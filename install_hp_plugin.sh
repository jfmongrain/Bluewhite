#!/bin/bash

# Install expect
dnf install -y expect

# Create an expect script
cat << 'EOF' > install_hp_plugin.exp
#!/usr/bin/expect

# Set the username and password
set username "dummy"
set password "dummy"  ;# Replace with the actual password

# Create the user if it doesn't exist
set user_exists [exec getent passwd $username]
if {[string equal $user_exists ""]} {
    # User does not exist, create it
    exec useradd -m -p [exec openssl passwd -1 $password] $username
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
