OUTPUT_FORMAT(elf32-i386)
ENTRY(loader)

phys = 0x00100000; /* 1 meg */

SECTIONS {
	. = 0xC0100000;

	.setup :
	{
		*(.setup)
	}

	.text ALIGN(0x1000) :
	{   
		*(.text)
	}

	.rodata ALIGN(0x1000) :
	{
		*(.rodata*)
	}

	.data ALIGN(0x1000) :
	{  
		*(.data)
	}

	.bss :
	{
		_sbss = .;
		*(COMMON)
		*(.bss)
		_ebss = .;
	}
}

