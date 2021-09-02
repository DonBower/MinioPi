# Overview
Now that you have your Raspberry pi set up, you need to download the minio executable, put it somewhere in the path, create a run script, and add that script to the root's crontab so it just runs if there is a reboot.

Start by navigating to https://min.io/download#/linux and select `arm64` in the Architecture drop-down box.

You will likly see something very similar to this for a minio server binary (that's right, no compiling today):

```
wget https://dl.min.io/server/minio/release/linux-arm64/minio
chmod +x minio
MINIO_ROOT_USER=admin MINIO_ROOT_PASSWORD=password ./minio server /mnt/data --console-address ":9001"
```

but I suggest you do something else.
download the file, make it executiable, and move it to /usr/local/bin.
Then create an executiable .sh file with the folliwing contents:
```
#!/bin/bash
export PATH=/usr/local/bin:${PATH} 
export MINIO_DATA_PATH=/mnt/minio
export MINIO_ROOT_USER=minioadmin
export MINIO_ROOT_PASSWORD=minipassword
export MINIO_REGION_NAME=home-office
export MINIO_DOMAIN=minio.local
export MINIO_SERVER_URL="http://${MINIO_DOMAIN}:9000"

if [[ ! -d ${MINIO_DATA_PATH} ]]; then
  sudo mkdir -p ${MINIO_DATA_PATH}
fi

sudo chown -R pi ${MINIO_DATA_PATH}
sudo chmod u+rxw ${MINIO_DATA_PATH}

minio \
  server ${MINIO_DATA_PATH} \
  --console-address ":9001"

```

then move the minio executable and the .sh file into a common location:
```
sudo mv minio /usr/local/bin
```

# Autostart
To start the server automatically on boot, edit the crontab (`sudo crontab -e -u root`) and add the following line:

```
@reboot /home/pi/minio.sh 1>> /home/pi/minio.sh.errlog.txt 2>&1
```

# Done

That's it! give your mini.pi a throw and see what you catch.
If you have any questions, or issues, leave them here on github so I can address them.

Thanks!
