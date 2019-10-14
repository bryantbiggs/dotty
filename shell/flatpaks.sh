#!/bin/bash

flatpaks=(
    "org.freedesktop.Platform"
    "org.freedesktop.Platform.ffmpeg"
    "org.freedesktop.Platform.ffmpeg-full"
    "org.freedesktop.Platform.html5-codecs"
    "org.freedesktop.Platform.openh264"
    "org.gnome.Calculator"
    "us.zoom.Zoom"
    "org.libreoffice.LibreOffice"
    "com.github.bilelmoussaoui.Authenticator"
    "org.mozilla.FirefoxNightly"
    "org.gnome.Screenshot"
    "com.github.alecaddd.sequeler"
    "com.visualstudio.code"
    "com.getpostman.Postman"
    "org.videolan.VLC"
    "com.slack.Slack"
    "org.telegram.desktop"
    "com.leinardi.gwe"
    )

# Add Flathub repo
echo "Adding Flathub repo..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Add Firefox repo
echo "Adding Firefox flatpak repo..."
flatpak remote-add --if-not-exists--from org.mozilla.FirefoxRepo https://firefox-flatpak.mojefedora.cz/org.mozilla.FirefoxRepo.flatpakrepo

# Install flatpaks
for i in ${!flatpaks[*]};
do
    echo "Installing" $(tput bold)${flatpaks[i]}$(tput sgr0)
    flatpak install ${flatpaks[i]}
    echo "---------------"
    sleep 1
done
