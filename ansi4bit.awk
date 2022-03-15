#! awk -f

# https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences
BEGIN {
	c[30]="Black"; c[31]="Red"; c[32]="Green"; c[33]="Yellow"; c[34]="Blue"; c[35]="Magenta"; c[36]="Cyan"; c[37]="White";
	print "  Color  Normal      Bright";
	print "        FG    BG    FG    BG";
	for (i=30;i<37+1;i++) {
		bg=40;
		if ( i==30 ) { bg=47; }
		if ( i==31 ) { bg=47; }
		if ( i==34 ) { bg=47; }
		if ( i==35 ) { bg=47; }
		printf( "%7.7s " i    " \033[" i    ";" bg "m" i    "\033[0m " i+10 " \033[" i+10 ";" bg-10 "m" i+10 "\033[0m ",c[i]);
		printf(          i+60 " \033[" i+60 ";" bg "m" i+60 "\033[0m " i+70 " \033[" i+70 ";" bg-10 "m" i+70 "\033[0m\n");
	}
}
