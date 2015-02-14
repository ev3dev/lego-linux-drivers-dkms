MDIR := lego

KVER ?= $(shell uname -r)
KDIR ?= /lib/modules/$(KVER)/build

# only build the stuff that does not depend on EV3 Intelligent Brick hardware
export CONFIG_LEGO_DRIVERS = m
export CONFIG_LEGO_PORTS = m
export CONFIG_LEGOEV3_MOTORS = m
export CONFIG_LEGOEV3_SERVO_MOTORS = m
export CONFIG_LEGOEV3_DC_MOTORS = m
# The ev3-tacho-motor module is EV3 hardware specific and probably should be in
# the ev3/ directory instead of the motors/ directory.
export CONFIG_LEGOEV3_TACHO_MOTORS = n
export CONFIG_LEGOEV3_MSENSORS = m
export CONFIG_NXT_ANALOG_SENSORS = m
export CONFIG_EV3_ANALOG_SENSORS = m
# I2C sensors require modifications to the core I2C kernel driver
export CONFIG_LEGOEV3_I2C_SENSORS = n
export CONFIG_EV3_UART_SENSORS = m
export CONFIG_WEDO = m

ifneq ($(KERNELRELEASE),)

ifeq ($(CONFIG_LEGO_DRIVERS), m)
KBUILD_CFLAGS += -DCONFIG_LEGO_DRIVERS_MODULE
endif
ifeq ($(CONFIG_LEGO_PORTS), m)
KBUILD_CFLAGS += -DCONFIG_LEGO_PORTS_MODULE
endif
ifeq ($(CONFIG_LEGOEV3_MOTORS), m)
KBUILD_CFLAGS += -DCONFIG_LEGOEV3_MOTORS_MODULE
endif
ifeq ($(CONFIG_LEGOEV3_SERVO_MOTORS), m)
KBUILD_CFLAGS += -DCONFIG_LEGOEV3_SERVO_MOTORS_MODULE
endif
ifeq ($(CONFIG_LEGOEV3_TACHO_MOTORS), m)
KBUILD_CFLAGS += -DCONFIG_LEGOEV3_TACHO_MOTORS_MODULE
endif
ifeq ($(CONFIG_LEGOEV3_MSENSORS), m)
KBUILD_CFLAGS += -DCONFIG_LEGOEV3_MSENSORS_MODULE
endif
ifeq ($(CONFIG_NXT_ANALOG_SENSORS), m)
KBUILD_CFLAGS += -DCONFIG_NXT_ANALOG_SENSORS_MODULE
endif
ifeq ($(CONFIG_EV3_ANALOG_SENSORS), m)
KBUILD_CFLAGS += -DCONFIG_EV3_ANALOG_SENSORS_MODULE
endif
ifeq ($(CONFIG_LEGOEV3_I2C_SENSORS), m)
KBUILD_CFLAGS += -DCONFIG_LEGOEV3_I2C_SENSORS_MODULE
endif
ifeq ($(CONFIG_EV3_UART_SENSORS), m)
KBUILD_CFLAGS += -DCONFIG_EV3_UART_SENSORS_MODULE
endif
ifeq ($(CONFIG_WEDO), m)
KBUILD_CFLAGS += -DCONFIG_WEDO_MODULE
endif

obj-y := $(MDIR)/

else

all: modules

modules:
	$(MAKE) -C $(KDIR) M="$(CURDIR)" modules

install: modules
	$(MAKE) INSTALL_MOD_PATH=$(DESTDIR) INSTALL_MOD_DIR=$(MDIR) \
		-C $(KDIR) M="$(CURDIR)" modules_install

clean:
	$(MAKE) -C $(KDIR) M="$(CURDIR)" clean

help:
	$(MAKE) -C $(KDIR) M="$(CURDIR)" help

endif