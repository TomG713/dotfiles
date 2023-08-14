alias acrtest='az login && az acr login --name acstest'
alias aksgo='echo "Using go ${GO_VERSION}" && alias go=go${GO_VERSION}'
alias gowork='aksgo && cd ${GOPATH}'
alias gorp='gowork && cd src/goms.io/aks/rp'
alias idweb='kinit THGAMBLE@NORTHAMERICA.CORP.MICROSOFT.COM && open -a safari https://idweb/'
alias aksdev='~/go/src/goms.io/aks/rp/bin/aksdev'
alias startdev='az vm start --name tg-202308 --resource-group thgamble-devbox && tailscale down && tailscale up && ssh devbox'
alias devboxsub='az login && az account set -s c1089427-83d3-4286-9f35-5af546a6eb67'

