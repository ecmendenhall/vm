ZSH=$HOME/.oh-my-zsh

ZSH_THEME="norm"
COMPLETION_WAITING_DOTS="true"
# Path
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:$PATH

plugins=(git
         github
         heroku
         lein
         battery
         cp
         git-extras)

source $ZSH/oh-my-zsh.sh

# Completion
setopt COMPLETE_IN_WORD
autoload -U compinit
compinit
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # case insensitive completion
zstyle ':completion:*:default' menu 'select=0' # menu-style

# Colors
export CLICOLOR=1
autoload colors
colors

# History
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt EXTENDED_HISTORY # add timestamps to history
setopt APPEND_HISTORY # adds history
setopt INC_APPEND_HISTORY # adds history incrementally
setopt SHARE_HISTORY # share across sessions
setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
bindkey -e
bindkey '^r' history-incremental-search-backward

autoload -U select-word-style
select-word-style bash

# Miscellaneous Options
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt PROMPT_SUBST
setopt AUTO_CD
stty -ixon -ixoff # disable scroll lock
export EDITOR=vim
set -o emacs

# Load other config files
for config_file ($HOME/.zsh/*.zsh(.N)) source $config_file
