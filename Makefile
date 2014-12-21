MDIR := lego

KVER ?= $(shell uname -r)
KDIR ?= /lib/modules/$(KVER)/build

ifneq ($(KERNELRELEASE),)

obj-m	+= lego/sensors/lego_sensor_class.o
obj-m	+= lego/sensors/ev3_uart_sensor_ld.o

else

all::
	$(MAKE) -C $(KDIR) M="$(CURDIR)" modules

install:: all
	$(MAKE) INSTALL_MOD_PATH=$(DESTDIR) INSTALL_MOD_DIR=$(MDIR) \
		-C $(KDIR) M="$(CURDIR)" modules_install

clean::
	$(MAKE) -C $(KDIR) M="$(CURDIR)" clean
	rm -f Module.symvers

endif