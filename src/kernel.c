#include "kernel.h"

uint16_t *video_mem = 0;

uint16_t terminal_make_char(char c, char color)
{
    return color << 8 | c;
}

void terminal_initialize()
{
    video_mem = (uint16_t *)(0xb8000);
    for (int y = 0; y < VGA_HEIGHT; y++)
    {
        for (int x = 0; x < VGA_HEIGHT; x++)
        {
            video_mem[(y * VGA_WIDTH + x)] = terminal_make_char(' ', 0);
        }
    }
}

void kernel_main()
{
    terminal_initialize();
    video_mem[0] = terminal_make_char('B', 4);
}