#!/bin/bash

# Install expect
dnf install -y expect

# Create an expect script
cat << 'EOF' > install_hp_plugin.exp
#!/usr/bin/expect

# Set the username and password
set username "dummy"
set password "dummy"  ;# Replace with the actual password

# Check if the user exists
set user_exists [catch {exec id $username} result]
if {$user_exists} {
    # User does not exist, create it without a mailbox
    exec useradd -M -p [exec openssl passwd -1 $password] $username
    puts "User $username created."
} else {
    puts "User $username already exists."
}

# Download the plugin .run file
exec wget https://www.openprinting.org/download/printdriver/auxfiles/HP/plugins/hplip-3.24.4-plugin.run
exec wget https://www.openprinting.org/download/printdriver/auxfiles/HP/plugins/hplip-3.24.4-plugin.run.asc

# Run the hp-plugin command
spawn runuser -u $username -- sh -c "echo 'y' | hp-plugin -p hplip-3.24.4-plugin.run"
expect "Password:"
send "$password\r"
expect eof

# Clean up: remove downloaded files
exec rm -f hplip-3.24.4-plugin.run hplip-3.24.4-plugin.run.asc

# Uninstall expect
exec dnf remove -y expect

# Remove the dummy user
exec userdel -r $username
puts "User $username removed."
EOF

# Make the expect script executable
chmod +x install_hp_plugin.exp

# Run the expect script
./install_hp_plugin.exp

# Clean up: remove the expect script after execution
rm -f install_hp_plugin.exp
