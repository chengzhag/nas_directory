#以 sudo 运行该脚本

#https://linux.die.net/man/5/cachefilesd.conf
sed -i "s/10%/30%/g" /etc/cachefilesd.conf
sed -i "s/7%/25%/g" /etc/cachefilesd.conf
sed -i "s/3%/20%/g" /etc/cachefilesd.conf
systemctl restart cachefilesd
