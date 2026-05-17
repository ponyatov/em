# import re
# import sys
import os
import datetime as dt

# @defgroup about about
# @{

APP = 'FORTH'
VERSION = '0.0.1'
TITLE = 'ASAP script language'
ABOUT = '''
- FORTH-like core
- Python as prototype language
- single weekend script 
'''

AUTHOR = 'Dmitry Ponyatov'
EMAIL = 'dponyatov@gmail.com'
YEAR = dt.date.today().year
LICENSE = 'MIT'

APP_ = APP.lower()
USER = os.getenv('USER')

print('-'*66)
print(f'  {APP} {VERSION} (c) {AUTHOR} <{EMAIL}> {YEAR} {LICENSE}')
print(f'  {TITLE} / weekend Python prototype /')
print('-'*66)

# @}


class Object:
    "object graph node: root class for all system elements"

    def __init__(self, V):
        # scalar: name of literal value
        self.value = V
        # attributes
        self.slot = {}
        # ordered: nested elements
        self.nest = []

    def __repr__(self): return self.head()

    def head(self):
        "<T:V> @id"
        return f'<{self.tag()}:{self.val()}> @{hash(self):x}'

    def tag(self):
        "<T:"
        return self.__class__.__name__.lower()

    def val(self):
        ":V>"
        return f'{self.value}'

    # evaluate node in context
    def eval(self, env=None): return self
    ##
    def __call__(self, env=None): return self.eval(env)


hello = Object('Hello')
hello
hello()


class Container(Object):
    pass


class Stack(Container):
    pass


D = Stack('data')
D
R = Stack('return')
R


class Active(Object):
    "EDS: Executable Data Structure"
    pass


class Command(Active):
    "VM command"

    def __init__(self): super().__init__(self.tag())
    def tag(self): return 'command'
    def __call__(self): self.fn()


class dump(Command):
    def fn(self): print(D)


dump()
dump()()
