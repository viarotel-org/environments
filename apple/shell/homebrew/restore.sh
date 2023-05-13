#!/bin/zsh

echo "Restore Brewfile"
echo "Script by viarotel v0.0.1"

# set -e

function restore_remote_brewfile() {
  local remote_script_url=$1
  local download_brewfile_path=$(mktemp)

  echo "正在加载 $remote_script_url 脚本并执行"

  # 下载远程脚本到临时文件
  curl -fsSL "$remote_script_url" -o "$download_brewfile_path"

  brew bundle --file="$download_brewfile_path"
  
  # 删除临时文件
  rm "$download_brewfile_path"
}

function restore_brewfile() {
  local brewfile_path=$1
  echo "即将恢复 Brewfile 备份的包, 是否继续？(y/n):"
  read -rk is_continue
  if [[ "$is_continue" == "y" || "$is_continue" == "Y" ]]; then
    echo "请输入 Brewfile 的路径或 URL(为空时将采用默认路径):"
    read -rk custom_brewfile_path
    if [[ -n "$custom_brewfile_path" ]]; then
      brew bundle --file="$custom_brewfile_path"
    else
      restore_remote_brewfile $brewfile_path
    fi
    echo "Brewfile 恢复成功"
  else
    echo "已跳过 Brewfile 备份恢复"
  fi 
}

restore_brewfile "https://gitee.com/viarotel/environments/raw/gitee/apple/configs/Brewfile"

if [[ "$ZSH_EVAL_CONTEXT" == "toplevel" ]]; then
  exit 0
fi