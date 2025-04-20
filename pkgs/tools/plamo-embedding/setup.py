#!/usr/bin/env python

from setuptools import setup, find_packages

setup(name='plamo-embedding',
      version='1.0',
      # Modules to import from other scripts:
      packages=find_packages(),
      # Executables
      scripts=[
          "plamo-embedding-1b.py"
      ],
     )
