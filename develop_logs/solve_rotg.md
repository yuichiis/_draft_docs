はい、`cblas_drotg` と `cblas_drot` を使って連立一次方程式 Ax = b を解くサンプルコードです。

このコードでは、Givens回転を用いて行列 A を上三角行列 R に変換し (QR分解の一部)、同時にベクトル b も変換して b' とします。その後、上三角系 Rx = b' を後退代入で解きます。

```c
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <cblas.h> // OpenBLAS (CBLASインターフェース) のヘッダー

// 行列表示用ヘルパー関数 (行優先)
void print_matrix(const char *name, int rows, int cols, const double *mat) {
    printf("%s (%d x %d):\n", name, rows, cols);
    for (int i = 0; i < rows; ++i) {
        printf("  [");
        for (int j = 0; j < cols; ++j) {
            // 非常に小さい値は 0.0 として表示することがある
            double val = mat[i * cols + j];
            if (fabs(val) < 1e-12) val = 0.0;
            printf("%8.4f", val);
            if (j < cols - 1) {
                printf(", ");
            }
        }
        printf("]\n");
    }
    printf("\n");
}

// ベクトル表示用ヘルパー関数
void print_vector(const char *name, int n, const double *vec) {
    printf("%s: [", name);
    for (int i = 0; i < n; ++i) {
        printf("%.4f", vec[i]);
        if (i < n - 1) {
            printf(", ");
        }
    }
    printf("]\n");
}

// Givens回転を用いて連立一次方程式 Ax = b を解く関数
// A: M x N 行列 (行優先配列) - 関数内で上書きされます！
// b: M 要素ベクトル - 関数内で上書きされます！
// x: N 要素の解ベクトル (出力用)
// M: 行数
// N: 列数 (今回は M >= N を仮定し、特に M = N の場合を想定)
// 戻り値: 0=成功, -1=失敗 (特異行列の可能性)
int solve_linear_system_givens(double *A, double *b, double *x, int M, int N) {
    if (M < N) {
        fprintf(stderr, "Error: Number of rows (M) must be >= number of columns (N).\n");
        return -1;
    }

    printf("--- Starting QR factorization (upper triangularization) using Givens rotations ---\n");

    // --- Givens回転による上三角化 ---
    // A の対角成分より下の要素をゼロにしていく
    for (int j = 0; j < N; ++j) { // 各列 j (0 から N-1 まで)
        for (int i = j + 1; i < M; ++i) { // 各行 i (j+1 から M-1 まで)
            // ゼロにしたい要素は A[i][j]
            // 回転の軸となる要素は A[j][j]

            // A[j][j] と A[i][j] の値を取得
            // rotgは値を上書きするため、元の値を使って回転を適用する必要がある場合は注意
            // 今回は rotg が計算した c, s を使うので、a, b が上書きされても直接は困らない
            double a_val = A[j * N + j]; // ピボット要素の値 (rotgで上書きされる)
            double b_val = A[i * N + j]; // ゼロにしたい要素の値 (rotgで上書きされる)

            // ゼロにしたい要素が既にほぼゼロならスキップ
            if (fabs(b_val) < 1e-14) { // 小さな許容誤差
                continue;
            }

            double c, s; // 計算される cosine と sine

            // Givens回転パラメータ (c, s) を計算
            // a_val と b_val のアドレスを渡す
            // この関数呼び出し後、a_val は r に、b_val はスケーリングファクタ z になる（が、ここでは使わない）
            cblas_drotg(&a_val, &b_val, &c, &s);

            // printf("Step: Zeroing element (%d, %d) using pivot (%d, %d)\n", i, j, j, j);
            // printf("  Original A[j][j]=%.4f, A[i][j]=%.4f => c=%.4f, s=%.4f\n", A[j * N + j], A[i * N + j], c, s);

            // 第 j 行 と 第 i 行 にGivens回転を適用
            // 適用範囲は j 列目から N-1 列目まで (行列 A の部分)
            int num_elements_A = N - j;
            double *rowA_j_start = &A[j * N + j]; // j行目のj列目から
            double *rowA_i_start = &A[i * N + j]; // i行目のj列目から

            // cblas_drot(n, x, incx, y, incy, c, s)
            // ここでは row_j を x, row_i を y とする
            // A の j 行目と i 行目を回転
            cblas_drot(num_elements_A, rowA_j_start, 1, rowA_i_start, 1, c, s);
            // これで A[i * N + j] がゼロになるはず

            // 同時に、ベクトル b の対応する要素 (b[j] と b[i]) にも同じ回転を適用
            // ベクトル b の要素は 1 つだけなので n=1
            // x として b[j] のアドレス、y として b[i] のアドレスを渡す
             cblas_drot(1, &b[j], 1, &b[i], 1, c, s);

            // printf("  Matrix A and vector b after rotating rows %d and %d:\n", j, i);
            // print_matrix("A", M, N, A);
            // print_vector("b", M, b);

        }
    }
    printf("--- Upper triangularization complete. Resulting R (in A) and b' (in b) ---\n");
    print_matrix("R (Upper Triangular)", M, N, A);
    print_vector("b' (Transformed)", M, b);


    // --- 後退代入 (Back Substitution) Rx = b' を解く ---
    // ここで R は A の上三角部分 (最初の N 行 N 列)
    // b' は b の最初の N 要素
    printf("--- Starting Back Substitution ---\n");
    //for (int i = N - 1; i >= 0; --i) {
    //    // 対角要素 R[i][i] (つまり A[i][i]) がゼロに近い場合は解けない (特異行列)
    //    if (fabs(A[i * N + i]) < 1e-14) {
    //        fprintf(stderr, "Error: Matrix is singular or near-singular (zero pivot encountered at R[%d][%d]).\n", i, i);
    //        return -1;
    //    }
    //
    //    // sum = R[i][i+1]*x[i+1] + R[i][i+2]*x[i+2] + ... + R[i][N-1]*x[N-1]
    //    // double sum = 0.0;
    //    // for (int k = i + 1; k < N; ++k) {
    //    //     sum += A[i * N + k] * x[k];
    //    // }
    //    double sum = 0.0;
    //    int num_elements_for_dot = N - 1 - i; // 内積を計算する要素数
    //
    //    if (num_elements_for_dot > 0) {
    //        // 内積を計算するベクトル要素の開始ポインタ
    //        double *rowA_part = &A[i * N + (i + 1)]; // Aのi行目の(i+1)列目から
    //        double *x_part = &x[i + 1];             // xベクトルの(i+1)要素目から
    //
    //        // cblas_ddot(要素数, ベクトルX, Xの増分, ベクトルY, Yの増分)
    //        sum = cblas_ddot(num_elements_for_dot, rowA_part, 1, x_part, 1);
    //    }
    //    // num_elements_for_dot が 0 以下の場合 (i = N-1 の最終ステップ) は sum は 0.0 のまま        
    //
    //    
    //
    //    // x[i] = (b'[i] - sum) / R[i][i]
    //    x[i] = (b[i] - sum) / A[i * N + i];
    //    printf("  x[%d] = (%.4f - %.4f) / %.4f = %.4f\n", i, b[i], sum, A[i * N + i], x[i]);
    //}

    printf("--- Solving Rx = b' using cblas_dtrsv ---\n");

    // Rx = b' を解く。結果は b ベクトルに上書きされる形で格納されることが多いので注意。
    // まず b' (現在のb) を x にコピーしておく必要がある。
    for (int i = 0; i < N; ++i) {
        x[i] = b[i]; // 変換後の b' を解ベクトル x の初期値（入力）として使う
    }

    // エラーチェック: dtrsv 自体は戻り値を持たないため、
    // 事前に対角要素がゼロでないか確認するか、解の検証を行うのが一般的。

    // --- 前処理: 対角要素にゼロがないか確認 (idamin を使用) ---
    printf("--- Checking diagonal elements using cblas_idamin ---\n");
    //for (int i = 0; i < N; ++i) {
    //    if (fabs(A[i * N + i]) < 1e-14) {
    //         fprintf(stderr, "Error: Matrix was singular or near-singular (detected before dtrsv).\n");
    //         return -1;
    //    }
    //}
    //printf("Solution obtained using cblas_dtrsv.\n");

    // 対角要素から絶対値最小の要素のインデックスを見つける
    // cblas_idamin(要素数 N, ベクトル開始アドレス A, 増分 N+1)
    // 注意: idamin は size_t を返すことが多い (実装による)
    size_t min_idx = cblas_idamin(N, A, N + 1);

    // 最小絶対値を持つ対角要素の値を取得
    double min_diag_abs_value = fabs(A[min_idx * N + min_idx]);
    printf("  Minimum absolute diagonal value found at index %zu: %.4e\n", min_idx, A[min_idx*N+min_idx]);

    // 閾値と比較
    if (min_diag_abs_value < 1e-14) {
        fprintf(stderr, "Error: Matrix is singular or near-singular (minimum absolute diagonal %.4e at A[%zu][%zu] is below threshold).\n",
                min_diag_abs_value, min_idx, min_idx);
        return -1;
    } else {
        printf("  All diagonal elements are sufficiently large.\n");
    }

    // cblas_dtrsv(レイアウト, 上三角/下三角, 転置するか, 対角成分が単位行列か,
    //             サイズN, 行列A(R), lda, ベクトルx(入力b', 出力x), incx)
    cblas_dtrsv(CblasRowMajor,    // 行優先
                CblasUpper,       // 上三角行列 (R)
                CblasNoTrans,     // 転置しない (Rx=b' を解く)
                CblasNonUnit,     // 対角成分は1ではない
                N,                // 行列のサイズ (N x N)
                A,                // 上三角行列 R (Aに格納されている)
                N,                // Aの Leading Dimension (行優先なので列数)
                x,                // 入力:b' が入っている, 出力:解 x が格納される
                1);               // x の増分

    // これで x に解が格納されているはず
    // (特異行列などのエラーチェックは別途必要になる場合がある)




    return 0; // 成功
}

int main() {
    // 例: 連立一次方程式 Ax = b
    //  2x + 1y + 1z = 5
    //  4x - 6y + 0z = -2
    // -2x + 7y + 2z = 9
    // 解は x=1, y=1, z=2

    const int N = 3; // 変数の数 (行列のサイズ N x N)
    const int M = 3; // 方程式の数 (今回は N=M)

    // 行列 A (行優先) - solve関数で上書きされるためコピー用も用意
    double A_orig[] = {
        2.0,  1.0,  1.0,
        4.0, -6.0,  0.0,
       -2.0,  7.0,  2.0
    };
    // ベクトル b - solve関数で上書きされるためコピー用も用意
    double b_orig[] = { 5.0, -2.0, 9.0 };

    // 計算用の A と b をコピーして作成
    double A[M * N];
    double b[M];
    for(int i=0; i<M*N; ++i) A[i] = A_orig[i];
    for(int i=0; i<M; ++i) b[i] = b_orig[i];

    // 解ベクトル x (結果を格納)
    double x[N];

    printf("Solving Ax = b using Givens rotations (rotg and rot):\n");
    printf("---------------------------------------------------------\n");
    print_matrix("Original Matrix A", M, N, A_orig);
    print_vector("Original Vector b", M, b_orig);
    printf("---------------------------------------------------------\n\n");

    // 連立方程式を解く
    int result = solve_linear_system_givens(A, b, x, M, N); // A と b は上書きされる

    if (result == 0) {
        printf("\n---------------------------------------------------------\n");
        printf("Solution found:\n");
        print_vector("Vector x", N, x);
        printf("---------------------------------------------------------\n\n");

        // 検算: 元の A_orig と求めた x を使って Ax を計算し、元の b_orig と比較
        printf("Verification (Calculating A_orig * x):\n");
        double Ax[M];
        for (int i = 0; i < M; ++i) {
            Ax[i] = 0.0;
            for (int j = 0; j < N; ++j) {
                Ax[i] += A_orig[i * N + j] * x[j];
            }
        }
        print_vector("Ax (Result)", M, Ax);
        print_vector("Original b", M, b_orig);

        // 差を計算
        double diff_norm = 0.0;
        printf("Difference (Ax - b_orig): [");
        for (int i = 0; i < M; ++i) {
            double diff = Ax[i] - b_orig[i];
            diff_norm += diff * diff;
            printf("%.4e", diff);
             if (i < M - 1) printf(", ");
        }
        printf("]\n");
        printf("Norm of difference ||Ax - b_orig||: %.4e\n", sqrt(diff_norm));

    } else {
        printf("\nFailed to solve the system (matrix might be singular).\n");
    }

    return 0;
}
```

**コンパイルと実行:**

```bash
# (前回の回答と同じようにコンパイル)
gcc solve_givens.c -o solve_givens -lopenblas -lm
./solve_givens
```

**コードのポイント:**

1.  **インプレース操作:** この実装では、`solve_linear_system_givens` 関数は入力された行列 `A` とベクトル `b` を直接変更（上書き）して上三角化と変換を行います。元のデータを保持したい場合は、関数を呼び出す前にコピーを作成します（`main` 関数で行っているように）。
2.  **Givens回転の適用:**
    *   `for` ループで A の対角成分より下の要素 `A[i][j]` を順に選びます。
    *   `cblas_drotg` で `A[j][j]` と `A[i][j]` を基に `c` と `s` を計算します。
    *   `cblas_drot` を使って、**行列 A の第 j 行と第 i 行の j 列目以降の要素**に回転を適用します。
    *   **同時に、ベクトル b の第 j 要素と第 i 要素にも同じ回転 (`c`, `s`) を適用します。** これが重要で、方程式系の同値性を保つためです (`Ax=b` から `(GA)x = (Gb)` へ、GはGivens回転行列)。
3.  **後退代入:** 上三角化された `A` (これが R) と変換された `b` (これが b') を使って `Rx = b'` を解きます。解は `x` 配列に格納されます。
4.  **検算:** 最後に、元の行列 `A_orig` と求まった解 `x` を使って `Ax` を計算し、元の `b_orig` と比較して、解が正しいかを確認しています。

このコードを実行すると、Givens回転によって行列 A が上三角行列 R に、ベクトル b が b' に変換される過程（の最終結果）と、後退代入によって解 x が求まる様子、そして最後の検算結果が表示されます。