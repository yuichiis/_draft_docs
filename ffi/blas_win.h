#define FFI_LIB "libopenblas.dll"

void cblas_sscal(int N, float alpha, float *X, int incX);
int openblas_get_num_threads(void);
int openblas_get_num_procs(void);
char* openblas_get_config(void);
char* openblas_get_corename(void);
int openblas_get_parallel(void);
/* OpenBLAS is compiled for sequential use  */
#define OPENBLAS_SEQUENTIAL  0
/* OpenBLAS is compiled using normal threading model */
#define OPENBLAS_THREAD  1
/* OpenBLAS is compiled using OpenMP threading model */
#define OPENBLAS_OPENMP 2
