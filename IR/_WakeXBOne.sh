#!/bin/bash

#################################################################################################
#												#
# Script to power on your XBox One wirelessly with infrared while in Energy Saving mode.	#
# (Might also work with earlier and later XBox models with IR sensors.)				#
#												#
# In Energy Saving mode, the XBox One draws only 0.5W idle power, compared to as much as	#
# 15.9W and often with noisy PSUs in Instant-On mode, which is required to power it on with	#
# XBox applications/WOL. The energy savings, with 41 million XBox Ones sold per November 2020,	#
# is potentially the equivalent of a 600MW (coal fired?) base load power plant, and around	#
# 130kWh/$15-$25 a year per XBox One, depending on the local electricity prices.		#
#												#
# WakeXBOne uses lirc version > 0.10 together with an external IR device(USB dongle, HAT etc.) 	#
# to issue the power on command/IR code from the XBox media remote.				#
#												#
# Tested to work with my Irdroid USB dongle with the irtoy driver on my Raspberry Pi, but	#
# should work on other Linux devices with other IR devices and drivers, as well.		#
#												#
# The goal of this project is to find a way to power on the XBox One from Energy Saving mode	#
# with wireless radio signals from a wifi capable single board computer or microcontroller, 	#
# without the need for extra hardware and placements in line of sight. -Similar to what is 	#
# already possible with the Guide button on the XBox One controllers.  				#
# 												#
# If you're interested and think you can contribute, don't hesitate to get in touch on 		#
# GitHub by opening an issue at: https://github.com/Vegz78/WakeXBOne				#
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
sudo irsend SEND_ONCE XBOX-ONE KEY_POWER

# Cleanup
if [ $killOnEnd == 1 ]
then
  sudo killall lircd
fi
