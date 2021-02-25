# WakeXBOne
If you are interested, able and want to help me power on the XBox One wirelessly from Energy Saving mode via RF/SDR, please check out the section [WakeXBOne - RF/SDR](https://github.com/Vegz78/WakeXBOne#wakexbone---rfsdr) and open an [issue](https://github.com/Vegz78/WakeXBOne/issues) to establish contact. If you only want the already working infrared solution, please check out the paragraph [WakeXBOne - IR](https://github.com/Vegz78/WakeXBOne#wakexbone---ir).

## Motivation
The XBox One console draws [up to 15.7W idle power](https://www.nrdc.org/sites/default/files/video-game-consoles-IP.pdf) in its Instant-On standby mode, where it quickly and easily can be powered on over the network by Wake-On-Lan, the XBox app, the XBox Console Companion app etc. 

This equals up to 138kWh and $15-$25 _per console pr year_ unecessary power consumption and electricity costs, depending on the local electricity prices. On the aggregate level, with [around 50 million XBox One units sold per Q2 2020](https://www.ampereanalysis.com/insight/sony-banks-on-playstation-studios-to-deliver-another-winning-console-generation), and with most consoles running in Instant-On mode, this is potentially the equivalent of a 750MW+ (coal fired?) base load power plant, something like [e.g. this one](https://en.wikipedia.org/wiki/A._B._Brown_Generating_Station), and with a lot of unecessary CO2 emissions/environmentally friendlier power production that could be put to better use.

In addition, some power supplies make a loud small helicopter noise while in Instant-On mode or on, there´s unecessary heat production 24/7, and therefore not unlikely a minor increase in the risk of fire.

<br>

In Energy Saving mode, the XBox One only draws [0.5W of idle power](https://support.xbox.com/en-US/help/hardware-network/power/learn-about-power-modes), which is acceptable and comparable to many other common household appliances in standby. However, the console takes a little longer to power on(which should be worth it) and, to my knowledge, can only be powered on with the physical console power button, a paired XBox wireless controller(RF) and the XBox media remote(IR).

<br>

This project aims to find and make available other ways to remotely power on the XBox One console from Energy Saving mode, by infrared, wireless radio or maybe other means, without the need for extra hardware or with reuse of existing hardware, like low-powered single board computers/microcontrollers etc.

Hopefully, these ways will also work on future XBox consoles and, hopefully, Microsoft wants the same and releases the "XBox Wireless" protocol´s power on sequence for open, free and public use.

# WakeXBOne - RF/SDR
tbc...

# WakeXBOne - IR
Turn on the XBox One remotely from Energy Saving mode using infrared signals.

Special thanks to [@tuxuser](https://github.com/tuxuser) from the [OpenXbox project](https://github.com/OpenXbox) and [Jez Corden from Windows Central](https://www.windowscentral.com/author/jez-corden) for the tips about using IR, and [@samnazarko](https://github.com/samnazarko) from the [OSMC project](https://github.com/osmc/osmc) and [@dustinrue](https://github.com/dustinrue) and his [Homebridge XBox One plugin](https://github.com/dustinrue/homebridge-xbox-one-lirc) for the LIRC conf file and the XBox One IR codes.

## Prerequisites
- A network enabled always-on computing device running Linux, with<br>
(I am using a [Raspberry Pi](https://www.raspberrypi.org/products/))
- An IR transmitter device in line of sight from the XBox One,<br>
(I am using an [Irdroid USB IR transceiver](https://www.irdroid.com/irdroid-usb-ir-transceiver/))
- [LIRC](https://www.lirc.org) with the right IR device driver, and<br>
(I am using LIRC version > 0.10 from the Debian buster packages)
- [Git](https://git-scm.com)

The same is probably also possible using the same [LIRC conf file](https://github.com/Vegz78/WakeXBOne/blob/main/IR/xbox-one-lircd.conf) on a Windows computing device runnning [WinLIRC](http://winlirc.sourceforge.net).

# WakeXBOne - Other means
tbc...
