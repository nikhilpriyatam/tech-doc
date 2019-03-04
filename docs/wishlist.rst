========
WishList
========

Contains the list of things which you know are possible, but you do not know exactly how to achieve them.

Unusually Long screen log file
------------------------------

You have been using screen log file to see the results of python programs. Consider a python modules which serves embeddings (on a server). After some time the file gets enormously long (and big) because of continous logging. At the same time, you do not want to completely do away with screen logging as it is super useful for debugging purposes.

Live example: A server which serves word embeddings. By default, the server logs the requests (e.b. 200 OK).

Wish: If we could restrict the file size by number of lines such that only the latest "k" lines are logged at any point in time.
