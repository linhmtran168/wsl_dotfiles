# Set language
set -xg LC_ALL en_US.UTF-8
set -xg LANG en_US.UTF-8
# Go
set -xg GOPATH "$HOME/go"
# Java Home
set -xg JAVA_HOME "/home/linuxbrew/.linuxbrew/opt/openjdk"
# Default editor
set -xg VISUAL "vim"
set -xg EDITOR "$VISUAL"
# Set path
set --universal fish_user_paths $HOME/bin $HOME/.local/bin $HOME/go/bin $GOPATH/bin $HOME/.cargo/bin $HOME/.krew/bin $HOME/.composer/vendor/bin /home/linuxbrew/.linuxbrew/opt/openjdk/bin 

# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

# Linuxbrew
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# Ssh agent
set -xg SSH_AUTH_SOCK $HOME/.ssh/agent.sock
ss -a | grep -q $SSH_AUTH_SOCK
if test $status -ne 0
    rm -f $SSH_AUTH_SOCK
    setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"/c/tools/wsl-ssh-agent/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &
end

# dir colors
bass (dircolors ~/wsl_dotfiles/dircolors.base16.dark)

# Directory
alias dev='cd $HOME/Dev'

# tmux
alias tma='tmux attach -t'
alias tmd='tmux new -s (basename (pwd))'
alias tmn='tmux new -s'
alias tml='tmux list-sessions'
alias tmk='tmux kill-session -t'

# drop cache
# This is specific to WSL 2. If the WSL 2 VM goes rogue and decides not to free
# up memory, this command will free your memory after about 20-30 seconds.
# Details: https://github.com/microsoft/WSL/issues/4166#issuecomment-628493643
alias drop_cache="sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'\"" 
