#!/bin/bash

# ---------------------- Setup for installation -----------------------

# Install the basic tools for building and downloading software
sudo add-apt-repository -y ppa:apt-fast/stable
sudo aptitude update
sudo aptitude install -y apt-transport-https apt-fast

# Remove the software you don't need
sudo apt-get -y remove mono-runtime-common gnome-orca transmission-gtk hexchat

# Add extra Repositories
sudo add-apt-repository -y ppa:linrunner/tlp
sudo add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable
sudo apt-add-repository -y ppa:fish-shell/release-3

# Add sublime-text to package lists
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# Adding brave-browser to package lists
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# Update the system
sudo apt update

# Essential Software list
sudo apt install -y \
					mint-meta-codecs \
					p7zip-rar \
					audacious \
					numlockx \
					vlc \
					curl \
					apt-transport-https \

# Extras
sudo apt install -y \
					fonts-crosextra-carlito \
					fonts-crosextra-caladea \

# Developers
sudo apt install -y	\
					python3-dev python-is-python3 python3-pip \
					build-essential \
					clang \
					cmake \
					git \
					sublime-text \

sudo apt install -y qbittorrent tlp tlp-rdw fish brave-browser



# Installing golang



# ---------------------- Set up and configuration software -----------------------------------

sudo ufw enable
sudo tlp start


# ---------------------- Cleanup -------------------------------------------------------------
sudo apt-get autoclean
sudo apt-get clean
sudo apt-get autoremove