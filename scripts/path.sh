export GO_PATH=~/go

paths=(
  "$GO_PATH/bin"
  "$HOME/.local/bin"
  "$HOME/.pyenv/bin"
  "$HOME/.scripts"
  "$HOME/.spicetify"
  "$HOME/Development/monarch/bin"
  "$HOME/Library/Python/3.11/bin"
  "$HOME/fvm/default/bin"
  "/bin"
  "/sbin"
  "/usr/bin"
  "/usr/local/bin/"
  "/usr/local/opt/libpq/bin"
  "/usr/local/sbin"
  "/usr/sbin"
)

paths_combined=""
for path_item in "${paths[@]}"; do
  if [ -z "${paths_combined}" ]; then
    paths_combined="$path_item"
  else
    if [ ! -d "${path_item}" ]; then
      echo "path '${path_item}' does not exists"
    fi
    paths_combined="${paths_combined}:${path_item}"
  fi
done

export PATH="$PATH:${paths_combined}"
