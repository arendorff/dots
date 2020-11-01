#!/bin/sh

STATUS=$(nordvpn status | grep Status | tr -d ' ' | cut -d ':' -f2)

if [ "$STATUS" = "Connected" ]; then
		echo " up"
else
		echo " down"
fi
