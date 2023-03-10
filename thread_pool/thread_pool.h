
/*
** thread_pool.h --- simple thread pool
*/
#ifndef THREAD_POOL_H_
#define THREAD_POOL_H_

typedef struct _thread_pool* thread_pool_t;
typedef struct _thread_pool_job* thread_pool_job_t;
typedef struct _thread_pool_thread* thread_pool_thread_t;

#ifdef __cplusplus
extern "C" {
#endif

extern thread_pool_t thread_pool_create(
    int max_threads, int max_jobs);

extern thread_pool_job_t thread_pool_create_job(
    int max_threads);

extern thread_pool_thread_t thread_pool_add_work(
    thread_pool_job_t job, void*(*start_routine)(void *), void*arg);

extern void thread_pool_wait(thread_pool_job_t job);

extern void thread_pool_wait_all(thread_pool_t job);

extern void thread_pool_shutdown(thread_pool_t job);

#ifdef __cplusplus
} // extern "C"
#endif

#endif // THREAD_POOL_H_