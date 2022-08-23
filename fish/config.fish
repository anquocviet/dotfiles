if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end

# Alias
source $HOME/.config/fish/alias.fish

# Set Caps Lock to ESC
setxkbmap -option caps:escape
# Set ESC to Caps Lock
setxkbmap -option escape:caps

# Auto load
neofetch
starship init fish | source
