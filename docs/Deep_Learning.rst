Deep Learning
=============


CUDA and CuDNN
--------------

* You need to install `CUDA` or `CuDNN` to impliment deep learning related stuff. You can indeed install these tools locally, without any root permissions. Please see this `link <https://stackoverflow.com/a/47503155/5408791>`_. For this solution to work you need to have a proper driver installed. 

* As of editing this page, the latest stable cuda version is 9.0.

* Add the following to your .bashrc (or any other appropriate file)

  * :code:`export CUDA_VISIBLE_DEVICES=0,1,2 # If 3 GPUs are housed on that machine.`
  * :code:`export CUDA_HOME="/home/nikhil.pattisapu/cuda-9.0/" # Give appropriate path`
  * :code:`export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_HOME/lib64/`
  * :code:`export LD_LIBRARY_PATH_SCREEN=$LD_LIBRARY_PATH`

* If you do not want PyTorch / TensorFlow to see all the GPUs available. Use the following snippet in your python code.

  :code:`import os`
  :code:`os.environ['CUDA_VISIBLE_DEVICES']=1 # If you want it to see only GPU ID 1`
  :code:`CUDA_VISIBLE_DEVICES=2 python <file> # If you want it to see only GPU ID 2`


Tensorflow and Tensorflow Hub
-----------------------------

* Tensorflow installation has two options, depending on whether you have a GPU or CPU.

  * :code:`pip install tensorflow-gpu`
  * :code:`pip install tensorflow`

* The default CPU only tensorflow binary (installed through pip) is not compiled to use AVX AVX2 (libraries for faster computation). You will see a warning of the following type :code:`Your CPU supports instructions that this TensorFlow binary was not compiled to use: AVX AVX2`. To avoid this you have to compile tensorflow from the source (which is a pain). An easier alternative is to use pre-compiled binaries with `AVX` and `AVX2` support. Check `this repo <https://github.com/lakshayg/tensorflow-build.git>`_
  

* Tensorflow uses lazy computation. In short it means that, it creates a computation graph and executes it when necessary. The ideal way to code is to ensure that you create a single graph and use it (or execute it) several times using :code:`tf.placeholder()`. You can even have :code:`tf.string` type placeholder. This is especially useful for obtaining text representations using pretrained models 

* You can create and use a tensorflow graph manually in the program in the following way
  ::

	import tensorflow as tf
  	graph_1 = tf.Graph() # Creating a graph. Method 1
  	with graph_1.as_default():
    	# Using the graph Method 1.
    	# The code writting in this indented block would be contribute to graph object graph_1.
    
    	with tf.Session() as sess:
    		# This session runs operations on the object graph_1.
			a_numpy_array = sess.run(a) # Pass a tensor.

* Even if you do not create a graph explicitly, tensorflow will create a default graph and session objects in the program will use them. If your program creates a large number of unconnected subgraphs, it may be more efficient to use a different :code:`tf.Graph` to build each subgraph, so that unrelated state can be garbage collected.

* :code:`tf.Sesssion().run()` is a costly operation. Use it sparingly. It might be also a little slow when you call it for the first time.

* Several latest pre-trained models are released as :code:`tensorflow-hub` modules which can be called easily. Find the instructions below.

  * :code:`pip install tensorflow-hub`
  * Create a directory to store all the downloaded tensorflow models. Say `tfhub_modules`. 
  * :code:`export TFHUB_CACHE_DIR=~/tfhub_modules/`
  * Refer the sample code below for obtaining sentence representations using `Universal Sentence Encoder`. You can lookup for other models `here <https://www.tensorflow.org/hub>`_
  	::

		import tensorflow as tf
		import numpy as np
		import tensorflow_hub as hub

		module_url = "https://tfhub.dev/google/universal-sentence-encoder-large/3"
		use = hub.Module(module_url, trainable=False)
		t1 = ["this is one sentence", "this is another sentence"]
		t2 = ["let us watch a movie", "let us work"]
		t3 = ["music is awesome", "carnatic is the real music"]
		data = [t1, t2, t3]

		ph = tf.placeholder(tf.string, shape=(2))
		embeddings = use(ph)

		with tf.Session() as sess:
			sess.run(tf.global_variables_initializer())
			sess.run(tf.tables_initializer())
			for item in data:
				var = sess.run(embeddings, {ph:item})
				print(var.shape)
				print(type(var))

  
PyTorch
-------

* Instead of moving a tensor to a GPU, one can instead create a tensor on GPU
* If you use `ReLU` activation functions in the last layers, you are more likely to see `NaN` values while computing loss. Instead prefer `tanh`
