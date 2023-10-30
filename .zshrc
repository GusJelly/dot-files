# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# # vi mode
# bindkey -v
# export KEYTIMEOUT=1
#
# # Use vim keys in tab complete menu:
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -v '^?' backward-delete-char

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

# PATH fuckery:
export JAVA_HOME=/usr/lib/jvm/java-openjdk
export LOCAL="$HOME/.local/bin"
export GO="/usr/local/go/bin"
export PATH
export CGO_ENABLED=1
export PATH=$PATH:$GO
export PATH=$PATH:$LOCAL
export PATH=$PATH:"/home/gustavo/idea-IC-232.8660.185/bin/"
export FZF_DEFAULT_COMMAND="fd"
export PATH=$PATH:"$HOME/.config/emacs/bin"
export PATH=$PATH:"$HOME/idea-community/bin"

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

nvimVimwiki() {
    cd $HOME/vimwiki
    nvim index.md
}

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

projectsD() {
    oldDir=$(pwd)
    cd "$HOME"/projects

    selected=$(ls -1 | dmenu)

    if [ -z $selected ]; then
        cd $oldDir
    else
        cd $selected
        nvim .
    fi
}
bindkey -s '^p' 'projects\n'

bindkey -s '^v' 'vit\n'

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
        echo "$NAME"

        if [[ "$ID" == "arch" || "$ID" == "endeavouros" ]]; then
            source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        fi

        if [[ "$ID" == "nobara" || "$ID" == "fedora" ]]; then
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
