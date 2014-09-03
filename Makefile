MDIR := legoev3

KVER ?= $(shell uname -r)
KDIR ?= /lib/modules/$(KVER)/build

ifneq ($(KERNELRELEASE),)

obj-m	+= msensor_class.o
obj-m	+= legoev3_uart.o

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