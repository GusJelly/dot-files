# # Vi mode cursor changing
# set fish_cursor_default block
# set fish_cursor_insert line
# set fish_cursor_replace_one underscore
# set fish_cursor_visual block

# Path fuckery
fish_add_path "$HOME/.local/bin/"
fish_add_path "$HOME/.nix-profile/bin/"
fish_add_path "/nix/var/nix/profiles/default/bin/"

# Aliases
alias ls="eza"
alias lsa="eza -a"
alias l="eza -l"
alias la="eza -la"
alias vim="nvim"
alias v="vim"
alias lg="lazygit"

# Commands to run in interactive sessions can go here
if status is-interactive
    # Keybindings
    bind -M insert \cP 'projects'
end


eval "$(starship init fish)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
