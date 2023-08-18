#!/bin/bash

# This script is used to setup a new Raspberry Pi with the necessary stuff

# install apt packages

sudo apt update
sudo apt upgrade -y

sudo apt install raspberrypi-kernel-headers python3-pip python3-venv git -y
sudo apt install cmake libgtest-dev libgpiod-dev -y

# install GitHub CLI

if [ ! -f /usr/bin/gh ]; then
    type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y
fi

# install github script

mkdir -p ~/.local/bin
cat > ~/.local/bin/gh-init.sh <<EOF
#!/bin/bash

echo "Enter your Git/GitHub details"
read -p "Enter your name: " GIT_AUTHOR_NAME
read -p "Enter your e-mail: " GIT_AUTHOR_EMAIL
read -p "Enter a valid GitHub token: " GITHUB_TOKEN

export GIT_COMMITTER_NAME="\$GIT_AUTHOR_NAME"
export GIT_COMMITTER_EMAIL="\$GIT_AUTHOR_EMAIL"
export GIT_AUTHOR_NAME
export GIT_AUTHOR_EMAIL
export GITHUB_TOKEN

gh auth setup-git

git config --global pull.rebase true

/bin/bash
EOF

chmod +x ~/.local/bin/gh-init.sh


# reboot in case upgrade did something interresting
echo Rebooting now
sudo reboot
