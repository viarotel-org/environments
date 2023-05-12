#!/bin/zsh

echo "Init MacOS"
echo "Script by viarotel v0.0.1"

# set -e

# 导入远程脚本
function import_remote_script() {
  local remote_script_url=$1
  local temp_file=$(mktemp)

  echo "正在加载 $remote_script_url 脚本并执行"
  echo $'\n'

  # 下载远程脚本到临时文件
  curl -fsSL "$remote_script_url" -o "$temp_file"

  # 导入脚本到当前环境
  source "$temp_file"

  # 删除临时文件
  rm "$temp_file"
}

# 设置终端主机名更
function set_hostname() {
  echo "即将更新终端主机名, 是否继续?(y/n):"
  read -r -u 0 custom_hostname
  if [[ "$custom_hostname" == "y" || "$custom_hostname" == "Y" ]]; then
    echo "请输入终端主机名"
    read -r -u 0 custom_hostname_path
    sudo scutil --set HostName "$custom_hostname_path"
  else
    echo "已跳过终端主机名更新"
  fi
}

# 安装 Rosetta
function install_rosetta() {
  echo "正在安装 Rosetta"
  softwareupdate --install-rosetta
  echo "安装 Rosetta 成功"
}

# 安装 xcode 命令行工具
function install_xcode_select() {
  echo "正在安装 xcode 命令行工具"
  xcode-select --install
  echo "安装 xcode 命令行工具成功"
}

# 更新权限
sudo -v
# 允许所有应用来源
sudo spctl --master-disable
# 设置终端主机名
set_hostname
# Rosetta
install_rosetta
# 安装 xcode 命令行工具
install_xcode_select
# 安装配置 homebrew
import_remote_script 'https://cdn.jsdelivr.net/gh/viarotel-org/environments@main/apple/shell/homebrew/main.sh'

if [[ "$ZSH_EVAL_CONTEXT" == "toplevel" ]]; then
  exit 0
fi