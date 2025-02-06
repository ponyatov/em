# ByteCode {#bc}

- dense code 
  - multi-stack virtual machine
    - single byte commands w/o operands
    - no stack smashing
- rich execution control
  - arbitrary debug features
  - hardware isolation
- multiplatform
  - fixed little-endian (as most used @ref arch es)
  - simpler compiler w/o any hw-specific hacks
  - code/data migration & persistence in heterogeneous clusters
- unlimited command set
  - application-/domain-specific extensions
  - architecture experimenting
