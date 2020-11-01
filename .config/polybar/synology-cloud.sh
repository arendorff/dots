#!/bin/sh

pgrep cloud-drive > /dev/null && echo " up" || echo " down" 
