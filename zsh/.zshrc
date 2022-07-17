export ZSH=$HOME/.oh-my-zsh
if [[ ! -d $ZSH ]]; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git $ZSH
fi

alias em="emacs -nw"
alias nv="nvim -p"
alias tmux="tmux -2 -u"
alias tm=tmux

ZSH_THEME="ys"
zstyle ':omz:update' mode reminder

EDITOR=nvim
VISUAL=$EDITOR

plugins=(
	git
	jira
	python
	themes
	vi-mode
	z
)
source $ZSH/oh-my-zsh.sh
