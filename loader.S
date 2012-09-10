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
//	movl %eax, %ecx
//	call kmain
	mov $0xb8000, %eax
	movb $0x41, (%eax)
	movb $0x1b, 1(%eax)
	
	
	cli
	_loop: hlt; jmp _loop
