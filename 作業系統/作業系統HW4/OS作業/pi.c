#define _GNU_SOURCE
#include <stdio.h>
#include <pthread.h>
#include <stdatomic.h>
#include <signal.h>
#include <unistd.h>
#include <stdlib.h>
#include <strings.h>
#include <sys/syscall.h> 
#include <assert.h>
#include <string.h>
#include <math.h>

size_t loopCount = 10000;
int numCPU = -1;
char *exename;

long gettid() {
    return (long int)syscall(__NR_gettid);
}

static volatile int keepRunning = 1;
void intHandler(int dummy){
    keepRunning = 0;
}

//注意，我使用了「volatile」
volatile double score[100];

void thread(void *givenName) {
    int id = (intptr_t)givenName;
    double pi = 0.0;
    double width = (double)1 / loopCount;
    for(size_t i = loopCount / numCPU * id ; i < loopCount / numCPU * (id + 1) ; i++){
        double x = (double)i / loopCount;
        pi = pi + width * sqrt(1 - x * x);
    }
    score[id] = pi; 
}

int main(int argc, char **argv) {
    signal(SIGINT , intHandler);
    exename = argv[0];
    int x = 0;
    if(argc == 5){
        numCPU = atoi(argv[4]);
        x = atoi(argv[2]);
    }
    else if(argc == 3){
        numCPU = sysconf(_SC_NPROCESSORS_ONLN);
        x = atoi(argv[2]);
    }
    else if(argc == 1){
        numCPU = sysconf(_SC_NPROCESSORS_ONLN);
        x = 100;
    }
    //printf("numCPU is %d\n" , numCPU);
    //printf("x is %d\n" , x);

    double lowerbdd = 0;
    double upperbdd = 1;
    double tol = pow(10 , -(x + 1));
    int y = 3;
    while((upperbdd - lowerbdd) >= (tol / 4) && keepRunning){
        lowerbdd = 0;
        pthread_t* tid = (pthread_t*)malloc(sizeof(pthread_t) * numCPU);
        for (long i=0 ; i< numCPU ; i++)
            pthread_create(&tid[i], NULL, (void *) thread, (void*)i);

        for (int i=0 ; i< numCPU ; i++)
	        pthread_join(tid[i], NULL);

        for (int i = 0; i < numCPU ; i++) 
            lowerbdd += score[i];
        
        upperbdd = lowerbdd + (double)1 / loopCount;
        if(loopCount / 10 < pow(10 , y)){
            loopCount = loopCount + pow(10 , y - 1);
        }
        else{
            loopCount = loopCount + pow(10 , y);
            y = y + 1;
        }

        //printf("%zu" , loopCount);
        //printf("\nlowerbdd is %.11lf\n", lowerbdd * 4);
        //printf("upperbdd is %.11lf\n", upperbdd * 4);
    }
    // printf upperbdd and lowerbdd
    printf("\nlowerbdd is %.11lf\n", lowerbdd * 4);
    printf("upperbdd is %.11lf\n", upperbdd * 4);

    printf("\npi is %.11lf\n", upperbdd * 2 + lowerbdd * 2);
}
