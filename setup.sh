#!/bin/bash
echo "安装将花费一定时间，请耐心等待直到安装完成^_^"
if which apt-get >/dev/null; then
	sudo apt-get install -y wget vim vim-gnome ctags xclip astyle python-setuptools python-dev git
elif which yum >/dev/null; then
	sudo yum install -y wget gcc vim git ctags xclip astyle python-setuptools python-devel	
fi

##Add HomeBrew support on  Mac OS
if which brew >/dev/null;then
    echo "You are using HomeBrew tool"
    brew install vim ctags git astyle
fi

echo "Configuring golang environment, version 1.6.3..."
if which go > /dev/null; then
    echo "Retain original golang Environment"
    echo `go version`
else
    wget https://storage.googleapis.com/golang/go1.6.3.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.6.3.linux-amd64.tar.gz
    cat >>~/.bashrc <<EOF
    export GOPATH=\$GOPATH:\$HOME/go-project
    export PATH=\$PATH:/usr/local/go/bin:\$GOPATH/bin/
EOF
fi

sudo easy_install -ZU autopep8 
sudo ln -s /usr/bin/ctags /usr/local/bin/ctags
mv -f ~/vim ~/vim_old
cd ~/ && git clone https://github.com/ma6174/vim.git
mv -f ~/.vim ~/.vim_old
mv -f ~/vim ~/.vim
mv -f ~/.vimrc ~/.vimrc_old
mv -f ~/.vim/.vimrc ~/
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
echo "ma6174正在努力为您安装bundle程序" > ma6174
echo "安装完毕将自动退出" >> ma6174
echo "请耐心等待" >> ma6174
vim ma6174 -c "BundleInstall" -c "q" -c "q"
rm ma6174
echo "安装完成"

