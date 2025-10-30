#!/bin/bash
sudo dnf update -y
sudo dnf install -y git java-21-amazon-corretto git
# install Jenkins agent if needed
sudo fallocate -l 1G /swapfile_extend_1GB
sudo chmod 600 /swapfile_extend_1GB
sudo mkswap /swapfile_extend_1GB
sudo swapon /swapfile_extend_1GB
sudo mount -o remount,size=5G /tmp/
