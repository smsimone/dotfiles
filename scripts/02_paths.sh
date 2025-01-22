#!/usr/bin/env bash
# shellcheck source=/dev/null

paths=(
	"/opt/homebrew/bin"
	"$HOME/fvm/default/bin"
)

for item in "${paths[@]}"; do
	if [ -d "$item" ]; then
		export PATH="$item:$PATH"
	fi
done

## makes every key in path unique
export PATH="$(echo "$PATH" | tr -s ':' '\n' | uniq | tr -s '\n' ':' | sed 's/.$//')"
