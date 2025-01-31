SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
TARGET_CONFIG_FILE="$HOME/.config/ghostty/config"
SOURCE_CONFIG_FILE="$SCRIPT_DIR/../configs/ghostty_config"

if [ ! -f "$TARGET_CONFIG_FILE" ]; then
	mkdir -p "$(dirname "$TARGET_CONFIG_FILE")"
	ln -s "$SOURCE_CONFIG_FILE" "$TARGET_CONFIG_FILE"

	jetbrains=$(ghostty +list-fonts | grep -E '^JetBrainsMono ')
	if [ -n "$jetbrains" ]; then
		echo "font-family = $jetbrains" >>"$SOURCE_CONFIG_FILE"
	fi
fi
