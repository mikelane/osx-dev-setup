#!/bin/bash

# Make a backup copy of .bash_profile
if [ -e "${HOME}/.bash_profile" ]; then
  echo 'Moving ~/.bash_profile to ~/.bash_profile.old ...'
  mv ${HOME}/.bash_profile ${HOME}/.bash_profile.old
fi

echo -e '\n# Sourcing required files' >> ${HOME}/.bash_profile

# Make sure that the ~/.bashrc is sourced
echo -e '\n# Sourcing ~/.bashrc...'
echo -e 'if [ -f "${HOME}/.bashrc" ]; then\n  source "${HOME}/.bashrc"\nfi' >> ${HOME}/.bash_profile

# Make sure the ~/.bash_aliases is sourced
echo -e '\n# Sourcing ~/.bash_aliases...'
echo -e 'if [ -f "${HOME}/.bash_aliases" ]; then\n  source "${HOME}/.bash_aliases"\nfi' >> ${HOME}/.bash_profile

# Check for homebrew and install if not found
if test ! $(which brew); then
  echo '\nInstalling homebrew...'
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Creating freshbrew
echo -e '\n\nAdding in a one-stop homebrew update function.\nAfter this, you can use the command freshbrew to update homebrew and installs'
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
  composer
  python
  rbenv
  ruby-build
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
echo -e '\n# OS X 10.8 and newer come with php-fpm pre-installed, to ensure you are \n# using the brew version you need to make sure /usr/local/sbin is before \n# /usr/sbin in your PATH:' >> ${HOME}/.bash_profile
echo 'PATH="/usr/local/sbin:$PATH"' >> ${HOME}/.bash_profile
echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> ${HOME}/.bash_profile

# rbenv
echo -e '\n# rbenv (Ruby Environment)' >> ${HOME}/.bash_profile
echo -e 'if which rbenv > /dev/null; then\n  eval "$(rbenv init -)"\nfi\n' >> ${HOME}/.bash_profile

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
echo 'if [ -f $(brew --prefix)/etc/bash_completion ]; then\n  source $(brew --prefix)/etc/bash_completion\nfi' >> ${HOME}/.bash_profile

# Add the Git Prompt
echo -e '\n# Source the Git Prompt' >> ${HOME}/.bash_profile
echo -e '\nif [ -f `brew --prefix`/etc/bash_completion.d/git-prompt.sh ]; then\n  source `brew --prefix`/etc/bash_completion.d/git-prompt.sh\nfi' >> ${HOME}/.bash_profile

# Awesomizing the prompt
echo 'Awesomizing the terminal prompt...'
cp git-prompt.sh ~/.git-prompt.sh
source ~/.git-prompt.sh
echo -e '\n# Make the prompt useful' >> ${HOME}/.bash_profile
echo 'export PS1="\[\e[34m\]\u\[\e[0m\]@\[\e[32m\]\h\[\e[0m\]:\[\e[33m\][\w]\[\e[36m\]$(__git_ps1 "{%s}")\[\e[0m\]\n<<\D{%F %T}>> \$ "' >> ${HOME}/.bash_profile

# Setting globals
echo 'export RBENV_ROOT=/usr/local/var/rbenv' >> ${HOME}/.bash_profile
echo 'export XDEBUG_CONFIG="idekey=PHPSTORM1"' >> ${HOME}/.bash_profile
echo 'export TERM=xterm-color' >> ${HOME}/.bash_profile
echo 'export GREP_OPTIONS="--color=auto' GREP_COLOR='1;32"' >> ${HOME}/.bash_profile
echo 'export CLICOLOR=1' >> ${HOME}/.bash_profile
echo 'export LS_COLORS="di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rb=90"' >> ${HOME}/.bash_profile
echo 'export COLOR_NC="\\e[0m"' >> ${HOME}/.bash_profile
echo 'export COLOR_WHITE="\\e[1;37m"' >> ${HOME}/.bash_profile
echo 'export COLOR_BLACK="\\e[0;30m"' >> ${HOME}/.bash_profile
echo 'export COLOR_BLUE="\\e[0;34m"' >> ${HOME}/.bash_profile
echo 'export COLOR_LIGHT_BLUE="\\e[1;34m"' >> ${HOME}/.bash_profile
echo 'export COLOR_GREEN="\\e[0;32m"' >> ${HOME}/.bash_profile
echo 'export COLOR_LIGHT_GREEN="\\e[1;32m"' >> ${HOME}/.bash_profile
echo 'export COLOR_CYAN="\\e[0;36m"' >> ${HOME}/.bash_profile
echo 'export COLOR_LIGHT_CYAN="\\e[1;36m"' >> ${HOME}/.bash_profile
echo 'export COLOR_RED="\\e[0;31m"' >> ${HOME}/.bash_profile
echo 'export COLOR_LIGHT_RED="\\e[1;31m"' >> ${HOME}/.bash_profile
echo 'export COLOR_PURPLE="\\e[0;35m"' >> ${HOME}/.bash_profile
echo 'export COLOR_LIGHT_PURPLE="\\e[1;35m"' >> ${HOME}/.bash_profile
echo 'export COLOR_BROWN="\\e[0;33m"' >> ${HOME}/.bash_profile
echo 'export COLOR_YELLOW="\\e[1;33m"' >> ${HOME}/.bash_profile
echo 'export COLOR_GRAY="\\e[0;30m"' >> ${HOME}/.bash_profile
echo 'export COLOR_LIGHT_GRAY="\\e[0;37m"' >> ${HOME}/.bash_profile

# Adding useful aliases
echo -e '\n# Useful Aliases' >> ${HOME}/.bash_aliases
echo 'alias ls="ls -acFGgho"' >> ${HOME}/.bash_aliases
# echo 'alias gs="git status"' >> ${HOME}/.bash_aliases
# echo 'alias ga="git add"' >> ${HOME}/.bash_aliases
# echo 'alias gb="git branch"' >> ${HOME}/.bash_aliases
# echo 'alias gc="git commit"' >> ${HOME}/.bash_aliases
# echo 'alias gd="git diff"' >> ${HOME}/.bash_aliases
# echo 'alias go="git checkout"' >> ${HOME}/.bash_aliases
# echo 'alias gk="gitk --all&"' >> ${HOME}/.bash_aliases
# echo 'alias gx="gitx --all"' >> ${HOME}/.bash_aliases
# echo 'alias got="git"' >> ${HOME}/.bash_aliases
# echo 'alias get="git"' >> ${HOME}/.bash_aliases

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
# echo "installing apps..."
# brew cask install --appdir="/Applications" ${apps[@]}

# Clean up our mess.
freshbrew

# Set up better Mac settings
eval bash improved_defaults.sh
