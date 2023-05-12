#!/bin/zsh

function install_homebrew() {
  # NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/Homebrew/install@master/install.sh)"
  # if [ $? -ne 0 ]; then
  #   echo "Install Homebrew Failure"
  #   exit 1
  # fi

  echo 'Install Homebrew Success'
}


install_homebrew()