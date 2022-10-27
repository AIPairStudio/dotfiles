# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zprofile.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.pre.zsh"
#!/bin/bash

# ------------------------------------------------------------------------------
# brew
# ------------------------------------------------------------------------------
if [[ $(command -v brew) ]]; then
  if [ "$(uname)" = "Darwin" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ "$(uname -s)" = "Linux" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  else
    echo "Your platform ($(uname -a)) is not supported."
  fi
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

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zprofile.post.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.post.zsh"
