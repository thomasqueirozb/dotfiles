#!/usr/bin/perl
#clicker.pl - click the living hell out of whatever's under the mouse cursor

use Time::HiRes qw (usleep nanosleep);

# sleep three seconds after starting clicker.pl before hammering the mouse - 
# gives you time to get into the game window
sleep 3;

# endless loop - press and hold the mouse button to stop registering click events,
# then mouse back over to the terminal and Ctrl-C to stop
while (1) {
    # 10,000 microseconds == 10 milliseconds == 1/100 of a second.
    # 2 of these per loop means ~~ 50 clicks per second.

    `/usr/bin/xdotool mousedown 1`;
    usleep(10000);
    `/usr/bin/xdotool mouseup 1`;
    # Half a second
    usleep(250000);
}
