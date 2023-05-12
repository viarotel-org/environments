#!/bin/zsh

echo "Init MacOS"
echo "Script by viarotel v0.0.1"

# 导入远程脚本
function import_remote_script() {
  local remote_script_url=$1
  local temp_file=$(mktemp)

  # 下载远程脚本到临时文件
  curl -fsSL "$remote_script_url" -o "$temp_file"

  # 导入脚本到当前环境
  source "$temp_file"

  # 删除临时文件
  rm "$temp_file"
}

# 允许所有应用来源
sudo spctl --master-disable

import_remote_script 'https://cdn.jsdelivr.net/gh/viarotel/scripts@main/shell/homebrew/main.sh'