#!/bin/bash

# This script is used to setup a new Raspberry Pi with the necessary stuff

sudo apt update
sudo apt upgrade -y

sudo apt install raspberrypi-kernel-headers python3-pip python3-venv git -y
sudo apt install cmake libgtest-dev libgpiod-dev -y
