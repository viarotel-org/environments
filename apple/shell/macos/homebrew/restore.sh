#!/bin/zsh

# 恢复 Brewfile 备份的软件包
function restore_brewfile() {
  local brewfile_path=$1
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

# restore_brewfile "https://cdn.jsdelivr.net/gh/viarotel/scripts@main/shell/macos/configs/Brewfile"