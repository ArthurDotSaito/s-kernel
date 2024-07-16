section .asm

global insb

insb:
    push ebp
    mov ebp, esp

    xor eax, eax
    mov edx, [ebp+8]
    in al, dx

    
    pop ebp
    ret