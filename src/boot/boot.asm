ORG 0x7c00
BITS 16

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

_start: 
    jmp short start
    nop

 times 33 db 0 

start:
    jmp 0:step2

step2:
    cli             ; Clear all interrupts 
    mov ax, 0x00
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00
    sti             ; Enables all interrupts

.load_protected:
    cli
    lgdt[gdt_descriptor]
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    jmp CODE_SEG:load32

    jmp $

; GDT
gdt_start:
gdt_null:
    dd 0x0
    dd 0x0

; offset 0x8
gdt_code:
    dw 0xffff       ; limit low
    dw 0            ; base 0 to 15 bits
    db 0            ; base 16 to 23 bits
    db 0x9a         ; access byte
    db 11001111b    ; high 4 bit flags and low 4 bits flags
    db 0            ; base 24 to 31 bits

; offset 0x10
gdt_data:           ; DS, SS, ES, FS, GS
    dw 0xffff       ; limit low
    dw 0            ; base 0 to 15 bits
    db 0            ; base 16 to 23 bits
    db 0x92         ; access byte
    db 11001111b    ; high 4 bit flags and low 4 bits flags
    db 0            ; base 24 to 31 bits

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start
 
 [BITS 32]   
 load32:
    mov eax, 1
    mov ecx, 100
    mov edi, 0x0100000
    call ata_lba_read

ata_lba_read:
    mov ebx, eax   ; Just backup the LBA
    ; Send the highest 8bits of data from lba to disk controller
    shr eax, 24
    mov dx, 0x1F6
    out dx, al
    ; Finish sending highest 8bits

    ; Send the total sectors to read
    mov eax, ecx
    mov dx, 0x1F2
    out dx, al
    ; Finish sending total sectors to read

    ; Send more bits from the LBA
    mov eax, ebx
    mov dx, 0x1F3
    out dx, al
    ; Finish sending more bits to LBA

    ; Send more bits from the LBA
    mov dx, 0x1F4
    mov eax, ebx ; Restore backup the LBA
    shr eax, 8
    ou dx, al 
    ; Finish sending more bits to LBA

    ; Sending upper 16 bits from the LBA
    mov dx, 0x1F5
    mov eax, ebx ; Restore backup the LBA
    shr eax, 16
    ou dx, al 
    ; Finish sending upper 16 bits from the LBA

    mov dx, 0x1F7
    mov al, 0x20
    out dx, al

    ;Read all sectors into memory
.next_sector:
    push ecx

.try_again:
    mov dx, 0x1f7
    in al, dx
    test al, 8
    jz .try_again

    mov ecx, 256
    mov dx, 0x1F0
    rep insw
    pop ecx
    loop .next_sector
    ; End of reading sectors into memory
    ret

times 510 - ($ - $$) db 0
dw 0xaa55
    