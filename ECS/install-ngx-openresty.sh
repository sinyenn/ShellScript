#!/bin/bash

# Author:Yenn
# Email:sinyenn@gmail.com
# Runtime:Aliyun ECS CentOS 7.0 64Bit
# Description:Auto install nginx
# Reference
# https://openresty.org/cn/download.html

checkResult()
{
    if test $? -ne 0
    then
        echo "Error!!!!"
        exit -1
    fi
}

#install depends library
yum install gc gcc gcc-c++ pcre-devel zlib-devel openssl-devel readline-devel -y
checkResult

#install ngx-openresty
wget https://openresty.org/download/openresty-1.9.15.1.tar.gz
checkResult
tar -zxvf openresty-1.9.15.1.tar.gz
checkResult
rm -rf openresty-1.9.15.1.tar.gz
checkResult
cd openresty-1.9.15.1
checkResult

#根据自己需求修改编译参数,See -> https://openresty.org/cn/components.html
./configure --prefix=/usr/local/openresty --with-stream --with-http_realip_module --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-luajit --with-http_iconv_module
checkResult
make
checkResult
make install
checkResult
#add ngx-openresty to path
echo -e "\n# ngx-openresty path" >> /etc/profile
echo "export PATH=/usr/local/openresty/nginx/sbin:\$PATH" >> /etc/profile
checkResult
. /etc/profile
nginx -V
cd ..
checkResult
rm -rf openresty-1.9.15.1