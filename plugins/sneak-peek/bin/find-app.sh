# Sourced by the commands beside it. The plugin carries no playground code: it runs the one
# the Sneak Peek app installs in its data folder, one folder per version, so the commands
# always match the app the user sees. Sets $playground to that version's playground folder,
# or leaves it empty when the app has never been opened.
data="${DEV_PLAYGROUND_DATA:-$HOME/Library/Application Support/Sneak Peek}"
playground=""
# A folder is named <version>-<build>, and builds only go up. An older one can linger while a
# session still runs from it.
for name in $(ls "$data/.runtime" 2>/dev/null | grep -E -- '-[0-9]+$' | sort -t- -k2 -n); do
  [ -x "$data/.runtime/$name/playground/skill/playground" ] && playground="$data/.runtime/$name/playground"
done

download="https://github.com/michael-jordan-coder/dev-playground-releases/releases/latest/download/Sneak-Peek.dmg"
missing="Sneak Peek is not installed, or has not been opened yet. It is a free Mac app: download it from $download, drag it to Applications and open it once. Then try again."
