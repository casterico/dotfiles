# Disable greeting
set -g fish_greeting

# Editors
set -gx EDITOR micro
set -gx VISUAL micro

# Pager
set -gx PAGER less
set -gx LESS "-R --mouse"
set -gx MANPAGER "less -R"

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lah'

# Abbreviations
abbr -a g git
abbr -a gs git status
abbr -a ga git add
abbr -a gl git log --oneline --graph --decorate
abbr -a gp git pull
abbr -a gc git commit
abbr -a v micro
abbr -a cl clear
abbr -a ff fastfetch
abbr -a pmi sudo pacman -S
abbr -a pmr sudo pacman -Rns
abbr -a pmu sudo pacman -Syu
abbr -a pms pacman -Ss
abbr -a pmq pacman -Qqe
abbr -a pqi pacman -Qi
abbr -a pqo pacman -Qo
abbr -a .. cd ..
abbr -a ... cd ../..
abbr -a .... cd ../../..

# FZF
set -gx FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'

# -------------------------------------------------
# Optional integrations (end of file)
# -------------------------------------------------

# Starship prompt
if type -q starship
    starship init fish | source
end

# fd
if type -q fd
    set -gx FZF_DEFAULT_COMMAND "fd --hidden --follow --exclude .git"
end

# bat
if type -q bat
    set -gx BAT_PAGER "less -R"
end