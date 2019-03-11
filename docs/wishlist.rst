========
WishList
========

Contains the list of things which I know are possible, but I do not know exactly how to achieve them.

Tensorflow not releasing GPU
----------------------------

* After a `tensorflow` session is closed it is still not releasing the GPU. Which means that the GPUs are available for another tensorflow model or Tensor, but not available for other modules such as `PyTorch`. This means `nvidia-smi` will show the GPUs are occupied. The GPU is freed when the process which uses tensorflow is terminated. This is a known issue, a partial solution is to write all tensorflow related code in a single function and call that function using a new process. A sample code snippet is given below
  ::
    
    from multiprocessing import Process, Manager
    def tf_func(sample_text, my_dict):
        # All tensorflow related computations here.
        Convert the result into a numpy array
        my_dict['result'] = np_result_array 

    def main():
        manager = Manager()
        d = manager.dict() # Dummy dictionary to store the result of computation.
        p = Process(target=tf_func, args=(sample_text, d))
        p.start() # Start the process
        p.join() # Wait for the process to finish.
        res = d['result'] # Copy the result from dictionary to a variable


* One caveat, is that `multiprocessing` uses `pickle` internally which relies on a default protocol which does'nt let you save data greater than 4GB. Therefore the above procedure did not work for me. I was unable to figure out a way through which I could change the default protocol to a higher number. 

* Another way is to use global variables for sharing data between processes. However, it is tricky and needs `Locks`. More content at `Python` section.


Unusually Long screen log file
------------------------------

You have been using screen log file to see the results of python programs. Consider a python modules which serves embeddings (on a server). After some time the file gets enormously long (and big) because of continous logging. At the same time, you do not want to completely do away with screen logging as it is super useful for debugging purposes.

Live example: A server which serves word embeddings. By default, the server logs the requests (e.b. 200 OK).

Wish: If we could restrict the file size by number of lines such that only the latest "k" lines are logged at any point in time.
