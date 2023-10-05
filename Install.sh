#!/bin/sh

echo "Installing 42_Session_Alert"


build_42_Session_Alert() {
	cat << EOF > 42_Session_Alert.py
import os
import time
import socket
import subprocess
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from discord_webhook import DiscordWebhook


HALF_HOUR = 1800

# Grabbing Logtime, I know it's too much!
chrome_options = Options()
chrome_options.add_argument("--headless=new")
driver = webdriver.Chrome(options=chrome_options)

driver.get('http://logtime-med.1337.ma/')

main = driver.find_element(By.ID, '__next')
sub_main = main.find_element(By.CLASS_NAME, 'counter_homeP__mg2AR')
form = sub_main.find_element(By.TAG_NAME, "form")
login = form.find_element(By.NAME, "login").send_keys(os.getenv('USER'))
form.find_element(By.TAG_NAME,'button').click()
time.sleep(1)
parent_elem = form.find_element(By.TAG_NAME, 'h3')
sub_elements = parent_elem.find_elements(By.TAG_NAME, 'span')

logtime = sub_elements[1].text
driver.quit()
# =======================================================

# Payload Data
hostname = socket.gethostname()
payload = "<@$1>" + "\nComputer: " + hostname + "\nDate: " + time.ctime(time.time()) + "\nCurrent Logged-in hours: " + logtime + "\nWarning you've been logged out for more than 30 mins"
# ========================================================

# Checking idle session

os.chdir('/Users/hmeftah/42_Alerts/')

sent_warning = 0
while 1:
    outtime = int(subprocess.check_output(["Watcher/sleepwatcher", "-g"])) / 10
    time.sleep(2.5)
    if int(outtime) >= HALF_HOUR:
        if sent_warning == 0:
            sent_warning = 1
            webhook = DiscordWebhook("$2", content=payload)
            response = webhook.execute()
    else:
        sent_warning = 0
    print(int(outtime))
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
		mkdir -p ~/42_Alerts
		cp -p 42_Session_Alert.py ~/42_Alerts
        cp -p RUN_MONITOR.sh ~/42_Alerts
        cp -pr Watcher ~/42_Alerts
        cp -pr DiscordEnv ~/42_Alerts
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