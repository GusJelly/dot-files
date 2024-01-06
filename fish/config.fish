# Commands to run in interactive sessions can go here
if status is-interactive
end

# Path fuckery
fish_add_path "$HOME/.local/bin/"
fish_add_path "$HOME/.nix-profile/bin/"
fish_add_path "/nix/var/nix/profiles/default/bin/"

eval "$(starship init fish)"
