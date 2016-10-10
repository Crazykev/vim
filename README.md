# Powerful vim Config files

Works totally fine with me, based on great work of [ma6174](https://github.com/ma6174/vim). 
Mainly remove some js plugin, add some golang plugin.

[![Build Status](https://travis-ci.org/crazykev/vim.png?branch=master)](https://travis-ci.org/crazykev/vim)

### How does this looks like

![screenshot.png](screenshot.png)

### Easy install:

Open a terminal, run the following command:

`wget -qO- https://raw.github.com/Crazykev/vim/master/setup.sh | bash -x`

### Manually(in ubuntu)

- install **vim**: `sudo apt-get install vim`
- install **ctags**: `sudo apt-get install ctags`
- install some tools: `sudo apt-get install xclip vim-gnome astyle python-setuptools`
- configure golang environment:
    ```
    wget https://storage.googleapis.com/golang/go1.6.3.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.6.3.linux-amd64.tar.gz
    cat >>~/.bashrc <<EOF
#export environment for golang
export GOPATH=\$HOME/go-project
export PATH=\$PATH:/usr/local/go/bin:\$GOPATH/bin/
EOF
    ```

- python code formatter tool: `sudo easy_install -ZU autopep8`
- `sudo ln -s /usr/bin/ctags /usr/local/bin/ctags`
- clone vim config files: `cd ~/ && git clone git://github.com/Crazykev/vim.git`
- `mv ~/vim ~/.vim`
- `mv ~/.vim/.vimrc ~/`
- clone bundle programs: `git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle`
- open vim and exec bundle cmd: `:BundleInstall`
- open vim and install **vim-go** dependencies: `:GoInstallBinaries`  *tips: User from China may need to use some tools like shadowsocks to connect to golang/google lib*
- reopen vim and have fun with your new **Vim** :)

### More tips:

[tips.md](tips.md)

### Update log:

[`update_log.md`](update_log.md)

