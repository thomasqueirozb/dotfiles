CC=clang++
#CFLAGS=-Weverything -Wno-c++98-compat -Wno-c++98-compat-pedantic -Og -g -std=c++20
CFLAGS=-Weverything -Wno-c++98-compat -Wno-c++98-compat-pedantic -Os -s -std=c++20

# CFLAGS=-Wall -Wno-c++98-compat -Werror -std=c++20 # -g
# LFLAGS=
# OBJCMD=$(CC) $(CFLAGS) $< -c
# EXECMD=$(CC) $^ -o $@ $(LFLAGS)
OBJS=helper.o
EXEC=updater


debug: all
	./updater --local-to-git

release: all clean

all:# helper.o
	$(CC) $(CFLAGS) helper.cpp updater.cpp -o updater

# helper.o:
# 	$(CC) $(CFLAGS) -c helper.cpp


clean:
	rm -f $(OBJS)

destroy: clean
	rm -f $(EXEC)
