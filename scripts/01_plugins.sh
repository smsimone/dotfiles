# shellcheck source=/dev/null

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

#SUBMODULES_SCRIPTS="$SCRIPT_DIR/../repos"
#[ ! -d "$SUBMODULES_SCRIPTS/zsh-defer" ] && git clone https://github.com/romkatv/zsh-defer.git "$SUBMODULES_SCRIPTS/zsh-defer"
#source "$SUBMODULES_SCRIPTS/zsh-defer/zsh-defer.plugin.zsh"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "$ZINIT_HOME" ] && mkdir -p "$(dirname "$ZINIT_HOME")"
[ ! -d "$ZINIT_HOME/.git" ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Completions
autoload -Uz compinit && compinit

######## PLUGINS
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit load romkatv/zsh-defer
zsh-defer zinit load zsh-users/zsh-autosuggestions
zsh-defer zinit load zdharma-continuum/fast-syntax-highlighting
zsh-defer zinit load Aloxaf/fzf-tab
zsh-defer zinit load zpm-zsh/tmux
######## PLUGINS

eval "$(starship init zsh)"
if command -v fzf &> /dev/null; then eval "$(fzf --zsh)"; fi
if command -v zoxide &> /dev/null; then eval "$(zoxide init zsh)"; fi
