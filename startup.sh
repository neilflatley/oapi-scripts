#! /usr/bin/env bash

HOME=/home/pi
cd /home/pi/oapi-scripts
git config --global --add safe.directory /home/pi/oapi-scripts

# reset directory so it can be pulled cleanly
git reset --hard origin/master

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