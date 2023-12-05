# Welcome to 42-MedGuard

> Your soon to be friend, it'll watch your back and let you know when your session is about to be logged out

**Warning: this monitoring kit will only work for 1337 MED or 42 MED and probably won't work elsewhere.**

### Pre-requisites:

* [Selenium](https://pypi.org/project/selenium/)
* [Discord_Webhook](https://pypi.org/project/discord-webhook/)

### How does it work:

- **42-MEDGUARD** works by checking for inactivity from the user, once a threshold has been reached it will fire up letting the user know that the session is about to log out, included is the total amount of logged hours and the hostname of that MAC with the date, the monitor will reset once an activity has been detected.

### Installation:

- **Before setting up the monitoring kit we have acquire some info - FYI: these steps will be done only once.**
- First: you have to create a discord server the following video link should illustrate the process behind it.
- [VIDEO: Making the server](https://i.imgur.com/MfWDWH3.mp4)
- Second: you have to make a webhook for the server that you just created and save somewhere it.
- [VIDEO: Webhook Creation](https://i.imgur.com/RAoMfUC.mp4)
- Third: you have to get your own UID (User ID) and save it next to the webhook saved earlier
- [VIDEO: Acquiring UID](https://i.imgur.com/o860PVn.mp4)
- **Now onto script setup part:**
- Clone this repo anywhere in your session.
- Execute the **Install.sh** script with the following command:

  ```shell
  bash Install.sh
  ```
- It will produce two files. One is called **42_Session_Alert.py** and the other is **RUN_MONITOR.sh**.
  the install script will copy them for you into a new directory called **42_Alerts** inside your home directory.
- **Setting the script for it be loaded at log in**
- First: Open up automator and choose application and then type in the search bar 'Run shell script' and fill the prompt with the following command ``bash ~/42_Alerts/RUN_MONITOR.sh``
- [VIDEO: Creation of the 42_MEDGUARD](https://i.imgur.com/sxBNjLh.mp4)
- Second copy the newly created app to the **42_Alerts** folder inside your home directory.
- Lastly open system preferences (settings) and search for **Login items**. click on the small plus sign under the list and look for the app you created before using automator.
- [VIDEO: Setting 42_MEDGUARD to run at login](https://i.imgur.com/58m3sSd.mp4)
- Log out and log back in and BAM! now you have the monitor ready and it will let you know whenever your session is about to log out.
  **Enjoy!**

  ### UPDATES:
  **BETA-001**: Monitor will start counting after the session becomes locked.
