#include "thread_pool.h"
#include "list.h"
#include <pthread.h>

struct _thread_pool
{
    struct thread_list threads;
    
};

struct thread_list
{
    struct list_header header;
    pthread_t id;
};


