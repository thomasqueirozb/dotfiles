#!/usr/bin/env python3
import os

with open('.ignore_dirs', 'r') as ig_d, open('.ignore_files', 'r') as ig_f:
    ignore_dirs = frozenset(ig_d.read().splitlines())
    ignore_files = frozenset(ig_f.read().splitlines())


def parse_dir(path):
    s = []

    for i in os.listdir(path):
        if os.path.isdir(path+i):
            if i not in ignore_dirs:
                s += parse_dir(path + i + '/')
        else:
            if i not in ignore_files:
                s.append(path+i)
    return s


files = parse_dir('./')


to_change = []

for path in files:
    sys_path = path[1:]
    result = os.system('cmp --silent ' + sys_path + ' ' + path)
    if result != 0:
        to_change.append([path, sys_path])

if to_change:
    print("Files that need to be updated")

    need_root = False

    for file in to_change:
        if not need_root:
            if not file[1].startswith('/home'):
                need_root = True
        print(file[1])

    print('''Do you want to:
o: OVERWRITE ALL these system files?
h: overwrite all the listed files in /home
e: exit
''')

    option = input('> ')
    # do = input('Do you want to OVERWRITE ALL these system files? [Y/n]')
    if option == 'o':
        if need_root and os.geteuid() != 0:
            print('You must rerun this as root')
        else:
            print('Overwriting...')
            for file in to_change:
                path, sys_path = file
                result = os.system('cp ' + path + ' ' + sys_path)
                if result != 0:
                    print(f'Failed to overwrite {sys_path}')

    elif option == 'h':
        print('Overwriting...')
        for file in to_change:
            path, sys_path = file
            if sys_path.startswith('/home'):
                result = os.system('cp ' + path + ' ' + sys_path)
                if result != 0:
                    print(f'Failed to overwrite {sys_path}')

else:
    print("All up to date")
