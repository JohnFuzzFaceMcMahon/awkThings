#!awk -f 
BEGIN {
	if (ARGC<3) {
		print "Usage: fieldPrint.awk filename field1 ... fieldN";
		exit;
	}
	filename=ARGV[1];
	# print filename;
	for (; (getline inp <filename)>0 ;) {
		count=split(inp,inpArray,FS);
		out="";
		for (i=2;i<ARGC;i++) {
			spoo=inpArray[ ARGV[i] ];
			if (spoo=="") { spoo="Null"; }
			out=sprintf(out "%s ",spoo);
		}
		print out;
	}
}
