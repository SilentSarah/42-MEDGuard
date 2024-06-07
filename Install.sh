#!/bin/sh

echo "Installing 42_Session_Alert"

build_42_Session_Alert() {
	cat << EOF > 42_Session_Alert.py
import os
import time
import Quartz
import socket
import subprocess
import discord_webhook
from discord_webhook import DiscordWebhook

def DetectLock():
    d = Quartz.CGSessionCopyCurrentDictionary()
    return ('CGSSessionScreenIsLocked' in d.keys())

webhook = DiscordWebhook("$2")

hostname = socket.gethostname()
payload = "42 MEDGUARD has been initialized, starting monitor at: " + hostname + " for: <@$1>\n"
embed_payload = discord_webhook.DiscordEmbed(title="Initialization", description=payload, color="3ace1a")
webhook.add_embed(embed_payload)
webhook.execute()
webhook.remove_embed(0)


HALF_HOUR = 1500


# =======================================================

# Checking idle session

os.chdir('/Users/$USER/42_Alerts/')

sent_warning = 0
while 1:
    start_track = DetectLock()
    time.sleep(1)
    if (start_track == True):
        outtime = int(subprocess.check_output(["Watcher/sleepwatcher", "-g"])) / 10
        time.sleep(2.5)
        if int(outtime) >= HALF_HOUR:
            if sent_warning == 0:
                sent_warning = 1
                # Payload Data
                hostname = socket.gethostname()
                payload = "<@$1>" + "\nComputer: " + hostname + "\nDate: " + time.ctime(time.time()) + "\nWarning you've been logged out for more than 25 mins - you have 10 minutes grace period"
                embed_payload = discord_webhook.DiscordEmbed(title="Inactivity Warning", description=payload, color="dc143c")
                webhook.add_embed(embed_payload)
                response = webhook.execute()
                webhook.remove_embed(0)
        else:
            sent_warning = 0
# ========================================================
EOF

	cat << EOF > RUN_MONITOR.sh
#!/bin/bash
source ~/42_Alerts/DiscordEnv/bin/activate
python3 ~/42_Alerts/42_Session_Alert.py
EOF
	
}

read_user_input() {
	echo "Put your discord uid here (lookup this repo's github for more information)"
	read user_id
	echo "Put in your discord webhook link."
	read webhook_link
	echo "Are you sure the above information is correct? (y/n)"
	read user_ans
	if [ "$user_ans" = "y" ]
	then
		build_42_Session_Alert $user_id $webhook_link
        echo "Installing 42 MEDGUARD, Please Wait..."
		mkdir -p ~/42_Alerts
		cp -p 42_Session_Alert.py ~/42_Alerts
        cp -p RUN_MONITOR.sh ~/42_Alerts
        cp -pr Watcher ~/42_Alerts
        cp -pr DiscordEnv ~/42_Alerts
        pip3 install discord_webhook
        pip3 install selenium
        pip3 install pyobjc-framework-Quartz
        echo "The Monitor has been installed in your home directory, visit the github page back to continue with the guide."
		
	elif [ "$user_ans" = "n" ]
	then
		read_user_input
	else
		echo "Please choose the right answer next time."
		exit 1
	fi
}

read_user_input
