#!/bin/bash

# Create user
useradd -m -p $(echo "dummy" | openssl passwd -1 -stdin) dummy > /dev/null 2>&1

# Add the user to the sudoers group (assuming the group is 'wheel' for Fedora)
usermod -aG wheel dummy

# Allow the dummy user to run hp-plugin without a password
echo "dummy ALL=(ALL) NOPASSWD: /usr/bin/hp-plugin" >> /etc/sudoers

# Install expect
dnf5 install -y expect

# Create an expect script
cat << 'EOF' > install_hp_plugin.exp
#!/usr/bin/expect

# Set a timeout for expect commands
set timeout 10

# Download the plugin .run file
exec wget https://www.openprinting.org/download/printdriver/auxfiles/HP/plugins/hplip-3.24.4-plugin.run
exec wget https://www.openprinting.org/download/printdriver/auxfiles/HP/plugins/hplip-3.24.4-plugin.run.asc

# Run the hp-plugin command
spawn runuser -u dummy -- sh -c "hp-plugin -p hplip-3.24.4-plugin.run"

# Log all output to the console
log_user 1

# Handle the license agreement prompt
expect {
    "Do you accept the license terms for the plug-in (y=yes*, n=no, q=quit) ?" {
        send "y\r"
        exp_continue
    }
    "Please enter the sudoer (dummy)'s password:" {
        sleep 1  ;# Add a delay before sending the password
        send "dummy\r"
    }
    timeout {
        puts "Error: Prompt not found."
        exit 1
    }
}

# Wait for the end of the command
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
