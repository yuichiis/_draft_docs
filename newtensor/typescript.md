理由はかなり深いです。
# JavaScript/TypeScriptにおけるテンソル計算とネイティブ連携の技術動向 (2026年版)

## 1. ネイティブ連携の仕組み (FFI / N-API / WebAssembly)
JavaScriptからC言語等の関数を呼び出す仕組みは、実行環境（Node.js / Browser）により異なります。

### 代表的な4系統
1. **Node.js FFI (node-ffi-napi)**
   - PHPのFFIに近く、共有ライブラリ（.so, .dll）を直接ロード可能。
   - 型定義をJSオブジェクトで記述する。
2. **Node-API (N-API)**
   - Node.js公式のネイティブ拡張機構。C/C++で記述し、`.node`バイナリとしてビルド。
   - FFIより高速で、ABI互換性が強い。
3. **WebAssembly (WASM)**
   - 現在の主流。C/C++/RustをWASMへコンパイルして利用。
   - ブラウザでも動作し、サンドボックス化されているため安全かつポータブル。
4. **Browser Restrictions**
   - セキュリティ上の理由から、ブラウザJSでの直接的なDLLロードやポインタ操作は不可。WASMが唯一の選択肢。

### 比較表
| 項目 | PHP FFI | Node.js FFI | Node-API | WebAssembly |
| :--- | :--- | :--- | :--- | :--- |
| 直接呼び出し | 可能 | 可能 | 可能 | コンパイルが必要 |
| ポインタ操作 | 可能 | 可能 | 可能 | 仮想メモリ内のみ |
| ブラウザ対応 | 不可 | 不可 | 不可 | **可能** |
| 実行速度 | 速い | やや遅い | **非常に速い** | 速い |
| 安全性 | 危険 | 危険 | 危険 | 安全 |

---

## 2. テンソル演算とGPU計算の変遷

### 歴史的背景
- **第1世代: Pure JS ndarray** (`mathjs`, `ndarray`): 軽量だが、大規模行列では遅くSIMDも使えない。
- **第2世代: TensorFlow.js**: WebGLを活用したGPU演算と、Backend抽象化の概念を導入。
- **第3世代: WASM + SIMD**: WASMのSIMD/Threads対応により、CPU上でのBLAS演算がWASMへシフト。
- **第4世代: WebGPU**: 現代の本命。CUDA風のGPU計算をブラウザおよびNode.jsで実現。

### 2026年のトレンド
- **CPU**: Rust/C++ で実装されたコアを **WASM SIMD** バックエンドとして提供。
- **GPU**: **WebGPU (WGSL)** への統一。OpenCL/WebGLからの移行が進む。
- **アーキテクチャ**: `TypeScript API` -> `Backend Abstraction` -> `WASM/WebGPU` という、環境に依存しない構成が理想的。

---

## 3. 主要機械学習フレームワーク

| フレームワーク | 推論 | 学習 | GPU | 特徴 |
| :--- | :---: | :---: | :---: | :--- |
| **TensorFlow.js** | ◎ | ◎ | ◎ | 最大勢力。Keras風。WebGPU対応済み。 |
| **ONNX Runtime Web** | ◎ | △ | ◎ | 業界標準。Pythonで学習したモデルの実行に最適。 |
| **Transformers.js** | ◎ | × | ◎ | Hugging Face系。LLM推論に特化。 |
| **Rust系 (Burn/Candle)** | ◎ | △ | ◎ | RustコアをWASM化してTSから利用する新潮流。 |

### なぜTypeScriptでの「学習」は進まないのか
1. **CUDAエコシステム**: AI学習の最適化は依然としてNVIDIA/CUDAに強く依存している。
2. **Pythonエコシステム**: PyTorch/JAX等の巨大な資産、論文の実装がPythonに集中。
3. **自動微分の未熟さ**: 高性能な自動微分エンジンがJS界隈ではまだ少ない。
4. **メモリ管理**: GPUメモリのライフサイクル管理（GCとの相性）が困難。

---

## 4. 次世代「汎用テンソル計算基盤」の設計構想

CUDA依存やPythonのオーバーヘッドを解消するため、AI専用ではなく**汎用科学計算（量子演算、物理シミュレーション等）を含む基盤**を構築する。

### 推奨スタック
- **Frontend**: TypeScript (高機能な型システム、エコシステム)
- **Core Logic**: Rust (メモリ安全、SIMD、高速演算)
- **Backend**: WebGPU (Vulkan/Metal/DX12の抽象化によるCUDA Lock-in回避)

### コア設計思想: 「Tensor IR」中心の設計
PyTorch等の既存フレームワークを超越するために、単なる関数の集まりではなく **中間表現 (IR)** を中心に据える。

1. **Immutable Tensor Graph**: 操作を即時実行せず、グラフとして保持。
2. **Graph Optimization**: カーネル融合 (Fusion) やレイアウト変換による最適化。
3. **Symbolic Dimensions**: TypeScriptの型システムを活かした形状チェック。
4. **Sparse Support**: 疎行列やテンソルネットワークを最初から考慮した抽象化。

### 開発ロードマップ案
- **Phase 1**: Tensor IR の定義 + WASM SIMD / WebGPU バックエンドの実装。
- **Phase 2**: 自動微分エンジン + カーネル融合最適化。
- **Phase 3**: テンソルネットワーク、量子回路シミュレータ、分散ランタイムの追加。
- **Phase 4**: コンパイラスタック、カスタムカーネルDSLの統合。

### 結論
成功の鍵は、単なる「NumPyのクローン」や「AIフレームワーク」を作ることではなく、**「Universal Tensor Runtime (汎用テンソル・ランタイム)」** として、ブラウザ・Node・Edgeを統合するレイヤを目指すことにあります。
