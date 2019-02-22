import os

ignore_dirs = frozenset(['.git', '.gitignore'])
ignore_files = frozenset(['FileUpdater.py', 'FileChecker.py', 'update_and_commit.sh'])


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

for path in files:
	sys_path = path[1:]

	result = os.system('cp ' + sys_path + ' ' + path)
	if result!=0:
		print(f'Failed to copy ' + sys_path)
