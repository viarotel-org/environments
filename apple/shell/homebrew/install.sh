#!/bin/zsh
echo "Install Homebrew"
echo "Script by viarotel v0.0.1"

# set -e

function install_homebrew() {
  echo "正在设置 homebrew 国内源"
  export HOMEBREW_INSTALL_FROM_API=1
  export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
  export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
  export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
  export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
  export HOMEBREW_PIP_INDEX_URL="https://pypi.tuna.tsinghua.edu.cn/simple"

  echo "正在自动安装 homebrew"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/Homebrew/install@master/install.sh)"
  if [ $? -ne 0 ]; then
    echo "Install Homebrew Failure"
    exit 1
  fi
  echo "初步安装 homebrew 成功"

  echo "正在启用 brew 命令"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  source ~/.zprofile
  echo "启用 brew 命令成功"

  if command -v brew &>/dev/null; then
    echo "正在切换常用 tap 为国内源"
    brew tap --custom-remote --force-auto-update homebrew/bundle https://gitee.com/Homebrew2/homebrew-bundle.git
    brew tap --custom-remote --force-auto-update homebrew/cask https://gitee.com/Homebrew2/homebrew-cask.git
    brew tap --custom-remote --force-auto-update homebrew/services https://gitee.com/Homebrew2/homebrew-services.git
    echo "切换 tap 为国内源成功"
    echo "Homebrew 安装成功"
  else
    echo "brew 命令未加载成功, 请检查"
  fi
}

install_homebrew

if [[ "$ZSH_EVAL_CONTEXT" == "toplevel" ]]; then
  exit 0
fi