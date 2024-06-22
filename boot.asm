ORG 0
BITS 16

_start: 
    jmp short start
    nop

 times 33 db 0 

start:
    jmp 0x7c0:step2

step2:
    cli ; Clear all interrupts 
    mov ax, 0x07C0
    mov ds, ax
    mov es, ax
    mov ax, 0x00
    mov ss, ax
    mov sp, 0x7C00

    sti ; Enables all interrupts

    mov ah, 2 ; Read one sector
    mov al, 1 ; One sector to Read
    mov ch, 0 ; Cylinder 0
    mov cl, 2 ; Sector 2
    mov dh, 0 ; Head 0
    mov bx, buffer ; Buffer to read to
    int 0x13
    jc error

    mov si , buffer
    call print
    
    jmp $

error:
    mov si, error_message
    call print
    jmp $

print:
    mov bx, 0

.loop:
    lodsb 
    cmp al, 0
    je .done
    call print_char
    jmp .loop

.done:
    ret

print_char:
    mov ah, 0eh
    int 0x10
    ret

error_message: db 'Failed to load sector', 0


times 510 - ($ - $$) db 0
dw 0xaa55
    
buffer:
