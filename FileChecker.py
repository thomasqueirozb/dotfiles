import os

ignore_dirs = frozenset(['.git', '.gitignore'])
ignore_files = frozenset(['FileUpdater.py', 'FileChecker.py'])


def parse_dir(path):
	s = []

	for i in os.listdir(path):
		if os.path.isdir(path+i):
			if i not in ignore_dirs:
				s+=parse_dir(path + i + '/')
		else:
			if i not in ignore_files:
				s.append(path+i)
	return s


files = parse_dir('./')


to_change = []

for path in files:
	sys_path = path[1:]
	result = os.system('cmp --silent ' + sys_path + ' ' + path)
	if result!=0:
		to_change.append([path, sys_path])

if to_change:
	print("Files that need to be updated")
	for file in to_change:
		print(file[0])


else:
	print("All up to date")
