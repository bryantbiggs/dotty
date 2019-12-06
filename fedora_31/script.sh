#!/bin/bash

# Fedora free & non-free repos
rpm-ostree install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
rpm-ostree install rpmfusion-nonfree-release

# Theming 
rpm-ostree install make fedora-workstation-repositories gnome-tweaks flat-remix-theme gnome-shell-extension-dash-to-dock gnome-shell-extension-user-theme

# Video codecs/drivers
rpm-ostree install gstreamer1-libav gstreamer1-plugins-ugly unrar compat-ffmpeg28 ffmpeg-libs ruby

# NVIDIA drivers - https://rpmfusion.org/Howto/NVIDIA
rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia 
rpm-ostree kargs --append=rd.driver.blacklist=nouveau --append=modprobe.blacklist=nouveau --append=nvidia-drm.modeset=1

