import os
import sys
import re


def mkdir(d):
    try:
        os.mkdir(d)
    except:
        pass


def dirs():
    for d in ['.vscode', 'bin', 'doc', 'lib', 'inc', 'src', 'tmp']:
        mkdir(d)


dirs()
