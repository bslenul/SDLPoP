#!/bin/sh -e

self="$(readlink -f "$0")"
name="$(basename "$self" .sh)"
cdir="$(dirname "$self")"
code="$(basename "$cdir")"

cd "$cdir/$name"
[ -f "/var/saves/$code/save.sram" ] || touch "/var/saves/$code/save.sram"
[ -f "/var/saves/$code/SDLPoP.ini" ] || cp "def-SDLPoP.ini" "/var/saves/$code/SDLPoP.ini"
[ -f "SDLPoP.ini" ] || touch "SDLPoP.ini"
mount -o bind "/var/saves/$code/SDLPoP.ini" "SDLPoP.ini"
[ -f "/var/saves/$code/QUICKSAVE.SAV" ] || touch "/var/saves/$code/QUICKSAVE.SAV"
[ -f "QUICKSAVE.SAV" ] || touch "QUICKSAVE.SAV"
mount -o bind "/var/saves/$code/QUICKSAVE.SAV" "QUICKSAVE.SAV"
[ -x "$name" ] || chmod +x "$name"
HOME="/var/saves/$code" exec "./$name" &
wait "$!"
mount | grep -F "SDLPoP.ini" && umount "SDLPoP.ini"
mount | grep -F "QUICKSAVE.SAV" && umount "QUICKSAVE.SAV"
