#!/bin/bash

log "Downloading the plugin files..."
if ! wget -q https://www.openprinting.org/download/printdriver/auxfiles/HP/plugins/hplip-3.24.4-plugin.run; then
    log "Failed to download the plugin file."
    exit 1
fi

log "Installing expect dnf5..."
if ! dnf5 install -y expect; then
    log "Failed to install expect."
    exit 1
fi

# Create the expect script that runs the temporary script as the dummy user
cat > install_hp_plugin.exp <<EOF
#!/usr/bin/expect

spawn sh hplip-3.24.4-plugin.run --target /usr/share/hplip/
expect {
    "Do you accept the license terms for the plug-in (y=yes*, n=no, q=quit) ?" {
        sleep 1  ;# Add a delay of 1 second before sending the response
        send "y\r"
        exp_continue
    }
}
expect eof
EOF

# Make the expect script executable
chmod +x install_hp_plugin.exp

# Run the expect script
expect ./install_hp_plugin.exp

# Clean up: delete the expect script, the temporary script, the downloaded files, and remove the user
log "Cleaning up..."
rm -f install_hp_plugin.exp hplip-3.24.4-plugin.run
dnf5 remove -y expect
