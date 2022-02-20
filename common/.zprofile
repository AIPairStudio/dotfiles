#!/bin/bash

# ------------------------------------------------------------------------------
# brew
# ------------------------------------------------------------------------------
if [[ $(command -v brew) ]]; then
    # shellcheck source=/dev/null
  . "$(brew --prefix)/bin/brew shellenv"
fi

# ------------------------------------------------------------------------------
# VS Code
# ------------------------------------------------------------------------------

# Remote Containers >> SSH
if [ -z "$SSH_AUTH_SOCK" ]; then
  # Check for a currently running instance of the agent
  RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
  if [ "$RUNNING_AGENT" = "0" ]; then
    # Launch a new instance of the agent
    ssh-agent -s &> $HOME/.ssh/ssh-agent
  fi
  eval `cat $HOME/.ssh/ssh-agent`
fi
