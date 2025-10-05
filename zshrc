export PATH="/snap/bin/:${HOME}/homebrew/bin:${PATH}:/usr/local/go/bin"
export COLORTERM=truecolor

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=refined
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
FZF_BASE=/usr/bin/
FZF_DEFAULT_COMMAND='fzf'

plugins=(docker fzf git emacs sudo z)

source $ZSH/oh-my-zsh.sh

/usr/bin/keychain --nogui $HOME/.ssh/id_ed25519
source $HOME/.keychain/`hostname`-sh
