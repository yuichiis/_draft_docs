/**
 * custom_strsv - CBLASライブラリのcblas_strsv関数と同等の機能を持つ自作関数
 * 
 * 三角行列による線形方程式を解く関数: op(A)*x = b または x*op(A) = b
 * 
 * @param order     - 行優先(CblasRowMajor)または列優先(CblasColMajor)を指定
 * @param uplo      - 上三角(CblasUpper)か下三角(CblasLower)かを指定
 * @param trans     - 行列Aの転置操作を指定(CblasNoTrans, CblasTrans, CblasConjTrans)
 * @param diag      - 対角成分が単位行列か(CblasUnit)否か(CblasNonUnit)を指定
 * @param n         - 行列Aの次元
 * @param A         - 三角行列A
 * @param lda       - 行列Aの主要次元
 * @param x         - 入力ベクトルxと出力ベクトル、上書きされる
 * @param incx      - ベクトルxの間隔
 */

#include <stdio.h>

// CBLAS定数の定義
#define CblasRowMajor 101
#define CblasColMajor 102
#define CblasNoTrans 111
#define CblasTrans 112
#define CblasConjTrans 113
#define CblasUpper 121
#define CblasLower 122
#define CblasNonUnit 131
#define CblasUnit 132

void custom_strsv(const int order, const int uplo, const int trans, const int diag,
                  const int n, const float *A, const int lda, float *x, const int incx) {
    
    int i, j, ix, jx;
    float temp;
    int kx = (incx < 0) ? (1 - n) * incx : 0;
    
    // 入力チェック
    if (n <= 0)
        return;
    
    // 行列が転置されていない場合
    if (trans == CblasNoTrans) {
        // 行優先か列優先かによる処理の分岐
        if (order == CblasRowMajor) {
            // 下三角行列の場合
            if (uplo == CblasLower) {
                ix = kx;
                for (i = 0; i < n; i++) {
                    if (x[ix] != 0.0) {
                        if (diag == CblasNonUnit)
                            x[ix] = x[ix] / A[i * lda + i];
                        
                        temp = x[ix];
                        jx = ix + incx;
                        for (j = i + 1; j < n; j++) {
                            x[jx] -= temp * A[i * lda + j];
                            jx += incx;
                        }
                    }
                    ix += incx;
                }
            }
            // 上三角行列の場合
            else {
                ix = kx + (n - 1) * incx;
                for (i = n - 1; i >= 0; i--) {
                    if (x[ix] != 0.0) {
                        if (diag == CblasNonUnit)
                            x[ix] = x[ix] / A[i * lda + i];
                        
                        temp = x[ix];
                        jx = kx;
                        for (j = 0; j < i; j++) {
                            x[jx] -= temp * A[i * lda + j];
                            jx += incx;
                        }
                    }
                    ix -= incx;
                }
            }
        }
        // 列優先の場合
        else {
            // 上三角行列の場合
            if (uplo == CblasUpper) {
                ix = kx;
                for (i = 0; i < n; i++) {
                    if (x[ix] != 0.0) {
                        if (diag == CblasNonUnit)
                            x[ix] = x[ix] / A[i + i * lda];
                        
                        temp = x[ix];
                        jx = ix + incx;
                        for (j = i + 1; j < n; j++) {
                            x[jx] -= temp * A[i + j * lda];
                            jx += incx;
                        }
                    }
                    ix += incx;
                }
            }
            // 下三角行列の場合
            else {
                ix = kx + (n - 1) * incx;
                for (i = n - 1; i >= 0; i--) {
                    if (x[ix] != 0.0) {
                        if (diag == CblasNonUnit)
                            x[ix] = x[ix] / A[i + i * lda];
                        
                        temp = x[ix];
                        jx = kx;
                        for (j = 0; j < i; j++) {
                            x[jx] -= temp * A[j + i * lda];
                            jx += incx;
                        }
                    }
                    ix -= incx;
                }
            }
        }
    }
    // 行列が転置されている場合
    else {
        // 行優先の場合
        if (order == CblasRowMajor) {
            // 上三角行列の場合
            if (uplo == CblasUpper) {
                ix = kx;
                for (i = 0; i < n; i++) {
                    temp = x[ix];
                    jx = kx;
                    for (j = 0; j < i; j++) {
                        temp -= A[j * lda + i] * x[jx];
                        jx += incx;
                    }
                    
                    if (diag == CblasNonUnit)
                        temp /= A[i * lda + i];
                    
                    x[ix] = temp;
                    ix += incx;
                }
            }
            // 下三角行列の場合
            else {
                ix = kx + (n - 1) * incx;
                for (i = n - 1; i >= 0; i--) {
                    temp = x[ix];
                    jx = kx + (n - 1) * incx;
                    for (j = n - 1; j > i; j--) {
                        temp -= A[j * lda + i] * x[jx];
                        jx -= incx;
                    }
                    
                    if (diag == CblasNonUnit)
                        temp /= A[i * lda + i];
                    
                    x[ix] = temp;
                    ix -= incx;
                }
            }
        }
        // 列優先の場合
        else {
            // 下三角行列の場合
            if (uplo == CblasLower) {
                ix = kx;
                for (i = 0; i < n; i++) {
                    temp = x[ix];
                    jx = kx;
                    for (j = 0; j < i; j++) {
                        temp -= A[i + j * lda] * x[jx];
                        jx += incx;
                    }
                    
                    if (diag == CblasNonUnit)
                        temp /= A[i + i * lda];
                    
                    x[ix] = temp;
                    ix += incx;
                }
            }
            // 上三角行列の場合
            else {
                ix = kx + (n - 1) * incx;
                for (i = n - 1; i >= 0; i--) {
                    temp = x[ix];
                    jx = kx + (n - 1) * incx;
                    for (j = n - 1; j > i; j--) {
                        temp -= A[i + j * lda] * x[jx];
                        jx -= incx;
                    }
                    
                    if (diag == CblasNonUnit)
                        temp /= A[i + i * lda];
                    
                    x[ix] = temp;
                    ix -= incx;
                }
            }
        }
    }
}

// 使用例
int main() {
    // 3x3の上三角行列を例として
    float A[9] = {
        1.0, 2.0, 3.0,
        0.0, 4.0, 5.0,
        0.0, 0.0, 6.0
    };
    
    // 解くべきベクトル b
    float x[3] = {3.0, 8.0, 18.0};
    
    // Ax = b を解く（上三角行列の場合）
    custom_strsv(CblasRowMajor, CblasUpper, CblasNoTrans, CblasNonUnit, 3, A, 3, x, 1);
    
    printf("解ベクトル x:\n");
    for (int i = 0; i < 3; i++) {
        printf("x[%d] = %f\n", i, x[i]);
    }
    
    return 0;
}