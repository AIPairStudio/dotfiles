### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# zinit: plugins
# 入力補完
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# シンタックスハイライト
zinit light zdharma-continuum/fast-syntax-highlighting

# Control + R でコマンドの履歴をリスト表示
zinit light zdharma-continuum/history-search-multi-word
zinit load zdharma-continuum/history-search-multi-word

# brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)".

# asdf
. /home/linuxbrew/.linuxbrew/opt/asdf/asdf.sh

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit
fi

# Starship
eval "$(starship init zsh)"

# shortcut
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias dl='cd ~/Downloads'
alias d='cd ~/Desktop'
alias work='cd ~/workspace'

# exa
if [[ $(command -v exa) ]]; then
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
fi

# git
if [[ $(command -v git) ]]; then
  alias g='git'
  alias gb='git branch'
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
  alias gstt='git status'
  alias gsts='git stash'
  alias gsw='git switch'
  alias gl='git log --oneline'
  alias gbm='git branch --merged'
  alias gbm-all='git branch --merged|egrep -v "\*|develop|main"|xargs git branch' # -d で削除, -D で完全削除
fi

# shellcheck
if [[ $(command -v shellcheck) ]]; then
  alias sc='shellcheck'
  function schelp() {
    curl -s https://raw.githubusercontent.com/wiki/koalaman/shellcheck/"$1".md
  }
fi

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