#用于用户的初始化设置
#新建用户时拷贝到用户的家目录下

init_file="/media/Public/documents/server/.inituser"
init_file_cp=/home/${USER}/.inituser
if [ ! -f "${init_file_cp}" ]; then
echo "调用 ${init_file} 初始化用户..."
bash "${init_file}" && cp "${init_file}" "${init_file_cp}"
else
SHELL=/bin/bash exec /bin/bash
fi
