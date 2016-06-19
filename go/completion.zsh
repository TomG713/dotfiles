# Uses go's autocompletion for inner commands. Assumes an install of go's
# bash `go-completion` script at $completion below (this is where Homebrew
# tosses it, at least).
completion='$(brew --prefix)/share/zsh/site-functions/_go'

#if test -f $completion
#then
#  source $completion
#fi
