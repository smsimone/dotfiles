# shellcheck source=/dev/null

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
LUA_SCRIPTS="$SCRIPT_DIR/../lua_scripts"
PROCESS_COUNT=""

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
		exit 1
	fi

	local server="$1"
	if [ -z "$server" ]; then
		echo "Missing server name"
		return 1
	fi

	config=$(awk "/Host $server/" RS= "$HOME/.ssh/config")
	if [ -z "$config" ]; then
		echo "ssh config not found"
		exit 1
	fi
	password=$(echo "$config" | grep "Pass" | awk -F' ' '{print $2}')
	sshpass -p "$password" ssh "$server"
}

exportf() {
	export $(echo $1)="$(whence -f $1 | sed -e "s/$1 //")"
}

__update_project() {
	local project_folder="$1"
	if [ -z "$project_folder" ]; then return 1; fi
	if [ ! -d "$project_folder" ]; then return 1; fi
	pushd "$project_folder" &>/dev/null || return 1
	if grep -q "no branch" < <(cd "$project_folder" && git branch); then
		# the project is not connected to a branch
		return 1
	fi

	result="$(git pull | head -1)"
	echo "$project_folder -> $result"
	popd &>/dev/null || return 1
	return 0
}

# Finds all the git projects in the given directory and pulls their updates
#
# Usage:
# pull_projects [folder]
pull_projects() {
	local folder="$1"

	if [ -z "$folder" ]; then folder="$(pwd)"; fi
	if [ -z "$PROCESS_COUNT" ]; then PROCESS_COUNT=5; fi
	echo "Using $PROCESS_COUNT processes"

	find "$folder" -type d -name '.git' -exec bash -c 'dirname $0' {} \; | xargs -P "$PROCESS_COUNT" -I% lua "$LUA_SCRIPTS/update_project.lua" "%"
}
