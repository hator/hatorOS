char* videoRam = (char*)0xB8000;


int __attribute__((fastcall)) kmain(void* multiboot_header) {
	videoRam[0] = 'A';
	videoRam[1] = 0x1B;
	return 0;
}
