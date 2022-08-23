#============================================================#
#                    # Alias command                         #
#============================================================#

alias v "nvim"
alias fm "ranger"
alias cl "clear"
alias .. "cd .."
alias ... "cd ../.."

# Git
alias gs "git status"
alias gi "git init"
alias ga "git add -u ."
alias gc "git commit -m"
alias gp "git push"

if type -q exa 
	alias ls "exa -g --icons"
	alias ll "ls -l"
	alias la "ll -la"
end
