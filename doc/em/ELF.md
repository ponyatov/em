# ELF
## Executable and Linking Format
### [[libelf]]

![[FreeBSD#3.0]]

## [[Linux/Linux|Linux]]
## [[hw/arch/ARM|ARM]]

https://github.com/ARM-software/abi-aa/releases/download/2022Q1/aaelf32.pdf

- .[[ARM.attributes]]
- .[[ARM.extab]]

## 32
## 64

## magic
- [Эльфы и пингвины: что такое ELF и как он работает](https://habr.com/ru/companies/timeweb/articles/784534/)

```
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
```
- `7F` 'ELF'

## initialization
### termination

- [[init_array#.init and . fini]]

tags:
- `DT_INIT`
- `DT_FINI`

## VMA
### Virtual Memory Address
## LMA
### Load Memory Address
