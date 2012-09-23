#include <util.h>
#include <idt.h>

/* Use this function to set an entry in the IDT. */
void idt_set_gate(idt_entry idt[], unsigned char num, unsigned long base,
                  unsigned short sel, unsigned char flags)
{
    /* take the
    *  argument 'base' and split it up into a high and low 16-bits,
    *  storing them in idt[num].base_hi and base_lo. The rest of the
    *  fields that you must set in idt[num] are fairly self-
    *  explanatory when it comes to setup */
	idt[num].base_lo = (base & 0x0000FFFF);
	idt[num].base_hi = (base & 0xFFFF0000) >> 0x10;
	idt[num].sel     = sel;
	idt[num].flags   = flags;
}

void idt_load(idt_ptr* ptr)
{
	__asm__( "lidt (%0)" : : "r"(ptr) );
}

/* Installs the IDT */
void idt_install(idt_ptr idtp, idt_entry idt[])
{
    /* Sets the special IDT pointer up, just like in 'gdt.c' */
    idtp.limit = (sizeof (idt_entry) * 256) - 1;
    idtp.base = idt;

    /* Clear out the entire IDT, initializing it to zeros */
    memset(idt, 0, sizeof(idt_entry) * 256);

    /* Add any new ISRs to the IDT here using idt_set_gate */

    /* Points the processor's internal register to the new IDT */
    idt_load(&idtp);
}

