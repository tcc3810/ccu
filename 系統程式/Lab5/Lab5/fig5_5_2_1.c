#include "apue.h"

int main(void)
{
	char buf[MAXLINE];
        int count = 0;
	setvbuf(stdout , buf , _IOFBF , MAXLINE);
	while( (fgets(buf,MAXLINE,stdin)) != NULL ){
		count++; 
		if(fputs(buf,stdout) == EOF)
			err_sys("output error");
	}
	printf("Count is %d.\n" , count);	
	if(ferror(stdin))
		err_sys("input error");

	exit(0);
}

