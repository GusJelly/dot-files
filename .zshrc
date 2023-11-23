export CLICOLOR=1

autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# aliases
alias pt='setxkbmap pt,pt'
alias us='setxkbmap us,us'
alias night='redshift -P -O 3500k'
alias n="nvim"
alias db="distrobox"
alias ta="tmux attach"
alias t="tmux"
alias lg="lazygit"
alias nc="cd $HOME/.config/nvim; nvim ."
alias ac="cd $HOME/.config; nvim alacritty.yml"
alias zshrc="cd $HOME; nvim .zshrc"
alias notes="cd $HOME/vimwiki; nvim index.md"
alias diary="cd $HOME/vimwiki/diary; nvim diary.md"
alias chess="cd $HOME/ProjetoJava2/chess-app"
alias p="prj"
alias tui="taskwarrior-tui"
alias night='redshift -P -O 3500k'

# aliases for ls
alias l="exa -l"
alias la="exa -la"
alias ls="exa"
alias lsa="exa -a"

# PATH fuckery:
export JAVA_HOME=/usr/lib/jvm/java-openjdk
export LOCAL="$HOME/.local/bin"
export GO="/usr/local/go/bin"
export PATH
export PATH=$PATH:$GO
export PATH=$PATH:$LOCAL
export PATH=$PATH:"/home/gustavo/idea-IC-232.8660.185/bin/"
export FZF_DEFAULT_COMMAND="find"

# Nix path
export PATH=$PATH:"/home/gustavo/.nix-profile/bin/"

# key-bindings for fzf and default nvim editor:
source $HOME/.config/key-bindings.zsh
export EDITOR=nvim
export VISUAL=nvim

# Make ranger exit into current directory:
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

bindkey -s '^o' 'r\n'

# Use lf to switch directories and bind it to ctrl-o
# vicd()
# {
#     local dst="$(command vifm --choose-dir - "$@")"
#     if [ -z "$dst" ]; then
#         echo 'Directory picking cancelled/failed'
#         return 1
#     fi
#     cd "$dst"
# }
# bindkey -s '^o' 'vicd\n'

nvimNotes() {
    cd $HOME/org
    nvim .
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
            echo "$DISTRIB_ID"
            # echo "Version: $DISTRIB_RELEASE"
        else
            # Check for /etc/redhat-release file (common on Red Hat-based distributions)
            if [ -f /etc/redhat-release ]; then
                REDHAT_RELEASE=$(cat /etc/redhat-release)
                echo "$REDHAT_RELEASE"
            else
                # If none of the above files exist, print an error message
                echo "Unable to determine the distribution."
            fi
        fi
    fi
}
findDistro

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
