#! awk -f

# https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences
BEGIN {
	for (i=0;i<255+1;i++) {
		bg=255;
		if ( i==0  ) { print "8 Standard Colors"; }
		# White
		if ( i==7  ) { bg=0; }
		if ( i==8  ) { print ""; print "8 High Intensity Colors"; }
		# Bright Green, Yellow, Cyan, White
		if ( i==10 ) { bg=0; }
		if ( i==11 ) { bg=0; }
		if ( i==14 ) { bg=0; }
		if ( i==15 ) { bg=0; }
		if ( i==16 ) { print ""; print "8 Greyscale Shades"; i=232; }
		# Right Half Of The Greyscale 
		if ( i>243 ) { bg=0; }
		printf( "\033[48;5;" i ";38;5;" bg "m %3.3d \033[0m ",i);
	}
	print "";

	for (j=0;j<215+1;j=j+36) {
		for (i=16;i<51+1;i++) {
			bg=255;
			if ( (i+j)==16 ) { print "216 Color Cube"; }
			if ( i>=34     ) { bg=0; }
			printf( "\033[48;5;" i+j ";38;5;" bg "m %3.3d \033[0m",i+j);
		}
		print "";
	}
}
