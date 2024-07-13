#include "idt.h"
#include "config.h"

struct idt_desc idt_descriptors[SOS_TOTAL_INTERRUPTS];
struct idt_desc idtr_descriptor;

void idt_init()
{
}