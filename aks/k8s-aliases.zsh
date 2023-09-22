alias aks='aks-prod-tools'
alias as='aks-prod-tools ssh'
alias ak='aks-prod-tools kubectl'
alias akg='aks-prod-tools kubectl -c $c && kubectl cluster-info && kubectl get nodes'
alias akge='aks-prod-tools kubectl -c $c -p env && kubectl cluster-info && kubectl get nodes'
alias klies="k get po --all-namespaces -o json | jq -r '.items[] | select(.status.phase != \"Running\" or ([ .status.conditions[] | select(.type == \"Ready\" and .status == \"False\") ] | length ) == 1 ) | \"k -n \" + .metadata.namespace + \" delete po \" + .metadata.name'"
alias kexec="aks-prod-tools ssh -c $c --exec "

function icm {
  if [[ -z "${1}" ]]; then
    echo -e "Enter full ICM title string: \c"
    read var
    eval "set -- '${var}'"
  fi

  # Split the input string into words using the " " character
  words=("${(@s: :)1}")
  incident=""
  cluster=""
  component=""
  node=""
  n="" 
  c=""

  for word in "${words[@]}"; do
    if [[ "$word" =~ ^[0-9]+$ ]]; then
      incident=$word
    elif [[ "$word" == *"/"* ]]; then
      cluster="${word%%/*}"
      c="${word%%/*}"
      raw_component="${word#*/}"
      if [[ "$raw_component" == k8s-* ]]; then
        node="$raw_component"
        n="$raw_component"
      else
        component="$raw_component"
      fi
    fi
  done

  # Set global variables and unset them if the value is empty
  if [[ -n "$incident" ]]; then
    typeset -g incident_global="${incident}"
  else
    unset incident_global
  fi

  if [[ -n "$cluster" ]]; then
    typeset -g cluster_global="${c}"
  else
    unset cluster_global
  fi
    typeset -g cluster_global="${c}"

  if [[ -n "$cluster" ]]; then
    typeset -g cluster_global="${cluster}"
  else
    unset cluster_global
  fi

  if [[ -n "$component" ]]; then
    typeset -g component_global="${component}"
  else
    unset component_global
  fi

  if [[ -n "$node" ]]; then 
    typeset -g node_global="${n}"
  else
    unset node_global
  fi

  if [[ -n "$node" ]]; then
    typeset -g node_global="${node}" 
  else
    unset node_global
  fi

  # Echo only non-empty variables with a newline after each
  [[ -n "$incident" ]] && echo "incident=$incident"
  [[ -n "$cluster" ]] && echo "cluster=$c"
  [[ -n "$component" ]] && echo "component=$component"
  [[ -n "$node" ]] && echo "node=$node"

  # Execute the aks-prod-tools command with the kubectl -c $cluster argument
  if [[ -n "$cluster" ]]; then
    aks-prod-tools kubectl -c "$cluster"
  fi
}


alias ll='ls -lah'
alias kgpa='kubectl get pods -A'
alias kgpaw='kubectl get pods -A -o wide'
alias knl='kubectl -n linkerd'
alias kgpt='kubectl get pods -A -o wide | grep -v Running'
alias kci='kubectl cluster-info'
alias kgpn='kubectl get pods -A -o wide | grep $n'
alias knks='kubectl -n kube-system'
alias kneg='kubectl -n eventgrid'
alias kncs='kubectl -n containerservice'
alias kncsa='kubectl -n containerservicei-async'
alias kni='kubectl -n infra'
alias kgpks='kubectl get pods -n kube-system'
alias knm='kubectl -n monitoring'
alias kgp='kubectl get pods'
alias kgpi='kubectl get pods -n infra'
alias kgpm='kubectl get pods -n monitoring'
alias kgn='kubectl get no'
alias kgna='kubectl get no | grep "k8s-agent-"'
alias kgnm='kubectl get no | grep master'
alias kgni='kubectl get no | grep infra'
alias hcp='hcpdebug debug -e prod -p bash'
alias kgnapi='kubectl get no | grep agentapi'
alias watch='watch '
alias ksn0='k scale --replicas=0 -n infra deployment/underlay-nanny'
alias ksn3='k scale --replicas=3 -n infra deployment/underlay-nanny'
alias keml='aks ssh -c $c -i 0 --exec "sudo etcdctl member list"'
alias aa='aks-prod-tools kubectl -c $c && kubectl cluster-info'
alias ss='knl edit deploy linkerd-proxy-injector'
alias dd='knl edit deploy linkerd-destination'
alias ff='kubectl -n linkerd get po'
alias fixit="rm -rf ~/.azure/* && az login -o none"


alias ssh='nocorrect ssh'


if [ ! -f "$HOME/.azure/az.sess" ]; then
  az login -o none
fi

alias kbroken='kubectl get pods --all-namespaces -o wide | grep -v Running'
alias kdelete='kubectl delete pods --field-selector status.phase!=Running --all-namespaces'

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

# Notes
# 
#kubectl -n {ns} get secret kubeconfig-file -o json | jq -r '.data."kubeconfig.yaml"' | base64 -d > config
# change kubeconfig serverurl to cluster fqdn
# kubectl --kubeconfig=config ...

# function ee() {
#     echo "Fixing linkerd deployment timeout and cpu limits..."
#     kubectl get deployments -n linkerd -o name | xargs -I {} sh -c 'kubectl get {} -n linkerd -o yaml | sed -e "s/timeoutSeconds: 1/timeoutSeconds: 10/g" -e "s/periodSeconds: 10/periodSeconds: 15/g" -e "s/cpu: 200m/cpu: 300m/g" | kubectl apply -f -'
# }


# backup of p10k custom prompt segment
# function prompt_my_which_k8s {
#   if [[ -z ${KUBECONFIG} ]]; then
#     KUBECONFIG=~/.kube/config
#   fi
#   if [[ -f ${KUBECONFIG} ]]; then
#     local server=$(yq eval '.clusters[0].cluster.server' ${KUBECONFIG} | sed 's/https:\/\///' | cut -d "." -f1)
#   fi
#   p10k segment -s $server -i '⭐' -f blue -t $server
# }  
