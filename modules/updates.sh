#!/usr/bin/env bash
pkg_updates() {
  updates=$(pacman -Qu | wc -l)
  aurupdates=$(paru -Qua | wc -l)
  updates=$((updates + aurupdates))
  if [ $updates -gt 0 ]; then
    echo -n "  $updates"
  fi
}
pkg_updates
