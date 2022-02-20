#!/bin/bash

# ------------------------------------------------------------------------------
# brew
# ------------------------------------------------------------------------------
if [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
    # shellcheck source=/dev/null
  . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
fi

# ------------------------------------------------------------------------------
# asdf
# ------------------------------------------------------------------------------
if [[ $(command -v brew) ]]; then
  # see https://asdf-vm.com/guide/getting-started.html#_2-download-asdf
  # Bash & Homebrew (macOS)

  # shellcheck source=/dev/null
  . "$(brew --prefix asdf)/asdf.sh"
  # shellcheck source=/dev/null
  . "$(brew --prefix asdf)/etc/bash_completion.d/asdf.bash"
fi

# ------------------------------------------------------------------------------
# VS Code
# ------------------------------------------------------------------------------

# Remote Containers >> SSH
if [ -z "$SSH_AUTH_SOCK" ]; then
  # Check for a currently running instance of the agent
  RUNNING_AGENT="$(pgrep -f 'ssh-agent -s' | wc -l | tr -d '[:space:]')"
  if [ "$RUNNING_AGENT" = "0" ]; then
    # Launch a new instance of the agent
    ssh-agent -s &> "$HOME/.ssh/ssh-agent"
  fi
  eval "cat $HOME/.ssh/ssh-agent"
fi
