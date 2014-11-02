CC=gcc
LD=ld
EM=qemu-system-i386 -monitor stdio

INCLUDE_DIR=.

CFLAGS=-Wall -Wextra -O2 -fno-builtin -fno-common -fno-stack-protector -fno-strict-aliasing -nostdinc -nostdlib -I$(INCLUDE_DIR)/
LFLAGS=-T linker.ld --exclude-lib ALL #--strip-all

KOBJS=loader.o kernel.o #idt.o util.o
KFILE=kernel

BASE_IMG=base_image.img
OUT_IMG=myos.img

all: $(KFILE)
	cp $(BASE_IMG) $(OUT_IMG)
	mkdir /media/osimg
	mount $(OUT_IMG) /media/osimg
	cp $(KFILE) /media/osimg/$(KFILE)
	umount /media/osimg
	rm -rf /media/osimg
	chown hator:hator $(OUT_IMG)

$(KFILE): $(KOBJS)
	$(LD) $(LFLAGS) $^ -o $@

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c $^ -o $@

loader.o: loader.S
	$(CC) $(CFLAGS) -c $^ -o $@

idt.o: idt.c
	$(CC) $(CFLAGS) -c $^ -o $@

util.o: util.c
	$(CC) $(CFLAGS) -c $^ -o $@


test:
	$(EM) -D ./qemu.log -fda $(OUT_IMG)

clean:
	rm -f *.o


.PHONY: all test clean
