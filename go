#!/bin/sh

DOCKER_HOST=$(cat docker-host)

go() {
  case $1 in
    deploy)
      deploy
      ;;
    run)
      run
      ;;
    build)
      build
      ;;
    "")
      print_usage
      exit 1
      ;;
    *)
      echo invalid command: $1
      print_usage
      exit 1
      ;;
  esac
}

deploy() {
  build
  use_docker_machine
  docker-compose build
  docker-compose up -d
}

run() {
  build
  docker-compose build
  docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d
}

build() {
  build_elm
  build_haskell
}

build_elm() {
  cd web
  elm make src/Main.elm --output=target/main.js || error "failed to compile elm"
  cd ..
}

build_haskell() {
  stack build --copy-bins || error "failed to compile haskell"
}

use_docker_machine() {
  eval $(docker-machine env $DOCKER_HOST)
}

print_usage() {
  echo usage: $0 \<command\>
}

error() {
	echo "$1"
	exit 1
}

go $1
