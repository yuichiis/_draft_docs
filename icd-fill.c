#include <stdio.h>
#include <stdlib.h>

#ifdef __APPLE__
#include <OpenCL/opencl.h>
#else
#include <CL/cl.h>
#endif

#define BUF_SIZE (16)
#define MAX_SOURCE_SIZE (0x100000)

int main()
{
    cl_device_id device_id = NULL;
    cl_context context = NULL;
    cl_command_queue command_queue = NULL;
    cl_mem memobj = NULL;
    cl_program program = NULL;
    cl_kernel kernel = NULL;
    cl_platform_id platform_id = NULL;
    cl_uint ret_num_devices;
    cl_uint ret_num_platforms;
    cl_int ret;
    cl_int memsize;

    cl_float host_buf[BUF_SIZE];
    cl_float pattern = 123.5;

    /* Get Platform and Device Info */
    ret = clGetPlatformIDs(1, &platform_id, &ret_num_platforms);
    ret = clGetDeviceIDs(platform_id, CL_DEVICE_TYPE_DEFAULT, 1, &device_id, &ret_num_devices);

    /* Create OpenCL context */
    context = clCreateContext(NULL, 1, &device_id, NULL, NULL, &ret);   

    /* Create Command Queue */    
    //command_queue = clCreateCommandQueueWithProperties(context, device_id, 0, &ret);
    command_queue = clCreateCommandQueue(context, device_id, 0, &ret);

    /* Create Memory Buffer */
    memobj = clCreateBuffer(context, CL_MEM_READ_WRITE,  sizeof(host_buf), NULL, &ret);
    memsize = sizeof(host_buf);

    printf("pattern=%f\n",pattern);
    printf("memsize=%d\n",memsize);
    printf("sizeof(pattern)=%ld\n",sizeof(pattern));
    printf("fill\n");

    ret = clEnqueueFillBuffer(
        command_queue,
        memobj,
        &pattern,
        sizeof(pattern),
        (size_t)0,
        (size_t)memsize,
        0,
        NULL,
        NULL);

    printf("finish\n");
    ret = clFinish(command_queue);

    printf("read\n");
    /* Copy results from the memory buffer */
    ret = clEnqueueReadBuffer(command_queue, memobj, CL_TRUE, 0,
                            sizeof(host_buf),host_buf, 0, NULL, NULL);

    printf("finish\n");
    ret = clFinish(command_queue);

    /* Display Result */
    for(int i=0;i<BUF_SIZE;i++) {
        printf("%f ",host_buf[i]);
    }
    printf("\n");

    /* Finalization */
    //ret = clFlush(command_queue);
    ret = clFinish(command_queue);
    ret = clReleaseKernel(kernel);
    ret = clReleaseProgram(program);
    ret = clReleaseMemObject(memobj);
    ret = clReleaseCommandQueue(command_queue);
    ret = clReleaseContext(context);

    return 0;
}