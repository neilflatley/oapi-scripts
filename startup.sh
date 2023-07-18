#! /usr/bin/env bash

# update scripts directory
git pull || echo "ERROR: git pull failed"

# add execute permission to scripts
chmod +x *.sh

# cp systemd files
cp -r ./systemd/* /etc/systemd

# reload systemd daemon
systemctl daemon-reload 

# ensure the service is enabled to start this script on next reboot
systemctl enable oapi-scripts.service