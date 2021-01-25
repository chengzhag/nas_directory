# 服务器使用说明


## 新用户

初始化：用户在拿到账号和初始密码后，按以下步骤初始化
1. 在 [NAS 管理页面](https://192.168.1.119:5001/cgi-bin/) 登陆自己的账号，并修改初始密码（密码在 NAS 和各显卡服务器上是通用的，用户密码会在各服务器之间同步；仅能在 [NAS 管理页面](https://192.168.1.119:5001/cgi-bin/) 更改，不能在显卡服务器上通过 passwd 命令更改，否则会导致 SMB 挂载认证出错）
1. 打开管理页面的文件管理器 File Station，将 NAS:/Public/documents/server/.profile 复制到 NAS:/home（如果没有显示该文件，在文件管理器的设置中勾选“显示NAS的隐藏文件”）
1. 用 ssh 登陆显卡服务器，自动进入 anaconda 安装程序


## 问题
- git clone 到 CPU:/home/{user} 报错“premature end of pack file”：由于 NFS 挂载的原因，目前还没有找到解决办法。可以暂时用 SMB 挂载到个人电脑进行 git clone


## 管理员

* [显卡服务器管理员说明](README_admin.md)

## Remote Desktop

1. 可以下载 [ThinLinc 客户端 ](https://www.cendio.com/thinlinc/what-is-thinlinc)连接远程桌面，用起来和 Team Viewer 差不多，但是不同用户有独立桌面
2. 使用姿势：
   - 客户端输入服务器IP，账号，密码就能登录，桌面环境选择**xfce**（ubuntu桌面可能因为配置问题会闪退）
   - 退出操作：1）直接叉掉窗口，会在后台继续运行；2）右上角可以log out，退出登录，停止运行
3. Note：免费版一台服务器限制登录5个账号，登录不上换一个试试