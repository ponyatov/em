import re
import sys
import os
import datetime as dt

AUTHOR = 'Dmitry Ponyatov'
EMAIL = 'dponyatov@gmail.com'
TITLE = 'bytecode language'
ABOUT = ''''''
VERSION = '0.0.1'
YEAR = dt.date.today().year
LICENSE = 'MIT'

APP = os.getcwd().split('/')[-1]
APP_ = APP.lower()
USER = os.getenv('USER')


def git():
    os.system(f'git remote add flic git@gitflic.ru:dponyatov/{APP_}.git')
    os.system(f'git remote add gh git@github.com:ponyatov/{APP_}.git')
    os.system(f'git checkout --orphan {USER}')
    os.system('ln -fs ../rc rc')
    os.system(f'git add -A ; git commit -am "." ; git push -uv gh {USER}')


git()


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


def readme():
    with open('README.md', 'w') as md:
        print(f'''# ![](vscode/logo.png) `{APP}` {VERSION}
## {TITLE}\n
(c) {AUTHOR} <<{EMAIL}>> {YEAR} {LICENSE}\n
github: https://github.com/ponyatov/bcl{APP_}''', file=md)


readme()


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

    def gen(self):
        c = self.__class__.__name__.lower()
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

    def gen(self):
        mkdir(f'cpu/{self.name}')
        mkdir(f'cpu/{self.name}/inc')
        mkdir(f'cpu/{self.name}/src')
        touch(f'cpu/{self.name}/inc/{self.name}.hpp',
              f'/// @defgroup {self.name} {self.name}\n/// @ingroup cpu\n')
        touch(f'cpu/{self.name}/src/{self.name}.cpp')
        touch(f'cpu/{self.name}/{self.name}.mk', f'ARCH = {self.arch}\n')
        return self


CPU.gendir(CPU)


class ARCH(Cross):
    def __init__(self, name, os, qemu):
        super().__init__(name)
        self.os = os
        self.qemu = qemu

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
APT    += qemu-system-{self.qemu[0]}{gdb}
QEMU    = qemu-system-{self.qemu[1]}
''')
        return self


ARCH.gendir(ARCH)


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

i386 = ARCH('i386', os=linux, qemu=['x86', 'i386']).gen()
x86_64 = ARCH('x86_64', os=linux, qemu=['x86', 'x86_64']).gen()
armv7 = ARCH('armv7', os=linux, qemu=['arm', 'arm']).gen()
aarch64 = ARCH('aarch64', os=linux, qemu=['arm', 'aarch64']).gen()

cortexm = ARCH('cortexm', os=none).gen()
cortexm0 = ARCH('cortexm0', os=none).gen()
cortexm3 = ARCH('cortexm3', os=none).gen()
cortexm4 = ARCH('cortexm4', os=none).gen()

xtensa = ARCH('xtensa', os=freertos).gen()

i486 = CPU('i486', arch=i386).gen()
i686 = CPU('i686', arch=i386).gen()
i5 = CPU('i5', arch=x86_64).gen()

bcm2837 = CPU('bcm2837', arch=armv7).gen()
rk3399 = CPU('rk3399', arch=aarch64).gen()
bcm2711 = CPU('bcm2711', arch=aarch64).gen()
bcm2712 = CPU('bcm2712', arch=aarch64).gen()

stm32f030f4 = CPU('stm32f030f4', arch=cortexm0).gen()
stm32f103c8 = CPU('stm32f103c8', arch=cortexm3).gen()
stm32f405rg = CPU('stm32f405rg', arch=cortexm4).gen()
stm32f407vg = CPU('stm32f407vg', arch=cortexm4).gen()
stm32f429zi = CPU('stm32f429zi', arch=cortexm4).gen()
stm32l496ag = CPU('stm32l496ag', arch=cortexm4).gen()
stm32f411ce = CPU('stm32f411ce', arch=cortexm4).gen()

lm3s6965 = CPU('lm3s6965', arch=cortexm3).gen()

lx106 = CPU('lx106', arch=xtensa).gen()
lx107 = CPU('lx107', arch=xtensa).gen()

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
iskra = HW('iskra', cpu=stm32f405rg).gen()
f4disco = HW('f4disco', cpu=stm32f407vg).gen()
f429disco = HW('f429disco', cpu=stm32f429zi).gen()
l496disco = HW('l496disco', cpu=stm32l496ag).gen()

HWcm = [pillf030, pillf103, lm3s6, iskra, f4disco, f429disco, l496disco]

esp8266 = HW('esp8266', cpu=lx106).gen()
esp32 = HW('esp32', cpu=lx107).gen()

HWesp = [esp8266, esp32]

HW = HWx86+HWrpi+HWcm+HWesp


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


def vsext():
    mkdir('vscode')
    os.system('cp ~/icons/triangle.png vscode/logo.png')
    for f in ['package.json',
              'languageConfiguration.json',
              'tmLanguage.json',
              'extension.js',]:
        touch(f'vscode/{f}')
    os.system('cp README.md vscode/README.md')


def vscode():
    vsjsons()
    vsext()


vscode()


def doxy():
    os.system('doxygen -l ; mv DoxygenLayout.xml doc/DoxygenLayout.xml')
    with open('.doxygen', 'w') as dx:
        print(f'''PROJECT_NAME           = "{APP}"
PROJECT_BRIEF          = "{TITLE}"
PROJECT_LOGO           = vscode/logo.png
LAYOUT_FILE            = doc/DoxygenLayout.xml
''', file=dx)
    touch(f'doc/{APP}.md')
    touch('doc/bytecode.md')
    touch('doc/FORTH.md')
    touch('doc/cp.md', '# concatenative programming\n')


def mk():
    # mkdir('mk')
    # with open('Makefile', 'w') as mk:
    #     for m in ['var', 'version', 'dir', 'tool', 'cross', 'pkg', 'src', 'all', 'format', 'rule', 'doc', 'ref', 'gz', 'install', 'ai']:
    #         touch(f'mk/{m}.mk')
    #         print(f'include mk/{m}.mk', file=mk)
    with open('mk/cross.mk', 'w') as c:
        print(f'HW ?= {HW[0]}', file=c)
        for h in HW[1:]:
            print(f'# HW ?= {h}', file=c)


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

os.system(f'git add -A ; git commit -am "." ; pp')
