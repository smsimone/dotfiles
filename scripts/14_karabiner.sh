SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
TARGET_CONFIG_DIR="$HOME/.config/karabiner"
SOURCE_CONFIG_DIR="$SCRIPT_DIR/../configs/karabiner"

if [ ! -f "$TARGET_CONFIG_DIR" ]; then
	ln -s "$SOURCE_CONFIG_DIR" "$TARGET_CONFIG_DIR"
fi
