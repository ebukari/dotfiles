#!/bin/bash

# ---------------------- Setup for installation -----------------------

# Install the basic tools for building/downloading/upgrading software
sudo add-apt-repository -y ppa:apt-fast/stable
sudo aptitude update
sudo aptitude install -y apt-transport-https apt-fast wget software-properties-common curl build-essential libreadline-dev

# Remove the software you don't need
sudo apt-get -y remove mono-runtime-common gnome-orca transmission-gtk hexchat


# ----------------------- Extra repositories ----------------------------

sudo add-apt-repository -y ppa:linrunner/tlp
sudo add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable
sudo apt-add-repository -y ppa:fish-shell/release-3
# zeal does not support focal as at now
# sudo add-apt-repository -y ppa:zeal-developers/ppa

# Sublime Text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# Brave Browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# VSCode
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

# Spotify
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

# Update the system
sudo apt update

# Essential Software list
sudo apt-fast install -y \
					mint-meta-codecs \
					p7zip-rar \
					audacious \
					numlockx \
					vlc \
					curl \

# Extras
sudo apt-fast install -y \
					fonts-crosextra-carlito \
					fonts-crosextra-caladea \

# Developers
sudo apt-fast install -y	\
					python3-dev python-is-python3 python3-pip \
					clang \
					cmake \
					git \
					sublime-text \
					code \
					zeal \


sudo apt-fast install -y \
						 qbittorrent \
						 tlp tlp-rdw \
						 fish \
						 brave-browser \
						 spotify-client \
						 terminator \


# ---------------------- Set up and configuration software -----------------------------------

sudo ufw enable
sudo tlp start

# ---------------------- Upgrade all packages to latest versions -----------------------------
sudo apt-fast -y dist-upgrade


# ---------------------- Cleanup -------------------------------------------------------------
sudo apt-get autoclean
sudo apt-get clean
sudo apt-get autoremove
