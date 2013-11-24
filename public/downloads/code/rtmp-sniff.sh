#!/bin/bash

# Bash script for managing the iptable rule for use with rtmpsrv
## PND4
## o1.27.13

success() {
  echo ".. success :)"
}

failure() {
  echo "-- FAILURE :("
}

add-rule() {
  sudo iptables -t nat -A OUTPUT -p tcp --dport 1935 -j REDIRECT
}

del-rule() {
  sudo iptables -t nat -D OUTPUT -p tcp --dport 1935 -j REDIRECT
}

case "$1" in
  start)
    echo "Starting.."
    # also delete rule if it exists for some reason to avoid dupes.
    # always errors out so we ignore it
    del-rule 2>/dev/null
    add-rule
    [ $? -eq 0 ] && success || failure
    ;;
  stop)
    echo "Stopping.."
    del-rule
    [ $? -eq 0 ] && success || failure
    ;;
  *)
    echo "Usage: $0 <start|stop>"
    ;;
esac
