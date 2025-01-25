# shellcheck source=/dev/null

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
SOURCE_CONFIG_FOLDER="$SCRIPT_DIR/../configs/yazi"
TARGET_CONFIG_FOLDER="$HOME/.config/yazi"

if [ ! -d "$TARGET_CONFIG_FOLDER" ]; then
	ln -s "$SOURCE_CONFIG_FOLDER" "$TARGET_CONFIG_FOLDER"
fi
