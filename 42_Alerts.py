import os
import time
import socket
import requests
import selenium
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from discord_webhook import DiscordWebhook

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
payload = "<@326490884759748619>" + "\n\
Computer: " + hostname + "\n\
Date: " + time.ctime(time.time()) + "\n\
Current Logged-in hours: " + logtime + "\n\
Warning you've been logged out for more than 30 mins"
# ========================================================

# Checking idle session
start_date = time.time()
current_time = time.time()
while current_time - start_date < 1800:
    time.sleep(5)
    current_time = time.time()

if current_time - start_date > 1800:
	webhook = DiscordWebhook("https://discord.com/api/webhooks/1158403904816558191/Hp6n5E5u7vUSt_GVvu0_PdXEZCJXODVOUyyRZA_OeJslalDGA_Oy4ZbRBIxpeEucyiFW", content=payload)
	response = webhook.execute()
