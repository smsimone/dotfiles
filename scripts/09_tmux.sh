SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
SOURCE_CONFIG_FOLDER="$SCRIPT_DIR/../configs/tmux"
TARGET_CONFIG_FOLDER="$HOME/.config/tmux"

if ! command -v tmux &>/dev/null; then
	brew install tmux
fi

if [ ! -d "$TARGET_CONFIG_FOLDER" ]; then
	ln -s "$SOURCE_CONFIG_FOLDER" "$TARGET_CONFIG_FOLDER"

	[ -d  "$TARGET_CONFIG_FOLDER/plugins/tpm" ] && rm -rf "$TARGET_CONFIG_FOLDER/plugins/tpm"
	git clone https://github.com/tmux-plugins/tpm "$TARGET_CONFIG_FOLDER/plugins/tpm"
	"$TARGET_CONFIG_FOLDER/plugins/tpm/bin/install_plugins"

	[ -d "$TARGET_CONFIG_FOLDER/plugins/catppuccin-tmux" ] && rm -rf "$TARGET_CONFIG_FOLDER/plugins/catppuccin-tmux"
	git clone -b v2.1.2 https://github.com/catppuccin/tmux.git "$TARGET_CONFIG_FOLDER/plugins/catppuccin-tmux"

	if [ ! -z "$TMUX" ]; then
		source-file ~/.config/tmux/tmux.conf
	fi
fi
