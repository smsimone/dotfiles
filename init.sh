SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

export STARSHIP_CONFIG=~/.config/starship.toml
export STARSHIP_CONFIG="$SCRIPT_DIR/configs/starship.toml"

scripts=($(find "$SCRIPT_DIR/scripts" -name '*.sh' | sort))
for script in "${scripts[@]}"; do
	if [ -f "$script" ]; then
		source "$script"
	fi
done
