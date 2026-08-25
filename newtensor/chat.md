

JavaScriptにはC言語の外部関数呼び出しの仕組みはありますか?PHPのFFIなどと同じ仕組みです。

はい。JavaScriptにもC言語の関数を呼び出す仕組みはありますが、PHPのFFIのように「標準でどこでも同じように使える」わけではなく、実行環境ごとに方法が異なります。

代表的なのは次の4系統です。

1. Node.js の FFI（PHPのFFIにかなり近い）
Node.jsではネイティブライブラリ（.so .dll .dylib）を直接呼べます。

代表ライブラリ:

Node.js

node-ffi-napi GitHub

例:

const ffi = require('ffi-napi');

const libm = ffi.Library('libm', {
  cos: ['double', ['double']]
});

console.log(libm.cos(0));
これはPHPのFFIとかなり近い感覚です。

PHP:

$ffi = FFI::cdef("
    double cos(double x);
", "libm.so");
Node.js側は型定義をJSオブジェクトで書きます。

2. N-API / Node-API（本格的なネイティブ拡張）
Node.js公式のネイティブアドオン機構です。

Node-API Documentation

C/C++を書いて:

Napi::Number Add(const Napi::CallbackInfo& info) {
    return Napi::Number::New(info.Env(), 1 + 2);
}
これをNode.jsから:

const addon = require('./build/Release/addon.node');
console.log(addon.add());
特徴:

FFIより高速

JS↔C間のオーバーヘッドが少ない

Node本体とのABI互換が強い

ネイティブモジュール開発向け

PHPのZend Extensionに近い世界です。

3. WebAssembly（現在かなり主流）
最近は「Cを直接呼ぶ」のではなく、C/C++ → WASM にコンパイルしてJavaScriptから呼ぶ方法が非常に多いです。

WebAssembly

Emscripten

流れ:

C/C++ → WebAssembly → JavaScriptから呼び出し
JS:

const result = wasmInstance.exports.add(1, 2);
特徴:

ブラウザでも動く

高速

サンドボックス安全

ポータブル

最近の「JSからネイティブコード高速実行」はかなりWASM寄りです。

4. ブラウザでは基本的に直接FFIは不可
セキュリティ上の理由で、ブラウザJavaScriptは:

DLLロード

任意共有ライブラリ呼び出し

生ポインタ操作

などはできません。

つまり:

LoadLibrary("kernel32.dll")
みたいなことは不可です。

ブラウザでは実質:

JavaScript ↔ WebAssembly
が唯一の「ネイティブ連携」に近い仕組みです。

PHP FFIとの比較
項目	PHP FFI	JavaScript(Node.js FFI)
C関数直接呼び出し	可能	可能
ポインタ操作	可能	可能
構造体	可能	可能
ブラウザ対応	不可	FFI不可
実行速度	比較的速い	ややオーバーヘッド大
安全性	危険	危険
主流度	限定的	WASMが主流化
実行速度面
一般に:

N-API addon > WASM > FFI
になりやすいです。

FFIは:

動的型変換

マーシャリング

ポインタ変換

のコストがあるため、頻繁な関数呼び出しでは遅くなります。

大量処理では:

N-API

Rust addon

WASM

がよく使われます。

最近の傾向
2020年代以降は:

「JSからCを直接叩く」
↓
「Rust/C++をWASM化」
へかなり移行しています。

特に:

画像処理

AI推論

音声処理

動画処理

ゲーム

はWASM利用が急増しています。


2026年時点のJavaScript/TypeScriptにおける BLAS・多次元配列・GPU 計算のトレンドは、かなり整理すると次のようになっています。

現在の大きな流れ
現在は大きく4系統あります。

系統	主な用途	現在の勢い
Pure JS ndarray	軽量数値計算	減少傾向
WASM + SIMD	CPU高速演算	強い
WebGPU	GPU計算	急増
ネイティブ addon	Node限定超高速	一部で継続
現在の主戦場はかなり:

WASM + WebGPU
へ移っています。

まず歴史
第1世代: Pure JS ndarray
昔は:

ndarray

mathjs

numeric.js

などが多かったです。

例:

mathjs

しかしPure JSは:

SIMD弱い

キャッシュ効率弱い

GC負荷

大規模行列で遅い

問題がありました。

第2世代: TensorFlow.js
大きな転機。

TensorFlow.js

特徴:

WebGL GPU利用

backend abstraction

Node native backendあり

内部的には:

JS API
↓
backend abstraction
↓
WebGL / WASM / native
という構造。

かなり現在の方向性を決定しました。

第3世代: WASM + SIMD
ここで急激に変わりました。

理由:

WASM SIMD

threads

shared memory

が成熟したため。

現在CPU側はかなり:

BLAS in WASM
へ向かっています。

第4世代: WebGPU
今最も勢いが強い。

WebGPU

現在は:

CUDA風GPU計算
↓
ブラウザ & Node
へ向かっています。

現在強いライブラリ
1. ONNX Runtime Web
かなり重要。

ONNX Runtime Web

backend:

WASM

WebGPU

WebGL

を切替可能。

今の「モダン構成」に近い。

2. TensorFlow.js
依然巨大。

backend:

CPU

WASM

WebGL

WebGPU

があります。

3. WebGPU系
かなり急増しています。

例:

gpu.js

webgpu-blas

transformers.js

4. Rust + WASM ndarray
かなり増加中。

Rust側:

ndarray

nalgebra

candle

burn

など。

JSへWASM export。

BLASの現在地
重要なのはここです。

「BLASを直接FFIで呼ぶ」
は最近そこまで主流ではないです。

昔は:

OpenBLAS
↓
Node addon
が多かった。

しかし現在は:

Rust/C++
↓
WASM SIMD
↓
JS
が増えています。

理由:

配布容易

Browser対応

Electron対応

Bun/Deno対応

ABI問題減少

です。

GPUはさらに別世界
GPUは現在かなり:

CUDA専用
↓
WebGPU abstraction
へ移っています。

つまり:

JS/TS
↓
WGSL shader
↓
WebGPU
構造。

もし今作るならどうするべきか
ここが本題。

あなたが今:

BLAS + ndarray library
を作るなら、おそらく以下がかなり現代的です。

推奨アーキテクチャ
CPU backend
Rust
↓
portable SIMD
↓
WASM SIMD
理由:

クロスプラットフォーム

npm配布容易

Browser対応

保守しやすい

GPU backend
WebGPU
一択に近づいています。

OpenCL/WebCL系はかなり衰退。

JS/TS API
表面APIは:

tensor.matmul(a, b)
のようなPyTorch/TensorFlow風。

内部backend切替。

backend abstraction
現在の主流設計。

TS API
↓
Backend interface
├─ WASM SIMD backend
├─ WebGPU backend
└─ fallback JS backend
TensorFlow.js型。

かなり重要: ndarray互換
JS界隈では:

NumPy風API
期待が非常に強い。

必要なのは:

shape

stride

broadcast

contiguous/non-contiguous

view/slice

です。

ここを雑にすると厳しい。

Node.js限定なら
もしBrowser不要なら選択肢が増えます。

Node限定高性能版
Rust/C++
↓
N-API
↓
OpenBLAS / oneDNN / cuBLAS
これは依然かなり強い。

特に:

AI

HPC

DB

では強い。

しかし長期トレンドは
かなり:

native addon
↓
WASM + WebGPU
へ寄っています。

特にWebGPUが巨大
これはかなり重要です。

今後:

GPU計算 = WebGPU
へ統一される可能性が高い。

Node.jsもWebGPU対応が進んでいます。

もし今ゼロから設計するなら
かなり現代的なのは:

おすすめ構成
TypeScript API
↓
Backend abstraction
├─ WebGPU backend (主力)
├─ WASM SIMD backend (CPU)
└─ JS fallback backend
内部実装:

Rust
↓
wasm-pack
↓
npm package
GPU:

WGSL shaders
なぜこれが強いのか
これで:

Browser

Node

Bun

Deno

Electron

をほぼ統一できます。

これは現在かなり大きい価値です。

今後5年くらいの方向性
かなり高確率で:

NumPy/Torch風TS API
↓
backend abstraction
↓
WebGPU + WASM
方向へ進みます。

特に:

AI

scientific computing

image processing

vector DB

signal processing

で加速しています。


TypeScriptで書ける、推論実行だけでなく、モデル開発や学習が出来る機械学習フレームワークはありますか?

はい。あります。
ただし2026年現在の状況を整理すると、

「TypeScriptで推論」
はかなり成熟していますが、

「TypeScriptで本格的な学習」
はまだPython(PyTorch/JAX)が圧倒的優勢です。

その中で、TS/JSで「モデル定義・学習・推論」まで可能な代表系統は次のようになります。

現在の主要勢力
フレームワーク	推論	学習	GPU	Browser	Node	状況
TensorFlow.js	◎	◎	◎	◎	◎	最大勢力
ONNX Runtime Web	◎	△	◎	◎	◎	推論中心
Transformers.js	◎	×	◎	◎	◎	推論専用
WebLLM	◎	×	◎	◎	○	LLM推論
Brain.js	○	○	△	○	○	小規模
Synaptic	○	○	×	○	○	古い
ConvNetJS	○	○	×	○	○	古典
WebGPU Native系	◎	△	◎	◎	○	新世代
1. TensorFlow.js（最大手）
現在も「TS/JSで学習までやる」なら実質これが本命です。

TensorFlow.js

できること
モデル定義
const model = tf.sequential();
model.add(tf.layers.dense({ units: 128 }));
学習
await model.fit(xs, ys);
GPU
backend:

WebGPU

WebGL

WASM

Node native

対応。

特徴
かなり:

「KerasをJS化」
した感じです。

強み
Browserで学習可能

TypeScript親和性

deployment容易

frontend統合容易

WebGPU対応

弱み
かなり重要。

Python版TensorFlowより弱い
特に:

distributed training

custom kernel

CUDA optimization

ecosystem

最新研究

が弱い。

PyTorchほど研究用途で使われない
現在研究界隈はほぼ:

PyTorch
です。

TensorFlow.jsは:

frontend AI

browser ML

demo

edge

inference

軽量学習

寄り。

2. Brain.js
Brain.js

昔からある。

簡単なニューラルネット向け。

特徴
const net = new brain.NeuralNetwork();
net.train(data);
非常に簡単。

ただし
本格深層学習には弱い。

今はやや存在感減少。

3. Transformers.js
Transformers.js

Hugging Face系。

重要
これは:

学習ではなく推論中心
です。

ただ現在JS AI界隈で非常に重要。

特徴
const pipe = await pipeline("text-generation");
だけでLLM推論可能。

backend:

ONNX

WebGPU

WASM

4. ONNX Runtime Web
ONNX Runtime Web

現在かなり重要。

立ち位置
Pythonで学習
↓
ONNX export
↓
TS/JSで推論
が主流。

つまり現在の実態
重要。

2026年現在の本流はかなり:

学習 = Python
推論 = TS/JS
です。

なぜTS学習が難しいのか
理由はかなり深いです。

1. CUDA ecosystem
AI学習の本体はほぼCUDA。

しかしJSは:

CUDAと距離が遠い
です。

2. Python ecosystemが巨大すぎる
現在AI研究は:

PyTorch

JAX

Triton

CUDA

cuDNN

中心。

論文コードも全部Python。

3. Autograd ecosystem差
PyTorch/JAXは:

自動微分
が非常に成熟。

JS側はまだ弱い。

4. メモリ管理
GPU tensor管理は:

lifecycle

gradient graph

VRAM reuse

が超重要。

GC言語は不利。

ただしWebGPUで状況が変化中
ここが非常に重要。

現在:

WebGPU + WASM
により、

TS/JS機械学習は再び勢いが出ています。

今後伸びそうな方向
かなり:

TypeScript frontend
↓
WebGPU backend
↓
LLM inference
が急成長。

特に:

browser AI

edge AI

local AI

multimodal UI

で重要。

「TSでPyTorchをやりたい」動き
あります。

かなり増えています。

例
WebGPU tensor engine
多数出現中。

例えば:

WebNN

TVM Web

MLC

Burn

Candle Web

など。

Rust backend + TS frontend
現在かなり熱い。

Rust tensor engine
↓
WASM/WebGPU
↓
TypeScript API
です。

もし今「TS機械学習FW」を作るなら
かなり現代的なのは:

推奨構成
TypeScript API
↓
autograd graph
↓
backend abstraction
├─ WebGPU
├─ WASM SIMD
└─ CPU fallback
内部:

Rust tensor core
かなり重要: Python互換
今後成功するには:

PyTorch API互換
が極めて重要。

つまり:

tensor.matmul(a, b)
tensor.reshape(...)
tensor.backward()
など。

結論
2026年時点では:

本格学習
依然:

Python (PyTorch/JAX)
が圧倒的。

TS/JSの強み
急成長しているのは:

推論
ブラウザAI
WebGPU
frontend統合
edge AI
です。

TSで学習可能な最大勢力
現状は:

TensorFlow.js
が最有力。

将来性
かなり高確率で:

Rust tensor core
+
WebGPU
+
TypeScript API
方向へ進みます。


CUDAに依存しない本格的機械学習フレームワークが必要と考えています。
しかしPythonは言語仕様が悪く、実行速度も遅いのでTypeScriptで新しいテンソル演算のエコシステムを作るべきと考えています。
ただし、機械学習だけでなく、量子演算シュミレーションやその他のテンソル演算すべてを対象にしたいです。
どのように作ったらいいと思いますか?

かなり面白い方向性です。
実際、2024〜2026あたりから、

「Python + CUDA中心のAIスタックは限界では？」
という問題意識は強くなっています。

特に:

Pythonが orchestration layer として重すぎる

CUDA依存が強すぎる

NVIDIA lock-in

NumPy/PyTorch ecosystem の複雑化

tensor abstraction が AI 専用寄り

distributed/runtime/compiler が分裂

などです。

あなたの方向性は、実は:

「AI専用」ではなく
「汎用テンソル計算基盤」
を作る方向で、かなり将来性があります。

これはむしろ:

scientific computing

differentiable programming

physics simulation

quantum simulation

probabilistic programming

graphics

DSP

HPC

を統合できる可能性があります。

まず重要な設計思想
もし本当に新世代を狙うなら、

「機械学習フレームワーク」
として作らないほうが良いです。

むしろ:

汎用 tensor IR + execution runtime
として設計したほうが強い。

現在の問題
PyTorch/JAX/TensorFlow は実質:

DL framework
として設計されています。

そのため:

sparse tensor

symbolic tensor

tensor network

quantum tensor

lazy tensor

distributed tensor

が後付けになりやすい。

あなたが狙うべき方向
かなり理想的なのは:

コア設計
Tensor Algebra Runtime
です。

AIはその上の1アプリケーション。

レイヤ構成
おすすめはこうです。

TypeScript API
↓
Tensor IR
↓
Optimization passes
↓
Backend abstraction
├─ CPU SIMD
├─ WebGPU
├─ Vulkan
├─ Metal
├─ ROCm
├─ distributed runtime
└─ quantum simulator backend
かなり重要: 「Tensor IR」
ここが本体です。

PyTorch/JAXを超えたいなら:

IR first
にする必要があります。

なぜIR中心か
AI以外を扱うと:

lazy evaluation

symbolic transform

graph rewrite

contraction optimization

autodiff

distributed planning

が必須になります。

つまり:

Tensor operation graph
を中心に設計する必要がある。

イメージ
例えば:

const y =
  A.matmul(B)
   .reshape([N, M])
   .fft()
   .quantumContract(...)
これを即実行せず、

IR graph
として保持。

その後:
fusion

tiling

layout transform

backend lowering

する。

これは:

XLA

MLIR

TVM

Halide

系統の考え方です。

TypeScriptを選ぶ意味
これは実はかなり合理的です。

TSの強み
1. 構文がまとも
Pythonより:

型システム

module system

tooling

AST ecosystem

が強い。

2. frontend/backend統合
重要。

UI
+
visualization
+
runtime
+
distributed orchestration
を統合しやすい。

3. WebGPUとの相性
TSはWebGPU時代に非常に強い。

4. npm ecosystem
配布が強い。

ただしTSだけでは厳しい
ここは重要。

本体実行系はおそらく:

Rust
にすべきです。

理想構成
かなりおすすめなのは:

TypeScript
↓
high-level graph API

Rust
↓
runtime + optimizer + execution engine
です。

なぜRustか
理由:

ownershipでtensor lifecycle管理しやすい

SIMD強い

GPU binding作りやすい

WASM強い

concurrency強い

MLIR連携しやすい

GPU backend
CUDA依存を避けたいなら重要。

現実的戦略
まず:

WebGPU
を主backendにする。

なぜWebGPUか
これが非常に重要。

WebGPUは実質:

クロスGPU IR
になりつつあります。

対応:

Vulkan

Metal

DX12

へ変換される。

つまり:

CUDA lock-in回避
にかなり有効。

さらに将来的には
backend追加:

ROCm
Vulkan compute
Metal compute
oneAPI
可能。

量子シミュレーション対応
ここが面白い。

量子系を扱うなら:

Tensor Network
を最初から意識すべきです。

例えば:

MPS

PEPS

tensor contraction

など。

つまり必要なのは
単なる:

dense ndarray
ではなく、

general tensor algebra system
です。

重要: sparseを最初から考える
AI専用FWの失敗点の一つ。

必要:

sparse tensor

block sparse

symbolic sparse

lazy sparse

autodiffも一般化
AIだけでなく:

physics

optimization

PDE

quantum

で必要。

おすすめ設計思想
かなり重要。

「NumPy clone」を作らない
ここが分岐点。

NumPy/PyTorch互換だけだと:

後発劣化版
になりやすい。

目指すべきは
むしろ:

Tensor Operating System
に近い。

具体的には
1. immutable tensor graph
基本immutable。

2. lazy execution
即実行しない。

3. graph optimizer
fusion必須。

4. backend lowering
backend抽象化。

5. differentiable IR
autodiffをIRレベルで。

6. symbolic dimension
shape system強化。

特にShape Type Systemは重要
TSの強みを使える。

例えば:

Tensor<[Batch, Channels, Height, Width], Float32>
みたいな。

これはPythonよりかなり強い。

実際かなり有望な方向
今後:

Python orchestration
+
CUDA monopoly
への反発は増える可能性があります。

特に:

browser AI

edge AI

local inference

heterogeneous compute

では。

もし私なら最初に作るもの
かなりおすすめなのは:

Phase 1
Tensor IR
+
WASM SIMD backend
+
WebGPU backend
Phase 2
autodiff
+
kernel fusion
+
shape typing
Phase 3
distributed runtime
+
tensor network
+
quantum simulation
Phase 4
compiler stack
+
custom kernel DSL
+
graph rewrite engine
最後にかなり重要な点
もし成功を狙うなら、

「AI framework」
ではなく、

「Universal Tensor Runtime」
として設計したほうが、
長期的には圧倒的に強いと思います。


