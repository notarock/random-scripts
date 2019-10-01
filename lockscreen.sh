#!/bin/bash

scrot /tmp/screen.png
convert /tmp/screen.png -interpolate nearest -virtual-pixel mirror -spread 20 /tmp/screen.png
i3lock -i /tmp/screen.png
rm /tmp/screen.png
