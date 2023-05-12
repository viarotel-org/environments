#!/bin/zsh

echo "Init MacOS"
echo "Script by viarotel v0.0.1"

set -e

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

import_remote_script 'https://cdn.jsdelivr.net/gh/viarotel/environments@main/apple/shell/macos/init.sh'

exit 0