# autoload -U +X compinit && compinit
source <(kubectl completion zsh)
alias k=kubectl
# complete -o default -F __start_kubectl k


