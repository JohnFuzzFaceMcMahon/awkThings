#! awk -f
BEGIN {
	q="\"";
	print "### ARGV";
	for (x in ARGV) {
		print "ARGV[" x "]=" q ARGV[x] q; 
	}
	print "### ENVIRON";
	for (x in ENVIRON) {
		print "ENVIRON[" x "]=" q ENVIRON[x] q; 
	}
	print "### FUNCTAB";
	for (x in FUNCTAB) {
		print "FUNCTAB[" x "]=" q FUNCTAB[x] q; 
	}
	print "### PROCINFO";
	for (x in PROCINFO) {
		if ( (x=="argv") || (x=="identifiers") ) {
			for (i in PROCINFO[x]) {
				print "PROCINFO[" x "][" i "]=" q PROCINFO[x][i] q; 
			}
		} else {
			print "PROCINFO[" x "]=" q PROCINFO[x] q; 
		}
	}
	print "### SYMTAB IS A MESS TO BE DEALT WITH LATER";
	#for (x in SYMTAB) {
	#	print x, typeof(SYMTAB[x]);
	#	if ( typeof(SYMTAB[x])=="array" ) {
	#		for (i in SYMTAB[x]) {
	#			print "SYMTAB[" x "][" i "]=" q SYMTAB[x][i] q; 
	#		}
	#	} else {
	#		print "SYMTAB[" x "]=" q SYMTAB[x] q; 
	#	}
	#}
	print "### DONE";
}
