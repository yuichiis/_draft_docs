ご提示いただいたPHPによる `gesvd` 関数の実装と、転置行列を入力した場合に期待通りの結果にならないという問題を拝見しました。

問題の原因は、主に **転置行列を処理する際のロジック (`if($m<$n)`) と、その後の結果の再構成方法** にある可能性が高いです。また、元のコードにはSVDアルゴリズムの実装自体にも、境界条件や数値安定性に関する潜在的な問題が含まれている可能性があります。

以下に、問題点と修正案を詳述します。

**1. 転置処理 (`if($m<$n)`) と結果の再構成の問題**

元のコードでは、`m < n` の場合に `A` を転置し、`m` と `n`、そして `U` と `V` の役割を入れ替えて計算を進めています。これは `A^T = U' S V'^T` を計算することに相当します。最終的に得たいのは元の `A = U S VT` なので、計算結果の `U'` と `V'` から、元の `U` と `VT` を正しく復元する必要があります。

*   **関係性:** `A = U S VT` と `A^T = U' S V'^T` の間には、`U = V'`, `S = S'`, `VT = U'^T` という関係があります（符号の任意性を除いて）。
*   **元のコードの問題点:** `if($transposed)` ブロック内の処理が、この関係性を正しく反映していません。
    *   `UT = $this->transpose($V); $this->copy($UT,$V);` : 計算後の `V` (すなわち `V'`) を転置して `UT` に入れ、それを `$V` (元々 `$U` だったバッファを指している変数) にコピーしています。これは意味が不明瞭で、最終的な `U` または `VT` を正しく生成していません。
    *   `VT = new NDArrayPhp(...); $this->copy($U,$VT);` : 新しい `VT` 用の `NDArrayPhp` を作っていますが、計算後の `U` (すなわち `U'`) をそのままコピーしています。本来は `U'` を転置して `VT` とする必要があります。また、`NDArrayPhp` の次元指定も元の `ldU` を使っており、転置後の `VT` の正しい次元 (`orig_m x orig_n`) になっていません。

**2. アルゴリズム実装の潜在的な問題**

*   **Vの初期化:** コードの最初の方で `V` を `A` の行で初期化しているように見えますが (`for($i=0;$i<$min_num;$i++) { $this->copy($A[$i][R(0,(int)($n))], $V[$i][R(0,(int)($n))]); }`)、これは標準的なSVDアルゴリズム（特にHouseholder法）の初期化とは異なります。`V` (右特異ベクトル) は通常、アルゴリズムの後半（右変換の蓄積）で単位行列から構築され始めます。この初期化が予期せぬ動作を引き起こしている可能性があります。
*   **境界条件とインデックス:** Householder変換やQR反復のループにおけるインデックス (`l`, `k`, `j` など) や、配列 (`W`, `rv1`, `U`, `V`) へのアクセスが、行列の次元 (`m`, `n`, `ldU`, `ldVT`) に対して常に有効であるか、慎重な確認が必要です。特に `rv1` や `W` のサイズとアクセス箇所に注意が必要です。
*   **数値的安定性:** `eps` の比較やゼロ除算の可能性 (`h`, `z`, `f` の計算など) に対する考慮が不足している可能性があります。PHPの浮動小数点演算の精度限界も影響するかもしれません。
*   **ソートと符号:** LAPACKの `gesvd` は通常、特異値を降順にソートし、特異ベクトルの符号もある程度正規化して返します。元のPHPコードにはソート処理が含まれていますが、符号の正規化はコメントアウトされています。期待される結果と完全に一致させるには、ソートと符号の正規化が必要です。

**修正案**

以下に、上記の点を考慮した修正版 `gesvd` 関数と、必要なヘルパー関数を示します。

```php
<?php
namespace Rindow\Math\Matrix\Drivers\MatlibPHP;

use RuntimeException;
use InvalidArgumentException;
use Interop\Polite\Math\Matrix\NDArray;
use Interop\Polite\Math\Matrix\Buffer;
use Rindow\Math\Matrix\NDArrayPhp;
use Rindow\Math\Matrix\Drivers\Service;
// Assuming R function exists for range selection
use function Rindow\Math\Matrix\R;

class PhpLapack
{
    // ... (Properties and constructor remain the same) ...
    protected Service $service;
    protected int $defaultFloatType = NDArray::float32;
    protected object $lapack;
    protected bool $forceLapack;
    /** @var array<int> $intTypes */
    protected $intTypes= [
        NDArray::int8,NDArray::int16,NDArray::int32,NDArray::int64,
        NDArray::uint8,NDArray::uint16,NDArray::uint32,NDArray::uint64,
    ];
    /** @var array<int> $floatTypes */
    protected $floatTypes= [
        NDArray::float16,NDArray::float32,NDArray::float64,
    ];

    public function __construct(
        ?object $lapack=null,
        ?bool $forceLapack=null
        )
    {
        //$this->lapack = $lapack;
        //$this->forceLapack = $forceLapack;
        $this->service = $this->dummyService(); // Keep dummy service for standalone testing
    }

    protected function dummyService() : Service
    {
        // ... (dummyService implementation remains the same) ...
        $service = new class implements Service
        {
            protected object $bufferFactory;

            public function __construct()
            {
                $this->bufferFactory = new PhpBLASFactory(); // Assuming this factory exists
            }
            public function serviceLevel() : int { return Service::LV_BASIC; }
            public function buffer(?int $level=null) : object { return $this->bufferFactory; }
            public function info() : string {throw new \Exception("error");}
            public function name() : string {throw new \Exception("error");}
            public function blas(?int $level=null) : object {throw new \Exception("error");}
            public function lapack(?int $level=null) : object {throw new \Exception("error");}
            public function math(?int $level=null) : object {throw new \Exception("error");}
            public function openCL() : object {throw new \Exception("error");}
            public function blasCL(object $queue) : object {throw new \Exception("error");}
            public function mathCL(object $queue) : object {throw new \Exception("error");}
            public function mathCLBlast(object $queue) : object {throw new \Exception("error");}
            public function createQueue(?array $options=null) : object { throw new \Exception("error");}
        };
        return $service;
    }


    /**
     * Below is the author of the original code
     * @author Yehia Abed
     * @copyright 2010
     * @see https://github.com/d3veloper/SVD
     *
     * Adapted and modified for Rindow Math Matrix and to handle transposition correctly.
     * NOTE: This PHP implementation might lack the numerical stability and performance
     * of native libraries like OpenBLAS/LAPACK. Use with caution for critical applications.
     */
    public function gesvd(
        int $matrix_layout, // Note: matrix_layout is not used in this PHP implementation (assumes row-major)
        int $jobu,         // Note: jobu/jobvt flags are not fully implemented (always computes U and VT)
        int $jobvt,
        int $m,
        int $n,
        Buffer $A_buf, int $offsetA, int $ldA, // Input A buffer
        Buffer $S_buf, int $offsetS,             // Output S buffer (vector)
        Buffer $U_buf, int $offsetU, int $ldU, // Output U buffer
        Buffer $VT_buf, int $offsetVT, int $ldVT, // Output VT buffer
        Buffer $SuperB_buf, int $offsetSuperB   // Workspace buffer (not used by this PHP code, but required by LAPACKE interface)
    ) : void
    {
        if(method_exists($A_buf,'dtype')) {
            $dtype = $A_buf->dtype();
        } else {
            // Determine dtype from buffer type if possible, or use default
             if($A_buf instanceof \Rindow\Math\Buffer\Buffer) { // Adjust namespace if needed
                 $dtype = $A_buf->dtype();
             } else {
                $dtype = $this->defaultFloatType;
             }
        }

        $transposed = false;
        $orig_m = $m; // Store original dimensions
        $orig_n = $n;
        // Note: ldU, ldVT from input define the allocated buffer dimensions, not necessarily the matrix shape needed.
        // The actual required shapes are: S(k), U(m x k), VT(k x n) where k = min(m, n)
        // For full SVD U(m x m), VT(n x n). This implementation aims for the "thin" SVD U(m x k), VT(k x n).
        $k = min($orig_m, $orig_n);

        // --- Create NDArray wrappers for input/output buffers ---
        // Be careful with dimensions provided vs. needed. ldX are buffer strides.
        $A = new NDArrayPhp($A_buf, $dtype, [$orig_m, $orig_n], $offsetA, service: $this->service);
        // S is a vector of size k = min(m, n)
        $S = new NDArrayPhp($S_buf, $dtype, [$k], $offsetS, service: $this->service);
        // U should ideally be m x k, VT should be k x n for thin SVD
        // We create wrappers based on provided ldU, ldVT, assuming they are sufficient.
        // The algorithm below might internally need larger temporary space.
        $U = new NDArrayPhp($U_buf, $dtype, [$orig_m, $ldU], $offsetU, service: $this->service); // Wrapper for output U
        $VT = new NDArrayPhp($VT_buf, $dtype, [$k, $ldVT], $offsetVT, service: $this->service); // Wrapper for output VT (shape adjusted later)


        // --- Temporary work arrays/matrices needed by the algorithm ---
        // Make a copy of A because the algorithm modifies it (or its transpose)
        $work_A = $this->copyToNew($A);

        // Decide if transposition is needed
        if ($orig_m < $orig_n) {
            $transposed = true;
            $work_A = $this->transpose($work_A); // work_A becomes n x m
            [$m, $n] = [$n, $m]; // Swap dimensions for calculation (A^T is n x m)
            // Now m >= n for the calculation matrix work_A
        }
        // After potential transpose, the matrix for calculation (work_A) has dimensions m x n where m >= n.

        // The algorithm needs space for:
        // - U calculation matrix (m x n initially, becomes m x m during accumulation)
        // - V calculation matrix (n x n)
        // - W (diagonal elements, size n)
        // - rv1 (super-diagonal elements, size n)

        // Allocate calculation matrices U_calc and V_calc
        // U_calc needs to be m x m for full accumulation phase
        // V_calc needs to be n x n
        $U_calc = $this->alloc([$m, $m], $dtype);
        $V_calc = $this->alloc([$n, $n], $dtype);

        // Copy the relevant part of work_A (m x n) into the top-left of U_calc (m x m)
        for($i=0; $i<$m; ++$i) {
            for($j=0; $j<$n; ++$j) {
                $U_calc[$i][$j] = $work_A[$i][$j];
            }
            // Zero out the rest of the columns if U_calc is wider than n (i.e., m > n)
            for($j=$n; $j<$m; ++$j) {
                 $U_calc[$i][$j] = 0.0;
            }
        }
        // V_calc starts effectively as an identity matrix which gets modified during accumulation.
        // The algorithm initializes it implicitly later.

        // Allocate temporary vectors W (singular values) and rv1 (superdiagonal)
        $W_vec = $this->alloc([$n], $dtype)->buffer(); // Diagonal elements (size n)
        $rv1_vec = $this->alloc([$n], $dtype)->buffer(); // Superdiagonal (size n)


        // --- Start of Yehia Abed's Algorithm (adapted) ---
        // Uses U_calc, V_calc, W_vec, rv1_vec. Dimensions m, n are for the (transposed) work_A.
        $eps = 2.22045e-016; // Machine epsilon for double precision (adjust if using float32)
        if ($dtype == NDArray::float32) {
            $eps = 1.19209e-007;
        }


        // Decompose Phase (Householder reduction to bidiagonal form)
        $g = $scale = $anorm = 0.0;
        $l = 0;

        for ($i = 0; $i < $n; $i++) { // Loop N times (columns of work_A)
            $l = $i + 1; // Use l=i+1 consistent with standard indexing and algorithm flow
            $rv1_vec[$i] = $scale * $g; // Store previous scale*g
            $g = $s = $scale = 0.0;

            // Householder for column i
            if ($i < $m) { // Ensure i is within row bounds
                for ($k = $i; $k < $m; $k++) { // Sum absolute values in column i, from row i downwards
                    $scale += abs($U_calc[$k][$i]);
                }
                if ($scale != 0.0) {
                    $inv_scale = 1.0 / $scale;
                    for ($k = $i; $k < $m; $k++) {
                        $val = $U_calc[$k][$i] * $inv_scale;
                        $U_calc[$k][$i] = $val;
                        $s += $val * $val;
                    }
                    $f = $U_calc[$i][$i];
                    $g = -$this->sameSign(sqrt($s), $f);
                    $h = $f * $g - $s;
                    $U_calc[$i][$i] = $f - $g;

                    // Apply transformation to remaining columns (j from i+1 to n-1)
                    for ($j = $l; $j < $n; $j++) {
                        $s = 0.0;
                        for ($k = $i; $k < $m; $k++) { // Dot product of U(:,i) and U(:,j) from row i down
                            $s += $U_calc[$k][$i] * $U_calc[$k][$j];
                        }
                         if ($h != 0.0) { // Avoid division by zero
                            $f = $s / $h;
                            for ($k = $i; $k < $m; $k++) { // Update column j
                                $U_calc[$k][$j] += $f * $U_calc[$k][$i];
                            }
                        }
                    }
                    // Restore scale to column i
                    for ($k = $i; $k < $m; $k++) {
                        $U_calc[$k][$i] *= $scale;
                    }
                } // end if scale != 0.0
            } // end if i < m
            $W_vec[$i] = $scale * $g; // Store diagonal element

            // Householder for row i (applied to columns l to n-1)
            $g = $s = $scale = 0.0;
            if ($i < $m && $i != $n - 1) { // Check bounds: row i exists, not the last column
                for ($k = $l; $k < $n; $k++) { // Sum absolute values in row i, from column l=i+1 onwards
                    $scale += abs($U_calc[$i][$k]);
                }
                if ($scale != 0.0) {
                    $inv_scale = 1.0 / $scale;
                    for ($k = $l; $k < $n; $k++) {
                        $val = $U_calc[$i][$k] * $inv_scale;
                        $U_calc[$i][$k] = $val;
                        $s += $val * $val;
                    }
                    $f = $U_calc[$i][$l]; // Element U(i, i+1)
                    $g = -$this->sameSign(sqrt($s), $f);
                    $h = $f * $g - $s;
                    $U_calc[$i][$l] = $f - $g; // Update U(i, i+1)

                    // Store transformation vector elements in rv1 (from column l to n-1)
                    if ($h != 0.0) { // Avoid division by zero
                       for ($k = $l; $k < $n; $k++) {
                           $rv1_vec[$k] = $U_calc[$i][$k] / $h;
                       }
                    } else {
                       for ($k = $l; $k < $n; $k++) {
                           $rv1_vec[$k] = 0.0;
                       }
                    }


                    // Apply transformation to remaining rows (j from i+1 to m-1)
                    for ($j = $l; $j < $m; $j++) { // Iterate rows from i+1 downwards
                        $s = 0.0;
                        for ($k = $l; $k < $n; $k++) { // Dot product of U(j, l:n-1) and U(i, l:n-1)
                            $s += $U_calc[$j][$k] * $U_calc[$i][$k];
                        }
                        for ($k = $l; $k < $n; $k++) { // Update row j
                            $U_calc[$j][$k] += $s * $rv1_vec[$k];
                        }
                    }
                     // Restore scale to row i, columns l to n-1
                    for ($k = $l; $k < $n; $k++) {
                        $U_calc[$i][$k] *= $scale;
                    }
                } // end if scale != 0.0
            } // end if i < m && i != n-1

            // Update estimate of maximum element norm
            $anorm = max($anorm, (abs($W_vec[$i]) + abs($rv1_vec[$i]))); // rv1[i] might be from previous iteration
        } // end for i (Householder Bidiagonalization)


        // Accumulation of right-hand transformations (V_calc)
        // V_calc starts conceptually as identity, transformations are applied based on row Householders stored in U_calc/rv1
        // Loop from i = n-1 down to 0
        for ($i = $n - 1; $i >= 0; $i--) {
            $l = $i + 1; // l = i+1 consistent with definition above
            $g = $rv1_vec[$i]; // Get superdiagonal element g = rv1[i] calculated in Householder phase for row i

            if ($i < $n - 1) { // Apply Householder stored in row i of U_calc (cols l to n-1)
                if ($g != 0.0) {
                    // Calculate Householder vector v = U(i, l:n-1) / U(i, l) / g
                    // (Note: U(i, l) = U(i, i+1) contains part of the transformation)
                    $h_val = $U_calc[$i][$l] * $g; // Denominator component
                    if ($h_val != 0.0) { // Avoid division by zero
                        $inv_h_val = 1.0 / $h_val;
                        for ($j = $l; $j < $n; $j++) { // Compute Householder vector elements (stored temporarily in V_calc(:, i))
                            $V_calc[$j][$i] = $U_calc[$i][$j] * $inv_h_val;
                        }
                        // Apply transformation H*V = (I - 2*v*vT)*V = V - 2*v*(vT*V)
                        for ($j = $l; $j < $n; $j++) { // For each column j of V to update
                            $s = 0.0;
                            for ($k = $l; $k < $n; $k++) { // Compute vT*V(:,j)
                                $s += $U_calc[$i][$k] * $V_calc[$k][$j];
                            }
                            $s *= $inv_h_val; // Scale factor = (vT*V(:,j)) / (U(i,l)*g)
                            for ($k = $l; $k < $n; $k++) { // Update V(:,j) = V(:,j) - factor * U(i,k)
                                $V_calc[$k][$j] += $s * $V_calc[$k][$i]; // Use computed Householder vector in V_calc(:,i)
                            }
                        }
                    } // end if h_val != 0.0
                } // end if g != 0.0

                 // Zero out elements related to the transformation in V_calc
                for ($j = $l; $j < $n; $j++) {
                    $V_calc[$i][$j] = 0.0;
                    $V_calc[$j][$i] = 0.0;
                }
            } // end if i < n-1

            // Set diagonal element and reset g for next iteration
            $V_calc[$i][$i] = 1.0;
            $g = 0.0; // Not strictly needed, g is re-read from rv1_vec next iteration
        } // end for i (Accumulation of V)


        // Accumulation of left-hand transformations (U_calc)
        // U_calc starts with bidiagonal form, apply column Householders stored implicitly
        // Loop from i = min(m, n) - 1 down to 0. Since m>=n, loop from n-1 down to 0.
        for ($i = $n - 1; $i >= 0; $i--) {
            $l = $i + 1; // l = i+1
            $g = $W_vec[$i]; // Get diagonal element g = W[i] from Householder phase

            // Apply Householder stored in column i of U_calc (rows i to m-1)
            if ($g != 0.0) {
                 // Apply transformation to columns l to n-1 (LAPACK uses m-1 or n-1 depending on version/context, here seems n-1 is relevant for U update related to V)
                 // Let's stick to the original paper's apparent logic which updates columns i+1 to m-1 of U (U_calc is m x m here)
                 $cols_to_update_U = $m; // Update full columns of U_calc

                 // Calculate factor = 1.0 / (U(i,i) * g)
                 $h_val = $U_calc[$i][$i] * $g;
                 if ($h_val != 0.0) { // Avoid division by zero
                    $inv_h_val = 1.0 / $h_val;

                    for ($j = $l; $j < $cols_to_update_U; $j++) { // For each column j to update
                        $s = 0.0;
                        for ($k = $i; $k < $m; $k++) { // Compute dot product U(i:m-1, i) . U(i:m-1, j)
                            $s += $U_calc[$k][$i] * $U_calc[$k][$j];
                        }
                        $f = $s * $inv_h_val; // Scale factor
                        for ($k = $i; $k < $m; $k++) { // Update column j
                            $U_calc[$k][$j] += $f * $U_calc[$k][$i];
                        }
                    }
                 } // end if h_val != 0.0

                 // Normalize column i
                 $inv_g = 1.0 / $g;
                 for ($j = $i; $j < $m; $j++) {
                     $U_calc[$j][$i] *= $inv_g;
                 }
            } else { // g == 0
                 // Zero out column i
                 for ($j = $i; $j < $m; $j++) {
                     $U_calc[$j][$i] = 0.0;
                 }
            }
             // Set diagonal element U(i,i) = U(i,i) + 1 (part of Householder accumulation)
             $U_calc[$i][$i] += 1.0;
        } // end for i (Accumulation of U)


        // Diagonalization of the bidiagonal form (QR iteration)
        // W_vec contains diagonal, rv1_vec contains superdiagonal (from index 1 upwards)
        // Loop over singular values, k from n-1 down to 0
        for ($k = $n - 1; $k >= 0; $k--) {
            for ($its = 0; $its < 30; $its++) { // Max 30 iterations per singular value
                $flag = true; // Flag indicates rv1[l] needs cancelling

                // Test for splitting: search for negligible superdiagonal element rv1[l]
                // Loop l from k down to 0
                $l = 0; // Initialize l outside loop for scope
                for ($l_search = $k; $l_search >= 0; $l_search--) {
                    $l = $l_search; // Assign found l
                    if ($l == 0) { // Reached top, no split possible below k
                        $flag = false;
                        break;
                    }
                    // Check if rv1[l] is negligible
                    if (abs($rv1_vec[$l]) <= $eps * (abs($W_vec[$k]) + abs($W_vec[$l-1]))) { // Use relative tolerance based on adjacent diagonal elements
                    //if (abs($rv1_vec[$l]) <= $eps * $anorm) { // Original tolerance check
                        $flag = false;
                        break;
                    }
                     // Check if W[l-1] is negligible (another split condition)
                    if (abs($W_vec[$l-1]) <= $eps * $anorm) { // Use $anorm as absolute tolerance floor
                         // Found negligible W[l-1], split occurs here, but rv1[l] needs cancelling below
                         // Original code just breaks, implying cancellation happens. Let's follow that.
                        break;
                    }
                } // end for l_search

                 // Perform cancellation of rv1[l] if necessary (flag is true)
                if ($flag) {
                    $c = 0.0;
                    $s = 1.0;
                    // Chase bulge from l to k using Givens rotations
                    for ($i = $l; $i <= $k; $i++) { // Corrected loop bound <= k
                        $f = $s * $rv1_vec[$i]; // Element to zero out potentially
                        $rv1_vec[$i] = $c * $rv1_vec[$i]; // Apply previous rotation part

                        if (abs($f) <= $eps * $anorm) break; // If already negligible, stop chasing

                        $g = $W_vec[$i];
                        list($c, $s, $h) = $this->givens($g, $f); // Calculate Givens rotation: [c s; -s c] * [g; f] = [h; 0]
                        $W_vec[$i] = $h; // Update diagonal element

                        // Apply rotation to left singular vectors (U_calc)
                         // Rotate columns (l-1) and i of U_calc
                         if ($l - 1 >= 0) { // Ensure column l-1 exists
                             for ($j = 0; $j < $m; $j++) { // Iterate through rows
                                 $y = $U_calc[$j][$l-1];
                                 $z = $U_calc[$j][$i];
                                 $U_calc[$j][$l-1] = $y * $c + $z * $s;
                                 $U_calc[$j][$i] = $z * $c - $y * $s;
                             }
                         }
                    } // end for i (bulge chasing for cancellation)
                } // end if flag

                // Test for convergence: Check if k-th singular value has converged
                $z = $W_vec[$k]; // Current estimate of k-th singular value
                if ($l == $k) { // If loop finished without finding non-negligible rv1[l] below k
                    if ($z < 0.0) { // Ensure singular value is non-negative
                        $W_vec[$k] = -$z;
                        // Flip sign of corresponding right singular vector (column k of V_calc)
                        for ($j = 0; $j < $n; $j++) {
                            $V_calc[$j][$k] = -$V_calc[$j][$k];
                        }
                    }
                    break; // Converged for singular value k, break inner iteration loop
                } // end if l == k (convergence check)

                 // Check for iteration limit
                if ($its == 29) {
                     trigger_error("SVD failed to converge in 30 iterations for k=$k", E_USER_WARNING);
                     // Optionally throw exception or just break
                     break; // Break iteration loop for k
                }

                // Perform QR shift
                // Calculate shift from bottom 2x2 minor: W[k-1], W[k], rv1[k]
                $x = $W_vec[$l]; // Use W[l] from split point as part of shift logic
                $nm = $k - 1; // Index k-1
                $y = $W_vec[$nm];
                $g = $rv1_vec[$nm]; // Superdiagonal rv1[k-1]
                $h = $rv1_vec[$k]; // Superdiagonal rv1[k]

                // Wilkinson shift calculation (or similar QR shift strategy)
                $f = 0.0; $g_shift = 0.0; // Initialize shift calculation variables
                 if ($y != 0.0 && $h != 0.0) { // Avoid division by zero in standard shift calc
                     $denominator_f = (2.0 * $h * $y);
                     if ($denominator_f != 0.0) {
                         $f = (($y - $z) * ($y + $z) + ($g - $h) * ($g + $h)) / $denominator_f;
                         $g_shift = $this->pythag($f, 1.0);
                         // Calculate shift (related to eigenvalue of bottom 2x2)
                          $shift_term = $f + $this->sameSign($g_shift, $f);
                          if ($shift_term != 0.0 && $x != 0.0) {
                              $f = (($x - $z) * ($x + $z) + $h * (($y / $shift_term) - $h)) / $x;
                          } else { $f = 0.0; } // Handle potential division by zero
                     } else { $f = 0.0; }
                 } else { $f = 0.0; } // Use zero shift if standard calculation fails


                // Apply implicit QR step with shift 'f'
                $c = 1.0; $s = 1.0; // These are reused for different Givens rotations below

                // Chase bulge from l up to k-1
                for ($j = $l; $j <= $nm; $j++) { // Loop from split point l up to k-1
                    $i = $j + 1; // Index i = j+1
                    $g = $rv1_vec[$i]; // Superdiagonal rv1[j+1]
                    $y = $W_vec[$i]; // Diagonal W[j+1]
                    $h = $s * $g; // Apply previous rotation component
                    $g = $c * $g; // Apply previous rotation component

                    // First Givens rotation (introduces bulge based on shift f)
                    list($c, $s, $z_rot1) = $this->givens($f, $h);
                    $rv1_vec[$j] = $z_rot1; // Update rv1[j]
                    $f = $c * $x + $s * $g;  // Update element related to W[j] (x holds W[j] state)
                    $g = $c * $g - $s * $x;  // Update element related to off-diagonal
                    $h = $s * $y;            // Update element related to W[j+1]
                    $y = $c * $y;            // Update element related to W[j+1]

                    // Apply first rotation to right singular vectors (V_calc)
                    // Rotate columns j and i of V_calc
                    for ($jj = 0; $jj < $n; $jj++) { // Iterate through rows
                        $x_v = $V_calc[$jj][$j];
                        $z_v = $V_calc[$jj][$i];
                        $V_calc[$jj][$j] = $x_v * $c + $z_v * $s;
                        $V_calc[$jj][$i] = $z_v * $c - $x_v * $s;
                    }

                    // Second Givens rotation (chases bulge down)
                    list($c, $s, $z_rot2) = $this->givens($f, $h);
                    $W_vec[$j] = $z_rot2; // Update diagonal W[j]
                    $f = $c * $g + $s * $y;  // Update f for next iteration (becomes new x)
                    $x = $c * $y - $s * $g;  // Update x (related to W[j+1] state for next iteration)

                    // Apply second rotation to left singular vectors (U_calc)
                    // Rotate columns j and i of U_calc
                    for ($jj = 0; $jj < $m; $jj++) { // Iterate through rows
                        $y_u = $U_calc[$jj][$j];
                        $z_u = $U_calc[$jj][$i];
                        $U_calc[$jj][$j] = $y_u * $c + $z_u * $s;
                        $U_calc[$jj][$i] = $z_u * $c - $y_u * $s;
                    }

                     // Prepare for next superdiagonal element calculation
                     // Need rv1[i] = rv1[j+1] for the next step (j becomes j+1)
                     // This element g needs to be updated based on the rotation just applied to U
                     // The update is rv1[i] = s * W[i] if standard implicit QR notation is followed.
                     // However, original code sets rv1[l]=0, rv1[k]=f, W[k]=x at the end.
                     // Let's follow the original logic for setting rv1.

                } // end for j (QR step bulge chasing)

                // Update final elements after chasing bulge up to k-1
                $rv1_vec[$l] = 0.0; // Connection at split point is zeroed
                $rv1_vec[$k] = $f; // Store remaining part of bulge chase in rv1[k]
                $W_vec[$k] = $x; // Store remaining part of bulge chase in W[k]

            } // end for its (QR iteration loop)
        } // end for k (Singular value loop)
        // --- End of Yehia Abed's Algorithm ---


        // --- Post-processing and final result assignment ---

        // 1. Copy computed singular values (W_vec) to the output S buffer
        // W_vec has size n = min(orig_m, orig_n) if transpose happened, or orig_n otherwise
        // S output vector should have size k = min(orig_m, orig_n)
        $num_singular_values = $k; // k = min(orig_m, orig_n)
        for ($i = 0; $i < $num_singular_values; $i++) {
             $S[$i] = $W_vec[$i]; // Copy from W_vec buffer to S NDArray wrapper
        }

        // 2. Sort singular values and vectors (optional but standard)
        // Sort W_vec, and apply the same permutation to columns of U_calc and V_calc
        $this->sortSvdResults($W_vec, $U_calc, $V_calc, $n, $m); // n=cols, m=rows of computed V, U

        // 3. Extract final U and VT based on transposition
        // U_calc is m x m, V_calc is n x n (where m, n are dims *after* potential transpose)
        // Final U needs to be orig_m x k
        // Final VT needs to be k x orig_n

        if ($transposed) {
            // Original A was orig_m x orig_n (orig_m < orig_n)
            // We computed SVD for A^T (n x m, where n=orig_n, m=orig_m, n > m)
            // U_calc is n x n, V_calc is m x m
            // S is size m (k = m)
            // We need final U = V_calc (orig_m x k = m x m)
            // We need final VT = U_calc^T (k x orig_n = m x n)

            // Target U: orig_m x k (m x m)
            // Target VT: k x orig_n (m x n)

            // Copy V_calc (m x m) to final U (orig_m x k = m x m)
            $U_final = new NDArrayPhp($U_buf, $dtype, [$orig_m, $k], $offsetU, service:$this->service); // Target shape m x k
            for ($r = 0; $r < $orig_m; ++$r) { // Rows of U (and V_calc)
                for ($c = 0; $c < $k; ++$c) { // Columns of U (and V_calc, k=m)
                     $U_final[$r][$c] = $V_calc[$r][$c];
                }
            }

            // Copy U_calc^T (m x n) to final VT (k x orig_n = m x n)
             $VT_final = new NDArrayPhp($VT_buf, $dtype, [$k, $orig_n], $offsetVT, service:$this->service); // Target shape k x n
             for ($r = 0; $r < $k; ++$r) { // Rows of VT (cols of U_calc, k=m)
                 for ($c = 0; $c < $orig_n; ++$c) { // Columns of VT (rows of U_calc, n=orig_n)
                     $VT_final[$r][$c] = $U_calc[$c][$r]; // Transpose
                 }
             }

        } else {
            // Original A was orig_m x orig_n (orig_m >= orig_n)
            // We computed SVD for A (m x n, where m=orig_m, n=orig_n, m >= n)
            // U_calc is m x m, V_calc is n x n
            // S is size n (k = n)
            // We need final U = U_calc(:, 0:k-1) (orig_m x k = m x n)
            // We need final VT = V_calc^T (k x orig_n = n x n)

             // Target U: orig_m x k (m x n)
            // Target VT: k x orig_n (n x n)

            // Copy relevant columns of U_calc (m x n) to final U (orig_m x k = m x n)
            $U_final = new NDArrayPhp($U_buf, $dtype, [$orig_m, $k], $offsetU, service:$this->service); // Target shape m x k
            for ($r = 0; $r < $orig_m; ++$r) { // Rows of U (and U_calc)
                for ($c = 0; $c < $k; ++$c) { // Columns of U (and U_calc, k=n)
                     $U_final[$r][$c] = $U_calc[$r][$c];
                }
            }

            // Copy V_calc^T (n x n) to final VT (k x orig_n = n x n)
             $VT_final = new NDArrayPhp($VT_buf, $dtype, [$k, $orig_n], $offsetVT, service:$this->service); // Target shape k x n
             for ($r = 0; $r < $k; ++$r) { // Rows of VT (cols of V_calc, k=n)
                 for ($c = 0; $c < $orig_n; ++$c) { // Columns of VT (rows of V_calc, n=orig_n)
                     $VT_final[$r][$c] = $V_calc[$c][$r]; // Transpose
                 }
             }
        }

        // 4. Optional: Normalize signs for consistency
        $this->normalizeSvdSigns($U_final, $VT_final, $k);


    } // end gesvd

    // --- Helper Functions ---

    // Helper to compute Givens rotation: [c s; -s c] * [a; b] = [r; 0]
    // Returns [c, s, r]
    private function givens(float $a, float $b) : array
    {
        if ($b == 0.0) {
            return [1.0, 0.0, $a];
        } else {
            if (abs($b) > abs($a)) {
                $tau = -$a / $b;
                $s = 1.0 / sqrt(1.0 + $tau*$tau);
                $c = $s * $tau;
                $r = $b / $s; // Should be -b / s ? Let's recheck LAPACK d/srotg source if needed. Using pythag logic:
                //$r = $this->pythag($a, $b); // r should be sqrt(a^2 + b^2)
                //$c = $a / $r;
                //$s = -$b / $r; // Sign convention might differ
                // Let's use robust version from LAPACK d/srotg logic:
                 $r = $this->pythag($a, $b);
                 $c = $a / $r;
                 $s = $b / $r; // LAPACK uses this sign for s
                 return [$c, $s, $r];

            } else {
                 $tau = -$b / $a;
                 $c = 1.0 / sqrt(1.0 + $tau*$tau);
                 $s = $c * $tau;
                 $r = $a / $c; // LAPACK uses this sign for s
                 return [$c, $s, $r];
            }
        }
    }

    // Helper function to sort SVD results (W_vec, U_calc, V_calc) based on descending W_vec values
    // Modifies U_calc and V_calc columns in place.
    // n_comp = number of columns in V_calc (n after transpose potentially)
    // m_comp = number of rows in U_calc (m after transpose potentially)
    protected function sortSvdResults(
        Buffer $W_vec, NDArray $U_calc, NDArray $V_calc,
        int $n_comp, int $m_comp
        ): void
    {
        $num_singular_values = $n_comp; // Number of values in W_vec

        // Create pairs of [singular_value, original_index]
        $pairs = [];
        for ($i = 0; $i < $num_singular_values; $i++) {
            // Use null coalescing for safety, though W_vec should be populated
            $pairs[] = [$W_vec[$i] ?? 0.0, $i];
        }

        // Sort pairs in descending order based on singular value
        usort($pairs, function ($a, $b) {
            // Add small tolerance or handle NaN/Inf if necessary
            if (abs($a[0] - $b[0]) < 1e-15) return 0; // Treat close values as equal for stability
            return ($b[0] < $a[0]) ? -1 : 1; // Descending order
        });

        // Create permutation map
        $permutation = array_column($pairs, 1); // Original indices in sorted order
        $is_sorted = ($permutation === range(0, $num_singular_values - 1));

        if (!$is_sorted) {
            // Apply permutation to W_vec (singular values)
            $sorted_W_vals = array_column($pairs, 0);
            for ($i = 0; $i < $num_singular_values; $i++) {
                 $W_vec[$i] = $sorted_W_vals[$i];
            }

            // Apply permutation to columns of U_calc and V_calc
            // This requires creating temporary copies of the matrices or columns

            // Permute U_calc columns
            $U_copy = $this->copyToNew($U_calc); // Make a copy
            for ($j = 0; $j < $num_singular_values; $j++) { // Iterate through sorted positions
                $original_col_idx = $permutation[$j];
                if ($original_col_idx < $U_calc->shape()[1]) { // Check bounds (use actual U_calc shape)
                    // Copy column original_col_idx from U_copy to column j in U_calc
                    for ($i = 0; $i < $m_comp; $i++) {
                        $U_calc[$i][$j] = $U_copy[$i][$original_col_idx];
                    }
                }
            }
            unset($U_copy); // Free memory

            // Permute V_calc columns
            $V_copy = $this->copyToNew($V_calc); // Make a copy
            for ($j = 0; $j < $num_singular_values; $j++) { // Iterate through sorted positions
                 $original_col_idx = $permutation[$j];
                 if ($original_col_idx < $V_calc->shape()[1]) { // Check bounds (use actual V_calc shape)
                     // Copy column original_col_idx from V_copy to column j in V_calc
                     for ($i = 0; $i < $n_comp; $i++) { // V_calc has n_comp rows
                         $V_calc[$i][$j] = $V_copy[$i][$original_col_idx];
                     }
                 }
            }
            unset($V_copy); // Free memory
        }
    }

     // Helper function to create a new NDArray and copy data from another
     protected function copyToNew(NDArray $X) : NDArray {
         $Y = $this->alloc($X->shape(), $X->dtype());
         $this->copy($X, $Y);
         return $Y;
     }


     // Optional: Normalize signs of U columns and VT rows for consistent output
     // Convention: Make the element with largest absolute value in each U column non-negative.
     protected function normalizeSvdSigns(NDArray $U_final, NDArray $VT_final, int $k): void
     {
         $u_rows = $U_final->shape()[0];
         $u_cols = $U_final->shape()[1]; // Should be k
         $vt_rows = $VT_final->shape()[0]; // Should be k
         $vt_cols = $VT_final->shape()[1];

         for ($j = 0; $j < min($k, $u_cols, $vt_rows); ++$j) { // Iterate up to k or available columns/rows
             // Find element with largest absolute value in column j of U_final
             $max_abs_val = 0.0;
             $sign = 1.0;
             $idx_max = 0; // Index of the element with max abs value

             for ($i = 0; $i < $u_rows; ++$i) {
                  // Check bounds just in case, though loop should be correct
                 if ($i < $u_rows && $j < $u_cols) {
                     $u_ij = $U_final[$i][$j];
                     $abs_val = abs($u_ij);
                     if ($abs_val > $max_abs_val) {
                         $max_abs_val = $abs_val;
                         $idx_max = $i;
                         // Use sign of this element (safer than checking < 0.0 if it's exactly zero)
                         $sign = ($u_ij >= 0.0) ? 1.0 : -1.0;
                     }
                 }
             }

             // If sign of the max abs element is negative, flip signs
             if ($sign < 0.0) {
                 // Flip U_final column j
                 for ($i = 0; $i < $u_rows; ++$i) {
                      if ($i < $u_rows && $j < $u_cols) { // Check bounds
                         $U_final[$i][$j] *= -1.0;
                      }
                 }
                 // Flip VT_final row j
                 if ($j < $vt_rows) { // Ensure row j exists in VT_final
                     for ($col = 0; $col < $vt_cols; ++$col) {
                          if ($j < $vt_rows && $col < $vt_cols) { // Check bounds
                              $VT_final[$j][$col] *= -1.0;
                          }
                     }
                 }
             }
         }
     }

    // private function print(NDArray $a) : void ...
    // private function alloc(array $shape, int $dtype) : NDArray ...
    // private function copy(NDArray $X, NDArray $Y) : void ...
    // private function sameSign(float $a, float $b) : float ...
    // private function pythag(float $a, float $b) : float ...
    // public function transpose(NDArray $X) : NDArray ...
    // protected function _transpose(...) : void ...
    // (Keep these helper implementations as they were, assuming they are correct)

     /**
      * @param array<int> $shape
      */
     private function alloc(array $shape, int $dtype) : NDArray
     {
         // Ensure service is initialized (e.g., in constructor or via setter)
         if (!isset($this->service)) {
             throw new \LogicException("Service not initialized in PhpLapack");
         }
         return new NDArrayPhp(null, $dtype, $shape, service: $this->service);
     }

     private function copy(NDArray $X, NDArray $Y) : void
     {
         // Basic copy assuming contiguous data and same shape/dtype for simplicity
         // A robust implementation should handle strides, different shapes/dtypes etc.
         if($X->shape() !== $Y->shape() || $X->dtype() !== $Y->dtype()) {
              // Allow copy if shapes are compatible (e.g., broadcasting source to dest)
              // For now, require exact shape match
             if($X->size() !== $Y->size()) {
                throw new InvalidArgumentException('Cannot copy: Array sizes do not match. X=' . $X->size() . ', Y=' . $Y->size());
             }
             // If size matches but shape doesn't, reshape Y before copy? Or throw error?
             // Let's throw for now to be safe.
             throw new InvalidArgumentException('Cannot copy: Array shapes or dtypes do not match.');
         }
         $N = $X->size();
         $XX = $X->buffer();
         $offX = $X->offset();
         $YY = $Y->buffer();
         $offY = $Y->offset();
         // Use buffer's bulk copy if available and efficient
         if (method_exists($XX, 'copy') && $XX === $YY) {
             // Assuming Buffer::copy($src_offset, $dst_offset, $length) exists
             // This requires the Buffer object to support copying within itself
             // If X and Y use *different* buffer objects, this won't work.
             // $XX->copy($offX, $offY, $N); // Example syntax
             // Fallback to element-wise copy if Buffer::copy isn't suitable
             for ($i = 0; $i < $N; $i++) {
                 $YY[$offY + $i] = $XX[$offX + $i];
             }
         } else {
             // Element-wise copy
             for ($i = 0; $i < $N; $i++) {
                 $YY[$offY + $i] = $XX[$offX + $i];
             }
         }
     }

     private function sameSign(float $a, float $b) : float
     {
         // Returns |a| if b >= 0, -|a| if b < 0
         return ($b >= 0) ? abs($a) : -abs($a);
     }

     private function pythag(float $a, float $b) : float
     {
         // Computes sqrt(a^2 + b^2) robustly to avoid overflow/underflow
         $absa = abs($a);
         $absb = abs($b);
         if ($absa > $absb) {
             if ($absa == 0.0) return 0.0;
             $ratio = $absb / $absa;
             return $absa * sqrt(1.0 + $ratio * $ratio);
         } else {
             if ($absb == 0.0) return 0.0;
             $ratio = $absa / $absb;
             return $absb * sqrt(1.0 + $ratio * $ratio);
         }
     }

     /**
     *   copied from MatrixOperator
     */
     public function transpose(NDArray $X) : NDArray
     {
         $shape = $X->shape();
         if (count($shape) !== 2) {
             throw new InvalidArgumentException("Transpose currently only supports 2D matrices.");
         }
         $newShape = array_reverse($shape);
         $Y = $this->alloc($newShape, $X->dtype());

         $rows = $shape[0];
         $cols = $shape[1];
         $XX = $X->buffer(); $offX = $X->offset();
         $YY = $Y->buffer(); $offY = $Y->offset();
         $dtype = $X->dtype();

         // Simple transpose for row-major NDArrayPhp assumed here
         // A more general version would consider strides.
         $idxX = $offX;
         for($i=0; $i<$rows; ++$i) {
             for($j=0; $j<$cols; ++$j) {
                 $idxY = $offY + $j * $rows + $i; // Target index in transposed array (assuming row-major)
                 $YY[$idxY] = $XX[$idxX];
                 $idxX++;
             }
         }
         // The recursive _transpose might be more general if strides are handled.
         // Let's keep the simple loop for clarity for now.
         /*
         $w = 1;
         $posY = 0;
         $posX = 0;
         $this->_transpose($newShape, $w, $X->buffer(), $X->offset(), $posX, $Y->buffer(), $posY);
         */
         return $Y;
     }
     /**
      * @param array<int> $shape
      */
      /* // Recursive transpose - keep commented unless needed and verified for NDArrayPhp
     protected function _transpose(
         array $shape, int $w,
         Buffer $bufX, int $offX, int $posX,
         Buffer $bufY, int &$posY) : void
     {
         // ... (implementation) ...
     }
     */

} // End Class PhpLapack

// Dummy BLAS Factory and Buffer for standalone testing
if (!class_exists('Rindow\Math\Matrix\Drivers\MatlibPHP\PhpBLASFactory')) {
     class PhpBLASFactory {
         public function create($size, $dtype) { return new PhpBuffer($size, $dtype); }
     }
     class PhpBuffer implements Buffer {
         public array $data;
         public int $dtype;
         public function __construct(int $size, int $dtype) { $this->data = array_fill(0, $size, 0.0); $this->dtype = $dtype; }
         public function offsetExists($offset): bool { return isset($this->data[$offset]); }
         public function offsetGet($offset): mixed { return $this->data[$offset]; }
         public function offsetSet($offset, $value): void { $this->data[$offset] = $value; }
         public function offsetUnset($offset): void { unset($this->data[$offset]); }
         public function slice(int $offset, int $length): Buffer { /* Implement slicing if needed */ return $this; }
         public function dtype(): int { return $this->dtype; }
         public function count(): int { return count($this->data); }
         public function value() { return $this->data; } // For debugging
     }
}
// Assume NDArray constants are defined if Interop isn't loaded fully
if(!defined('Rindow\Math\Matrix\NDArray::float32')) {
    class_alias('MyNDArrayConstants', 'Rindow\Math\Matrix\NDArray');
}
class MyNDArrayConstants {
    const float32 = 10;
    const float64 = 11;
    // ... other constants
}
// Assume Service constants are defined
if(!defined('Rindow\Math\Matrix\Drivers\Service::LV_BASIC')) {
     class_alias('MyServiceConstants', 'Rindow\Math\Matrix\Drivers\Service');
}
class MyServiceConstants {
    const LV_BASIC = 1;
}

// --- Example Usage ---
/*
require_once 'vendor/autoload.php'; // Adjust path if necessary
use Rindow\Math\Matrix\MatrixOperator;
use Rindow\Math\Matrix\Drivers\MatlibPHP\PhpLapack;
use Rindow\Math\Matrix\NDArrayPhp;

$mo = new MatrixOperator();
$la = $mo->la(); // Get Linear Algebra instance

// Use the pure PHP Lapack implementation
$phpLapack = new PhpLapack();
$la->setLapack($phpLapack); // Assuming a method exists to set the Lapack driver


echo "--- Original Matrix Test ---\n";
$a = $la->array([
    [ 8.79,  9.93,  9.83,  5.45,  3.16,],
    [ 6.11,  6.91,  5.04, -0.27,  7.98,],
    [-9.15, -7.93,  4.86,  4.85,  3.01,],
    [ 9.57,  1.64,  8.83,  0.74,  5.80,],
    [-3.49,  4.02,  9.80, 10.00,  4.27,],
    [ 9.84,  0.15, -8.99, -6.02, -5.31,],
], dtype: NDArrayPhp::float64); // Use float64 for better precision like OpenBLAS

[$u,$s,$vt] = $la->svd($a); // svd should call the registered gesvd

echo "U:\n"; $mo->print($u,"%.6f");
echo "S:\n"; $mo->print($s,"%.6f");
echo "VT:\n"; $mo->print($vt,"%.6f");

echo "\n--- Transposed Matrix Test ---\n";
$a_t = $la->transpose($a);

[$u_t,$s_t,$vt_t] = $la->svd($a_t);

echo "U (from transposed A):\n"; $mo->print($u_t,"%.6f");
echo "S (from transposed A):\n"; $mo->print($s_t,"%.6f");
echo "VT (from transposed A):\n"; $mo->print($vt_t,"%.6f");

// Expected U for transposed case (approximately)
echo "\nExpected U approx (from user):\n";
$expected_u_t = [
 [  0.25,  0.81, -0.26,  0.40, -0.22],
 [  0.40,  0.36,  0.70, -0.45,  0.14],
 [  0.69, -0.25, -0.22,  0.25,  0.59],
 [  0.37, -0.37,  0.39,  0.43, -0.63],
 [  0.41, -0.10, -0.49, -0.62, -0.44]
];
print_r($expected_u_t);

// Verification: Check U * S * VT against original A
//$smat = $la->diag($s); // Create diagonal matrix from S
//$reconstructed_a = $la->matmul($u, $la->matmul($smat, $vt));
//echo "\nReconstructed A (Original):\n"; $mo->print($reconstructed_a, "%.2f");

//$smat_t = $la->diag($s_t);
//$reconstructed_a_t = $la->matmul($u_t, $la->matmul($smat_t, $vt_t));
//echo "\nReconstructed A (Transposed):\n"; $mo->print($reconstructed_a_t, "%.2f");

*/
```

**主な変更点:**

1.  **バッファ管理と一時配列:**
    *   入力行列 `A` をコピーして `work_A` を作成し、アルゴリズムが元のデータを破壊しないようにしました。
    *   `if ($orig_m < $orig_n)` で転置が必要な場合、`work_A` を転置し、計算用の次元 `m`, `n` を更新します。
    *   アルゴリズムの計算に必要な一時的な行列 `U_calc` (m x m), `V_calc` (n x n) とベクトル `W_vec` (n), `rv1_vec` (n) を明示的に確保 (`alloc`) します。これにより、出力バッファ `U_buf`, `VT_buf` のサイズに依存せず、アルゴリズムが必要とする十分な作業領域を確保します。
2.  **アルゴリズムの修正:**
    *   `V` の不適切な初期化を削除しました。
    *   Householder変換、QR反復のループ範囲やインデックスを再確認し、より標準的な実装に近づけました。特に `l=i+1` の使用、許容誤差の計算方法 (`eps * (abs(Wk)+abs(Wl-1))`) を調整しました。
    *   Givens回転の計算 (`givens` ヘルパー関数) を追加しました。
    *   ゼロ除算の可能性のある箇所にチェックを追加しました。
3.  **結果の再構成:**
    *   `if ($transposed)` ブロックを全面的に書き換えました。
    *   計算結果の `U_calc` と `V_calc` から、元の行列 `A` に対する正しい `U` (`V_calc` の一部または全体) と `VT` (`U_calc` の一部の転置) を、最終的な出力バッファ `U_buf`, `VT_buf` に正しくコピーするようにしました。出力行列の次元 (`orig_m x k`, `k x orig_n`) を考慮しています。
4.  **ソートと符号正規化:**
    *   `sortSvdResults` ヘルパー関数を追加し、計算された特異値 (`W_vec`) を降順にソートし、対応する `U_calc` と `V_calc` の列を並べ替えます。
    *   `normalizeSvdSigns` ヘルパー関数を追加し、最終的な `U_final` の各列の絶対値最大の要素が非負になるように `U_final` と `VT_final` の符号を調整します。これにより、結果がより一貫し、期待値と比較しやすくなります。
5.  **ヘルパー関数:** `copyToNew`, `givens` を追加しました。既存のヘルパー (`alloc`, `copy`, `sameSign`, `pythag`, `transpose`) は基本的に維持しますが、`transpose` は2D専用に単純化し、`copy` は基本的な機能に留めています。

**試していただきたいこと:**

1.  上記の修正版 `PhpLapack` クラスをプロジェクトに組み込んでください。
2.  `Rindow\Math\Matrix\MatrixOperator` (または同等のもの) で `setLapack` のようなメソッドを使い、この `PhpLapack` インスタンスをSVD計算に使用するように設定してください (もしそのような仕組みがなければ、`svd` メソッド内で直接 `PhpLapack::gesvd` を呼び出すように修正する必要があるかもしれません)。
3.  転置した場合のテストケースを再度実行し、出力される `u_t` が期待される `U` (符号の違いは許容) に近づいたか確認してください。 `normalizeSvdSigns` により、符号も一致する可能性が高まります。
4.  元の行列 (`$a`) と転置行列 (`$a_t`) の両方で `[$u,$s,$vt] = $la->svd(...)` を実行し、`$la->matmul($u, $la->matmul($la->diag($s), $vt))` が元の行列を（許容誤差範囲内で）復元できるか確認することも有効です。

この修正により、転置行列に対するSVD計算がより正確になるはずです。ただし、PHPでの数値計算には限界があるため、OpenBLASの結果と完全にビット単位で一致することは期待できない点にご注意ください。
