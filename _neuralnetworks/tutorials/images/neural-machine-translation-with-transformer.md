---
layout: document
title: "Neural Machine Translation with Transformer Models in PHP"
upper_section: tutorials/tutorials
previous_section: tutorials/neural-machine-translation-with-attention
---

In this tutorial, we'll build a translation model from French to English using a Transformer model in PHP.

What is a Transformer Model
---------------------------

A Transformer is a translation model that uses an attention mechanism.
It's a very powerful model that can be applied to various tasks, not just natural language processing.
It doesn't use RNN blocks but rather uses only attention, which improves parallel computation efficiency and enables faster learning and inference.

![Attention Image](images/transformer-translation.png)

Prerequisites
------------
Before starting, please set up Rindow Neural Networks. For installation instructions, refer to
[Installing Rindow Neural Networks](/neuralnetworks/install.md).

Experience how Transformers can run efficiently even in PHP.
If you're using a Windows environment, we recommend using Rindow CLBlast / OpenCL.

This tutorial is for those who have completed the [Basic Image Classification in PHP](basic-image-classification.html) tutorial or have equivalent knowledge.

Dataset
-------
We'll use data for various languages provided by http://www.manythings.org/anki/.
This data contains pairs of English sentences and their translations in other languages.
In this tutorial, we'll use the English and French dataset.

For example:
```
Let me do that.       Laissez moi faire ça.
```
We'll convert this data into a format that can be input to our model.

First, we split the data into English and French sentences and add markers to the beginning and end of each sentence.

```
English:   <start> Let me do that. <end>
French:    <start> Laissez moi faire ça. <end>
```

Next, we convert these sentences into sequences using a tokenizer.
The tokenizer performs the following processes:

+ Removes special characters from the sentences.
+ Splits them into words.
+ Creates a word dictionary.
+ Converts words into word numbers to create sequences.

The input sequence is completed by padding the converted sequences to the maximum length.
Since the French dataset has 190,000 sentence pairs, we'll cut it at an appropriate point and shuffle the order.

Here's the code that does these things:
```php
// Code for the dataset class goes here
```

Let's create the dataset:
```php
// Code to instantiate the dataset class and load the data goes here
```

Transformer Model Structure
--------------------------
The Transformer model is an encoder-decoder model consisting of an encoder and a decoder.

The encoder processes the input French sentences and extracts their meaning.
The decoder generates English sentences from the meaning received from the encoder.
Both the encoder and decoder have a structure that repeats similar blocks 6 times internally.
In the tutorial code, you can specify the number of repetitions.

### Block Structure
Each block consists of Multi-Head Attention, Feed Forward Network, and Add & Layer Normalization.

- **Multi-Head Attention**: A mechanism that determines and processes which information to focus on within the input information.
- **Feed Forward Network**: A standard neural network that is applied to each sequence.
- **Residual Connection (addition processing) and Layer Normalization**: Stabilizes and accelerates learning.

![Transformer Model](images/transformer-translation-model.svg)

### Positional Embedding
The input is a French sentence, with words converted to vectors.
The output is an English sentence, with the probability of generating each word.
The input and output teacher data undergo word-to-vector conversion (Embedding) and positional information addition (Positional Encoding).
This sample uses sine wave-based positional encoding.

```php
// Code for positional embedding goes here
```

Let's see how positional information is encoded.
You can see that different values are added for each position.

```php
// Code for positional encoding goes here
```

![Positional Encoding Image](images/transformer-translation-positionalenc.png)

### Residual Connection and Layer Normalization

Residual Connection is a technique introduced to mitigate the vanishing gradient problem in deep neural networks and stabilize learning. Residual Connection is achieved by adding the original input to the output of each sublayer.
Layer Normalization can stabilize learning without depending on batch size.

### Multi-Head Attention
Multi-Head Attention is a mechanism that compares input information from various angles and controls where to focus.

It can focus on any information regardless of distance, making it applicable to various tasks.
The core of Multi-Head Attention, Scaled Dot-Product Attention, calculates the dot product of queries and keys, and weights values based on similarity.
If a query and a key are similar, the corresponding value is strongly reflected.
As the name "Multi-Head" suggests, it calculates attention multiple times in multiple different ways on the input, and combines the results, enabling comparison of information from various angles.

Rindow Neural Networks provides Multi-Head Attention as a single layer.
This makes it easy to use the powerful capabilities of Multi-Head Attention.

```php
// Code for the three types of multi-head attention goes here
```

### Feed Forward Network

After Multi-Head Attention, a feed-forward network is placed. This network applies non-linear transformations to each word's embedding vector, enhancing the model's expressiveness.

```php
// Code for feed forward goes here
```

### Encoder Block
The encoder processes the input French sentences and extracts their meaning.

```php
// Code for encoder layer and encoder goes here
```

### Decoder Block
The decoder generates English sentences from the meaning received from the encoder.

The decoder block uses Masked Multi-Head Attention, known as Causal Self-Attention.
Unlike normal self-attention, Causal Self-Attention is restricted to reference only information from past positions in the input sequence. In other words, a word at a certain position cannot see information from words at later positions.
This restriction is particularly important in text generation tasks. In text generation, the next word needs to be generated based on previously generated words, and if it sees future information, the generated text would become unnatural. Causal Self-Attention prevents such future information leakage, enabling natural text generation.

By using this for the output teacher data (English sentences in this case), it becomes possible to predict subsequent words one after another, being influenced only by the preceding words.

Also, in cross-attention, encoder outputs are used for keys and values, and decoder inputs are used for queries.
For each position in the output teacher data, information with high relevance to the input is output.

```php
// Code for decoder layer and decoder goes here
```

### Creating the Transformer Model
Let's create the Transformer model by combining these components.

```php
// Code for the transformer model goes here
```

### Loss Function and Metric Function

In the loss function, we mask parts that shouldn't influence the calculation before computing.

Similarly, the metric function is also masked.
The target label values are the words one step ahead in the output teacher data.
This allows us to teach which words should be predicted.

```php
// Code for loss function, metric function, and label creation goes here
```

### Training
For training, we use a scheduler that gradually reduces the learning rate.

```php
// Code for scheduler and training goes here
```

```
// Training results go here
```

![Training History](images/transformer-translation-training.png)

### Prediction
Let's perform machine translation with the trained model.

First, we provide the input French sentence and the output start mark,
and predict the word that comes after the start mark.
We then add the predicted word after the start mark, and from the input, start mark, and predicted word,
we predict the next word.
This process is repeated to predict the entire output.

```php
// Code for the translator goes here
```

Let's select sample data and translate it.

```php
// Code for executing the translator goes here
```

```
// Prediction results go here
```
