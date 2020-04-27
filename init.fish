# Set language
set -xg LC_ALL en_US.UTF-8
set -xg LANG en_US.UTF-8
# Go
set -xg GOPATH "$HOME/go"
# Docker
set -xg DOCKER_HOST "tcp://localhost:2375"
# Java Home
set -xg JAVA_HOME "/home/linuxbrew/.linuxbrew/opt/openjdk"
# Default editor
set -xg VISUAL "vim"
set -xg EDITOR "$VISUAL"
# Set path
set --universal fish_user_paths $fish_user_paths $HOME/bin $HOME/.local/bin $HOME/go/bin $GOPATH/bin $HOME/.cargo/bin $HOME/.krew/bin $HOME/.composer/vendor/bin/ /home/linuxbrew/.linuxbrew/opt/openjdk/bin

# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

# Direnv
eval (direnv hook fish)
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

# Anaconda
function tg_conda
    if test -z "$PYTHON_DIST"
        set -gx _OLD_PATH $PATH
        set -gx PATH /opt/conda/condabin/ $PATH
        source (conda info --root)/etc/fish/conf.d/conda.fish
        set -gx PYTHON_DIST 'conda'
        echo "Using Anaconda Python"
    else
        set -gx PATH $_OLD_PATH
        set -e PYTHON_DIST
        echo "Back to system Python"
    end
end
