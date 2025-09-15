import os
import re
import sys


def touch(name, content=None):
    if not os.path.exists(name):
        with open(name, 'w') as f:
            if content is not None:
                print(content, file=f)


def mkdir(name):
    def mkdir_(name):
        try:
            os.mkdir(name)
        except FileExistsError:
            pass
        with open(f'{name}/.gitignore', 'w') as giti:
            if name in ['bin', 'tmp', 'ref', 'root']:
                print('*', file=giti)
            if name in ['doc']:
                print('html/', file=giti)
            print('!.gitignore', file=giti)

    def tree_(name):
        ret = []
        curr = ''
        for d in name.split('/'):
            if curr:
                curr = f'{curr}/{d}'
            else:
                curr = d
            ret.append(curr)
        return ret
    for d in tree_(name):
        mkdir_(d)


def dirs():
    for d in ['.vscode', 'vscode', 'bin', 'doc', 'lib', 'inc', 'src', 'tmp']:
        mkdir(d)


def hw():
    mkdir('hw')
    mkdir('hw/inc')
    touch('hw/inc/hw.hpp')
    mkdir('hw/src')
    for h in ['pc', 'rpi3bp', 'opi800', 'f429disco', 'l496disco', 'iskra', 'pillf030', 'pillf103', 'esp8266', 'esp32']:
        mkdir(f'hw/{h}')
        touch(f'hw/{h}/{h}.mk')
        touch(f'hw/{h}/{h}.cmake')
        mkdir(f'hw/{h}/inc')
        touch(f'hw/{h}/inc/{h}.hpp')
        mkdir(f'hw/{h}/src')
        touch(f'hw/{h}/src/{h}.cpp')
        if re.match(r'f.+|iskra', h):
            touch(f'hw/{h}/{h}.ocd')
            touch(f'hw/{h}/{h}.ioc')


def cpu():
    mkdir('cpu')
    mkdir('cpu/inc')
    touch('cpu/inc/cpu.hpp')
    mkdir('cpu/src')
    for c in ['i5', 'i486', 'i686', 'bcm2837', 'rk3399', 'stm32f496zi', 'stm32f103c8t', 'stm32f030f4p', 'lx106', 'lx107']:
        mkdir(f'cpu/{c}')
        touch(f'cpu/{c}/{c}.mk')
        touch(f'cpu/{c}/{c}.cmake')
        mkdir(f'cpu/{c}/inc')
        touch(f'cpu/{c}/inc/{c}.hpp')
        mkdir(f'cpu/{c}/src')
        touch(f'cpu/{c}/src/{c}.cpp')


def arch():
    mkdir('arch')
    mkdir('arch/inc')
    touch('arch/inc/arch.hpp')
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
        touch(f'arch/{a}/inc/{a}.hpp')
        mkdir(f'arch/{a}/src')
        touch(f'arch/{a}/src/{a}.cpp')
        if a in ['x86_64', 'i386', 'armv7', 'aarch64']:
            touch(f'arch/{a}/{a}.kernel')
            touch(f'arch/{a}/{a}.uclibc')


def os_():
    mkdir('os')
    mkdir('os/inc')
    touch('os/inc/os.hpp')
    mkdir('os/src')
    for o in ['linux', 'win32', 'none', 'freertos']:
        mkdir(f'os/{o}')
        touch(f'os/{o}/{o}.mk')
        if o in ['linux', 'win32']:
            touch(f'os/{o}/{o}.cmake', 'include(os/posix/posix.cmake)')
        else:
            touch(f'os/{o}/{o}.cmake')
        mkdir(f'os/{o}/inc')
        touch(f'os/{o}/inc/{o}.hpp')
        mkdir(f'os/{o}/src')
        touch(f'os/{o}/src/{o}.cpp')
    touch(f'os/linux/all.kernel')
    touch(f'os/linux/all.uclibc')


def etc():
    mkdir('root/etc')
    touch('root/etc/fstab')
    touch('root/etc/inittab')
    os.system('git add -f root/etc')


def boot():
    mkdir('root/boot')
    mkdir('root/isolinux')
    touch('root/isolinux/isolinux.cfg')
    os.system('git add -f root/boot root/isolinux')


def root():
    mkdir('root')
    touch('root/.gitignore', '*')
    os.system('git add -f root/.gitignore')
    etc()
    boot()


def cross():
    hw()
    cpu()
    arch()
    os_()
    root()


def vscode():
    mkdir('.vscode')
    mkdir('vscode')
    for j in ['c_cpp_properties',
              'launch',
              'extensions',
              'tasks',
              'settings'
              ]:
        touch(f'.vscode/{j}.json')


def mklib(name):
    mkdir(f'lib/{name}/inc')
    mkdir(f'lib/{name}/src')
    touch(f'lib/{name}/inc/{name}.hpp')
    touch(f'lib/{name}/src/{name}.cpp')


def bcx():
    mklib('bcx')


def lib():
    bcx()


def mk():
    mkdir('mk')
    with open('Makefile', 'w') as mk:
        for m in ['var', 'version', 'dir', 'tool', 'src', 'cfg', 'all', 'format', 'rule', 'doc', 'ref', 'gz', 'install']:
            touch(f'mk/{m}.mk')
            print(f'include mk/{m}.mk', file=mk)


def cmake():
    mkdir('cmake')
    touch('CMakeLists.txt')
    touch('CMakePresets.json')
    for cm in ['any_toolchain',
               'x86_64-linux-gnu', 'i686-w64-mingw32',
               'aarch64-linux-gnu', 'armv7-linux-gnu',
               'arm-none-eabi', 'xtensa-lx106-elf', 'avr-none',
               'syntax', 'version', 'install',
               'cross', 'clean', 'src', 'bytecode'
               ]:
        touch(f'cmake/{cm}.cmake')


if __name__ == '__main__':
    dirs()
    cross()
    vscode()
    lib()
    mk()
    cmake()
