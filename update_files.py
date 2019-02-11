from subprocess import run, STDOUT, PIPE
from os import system
from pprint import pprint

username = run(['echo $USER'], stdout = PIPE ,shell=True)
username = username.stdout.decode('utf-8')[:-1]

#all_files = run(["ls", "-1AR"], stdout = PIPE)
#all_files = all_files.stdout.decode('utf-8')


#all_files_org = []
#temp_list = []
#for line in all_files.splitlines():
#	if line != '':
#		temp_list.append(line)
#	else:
#		all_files_org.append(temp_list)
#		temp_list = []
#all_files_org = [{'dir' : i[0][:-1], 'files' : i[1:]} for i in all_files_org if not i[0].startswith('./.git')]

#all_files_org[0]['dir']+='/'

#for i in all_files_org:
#	pprint(i)


all_files = run(["ls", "-AgR"], stdout = PIPE)
all_files = all_files.stdout.decode('utf-8').splitlines()


all_files_org = []
temp_list = []

for line in all_files:
	if line == '':
		all_files_org.append(temp_list)
		temp_list = []
	else:
		if line.startswith("."):print(line)
		temp_list.append(line)






#	#print(line, line != '' and not line.startswith("total"))
#	if line != '' and not line.startswith("total"):
#		temp_list.append(line)
#	elif line == '' and any(temp_list):
#		print(temp_list)
#		all_files_org.append(temp_list)
#		temp_list = []


all = []
for directory in all_files_org:
	d = {'dir': directory.pop(0), 'subdirs': [], 'files': []}

	for line in directory:

		line = line.split()
		#print(line)
		d['files' if line[0].startswith('-r') else 'subdirs'].append(line[-1])
	all.append(d)
#pprint(all)




#all_files_org[0]['dir']+='/'
#for i in all_files_org:
#	pprint(i)

from collections import defaultdict as ddict

#all = {}
#for directory in all_files_org:
#	directory = iter(directory)
#	dir = next(directory)
#
#	all[dir] = {'subdirs': [], 'files': []} #ddict(list)
#
#	#d = {'dir': directory.pop(0), 'subdirs': [], 'files': []}
#
#	for line in directory:
#		line = line.split()
#		all[dir]['files' if line[0].startswith('-r') else 'subdirs'].append(line[-1])

#pprint(all)
