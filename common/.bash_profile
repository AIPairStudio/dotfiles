#!/bin/bash

if [ -r "/home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh" ]; then
  # shellcheck source=/dev/null
  . "/home/linuxbrew/.linuxbrew/etc/profile.d/bash_completion.sh"
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
