#!/bin/bash

#Author:Yenn
#Runtime:Aliyun ECS CentOS 7.0 64Bit
#Description:Auto install tmux

checkResult()
{
    if test $? -ne 0
    then
        echo "Error!!!!"
        exit -1
    fi
}

#tmux depends on libevent 2.x.
wget https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz
checkResult
tar -zxvf libevent-2.0.22-stable.tar.gz
checkResult
cd libevent-2.0.22-stable
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