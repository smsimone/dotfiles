# shellcheck source=/dev/null

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
SOURCE_CONFIG_FOLDER="$SCRIPT_DIR/../configs/alacritty"
TARGET_CONFIG_FOLDER="$HOME/.config/alacritty"

__themes=(
	"https://github.com/catppuccin/alacritty/raw/main/catppuccin-latte.toml"
	"https://github.com/catppuccin/alacritty/raw/main/catppuccin-mocha.toml"
)

if [ ! -d "$TARGET_CONFIG_FOLDER" ]; then
	ln -s "$SOURCE_CONFIG_FOLDER" "$TARGET_CONFIG_FOLDER"
fi

download_themes() {
	for theme in "${__themes[@]}"; do
		local theme_name="$(echo "$theme" | awk -F'/' '{print $(NF)}')"
		if [ ! -f "$TARGET_CONFIG_FOLDER/$theme_name" ]; then
			curl -L0 "$theme" >"${TARGET_CONFIG_FOLDER}/${theme_name}"
		fi
	done
}

apply_theme() {
	local theme_name="$1"
	sanitized=$(echo "$TARGET_CONFIG_FOLDER/${theme_name}.toml" | sed 's/\//\\\//g')
	sed -ie "s/^import.*/import=[\"$sanitized\"]/" "$SOURCE_CONFIG_FOLDER/alacritty.toml"
	if [ -f "$SOURCE_CONFIG_FOLDER/alacritty.tomle" ]; then rm "$SOURCE_CONFIG_FOLDER/alacritty.tomle"; fi
}

download_themes

brightness=$(defaults read -g AppleInterfaceStyle 2>&1 | tr -d '\n')
if [[ "$brightness" == "Dark" ]]; then
	apply_theme 'catppuccin-mocha'
else
	apply_theme 'catppuccin-latte'
fi
