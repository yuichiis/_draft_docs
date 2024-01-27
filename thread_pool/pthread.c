#include <stdio.h>
#include <pthread.h>
#include <unistd.h>

void *worker(void* arg)
{
    char *str=arg;
    for(int i=0;i<10;i++) {
        printf("worker:%s - %d\n",str,i);
        sleep(1);
    }
    return 0;
}

int main()
{
    printf("start main\n");
    pthread_t handle1;  // Thread handle.
    pthread_t handle2;  // Thread handle.

    printf("start th1\n");
    pthread_create(&handle1, NULL, worker, "th1");
    printf("start th2\n");
    pthread_create(&handle2, NULL, worker, "th2");

    sleep(1);
    printf("join th1\n");
    pthread_join(handle1, NULL);
    printf("join th2\n");
    pthread_join(handle2, NULL);
}
