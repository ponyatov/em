# [[Infeneon]] AURIX

- [[TC375]]

## [[PXROS-HR]]

## [[Rust]] Startup Ecosystem
![[HighTec]]
![](https://hightec-rt.com/images/news/rust_ecosystem-1.png)

- Peripheral Access Crate ([[PAC]]) from [[Infineon]] allowing direct peripheral access for Rust.
- Rust specific peripheral low-level drivers from [[Bluewind]] written in native Rust.
- A precompiled version of [[PXROS-HR]] from [[HighTec]], an [[ASIL#D]] multicore [[RTOS]] with a [[Rust]] wrapper on top.
- A Rust runtime from [[Veecle]] (NOS) that integrates with PXROS-HR and allows writing of modern event drive software in Rust for AURIX.
- HighTec offers a combined package of the AURIX Rust and C/C++ compiler allowing to build projects with Rust and C/C++ sources.
	- The package also includes [[cargo]], the Rust build system and package manager to access all resources that come with the [[AURIX#Rust Startup Ecosystem]].
- A set of different example projects, ready to run on a [[TC375 Lite Kit]] completes this package, and includes bare metal examples, or complex Rust / C/C++ examples.
