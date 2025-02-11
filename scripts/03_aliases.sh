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
	if ! command -v fzf &>/dev/null; then
		nvim .
		return "$?"
	fi

	appearance=$(defaults read -g AppleInterfaceStyle 2>&1 | tr -d '\n')
	if [[ "$appearance" == "Dark" ]]; then
		# catppuccin mocha
		export FZF_DEFAULT_OPTS=" \
		--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
		--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
		--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
		--color=selected-bg:#45475a \
		--multi"
	else
		# catppuccin latte
		export FZF_DEFAULT_OPTS=" \
	--color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
	--color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
	--color=marker:#7287fd,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39 \
	--color=selected-bg:#bcc0cc \
	--multi"
	fi

	file=$(
		fzf --style full --preview "fzf-preview.sh {}" \
			--border --padding 1,2 \
			--border-label ' Neovim pick ' --input-label ' Input ' \
			--bind 'focus:transform-preview-label:[[ -n {} ]] && printf " Previewing [%s] " {}' \
			--bind 'focus:+transform-header:file --brief {} || echo "No file selected"' \
			--bind 'result:transform-list-label:if [[ -z $FZF_QUERY ]]; then echo " $FZF_MATCH_COUNT items "; else echo " $FZF_MATCH_COUNT matches for [$FZF_QUERY] "; fi'
	)
	[ -n "$file" ] && nvim "$file"
}

if ! command -v fd &>/dev/null; then brew install fd; fi
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
