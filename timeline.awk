BEGIN {
    inYear=ARGV[1];
    inMonth=ARGV[2];
    inDay=ARGV[3];
    inHour=ARGV[4];
    duration=ARGV[5]*3600;
    inString=inYear " " inMonth " " inDay " " inHour " 00 00 ";
    startTime=mktime(inString);
    now=startTime;

    timeFormat="%a %Y-%m-%d %H:%M:%S %Z ";
    outputFormat="%s%29s%1s%29s%s\n";
    # cheesy way of making a string a particular length
    bar=substr("--------------------------------------------------------------------",1,29);

    # Table Header
    printf(outputFormat,"/",bar,"+",bar,"\\");
    printf(outputFormat,"|","Local Time ","|","UTC Time ","|");
    printf(outputFormat,"+",bar,"+",bar,"+");
    printf(outputFormat,"|"," ","|"," ","|");
    # Table Body
    for(;duration>0;duration=duration-1800) { 
        localTime=strftime(timeFormat,now,0);
        utcTime  =strftime(timeFormat,now,1);
        printf(outputFormat,"|",localTime,"|",utcTime,"|");
        printf(outputFormat,"|"," ","|"," ","|");
        now=now+1800;
    }
    # Table Footer
    printf(outputFormat,"\\",bar,"+",bar,"/");    
}
