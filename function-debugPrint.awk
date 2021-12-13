# Debug Printing
# 
# dpx - String to be printed
# dpy - Unique number to put on the front of the message
# dpz - Flag to do printing
#
function dp( dpx, dpy, dpz ) {
        if (dpz) printf("###%05.5dDEBUG: %s\n",dpy,dpx);
}
