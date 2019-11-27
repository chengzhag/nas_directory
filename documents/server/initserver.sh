apt update

#安装必备包
apt -y --force-yes install openssh-server exfat-utils ethtool net-tools gcc make screen


#安装 nfs 依赖库，挂载 Public、tmp 文件夹，设置开机自动挂载
apt -y --force-yes install nfs-common
mkdir /media/Public
mount 192.168.1.119:/Public /media/Public
echo "192.168.1.119:/Public /media/Public nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0"  >> /etc/fstab
mount 192.168.1.119:/homes /home
echo "192.168.1.119:/homes /home nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0"  >> /etc/fstab


#修改用户组 sudoer 权限
touch /etc/sudoers.d/members
echo "%members ALL=(ALL)ALL" >> /etc/sudoers.d/members


#安装 ldap 依赖库，配置 ldap 服务
#https://www.iteye.com/blog/wuyaweiwude-1889452
LDAP_SERVER_IP=192.168.1.119
BASE_DN='dc=kc110lsc,dc=local'
ROOT_DN='cn=admin,dc=kc110lsc,dc=local'

#创建preseed文件-软件安装自应答  
touch debconf-ldap-preseed.txt
echo "ldap-auth-config    ldap-auth-config/move-to-debconf     boolean    true" >> debconf-ldap-preseed.txt  
echo "ldap-auth-config    ldap-auth-config/ldapns/ldap-server    string    ldap://$LDAP_SERVER_IP" >> debconf-ldap-preseed.txt  
echo "ldap-auth-config    ldap-auth-config/ldapns/base-dn    string    $BASE_DN" >> debconf-ldap-preseed.txt  
echo "ldap-auth-config    ldap-auth-config/ldapns/ldap_version    select    3" >> debconf-ldap-preseed.txt  
echo "ldap-auth-config    ldap-auth-config/dbrootlogin    boolean    true" >> debconf-ldap-preseed.txt  
echo "ldap-auth-config    ldap-auth-config/dblogin    boolean    false" >> debconf-ldap-preseed.txt  
echo "ldap-auth-config    ldap-auth-config/rootbinddn     string    $ROOT_DN" >> debconf-ldap-preseed.txt  
echo "ldap-auth-config    ldap-auth-config/rootbindpw     password" >> debconf-ldap-preseed.txt  
echo "ldap-auth-config    ldap-auth-config/override    boolean    true" >> debconf-ldap-preseed.txt  
echo "ldap-auth-config    ldap-auth-config/pam_password     select    md5" >> debconf-ldap-preseed.txt  
echo "nslcd   nslcd/ldap-uris string  ldap://$LDAP_SERVER_IP" >> debconf-ldap-preseed.txt  
echo "nslcd   nslcd/ldap-base string  $BASE_DN" >> debconf-ldap-preseed.txt  
cat debconf-ldap-preseed.txt | debconf-set-selections
rm debconf-ldap-preseed.txt
/etc/ldap.secret
#安装ldap client相关软件  
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


#安装威联通 USB 网卡 QNA-UC5G1T 驱动
cd /media/Public/documents/server/app/AQ_USBDongle_LinuxDriver_1.3.3.0/fiji/Linux
make
cp aqc111.ko /lib/modules/$(uname -r)/kernel/drivers/net/usb/
depmod -a
cd ~
