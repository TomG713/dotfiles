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


if (( ! $+commands[kubectl] )); then
  return
fi

# If the completion file doesn't exist yet, we need to autoload it and
# bind it to `kubectl`. Otherwise, compinit will have already done that.
if [[ ! -f "$ZSH_CACHE_DIR/completions/_kubectl" ]]; then
  typeset -g -A _comps
  autoload -Uz _kubectl
  _comps[kubectl]=_kubectl
fi

kubectl completion zsh 2> /dev/null >| "$ZSH_CACHE_DIR/completions/_kubectl" &|

# This command is used a LOT both below and in daily life
alias k=kubectl

# Execute a kubectl command against all namespaces
alias kca='_kca(){ kubectl "$@" --all-namespaces;  unset -f _kca; }; _kca'

# Apply a YML file
alias kaf='kubectl apply -f'

# Drop into an interactive terminal on a container
alias keti='kubectl exec -t -i'

# Manage configuration quickly to switch contexts between local, dev ad staging.
alias kcuc='kubectl config use-context'
alias kcsc='kubectl config set-context'
alias kcdc='kubectl config delete-context'
alias kccc='kubectl config current-context'

# List all contexts
alias kcgc='kubectl config get-contexts'

# General aliases
alias kdel='kubectl delete'
alias kdelf='kubectl delete -f'

# Pod management.
alias kgp='kubectl get pods'
alias kgpa='kubectl get pods --all-namespaces'
alias kgpw='kgp --watch'
alias kgpwide='kgp -o wide'
alias kep='kubectl edit pods'
alias kdp='kubectl describe pods'
alias kdelp='kubectl delete pods'
alias kgpall='kubectl get pods --all-namespaces -o wide'

# get pod by label: kgpl "app=myapp" -n myns
alias kgpl='kgp -l'

# get pod by namespace: kgpn kube-system"
alias kgpn='kgp -n'

# Service management.
alias kgs='kubectl get svc'
alias kgsa='kubectl get svc --all-namespaces'
alias kgsw='kgs --watch'
alias kgswide='kgs -o wide'
alias kes='kubectl edit svc'
alias kds='kubectl describe svc'
alias kdels='kubectl delete svc'

# Ingress management
alias kgi='kubectl get ingress'
alias kgia='kubectl get ingress --all-namespaces'
alias kei='kubectl edit ingress'
alias kdi='kubectl describe ingress'
alias kdeli='kubectl delete ingress'

# Namespace management
alias kgns='kubectl get namespaces'
alias kens='kubectl edit namespace'
alias kdns='kubectl describe namespace'
alias kdelns='kubectl delete namespace'
alias kcn='kubectl config set-context --current --namespace'

# ConfigMap management
alias kgcm='kubectl get configmaps'
alias kgcma='kubectl get configmaps --all-namespaces'
alias kecm='kubectl edit configmap'
alias kdcm='kubectl describe configmap'
alias kdelcm='kubectl delete configmap'

# Secret management
alias kgsec='kubectl get secret'
alias kgseca='kubectl get secret --all-namespaces'
alias kdsec='kubectl describe secret'
alias kdelsec='kubectl delete secret'

# Deployment management.
alias kgd='kubectl get deployment'
alias kgda='kubectl get deployment --all-namespaces'
alias kgdw='kgd --watch'
alias kgdwide='kgd -o wide'
alias ked='kubectl edit deployment'
alias kdd='kubectl describe deployment'
alias kdeld='kubectl delete deployment'
alias ksd='kubectl scale deployment'
alias krsd='kubectl rollout status deployment'

function kres(){
  kubectl set env $@ REFRESHED_AT=$(date +%Y%m%d%H%M%S)
}

# Rollout management.
alias kgrs='kubectl get replicaset'
alias kdrs='kubectl describe replicaset'
alias kers='kubectl edit replicaset'
alias krh='kubectl rollout history'
alias kru='kubectl rollout undo'

# Statefulset management.
alias kgss='kubectl get statefulset'
alias kgssa='kubectl get statefulset --all-namespaces'
alias kgssw='kgss --watch'
alias kgsswide='kgss -o wide'
alias kess='kubectl edit statefulset'
alias kdss='kubectl describe statefulset'
alias kdelss='kubectl delete statefulset'
alias ksss='kubectl scale statefulset'
alias krsss='kubectl rollout status statefulset'

# Port forwarding
alias kpf="kubectl port-forward"

# Tools for accessing all information
alias kga='kubectl get all'
alias kgaa='kubectl get all --all-namespaces'

# Logs
alias kl='kubectl logs'
alias kl1h='kubectl logs --since 1h'
alias kl1m='kubectl logs --since 1m'
alias kl1s='kubectl logs --since 1s'
alias klf='kubectl logs -f'
alias klf1h='kubectl logs --since 1h -f'
alias klf1m='kubectl logs --since 1m -f'
alias klf1s='kubectl logs --since 1s -f'

# File copy
alias kcp='kubectl cp'

# Node Management
alias kgno='kubectl get nodes'
alias keno='kubectl edit node'
alias kdno='kubectl describe node'
alias kdelno='kubectl delete node'

# PVC management.
alias kgpvc='kubectl get pvc'
alias kgpvca='kubectl get pvc --all-namespaces'
alias kgpvcw='kgpvc --watch'
alias kepvc='kubectl edit pvc'
alias kdpvc='kubectl describe pvc'
alias kdelpvc='kubectl delete pvc'

# Service account management.
alias kdsa="kubectl describe sa"
alias kdelsa="kubectl delete sa"

# DaemonSet management.
alias kgds='kubectl get daemonset'
alias kgdsw='kgds --watch'
alias keds='kubectl edit daemonset'
alias kdds='kubectl describe daemonset'
alias kdelds='kubectl delete daemonset'

# CronJob management.
alias kgcj='kubectl get cronjob'
alias kecj='kubectl edit cronjob'
alias kdcj='kubectl describe cronjob'
alias kdelcj='kubectl delete cronjob'

# Job management.
alias kgj='kubectl get job'
alias kej='kubectl edit job'
alias kdj='kubectl describe job'
alias kdelj='kubectl delete job'

# Only run if the user actually has kubectl installed
# if (( ${+_comps[kubectl]} )); then
#   function kj() { kubectl "$@" -o json | jq; }
#   function kjx() { kubectl "$@" -o json | fx; }
#   function ky() { kubectl "$@" -o yaml | yh; }

#   compdef kj=kubectl
#   compdef kjx=kubectl
#   compdef ky=kubectl
# fi
