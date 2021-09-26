#include <stdio.h>
#include <math.h>

#define Maxterm 50
int num , time;
double vec[Maxterm][4];
double transMatrix[Maxterm][Maxterm];
int connected[Maxterm][Maxterm];
int numOfNeighbor[Maxterm];

double constantOfTransMatrix(int i , int j) {
    if(i == j) {
        double calculus = 1.0;
        for(int x = 0 ; x < num ; x++) {
            if(x == i)
                continue;
            calculus = calculus - constantOfTransMatrix(i , x);
        }
        return calculus;
    }
    else if(connected[i][j]) {
        double constant;
        if(numOfNeighbor[i] > numOfNeighbor[j])
            constant = 0.5 / numOfNeighbor[i];
        else
            constant = 0.5 / numOfNeighbor[j];
        return constant;
    }
    return 0;
}

int main() {

    // 輸入點個數 and 次數 and 座標點 and 值
    if(scanf("%d %d" , &num , &time)) {};
    int count = 0;
    while(count < num){
        int y = 0;
        if(scanf("%d " , &y)){};
        if(scanf("%lf %lf %lf" , &vec[y][1] , &vec[y][2] , &vec[y][3])) {};
        count = count + 1;
    }

    // 初始化轉換矩陣 and 點關係矩陣 and 邊關係矩陣
    for(int i = 0 ; i < num ; i++) {
        for(int j = 0 ; j < num ; j++) {
            transMatrix[i][j] = 0;
            connected[i][j] = 0;
        }
        numOfNeighbor[i] = 0;
    }

    // 構成點關係矩陣 connected[][]
    for(int i = 0 ; i < num ; i++) {
        for(int j = 0 ; j < num ; j++) {
            if(i == j) 
                continue;
            float dist =  pow(vec[i][1] - vec[j][1] , 2) +  pow(vec[i][2] - vec[j][2] , 2);
            if(dist < 1)
                connected[i][j] = 1;
        }
    }

    // 計算每個頂點有幾個邊 numOfNeighbor[]
    for(int i = 0 ; i < num ; i++) {
        for(int j = 0 ; j < num ; j++) {
            if(connected[i][j])
                numOfNeighbor[i] = numOfNeighbor[i] + 1;
        }
    }

    // 構成轉換矩陣 transMatrix[][]
    for(int i = 0 ; i < num ; i++) {
        for(int j = 0 ; j < num ; j++) {
            transMatrix[i][j] = constantOfTransMatrix(i , j);
        }
    }

    printf("%d %d\n" , num , time);
    // 計算轉換後的值
    double nextVec[num];
    for(int t = 0 ; t < time ; t++) {
        // 印出結果
        for(int i = 0 ; i < num - 1 ; i++)
            printf("%.2f " , vec[i][3]);
        printf("%.2f\n" , vec[num - 1][3]);

        for(int i = 0 ; i < num ; i++) {
            nextVec[i] = 0;
            for(int j = 0 ; j < num ; j++) 
                nextVec[i] = nextVec[i] + transMatrix[i][j] * vec[j][3];
        }
        for(int i = 0 ; i < num ; i++)
            vec[i][3] = nextVec[i];
    }

    return 0;
}