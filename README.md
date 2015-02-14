lego-linux-drivers-dkms
=======================

Dynamic Kernel Module Support (DKMS) for the ev3dev drivers.

The ev3dev drivers provide and easy to use interface for LEGO MINDSTORMS and
LEGO WeDo hardware. Using these drivers you can use the LEGO WeDo USB Hub and
LEGO MINDSTORMS EV3 UART sensors with your desktop, laptop, Raspberry Pi or
just about anything that runs Linux.

About
-----

LEGO MINDSTORMS EV3 introduced a new type of sensor that communicates via
[UART]. This means that, given the correct voltage levels, these sensors can
communicate with anything with a UART communication port.

This package provides a couple of Linux kernel modules so that you can use the
LEGO MINDSTORMS EV3 UART sensors with anything that runs Linux and has an
available serial port (and something to convert voltage levels if needed).

Current known UART sensors are:

* [LEGO 45504 EV3 Ultrasonic Sensor]
* [LEGO 45505 EV3 Gyro Sensor]
* [LEGO 45506 EV3 Color Sensor]
* [LEGO 45509 EV3 Infrared Sensor]

...but any future LEGO, 3rd party or even homemade UART sensors should just work.

Additionally, LEGO WeDo has a USB Hub that connects to WeDo sensors and Power
Functions motors and lights. These devices can also be used with these drivers.

Warning
-------

These are kernel modules. They have the potential completely crash your
machine. If this worries you, try it in a virtual machine.

Installation
------------

Note: This has been tested on kernel v3.16 (Debian jessie) and v3.13 (Ubuntu trusty).
Older or newer kernel versions might not be compatible - in which chase installation
will fail because the modules could not be compiled.

You can download the latest Debian package from
<https://github.com/ev3dev/lego-linux-drivers-dkms/releases>.

To install the Debian package (version number may be different):

    sudo dpkg -i legoev3-uart-sensor-modules_2.0_all.deb

Usage
-----

For info about how to physically connect the sensor (including info about these
voltage levels we've been talking about), check out [this blog post][blog].

Once you have the sensor connected, you need to find out which tty device it is
connected to. This varies based on what you are connecting to, so we'll leave
this up to you to figure out. As an example, we'll say we are using a USB serial
port at `/dev/ttyUSB0`.

Next, you need to attach the LEGOEV3_UART line discipline to the tty. 29 is the
the number we have assigned to the line discipline.

    sudo ldattach 29 /dev/ttyUSB0
    
Now, you will have a sensor at `/sys/class/lego-sensor/` that you can play with.
For information on how to use the MINDSTORMS sensor class (lego-sensor) in sysfs,
checkout the [ev3dev docs].

If you want to automate the `ldattach` command, check out [that same blog
post][blog] for information on how your can do this using udev.

Issues
------

If you have problems or find a bug, search the issues [here][issues] and open
a new issue if you can't find an existing issue that helps.

[UART]: https://en.wikipedia.org/wiki/Universal_asynchronous_receiver/transmitter
[ev3dev docs]: http://www.ev3dev.org/docs/drivers/lego-sensor-class/
[blog]: http://lechnology.com/2014/09/using-uart-sensors-on-any-linux
[LEGO 45504 EV3 Ultrasonic Sensor]: http://www.ev3dev.org/docs/sensors/lego-ev3-ultrasonic-sensor/
[LEGO 45505 EV3 Gyro Sensor]: http://www.ev3dev.org/docs/sensors/lego-ev3-gyro-sensor/
[LEGO 45506 EV3 Color Sensor]: http://www.ev3dev.org/docs/sensors/lego-ev3-color-sensor
[LEGO 45509 EV3 Infrared Sensor]: http://www.ev3dev.org/docs/sensors/lego-ev3-infrared-sensor
[issues]: https://github.com/ev3dev/ev3dev/issues
