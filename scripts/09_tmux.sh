#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
SOURCE_CONFIG_FOLDER="$SCRIPT_DIR/../configs/tmux"
TARGET_CONFIG_FOLDER="$HOME/.config/tmux"

if [[ "$ENABLE_TMUX" == "1" ]]; then
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

	function apply_theme(){
		local from="$1"
		local to="$2"

		exists=$(grep -w "$from" "$SOURCE_CONFIG_FOLDER/statusbar.conf")
		if [ ! -z "$exists" ]; then
			sed -ie "s/$from/$to/g" "$SOURCE_CONFIG_FOLDER/statusbar.conf"
			return 0
		fi
		return 1
	}

	brightness=$(defaults read -g AppleInterfaceStyle 2>&1 | tr -d '\n')
	if [[ "$brightness" == "Dark" ]]; then
		apply_theme 'latte' 'mocha' && tmux kill-server
	else
		apply_theme 'mocha' 'latte' && tmux kill-server
	fi

	if [ -f "$SOURCE_CONFIG_FOLDER/statusbar.confe" ]; then
		rm "$SOURCE_CONFIG_FOLDER/statusbar.confe"
	fi

fi
