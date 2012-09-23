OUTPUT_FORMAT("elf32-i386")
ENTRY(loader)

virt = 0xC0000000; /* 3 gig */
phys = 0x100000; /* 1 meg */

SECTIONS
{
	. = phys;
	
	.setup :
	{
		*(.setup)
	}
	
	. += virt;
	
	.text virt : AT(ADDR(.text) - virt)
        {   
                *(.text)
	}
            
	.data ALIGN(4096) :  AT(ADDR(.data) - virt)
	{  
                *(.data)
                *(.rodata)
	}

	.bss ALIGN(4096) :  AT(ADDR(.bss) - virt)
        {
		*(.bss)
		*(COMMON)
	}
}

