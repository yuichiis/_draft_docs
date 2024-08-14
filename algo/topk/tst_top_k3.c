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

int swap_count = 0;
void swap_float(float *a, float *b)
{
    float tmp = *a;
    *a = *b;
    *b = tmp;
    ++swap_count;
}
void swap_int(int *a, int *b)
{
    int tmp = *a;
    *a = *b;
    *b = tmp;
}

void minHeapify(int size, float heap[],  int indices[], int parent) {
    //printf("========================\n");
    //printf("minHeapify: size=%d parent=%d\n",size,parent);
    int left = 2 * parent + 1;
    int right = 2 * parent + 2;
    //printf("parent=%d left=%d, right=%d\n",parent,left,right);

    while (left < size) {
        int smallest;
        if(right < size) {
            //printf("*left:%d =%4.1f *right:%d =%4.1f\n",left,heap[left],right,heap[right]);
        } else {
            //printf("*left:%d =%4.1f *right:%d = NONE\n",left,heap[left],right);
        }
        if (right < size && heap[right] < heap[left]) {
            //printf("right is smaller\n");
            smallest = right;
        } else {
            //printf("left is smaller\n");
            smallest = left;
        }

        //printf("*parent:%d =%4.1f *smaller:%d =%4.1f\n",parent,heap[parent],smallest,heap[smallest]);
        if (heap[parent] <= heap[smallest]) {
            //printf("parent is smallest\n");
            break;
        }
        //printf("parent is not smallest\n");
        // swap
        //printf("swap: parent:%d:%4.1f, smallest:%d:%4.1f\n",parent,heap[parent],smallest,heap[smallest]);
        swap_float(&heap[parent],&heap[smallest]);
        swap_int(&indices[parent],&indices[smallest]);
        //printf("*parent:%d =%4.1f *smallest:%d =%4.1f\n",parent,heap[parent],smallest,heap[smallest]);

        parent = smallest;
        left = 2 * parent + 1;
        right = 2 * parent + 2;
        //printf("parent=%d left=%d, right=%d\n",parent,left,right);
    }
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
    for (int i = (k / 2) - 1; i >= 0; --i) {
        minHeapify(k, topNumbers, indices, i);
    }
    //print_arr(k, minHeap);

    // Process remaining elements
    for (int i = k; i < size; ++i) {
        if (arr[i] > topNumbers[0]) {
            topNumbers[0] = arr[i];
            indices[0] = i;
            minHeapify(k, topNumbers, indices, 0);
        }
    }

    if(sorted) {
        // sort
        for (int i = k - 1; i > 0; --i) {
            // swap
            swap_float(&topNumbers[0],&topNumbers[i]);
            swap_int(&indices[0],&indices[i]);
            minHeapify(i, topNumbers, indices, 0);
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

int sortmain()
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

    printf("build heap\n");
    for (int i = (k / 2) - 1; i >= 0; --i) {
        minHeapify(k, arr, indices, i);
        //print_arr(k,arr,indices);
    }
    printf("swap count=%d\n",swap_count);
    swap_count = 0;
    print_arr(k,arr,indices);

    printf("sort larger\n");
    for (int i = k-1; i>0; --i) {
        swap_float(&arr[0],&arr[i]);
        swap_int(&indices[0],&indices[i]);
        minHeapify(i, arr,  indices, 0);
    }
    printf("swap count=%d\n",swap_count);
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

    printf("swap count=%d\n",swap_count);
    printf("processing time %f\n", (double)(cpu_time_end-cpu_time_start)/CLOCKS_PER_SEC);

    free(arr);
    return 0;
}
