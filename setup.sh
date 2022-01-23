#!/bin/bash

set -eu

_REPOSITORY=https://github.com/tqer39/dotfiles

main() {
  detect_os
  if [ "$_PLATFORM" == 'linux' -a "$_PLATFORM" == 'mac' ]; then
    detect_distribution
  fi

  if [ "$_PLATFORM" == 'linux' ]; then
    install_linux
  elif [ "$_PLATFORM" == 'mac' ]; then
    install_mac
  else
    abort 'このOSは対応していません'
  fi

  exit 0
}

abort() {
  printf "%s\n" "$@"
  exit 1
}

detect_os() {
  if [ "$(uname)" == "Darwin" ]; then
    _PLATFORM=mac
  elif [ "$(expr substr $(uname -s) 1 5)" == "MINGW" ]; then
    _PLATFORM=windows
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    _PLATFORM=linux
  else
    _PLATFORM="Unknown OS"
    abort "Your platform ($(uname -a)) is not supported."
  fi
}

detect_distribution() {
  if [ -e /etc/lsb-release ]; then
    _DISTRIBUTION=ubuntu
    _DISTRIBUTION_VERSION=$(cat /etc/os-release | grep UBUNTU_CODENAME= | cut -c 17-)
    echo $_DISTRIBUTION
    echo $_DISTRIBUTION_VERSION
  elif [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
    _DISTRIBUTION=debian
  elif [ -e /etc/redhat-release ]; then
    if [ -e /etc/oracle-release ]; then
      _DISTRIBUTION=oracle
    else
      _DISTRIBUTION=redhat
    fi
  elif [ -e /etc/fedora-release ]; then
    _DISTRIBUTION=fedora
  elif [ -e /etc/arch-release ]; then
    _DISTRIBUTION=arch
  else
    echo "Your distributio is not supported."
    _DISTRIBUTION="Unknown Distribution"
    exit 1
  fi
}

install_linux() {
  setup_dotfiles
}

install_mac() {
  setup_dotfiles
}

is_exists() {
  which "$1" >/dev/null 2>&1
  return $?
}

setup_dotfiles() {
  if [ ! -e $HOME/dotfiles ]; then
    if is_exists "git"; then
      git clone "${_REPOSITORY}.git" $HOME/dotfiles
    else
      cd $HOME/Downloads
      wget -O ./dotfiles.zip "${_REPOSITORY}/archive/main.zip"
      unzip ./dotfiles.zip
      rm -rf ./dotfiles.zip
      mv ./dotfiles-main $HOME/dotfiles
      cd
    fi
  fi

  DOTFILES=$(ls ./target -a1 | grep -v "\.$")

  for f in ${DOTFILES[@]}; do
    echo "ln -sf $HOME/dotfiles/$f $HOME/$f"
    ln -sf $HOME/dotfiles/target/$f $HOME/$f
  done
}

main