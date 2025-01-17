SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
VSCODE_CONFIG_DIR="$HOME/Library/Application Support/Code/User"

SOURCE_VIMRC="$SCRIPT_DIR/../configs/vscode/code.vimrc"
SOURCE_KEYBINDINGS="$SCRIPT_DIR/../configs/vscode/keybindings.json"
SOURCE_SETTINGS="$SCRIPT_DIR/../configs/vscode/settings.json"
SOURCE_SNIPPETS_FOLDER="$SCRIPT_DIR/../configs/vscode/snippets"

TARGET_VIMRC="$HOME/.config/code.vimrc"
TARGET_KEYBINDINGS="$VSCODE_CONFIG_DIR/keybindings.json"
TARGET_SETTINGS="$VSCODE_CONFIG_DIR/settings.json"
TARGET_SNIPPETS_FOLDER="$VSCODE_CONFIG_DIR/snippets"


if [ -d "$VSCODE_CONFIG_DIR" ]; then 
	[ -f "$TARGET_KEYBINDINGS" ] && rm "$TARGET_KEYBINDINGS"
	ln -s "$SOURCE_KEYBINDINGS" "$TARGET_KEYBINDINGS"

	[ -f "$TARGET_SETTINGS" ] && rm "$TARGET_SETTINGS"
	ln -s "$SOURCE_SETTINGS" "$TARGET_SETTINGS"

	[ -d "$TARGET_SNIPPETS_FOLDER" ] && rm -rf "$TARGET_SNIPPETS_FOLDER"
	ln -s "$SOURCE_SNIPPETS_FOLDER" "$TARGET_SNIPPETS_FOLDER"

	[ -f "$TARGET_VIMRC" ] && rm "$TARGET_VIMRC"
	ln -s "$SOURCE_VIMRC" "$TARGET_VIMRC"
fi
