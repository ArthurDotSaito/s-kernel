#include "kheap.h"
#include "heap.h"
#include "config.h"
#include "kernel.h"

struct heap kernel_heap;

struct heap_table kernel_heap_table;

void kheap_init()
{
    int total_table_entries = SOS_HEAP_SIZE_BYTES / SOS_HEAP_BLOCK_SIZE;
    kernel_heap_table.entries = (HEAP_BLOCK_TABLE_ENTRY *)(SOS_HEAP_TABLE_ADDRESS);
    kernel_heap_table.total = total_table_entries;

    void *end = (void *)(SOS_HEAP_ADDRESS + SOS_HEAP_SIZE_BYTES);
    int res = heap_create(&kernel_heap, (void *)(SOS_HEAP_ADDRESS), end, &kernel_heap_table);
    if (res < 0)
    {
        print("Panic! Failed to create heap!\n");
    }
}

void *kmalloc(size_t size)
{
    return heap_malloc(&kernel_heap, size);
}