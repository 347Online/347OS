# TODO: Move this file to dotfiles, remove readFile kludge
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

fpath=(~/.config/zsh/completions $fpath)

test -f ~/.config/zsh/.p10k.zsh && source ~/.config/zsh/.p10k.zsh

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

bindkey -e

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

eval "$(tinty generate-completion zsh)"
# Activate syntax highlighting in manpages
eval "$(batman --export-env)"
