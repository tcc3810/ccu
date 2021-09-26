#include <stdio.h>
#include <stdlib.h>
#include <time.h>
int main(int argc , char *argv[]){
	time_t now = time(NULL);	// 目前累積多少秒
	printf("開始時間 : %s\n" , ctime(&now));	// 轉為目前時間

	int temp0 , temp1 , temp2 = 0;
	FILE *fp0 = fopen("/sys/class/hwmon/hwmon3/temp1_input" , "r");
	FILE *fp1 = fopen("/sys/class/hwmon/hwmon3/temp2_input" , "r");
	FILE *fp2 = fopen("/sys/class/hwmon/hwmon3/temp3_input" , "r");
	fscanf(fp0 , "%d" , &temp0);
	fscanf(fp1 , "%d" , &temp1);
	fscanf(fp2 , "%d" , &temp2);
	temp0 = temp0 / 1000;
	temp1 = temp1 / 1000;
	temp2 = temp2 / 1000;
	fclose(fp0);
	fclose(fp1);
	fclose(fp2);
	
	printf("\tPackage id 0 的初始溫度 : %d\n" , temp0);
	printf("\tCore 0 的初始溫度 : %d\n" , temp1);
	printf("\tCore 1 的初始溫度 : %d\n\n" , temp2);
		
	int temp = 55;
	if(argc == 2){
		temp = atoi(argv[1]);
	}
	printf("-----降到 %d 度以下-----\n\n" , temp);
	while(1){
		FILE *fp0 = fopen("/sys/class/hwmon/hwmon3/temp1_input" , "r");
		FILE *fp1 = fopen("/sys/class/hwmon/hwmon3/temp2_input" , "r");
		FILE *fp2 = fopen("/sys/class/hwmon/hwmon3/temp3_input" , "r");
		fscanf(fp0 , "%d" , &temp0);
		fscanf(fp1 , "%d" , &temp1);
		fscanf(fp2 , "%d" , &temp2);
		temp0 = temp0 / 1000;
		temp1 = temp1 / 1000;
		temp2 = temp2 / 1000;
		fclose(fp0);
		fclose(fp1);
		fclose(fp2);
		
		if(temp0 < temp && temp1 < temp && temp2 < temp){
			break;
		}
	}

	now = time(NULL);	// 目前累積多少秒
	printf("結束時間 : %s\n" , ctime(&now));	// 轉為目前時間
	
	printf("\tPackage id 0 的結束溫度 : %d\n" , temp0);
	printf("\tCore 0 的結束溫度 : %d\n" , temp1);
	printf("\tCore 1 的結束溫度 : %d\n" , temp2);
	
	return 0;
}
