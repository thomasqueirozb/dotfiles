import os

with open('.ignore_dirs', 'r') as ig_d:
	ignore_dirs = frozenset(ig_d.read().splitlines())

with open('.ignore_files', 'r') as ig_f:
	ignore_files = frozenset(ig_f.read().splitlines())


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

	need_root=False

	for file in to_change:
		if not need_root:
			if not file[1].startswith('/home'):
				need_root=True
		print(file[0])


else:
	print("All up to date")
