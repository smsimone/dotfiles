SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
TARGET_CONFIG_FILE="$HOME/.config/wezterm/wezterm.lua"
SOURCE_CONFIG_FILE="$SCRIPT_DIR/../configs/wezterm/wezterm.lua"

if [ ! -f "$TARGET_CONFIG_FILE" ]; then
	mkdir -p "$(dirname "$TARGET_CONFIG_FILE")"
	ln -s "$SOURCE_CONFIG_FILE" "$TARGET_CONFIG_FILE"
fi
