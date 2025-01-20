#/usr/bin/env bash 

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

export STARSHIP_CONFIG=~/.config/starship.toml
export STARSHIP_CONFIG="$SCRIPT_DIR/configs/starship.toml"

scripts=($(find "$SCRIPT_DIR/scripts" -name '*.sh' | sort))
for script in "${scripts[@]}"; do
	if [ -f "$script" ]; then
		source "$script" || echo "Failed to source $script"
	fi
done

if [[ "$ENABLE_TMUX" == "1" ]];then
	if [ "$TERM_PROGRAM" != "vscode" ]; then
		if command -v tmux &>/dev/null; then 
			if [ "$TMUX" = "" ]; then tmux a || tmux; fi
		fi
	fi
fi
