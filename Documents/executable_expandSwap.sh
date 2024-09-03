#!/bin/sh
## Ref: https://ploi.io/documentation/server/change-swap-size-in-ubuntu

sudo swapoff -a

sudo rm /swapfile

sudo fallocate -l 16G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
free -m
