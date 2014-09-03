legoev3-uart-sensor-modules DKMS
================================

Dynamic Kernel Module Support (DKMS) for LEGO MINDSTROMS EV3 UART sensors.

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

...but any future/unknown UART sensors should just work.

Warning
-------

These are kernel modules. They have the potential completely crash your
machine.

Installation
------------

You can download the latest Debian package or DKMS tarball from
<https://github.com/ev3dev/legoev3-uart-sensor-modules/releases>.
You just need one or the other.

To install the Debian package (version number may be different):

    sudo dpkg -i legoev3-uart-sensor-modules_1.0_all.deb
    
Or to install the DKMS package (version number may be different):

    sudo dkms ldtarball legoev3-uart-sensor-modules-1.0-source-only.dkms.tar.gz
    sudo dkms install legoev3-uart-sensor-modules/1.0

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
    
Now, you will have a sensor at `/sys/class/msensor/` that you can play with.
For information on how to use the MINDSTORMS sensor class (msensor) in sysfs,
checkout the [ev3dev wiki].

If you want to automate the `ldattach` command, check out [that same blog
post][blog] for information on how your can do this
using udev.

[UART]: https://en.wikipedia.org/wiki/Universal_asynchronous_receiver/transmitter
[ev3dev wiki]: https://github.com/ev3dev/ev3dev/wiki/Using-Sensors#usage
[blog]: http://lechnology.com/2014/09/using-uart-sensors-on-any-linux
[LEGO 45504 EV3 Ultrasonic Sensor]: https://github.com/ev3dev/ev3dev/wiki/LEGO-EV3-Ultrasonic-Sensor-%2845504%29
[LEGO 45505 EV3 Gyro Sensor]: https://github.com/ev3dev/ev3dev/wiki/LEGO-EV3-Gyro-Sensor-%2845505%29
[LEGO 45506 EV3 Color Sensor]: https://github.com/ev3dev/ev3dev/wiki/LEGO-EV3-Color-Sensor-%2845506%29
[LEGO 45509 EV3 Infrared Sensor]: https://github.com/ev3dev/ev3dev/wiki/LEGO-EV3-Infrared-Sensor-%2845509%29