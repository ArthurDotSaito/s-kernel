#ifndef IDT_H
#define IDT_H

#include <stdint.h>

struct idt_desc
{
    uint16_t offset_1; // offset bits 0 - 15
    uint16_t selector;
    uint8_t zero;
    uint8_t type_attr;
    uint16_t offset_2; // offset bits 16-31
} __attribute__((packed));

struct idtr_desc
{
    uint16_t limit; // size of descriptor table
    uint32_t base;  // base address of the start of idt
} __attribute__((packed));

void idt_init();
void enable_interrupts();
void disable_interrupts();

#endif