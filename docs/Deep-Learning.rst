Deep Learning
=============

CUDA
----

* It is possible to install CUDA and CuDNN locally. Take a look at `this link<https://stackoverflow.com/questions/39379792/install-cuda-without-root>`__


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


Pre-trained Word Embeddings
---------------------------

* Use Magnitude to obtain pre-trained word embeddings. Loads super fast
* 

PyTorch
-------

* Instead of moving a tensor to a GPU, one can instead create a tensor on GPU
* If you use `ReLU` activation functions in the last layers, you are more likely to see `NaN` values while computing loss. Instead prefer `tanh`

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
