ENTRY(_start)
OUTPUT_FORMAT(binary)
SECTIONS
{
    . = 1M;
    .text:
    {
        *(.text)
    }

    .rodada:
    {
        *(.rodada)
    }

    .data:
    {
        *(.data)
    }

    .bss:
    {
        *(COMMON)
        *(.bss)
    }
}