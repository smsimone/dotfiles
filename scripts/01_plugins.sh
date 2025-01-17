# Initializes zinit

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Completions
autoload -Uz compinit && compinit

######## PLUGINS
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit load zsh-users/zsh-autosuggestions
zinit load zdharma-continuum/fast-syntax-highlighting
zinit load Aloxaf/fzf-tab
######## PLUGINS

eval "$(starship init zsh)"
if command -v fzf &> /dev/null; then eval "$(fzf --zsh)"; fi
if command -v zoxide &> /dev/null; then eval "$(zoxide init zsh)"; fi
