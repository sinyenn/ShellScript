#!/bin/bash

# Author:Yenn
# Email:sinyenn@gmail.com
# Runtime:Aliyun ECS CentOS 7.0 64Bit
# Description:Auto install tmux
# Reference
# https://github.com/tmux/tmux

checkResult()
{
    if test $? -ne 0
    then
        echo "Error!!!!"
        exit -1
    fi
}

#depends
yum install gcc git automake -y
checkResult

#tmux depends on libevent 2.x.
wget https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz
checkResult
tar -zxvf libevent-2.1.8-stable.tar.gz
checkResult
rm -rf libevent-2.1.8-stable.tar.gz
checkResult
cd libevent-2.1.8-stable
checkResult
./configure && make
checkResult
sudo make install
checkResult
cd ..

#CentOS 7.0 64bit Copy lib to lib64
if test $(arch)="x86_64"
then
    cp -R /usr/local/lib/libevent* /usr/lib64/
fi

#tmux depend curses
yum install ncurses-devel -y
checkResult

#tmux
git clone https://github.com/tmux/tmux.git
checkResult
cd tmux
checkResult
sh autogen.sh
checkResult
./configure && make
checkResult
echo -e "\n# tmux path" >> /etc/profile
echo "export PATH=$(pwd):\$PATH" >> /etc/profile
checkResult
. /etc/profile
echo "$(tmux -V) installed"