SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
TARGET_CONFIG_FILE="$HOME/.config/television/config.toml"
SOURCE_CONFIG_FILE="$SCRIPT_DIR/../configs/television/config.toml"

if [ ! -f "$TARGET_CONFIG_FILE" ]; then
	mkdir -p "$(dirname "$TARGET_CONFIG_FILE")"
	ln -s "$SOURCE_CONFIG_FILE" "$TARGET_CONFIG_FILE"
fi
