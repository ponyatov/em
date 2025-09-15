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
    touch(f'{name}/.gitignore', '!.gitignore')


def meld(here,em):
    os.system(f'meld {here} {em} &')

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


def hw():
    mkdir('hw')
    mkdir('hw/inc')
    touch('hw/inc/hw.hpp')
    mkdir('hw/src')


def cpu():
    mkdir('cpu')
    mkdir('cpu/inc')
    touch('cpu/inc/cpu.hpp')
    mkdir('cpu/src')


def arch():
    mkdir('arch')
    mkdir('arch/inc')
    touch('arch/inc/arch.hpp')
    mkdir('arch/src')


def os_():
    mkdir('os')
    mkdir('os/inc')
    touch('os/inc/os.hpp')
    mkdir('os/src')


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


doxy()
meld('.doxygen','~/em/.doxygen')

os.system(f'git add -A ; git commit -am "." ; pp')
