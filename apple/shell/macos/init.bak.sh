#!/bin/zsh

echo "Init MacOS"
echo "Script by viarotel v0.0.1"

set -e

host_name='viarotel-macbook'
proxy_address='127.0.0.1:7890'
clashx_download_address='https://github.com/yichengchen/clashX/releases/latest/download/ClashX.dmg'
homebrew_install_address='https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh'
brewfile_path='https://cdn.jsdelivr.net/gh/viarotel/viarotel.github.io@docs/scripts/shell/init-macos/Brewfile'

# 修改终端的 HostName
function set_hostname() {
  sudo scutil --set HostName "${1:-host_name}"
}

# 开启允许任何来源
function enable_any_source() {
  sudo spctl --master-disable
}

# 安装 Rosetta
function install_rosetta() {
  softwareupdate --install-rosetta
}

# 安装 clashX
function install_clashx() {
  # 从 GitHub 下载最新的 clashX 安装包
  curl -L -o clashX.dmg "$1"

  # 安装 clashX
  hdiutil mount clashX.dmg
  sudo cp -R "/Volumes/ClashX/ClashX.app" /Applications
  hdiutil unmount "/Volumes/ClashX"
}

# 配置 clashX
function configure_clashx() {
  echo $'请输入 ClashX 订阅地址: \n'
  read -r clashx_sub_url
  defaults write com.west2online.ClashX config '{
    "mixedPolicy": "Rule",
    "subUrl": "'$clashx_sub_url'",
    "openAtLogin": true,
    "systemProxyEnable": true
  }'
}

# 配置终端代理
function configure_zshrc() {
  echo "export all_proxy=$1" >> ~/.zshrc
  echo 'export HOMEBREW_BREW_GIT_REMOTE=https://mirrors.ustc.edu.cn/brew.git' >> ~/.zshrc
  echo 'export HOMEBREW_CORE_GIT_REMOTE=https://mirrors.ustc.edu.cn/homebrew-core.git' >> ~/.zshrc
  echo 'export HOMEBREW_CASK_GIT_REMOTE=https://mirrors.ustc.edu.cn/homebrew-cask.git' >> ~/.zshrc
  echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.zshrc
  source ~/.zshrc
}

# 配置 curl 代理
function configure_curlrc() {
  echo "proxy=$1" >> ~/.curlrc
}

# 安装 Homebrew
function install_homebrew() {
	curl -fsSL --progress-bar "$1" | bash
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  source ~/.zprofile
}

# 恢复 Brewfile 备份的软件包
function restore_brewfile() {
  echo $'即将恢复 Brewfile 备份的包, 是否要自定义 Brewfile 的路径或 URL？(y/n): \n'
  read -r custom_brewfile
  if [[ "$custom_brewfile" == "y" || "$custom_brewfile" == "Y" ]]; then
    echo $'请输入 Brewfile 的路径或 URL: \n'
    read -r custom_brewfile_path
    brew bundle --file="$custom_brewfile_path"
  else
    brew bundle --file="$brewfile_path"
  fi
}

# 执行配置步骤
function run_configuration() {
  sudo -v

  set_hostname $host_name
  enable_any_source
  install_rosetta
  install_clashx $clashx_download_address
  configure_clashx 
  configure_zshrc $proxy_address
  configure_curlrc $proxy_address
  install_homebrew $homebrew_install_address
  restore_brewfile
}

# 执行配置步骤
run_configuration

echo "配置完成！"

exit 0
