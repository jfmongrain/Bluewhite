FROM ghcr.io/ublue-os/bluefin:lts-testing

## Other possible base images include:
# FROM ghcr.io/ublue-os/bazzite-gnome:latest
# FROM ghcr.io/ublue-os/bluefin-nvidia:stable
# 
# ... and so on, here are more base images
# Universal Blue Images: https://github.com/orgs/ublue-os/packages
# Fedora base image: quay.io/fedora/fedora-bootc:41
# CentOS base images: quay.io/centos-bootc/centos-bootc:stream10

### MODIFICATIONS
## make modifications desired in your image and install packages by modifying the build.sh script
## the following RUN directive does all the things required to run "build.sh" as recommended.

COPY build.sh /tmp/build.sh
COPY webcore-fonts-3.0-1.noarch.rpm /webcore-fonts-3.0-1.noarch.rpm
COPY webcore-fonts-vista-3.0-1.noarch.rpm /webcore-fonts-vista-3.0-1.noarch.rpm
#COPY hplip-plugin-latest-1.x86_64.rpm /hplip-plugin-latest-1.x86_64.rpm
COPY system_files/ /

RUN rm /usr/share/applications/system-update.desktop
RUN rm /usr/share/applications/documentation.desktop
RUN rm /usr/share/applications/discourse.desktop

RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh && \
    ostree container commit
    
