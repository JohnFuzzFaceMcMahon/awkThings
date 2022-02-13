#! gawk -f

@include "function-runCommand"

BEGIN {

    runCmdGlobalArray["BORK"]="BORK BORK";

    # what is loaded?
    rc=runCommand("ssh-add -L");
    # how many loaded already?
    loadedIndex=0;
    for (i=1;i<=rc;i++) {
        inp=runCmdGlobalArray[i];
        # found a public key?
        if ( substr(inp,1,4)=="ssh-") {
            loadedIndex++;
            # split the key up
            argCount=split(inp,aArray," ");
            # build a list of keys
            keyType[loadedIndex]=aArray[1];
            keyIs[loadedIndex]=aArray[2];
            for (j=3;j<=argCount;j++) {
                if (keyComment[loadedIndex]=="") {
                    keyComment[loadedIndex]=aArray[j];
                } else {
                    keyComment[loadedIndex]=keyComment[loadedIndex] " " aArray[j]; 
                } 
            }
        }
    }

    # what is available?
    rc=runCommand("find $HOME/.ssh/* -name \\*.pub");
    # how many loaded already?
    availIndex=0;
    for (i=1;i<=rc;i++) {
        inp=runCmdGlobalArray[i];
        print i, inp;
    }

    print "# Currently Loaded";
    # already loaded dump
    for (k=1;k<=loadedIndex;k++) {
        print "## " k;
        print "### " keyType[k];
        print "### " keyIs[k];
        print "### " keyComment[k];
    }
    print "# END Currently Loaded";
    
}