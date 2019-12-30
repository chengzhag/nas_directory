#第一步：以 sudo 运行该脚本
#第二步：各用户编辑 .bashrc，注释或删除其中的“alias sudo='sudo env PATH=$PATH'”

#修改用户组 sudoer 权限
#https://segmentfault.com/a/1190000007394449
touch /etc/sudoers.d/members
echo "Cmnd_Alias APT_CMD=/usr/bin/apt,/usr/bin/apt-get,!/usr/bin/apt remove,!/usr/bin/apt autoremove,!/usr/bin/apt-get remove,!/usr/bin/apt-get purge,!/usr/bin/apt-get autoremove" >> /etc/sudoers.d/members
echo "%members ALL=APT_CMD" >> /etc/sudoers.d/members
