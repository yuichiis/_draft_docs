#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void print_array(float array[], int k)
{
    for (int i = 0; i < k; i++) {
        printf("%6.1f ", array[i]);
    }
    printf("\n");
}

void insertSort(float array[], int size, int k) {
    //printf("===== begin insertSort =====\n");
    //printf("size=%d,k=%d\n",size,k);
    for (int i = k; i < size; i++) {
        float value = array[i];
        int j = i - 1;
        //print_array(array, size);
        //printf("i=%d,j=%d,value=%6.1f\n",i,j,value);

        while (j >= 0 && array[j] < value) {
            array[j + 1] = array[j];
            j--;
        }

        array[j + 1] = value;
    }
    //printf("===== end insertSort =====\n");
}

int main() {
    float array[50000]; // 
    int k = 5; // 
    time_t salt;

    // 
    srand((int)time(&salt));
    for (int i = 0; i < 50000; i++) {
      array[i] = (float)rand()/RAND_MAX*1000;
    }
    print_array(array, k);

    // 
    //insertSort(array, 50000, k);
    insertSort(array, k, 0);
    print_array(array, k);

    // 
    for (int i = k; i < 50000; i++) {
        //printf("new data=%6.1f\n",array[i]);
        if (array[i] > array[k-1]) {
            array[k-1] = array[i];
            insertSort(array, k, k - 1); // 
        }
        //print_array(array, k);
    }

    // 
    print_array(array, k);

    return 0;
}
