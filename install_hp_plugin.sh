#!/bin/bash

wget -q https://www.openprinting.org/download/printdriver/auxfiles/HP/plugins/hplip-3.24.4-plugin.run

echo "y" | sh hplip-3.24.4-plugin.run --target /usr/share/hplip/

rm -f hplip-3.24.4-plugin.run
dnf5 remove -y expect
