# shellcheck source=/dev/null

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
LUA_SCRIPTS="$SCRIPT_DIR/../lua_scripts"

# Connects to ssh by injecting the password automatically using sshpass
#
# To make it work you have to add the "Pass" key to your host configuration
# in ~/.ssh/config
#
# The Pass field must be commented out because it's an invalid key, like so
#
# Host example_host
#   HostName <address>
#   #Pass <password>
ssh_with_pass() {
	if ! command -v sshpass; then
		echo "Missing sshpass. You should install it first."
		return 1
	fi

	local server="$1"
	if [ -z "$server" ]; then
		echo "Missing server name"
		return 1
	fi

	config=$(awk "/Host $server/" RS= "$HOME/.ssh/config")
	if [ -z "$config" ]; then
		echo "ssh config not found for server '$server'"
		return 1
	fi
	password=$(echo "$config" | grep "Pass" | awk -F' ' '{print $2}')
	sshpass -p "$password" ssh "$server"
}

# Finds all the git projects in the given directory and pulls their updates
#
# Usage:
# pull_projects [folder]
pull_projects() {
	local folder=""
	local process_count="5"

	while getopts "p:f:" opt; do
		case $opt in
		p)
			process_count=$OPTARG
			;;
		f)
			folder=$OPTARG
			if [ ! -d "$folder" ]; then
				echo "the given path should point to a folder"
				return 1
			fi
			;;
		\?)
			echo "Usage: $0 -p process_count -f folder"
			return 1
			;;
		esac
	done
	if [ -z "$folder" ]; then
		echo "Missing target folder"
		echo "--------"
		echo "Usage: $0 -p path -f folder"
		return 1
	fi

	local projects=($(find "$folder" -type d -name '.git' -exec bash -c 'dirname "$(readlink -f $0)"' {} \;))
	pushd "$LUA_SCRIPTS" &>/dev/null
	printf "%s\n" "${projects[@]}" | xargs -P "$process_count" -I% lua "$LUA_SCRIPTS/update_project.lua" "%"
	popd &>/dev/null
}

clean_ios_project() {
	if [ ! -f './pubspec.yaml' ]; then
		echo "This script should be run in the flutter project root folder"
		return 1
	fi
	(
		cd ios
		rm Podfile.lock
		pod deintegrate && pod repo update && pod install
	)
}
