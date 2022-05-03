#!/bin/bash

# fonts
if test paru; then
    aur_helper=paru
elif test yay; then
    aur_helper=yay
fi

$aur_helper -S --needed --noconfirm ttf-material-design-icons
sudo pacman -S --needed --noconfirm ttf-font-awesome pacman-contrib

