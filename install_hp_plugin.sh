#!/bin/bash

# Create user
useradd -m -p $(echo "dummy" | openssl passwd -1 -stdin) dummy > /dev/null 2>&1

# Install expect
dnf5 install -y expect

# Create an expect script
cat << 'EOF' > install_hp_plugin.exp
#!/usr/bin/expect

# Download the plugin .run file
exec wget https://www.openprinting.org/download/printdriver/auxfiles/HP/plugins/hplip-3.24.4-plugin.run
exec wget https://www.openprinting.org/download/printdriver/auxfiles/HP/plugins/hplip-3.24.4-plugin.run.asc

# Run the hp-plugin command
spawn runuser -u dummy -- sh -c "echo 'y' | hp-plugin -p hplip-3.24.4-plugin.run"
expect "Please enter the root/superuser password:"
send "dummy\r"
expect eof

# Clean up: remove downloaded files
exec rm -f hplip-3.24.4-plugin.run hplip-3.24.4-plugin.run.asc
EOF

# Make the expect script executable
chmod +x install_hp_plugin.exp

# Run the expect script
./install_hp_plugin.exp

# Clean up: remove the expect script after execution
rm -f install_hp_plugin.exp

# Uninstall expect
dnf5 remove -y expect

# Remove the dummy user
userdel -r dummy
echo "User dummy removed."
