alias gclean='git remote prune origin && git reflog expire --expire=now --all && git gc --prune=now --aggressive && git branch | grep -v "master" | xargs git branch -D'
