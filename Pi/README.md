# Install the RaspberryPi Imager

Raspberry Pi Imager is the quick and easy way to install Raspberry Pi OS and other operating systems to a microSD card, ready to use with your Raspberry Pi.

Download the Appropriate Imager for your workstation (not the Pi). 

[MAC](https://downloads.raspberrypi.org/imager/imager_1.6.2.dmg)<br>
[Ubuntu_x86](https://downloads.raspberrypi.org/imager/imager_1.6.2_amd64.deb)<br>
[Windows](https://downloads.raspberrypi.org/imager/imager_1.6.2.exe)<br>
RaspberryPi: type `sudo apt install rpi-imager` in a Terminal window.


Then watch [45 second video](https://youtu.be/ntaXWS8Lk34) to learn how to install an operating system using Raspberry Pi Imager

Install Raspberry Pi Imager to a workstation with an SD card reader. Put the SD card you'll use with your Raspberry Pi into the reader and run Raspberry Pi Imager.

![alt text][Imager]

[Imager]: /Images/Imager.png "Raspberry Pi Imager"

[ImageZip]: /Images/ImageZip.png "Raspberry Pi Image Zip file"

[ImageFile]: /Images/ImageFile.png "Raspberry Pi Image file"

[UseCustom]: /Images/UseCustom.png "Select Custom Image file"

[PickSDCard]: /Images/PickSDCard.png "Select SD Card on Workstation"

[ReadyToWrite]: /Images/ReadyToWrite.png "Click the Write button"

[Warning]: /Images/Warning.png "Be sure!"

[Eject]: /Images/Eject.png "Remove the SD Card!"

[NewHostID]: /Images/NewHostID.png "Click the Write button"

# Download 64 bit Raspberry OS Lite
We are going to use a 64 bit version of Rasperry OS, which is not available as a selection from the imager. So we start by navigating to [Raspberry OS Lite for ARM64 Images](https://downloads.raspberrypi.org/raspios_lite_arm64/images/). Then download the newest zip file.
At the time of this writing, the latest build was [dated May 5th, 2021](https://downloads.raspberrypi.org/raspios_lite_arm64/images/raspios_lite_arm64-2021-05-28/2021-05-07-raspios-buster-arm64-lite.zip). ![alt text][ImageZip] 
It is unclear how often there will be 64 bit builds.

Unzip after download is complete, which is a .img file. ![alt text][ImageFile]

In the imager, choose **Use Custom** for Operating System, then select the .img file from above.
![alt text][UseCustom]

Insert an SD card in your workstation, and be sure to select the correct storage device. ![alt text][PickSDCard]
![alt text][ReadyToWrite]
Click the [WRITE] button when you are ready.

(**CAUTION** - you pick the wrong storage device, I hope you have backup!)
![alt text][Warning]
Click the [YES] button, if you are sure, and go have a cup of coffee. It will take a few minutes.

When it's done, it ejects the sdcard, so you will have to un-plug it, and then re-plug the SD card back into your workstation (don't use your Pi yet!)
![alt text][Eject]

## Enable WiFi
Set up your WiFi by copying the file [wpa_supplicant.conf](/Pi/wpa_supplicant.conf) to the /Volumes/boot/wpa_supplicant.conf (sd card) and then edit the file, replacing the <> values with your WiFi name (SSID) and password.

## Enable SSH
Create an empty file called ssh on the sd card.
```
touch /Volumes/boot/ssh
```
This enables the ssh protocol on the RaspberryPi, which is good, because there is no monitor on this Pi.

# Boot your new Raspberry Pi!
Eject the SD Card from your PC, and plug it into the Pi

If you have an HDMI monitor we recommend connecting it so you can see that the Pi is booting OK

Plug in power to the Pi - you will see the green LED flicker a little. The Pi will reboot while it sets up so wait a good 10 minutes

If you are running Windows on your computer, install Bonjour support so you can use `.local` names, you'll need to reboot Windows after installation

You can now ssh into raspberrypi.local
```
ssh pi@raspberrypi.local
```

If you are like me, and re-purpose your hardware a lot, you may get the man-in-the-middle warning.

![alt text][NewHostID]

Don't Panic! you can clear the warning with the following:
```
ssh-keygen -R raspberrypi.local
ssh pi@raspberrypi.local
```

Otherwise you will get an `ECDSA key fingerprint` request, to which you should respond yes.

Now, for some scary David Copperfield stuff.  I know your password.  It's `raspberry`.  You should change that.

pi@raspberrypi:~ $ **passwd**<br>
Changing password for pi.<br>
Current password: **raspberry**<br> 
New password: **Wouldn'tYouLikeToKnow**<br>
Retype new password: **Wouldn'tYouLikeToKnow**<br>
passwd: password updated successfully

Now don't forget that new Password.

## Make ssh Life eaiser.
Copy your public key to the raspberry pi so when you SSH into it, you don't kneed to provide a password.
Type `exit` if you have not done so to return to your workstation.

```
ssh-copy-id pi@raspberrypi.local
``` 
Enter that `Wouldn'tYouLikeToKnow` password to complete the process.

## Set Hostname
```
sudo sed -i 's/raspberrypi/minio/g' /etc/hosts
sudo sed -i 's/raspberrypi/minio/g' /etc/hostname
sudo shutdown -r now
```

The Pi will reboot so log back in with `ssh pi@minio.local`

## Firmware/OS Updates

Next we update/upgrade the OS to the latest version, as well as the RaspberryPi Firmware.  <br />

```
sudo apt-get --assume-yes update
sudo rpi-update # this is seldom required
```

If you performed the firmware upgrad `rpi-update`, your system may have actually performed a firmware update.  And a brave man may continue on and reboot later.  I am not that brave. `sudo shutdown -r now` if you are so inclined.


```
sudo apt-get --assume-yes upgrade
sudo apt-get --assume-yes dist-upgrade
sudo shutdown -r now
```

## Set Timezone

Set the Timezone to the one that best describes your location. See https://en.wikipedia.org/wiki/List_of_tz_database_time_zones for a complete list.  For me, it's Los Angeles:

```
sudo timedatectl set-timezone America/Los_Angeles
```

## Git/GitHub (may not be needed)

Log back into the pi and Generate an ssh key. (Take all defaults)

```
ssh-keygen
```

Copy the public SSH key you just generated (`~/.ssh/id_rsa.pub`) to GitHub per the instructions documented in https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/<br>


Then it's time to get git, and configure the git Global Variables <br />
(note: use your own name and email...)

```
sudo apt-get --assume-yes install git
git config --global user.name "Don Bower"
git config --global user.email "Don.Bower@outlook.com"
```

Next Create a *Developer* directory, and clone this repository from there.  The *Developer* directory is standard practice for modern developers. Some use lowercase for the name, but since on the RaspberryPi, and my Mac, all the other preloaded directories are capitalized, (i.e. Documents, Pictures, etc...) I'll follow form. <br />

```
mkdir ~/Developer
cd ~/Developer
git clone git@github.com:DonBower/MinioPi.git
```

If you need updates from github, use git pull:

```
cd ~/Developer/MinioPi
git pull
```