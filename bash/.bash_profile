alias git-graph="git log --graph --pretty=format:\"%h (%aN, %cr) %s\""

alias grep='grep --color=always'
alias less='less -R'

# http://code-worrier.com/blog/autocomplete-git/
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# http://apple.stackexchange.com/questions/57569/how-to-share-history-between-terminal-tabs
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export EDITOR=emacs

calc () {
    echo "$@" | bc -l
}
