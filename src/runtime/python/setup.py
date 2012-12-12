from distutils.core import setup, Extension

pgf_module = Extension('pgf',
                       sources = ['pypgf.c'],
                       extra_compile_args = ['-std=c99'],
                       libraries = ['gu', 'pgf'])

setup (name = 'pgf',
       version = '1.0',
       description = 'This is binding to the PGF engine',
       ext_modules = [pgf_module])
