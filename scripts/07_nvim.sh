# shellcheck source=/dev/null

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
SOURCE_CONFIG_FOLDER="$SCRIPT_DIR/../configs/nvim"
TARGET_CONFIG_FOLDER="$HOME/.config/nvim"

if ! command -v nvim &>/dev/null; then
	brew install neovim
fi

if [ ! -d "$TARGET_CONFIG_FOLDER" ]; then
	ln -s "$SOURCE_CONFIG_FOLDER" "$TARGET_CONFIG_FOLDER"
fi
