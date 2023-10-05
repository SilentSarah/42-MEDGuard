# Welcome to 42-MedGuard

> Your soon to be friend, it'll watch your back and let you know when your session is about to be logged out
> 
**Warning: this monitoring kit will only work for 1337 MED or 42 MED and probably won't work elsewhere.**

### Installation:
- **Before setting up the monitoring kit we have acquire some info**
-	First: you have to create a discord server the following video link should illustrate the process behind it.
[Making the server](https://i.imgur.com/MfWDWH3.mp4)

- Second: you have to make a webhook for the server that you just created and save somewhere it.
[Webhook Creation](https://i.imgur.com/RAoMfUC.mp4)

- Third: you have to get your own UID (User ID) and save it next to the webhook saved earlier
[Acquiring UID](https://i.imgur.com/o860PVn.mp4)

- **Now into script setup part:**
-	Clone this repo anywhere in your session.
-	Execute the **Install.sh** script with the following command:
	```shell
	bash Install.sh
	```
- It will produce two files. One is called **42_Session_Alert.py** and the other is **RUN_MONITOR.sh**.
and copies them into your home dir, you can delete the repo after.

- **Setting the script for it be loaded at log in**
- First: Open up automator and choose application and then type in the search bar 'Run shell script' and fill the prompt with the following command ```bash ~/42_Alerts/RUN_MONITOR.sh```
[Creation of the 42_MEDGUARD](https://i.imgur.com/sxBNjLh.mp4)
- Second copy the newly created app to the **42_Alerts** folder inside your home directory.
- Lastly open settings and search for **Login items**. click on the small plus sign under the list and look for the app you created before using automator.
- Log out and BAM! you now have the monitor ready and will let you know whenever your session is about to log out.
**Enjoy!**