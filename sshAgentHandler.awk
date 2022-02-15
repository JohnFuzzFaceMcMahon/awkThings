#! gawk -f

@include "function-runCommand"

BEGIN {

    runCmdGlobalArray["BORK"]="BORK BORK";
    q="\"";

    debugGlobal=0;
#######################################################################################
# What Keys Are Loaded? 
#######################################################################################
    rc=runCommand("ssh-add -L");
    # how many loaded in the arrays
    loadedIndex=0;
    # scroll through the ssh-add command
    for (i=1;i<=rc;i++) {
        inp=runCmdGlobalArray[i];
        # found a public key?
        if ( index(inp,"ssh-")==1 ) {
            loadedIndex++;
            # split the key up by spaces
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

    debugGlobal=0;
#######################################################################################
# What Keys Are Available? 
#######################################################################################
    rc=runCommand("grep . $HOME/.ssh/*.pub");
    availIndex=0;
    for (i=1;i<=rc;i++) {

        inp=runCmdGlobalArray[i];

        # print i, inp;
        # found a public key?
        if ( index(inp,":ssh-")>0 ) {
            availIndex++;
            keyCommentAvail[availIndex]="XXXXX";
            keyFileAvail[availIndex]="XXXXX";
            keyIsAvail[availIndex]="XXXXX";
            keyTypeAvail[availIndex]="XXXXX";
            # split the key up by spaces
            argCount=split(inp,aArray," ");
            # split the first element by the ":"
            argCount2=split(aArray[1],bArray,":");
            # build a list of keys
            # aArray[1]
            keyFileAvail[availIndex]=bArray[1];
            keyTypeAvail[availIndex]=bArray[2];
            keyIsAvail[availIndex]=aArray[2];
            for (j=3;j<=argCount;j++) {
                dp("BEFORE " q j q " " q argCount q " " q keyCommentAvail[availIndex] q " " q aArray[j] q,10000,debugGlobal);
                if (keyCommentAvail[availIndex]=="XXXXX") {
                    keyCommentAvail[availIndex]=aArray[j];
                } else {
                    keyCommentAvail[availIndex]=keyCommentAvail[availIndex] " " aArray[j]; 
                } 
                dp("AFTER  " q j q " " q argCount q " " q keyCommentAvail[availIndex] q " " q aArray[j] q,10000,debugGlobal);
            }
        }
    }

    debugGlobal=0;
#######################################################################################
# Yubikey Available? 
#######################################################################################  
    rc=runCommand("uname");
    if ( runCmdGlobalArray[1]=="Darwin") {
        dp("Yubikey: Mac OS X Yes",13000,debugGlobal); 
        yCmd="ioreg -p IOUSB -w 0 | grep Yubikey >/dev/null";
        rc=system(yCmd); close(yCmd);
        if (rc==0) {
            dp("Yubikey: Found",13100,debugGlobal);  
            availIndex++;
            keyCommentAvail[availIndex]="/usr/local/lib/opensc-pkcs11.so";
            keyFileAvail[availIndex]="Yubikey";
            keyIsAvail[availIndex]="Yubikey";
            keyTypeAvail[availIndex]="ssh-rsa";           
        } else {
           dp("Yubikey: Not Found",13200,debugGlobal);   
        }
    } else {
        dp("Yubikey: Mac OS X No",23000,debugGlobal); 
    }

    debugGlobal=0;
#######################################################################################
# Print Out What Is Available 
#######################################################################################
    # dump what is already loaded
    if (debugGlobal) {
        dp("START Available",3000,debugGlobal);
        # already loaded dump
        for (k=1;k<=availIndex;k++) {
            dp("Index      | " k,3100,debugGlobal);
            dp("KeyType    | " keyTypeAvail[k],3200.debugGlobal);
            dp("Key        | " keyIsAvail[k],3300,debugGlobal);
            dp("KeyComment | " keyCommentAvail[k],3400,debugGlobal);
            dp("KeyFile    | " keyFileAvail[k],3450,debugGlobal);
            dp("           + " ,3500,debugGlobal);
        }
        dp("END   Available",3600,debugGlobal);
    }

    debugGlobal=0;
#######################################################################################
# Print Out What Is Loaded 
#######################################################################################
    # dump what is already loaded
    if (debugGlobal) {
        dp("START Currently Loaded",2000,debugGlobal);
        # already loaded dump
        for (k=1;k<=loadedIndex;k++) {
            dp("Index      | " k,2100,debugGlobal);
            dp("KeyType    | " keyType[k],2200.debugGlobal);
            dp("Key        | " keyIs[k],2300,debugGlobal);
            dp("KeyComment | " keyComment[k],2400,debugGlobal);
            dp("           + " ,2500,debugGlobal);
        }
        dp("END   Currently Loaded",2600,debugGlobal);
    }

    debugGlobal=1;
#######################################################################################
# Do the comparison 
#######################################################################################
    tableFormat="| %11s | %31s | %4s | %60s |\n";
    printf(tableFormat,"TYPE","COMMENT","LOAD","FILENAME");

    for(i=1;i<=availIndex;i++) {
        isItLoadedYet=0;
        for (j=1;j<=loadedIndex;j++) {
            if ( keyIs[j]==keyIsAvail[i]) {
                isItLoadedYet=1;
            }
            if (( keyComment[j] == keyCommentAvail[i] ) && ( keyIsAvail[i]=="Yubikey" )) {
                isItLoadedYet=1;
            }
        }

        if ( isItLoadedYet==0 ) {
            loadedStatus="NO";
            if ( keyFileAvail[i]=="Yubikey" ) {
                system("ssh-add -s " keyCommentAvail[i] );
            } else {
                tFileName=keyFileAvail[i];
                sub(".pub$","",tFileName);
                system("ssh-add " tFileName );                
            }
        } else {
            loadedStatus="YES";
        }
        printf(tableFormat,keyTypeAvail[i],keyCommentAvail[i],loadedStatus,keyFileAvail[i]);
    }
}