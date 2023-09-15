# Enable colors and change prompt:
autoload -U colors && colors
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

git_prompt() {
    local branch="$(git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3-)"
    local branch_truncated="${branch:0:30}"

    if (( ${#branch} > ${#branch_truncated} )); then
        branch="${branch_truncated}..."
    fi

    [ -n "${branch}" ] && echo " (${branch})"
}

# This is specific to zsh but you could call $(git_prompt) in your .bashrc PS1 too.
setopt PROMPT_SUBST
PROMPT='%B%{$fg[blue]%}%~%{$fg[yellow]%}$(git_prompt)%{$reset_color%} %(?.$.%{$fg[red]%}$)%b '
# PROMPT="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%}%{$fg[yellow]%}$(git_prompt)%{$reset_color%} %(?.$.%{$fg[red]%}$)%b "

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Enable moving around tab complete menu with vi keys:
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

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[6 q"
}
zle -N zle-line-init
echo -ne '\e[6 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[6 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# aliases
alias ls="exa"
alias l="exa -l"
alias la="exa -la"
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

# PATH fuckery:
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-17.0.8.0.7-1.fc38.x86_64
export LOCAL="$HOME/.local/bin"
export GO="/usr/local/go/bin"
export PATH
export CGO_ENABLED=1
export PATH=$PATH:$GO
export PATH=$PATH:$LOCAL
export PATH=$PATH:"/home/gustavo/idea-IC-232.8660.185/bin/"
# export FZF_DEFAULT_OPTS="--preview 'less --color=always {}'"
export FZF_DEFAULT_COMMAND="fd --type f"
export PATH=$PATH:"$HOME/.config/emacs/bin"

# key-bindings for fzf and default nvim editor:
source $HOME/.config/key-bindings.zsh
export EDITOR=nvim
export VISUAL=nvim

# Make ranger exit into current directory:
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

nvimnotes() {
    cd $HOME/org
    nvim .
}
bindkey -s '^p' 'nvimnotes\n'

# Source custom scripts:
sh_folder="$HOME/projects/scripts/shellScripts"
for script_file in "$sh_folder"/*.sh; do
    if [[ -f "$script_file" ]]; then
        source "$script_file"
    fi
done

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
