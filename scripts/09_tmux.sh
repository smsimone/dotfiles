SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
SOURCE_CONFIG_FOLDER="$SCRIPT_DIR/../configs/tmux"
TARGET_CONFIG_FOLDER="$HOME/.config/tmux"

if ! command -v tmux &>/dev/null; then
	brew install tmux
fi

if [ ! -d "$TARGET_CONFIG_FOLDER" ]; then
	ln -s "$SOURCE_CONFIG_FOLDER" "$TARGET_CONFIG_FOLDER"
fi
