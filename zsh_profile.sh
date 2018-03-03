DIR=${0:a:h}

# common
source "$DIR/shell/common_platform.sh"
source "$DIR/shell/common_config.sh"
source "$DIR/shell/common_colors.sh"
source "$DIR/shell/common_aliases.sh"

# zsh-specific
source "$DIR/shell/zsh_config.sh"
source "$DIR/shell/zsh_completion.sh"

# oh my zsh
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
