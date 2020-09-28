# Set language
set -xg LC_ALL en_US.UTF-8
set -xg LANG en_US.UTF-8
# Go
set -xg GOPATH "$HOME/go"
# Java Home
set -xg JAVA_HOME "/usr/lib/jvm/java-1.14.0-openjdk-amd64"
# Default editor
set -xg VISUAL "vim"
set -xg EDITOR "$VISUAL"
# Set path
set --universal fish_user_paths $HOME/bin $HOME/.local/bin $HOME/go/bin $GOPATH/bin $HOME/.cargo/bin $HOME/.krew/bin $HOME/.composer/vendor/bin /home/linuxbrew/.linuxbrew/opt/openjdk/bin $HOME/.cargo/bin

# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

# Linuxbrew
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# Starship
starship init fish | source

# FZF
set -gx FZF_DEFAULT_COMMAND 'rg --files --no-ignore-vcs --hidden'
source $HOME/wsl_dotfiles/fzf.fish

# Ssh agent
function set_ssh_agent
	set -xg SSH_AUTH_SOCK $HOME/.ssh/agent.sock
	ss -a | grep -q $SSH_AUTH_SOCK
	if test $status -ne 0
	    rm -f $SSH_AUTH_SOCK
	    setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"/c/tools/wsl-ssh-agent/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &
	end
end
function reset_ssh_agent
    rm -f $SSH_AUTH_SOCK
    setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"/c/tools/wsl-ssh-agent/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &
end
set_ssh_agent

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

# Python
alias pip=pip3

# Kubernetes
alias k9sDanger=/home/linuxbrew/.linuxbrew/bin/k9s
alias k9s='k9s --readonly'
