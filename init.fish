# Set language
set -xg LC_ALL en_US.UTF-8
set -xg LANG en_US.UTF-8
set -xg GOPATH "$HOME/go"
# Docker
set -xg DOCKER_HOST "tcp://localhost:2375"
# Default editor
set -xg VISUAL "vim"
set -xg EDITOR "$VISUAL"
# Set path
set --universal fish_user_paths $fish_user_paths $HOME/bin $HOME/.local/bin $HOME/go/bin $GOPATH/bin $HOME/.cargo/bin

# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

# Linuxbrew
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
# wsl-ssh-agent
set -xg SSH_AUTH_SOCK /c/tools/wsl-ssh-agent/ssh-agent.sock
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
