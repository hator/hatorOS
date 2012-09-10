CC=gcc
LD=ld
EM=qemu-system-i386

CFLAGS=-Wall -Wextra -O2 -fno-builtin -nostdlib -I$(INCLUDE_DIR)/
LFLAGS=-T linker.ld --exclude-lib ALL #--strip-all

KOBJS=loader.o kernel.o
KFILE=kernel

BASE_IMG=floppy.img
OUT_IMG=myos.img

all: $(KFILE)
	cp $(BASE_IMG) $(OUT_IMG)
	mkdir /media/osimg
	mount -o loop $(OUT_IMG) /media/osimg
	cp $(KFILE) /media/osimg/$(KFILE)
	umount /media/osimg
	rm -rf /media/osimg
	chown hator:users $(OUT_IMG)

$(KFILE): $(KOBJS)
	$(LD) $(LFLAGS) $^ -o $@

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c $^ -o $@

loader.o: loader.S
	$(CC) $(CFLAGS) -c $^ -o $@

test:
	$(EM) -D ./qemu.log -fda $(OUT_IMG)

clean:
	rm -f *.o
	umount /media/osimg
	rm -rf /media/osimg

.PHONY: all test clean
