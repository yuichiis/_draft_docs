#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include <omp.h>

#define SIZE 50000 // size of array
#define BATCH_SIZE 64
#define TOP_NUM 10 // Number of numbers to extract
#define EPOCH 1000

void print_arr(int n, const float *arr, int *indices)
{
    printf("========================\n");
    for (int i = 0; i < n; ++i) {
        printf("[%d:%4.1f] ", indices[i],arr[i]);
    }
    printf("\n");
}

void maxInsertSort(int size, float array[], int indices[], int start) {
    //printf("===== begin insertSort =====\n");
    //printf("size=%d,k=%d\n",size,start);
    for (int i = start; i < size; i++) {
        float value = array[i];
        int index = indices[i];
        int j = i - 1;
        //print_array(array, size);
        //printf("i=%d,j=%d,value=%6.1f\n",i,j,value);

        while (j >= 0 && array[j] < value) {
            array[j + 1] = array[j];
            indices[j + 1] = indices[j];
            j--;
        }

        array[j + 1] = value;
        indices[j + 1] = index;
    }
    //printf("===== end insertSort =====\n");
}


// Function to extract the largest 10 numbers from an array
void findTopNumbers(
    int size,
    const float arr[],
    int k,
    float topNumbers[],
    int indices[],
    bool sorted)
{
    // Build minimum heap with first TOP_NUM element
    
    for (int i = 0; i < k; ++i) {
        topNumbers[i] = arr[i];
        indices[i] = i;
    }
    //print_arr(k, minHeap);
    maxInsertSort(k, topNumbers, indices, 0);
    //print_arr(k, minHeap);

    // Process remaining elements
    for (int i = k; i < size; ++i) {
        if (arr[i] > topNumbers[k-1]) {
            topNumbers[k-1] = arr[i];
            indices[k-1] = i;
            maxInsertSort(k, topNumbers, indices, k-1);
        }
    }
}

void s_topK(
    int m,
    int n,
    const float *input,
    int k,
    float *values,
    int *indices,
    bool sorted)
{
    int i;
    #pragma omp parallel for
    for(i = 0; i < m; ++i) {
        findTopNumbers(n, &input[i*n], k, &values[i*k], &indices[i*k], sorted);
    }
}

int testsortmain()
{
    float data[10] = { 1, 0, 9, 8, 4, 3, 2,  7, 6, 5};
    float arr[10];
    int indices[10];
    int k = sizeof(arr)/sizeof(float);
    for(int i=0; i<10; ++i) {
        arr[i] = data[i];
        indices[i] = i;
    }
    print_arr(k,arr,indices);
    maxInsertSort(k,arr,indices,0);
    print_arr(k,arr,indices);
    return 0;
}

int main(int argc, char* argv[]) {
    int m = BATCH_SIZE;
    int n = SIZE;
    int k = TOP_NUM;
    float *arr;  // target data
    float topNumbers[BATCH_SIZE][TOP_NUM]; // Array containing the largest 10 numbers
    int indices[BATCH_SIZE][TOP_NUM]; // Array containing the largest 10 numbers
    clock_t cpu_time_start;
    clock_t cpu_time_end;
    time_t salt;
    bool sorted = true;

    arr = malloc(sizeof(float)*SIZE*BATCH_SIZE);
    if(arr==NULL) {
        printf("memory allocation error\n");
        return 0;
    }

    if(argc>1) {
        if(strncmp(argv[1],"-s",2)) {
            sorted = true;
        }
    }

    srand(time(&salt));
    // Store test data in array
    for (int i = 0; i < BATCH_SIZE*SIZE; ++i) {
        arr[i] = (float)rand() / (float)(RAND_MAX) * 1000; // fill array with random numbers
        //arr[i] = (float)i;
    }

    cpu_time_start = clock();

    for(int i=0; i< EPOCH; ++i) {
        s_topK(
            BATCH_SIZE, // int m,
            SIZE,       // int n,
            arr,        // const float *input,
            TOP_NUM,    // int k,
            (float*)&topNumbers, // float *values,
            (int*)&indices,    // int *indices,
            sorted      // bool sorted)
        );
    }

    cpu_time_end = clock();

    // Show results
    printf("Top K numbers:\n");
    print_arr(TOP_NUM, topNumbers[0],indices[0]);

    //printf("swap count=%d\n",swap_count);
    printf("processing time %f\n", (double)(cpu_time_end-cpu_time_start)/CLOCKS_PER_SEC);

    free(arr);
    return 0;
}
