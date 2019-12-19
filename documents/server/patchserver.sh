#以 sudo 运行该脚本

#设置 tmpfiles.d 定期删除 /tmp 下的文件
touch /etc/tmpfiles.d/tmp.conf
echo "d /tmp/ - - - 1d" >> /etc/tmpfiles.d/tmp.conf
systemctl start systemd-tmpfiles-clean
