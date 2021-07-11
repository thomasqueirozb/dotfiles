# Based on:
# https://docs.python.org/3/library/readline.html?highlight=readline#example

"""Script run when interactive python mode is used. PYTHONSTARTUP environment
variable must be set to the path to this file"""

import atexit
import os
import readline


if "XDG_DATA_HOME" in os.environ:
    DIR = os.path.join(os.environ["XDG_DATA_HOME"], "python")
else:
    DIR = os.path.join(os.path.expanduser("~"), ".local/share/python")

if not os.path.exists(DIR):
    os.makedirs(DIR)

HISTFILE = os.path.join(DIR, "history")
del DIR

try:
    readline.read_history_file(HISTFILE)
    # default history len is -1 (infinite), which may grow unruly
    readline.set_history_length(10000)
except FileNotFoundError:
    pass

atexit.register(readline.write_history_file, HISTFILE)
