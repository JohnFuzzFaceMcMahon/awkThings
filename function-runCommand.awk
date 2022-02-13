@include "function-debugPrint"
#
# Run shell command 
#
# Inputs 
#       rc_x - command to run
# Internal
#       rc_z - index counter
# Output
#       return code - number of elements in runCmdGlobalArray 
#       (indirect) runCmdGlobalArray - results
# 
function runCommand (rc_x,              rc_y,rc_z) {
        delete runCmdGlobalArray;
        rc_z=0;
        dp("rc_x=" rc_x ".",8881,debugGlobal);
        for (; ( (rc_x|getline rc_y)>0 ) ;) {
                rc_z++;
                # scrub CR and LF
                gsub("\r","[CR]",rc_y);
                gsub("\n","[LF]",rc_y);
                runCmdGlobalArray[rc_z]=rc_y;
                dp("rc_y=" rc_y ".",8882,debugGlobal);
                dp("rc_z=" rc_z ".",8883,debugGlobal);
        }
        dp("CLOSING rc_z=" rc_z ".",8884,debugGlobal);
        close(rc_x);
        # return array element count
        return(rc_z);
}