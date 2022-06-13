function fish_greeting
  echo ""
end

# ------------------------------------------------------------------------------
# brew
# ------------------------------------------------------------------------------
function abort
  printf "%s\n" "\$@"
  exit 1
end

if test (uname -s) = "Darwin"
  set -x PLATFORM "mac"
else if test (uname -s) = "MINGW"
  set -x PLATFORM "windows"
else if test (uname -s) = "Linux"
  set -x PLATFORM "linux"
else
  set -x PLATFORM "Unknown OS"
  abort "Your platform (uname -a) is not supported."
end

function is_exists
  which "$1" >/dev/null 2>&1
  return "\$?"
end

function is_linux
  return test ("$PLATFORM" = "linux")
end

function is_mac
  return test ("$PLATFORM" = "mac")
end

# ------------------------------------------------------------------------------
# asdf
# ------------------------------------------------------------------------------
if test is_linux = true
  eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
else if test is_mac
  eval (/opt/homebrew/bin/brew shellenv)
end
# end

# ------------------------------------------------------------------------------
# asdf
# ------------------------------------------------------------------------------
if test (command -v brew)
  # see https://asdf-vm.com/guide/getting-started.html#_2-download-asdf
  # Fish & Homebrew
  . ""(brew --prefix asdf)"/libexec/asdf.fish"
end

# ------------------------------------------------------------------------------
# shortcut
# ------------------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias dl='cd ~/Downloads'
alias d='cd ~/Desktop'
alias work='cd ~/workspace'

# ------------------------------------------------------------------------------
# exa
# ------------------------------------------------------------------------------
if test (command -v exa)
  alias e='exa --icons --git'
  alias l=e
  alias ls=e
  alias ea='exa -a --icons --git'
  alias la=ea
  alias ee='exa -aahl --icons --git'
  alias ll=ee
  alias et='exa -T -L 3 -a -I "node_modules|.git|.cache" --icons'
  alias lt=et
  alias eta='exa -T -a -I "node_modules|.git|.cache" --color=always --icons | less -r'
  alias lta=eta
  alias l='clear && ls'
end

# ------------------------------------------------------------------------------
# git
# ------------------------------------------------------------------------------
if test (command -v git)
  alias g='git'
  alias gb='git branch'
  alias gb-this='git rev-parse --abbrev-ref HEAD'
  alias gba='git branch -a'
  alias ga='git add'
  alias gc='git commit -am'
  alias gca='git commit --amend'
  alias gd='git diff'
  alias gds='git diff --staged'
  alias gf='git fetch'
  alias gm='git merge'
  alias gr="git rebase"
  alias grc="git rebase --continue"
  alias gra="git rebase --abort"
  alias gpl='git pull'
  alias gps='git push'
  alias gpso='git push origin'
  alias gpso-this='git push origin (git rev-parse --abbrev-ref HEAD)'
  alias gstt='git status'
  alias gsts='git stash'
  alias gsw='git switch'
  alias gswc='git switch -c'
  alias gl='git log --oneline'
  alias gbm='git branch --merged'
  alias gbm-all='git branch --merged|egrep -v "\*|develop|main"|xargs git branch' # -d で削除, -D で完全削除
end

# ------------------------------------------------------------------------------
# terraform
# ------------------------------------------------------------------------------
if test (command -v terraform)
  alias tf='terraform'
  alias tfi='terraform init'
  alias tfi='terraform init --auto-approve'
  alias tff='terraform fmt'
  alias tfp='terraform plan'
  alias tfa='terraform apply'
  alias tfi='terraform import'
  alias tfaa='terraform apply --auto-approve'
  alias tfsl='terraform state list'
end

# ------------------------------------------------------------------------------
# \shellcheck
# ------------------------------------------------------------------------------
if test (command -v shellcheck)
  alias sc='shellcheck'
  function schelp
    curl -s https://raw.githubusercontent.com/wiki/koalaman/shellcheck/"$1".md
  end
end

alias help-me='echo "
ctrl+a\t\t:行頭に移動
ctrl+e\t\t:行末に移動
ctrl+h\t\t:後方に1文字削除
meta(esc)+b\t:一語後退
meta(esc)+f\t:一語前進
ctrl+u\t\t:行頭まで削除
ctrl+l\t\t:ターミナルの内容をクリア
ctrl+c\t\t:実行中のコマンドを終了
ctrl+r\t\t:コマンド履歴の検索
ctrl+insert\t:コピー
shift+insert\t:貼り付け
ctrl+d\t\t:ターミナルを強制終了
"'

# ------------------------------------------------------------------------------
# mysql-client
# ------------------------------------------------------------------------------
if test (command -v brew)
  if test (brew list | grep -c "^mysql-client@*.*\$") -gt 0
    set -x PATH (brew --prefix mysql-client)/bin $PATH
  end
end

# ------------------------------------------------------------------------------
# pre-commit
# ------------------------------------------------------------------------------
if test (command -v pre-commit)
  alias pcv="pre-commit -V"
  alias pci="pre-commit install --install-hooks"
  alias pcra="pre-commit run -a"
end

# ------------------------------------------------------------------------------
# openjdk
# ------------------------------------------------------------------------------
if test (command -v brew)
  if test (brew list | grep -c "^openjdk@*.*\$") -gt 0
    set -x PATH (brew --prefix openjdk@11)/bin $PATH
  end
end

# ------------------------------------------------------------------------------
# bat
# ------------------------------------------------------------------------------
if test (command -v bat)
  alias cat="bat"
end

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/home/tqer39/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# ------------------------------------------------------------------------------
# VS Code
# ------------------------------------------------------------------------------

# Remote Containers >> SSH
if test (string length -q -- $SSH_AUTH_SOCK)
  # Check for a currently running instance of the agent
  set RUNNING_AGENT "(ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]')"
  if test ($RUNNING_AGENT -eq 0)
    # Launch a new instance of the agent
    ssh-agent -s &> $HOME/.ssh/ssh-agent
  end
  eval (cat $HOME/.ssh/ssh-agent)
end

# ------------------------------------------------------------------------------
# Starship
# ------------------------------------------------------------------------------
# see https://starship.rs/ja-jp/guide/
# ※ 一番最後の行に設定が必要
starship init fish | source

echo "fish shell..."
