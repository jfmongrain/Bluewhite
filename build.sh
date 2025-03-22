#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# dnf5 install -y tmux 

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

# Enable COPR repos

dnf5 -y copr enable ilyaz/LACT
dnf5 -y copr enable pesader/hblock
      
# Install packages 

dnf5 -y install langpacks-core-fr
dnf5 -y install langpacks-fr
dnf5 -y install lact-libadwaita
dnf5 -y install hblock

# Remove packages

dnf5 -y remove ibus-hangul
dnf5 -y remove ibus-libpinyin
dnf5 -y remove ibus-anthy
dnf5 -y remove ibus-anthy-python
dnf5 -y remove ibus-m17n
dnf5 -y remove gnome-tour
dnf5 -y remove yelp
dnf5 -y remove solaar
dnf5 -y remove input-leap
dnf5 -y remove simple-scan
dnf5 -y remove gnome-system-monitor
dnf5 -y remove gnome-classic-session
dnf5 -y remove gnome-shell-extension-apps-menu
dnf5 -y remove gnome-shell-extension-logo-menu
dnf5 -y remove gnome-shell-extension-launch-new-instance
dnf5 -y remove gnome-shell-extension-places-menu
dnf5 -y remove gnome-shell-extension-appindicator
dnf5 -y remove gnome-shell-extension-dash-to-dock
dnf5 -y remove gnome-shell-extension-caffeine
dnf5 -y remove gnome-shell-extension-window-list
dnf5 -y remove gnome-shell-extension-blur-my-shell
dnf5 -y remove gnome-shell-extension-search-light
dnf5 -y remove gnome-shell-extension-user-theme
dnf5 -y remove nautilus-gsconnect
dnf5 -y remove gnome-shell-extension-gsconnect
dnf5 -y remove gnome-shell-theme-yaru
dnf5 -y remove yaru-sound-theme
dnf5 -y remove yaru-icon-theme
dnf5 -y remove yaru-gtksourceview-theme
dnf5 -y remove yaru-gtk4-theme
dnf5 -y remove yaru-gtk3-theme
dnf5 -y remove yaru-gtk2-theme
dnf5 -y remove yaru-theme
dnf5 -y remove gnome-shell-extension-tailscale-gnome-qs
dnf5 -y remove input-remapper

# Remove unused fonts

dnf5 -y remove google-noto-fonts-all
dnf5 -y remove google-noto-sans-mono-cjk-vf-fonts
dnf5 -y remove google-noto-serif-cjk-vf-fonts
dnf5 -y remove google-noto-naskh-arabic-vf-fonts
dnf5 -y remove google-noto-sans-arabic-vf-fonts
dnf5 -y remove google-noto-sans-armenian-vf-fonts
dnf5 -y remove google-noto-sans-bengali-vf-fonts
dnf5 -y remove google-noto-sans-canadian-aboriginal-vf-fonts
dnf5 -y remove google-noto-sans-cherokee-vf-fonts
dnf5 -y remove google-noto-sans-devanagari-vf-fonts
dnf5 -y remove google-noto-sans-ethiopic-vf-fonts
dnf5 -y remove google-noto-sans-georgian-vf-fonts
dnf5 -y remove google-noto-sans-gujarati-vf-fonts
dnf5 -y remove google-noto-sans-gurmukhi-vf-fonts
dnf5 -y remove google-noto-sans-hebrew-vf-fonts
dnf5 -y remove google-noto-sans-kannada-vf-fonts
dnf5 -y remove google-noto-sans-khmer-vf-fonts
dnf5 -y remove google-noto-sans-lao-vf-fonts
dnf5 -y remove google-noto-sans-meetei-mayek-vf-fonts
#dnf5 -y remove google-noto-sans-mono-vf-fonts
dnf5 -y remove google-noto-sans-ol-chiki-vf-fonts
dnf5 -y remove google-noto-sans-oriya-vf-fonts
dnf5 -y remove google-noto-sans-sinhala-vf-fonts
dnf5 -y remove google-noto-sans-symbols-2-fonts
dnf5 -y remove google-noto-sans-symbols-vf-fonts
dnf5 -y remove google-noto-sans-tamil-vf-fonts
dnf5 -y remove google-noto-sans-telugu-vf-fonts
dnf5 -y remove google-noto-sans-thaana-vf-fonts
dnf5 -y remove google-noto-sans-thai-vf-fonts
#dnf5 -y remove google-noto-sans-vf-fonts
dnf5 -y remove google-noto-serif-armenian-vf-fonts
dnf5 -y remove google-noto-serif-bengali-vf-fonts
dnf5 -y remove google-noto-serif-devanagari-vf-fonts
dnf5 -y remove google-noto-serif-ethiopic-vf-fonts
dnf5 -y remove google-noto-serif-georgian-vf-fonts
dnf5 -y remove google-noto-serif-gujarati-vf-fonts
dnf5 -y remove google-noto-serif-gurmukhi-vf-fonts
dnf5 -y remove google-noto-serif-hebrew-vf-fonts
dnf5 -y remove google-noto-serif-kannada-vf-fonts
dnf5 -y remove google-noto-serif-khmer-vf-fonts
dnf5 -y remove google-noto-serif-lao-vf-fonts
dnf5 -y remove google-noto-serif-oriya-vf-fonts
dnf5 -y remove google-noto-serif-sinhala-vf-fonts
dnf5 -y remove google-noto-serif-tamil-vf-fonts
dnf5 -y remove google-noto-serif-telugu-vf-fonts
dnf5 -y remove google-noto-serif-thai-vf-fonts
#dnf5 -y remove google-noto-serif-vf-fonts
dnf5 -y remove google-noto-sans-balinese-fonts
dnf5 -y remove google-noto-sans-cjk-fonts
dnf5 -y remove google-noto-sans-javanese-fonts
dnf5 -y remove google-noto-sans-sundanese-fonts
dnf5 -y autoremove

# Disable COPR repos

dnf5 -y copr disable ilyaz/LACT
dnf5 -y copr disable pesader/hblock

#### Example for enabling a System Unit File

# systemctl enable podman.socket
