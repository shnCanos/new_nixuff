# Source the file that contains home-manager's variables (not sure why that is not default)
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

# Workaround so icons appear
# export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"

nsearch() {
	xdg-open "search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=$1"
}

# Shell mommy
. shell-mommy
export PROMPT_COMMAND="mommy \\$\\(exit \$?\\); $PROMPT_COMMAND"

export PS1="\[\e[35m\]@\[\e[m\]\[\e[35m\]\u\[\e[m\]: \[\e[36m\]\d\[\e[m\] - \[\e[36m\]\t\[\e[m\]\n[\[\e[37m\]\w\[\e[m\]] - \\$ "

# In order to remove the initial shell mommy thing
clear
cowsay "From now on, WE will be the ones controlling everything you see"
