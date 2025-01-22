#!/usr/bin/env bash
# shellcheck source=/dev/null

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

export STARSHIP_CONFIG="$HOME/.config/starship.toml"
export STARSHIP_CONFIG="$SCRIPT_DIR/configs/starship.toml"

if [[ "$ENABLE_TMUX" == "1" ]]; then
	if [[ "$TERM_PROGRAM" == "vscode" ]]; then
		# Avoid using tmux in vscode
		export TMUX_AUTOSTART=false
	fi
fi

find "$SCRIPT_DIR/scripts" -name '*.sh' | sort | while read -r script; do
	if [ -f "$script" ]; then
		source "$script" || echo "Failed to source $script"
	fi
done
