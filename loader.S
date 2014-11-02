#define MULTIBOOT_PAGE_ALIGN (1<<0)
#define MULTIBOOT_MEMORY_INFO (1<<1)

#define MULTIBOOT_HEADER_MAGIC (0x1BADB002)
#define MULTIBOOT_HEADER_FLAGS (MULTIBOOT_PAGE_ALIGN|MULTIBOOT_MEMORY_INFO)
#define CHECKSUM (-(MULTIBOOT_HEADER_MAGIC+MULTIBOOT_HEADER_FLAGS))

// Export entry point
.globl loader

// Multiboot header
.align 4
MultibootHeader:
	.long MULTIBOOT_HEADER_MAGIC
	.long MULTIBOOT_HEADER_FLAGS
	.long CHECKSUM

// infinite loop
loader:
	// TRICK: GDT with base 0x40000000 for code(0x08) and data(0x10)
/*	lgdt (_trickgdt)
	movw $0x10, %ax
	movw %ax, %ds
	movw %ax, %es
	movw %ax, %fs
	movw %ax, %gs
	movw %ax, %ss*/
	jmp $0x08,$_higherhalf

_higherhalf:
	mov _sys_stack, %esp

	call kmain

	__loop:
		hlt
		jmp __loop


.global gdt_flush
/*gdt_flush:
	lgdt (gp)
	movw $0x10, %ax
	movw %ax, %ds
	movw %ax, %es
	movw %ax, %fs
	movw %ax, %gs
	movw %ax, %ss
	jmp $0x08,$_flush2

_flush2:
	ret
*/
/*.section .setup
_trickgdt:
	.word _gdt_end - _gdt - 1 //size of the GDT
	.long _gdt 		  //linear address of the GDT
_gdt:
	.long 0
	.long 0
	.byte 0xFF, 0xFF, 0, 0, 0, 0b10011010, 0b11001111, 0x40 //code seg
	.byte 0xFF, 0xFF, 0, 0, 0, 0b10010010, 0b11001111, 0x40 //data seg
_gdt_end:
*/
.section .bss
.lcomm _sys_stack_start 0x1000
_sys_stack:
