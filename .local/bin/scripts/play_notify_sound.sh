#!/bin/sh
opusdec --force-wav $(ls $(xdg-user-dir MUSIC)/Soundtracks/Devs/Notifications/*.opus | shuf -n 1) - | aplay
