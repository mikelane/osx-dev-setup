#!/bin/bash

# Check for homebrew and install if not found
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# update and upgrade homebrew
echo "Ensuring homebrew is fully up to date..."
brew update
brew upgrade --all

# Add in some other useful repos
echo "Tapping other useful repos..."
brew tap homebrew/dupes
brew tap caskroom/cask
brew tap homebrew/homebrew-php
brew tap homebrew/versions

# Add required lines to your ~/.bash_profile/
# Prepend local bin directory to your PATH to prefer Homebrew packages over system defaults
echo -e '\n# Homebrew bin dir path.' >> ${HOME}/.bash_profile
echo 'PATH=/usr/local/bin:\$PATH"' >> ${HOME}/.bash_profile
echo -e 'OS X 10.8 and newer come with php-fpm pre-installed, to ensure you are using the brew version you need to make sure /usr/local/sbin is before /usr/sbin in your PATH:' >> ${HOME}/.bash_profile
echo 'PATH="/usr/local/sbin:$PATH"' >> ${HOME}/.bash_profile

# coreutils
echo -e '\n# Use coreutils commands with regular bash names.' >> ${HOME}/.bash_profile
echo 'PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"' >> ${HOME}/.bash_profile
echo -e '\n# Add the coreutils MANPATH' >> ${HOME}/.bash_profile
echo 'MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"' >> ${HOME}/.bash_profile

# Add autojump
echo -e '\n# Use autojump' >> ${HOME}/.bash_profile
echo '[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh' >> ${HOME}/.bash_profile

# Add bash-completion
echo -e '\n# Use bash-completion' >> ${HOME}/.bash_profile
echo 'if [ -f $(brew --prefix)/etc/bash_completion ]; then' >> ${HOME}/.bash_profile
echo '  . $(brew --prefix)/etc/bash_completion' >> ${HOME}/.bash_profile
echo 'fi' >> ${HOME}/.bash_profile


echo -e '' >> ${HOME}/.bash_profile
echo '' >> ${HOME}/.bash_profile

# List of useful binaries.
binaries=(
  ack
  autojump
  bash
  bash-completion
  brew-cask
  brew-php-switcher
  cask
  colordiff
  composer
  coreutils
  ffmpeg
  findutils
  gdbm
  git
  graphicsmagick
  grep
  htop-osx
  hub
  imagemagick
  mysql
  node
  php55
  php55-xdebug
  php56
  php56-xdebug
  rename
  rlwrap
  sqlite
  trash
  tree
  unixodbc
  vim
  webkit2png
  wget
  zlib
  zopfli
)

# Install the previous binaries
echo "Installing binaries..."
brew install ${binaries[@]}

# List of useful apps to install using cask
apps=(
  alfred
  google-chrome
  caffeine
  iterm2
  dropbox
  flash
  phpstorm
  1password
  adium
  evernote
  textexpander
  firefox
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

# Clean up our mess.
brew cleanup
