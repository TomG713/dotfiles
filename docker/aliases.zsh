alias d='docker $*'
alias d-c='docker-compose $*'
alias docker-prune='docker system prune -f'
function dockerenv () {
  local args=${@:-default}
  eval $(docker-machine env $args)
}

function docker-empty () {
  docker ps -aq | xargs --no-run-if-empty docker rm -f
}
