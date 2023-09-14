#! /bin/bash

pc=$(hostname)
update_output=$(sudo apt update 2>&1)

#check for updates
if [[ $(sudo apt update | grep -o '^[0-9]\+ packages can be upgraded') ]]; then
    echo "Updates are available. Proceeding with the update..."
    sudo apt upgrade -y
    sudo apt autoremove -y
    echo "System update completed."
        if [[ $update_output =~ "W: An error occurred" ]]; then
    echo "Error occurred during update."
    echo "$update_output"  # Print the error messages
    curl -d "Update error on machine $pc" https://noti.techtretas.dev/teste  # Send a notification
else
        curl -d "Feitos updates a maquina $pc" https://noti.techtretas.dev/teste ## envia push
       
 fi
else
    echo "No updates are available."
    curl -d "Maquina $pc sem updates" https://noti.techtretas.dev/teste
fi
