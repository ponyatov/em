/* generic i486sx @ retro PC (Vortex86SX @ PC104) */

MEMORY
{
    /* ROM/Flash memory region (typically 512KB-1MB) */
    ROM (rx)  : ORIGIN = 0x00000000, LENGTH = 512K
    /* RAM region (typically 64KB-128KB for older i486/Vortex86SX systems) */
    RAM (rwx) : ORIGIN = 0x00100000, LENGTH = 64K
}
