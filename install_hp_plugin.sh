#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Function to log messages
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Set default values for username and password
username="${1:-dummy}"
password="${2:-password}"  # Hardcoded password for the dummy user

log "Creating user $username..."
if ! useradd -G wheel -p "$(openssl passwd -1 "$password")" "$username"; then
    log "Failed to create user $username."
    exit 1
fi

log "Downloading the plugin files..."
if ! wget -q https://www.openprinting.org/download/printdriver/auxfiles/HP/plugins/hplip-3.24.4-plugin.run; then
    log "Failed to download the plugin file."
    exit 1
fi

if ! wget -q https://www.openprinting.org/download/printdriver/auxfiles/HP/plugins/hplip-3.24.4-plugin.run.asc; then
    log "Failed to download the .asc file."
    exit 1
fi

log "Installing expect and spawn using dnf5..."
if ! dnf5 install -y expect spawn; then
    log "Failed to install expect."
    exit 1
fi

# Create the expect script that runs hp-plugin as the dummy user
#!/usr/bin/expect

# Get the username and password from the command line arguments
set username [lindex $argv 0]
set password [lindex $argv 1]

# Run the hp-plugin command
#!/usr/bin/expect

# Get the username and password from the command line arguments
set username [lindex $argv 0]
set password [lindex $argv 1]

# Run the hp-plugin command as the specified user
spawn runuser -l $username -c "hp-plugin -p hplip-3.24.4-plugin.run"
expect {
    "Do you accept the license terms for the plug-in (y=yes*, n=no, q=quit) ?" {
        send "y\r"
        exp_continue
    }
    -re "ExpectedPrompt 2" {
        send "$password\r"
    }
}
expect eof

# Make the expect script executable
chmod +x install_hp_plugin.exp

# Run the expect script with the username and password as arguments
log "Running hp-plugin installation..."
if ! expect ./install_hp_plugin.exp "$username" "$password"; then
    log "Failed to run the hp-plugin installation."
    exit 1
fi

# Clean up: delete the expect script, the downloaded files, and remove the user
log "Cleaning up..."
rm -f install_hp_plugin.exp hplip-3.24.4-plugin.run hplip-3.24.4-plugin.run.asc
dnf5 remove -y expect spawn
if ! userdel "$username"; then
    log "Failed to remove user $username."
    exit 1
fi

log "User $username removed successfully."
