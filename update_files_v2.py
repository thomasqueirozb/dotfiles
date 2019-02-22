import os
#from filecmp import cmp

ignore_dirs = frozenset(['.git', '.gitignore'])
ignore_files = frozenset(['update_files_v2.py', 'update_files.py'])


def parse_dir(path):
	s = []

	for i in os.listdir(path):
		if os.path.isdir(path+i):
			if i not in ignore_dirs:
				s+=parse_dir(path + i + '/')
		else:
			if i not in ignore_files:
				#print(path+i)
				s.append(path+i)
				#cmp()
				#compare
				#pass
	return s

#from pprint import pprint
#pprint(check_dir('./'))

files = parse_dir('./')

for path in files:
	sys_path = path[1:]

	result = os.system('cp ' + sys_path + ' ' + path)
	if result!=0:
		print(f'Failed to copy ' + sys_path)
#		print(f'cp {file[1:]} {file}')
