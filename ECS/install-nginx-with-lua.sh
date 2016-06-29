#!/bin/bash

# Author:Yenn
# Email:sinyenn@gmail.com
# Runtime:Aliyun ECS CentOS 7.0 64Bit
# Description:Auto install nginx
# Reference
# https://www.nginx.com/resources/admin-guide/installing-nginx-open-source/

checkResult()
{
    if test $? -ne 0
    then
        echo "Error!!!!"
        exit -1
    fi
}

#install depends library
yum install gc gcc gcc-c++ pcre-devel zlib-devel openssl-devel -y
checkResult

#install luajit
wget http://luajit.org/download/LuaJIT-2.0.4.tar.gz
checkResult
tar -zxvf LuaJIT-2.0.4.tar.gz
checkResult
cd LuaJIT-2.0.4
checkResult
make && sudo make install
checkResult
echo -e "\n# LUAJIT Path" >> /etc/profile
echo "export LUAJIT_LIB=/usr/local/lib" >> /etc/profile
echo "export LUAJIT_INC=/usr/local/include/luajit-2.0" >> /etc/profile
checkResult
. /etc/profile
checkResult
cd ..
checkResult
rm -rf LuaJIT-2.0.4.tar.gz
checkResult


#download library
#ngx_devel_kit See -> https://github.com/simpl/ngx_devel_kit/tags
wget https://github.com/simpl/ngx_devel_kit/archive/v0.3.0.zip
checkResult
unzip v0.3.0.zip
checkResult
rm -rf v0.3.0.zip
checkResult
#lua-nginx-module See -> https://github.com/openresty/lua-nginx-module/tags
wget https://github.com/openresty/lua-nginx-module/archive/v0.10.5.zip
checkResult
unzip v0.10.5.zip
checkResult
rm -rf v0.10.5.zip
checkResult

#install nginx
wget http://nginx.org/download/nginx-1.11.1.tar.gz
checkResult
tar -zxvf nginx-1.11.1.tar.gz
checkResult
rm -rf nginx-1.11.1.tar.gz
checkResult
cd nginx-1.11.1
checkResult

#根据自己需求修改编译参数,See -> https://www.nginx.com/resources/admin-guide/installing-nginx-open-source/#configure
./configure --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --add-module=../ngx_devel_kit-0.3.0 --add-module=../lua-nginx-module-0.10.5
checkResult
make
checkResult
make install
checkResult
#add nginx to path
echo -e "\n# nginx path" >> /etc/profile
echo "export PATH=/usr/local/nginx/sbin:\$PATH" >> /etc/profile
checkResult
. /etc/profile
checkResult
echo "/usr/local/lib" > /etc/ld.so.conf.d/usr_local_lib.conf
checkResult
ldconfig
checkResult
nginx -V
