#用于用户的初始化设置
#新建用户时拷贝到用户的家目录下

init_file="/media/Public/documents/server/.inituser"
init_file_cp=/home/${USER}/.inituser
if [ ! -f "${init_file_cp}" ]; then
    echo "调用 ${init_file} 初始化用户..."
    bash "${init_file}" && cp "${init_file}" "${init_file_cp}"
else

    # ~/.profile: executed by the command interpreter for login shells.
    # This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
    # exists.
    # see /usr/share/doc/bash/examples/startup-files for examples.
    # the files are located in the bash-doc package.

    # the default umask is set in /etc/profile; for setting the umask
    # for ssh logins, install and configure the libpam-umask package.
    #umask 022

    # if running bash
    if [ -n "$BASH_VERSION" ]; then
        # include .bashrc if it exists
        if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
        fi
    fi

    # set PATH so it includes user's private bin directories
    PATH="$HOME/bin:$HOME/.local/bin:$PATH"

fi

# https://unix.stackexchange.com/questions/317652/running-program-in-profile-prevents-gui-startx
# 在此设置自己的 shell
export SHELL=/bin/bash
if test -t 0 -a -t 1
then
    exec $SHELL
fi

