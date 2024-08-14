#include <stdio.h>

// print 
void print_data(int n, int *data) {
  for (int i = 0; i < n; i++) {
    printf("%d ", data[i]);
  }
  printf("\n");
}

// Swapping elements
void swap(int *a, int *b) {
  int tmp = *a;
  *a = *b;
  *b = tmp;
}

// Heap structure repair
void sift_down(int start, int end, int *data) {
  int root = start;
  while (root * 2 + 1 <= end) {
    int child = root * 2 + 1;
    if (child + 1 <= end && data[child] < data[child + 1]) {
      child++;
    }
    if (child <= end && data[root] < data[child]) {
      swap(&data[root], &data[child]);
      root = child;
    } else {
      return;
    }
  }
}

// heap sort
void heapify(int n, int *data) {
  for (int i = (n - 2) / 2; i >= 0; i--) {
    sift_down(i, n - 1, data);
  }
}

// partial sort
void partial_sort(int n, int k, int *data) {
  // Sort elements up to Top-k using heap sort
  heapify(n, data);
  print_data(k, data);
  for (int i = k; i < n; i++) {
    if (data[i] > data[0]) {
      swap(&data[0], &data[i]);
      sift_down(0, k - 1, data);
    }
  }
}

int main() {
  // sample data
  int data[] = {5, 2, 4, 1, 3};
  int n = sizeof(data) / sizeof(int);
  int k = 3;

  // Extracting top-k elements
  partial_sort(n, k, data);

  // print
  print_data(k, data);

  return 0;
}