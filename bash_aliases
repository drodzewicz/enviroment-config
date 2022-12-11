#!/bin/bash

alias bashconf="sudo nano ~/.bashrc"
alias up="git fetch -p & git pull --rebase"
alias lintfix="eslint --fix --ext .js,.jsx ./src/js/"
alias findport="lsof -t -i :8080 -s TCP:LISTEN"
# use java version using sdkman
alias usejava7="sdk use java 7.0.332-zulu"
alias usejava8="sdk use java 8.0.332-zulu"
