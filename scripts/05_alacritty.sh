# shellcheck source=/dev/null

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
SOURCE_CONFIG_FOLDER="$SCRIPT_DIR/../configs/alacritty"
TARGET_CONFIG_FOLDER="$HOME/.config/alacritty"

if [ ! -d "$TARGET_CONFIG_FOLDER" ]; then
	ln -s "$SOURCE_CONFIG_FOLDER" "$TARGET_CONFIG_FOLDER"
fi

apply_theme() {
	local theme_name="$1"
	if [ ! -f "$TARGET_CONFIG_FOLDER/catppuccin-${theme_name}.toml" ]; then
		curl -LO --output-dir "$TARGET_CONFIG_FOLDER" "https://github.com/catppuccin/alacritty/raw/main/catppuccin-${theme_name}.toml"
	fi

	sanitized=$(echo "$TARGET_CONFIG_FOLDER/catppuccin-${theme_name}.toml" | sed 's/\//\\\//g')
	sed -ie "s/^import.*/import=[\"$sanitized\"]/" "$SOURCE_CONFIG_FOLDER/alacritty.toml"
	if [ -f "$SOURCE_CONFIG_FOLDER/alacritty.tomle" ]; then rm "$SOURCE_CONFIG_FOLDER/alacritty.tomle"; fi
}

brightness=$(defaults read -g AppleInterfaceStyle 2>&1 | tr -d '\n')
if [[ "$brightness" == "Dark" ]]; then
	apply_theme 'mocha'
else
	apply_theme 'latte'
fi
