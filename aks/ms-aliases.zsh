# microsoft
alias idweb='kinit THGAMBLE@NORTHAMERICA.CORP.MICROSOFT.COM && open -a safari https://idweb/'

# aksdev
alias acrtest='az login && az acr login --name acstest'
alias gowork='cd ${GOPATH}'
alias rp='gowork && cd src/goms.io/aks/rp'
alias aksdev='~/go/src/goms.io/aks/rp/bin/aksdev'

# devbox
alias starthyper='open -a "Azure VPN Client" && ssh hyper'
alias startdev='devboxsub && open -a "Azure VPN Client" && az vm start --name tg --resource-group thgamble-devbox && ssh devbox'
alias devboxsub='az login && az account set -s c1089427-83d3-4286-9f35-5af546a6eb67'
alias devsub='az account set -s d0ecd0d2-779b-4fd0-8f04-d46d07f05703'




