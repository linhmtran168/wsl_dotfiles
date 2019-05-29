# Set languag
set -xg LC_ALL en_US.UTF-8
set -xg LANG en_US.UTF-8
# Docker
set -xg DOCKER_HOST "tcp://localhost:2375"
# Set path
set --universal fish_user_paths $fish_user_paths $HOME/bin $HOME/.local/bin

# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

# Linuxbrew
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
# ssh-agent-wsl
bass (/c/bin/ssh-agent/ssh-agent-wsl -r)
# dir colors
bass (dircolors ~/wsl_dotfiles/dircolors.base16.dark)
# Directory
alias dev='cd /c/Users/linhm/Dev'
# tmux
alias tma='tmux attach -t'
alias tmd='tmux new -s (basename (pwd))'
alias tmn='tmux new -s'
alias tml='tmux list-sessions'
alias tmk='tmux kill-session -t'
