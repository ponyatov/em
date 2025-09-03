/* generic i486sx @ retro PC (Vortex86SX @ PC104) */

MEMORY
{
    /* ROM/Flash memory region (typically 512KB-1MB) */
    ROM (rx)  : ORIGIN = 0x00000000, LENGTH = 512K
    /* VGA text  videomemory */
    TGA (rx)  : ORIGIN = 0x000B8000, LENGTH = 80*25*2
    /* VGA graph videomemory */
    VGA (rx)  : ORIGIN = 0x000A0000, LENGTH = 64K
    /* RAM region (typically 64KB-128KB for older i486/Vortex86SX systems) */
    RAM (rwx) : ORIGIN = 0x00100000, LENGTH = 64K
}
