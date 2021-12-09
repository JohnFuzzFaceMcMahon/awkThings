function runCommand (x) {
        delete globalArray;
        z=0;
        dp("x=" x ".",1000,debugGlobal);
        for (; ( (x|getline y)>0 ) ;) {
                z++;
                gA[z]=y;
                dp("y=" y ".",2000,debugGlobal);
                dp("z=" z ".",3000,debugGlobal);
        }
        dp("CLOSING z=" z ".",4000,debugGlobal);
        close(x);
        # return array element count
        return(z);
}

