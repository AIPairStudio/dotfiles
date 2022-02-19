function fish_greeting
  echo ""
end

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

# ------------------------------------------------------------------------------
# pre-commit
# ------------------------------------------------------------------------------
if test (command -v pre-commit)
  alias pcv="pre-commit -V"
  alias pci="pre-commit install --install-hooks"
  alias pcra="pre-commit run -a"
end

# ------------------------------------------------------------------------------
# bat
# ------------------------------------------------------------------------------
if test (command -v bat)
  alias cat="bat"
end

# ------------------------------------------------------------------------------
# Starship
# ------------------------------------------------------------------------------
# see https://starship.rs/ja-jp/guide/
# ※ 一番最後の行に設定が必要
starship init fish | source
