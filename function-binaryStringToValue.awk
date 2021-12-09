function binaryStringToValue(bstvX) {

    # Convert a binary string to an integer binaryStringToValue

    # bstvX is the input value
    # length of string is bstvY
    bstvY=length(bstvX);

    # bstvA is the calculated total
    bstvA=0;
    # bstvZ is the index for the digit we are working on
    for(bstvZ=1;bstvZ<bstvY+1;bstvZ++) {
        if ( substr(bstvX,bstvZ,1)=="1" ) {
            bstvA=bstvA+2**(bstvY-bstvZ);
        }
    }
    return bstvA;
}
