#!/bin/sh

run() {
    if ! pgrep -f "$1"; then
        "$@" &
    fi
}

run unclutter -root
run greenclip daemon
run udiskie
run mpd
run mpDris2
run nm-applet
run flameshot
run volctl
run xautolock -time 10 -locker 'i3lock-fancy-multimonitor -b=0x3'

# apps
run firefox
run emacs
run alacritty -e tmux new-session -A -s ArchLinux
run slack
run telegram-desktop
run pcmanfm
run obsidian
