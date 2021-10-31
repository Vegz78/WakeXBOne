# WakeXBOne
([For a similar solution for the PS3, see here](https://github.com/Vegz78/WakePS3))

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

<br>

# WakeXBOne - RF/SDR
An attempt to turn on the XBox One remotely from Energy Saving mode using [software defined radio](https://en.wikipedia.org/wiki/Software-defined_radio).

Special thanks to [@Frank Hessel](https://github.com/fhessel) from the [Secure Mobile Networking Lab](https://github.com/seemoo-lab) for tipping me about Nexmon as a possible tool and for helping me get started with it.

I am quite stuck at the moment, so any help is greatly appreciated!

## Idea
Use the [Nexmon](https://github.com/seemoo-lab/nexmon) firmware patching framework for Broadcom WiFi chips on a Raspberry Pi to inject and transmit the "XBox Wireless" protocol´s power on sequence to the XBox One console, similar to how the XBox controller Guide button powers on the XBox One console.

Tips about other/better approaches are most welcome!

## Results
- It has been [documented that the XBox controller communicates with the "XBox Wireless" protocol](https://github.com/paroj/xpad/issues/25), which seems to be a slightly modified version of 802.11a/n.
- The 2.41-2.46 and 5.18-5.8GHz operating frequency hopping radio frequencies for the XBox One controller are [documented e.g. at the FCC](https://fccid.io/C3K1697).
- While the console is powered on and when connecting a wireless controller I´ve managed with Nexmon in monitor mode and Wireshark to capture communication packets between them on channel 161/20, similar to what [@devkid](https://github.com/devkid) managed in 2016 and has [shared here](https://gist.github.com/devkid/4b3bd50760504d1b93ea684cfd3ed895).
- When trying to monitor communication while the console is **_off_** and powering it on with the XBox controller Guide button, I still haven´t managed to catch any radio packets with Nexmon and Wireshark.
- Some people have suggested that there is wireless security/encryption inside the controller and RF/Power board on the console, to prevent/hide the power on sequence from other devices, which may be the reason for not being able to catch these packets.

If anyone has an idea about how to catch and replay the power on sequence, or want to help find out, please get in touch by [opening an issue here](https://github.com/Vegz78/WakeXBOne/issues)!

HELP! ;-)

<br>

# WakeXBOne - IR
Turn on the XBox One remotely from Energy Saving mode using infrared signals.

Special thanks to [@tuxuser](https://github.com/tuxuser) from the [OpenXbox project](https://github.com/OpenXbox) and [Jez Corden from Windows Central](https://www.windowscentral.com/author/jez-corden) for the tips about using IR, and [@samnazarko](https://github.com/samnazarko) from the [OSMC project](https://github.com/osmc/osmc) and [@dustinrue](https://github.com/dustinrue) and his [Homebridge XBox One plugin](https://github.com/dustinrue/homebridge-xbox-one-lirc) for the LIRC conf file and the XBox One IR codes.

## Prerequisites
- A network enabled always-on computing device running Linux, with<br>
(I am using a [Raspberry Pi](https://www.raspberrypi.org/products/))
- An IR transmitter device in line of sight from the XBox One,<br>
(I am using an [Irdroid USB IR transceiver](https://www.irdroid.com/irdroid-usb-ir-transceiver/))
- [LIRC](https://www.lirc.org) with the right IR device driver, and<br>
(I am using LIRC version > 0.10 from the Debian buster packages and the _irtoy_ driver for the Irdroid)
- [Git](https://git-scm.com)

The same is probably also possible using the same [LIRC conf file](https://github.com/Vegz78/WakeXBOne/blob/main/IR/xbox-one-lircd.conf) on a Windows computing device runnning [WinLIRC](http://winlirc.sourceforge.net).

## Installation and usage
- Install LIRC:<br>
```sudo apt update&&sudo apt install lirc```
- Clone the WakeXBOne repo:<br>
```git clone https://github.com/Vegz78/WakeXBOne.git```
- Copy _.../IR/xbox-one-lircd.conf_ to /etc/lirc/lircd.conf.d:<br>
```sudo cp xbox-one-lircd.conf /etc/lirc/lircd.conf.d```
- Edit _.../IR/_WakeXBOne.sh´s_ global variable with the right driver for your IR device:<br>
```nano _WakeXBOne.sh```
- Make sure _.../IR/_WakeXBOne.sh_ is executable:<br>
```chmod +x _WakeXBOne.sh```

When everything is ready, rund _\_WakeXBOne.sh_ to power on your XBox One over IR:<br>
```/path-to-script/_WakeXBOne.sh```

- Same procedure as above for powering **_off_** your XBox One using _\_PowerOffXBOne.sh_.
- There are some included .bat files, _WinWakeXBOne.bat_ and _WinPowerOffXBOne.bat_, for running these IR-scripts on your Linux device remotely from a Windows device using [Putty´s plink utility](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html). Handy if you, for instance, like to stream your XBox One console to a Windows computer.
- [As described for example here](https://www.irdroid.com/2016/10/discover-how-to-turn-raspberry-pi-into-a-infrared-remote-control-using-the-irdroid-rpi/), it is also possible to rund lirc as a web service, which can be controlled locally and remotely by apps on Android and iPhone phones.

<br>

# WakeXBOne - Other means
Was thinking about collecting links to other working solution for powering on the XBox One wirelessly from Energy Saving mode here.

Tips are most welcome!
