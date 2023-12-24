export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# # Change cursor shape for different vi modes.
# function zle-keymap-select {
#   if [[ ${KEYMAP} == vicmd ]] ||
#      [[ $1 = 'block' ]]; then
#     echo -ne '\e[1 q'
#   elif [[ ${KEYMAP} == main ]] ||
#        [[ ${KEYMAP} == viins ]] ||
#        [[ ${KEYMAP} = '' ]] ||
#        [[ $1 = 'beam' ]]; then
#     echo -ne '\e[5 q'
#   fi
# }
# zle -N zle-keymap-select
# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# aliases
alias n="nvim"
alias db="distrobox"
alias ta="tmux attach"
alias t="tmux"
alias lg="lazygit"
alias nc="cd $HOME/.config/nvim; nvim ."
alias zshrc="cd $HOME; nvim .zshrc"
alias ls="eza"
alias ll="eza -l"
alias la="eza -la"
alias l="eza -l"
alias lsa="eza -a"

export LOCAL="$HOME/.local/bin"
export GO="/home/gustavo/go/bin/"
export PATH=$PATH:$GO
export PATH=$PATH:$LOCAL

# Nix path
export PATH=$PATH:"/home/gustavo/.nix-profile/bin/"

# Make ranger exit into current directory:
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
bindkey -s '^o' 'r\n'

nvimNotes() {
    cd $HOME/notes/
    nvim index.norg
}
bindkey -s '^n' 'nvimNotes\n'

projects() {
    oldDir=$(pwd)
    cd "$HOME"/projects

    selected=$(ls -1 | fzf --reverse --preview 'ls {}')

    if [ -z $selected ]; then
        cd $oldDir
    else
        cd $selected
        nvim .
    fi
}
bindkey -s '^p' 'projects\n'

# Source custom scripts:
sh_folder="$HOME/projects/scripts/shellScripts"
for script_file in "$sh_folder"/*.sh; do
    if [[ -f "$script_file" ]]; then
        source "$script_file"
    fi
done

# Find current distro and source correct zsh-syntax-highlighting script path
findDistro() {
    # Check for /etc/os-release file (common on modern distributions)
    if [ -f /etc/os-release ]; then
        source /etc/os-release
        # echo "$NAME"

        if [[ "$ID" == "arch" || "$ID" == "endeavouros" ]]; then
            source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        fi

        if [[ "$ID" == "nobara" || "$ID" == "fedora" ]]; then
            source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        fi

        if [[ "$ID" == "pop" ]]; then
            source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        fi

        # echo "Version: $VERSION"
    else
        # Check for /etc/lsb-release file (common on Debian-based distributions)
        if [ -f /etc/lsb-release ]; then
            source /etc/lsb-release
            # echo "Version: $DISTRIB_RELEASE"
        else
            # Check for /etc/redhat-release file (common on Red Hat-based distributions)
            if [ -f /etc/redhat-release ]; then
                REDHAT_RELEASE=$(cat /etc/redhat-release)
            else
                # If none of the above files exist, print an error message
                echo "Unable to determine the distribution."
            fi
        fi
    fi
}
findDistro

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
