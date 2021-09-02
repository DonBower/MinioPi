# MinioPi
minIO server on Rasperry Pi 400

## Objectives:
The Purpose of this Repository is to document the build of the MinIO Server on headless (no console/monitor) Raspberry Pi, which provides for an alternitive to AWS S3 service in a standalone Server.

## Status:
Mostly just documentation, but I am re-doing the entire server

## Components:
||||
|:--------:|:---------|:------------------------------------------------------|
|![alt text][raspberryPI400]|[Computer](https://www.adafruit.com/product/4795)|Yea, that's right Computer. With built in Keyboard.  or peraps the other way around. This computer in a keyboard will run MinIO server. It also has 3 USB ports, a 40 pin GPIO, and and sd-micro for storage. Quite the Utility Computer.|
|![alt text][raspberryPIPower]|[PowerSupply](https://www.adafruit.com/product/4298)|The official Raspberry Pi USB-C power supply for the Raspberry Pi 4 and 400.|
|![alt text][raspberryPIOS]|[Operating System](https://downloads.raspberrypi.org/raspios_lite_arm64/images/raspios_lite_arm64-2021-05-28/2021-05-07-raspios-buster-arm64-lite.zip)|The official Raspberry Pi USB-C power supply for the Raspberry Pi 4 and 400.|
|![alt text][minio]|[MinIO Server](https://min.io/download#/linux)|MinIO offers high-performance, S3 compatible object storage. Select the **arm64** architecture. MinIO is software-defined and is 100% open source under GNU AGPL v3.|

---
## Future Wants
* Other Services (Vault?)

---
## Assembly

---
## Software Installation
* Setup the RaspberryPi
Follow the instructions [here](/Pi/README.md)


[raspberryPI400]: /Images/Pi400.jpg "Raspberry Pi 400"

[raspberryPIPower]: /Images/PowerSupply.jpg "Raspberry Pi Power Supply"

[raspberryPIOS]: /Images/PiOS.png

[minIO]: /Images/minio.svg "Minio Server for ARM"
