function printLine (fpl_char,fpl_count,         fpl_index,fpl_out) {
	for (fpl_index==1; fpl_index<=fpl_count; fpl_index++) {
        fpl_out=fpl_out fpl_char;
    }
    print fpl_out;
    return;
}