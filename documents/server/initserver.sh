#!/bin/bash
set -v
set -e

# 设置源
mv /etc/apt/sources.list /etc/apt/sources.list_backup
touch /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse" > /etc/apt/sources.list
apt update
apt upgrade


# #安装并固定内核
# apt install linux-modules-4.15.0-107-generic
# apt-mark hold linux-image-generic linux-headers-generic


#安装必备包
apt -y --force-yes install openssh-server exfat-utils ethtool net-tools gcc make screen git iperf3


# #删除已有的 swap 文件，设置新的 swap 文件，启动时挂载已设置
# #https://www.cnblogs.com/EasonJim/p/7487596.html
# swapoff /swapfile
# rm /swapfile
# fallocate -l 32G /swapfile
# chmod 600 /swapfile
# mkswap /swapfile
# swapon /swapfile
# echo "/swapfile none swap sw 0 0" >> /etc/fstab


#配置 NAS 挂载
#设置 nfs 缓存
#https://blog.frehi.be/2019/01/03/fs-cache-for-nfs-clients/
apt -y --force-yes install cachefilesd
mkdir -p /var/cache/fscache
echo "RUN=yes" >> /etc/default/cachefilesd
#https://linux.die.net/man/5/cachefilesd.conf
sed -i "s/10%/30%/g" /etc/cachefilesd.conf
sed -i "s/7%/25%/g" /etc/cachefilesd.conf
sed -i "s/3%/20%/g" /etc/cachefilesd.conf
systemctl start cachefilesd
#设置 tmpfiles.d 定期删除 /tmp 下的文件
touch /etc/tmpfiles.d/tmp.conf
echo "d /tmp/ - - - 1w" > /etc/tmpfiles.d/tmp.conf
systemctl start systemd-tmpfiles-clean
#安装 nfs 依赖库，设置自动挂载 Public、home 文件夹
#https://www.jianshu.com/p/bedce559a0be
#https://linux.die.net/man/5/autofs
apt -y --force-yes install nfs-common autofs
touch /etc/nfs-public.misc
touch /etc/nfs-home.misc
#https://blog.csdn.net/xinanrusu/article/details/70047422
#https://zhuanlan.zhihu.com/p/78249819
#http://notes.yuting.cc/home/nfsperformance
echo "Public -fstype=nfs,auto,nofail,noatime,nodiratime,intr,tcp,actimeo=120,_netdev,bg,rsize=262144,wsize=262144,fsc 192.168.1.119:/Public" > /etc/nfs-public.misc
echo "* -fstype=nfs,auto,nofail,noatime,nodiratime,intr,tcp,actimeo=120,_netdev,bg,rsize=262144,wsize=262144,fsc 192.168.1.119:/homes/&" > /etc/nfs-home.misc
echo "/media /etc/nfs-public.misc" >> /etc/auto.master
echo "/home /etc/nfs-home.misc" >> /etc/auto.master
systemctl start autofs
systemctl enable autofs
#设置内核参数
#https://blog.51cto.com/francis198/1847103
#https://blog.51cto.com/13673885/2124308
echo "net.core.wmem_default = 8388608" >> /etc/sysctl.conf
echo "net.core.rmem_default = 8388608" >> /etc/sysctl.conf
echo "net.core.rmem_max = 16777216" >> /etc/sysctl.conf
echo "net.core.wmem_max = 16777216" >> /etc/sysctl.conf
sysctl -p


#修改用户组 sudoer 权限
#https://segmentfault.com/a/1190000007394449
touch /etc/sudoers.d/members
echo "Cmnd_Alias ALLOW_APT_CMD=/usr/bin/apt,/usr/bin/apt-get,!/usr/bin/apt remove,!/usr/bin/apt autoremove,!/usr/bin/apt-get remove,!/usr/bin/apt-get purge,!/usr/bin/apt-get autoremove" > /etc/sudoers.d/members
echo "Cmnd_Alias ALLOW_MAKE_CMD=/usr/bin/make" >> /etc/sudoers.d/members
echo "%members ALL=ALLOW_APT_CMD,ALLOW_MAKE_CMD" >> /etc/sudoers.d/members


#安装 ldap 依赖库，配置 ldap 服务
#https://www.iteye.com/blog/wuyaweiwude-1889452
LDAP_SERVER_IP=192.168.1.119
BASE_DN='dc=kc110lsc,dc=local'
ROOT_DN='cn=admin,dc=kc110lsc,dc=local'
#创建preseed文件-软件安装自应答  
touch debconf-ldap-preseed.txt
echo "ldap-auth-config    ldap-auth-config/move-to-debconf     boolean    true
ldap-auth-config    ldap-auth-config/ldapns/ldap-server    string    ldap://$LDAP_SERVER_IP
ldap-auth-config    ldap-auth-config/ldapns/base-dn    string    $BASE_DN
ldap-auth-config    ldap-auth-config/ldapns/ldap_version    select    3
ldap-auth-config    ldap-auth-config/dbrootlogin    boolean    true
ldap-auth-config    ldap-auth-config/dblogin    boolean    false
ldap-auth-config    ldap-auth-config/rootbinddn     string    $ROOT_DN
ldap-auth-config    ldap-auth-config/rootbindpw     password
ldap-auth-config    ldap-auth-config/override    boolean    true
ldap-auth-config    ldap-auth-config/pam_password     select    exop
nslcd   nslcd/ldap-uris string  ldap://$LDAP_SERVER_IP
nslcd   nslcd/ldap-base string  $BASE_DN" >> debconf-ldap-preseed.txt  
cat debconf-ldap-preseed.txt | debconf-set-selections
rm debconf-ldap-preseed.txt
#安装ldap client相关软件
# apt -y --force-yes install libldap-2.4-2=2.4.45+dfsg-1ubuntu1
apt -y --force-yes install ldap-utils libpam-ldap libnss-ldap nslcd
#认证方式中添加ldap  
auth-client-config -t nss -p lac_ldap
#认证登录后自动创建用户家目录  
echo "session required pam_mkhomedir.so skel=/etc/skel umask=0022" >> /etc/pam.d/common-session  
#自启动服务  
update-rc.d nslcd enable  
#可以在Host上通过passwd更改用户密码  
cp /etc/pam.d/common-password /etc/pam.d/common-password.bak  
sed -i 's/use_authtok//' /etc/pam.d/common-password  
#使配置生效  
/etc/init.d/nscd restart  
#在交互界面中重新配置 LDAP root 密码
dpkg-reconfigure ldap-auth-config


# #安装威联通 USB 网卡 QNA-UC5G1T 驱动
# #https://www.qnap.com/en/product/qna-uc5g1t
# cd /media/Public/documents/server/app/AQ_USBDongle_LinuxDriver_1.3.3.0/fiji/Linux
# make clean
# make
# #https://gadgetrip.jp/2019/09/review_qnap_qna_uc5g1t/
# make install
# #从内核中删除系统自带的 cdc_ether 模块，并将其加入黑名单
# #https://gadgetrip.jp/2019/09/review_qnap_qna_uc5g1t/
# rmmod cdc_ether
# #http://einverne.github.io/post/2018/09/modprobe.html
# touch /etc/modprobe.d/blacklist-usbnet.conf
# echo "blacklist cdc_ether" > /etc/modprobe.d/blacklist-usbnet.conf
# cd ~


# #安装 netdata
# apt -y --force-yes install curl
# curl -s https://packagecloud.io/install/repositories/netdata/netdata/script.deb.sh | sudo bash
# apt -y --force-yes install netdata
# #配置显卡监控
# touch /etc/netdata/python.d.conf
# echo "nvidia_smi: yes" >> /etc/netdata/python.d.conf
# echo "" >> /etc/netdata/netdata.conf
# echo "[plugins]" >> /etc/netdata/netdata.conf
# echo "    python.d = yes" >> /etc/netdata/netdata.conf
# service netdata restart
# systemctl enable netdata
# #claim：登录到 https://app.netdata.cloud/spaces/kc110lsc/rooms/gpu 查看 claim 命令
