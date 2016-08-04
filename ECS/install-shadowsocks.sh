#!/bin/bash

# Author:Yenn
# Email:sinyenn@gmail.com
# Runtime:Aliyun ECS CentOS 7.0 64Bit
# Description:Auto install shadowsocks
# Reference
# https://pip.pypa.io/en/latest/installing/
# https://github.com/shadowsocks/shadowsocks/tree/master

checkResult()
{
    if test $? -ne 0
    then
        echo "Error!!!!"
        exit -1
    fi
}

# install pip
wget https://bootstrap.pypa.io/get-pip.py
checkResult
python get-pip.py
checkResult
# install shadowsocks
pip install shadowsocks
checkResult
echo "$(ssserver --version) installed"