#!/bin/bash

#################################################################################################
#												#
# Script to power off your XBox One wirelessly over infrared.					#
# (Might also work with earlier and later XBox models with IR sensors.)				#
#												#
# PowerOffXBOne uses lirc version > 0.10 together with an external 				#
# IR device(USB dongle, HAT etc.) to issue the power on command/IR code from the 		#
# XBox media remote.										#
#												#
# Tested to work with my Irdroid USB dongle with the irtoy driver on my Raspberry Pi, but	#
# should work on other Linux devices with other IR devices and drivers, as well.		#
#												#
# GitHub repo at: https://github.com/Vegz78/WakeXBOne						#
#												#
#################################################################################################


# Global variables
Driver="irtoy"  #Wanted IR device driver

# Script body
# Check if lircd is already running as a service
killOnEnd=0
if [[ $(ps -A | grep lircd) == "" ]]; then
  sudo lircd -H $Driver
  killOnEnd=1
fi

# Execute IR commamnd
sudo irsend SEND_ONCE XBOX-ONE PowerOff

# Cleanup
if [ $killOnEnd == 1 ]
then
  sudo killall lircd
fi
