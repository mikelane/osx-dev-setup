#!/bin/bash

# Make a backup copy of .bash_profile
if [ -e "${HOME}/.bash_profile" ]; then
  echo 'Copying ~/.bash_profile to ~/.bash_profile.old ...'
  cp ${HOME}/.bash_profile ${HOME}/.bash_profile.old
fi

# Check for homebrew and install if not found
if test ! $(which brew); then
  echo '\nInstalling homebrew...'
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Creating freshbrew
echo -e '\nAdding in a one-stop homebrew update function.\nAfter this, you can use the command freshbrew to update homebrew and installs'
echo -e '\n# freshbrew. From the command prompt type freshbrew to update your homebrew and installed \n' >> ${HOME}/.bash_profile
echo -e '\nfreshbrew() {\n  brew update\n  brew upgrade\n  brew cleanup\n  brew prune\n  brew doctor\n}\n' >> ${HOME}/.bash_profile

# Sourcing the bash profile so that we can use freshbrew right away.
source ${HOME}/.bash_profile

# update and upgrade homebrew
echo "Ensuring homebrew is fully up to date..."
freshbrew

# Add in some other useful repos
echo "Tapping other useful repos..."
brew tap homebrew/dupes
brew tap caskroom/cask
brew tap homebrew/homebrew-php
brew tap homebrew/versions

# List of useful binaries.
binaries=(
  ack
  autoconf
  autojump
  bash
  bash-completion
  brew-cask
  brew-php-switcher
  cask
  colordiff
  composer
  coreutils
  emacs
  ffmpeg
  findutils
  gdbm
  git
  graphicsmagick
  grep
  htop-osx
  hub
  imagemagick
  lame
  libtiff
  libvo-aacenc
  mysql
  node
  php55
  php55-xdebug
  php56
  php56-xdebug
  python
  rename
  rlwrap
  sqlite
  tmux
  trash
  tree
  vim
  webkit2png
  wget
  x264
  xvid
  zopfli
)

# Install the previous binaries
echo -e '\nInstalling binaries...'
brew install ${binaries[@]}

# Add required lines to your ~/.bash_profile/
# Prepend local bin directory to your PATH to prefer Homebrew packages over system defaults
echo -e '\nMaking required ~/.bash_profile additions'
echo -e '\n# Homebrew bin dir path.' >> ${HOME}/.bash_profile
echo 'PATH="/usr/local/bin:$PATH"' >> ${HOME}/.bash_profile
echo -e 'OS X 10.8 and newer come with php-fpm pre-installed, to ensure you are \nusing the brew version you need to make sure /usr/local/sbin is before \n/usr/sbin in your PATH:' >> ${HOME}/.bash_profile
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

# Addition for hub
echo -e '\n# Add hub to command line' >> ${HOME}/.bash_profile
echo 'eval "$(hub alias -s)"' >> ${HOME}/.bash_profile

# Awesomizing the prompt
echo 'Awesomizing the terminal prompt...'
cp .git-prompt.sh ~/.git-prompt.sh
source ~/.git-prompt.sh
echo -e '\n# Make the prompt useful' >> ${HOME}/.bash_profile
echo 'export PS1="\[\e[34m\]\u\[\e[0m\]@\[\e[32m\]\h\[\e[0m\]:\[\e[33m\][\w]\[\e[36m\]$(__git_ps1 "{%s}")\[\e[0m\]\n<<\D{%F %T}>> \$"' >> ${HOME}/.bash_profile
echo 'export PS1="\u@\[\e[32m\]\h\[\e[0m\]:\W\[\e[36m\]$(__git_ps1 "{%s}")\[\e[0m\]\n \D{%F %T}\$ "' >> ${HOME}/.bash_profile

# Adding useful aliases
echo -e '\n# Useful Aliases' >> ${HOME}/.bash_profile
echo 'alias ls="ls -acFGgho"' >> ${HOME}/.bash_profile
echo 'alias root="cd ${HOME} && clear"' >> ${HOME}/.bash_profile

# for cut-and-paste purposes
# echo -e '' >> ${HOME}/.bash_profile
# echo '' >> ${HOME}/.bash_profile

# Sourcing the bash profile
source ${HOME}/.bash_profile

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
  atom
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

# Clean up our mess.
freshbrew
