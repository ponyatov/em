# `embxx`
## [[Cpp/Embedded C++]] Library

## [[Alex Robenko]]

https://github.com/arobenko/embxx

[[embxx]] is [[em/embedded|embedded]] [[Cpp/C++|C++]] library that is developed with intetion to be used in [[bare-metal]] and [[Linux/Linux|Linux]] based embedded environments. It comes to supplement essential functionality that is missing in widely used [[Cpp/STL|STL]] and [[Boost]] C++ libraries.

[[embxx]] doesn't use "[[Cpp/RTTI|RTTI]]" and "[[Exceptions]]". It makes a significant effort to completely eliminate or minimise usage of [[Dynamic Memory Allocation]] in order to make it usable with embedded system with low memory footprint and/or slow [[hw/CPU|CPU]]s.

## [[hw/Raspberry#Pi]]

http://github.com/arobenko/embxx_on_rpi

There is also a project that implements multiple simple [[bare-metal]] applications using [embxx](https://github.com/arobenko/embxx) which can run on [[Raspberry#Pi]] platform. The source code can be found at [https://github.com/arobenko/embxx_on_rpi](https://github.com/arobenko/embxx_on_rpi). It also has GPLv3 licence.

## [[doxygen/doxygen|doxygen]]

The [[embxx]] library has [[doxygen/doxygen|doxygen]] generated documentation. It can be found at [release artifacts](https://github.com/arobenko/embxx/releases).
