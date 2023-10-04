#!/bin/sh

# echo "Installing 42_Session_Alert"

# build_launchAgent() {
# 	cat << EOF >> 42_"$USER"_Session_alert.plist
# <?xml version="1.0" encoding="UTF-8"?>
# <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
# <plist version="1.0">
#   <dict>
#     <key>Label</key>
#     <string>42_session_alert</string>
#     <key>ProgramArguments</key>
#     <array>
#       <string>sh</string>
#       <string>-c</string>
#       <string>python3 </string>
# 	  <string>/Users/$USER/42_Alerts/42_Session_Alert.py </string>
#     </array>
#     <key>RunAtLoad</key>
#     <true/>
#     <key>UserName</key>
#     <string>$USER</string>
#   </dict>
# </plist>
# EOF
# }

# build_42_Session_Alert() {
# 	cat << EOF >> 42_"$USER"_Session_alert.plist
# import os
# import time
# import socket
# import requests
# import selenium
# from selenium import webdriver
# from selenium.webdriver.common.by import By
# from selenium.webdriver.chrome.options import Options
# from discord_webhook import DiscordWebhook

# # Grabbing Logtime, I know it's too much!
# chrome_options = Options()
# chrome_options.add_argument("--headless=new")
# driver = webdriver.Chrome(options=chrome_options)

# driver.get('http://logtime-med.1337.ma/')

# main = driver.find_element(By.ID, '__next')
# sub_main = main.find_element(By.CLASS_NAME, 'counter_homeP__mg2AR')
# form = sub_main.find_element(By.TAG_NAME, "form")
# login = form.find_element(By.NAME, "login").send_keys(os.getenv('USER'))
# form.find_element(By.TAG_NAME,'button').click()
# time.sleep(1)
# parent_elem = form.find_element(By.TAG_NAME, 'h3')
# sub_elements = parent_elem.find_elements(By.TAG_NAME, 'span')

# logtime = sub_elements[1].text
# driver.quit()
# # =======================================================

# # Payload Data
# hostname = socket.gethostname()
# payload = "<@$1>" + "\n\
# Computer: " + hostname + "\n\
# Date: " + time.ctime(time.time()) + "\n\
# Current Logged-in hours: " + logtime + "\n\
# Warning you've been logged out for more than 30 mins"
# # ========================================================

# # Checking idle session
# start_date = time.time()
# current_time = time.time()
# while current_time - start_date < 1800:
#     time.sleep(1800)
#     current_time = time.time()

# if current_time - start_date > 1800:
# 	webhook = DiscordWebhook("$2", content=payload)
# 	response = webhook.execute()
# # ========================================================
# EOF
# }

# read_user_input() {
# 	echo "Put your discord uid here (lookup this repo's github for more information)"
# 	read user_id
# 	echo "Put in your discord webhook link."
# 	read webhook_link
# 	echo "Are you sure the above information is correct? (y/n)"
# 	read user_ans
# 	if [ [ "$user_ans" = "y" || "$user_ans" = "yes" ] ]
# 	then
# 		build_42_Session_Alert $user_id $webhook_link
# 		build_launchAgent
# 		mkdir -p ~/42_Alerts
# 		cp -p 42_"$USER"_Session_alert.plist ~/Library/LaunchAgents
# 		cp -p 42_Session_Alert.py ~/42_Alerts
		
# 	elif [ [ "$user_ans" = "n" || "$user_ans" = "no" ] ]
# 	then
# 		read_user_input
# 	else
# 		echo "Please choose the right answer next time."
# 		exit 1
# 	fi
# }

# read_user_input