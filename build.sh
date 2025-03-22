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
#- https://mega.nz/linux/repo/Fedora_%OS_VERSION%/megasync-fedora-%OS_VERSION%.repo
      
# Install packages 

dnf5 -y install langpacks-core-fr
dnf5 -y install langpacks-fr
dnf5 -y install lact-libadwaita
dnf5 -y install hblock
#- megasync

# Remove packages

dnf5 -y uninstall ibus-hangul
dnf5 -y uninstall ibus-libpinyin
dnf5 -y uninstall ibus-anthy
dnf5 -y uninstall ibus-anthy-python
dnf5 -y uninstall ibus-m17n
dnf5 -y uninstall gnome-tour
dnf5 -y uninstall yelp
dnf5 -y uninstall solaar
dnf5 -y uninstall input-leap
dnf5 -y uninstall simple-scan
dnf5 -y uninstall gnome-system-monitor
      #- gnome-classic-session
      #- gnome-shell-extension-apps-menu
      #- gnome-shell-extension-logo-menu
      #- gnome-shell-extension-launch-new-instance
      #- gnome-shell-extension-places-menu
dnf5 -y uninstall gnome-shell-extension-appindicator
dnf5 -y uninstall gnome-shell-extension-dash-to-dock
dnf5 -y uninstall gnome-shell-extension-caffeine
      #- gnome-shell-extension-window-list
dnf5 -y uninstall gnome-shell-extension-blur-my-shell
dnf5 -y uninstall gnome-shell-extension-search-light
dnf5 -y uninstall gnome-shell-extension-user-theme
dnf5 -y uninstall nautilus-gsconnect
dnf5 -y uninstall gnome-shell-extension-gsconnect
dnf5 -y uninstall gnome-shell-theme-yaru
dnf5 -y uninstall yaru-sound-theme
dnf5 -y uninstall yaru-icon-theme
dnf5 -y uninstall yaru-gtksourceview-theme
dnf5 -y uninstall yaru-gtk4-theme
dnf5 -y uninstall yaru-gtk3-theme
dnf5 -y uninstall yaru-gtk2-theme
dnf5 -y uninstall yaru-theme
dnf5 -y uninstall gnome-shell-extension-tailscale-gnome-qs
dnf5 -y uninstall input-remapper
dnf5 -y uninstall google-noto-fonts-all

# Disable COPR repos

dnf5 -y copr disable ilyaz/LACT
dnf5 -y copr disable pesader/hblock

#### Example for enabling a System Unit File

# systemctl enable podman.socket
