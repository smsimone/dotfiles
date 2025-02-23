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
alias upgrade='brew update && brew upgrade --greedy && brew cleanup'
alias zi='__zoxide_zi'

unset nnvim
nnvim() {
	if ! command -v tv &>/dev/null; then
		nvim .
		return "$?"
	fi

	file=$(tv)
	[ -n "$file" ] && nvim "$file"
}

if ! command -v fd &>/dev/null; then brew install fd; fi
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
