#!/bin/bash

set -ouex pipefail

# Enable COPR repos

dnf5 -y copr enable pesader/hblock

# Remove packages

dnf5 -y remove \
libpinyin \
ibus-libpinyin \
ibus-typing-booster \
ibus-anthy \
ibus-anthy-python \
ibus-m17n \
ibus-hangul \
gnome-tour \
gnome-shell-extension-logo-menu \
gnome-shell-extension-appindicator \
gnome-shell-extension-dash-to-dock \
gnome-shell-extension-caffeine \
gnome-shell-extension-blur-my-shell \
gnome-shell-extension-search-light \
gnome-shell-extension-gsconnect \
gnome-shell-extension-apps-menu \
gnome-shell-extension-launch-new-instance \
gnome-shell-extension-places-menu \
gnome-shell-extension-user-theme \
gnome-shell-extension-window-list \
gnome-shell-extension-tailscale-gnome-qs \
gtk-murrine-engine \
yaru-gtk2-theme \
yaru-sound-theme \
yaru-icon-theme \
yaru-gtksourceview-theme \
yaru-gtk4-theme \
yaru-gtk3-theme \
gnome-shell-theme-yaru \
gnome-system-monitor \
input-remapper \
firewall-config

# Remove unused fonts

dnf5 -y remove \
google-noto-sans-mono-cjk-vf-fonts \
google-noto-serif-cjk-vf-fonts \
google-noto-naskh-arabic-vf-fonts \
google-noto-sans-arabic-vf-fonts \
google-noto-sans-armenian-vf-fonts \
google-noto-sans-bengali-vf-fonts \
google-noto-sans-canadian-aboriginal-vf-fonts \
google-noto-sans-cherokee-vf-fonts \
google-noto-sans-devanagari-vf-fonts \
google-noto-sans-ethiopic-vf-fonts \
google-noto-sans-georgian-vf-fonts \
google-noto-sans-gujarati-vf-fonts \
google-noto-sans-gurmukhi-vf-fonts \
google-noto-sans-hebrew-vf-fonts \
google-noto-sans-kannada-vf-fonts \
google-noto-sans-khmer-vf-fonts \
google-noto-sans-lao-vf-fonts \
google-noto-sans-meetei-mayek-vf-fonts \
google-noto-sans-ol-chiki-vf-fonts \
google-noto-sans-oriya-vf-fonts \
google-noto-sans-sinhala-vf-fonts \
google-noto-sans-symbols-2-fonts \
google-noto-sans-symbols-vf-fonts \
google-noto-sans-tamil-vf-fonts \
google-noto-sans-telugu-vf-fonts \
google-noto-sans-thaana-vf-fonts \
google-noto-sans-thai-vf-fonts \
google-noto-serif-armenian-vf-fonts \
google-noto-serif-bengali-vf-fonts \
google-noto-serif-devanagari-vf-fonts \
google-noto-serif-ethiopic-vf-fonts \
google-noto-serif-georgian-vf-fonts \
google-noto-serif-gujarati-vf-fonts \
google-noto-serif-gurmukhi-vf-fonts \
google-noto-serif-hebrew-vf-fonts \
google-noto-serif-kannada-vf-fonts \
google-noto-serif-khmer-vf-fonts \
google-noto-serif-lao-vf-fonts \
google-noto-serif-oriya-vf-fonts \
google-noto-serif-sinhala-vf-fonts \
google-noto-serif-tamil-vf-fonts \
google-noto-serif-telugu-vf-fonts \
google-noto-sans-sundanese-fonts \
google-noto-sans-javanese-fonts \
google-noto-sans-cjk-fonts \
google-noto-sans-balinese-fonts \
google-noto-serif-thai-vf-fonts

# Install packages 

dnf5 -y install \
langpacks-core-fr \
langpacks-fr \
simple-scan \
hblock

# Install latest Zorin icon theme

git clone https://github.com/ZorinOS/zorin-icon-themes.git
mv zorin-icon-themes/Zorin /usr/share/icons
rm -r zorin-icon-themes

# Disable COPR repos

dnf5 -y copr disable pesader/hblock

# Enable System Unit Files for HP printer

systemctl enable hp-plugin-install
