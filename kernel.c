#include <idt.h>

/* Declare an IDT of 256 entries. Although we will only use the
*  first 32 entries in this tutorial, the rest exists as a bit
*  of a trap. If any undefined IDT entry is hit, it normally
*  will cause an "Unhandled Interrupt" exception. Any descriptor
*  for which the 'presence' bit is cleared (0) will generate an
*  "Unhandled Interrupt" exception */
/*idt_entry idt[256];
idt_ptr   idtp;*/

static char* videoRam = (char*)0xB8000;

void gdt_install();

int __attribute__((fastcall)) kmain(void* multiboot_header) {
	videoRam[0] = 'A';
	videoRam[1] = 0x1B;
	
//	idt_install(idtp, &idt);
	
	init_paging();
	gdt_install();

	videoRam[2] = 'B';
	videoRam[3] = 0x2C;
	
	for(;;);
	
	return 0;
}
