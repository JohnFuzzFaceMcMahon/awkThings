#! gawk -f

# https://ben.akrin.com/?p=1347
BEGIN {
	for (i=0;i<255+1;i++) {
		h=sprintf("%x",i);
		hex2dec[h]=i;
		dec2hex[i]=h;
	}
	# STEP 1
	if (ARGC!=2) {
		print "Usage: mac2ip6.awk mac-address";
		exit;
	}
	mac=tolower(ARGV[1]);
	# standardize on colons
	gsub("-",":",mac);
	print "MAC: " mac;
	if ( index(mac,":") == 0 ) {
		print "mac-address needs to be formatted into bytes separated by dashes or colons";
		exit;
	}
	split(mac,workarray,":");
	## Shift Bytes 4,5,6 right 2
	workarray[8]=workarray[6];
	workarray[7]=workarray[5];
	workarray[6]=workarray[4];
	## Add FF:FE in the middle
	workarray[4]="ff";
	workarray[5]="fe";
	# for (i=1;i<8+1;i++) {
	#	printf("%s:",workarray[i]);
	# }
	# print "";
	firstByte=workarray[1];
	# print firstByte;
	firstByteDec=hex2dec[ firstByte ];
	# print firstByteDec;
	fBDXor=xor(firstByteDec,2);
	# print fBDXor;
	workarray[1]=dec2hex[ fBDXor ];
	out="";
	for (i=1;i<8+1;i++) {
		out=out workarray[i];
		if ( ((i%2)==0) && (i!=8) ) { out = out ":"; }
	}
	out="fe80::" out;
	print "IPv6 LL Address: " out;

}
