ORG 0xc00
BITS 16

start:
    mov ah, 0eh
    mov al, 'A'
    mov bx, 0
    int 0x10

times 510 - ($ - $$) db 0
dw 0xaa55
    