import re
import sys
import os
import datetime as dt

APP = os.getcwd().split('/')[-1]
TITLE = 'old-fashioned IDE with minimal CPU/RAM requirements'

AUTHOR = 'Dmitry Ponyatov'
EMAIL = 'dponyatov@gmail.com'
ABOUT = ''''''
VERSION = '0.0.1'
YEAR = dt.date.today().year
LICENSE = 'MIT'

APP_ = APP.lower()
USER = os.getenv('USER')


def touch(name, content=None):
    # if not os.path.exists(name):
    with open(name, 'w') as f:
        if content is not None:
            f.write(content)


def mkdir(name):
    try:
        os.mkdir(name)
    except FileExistsError:
        pass
    touch(f'{name}/.gitignore', '!.gitignore\n')


def meld(name):
    os.system(f'meld {name} ~/em/{name} &')


def dirs():
    for d in ['.vscode', 'bin', 'doc', 'lib', 'inc', 'src', 'tmp', 'ref']:
        mkdir(d)
        if d in ['doc']:
            touch(f'{d}/.gitignore', 'html/\n!.gitignore\n')
        if d in ['bin', 'tmp', 'ref']:
            touch(f'{d}/.gitignore', '*\n!.gitignore\n')


dirs()


def giti():
    touch('.gitignore', '''*~\n*.swp\n*.log\ntarget/\n!.gitignore\n''')


giti()


def readme():
    with open('README.md', 'w') as md:
        print(f'''# ![](vscode/logo.png) `{APP}` {VERSION}
## {TITLE}\n
(c) {AUTHOR} <<{EMAIL}>> {YEAR} {LICENSE}\n
github: https://github.com/ponyatov/{APP_}''', file=md)


readme()

def lic():
    touch('LICENSE',f'{LICENSE}\n\nCopyright (c) {YEAR} {AUTHOR} <{EMAIL}>\n')
    meld('LICENSE')

lic()

def git():
    os.system(f'git remote add flic git@gitflic.ru:dponyatov/{APP_}.git')
    os.system(f'git remote add gh git@github.com:ponyatov/{APP_}.git')
    os.system(f'git checkout --orphan {USER}')
    os.system('ln -fs ../rc rc')
    os.system(f'git add -A ; git commit -am "." ; git push -uv gh {USER}')


git()


class Cross:
    def __init__(self, name): self.name = name
    def __str__(self): return f'{self.name}'

    def gendir(c):
        c = c.__name__.lower()
        mkdir(f'{c}')
        mkdir(f'{c}/inc')
        mkdir(f'{c}/src')
        touch(f'{c}/inc/{c}.hpp', f'''/// @defgroup {c} {c}
/// @ingroup cross
''')

    def gen(self, c):
        mkdir(f'{c}/{self.name}')
        mkdir(f'{c}/{self.name}/inc')
        mkdir(f'{c}/{self.name}/src')
        touch(f'{c}/{self.name}/inc/{self.name}.hpp',
              f'/// @defgroup {self.name} {self.name}\n/// @ingroup {c}\n')
        touch(f'{c}/{self.name}/src/{self.name}.cpp')
        touch(f'{c}/{self.name}/{self.name}.mk')
        touch(f'{c}/{self.name}/{self.name}.cmake')
        return self


class HW(Cross):
    def __init__(self, name, cpu):
        super().__init__(name)
        self.cpu = cpu

    def gendir(c):
        super().gendir(c)
        touch('hw/inc/hw.hpp', '''/// @defgroup cross cross
/// @defgroup hw hw
/// @ingroup cross
''')

    def gen(self):
        super().gen()
        touch(f'hw/{self.name}/{self.name}.mk', f'CPU = {self.cpu}\n')
        return self


HW.gendir(HW)


class CPU(Cross):
    def __init__(self, name, arch):
        super().__init__(name)
        self.arch = arch
        self.series = ''

    def gen(self):
        super().gen('cpu')
        # touch(f'cpu/{self.name}/src/{self.name}.cpp')
        touch(f'cpu/{self.name}/{self.name}.mk', f'ARCH = {self.arch}\n')
        return self


CPU.gendir(CPU)


class CPUstm32(CPU):
    def __init__(self, name, arch):
        super().__init__(name, arch)
        self.series = re.findall(r'stm32..', self.name)[0]


class ARCH(Cross):
    def __init__(self, name, os, target, rtarget, qemu, apt=''):
        super().__init__(name)
        self.os = os
        self.qemu = qemu
        self.target = target
        self.rtarget = rtarget
        self.apt = apt

    def gen(self):
        mkdir(f'arch/{self.name}')
        mkdir(f'arch/{self.name}/inc')
        mkdir(f'arch/{self.name}/src')
        touch(f'arch/{self.name}/inc/{self.name}.hpp',
              f'/// @defgroup {self.name} {self.name}\n/// @ingroup arch\n')
        touch(f'arch/{self.name}/src/{self.name}.cpp')
        gdb = '' if self.name == 'x86_64' else ' gdb-multiarch'
        touch(f'arch/{self.name}/{self.name}.mk', f'''\
OS      = {self.os}
 TARGET = {self.target}
RTARGET = {self.rtarget}
APT    += qemu-system-{self.qemu[0]} gcc-{self.target}{gdb}{self.apt}
QEMU    = qemu-system-{self.qemu[1]}
''')
        return self


ARCH.gendir(ARCH)


class CM(ARCH):
    def __init__(self, name, rtarget):
        super().__init__(name, os=none, target='arm-none-eabi',
                         rtarget=rtarget, qemu=['arm', 'arm'])

    def gen(self):
        super().gen()
        touch(f'arch/{self.name}/inc/{self.name}.hpp',
              f'''/// @defgroup {self.name} {self.name}
/// @ingroup arch
#include "cortexm.hpp"
''')
        touch(f'arch/{self.name}/{self.name}.mk',
              f'include arch/cortexm/cortexm.mk\nRTARGET = {self.rtarget}\n')
        return self


class OS(Cross):
    def gen(self):
        mkdir(f'os/{self.name}')
        mkdir(f'os/{self.name}/inc')
        mkdir(f'os/{self.name}/src')
        touch(f'os/{self.name}/inc/{self.name}.hpp',
              f'/// @defgroup {self.name} {self.name}\n/// @ingroup os\n')
        touch(f'os/{self.name}/src/{self.name}.cpp')
        return self


OS.gendir(OS)


none = OS('none').gen()
linux = OS('linux').gen()
win32 = OS('win32').gen()
freertos = OS('freertos').gen()

OSall = [none, linux, win32, freertos]

i386 = ARCH('i386', os=linux, target='i686-linux-gnu',
            rtarget='i686-unknown-linux-gnu', qemu=['x86', 'i386']).gen()
x86_64 = ARCH('x86_64', os=linux, target='x86_64-linux-gnu',
              rtarget='x86_64-unknown-linux-gnu', qemu=['x86', 'x86_64'], apt=' g++ gdb').gen()
armv7 = ARCH('armv7', os=linux, target='arm-linux-gnueabihf',
             rtarget='armv7-unknown-linux-gnueabihf', qemu=['arm', 'arm']).gen()
aarch64 = ARCH('aarch64', os=linux, target='aarch64-linux-gnu',
               rtarget='aarch64-unknown-linux-gnu', qemu=['arm', 'aarch64']).gen()

ARCHx86 = [i386, x86_64]
ARCHrpi = [armv7, aarch64]

cortexm = ARCH('cortexm', os=none, target='arm-none-eabi', rtarget='thumbv6m-none-eabi',
               qemu=['arm', 'arm'], apt=' openocd stlink-tools dfu-util dos2unix stm32flash').gen()
cortexm0 = CM('cortexm0', rtarget='thumbv6m-none-eabi').gen()
cortexm3 = CM('cortexm3', rtarget='thumbv7m-none-eabi').gen()
cortexm4 = CM('cortexm4', rtarget='thumbv7em-none-eabi').gen()
cortexm4f = CM('cortexm4f', rtarget='thumbv7em-none-eabihf').gen()

ARCHcm = [cortexm0, cortexm3, cortexm4, cortexm4f]

xtensa = ARCH('xtensa', target='xtensa-lx106-elf',
              rtarget='xtensa-esp8266-none-elf', os=freertos, qemu=['misc', 'xtensa']).gen()

ARCHesp = [xtensa]

ARCHall = ARCHx86 + ARCHrpi + ARCHcm + ARCHesp

i486 = CPU('i486', arch=i386).gen()
i686 = CPU('i686', arch=i386).gen()
i5 = CPU('i5', arch=x86_64).gen()

CPUx86 = [i486, i686, i5]

bcm2837 = CPU('bcm2837', arch=armv7).gen()
rk3399 = CPU('rk3399', arch=aarch64).gen()
bcm2711 = CPU('bcm2711', arch=aarch64).gen()
bcm2712 = CPU('bcm2712', arch=aarch64).gen()

CPUrpi = [bcm2837, rk3399, bcm2711, bcm2712]

stm32f030f4 = CPUstm32('stm32f030f4', arch=cortexm0).gen()
stm32f103c8 = CPUstm32('stm32f103c8', arch=cortexm3).gen()
stm32f405rg = CPUstm32('stm32f405rg', arch=cortexm4).gen()
stm32f407vg = CPUstm32('stm32f407vg', arch=cortexm4).gen()
stm32f429zi = CPUstm32('stm32f429zi', arch=cortexm4).gen()
stm32l496ag = CPUstm32('stm32l496ag', arch=cortexm4).gen()
stm32f411ce = CPUstm32('stm32f411ce', arch=cortexm4).gen()

lm3s6965 = CPU('lm3s6965', arch=cortexm3).gen()

CPUcm = [
    stm32f030f4, stm32f103c8, stm32f405rg, stm32f407vg, stm32f429zi,
    stm32l496ag, stm32f411ce, lm3s6965
]

lx106 = CPU('lx106', arch=xtensa).gen()
lx107 = CPU('lx107', arch=xtensa).gen()

CPUesp = [lx106, lx107]

CPUall = CPUx86+CPUrpi+CPUcm+CPUesp

pc = HW('pc', cpu=i5).gen()
qemu386 = HW('qemu386', cpu=i486).gen()
a7n8x = HW('a7n8x', cpu=i686).gen()

HWx86 = [pc, qemu386, a7n8x]

rpi3bp = HW('rpi3bp', cpu=bcm2837).gen()
opi800 = HW('opi800', cpu=rk3399).gen()
rpi4 = HW('rpi4', cpu=bcm2711).gen()
rpi5 = HW('rpi5', cpu=bcm2712)

HWrpi = [rpi3bp, opi800, rpi4, rpi5]

pillf030 = HW('pillf030', cpu=stm32f030f4).gen()
pillf103 = HW('pillf103', cpu=stm32f103c8).gen()
lm3s6 = HW('lm3s6', cpu=lm3s6965).gen()
netduino2 = HW('netduino2', cpu=stm32f103c8).gen()
netduinoplus2 = HW('netduinoplus2', cpu=stm32f405rg).gen()
iskra = HW('iskra', cpu=stm32f405rg).gen()
f4disco = HW('f4disco', cpu=stm32f407vg).gen()
f429disco = HW('f429disco', cpu=stm32f429zi).gen()
l496disco = HW('l496disco', cpu=stm32l496ag).gen()

HWcm = [pillf030, pillf103, lm3s6, netduino2, netduinoplus2,
        iskra, f4disco, f429disco, l496disco]

esp8266 = HW('esp8266', cpu=lx106).gen()
esp32 = HW('esp32', cpu=lx107).gen()

HWesp = [esp8266, esp32]

HWall = HWx86+HWrpi+HWcm+HWesp


def root():
    mkdir('root')
    mkdir('root/boot')
    mkdir('root/etc')
    mkdir('root/isolinux')
    touch('root/isolinux/isolinux.cfg')


root()


def vsjsons():
    mkdir('.vscode')
    for j in ['c_cpp_properties',
              'launch',
              'extensions',
              'tasks',
              'settings'
              ]:
        touch(f'.vscode/{j}.json')
    meld('.vscode')

vsjsons()


def vsext():
    mkdir('vscode')
    os.system('cp ~/icons/triangle.png vscode/logo.png')
    for f in ['package.json',
              'languageConfiguration.json',
              'tmLanguage.json',
              'extension.js',]:
        touch(f'vscode/{f}')
    os.system('cp README.md vscode/README.md')

vsext()


def doxy():
    os.system('doxygen -l ; mv DoxygenLayout.xml doc/DoxygenLayout.xml')
    with open('.doxygen', 'w') as dx:
        print(f'''PROJECT_NAME           = "{APP}"
PROJECT_BRIEF          = "{TITLE}"
PROJECT_LOGO           = vscode/logo.png
LAYOUT_FILE            = doc/DoxygenLayout.xml
''', file=dx)
    meld('.doxygen')
    os.system(f'cd doc ; ln -fs ../README.md {APP}.md')
    touch('doc/bytecode.md','# bytecode\n')
    touch('doc/FORTH.md','# FORTH\n')
    touch('doc/cp.md', '# concatenative programming\n')

doxy()

def mk():
    mkdir('mk')
    with open('Makefile', 'w') as mk:
        for m in ['var', 'version', 'dir', 'tool', 'cross', 'pkg', 'src', 'all', 'format', 'rule', 'doc', 'ref', 'gz', 'install', 'ai']:
            touch(f'mk/{m}.mk')
            print(f'include mk/{m}.mk', file=mk)
    meld('mk')
    # with open('mk/cross.mk', 'w') as c:
    #     print(f'HW ?= {HW[0]}', file=c)
    #     for h in HW[1:]:
    #         print(f'# HW ?= {h}', file=c)

mk()

meld('mk/cross.mk')

meld('mk')


def cmake():
    mkdir('cmake')
    # touch('CMakeLists.txt')
    # touch('CMakePresets.json')
    for cm in ['any_toolchain',
               'x86_64-linux-gnu',
               'armv7-linux-gnu',
               'aarch64-linux-gnu',
               'i686-w64-mingw32',
               'arm-none-eabi',
               'xtensa-lx106-elf',
               'cross', 'clean', 'bytecode', 'src', 'syntax',
               'version', 'install',]:
        touch(f'cmake/{cm}.cmake')


cmake()
# meld('CMakeLists.txt')
# meld('CMakePresets.json')
meld('cmake')

doxy()
meld('.doxygen', '~/em/.doxygen')


def cli():
    mkdir('lib/cli')
    mkdir('lib/cli/inc')
    touch('lib/cli/inc/cli.hpp', f'/// @defgroup cli cli\n/// @ingroup lib\n')
    mkdir('lib/cli/src')
    touch('lib/cli/src/cli.cpp')
    touch('lib/cli/src/cli.lex')
    touch('lib/cli/src/cli.yacc')
    for n in ['num', 'dec', 'hex', 'oct', 'bin']:
        touch(f'lib/cli/src/{n}.ragel')


cli()
meld('lib/cli')


def vm():
    mkdir('lib/vm')
    mkdir('lib/vm/inc')
    touch('lib/vm/inc/vm.hpp', f'/// @defgroup vm vm\n/// @ingroup cli\n')
    mkdir('lib/vm/src')
    touch('lib/vm/src/vm.cpp')


vm()
meld('lib/vm')


def lib():
    mkdir('lib')
    mkdir('lib/inc')
    touch('lib/inc/lib.hpp', f'/// @defgroup lib lib\n')
    touch(f'lib/{APP}.ini')
    cli()
    vm()


lib()
os.system(f'meld lib/{APP}.ini ~/em/lib/em.ini &')


def dots():
    for i in ['.clang-format', '.prettierrc', '.gitattributes']:
        os.system(f'cp ~/em/{i} {i}')


dots()


def apt():
    touch('apt.Debian')


apt()
meld('apt.Debian')


def rust_main():
    touch('src/main.rs', '''mod config;\nmod vm;\n
use memmap2::Mmap;
use std::fs::File;
use std::io;
use std::io::Write;
use std::path::Path;\n
fn main() {
    let argv: Vec<String> = std::env::args().collect();
    let _argc = argv.len();
    arg(0, &argv[0]);
    for (argc, argv) in argv.iter().enumerate().skip(1) {
        arg(argc, argv);
        let file = File::open(Path::new(argv)).unwrap();
        let src = unsafe { Mmap::map(&file).unwrap() };
        eprintln!("\\tsize: {} bytes", src.len());
    }
}\n
fn arg(argc: usize, argv: &str) {
    eprintln!("argv[{argc}] = {argv:?}");
}
''')


rust_main()


def rust():
    mkdir('.cargo')
    touch('.cargo/config.toml', '//! shared config\n')
    mkdir('src')
    rust_main()
    touch('src/config.rs')
    touch('src/lib.rs')
    touch('src/server.rs', '//! HTTP control server\n')
    touch('src/vm.rs')
    hw = '# hw\n'
    for h in HWall:
        hw += f'{str(h):<23} = ["{h.cpu}"]\n'
    cpu = '# cpu\n'
    for h in CPUall:
        cpu += f'{str(h):<23} = ["{h.series if h.series else h.arch}"]\n'
    arch = '# arch\n'
    for h in ARCHall:
        arch += f'{str(h):<23} = ["{h.os}"]\n'
    os = '# os\n'
    for h in OSall:
        os += f'{str(h):<23} = []\n'
    touch('Cargo.toml', f'''[package]
name                    =  "{APP_}"
version                 =  "{VERSION}"
description             =  "{TITLE}"
authors                 = ["{AUTHOR} <{EMAIL}>"]
license                 =  "{LICENSE}"
repository              =  "https://github.com/ponyatov/{APP_}"
edition                 =  "2024"
#
[[bin]]
name                    = "main"
path                    = "src/main.rs"
#
[[bin]]
name                    = "server"
path                    = "src/server.rs"
#
[dependencies]
const_format            = "0.2"
#
[target.'cfg(target_os = "linux")'.dependencies]
libc                    = "0.2"
memmap2                 = "0.9"
#
[target.'cfg(target_arch = "arm")'.dependencies]
cortex-m                = "0.7"
cortex-m-rt             = "0.7"
cortex-m-semihosting    = "0.5"
panic-semihosting       = "0.6"
#
stm32f1                 = {{version="0.16",optional = true}}
stm32f1xx-hal           = {{version="0.10",optional = true}}
stm32f4                 = {{version="0.16",optional = true}}
stm32f4xx-hal           = {{version="0.22",optional = true}}
stm32l4                 = {{version="0.16",optional = true}}
stm32l4xx-hal           = {{version="0.7" ,optional = true}}
#
[features]
{hw}
{cpu}
{arch}
{os}
''')


rust()

os.system(f'git add -A ; git commit -am "." ; pp')
