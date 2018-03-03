DIR="${BASH_SOURCE%/*}"

# common
source "$DIR/shell/common_platform.sh"
source "$DIR/shell/common_config.sh"
source "$DIR/shell/common_colors.sh"
source "$DIR/shell/common_aliases.sh"

# bash-specific
source "$DIR/shell/bash_git.sh"
source "$DIR/shell/bash_prompt.sh"
source "$DIR/shell/bash_completion.sh"
