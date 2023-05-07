

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

xrandr --output DVI-D-1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-1 --primary --mode 1920x1080 --refresh 165.00 --pos 0x0 --rotate normal --output DP-2 --off --output HDMI-1 --off --output HDMI-2 --off

