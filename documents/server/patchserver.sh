#准备：将该脚本复制到 U盘
#第一步：删除 /etc/fstab 中 NFS 的挂载设置
#第二步：umount /home 和 /media/Public
#第三步：运行该脚本
#第四步：插拔网卡
#第五步：在 GUI 设置网络 MTU 为 9000


#删除已有的 swap 文件，设置新的 swap 文件，启动时挂载已设置
#https://www.cnblogs.com/EasonJim/p/7487596.html
swapoff /swapfile
rm /swapfile
fallocate -l 32G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile


#从内核中删除系统自带的 cdc_ether 模块，并将其加入黑名单
#https://gadgetrip.jp/2019/09/review_qnap_qna_uc5g1t/
rmmod cdc_ether
#http://einverne.github.io/post/2018/09/modprobe.html
touch /etc/modprobe.d/blacklist-usbnet.conf
echo "blacklist cdc_ether" >> /etc/modprobe.d/blacklist-usbnet.conf
cd ~


#配置 NAS 挂载
#设置 nfs 缓存
#https://blog.frehi.be/2019/01/03/fs-cache-for-nfs-clients/
apt -y --force-yes install cachefilesd
mkdir /var/cache/fscache
echo "RUN=yes" >> /etc/default/cachefilesd
systemctl start cachefilesd
#安装 nfs 依赖库，设置自动挂载 Public、home 文件夹
#https://www.jianshu.com/p/bedce559a0be
#https://linux.die.net/man/5/autofs
apt -y --force-yes install nfs-common autofs
echo "/media /etc/nfs-public.misc" >> /etc/auto.master
echo "/home /etc/nfs-home.misc" >> /etc/auto.master
touch /etc/nfs-public.misc
touch /etc/nfs-home.misc
#https://blog.csdn.net/xinanrusu/article/details/70047422
#https://zhuanlan.zhihu.com/p/78249819
#http://notes.yuting.cc/home/nfsperformance
echo "Public -fstype=nfs,auto,nofail,noatime,nodiratime,nolock,intr,tcp,actimeo=120,_netdev,bg,rsize=262144,wsize=262144,fsc 192.168.1.119:/Public" >> /etc/nfs-public.misc
echo "* -fstype=nfs,auto,nofail,noatime,nodiratime,nolock,intr,tcp,actimeo=120,_netdev,bg,rsize=262144,wsize=262144,fsc 192.168.1.119:/homes/&" >> /etc/nfs-home.misc
systemctl start autofs
systemctl enable autofs
#设置内核参数
#https://blog.51cto.com/francis198/1847103
#https://blog.51cto.com/13673885/2124308
echo "\n" >> /etc/sysctl.conf
echo "net.core.wmem_default = 8388608" >> /etc/sysctl.conf
echo "net.core.rmem_default = 8388608" >> /etc/sysctl.conf
echo "net.core.rmem_max = 16777216" >> /etc/sysctl.conf
echo "net.core.wmem_max = 16777216" >> /etc/sysctl.conf
sysctl -p


#修改 root 密码
passwd root
