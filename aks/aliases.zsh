# microsoft
alias idweb='kinit THGAMBLE@NORTHAMERICA.CORP.MICROSOFT.COM && open -a safari https://idweb/'

# aksdev
alias acrtest='az login && az acr login --name acstest'
alias gowork='cd ${GOPATH}'
alias rp='gowork && cd src/goms.io/aks/rp'
alias aksdev='~/go/src/goms.io/aks/rp/bin/aksdev'

# devbox
alias starthyper='open -a "Azure VPN Client" && ssh hyper'
alias startdev='devboxsub && open -a "Azure VPN Client" && az vm start --name tg-202308 --resource-group thgamble-devbox && ssh devbox'
alias devboxsub='az login && az account set -s c1089427-83d3-4286-9f35-5af546a6eb67'
alias devsub='az account set -s d0ecd0d2-779b-4fd0-8f04-d46d07f05703'

# k8s
alias kbroken='kubectl get pods --all-namespaces -o wide | grep -v Running'
alias kdelete='kubectl delete pods --field-selector status.phase!=Running --all-namespaces'

## saw

#alias k='kubectl'
#complete -o default -F __start_kubectl k
#alias kstaging='aks-prod-tools kubectl -e staging -r westus2 -c svc-0'
#alias kint='aks-prod-tools kubectl -e intv2 -r eastus -c svc-0'
#alias a='aks-prod-tools'
#alias ak='aks-prod-tools kubectl -e prod'
#alias as='aks-prod-tools ssh -e prod'
#PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]|\[\033[01;34m\]\w\[\033[00m\]|\[\033[01;33m\]$(kwhich | sed "s/hcp-underlay-//")\[\033[00m\]\$ '
#function kwhich {
#  if [[ -z ${KUBECONFIG} ]]; then
#    KUBECONFIG=~/.kube/config
#  fi
#  if [[ -f ${KUBECONFIG} ]]; then
#    yq e .clusters[0].cluster.server ${KUBECONFIG} | sed 's/https:\/\///' | cut -d "." -f1
#  else
#    echo "unset"
#  fi
#}
#kubectl -n {ns} get secret kubeconfig-file -o json | jq -r '.data."kubeconfig.yaml"' | base64 -d > config
# change kubeconfig serverurl to cluster fqdn
# kubectl --kubeconfig=config ...
