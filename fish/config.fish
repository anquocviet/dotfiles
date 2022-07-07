if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Set vim as Editor:
set -gx EDITOR vim

# Set $PATH to load binary:
set -gx PATH $PATH ~/.fnm ~/.yarn/bin ~/.composer/vendor/bin

if type -q exa 
	alias ls "exa -g --icons"
	alias ll "ls -l"
	alias la "ll -la"
end

alias v "nvim"
alias cl "clear"


# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end

