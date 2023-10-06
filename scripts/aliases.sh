#!/bin/bash

alias git-history="git diff-tree --no-commit-id --name-only -r "
alias vim='nvim'
alias gw='git worktree'
alias jqq='/Users/smaso/Development/jqq/jqq.rb'
alias update='brew update && brew upgrade; brew cleanup'
alias cd='z'
alias l='ls -l'
alias ll='ls -la'
alias fastlane='bundle exec fastlane'
alias flutter='fvm flutter'

gcl_exists=$(command gitlab-ci-local 2> /dev/null; echo $?)
if [ "$gcl_exists" -eq 0 ]; then
  alias gcl="gitlab-ci-local"
fi
