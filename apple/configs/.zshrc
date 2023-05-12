# 开启终端后默认执行的命令

# 别名配置
alias via_proxy="export all_proxy=127.0.0.1:7890"
alias via_proxy_set="export all_proxy=$@"
alias via_proxy_close="unset all_proxy"

# 环境变量配置

# 设置代理
export all_proxy="127.0.0.1:7890"

# 设置 homebrew 国内源
export HOMEBREW_INSTALL_FROM_API=1
export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_PIP_INDEX_URL="https://pypi.tuna.tsinghua.edu.cn/simple"