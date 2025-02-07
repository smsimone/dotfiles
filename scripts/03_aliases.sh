# shellcheck source=/dev/null

if ! command -v eza &>/dev/null; then brew install eza; fi
if ! command -v lazygit &>/dev/null; then brew install lazygit; fi
if ! command -v zoxide &>/dev/null; then # better cd (zoxide)
	brew install zoxide
	brew install fzf
fi
if ! command -v bat &>/dev/null; then brew install bat; fi

eval "$(zoxide init zsh)"
alias ..='cd ..'
alias l='ls -lha'
alias ls='eza'
alias lg='lazygit'
alias cd='z'
alias cat='bat'
alias upgrade='brew update && brew upgrade && brew cleanup'
alias zi='__zoxide_zi'

unset nnvim
nnvim() {
	nvim "$(fzf --preview "cat {}")"
}

if ! command -v fd &>/dev/null; then brew install fd; fi
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
