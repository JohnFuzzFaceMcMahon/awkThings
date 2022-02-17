#! awk -f
BEGIN {
	q="\"";
	cmd1="uname";
	cmd1 | getline unameResult;
	# print q unameResult q;
	close(cmd1);
	cmd="find -depth 1 -type d .";
	if ( unameResult=="Linux" ) cmd="find . -maxdepth 1 -mindepth 1 -type d";
	# print q cmd q;
	for (; (cmd|getline inp)>0 ;) {
		cmd2="cd " inp "; git status";
		print "# " cmd2;
		for (; (cmd2|getline inp2)>0 ;) {
			burp="##### ";
			if (inp2=="On branch master") burp="";
			if (inp2=="Your branch is up to date with 'origin/master'.") burp="";
			if (inp2=="On branch main") burp="";
			if (inp2=="Your branch is up to date with 'origin/main'.") burp="";
			if (inp2=="") burp="";
			if (inp2=="nothing to commit, working tree clean") burp="";
			if (burp!="") {
				print inp "> " burp q inp2 q;
			}
		}
		close(cmd2);
	}
	close(cmd);
}
