alias d='docker $*'
alias d-c='docker-compose $*'
alias docker-prune='docker system prune -f'

function docker-empty () {
  docker ps -aq | xargs --no-run-if-empty docker rm -f
}
