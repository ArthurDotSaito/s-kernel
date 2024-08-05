#ifndef CONFIG_H
#define CONFIG_H

#define SOS_TOTAL_INTERRUPTS 512
#define KERNEL_CODE_SELECTOR 0x08
#define KERNEL_DATA_SELECTOR 0x10

// This should be enough for 4096 byte entry ~100Mb heap size.
#define SOS_HEAP_SIZE_BYTES 104857600
#define SOS_HEAP_BLOCK_SIZE 4096
#define SOS_HEAP_ADDRESS 0x01000000
#define SOS_HEAP_TABLE_ADDRESS 0x00007E00

#endif