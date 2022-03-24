BEGIN {
	for (i=1;i<24+1;i++) {
		bar=bar "#";
	}
	for (d1=1;d1<6+1;d1++) {
		for (d2=1;d2<6+1;d2++) {
			# print " 2d6 Roll: " d1 " + " d2 " = " d1+d2;
			count[d1]++;
			count[d2]++;
			count[d1+d2]++;
		}
	}
	for (i=1;i<12+1;i++) {
		total=total+count[i];
	}
	# print total;
	print "Probability in Space Base";
	printf("+-------------+-------+----+-------------------+\n");
	printf("| Dock Number | Count | %  | Graph             |\n");
	printf("+-------------+-------+----+-------------------+\n");
	for (i=1;i<13;i++) {
		printf("| %-11.11s | %-5.5s | %2d | %-17.17s |\n",i,count[i],count[i]*100/total,substr(bar,1,count[i]));
	}
	printf("+-------------+-------+----+-------------------+\n");
}
