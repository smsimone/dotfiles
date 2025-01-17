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
function ssh_with_pass(){
	if ! command -v sshpass; then 
		echo "Missing sshpass. You should install it first."
		exit 1
	fi

	local server="$1"
	config=$(cat $HOME/.ssh/config | grep -A 4 "Host $server")
	if [ -z "$config" ]; then 
		echo "ssh config not found"
		exit 1
	fi
	password=$(echo "$config" | grep "Pass" | awk -F' ' '{print $2}') 
	sshpass -p "$password" ssh "$server"
}
