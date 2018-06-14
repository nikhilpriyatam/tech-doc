Deep Learning
=============

GPU
---

* :code:`CUDA_VISIBLE_DEVICES=<gpu_id> python <file>` , where :code:`<gpu_id>`
  is the id of the free GPU (which you have to check manually using the command
  :code:`nvidia-smi`). This ensures that Tensorflow only uses the
  :code:`<gpu_id>` GPU.

* In the code, add the following lines before calling::

    tf.Session()
    gpu_options = tf.GPUOptions(per_process_gpu_memory_fraction=0.333)

Related link `here
<https://stackoverflow.com/questions/34199233/how-to-prevent-tensorflow-from-allocating-the-totality-of-a-gpu-memory>`__


Tensorflow
----------

* I was able to use the GPU on my mac by following instructions provided
  `here <https://github.com/hughperkins/tf-coriander>`__.
* Three types of variables :code:`Constants` (Once initialized, can never change, for
  e.g. learning rate eta), :code:`Variables` (e.g. neural network Weights -
  are not initialized until :code:`init = tf.global_variables_initializer()
  sess.run(init)` is run) and :code:`Placeholders` (can be substituted with any
  variable, like input x). Following are few examples::

    import tensorflow as tf
    const = tf.constant(0.1, shape=shape)
    W = tf.Variable(tf.truncated_normal(shape, stddev=0.1))
    x = tf.placeholder(tf.float32) # A placeholder is a promise to provide a
    value later.

* All the variables from :code:`numpy` must be converted to :code:`float32` as
  :code:`float64` is not supported by tensorflow::
    
    mat = np.random.rand(4,4)
    mat_tf = tf.cast(mat, tf.float32)

* One of the important things in `tf` is `convolution layers`. The following is
  a sample code on CNNs::
    
    # promise to provide value later
    x = tf.placeholder(tf.float32, shape=(1024, 1024))
    # Initialize weight matrix randomly with small values.
    W = tf.Variable(tf.truncated_normal(shape, stddev=0.1)) 
    conv_op = tf.nn.conv2d(x, W, strides=[1, 1, 1, 1], padding='SAME')

* For CNNs, we use convolution and max pool layers. For both, we use sliding
  windows, which in turn requires a parameter of the type :code:`strides=[1, 1, 1,
  1]`, the four integers represent the following :code:`[batch, height, width, channels]`.

Server for Word2Vec Embeddings
------------------------------

* Loading w2v embeddings in python/keras programs takes a very long time. The
  following is a nice work-around : Setup the word embeddings through API call
  * Clone `word2vec-api <https://github.com/3Top/word2vec-api>`_ repository.
  * Follow the instructions to *serve* the embeddings

  * There are many things that you can do with the loaded embeddings like
    finding most similar word to a word etc. But here I cover the most crucial
    application - Given a word (in this case **the**) find its embedding::

      import requests
      import base64
      import struct

      req = requests.get('http://127.0.0.1:1234/word2vec/model?word=the')
      bb = base64.b64decode(req.json())
      emb = [item[0] for item in struct.iter_unpack('f', bb)]


PyTorch
-------

Gensim
------

* To get **word embeddings** from gensim (version 2.3.0) use the following code
  snippet::
     
    import numpy as np
    from gensim.models import word2vec

    model = word2vec.Word2Vec.load('dbpedia.w2v')
    model.wv['india'] # model.wv['DBPEDIA_ID/India']

    def getVector(word):
        if word in model:
            return model[word]
        else:
            return np.zeros(model.vector_size)

* To get **document or paragraph embeddings** from gensim (version 2.3.0) use
  the following code snippet::

    import numpy as np
    import nltk
    from gensim.models.doc2vec import Doc2Vec, LabeledSentence

    def get_paragraph_vectors(phrase_list):
      sentences = []
      for id_phrase in enumerate(phrase_list):
        sentences.append(LabeledSentence(words=nltk.word_tokenize(id_phrase[1]), labels=[u'PHRASE_'+str(id_phrase[0])]))

      model = Doc2Vec(alpha=0.025, min_alpha=0.025)  # use fixed learning rate  
      model.build_vocab(sentences)
      model.train(sentences)
