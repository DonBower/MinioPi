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
