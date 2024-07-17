section .asm

extern init21h_handler

global int21h
global idt_load

idt_load:
    push ebp
    mov ebp, esp

    mov ebx, [ebp+8]
    lidt [ebx]

    pop ebp
    ret

init21h:
    cli
    pushad
    call int21h_handler
    popad
    sti
    iret