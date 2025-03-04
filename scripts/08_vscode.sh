# shellcheck source=/dev/null

__required_plugins=(
	actboy168.lua-debug
	arkroot.freezed-snippets
	catppuccin.catppuccin-vsc
	catppuccin.catppuccin-vsc-icons
	chaitanyashahare.lazygit
	dart-code.dart-code
	dart-code.flutter
	foxundermoon.shell-format
	golang.go
	ms-azuretools.vscode-docker
	ms-vscode-remote.remote-containers
	redhat.java
	redhat.vscode-microprofile
	redhat.vscode-quarkus
	skellock.just
	sumneko.lua
	usernamehw.errorlens
	visualstudioexptteam.intellicode-api-usage-examples
	visualstudioexptteam.vscodeintellicode
	vscjava.vscode-gradle
	vscjava.vscode-java-debug
	vscjava.vscode-java-dependency
	vscjava.vscode-java-pack
	vscjava.vscode-java-test
	vscjava.vscode-maven
	vscodevim.vim
	jacobdufault.fuzzy-search
	tobias-z.vscode-harpoon
	vspacecode.whichkey
	enkia.tokyo-night
)

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
VSCODE_CONFIG_DIR="$HOME/Library/Application Support/Code/User"

SOURCE_VIMRC="$SCRIPT_DIR/../configs/vscode/code.vimrc"
SOURCE_KEYBINDINGS="$SCRIPT_DIR/../configs/vscode/keybindings.json"
SOURCE_SETTINGS="$SCRIPT_DIR/../configs/vscode/settings.json"

TARGET_VIMRC="$HOME/.config/code.vimrc"
TARGET_KEYBINDINGS="$VSCODE_CONFIG_DIR/keybindings.json"
TARGET_SETTINGS="$VSCODE_CONFIG_DIR/settings.json"

if [ -d "$VSCODE_CONFIG_DIR" ]; then
	[ -f "$TARGET_KEYBINDINGS" ] && rm "$TARGET_KEYBINDINGS"
	ln -s "$SOURCE_KEYBINDINGS" "$TARGET_KEYBINDINGS"

	[ -f "$TARGET_SETTINGS" ] && rm "$TARGET_SETTINGS"
	ln -s "$SOURCE_SETTINGS" "$TARGET_SETTINGS"

	[ -f "$TARGET_VIMRC" ] && rm "$TARGET_VIMRC"
	ln -s "$SOURCE_VIMRC" "$TARGET_VIMRC"
fi

# installs `code` command in path
if ! command -v code &>/dev/null; then
	exec_path="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
	if [ -f "$exec_path" ]; then
		sudo ln -s "$exec_path" /usr/local/bin/code
	fi
fi

if command -v code &>/dev/null; then
	# Install missing plugins
	__installed_plugins=($(code --list-extensions))
	for plugin in "${__required_plugins[@]}"; do
		if ! echo "${__installed_plugins[@]}" | grep -q -w "$plugin"; then
			echo "Plugin $plugin is missing"
			code --install-extension "$plugin"
		fi
	done
fi

# Custom monaspace font
if ! grep -q "monaspace" < <(brew list); then
	brew install font-monaspace-nerd-font
	jq '."editor.fontFamily" = "MonaspiceNE Nerd Font"' "$SOURCE_SETTINGS" | tee "$SOURCE_SETTINGS"
fi
