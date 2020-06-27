# 显卡服务器管理员说明


## 账号
root 和 admin 账号与 NAS 的 admin 账号共用密码。


## 重装
1. 重装 ubuntu 16 系统
    * 系统语言设为英语
    * 初始用户设为 manager
    * 主机命名为 LSC-GPU{02d}（如 LSC-GPU01）
1. 将脚本 initserver.sh 复制到服务器并以 root 账户运行 ```bash initserver.sh```，运行结束后自动打开交互式界面（dpkg-reconfigure ldap-auth-config），手动设置以下参数（其他参数已通过脚本设置，按回车键跳过）：
    1. Does the LDAP database require login?： no
    1. LDAP root account password: 输入 NAS 上设置的 LDAP root 账户密码
    1. Local crypt to use when changing passwords: md5
1. 用 ```sudo teamviewer --passwd ***``` 设置 teamviewer 密码，用 ```sudo teamviewer --info print id ``` 查看 teamviewer ID
1. 设置网络参数（也可通过 GUI 设置）
    1. 用 ifconfig 查询网卡的接口名称（如 enx245ebe4300d7）
    1. 编辑 /etc/network/interfaces，添加：
        ```
        auto {接口名称}
        iface {接口名称} inet static
        address 192.168.1.{自定义的 IP}
        netmask 255.255.255.0
        gateway 192.168.1.{路由器 IP}
        dns-nameserver 192.168.1.{路由器 IP}
        mtu 9000
        ```
    1. 重启网络：```sudo /etc/init.d/networking restart```
    1. 在 NAS 管理页面设置 NFS 挂载权限（[NAS 管理员说明](../nas/README_admin.md)）
1. 安装显卡驱动、cuda、cudnn
    1. Nividia 驱动安装（升级一样）
        ```
        sudo add-apt-repository ppa:graphics-drivers/ppa
        sudo apt update
        ubuntu-drivers devices
        sudo apt install nvidia-driver-*** # 安装指定驱动(这里挑选自己需要的驱动,然后安装即可,不必卸载之前装过的驱动，注意Ubuntu 16最高支持418
        sudo reboot # 重启
        ```
    2. cuda安装

        到 [CUDA Toolkit Download](https://developer.nvidia.com/cuda-downloads) 下载所需版本 .run文件，以 cuda_9.0.176_384.81_linux.run为例
        ```
        sudo chmod +x cuda_9.0.176_384.81_linux.run
        ./cuda_9.0.176_384.81_linux.run

        Do you accept the previously read EULA?
        accept/decline/quit: accept

        Install NVIDIA Accelerated Graphics Driver for Linux-x86_64 384.81?
        (y)es/(n)o/(q)uit: n # 如果在这之前已经安装好更高版本的显卡驱动就不需要再重复安装，如果需要重复安装就选择 yes,此外还需要关闭图形界面。

        Install the CUDA 9.0 Toolkit?
        (y)es/(n)o/(q)uit: y

        Enter Toolkit Location
        [ default is /usr/local/cuda-9.0 ]: # 一般选择默认即可，也可以选择安装在其他目录，在需要用的时候指向该目录或者使用软连接 link 到 /usr/local/cuda。

        /usr/local/cuda-9.0 is not writable.
        Do you wish to run the installation with 'sudo'?
        (y)es/(n)o: y

        Please enter your password: 
        Do you want to install a symbolic link at /usr/local/cuda? # 是否将安装目录通过软连接的方式 link 到 /usr/local/cuda，yes or no 都可以，取决于你是否使用 /usr/local/cuda 为默认的 cuda 目录。
        (y)es/(n)o/(q)uit: n

        Install the CUDA 9.0 Samples?
        (y)es/(n)o/(q)uit: n

        sudo ln -s /usr/local/cuda-9.0/ /usr/local/cuda/

        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64
        export PATH=$PATH:/usr/local/cuda/bin
        export CUDA_HOME=$CUDA_HOME:/usr/local/cuda
        source ~/.bashrc

        nvcc --version
        ```  
    3. 对应cudnn安装
        
        对应cuda下载cudnn的安装文件：https://developer.nvidia.com/rdp/cudnn-archive
        ```
        # 解压下载的文件，可以看到cuda文件夹
        sudo cp cuda/include/cudnn.h /usr/local/cuda/include/

        sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64/

        sudo chmod a+r /usr/local/cuda/include/cudnn.h

        sudo chmod a+r /usr/local/cuda/lib64/libcudnn*
        ```
    4. cuda版本切换
        ```
        # 在切换cuda版本时
        rm -rf /usr/local/cuda # 删除之前创建的软链接
        sudo ln -s /usr/local/cuda-*/ /usr/local/cuda/
        nvcc --version #查看当前 cuda 版本
        ```


## 脚本

* 显卡服务器安装脚本：initserver.sh, 重装系统后以 root 账户运行，具体功能参考注释
* 用户初始化脚本：.profile, 复制到每个用户 home 文件夹，用户每次登陆运行
* 用户初始化脚本：.inituser, 由 .profile 自动复制到各用户 home 文件夹，第一次登陆运行
