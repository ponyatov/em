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
            touch(f'{d}/.gitignore', 'html/\n!.gitignore')
        if d in ['bin', 'tmp', 'ref']:
            touch(f'{d}/.gitignore', '*\n!.gitignore')


dirs()


def readme():
    with open('README.md', 'w') as md:
        print(f'''# ![](vscode/logo.png) `{APP}` {VERSION}
## {TITLE}

(c) {AUTHOR} <<{EMAIL}>> {YEAR} {LICENSE}

github: https://github.com/ponyatov/bcl{APP_}''', file=md)


readme()

HW = ['pc', 'qemu386', 'a7n8x',
      'rpi3bp', 'rpi4', 'rpi5', 'opi800',
      'lm3s6', 'pillf030', 'pillf103',
      'f4disco', 'f429disco', 'l496disco', 'iskra',
      'esp8266', 'esp32']


def hw():
    mkdir('hw')
    mkdir('hw/inc')
    touch('hw/inc/hw.hpp',
          f'/// @defgroup cross cross\n/// @defgroup hw hw\n/// @ingroup cross\n')
    mkdir('hw/src')
    for h in HW:
        mkdir(f'hw/{h}')
        touch(f'hw/{h}/{h}.mk')
        touch(f'hw/{h}/{h}.cmake')
        mkdir(f'hw/{h}/inc')
        touch(f'hw/{h}/inc/{h}.hpp',
              f'/// @defgroup {h} {h}\n/// @ingroup hw\n')
        mkdir(f'hw/{h}/src')
        touch(f'hw/{h}/src/{h}.cpp')
        if re.match(r'f.+|iskra|pill.+', h):
            touch(f'hw/{h}/{h}.ocd')
            touch(f'hw/{h}/{h}.ioc')


hw()


def cpu():
    mkdir('cpu')
    mkdir('cpu/inc')
    touch('cpu/inc/cpu.hpp', f'/// @defgroup cpu cpu\n/// @ingroup cross\n')
    mkdir('cpu/src')
    for c in ['i5', 'i486', 'i686', 'bcm2837', 'rk3399', 'stm32f496zi', 'stm32f405rg', 'stm32f103c8t', 'stm32f030f4p', 'lx106', 'lx107']:
        mkdir(f'cpu/{c}')
        touch(f'cpu/{c}/{c}.mk')
        touch(f'cpu/{c}/{c}.cmake')
        mkdir(f'cpu/{c}/inc')
        touch(f'cpu/{c}/inc/{c}.hpp')
        mkdir(f'cpu/{c}/src')
        touch(f'cpu/{c}/src/{c}.cpp')


cpu()


def arch():
    mkdir('arch')
    mkdir('arch/inc')
    touch('arch/inc/arch.hpp', f'/// @defgroup arch arch\n/// @ingroup cross\n')
    mkdir('arch/src')
    for a in ['x86_64', 'i386', 'armv7', 'aarch64', 'cortexm', 'cortexm0', 'cortexm3', 'cortexm4', 'xtensa']:
        mkdir(f'arch/{a}')
        if re.match(r'cortex\d', a):
            touch(f'arch/{a}/{a}.mk', 'include arch/cortexm.mk')
            touch(f'arch/{a}/{a}.cmake', 'include(arch/cortexm.cmake)')
        else:
            touch(f'arch/{a}/{a}.mk')
            touch(f'arch/{a}/{a}.cmake')
        mkdir(f'arch/{a}/inc')
        touch(f'arch/{a}/inc/{a}.hpp',
              f'/// @defgroup {a} {a}\n/// @ingroup arch\n')
        mkdir(f'arch/{a}/src')
        touch(f'arch/{a}/src/{a}.cpp')
        if a in ['x86_64', 'i386', 'armv7', 'aarch64']:
            touch(f'arch/{a}/{a}.kernel')
            touch(f'arch/{a}/{a}.uclibc')


arch()


def os_():
    mkdir('os')
    mkdir('os/inc')
    touch('os/inc/os.hpp', f'/// @defgroup os os\n/// @ingroup cross\n')
    touch(f'os/inc/libc.hpp')
    mkdir('os/src')
    for o in ['linux', 'win32', 'none', 'freertos']:
        mkdir(f'os/{o}')
        touch(f'os/{o}/{o}.mk')
        touch(f'os/{o}/{o}.cmake')
        mkdir(f'os/{o}/inc')
        touch(f'os/{o}/inc/{o}.hpp',
              f'/// @defgroup {o} {o}\n/// @ingroup os\n')
        mkdir(f'os/{o}/src')
        touch(f'os/{o}/src/{o}.cpp')
    touch(f'os/linux/all.kernel')
    touch(f'os/linux/all.uclibc')


os_()


def root():
    mkdir('root')
    mkdir('root/boot')
    mkdir('root/etc')


def cross():
    hw()
    cpu()
    arch()
    os_()
    root()


cross()


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

os.system(f'git add -A ; git commit -am "." ; pp')
