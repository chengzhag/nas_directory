#以 sudo 运行该脚本

echo "Cmnd_Alias ALLOW_APT_CMD=/usr/bin/apt,/usr/bin/apt-get,!/usr/bin/apt remove,!/usr/bin/apt autoremove,!/usr/bin/apt-get remove,!/usr/bin/apt-get purge,!/usr/bin/apt-get autoremove" > /etc/sudoers.d/members
echo "Cmnd_Alias ALLOW_MAKE_CMD=/usr/bin/make" >> /etc/sudoers.d/members
echo "%members ALL=ALLOW_APT_CMD,ALLOW_MAKE_CMD" >> /etc/sudoers.d/members
