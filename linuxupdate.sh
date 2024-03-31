#! /bin/bash

pc=$(hostname)
update_output=$(sudo apt update )
upgrade_output=$(sudo sudo apt upgrade -y )

#check for updates
if [[ $(sudo apt update | grep -o '^[0-9]\+ packages can be upgraded') ]]; then
    sudo apt upgrade -y
    sudo apt -f install -y
    sudo apt autoremove -y
    #echo "parte1"

    if [[ $update_output =~ "W:" ]]; then # Check warnings
        #echo "$update_output"  # Print the error messages
        #curl -d "Updates with warnings on machine $pc" https://noti.techtretas.dev/alerts  # Send a notification
        echo "Updates with warnings"
    elif [[ $upgrade_output =~ "The following " ]]; then # Check not upgraded
        #echo "$upgrade_output"  # Print the error messages
        #curl -d "Upgrade needed on machine $pc" https://noti.techtretas.dev/alerts  # Send a notification 
        echo "Upgrades needed"
    elif [[$upgrade_output != "The following " | $update_output != "W:" ]]; then 
        #curl -d "Updates OK on machine $pc" https://noti.techtretas.dev/alerts
        echo "Updates are OK"
    fi
else
    echo "No updatess available"
    #curl -d "Machine $pc without updates" https://noti.techtretas.dev/alerts # Send a notification
fi
