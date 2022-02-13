#
# Debug Printing Function - function-debugPrint.awk
# 
# dp_x - String to be printed
# dp_y - Unique number to put on the front of the message
# dp_z - Flag to do printing
#
function dp( dp_x, dp_y, dp_z ) {
        if (dp_z) printf("###%05.5dDEBUG: %s\n",dp_y,dp_x);
}