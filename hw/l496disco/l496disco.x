MEMORY
{
    FLASH (r x) : ORIGIN = 0x8000000 , LENGTH = 1024K
    RAM   (rwx) : ORIGIN = 0x20000000, LENGTH =  256K
    CCM   (rwx) : ORIGIN = 0x10000000, LENGTH =   64K
    XRAM  (rwx) : ORIGIN = 0x60000000, LENGTH =    8M   /* bank 2 rw SDRAM  */
}
