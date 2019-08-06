alias d='docker $*'
alias d-c='docker-compose $*'
alias docker-prune='docker rmi -f $(docker images -q) && docker rmi -f $(docker images -a -q) && docker rm -f $(docker ps -a -q) && docker volume rm -f $(docker volume ls -q)'

function dockerenv () {
  local args=${@:-default}
  eval $(docker-machine env $args)
}
function docker-empty () {
  docker ps -aq | xargs --no-run-if-empty docker rm -f
}
