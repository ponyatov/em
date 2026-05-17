# ARM Semihosting
## [[ADS Debug Target Guide]]

- https://interrupt.memfault.com/blog/arm-semihosting
- https://mcuoneclipse.com/2023/03/09/using-semihosting-the-direct-way/
- https://developer.arm.com/documentation/dui0058/d/semihosting

> [[semihosting]] is a mechanism for [[hw/arch/ARM|ARM]] targets to communicate input/output requests from application code to a host computer running a [[lang/debugger|debugger]].

```cmake
add_link_options(
    -mthumb
    -T ${CMAKE_SOURCE_DIR}/hw/${HW}/${CPU_}x_FLASH.ld
    # --specs=nano.specs
    --specs=nosys.specs -lrdimon
    -Wl,--start-group -lc -lm -lnosys   -Wl,--end-group
    -Wl,--start-group -lstdc++ -lsupc++ -Wl,--end-group
    -Wl,-Map=${CMAKE_PROJECT_NAME}.map -Wl,--gc-sections
)
```
```c
#ifdef __cplusplus
extern "C" {
#else
extern
#endif
void initialise_monitor_handles(void);
```
```c
void setup() {  //
    initialise_monitor_handles();
}
```

## Semihosting implementation

```c
/* File operations */
SYS_OPEN        EQU 0x01 //Open a file or stream on the host system.
SYS_ISTTY       EQU 0x09 //Check whether a file handle is associated with a file or a stream/terminal such as stdout.
SYS_WRITE       EQU 0x05 //Write to a file or stream.
SYS_READ        EQU 0x06 //Read from a file at the current cursor position.
SYS_CLOSE       EQU 0x02 //Closes a file on the host which has been opened by SYS_OPEN.
SYS_FLEN        EQU 0x0C //Get the length of a file.
SYS_SEEK        EQU 0x0A //Set the file cursor to a given position in a file.
SYS_TMPNAM      EQU 0x0D //Get a temporary absolute file path to create a temporary file.
SYS_REMOVE      EQU 0x0E //Remove a file on the host system. Possibly insecure!
SYS_RENAME      EQU 0x0F //Rename a file on the host system. Possibly insecure!
```
```c
/* Terminal I/O operations */
SYS_WRITEC      EQU 0x03 //Write one character to the debug terminal.
SYS_WRITE0      EQU 0x04 //Write a 0-terminated string to the debug terminal.
SYS_READC       EQU 0x07 //Read one character from the debug terminal.
```
```c
/* Time operations */
SYS_CLOCK       EQU 0x10
SYS_ELAPSED     EQU 0x30
SYS_TICKFREQ    EQU 0x31
SYS_TIME        EQU 0x11
```
```c
/* System/Misc. operations */
SYS_ERRNO       EQU 0x13 //Returns the value of the C library errno variable that is associated with the semihosting implementation.
SYS_GET_CMDLINE EQU 0x15 //Get commandline parameters for the application to run with (argc and argv for main())
SYS_HEAPINFO    EQU 0x16
SYS_ISERROR     EQU 0x08
SYS_SYSTEM      EQU 0x12
```

## Adding an application SWI handler
## Semihosting SWIs
## Debug agent interaction SWIs.

## [[Introduction to ARM Semihosting]]

![[cortex_m_semihosting#Exception]]
