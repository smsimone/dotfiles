# shellcheck source=/dev/null

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

export STARSHIP_CONFIG="$HOME/.config/starship.toml"
export STARSHIP_CONFIG="$SCRIPT_DIR/configs/starship.toml"

#if [[ "$ENABLE_TMUX" == "0" ]] || [[ "$TERM_PROGRAM" == "vscode" ]] || [[ "$TERM_PROGRAM" == "ghostty" ]] || [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
#	# Avoid using tmux in vscode
#	export TMUX_AUTOSTART=false
#fi

export TMUX_AUTOSTART=false

find "$SCRIPT_DIR/scripts" -name '*.sh' | sort | while read -r script; do
	if [ -f "$script" ]; then
		#if command -v zsh-defer &>/dev/null; then
		#	zsh-defer source "$script" || echo "Failed to source $script"
		#else
		source "$script" || echo "Failed to source $script"
		#fi
	fi
done
