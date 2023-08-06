alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gclean='git remote prune origin && git reflog expire --expire=now --all && git gc --prune=now --aggressive && git branch | grep -v "master" | xargs git branch -D'
alias gs='git status -sbuno' # upgrade your git if -sb breaks for you. it's fun.
