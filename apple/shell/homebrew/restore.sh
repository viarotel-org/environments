#!/bin/zsh

echo "Restore Brewfile"
echo "Script by viarotel v0.0.1"

set -e

function restore_brewfile() {
  local brewfile_path=$1
  echo $'即将恢复 Brewfile 备份的包, 是否继续？(y/n): \n'
  read -r is_continue
  if [[ "$is_continue" == "y" || "$is_continue" == "Y" ]]; then
    echo $'请输入 Brewfile 的路径或 URL(为空时将采用默认路径): \n'
    read -r custom_brewfile_path
    if [[ -n "$custom_brewfile_path" ]]; then
      brew bundle --file="$custom_brewfile_path"
    else
      brew bundle --file="$brewfile_path"
    fi
    echo $'Brewfile 恢复成功\n'
  else
    echo $'已跳过 Brewfile 备份恢复\n'
  fi 
}

restore_brewfile "https://cdn.jsdelivr.net/gh/viarotel-org/environments@main/shell/macos/configs/Brewfile"

echo "$0"
# if [[ "$0" =~ "install" ]]; then
#   exit 0
# fi