#!/bin/bash

flatpaks=(
    "com.slack.Slack"
    "net.rpdev.OpenTodoList"
    "org.freedesktop.Platform"
    "org.freedesktop.Platform.GL.default"
    "org.freedesktop.Platform.ffmpeg-full"
    "org.freedesktop.Platform.html5-codecs"
    "org.freedesktop.Platform.openh264"
    "org.freedesktop.Sdk"
    "org.gnome.Calculator"
    "org.gnome.Platform"
    "org.kde.Platform"
    "org.kde.PlatformTheme.QGnomePlatform"
    "org.kde.WaylandDecoration.QGnomePlatform-decoration"
    "org.libreoffice.LibreOffice"
    "us.zoom.Zoom"
    "org.mozilla.FirefoxNightly"
    "org.gnome.Screenshot"
    "org.videolan.VLC"
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
