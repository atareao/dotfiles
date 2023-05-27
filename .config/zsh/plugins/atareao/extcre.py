#!/usr/bin/env python3
import os
import shutil
import re
import subprocess
import shlex
import glob

KEY = '2962A198'
KEY = 'F9A9F326A89151DAE54F66F72174E3022962A198'
KEY = '726BF28194F177B10C85F46D0AD17DF58AA94BFB'
PPA = 'atareao/test'
FORGET = ['.git', '.gitignore', 'extcre.py', 'temporal', '.mypy_cache']
FORGETEXT = ['.pyc']
NOCONVERT = ['.pdf', '.png', '.svg', '.jpg']


def case_sensitive_replace(s, before, after):
    regex = re.compile(re.escape(before), re.I)
    return regex.sub(lambda x: ''.join(d.upper() if c.isupper() else d.lower()
                                       for c, d in zip(x.group(), after)), s)


def dow_dir(parentdir, odirname, fb):
    tempdir = os.path.join(parentdir, 'temporal')
    for element in os.listdir(odirname):
        if os.path.basename(element) not in FORGET and\
                os.path.splitext(element)[1].lower() not in FORGETEXT:
            element = os.path.join(odirname, element)
            if os.path.isfile(element):
                dow_file(parentdir, element, fb)
            else:
                relative_path = os.path.relpath(element, parentdir)
                ndirname = os.path.join(tempdir, relative_path)
                if os.path.exists(ndirname):
                    shutil.rmtree(ndirname)
                os.mkdir(ndirname)
                dow_dir(parentdir, element, fb)


def dow_file(parentdir, ofilename, fb):
    global NEWVERSION
    global APP
    filename, file_extension = os.path.splitext(ofilename)
    tempdir = os.path.join(parentdir, 'temporal')
    relative_path = os.path.relpath(ofilename, parentdir)
    nfilename = os.path.join(tempdir, relative_path)
    head, tail = os.path.split(nfilename)
    tail = case_sensitive_replace(tail, 'nautilus', fb)
    nfilename = os.path.join(head, tail)
    if os.path.exists(nfilename):
        os.remove(nfilename)
    print('===', ofilename, '===')
    if file_extension in NOCONVERT:
        shutil.copyfile(ofilename, nfilename)
    else:
        ofile = open(ofilename, 'r')
        odata = ofile.read()
        ofile.close()
        nfile = open(nfilename, 'w')
        ndata = case_sensitive_replace(odata, 'nautilus', fb)
        if fb == 'caja':
            ndata = ndata.replace("gi.require_version('Caja', '3.0')",
                                  "gi.require_version('Caja', '2.0')")
            ndata = ndata.replace('gir1.2-caja-3.0', 'gir1.2-caja')
        elif fb == 'nemo':
            ndata = ndata.replace('python3-nemo', 'python-nemo')
        # ndata = re.sub("VERSION = '.*'", NEWVERSION, ndata)
        ndata = ndata.replace('$VERSION$', NEWVERSION)
        ndata = ndata.replace('$APP$', APP)
        nfile.write(ndata)
        nfile.close()


def get_app_version(parentdir):
    CHANGELOG = os.path.join(parentdir, 'debian', 'changelog')
    changelogfile = open(CHANGELOG, 'r')
    data = changelogfile.readline()
    changelogfile.close()
    posi = data.find('(')
    posf = data.find(')')
    app = data[0:posi].lower().strip()
    version = data[posi + 1:posf].strip()
    return app, version


def create_package(parentdir):
    SRCDIR = os.path.join(parentdir, 'src')
    CHANGELOG = os.path.join(parentdir, 'debian', 'changelog')
    PYCACHEDIR = os.path.join(SRCDIR, '__pycache__')
    if os.path.exists(PYCACHEDIR):
        shutil.rmtree(PYCACHEDIR)
    changelogfile = open(CHANGELOG, 'r')
    data = changelogfile.readline()
    changelogfile.close()
    posi = data.find('(')
    posf = data.find(')')
    app = data[0:posi].lower().strip()
    version = data[posi + 1:posf].strip()
    print('\r\n*** Building debian package... ***\r\n')
    p = subprocess.Popen(shlex.split('debuild -S -sa -k{}'.format(KEY)),
                         stdout=subprocess.PIPE)
    p.communicate()
    # time.sleep(1)
    package = os.path.join(os.path.dirname(parentdir),
                           '%s_%s_source.changes' % (app, version))
    print('***', package, '***')
    if os.path.exists(package):
        print('\r\n*** Uploading debian package ***\r\n')
        # os.system('dput ppa:"%s" "%s"' % (PPA, package))
        p = subprocess.Popen(shlex.split(
            'dput ppa:"%s" "%s"' % (PPA, package)),
            stdout=subprocess.PIPE)
        p.communicate()
        print('\r\n*** Uploaded debian package ***\r\n')
    else:
        print('\r\n*** Error: package not build ***')
    print('\r\n*** Removing files ***\r\n')
    for afile in glob.glob(os.path.join(
            os.path.dirname(parentdir), '%s_%s*' % (app, version))):
        print('\r\n*** Removing file: %s ***\r\n' % afile)
        os.remove(afile)


def doit(adir):
    global NEWVERSION
    global APP
    APP, NEWVERSION = get_app_version(adir)
    tempdir = os.path.join(adir, 'temporal')
    for fb in ['nautilus', 'nemo', 'caja']:
        print('\r\n*** Doing %s ***\r\n' % (fb.upper()))
        if os.path.exists(tempdir):
            shutil.rmtree(tempdir)
        os.makedirs(tempdir)
        dow_dir(adir, adir, fb)
        os.chdir(tempdir)
        # time.sleep(1)
        create_package(tempdir)
        if os.path.exists(tempdir):
            shutil.rmtree(tempdir)


if __name__ == '__main__':
    import sys
    args = sys.argv
    if len(args) > 1:
        doit(args[1])
