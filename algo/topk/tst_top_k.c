#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <omp.h>

#define SIZE 10000 // size of array
#define TOP_NUM 10 // Number of numbers to extract
#define EPOCH 256

void print_arr(int n, const float *arr)
{
    printf("========================\n");
    for (int i = 0; i < n; ++i) {
        printf("%4.1f ", arr[i]);
    }
    printf("\n");
}

// Compare float
int compare( const void *arg1, const void *arg2 )
{
    float result = *(float*)arg1 - *(float*)arg2;
    if(result==0.0) {
        return 0;
    } else if(result < 0.0) {
        return 1;
    } else {
        return -1;
    }
}

int main() {
    float topNumbers[TOP_NUM]; // Array containing the largest 10 numbers
    float data[SIZE]; // input data
    float arr[SIZE];  // sorted data
    clock_t cpu_time_start;
    clock_t cpu_time_end;

    // Store test data in array
    for (int j = 0; j < SIZE; ++j) {
        data[j] = (float)rand() / (float)(RAND_MAX) * 1000; // fill array with random numbers
    }

    cpu_time_start = clock();

    for(int i = 0; i < EPOCH; ++i) {
        memcpy(arr,data,sizeof(float)*SIZE);
        // sort to find the largest 10 numbers
        qsort(arr, SIZE, sizeof(float), compare);
    }
    cpu_time_end = clock();

    // Show results
    printf("Top 10 numbers:\n");
    print_arr(TOP_NUM, arr);

    printf("processing time %f\n", (double)(cpu_time_end-cpu_time_start)/CLOCKS_PER_SEC);

    return 0;
}
