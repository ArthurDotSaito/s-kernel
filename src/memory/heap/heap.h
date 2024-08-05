#ifndef HEAP_H
#define HEAP_H

#include "config.h"
#include "stdint.h"
#include "stddef.h"

#define HEAP_BLOCK_TABLE_ENTRY_TAKEN 0x01
#define HEAP_BLOCK_ENTRY_FREE 0X00

#define HEAP_BLOCK_HAS_NEXT 0b10000000
#define HEAP_BLOCK_IS_FREE 0b010000000

typedef unsigned char HEAP_BLOCK_TABLE_ENTRY;

struct heap_table
{
    HEAP_BLOCK_TABLE_ENTRY *entries;
    size_t total;
};

struct heap
{
    struct heap_table *table;
    void *saddr; // This is the first address of heap data pool.
};

#endif