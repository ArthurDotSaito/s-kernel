#include "heap.h"
#include "kernel.h"
#include <stdbool.h>
#include "status.h"

static int heap_validate_alignment(void *ptr)
{
    return ((unsigned int)ptr % SOS_HEAP_BLOCK_SIZE) == 0;
}

/*
When I want to create a new heap, I should pass a blank heap struct, a pointer to start address
a poiter to the most right address and a valid heap table.
 */

int heap_create(struct heap *heap, void *ptr, void *end, struct heap_table *table)
{
    int res = 0;

    if (!heap_validate_alignment(ptr) || !heap_validate_alignment(end))
    {
        res = -EINVARG;
        goto out;
    }

out:
    return res;
}