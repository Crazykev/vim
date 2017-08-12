#!/bin/bash

GOLANG_VERSION=${GOLANG_VERSION:-1.8.1}

vim::common::os(){
    PLATFORM=`uname`
    case $PLATFORM in
      Linux)
        if [ -e /etc/centos-release ]; then
          OS=centos
        elif [ -e /etc/os-release ]; then
          if [ grep 'NAME="Ubuntu"' /etc/os-release ]; then
            OS=ubuntu
          fi 
        fi ;;
      Darwin)
        OS=darwin ;;
    esac
    if [ OS == "" ]; then
      echo "Only Ubuntu/Centos/MacOS is supported"
      exit 1
    else
      echo "Detacted OS $OS"
    fi
}

vim::ubuntu::package(){
    sudo apt-get install -y wget vim vim-gnome ctags xclip astyle python-setuptools python-dev git
}
    
vim::centos::package(){
    sudo yum install -y wget gcc vim git ctags xclip astyle python-setuptools python-devel	
}

##Add HomeBrew support on  Mac OS
vim::darwin::package(){
    if ! which brew >/dev/null;then
        echo "Install HomeBrew tool first"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    brew install vim ctags git astyle wget
}

vim::linux::golang(){
    if which go > /dev/null; then
      echo "Retain original golang Environment"
      echo `go version`
      return
    fi
    echo "Configuring golang environment, version ${GOLANG_VERSION}..."
    GOLANG_TAR=${GOLANG_TAR:-go${GOLANG_VERSION}.linux-amd64.tar.gz}
    cd /tmp/
    wget https://storage.googleapis.com/golang/${GOLANG_TAR}
    sudo tar -C /usr/local -xzf ${GOLANG_TAR}
    cat >>~/.bashrc <<EOF
#export environment for golang
export GOPATH=\$HOME/go-project
export PATH=\$PATH:/usr/local/go/bin:\$GOPATH/bin/
EOF
    source ~/.bashrc
}

vim::darwin::golang(){
    if which go > /dev/null; then
      echo "Retain original golang Environment"
      echo `go version`
      return
    fi
    echo "Configuring golang environment, version ${GOLANG_VERSION}..."
    GOLANG_TAR=${GOLANG_TAR:-go${GOLANG_VERSION}.darwin-amd64.pkg}
    TARGET_DEVICE=`mount | grep " / " | cut -d ' ' -f 1`
    cd /tmp/
    wget https://storage.googleapis.com/golang/${GOLANG_TAR}
    sudo installer -package $GOLANG_TAR -target $TARGET_DEVICE
    cat >>~/.bash_profile <<EOF
#export environment for golang
export GOPATH=\$HOME/go-project
export PATH=\$PATH:/usr/local/go/bin:\$GOPATH/bin/
EOF
    source ~/.bash_profile
}

vim::common::setup(){
  export GOPATH=${GOPATH:-$HOME/go-project}
  mkdir -p ${GOPATH}
  sudo easy_install -ZU autopep8 
  if [ ! -e /usr/local/bin/ctags ]; then
    sudo ln -s /usr/bin/ctags /usr/local/bin/ctags
  fi
  mv -f ~/vim ~/vim_old
  cd ~/ && git clone https://github.com/Crazykev/vim.git
  mv -f ~/.vim ~/.vim_old
  mv -f ~/vim ~/.vim
  mv -f ~/.vimrc ~/.vimrc_old
  mv -f ~/.vim/.vimrc ~/
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  echo "Installing bundle ..." > crazykev
  echo "Installing golang tools dependency binaries" >> crazykev
  echo "Will exit when install finished" >> crazykev
  echo "Please be patient" >> crazykev
  vim crazykev -c "BundleInstall" -c "GoInstallBinaries" -c "q" -c "q"
  rm crazykev
}

main(){
  vim::common::os

  case $OS in
    ubuntu)
      vim::ubuntu::package
      vim::linux::golang

    ;;
    centos)
      vim::centos::package
      vim::linux::golang

    ;;
    darwin)
      vim::darwin::package
      vim::darwin::golang

    ;;
  esac

  vim::common::setup
  echo "Install finished"
}

main $@
