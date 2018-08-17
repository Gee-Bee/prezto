#
# Displays installation information for not found commands.
#
# Authors:
#   Joseph Jon Booker <joe@neoturbine.net>
#   Indrajit Raychaudhuri <irc+code@indrajit.com>
#

# Load command-not-found on Debian-based distributions.
if [[ -s '/etc/zsh_command_not_found' ]]; then
  source '/etc/zsh_command_not_found'
  # Load command-not-found on Arch Linux-based distributions.
elif [[ -s '/usr/share/doc/pkgfile/command-not-found.zsh' ]]; then
  source '/usr/share/doc/pkgfile/command-not-found.zsh'
# Fedora command-not-found support
elif [ -f /usr/libexec/pk-command-not-found ]; then
  command_not_found_handler () {
    runcnf=1
    retval=127
    [ ! -S /var/run/dbus/system_bus_socket ] && runcnf=0
    [ ! -x /usr/libexec/packagekitd ] && runcnf=0
    if [ $runcnf -eq 1 ]
      then
      /usr/libexec/pk-command-not-found $@
      retval=$?
    fi
    return $retval
  }
  # Return if requirements are not found.
# Load command-not-found on Mac OS X when homebrew tap is configured.
elif (( $+commands[brew] )) && brew command command-not-found-init > /dev/null 2>&1; then
  eval "$(brew command-not-found-init)"
# Load command-not-found on macOS when homebrew tap is configured.
elif [[ -s '/usr/local/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh' ]]; then
  source '/usr/local/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh'
# Return if requirements are not found.
else
  return 1
fi
