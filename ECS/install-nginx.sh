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
./configure --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module
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
nginx -V
