#include <stdio.h>
#include "apue.h"

void accumulation(int d_sum);

int main()
{
	FILE* sum;
	int total_sum=0;
	pid_t pid[5];
	int year=5, week=52, day=7;

	sum = fopen("sum.txt", "w");
	fprintf(sum, "%d\n", 0);
	fclose(sum);

	/**********************************************************/
	
	TELL_WAIT();
	int cnt_pid;
	int tmp;
	for (cnt_pid = 0 ; cnt_pid < 5 ; cnt_pid++){
		
		if((pid[cnt_pid] = fork()) < 0)
			err_sys("Fork Error.\n");
		else if(pid[cnt_pid] == 0){
			for (int i = 1 ; i <= 52 ; i++){
				char *filename = malloc(sizeof(char) * 1000);
				sprintf(filename , "%d-%02d.txt" , cnt_pid + 1 , i);
				FILE *fp = fopen(filename , "r");
				for(int z = 1 ; z <= 7 ; z++){
					int d_sum = 0;
					for(int j = 1 ; j <= 96 ; j++){
						fscanf(fp , "%d" , &tmp);
						d_sum = d_sum + tmp;	
					}
					accumulation(d_sum);
				}
			}
			TELL_PARENT(getppid());
			WAIT_PARENT();
			exit(0);
		}
		TELL_CHILD(cnt_pid);
		WAIT_CHILD();
	}	
	/**********************************************************/

	sum = fopen("sum.txt", "r");
	fscanf(sum, "%d", &total_sum);
	printf("Day_Average = %d\n",total_sum/(year*week*day));
	fclose(sum);

	return 0;
}

void accumulation(int d_sum)    //Accumulating the daily sum to "sum.txt".
{
	FILE* sum;
	int tmp=0;

	sum = fopen("sum.txt", "r+");
	fscanf(sum, "%d", &tmp);

	tmp += d_sum;

	rewind(sum);
	fprintf(sum, "%d", tmp);
	fclose(sum);

	return;
}
