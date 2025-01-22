#!/usr/bin/env bash
# shellcheck source=/dev/null

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

export STARSHIP_CONFIG=~/.config/starship.toml
export STARSHIP_CONFIG="$SCRIPT_DIR/configs/starship.toml"

if [[ "$ENABLE_TMUX" == "1" ]]; then
	if [[ "$TERM_PROGRAM" == "vscode" ]]; then
		export TMUX_AUTOSTART=false
		#if command -v tmux &>/dev/null; then
		#	if [ "$TMUX" = "" ]; then tmux a || tmux; fi
		#fi
	fi
fi

#scripts=($(find "$SCRIPT_DIR/scripts" -name '*.sh' | sort))
#for script in "${scripts[@]}"; do
#	if [ -f "$script" ]; then
#		source "$script" || echo "Failed to source $script"
#	fi
#done

find "$SCRIPT_DIR/scripts" -name '*.sh' | sort | while read -r script; do
	if [ -f "$script" ]; then
		source "$script" || echo "Failed to source $script"
	fi
done
