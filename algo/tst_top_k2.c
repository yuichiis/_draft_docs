#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>

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

void minHeapify(int size, float heap[], int i) {
    int smallest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    while (left < size) {
        if (right < size && heap[right] < heap[left]) {
            smallest = right;
        } else {
            smallest = left;
        }

        if (heap[smallest] >= heap[i]) {
            break;
        }
        // swap
        float temp = heap[i];
        heap[i] = heap[smallest];
        heap[smallest] = temp;

        i = smallest;
        left = 2 * i + 1;
        right = 2 * i + 2;
    }
}


// Function to extract the largest 10 numbers from an array
void findTopNumbers(
    int size,
    const float arr[],
    int k,
    float topNumbers[],
    bool sorted)
{
    // Build minimum heap with first TOP_NUM element
    
    float *minHeap = malloc(sizeof(float)*k);
    if(minHeap==NULL) {
        return;
    }
    for (int i = 0; i < k; ++i) {
        minHeap[i] = arr[i];
    }
    //print_arr(k, minHeap);
    for (int i = (k / 2) - 1; i >= 0; --i) {
        minHeapify(k, minHeap, i);
    }
    //print_arr(k, minHeap);

    // Process remaining elements
    for (int i = k; i < size; ++i) {
        if (arr[i] > minHeap[0]) {
            minHeap[0] = arr[i];
            minHeapify(k, minHeap, 0);
        }
    }

    if(sorted) {
        // sort
        for (int i = k - 1; i > 0; --i) {
            // swap
            float temp = minHeap[i];
            minHeap[i] = minHeap[0];
            minHeap[0] = temp;
            minHeapify(i, minHeap, 0);
        }
    }

    // Copy final top 10 numbers
    for (int i = 0; i < k; ++i) {
        topNumbers[i] = minHeap[i];
    }
    free(minHeap);
}

int main(int argc, char* argv[]) {
    float arr[SIZE];  // target data
    float topNumbers[TOP_NUM]; // Array containing the largest 10 numbers
    clock_t cpu_time_start;
    clock_t cpu_time_end;
    time_t salt;
    bool sorted = false;

    if(argc>1) {
        if(strncmp(argv[1],"-s",2)) {
            sorted = true;
        }
    }

    srand(time(&salt));
    // Store test data in array
    for (int i = 0; i < SIZE; ++i) {
        arr[i] = (float)rand() / (float)(RAND_MAX) * 1000; // fill array with random numbers
    }

    cpu_time_start = clock();

    for(int i = 0; i < EPOCH; ++i) {
        // find the largest 10 numbers
        findTopNumbers(SIZE, arr, TOP_NUM, topNumbers, sorted);
    }
    cpu_time_end = clock();

    // Show results
    printf("Top 10 numbers:\n");
    print_arr(TOP_NUM, topNumbers);

    printf("processing time %f\n", (double)(cpu_time_end-cpu_time_start)/CLOCKS_PER_SEC);

    return 0;
}
