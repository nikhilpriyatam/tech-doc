Here we list the best python coding practices which are relatively less known

Loops
=====

*  When using a `for loop` use enumerate function instead of incrementing a counter::

   for ix, item in enumerate(my_list):
       # ix represents index. It acts as a counter
       # item contains the value.

*  When traversing through multiple lists of same size use `zip` function ::

   for itm_a, itm_b in zip(list_a, list_b):
       # itm_a contains the value of list_a
       # itm_b contains the value of list_b

*  If you want to loop backwards, use `reversed` function::

   for color in reversed(colors):
       print(color)

*  Suppose you want to use a `for loop` with `break` statement. You could check whether the loop ran completely by using an else statement::

   for item in my_list:
       if item == 'something':
           print("Item found")
           break

   # This else acts like if no-break occured. No need to use extra variables.
   else:
       print("The loop did not break")

       
Dictionaries
============

*  Suppose you wanted to obtain the value corresponding to a key in a dictionary, use::

   # No error even if the key is not present in the dictionary.
   my_val = my_dict.get('my_key', 'my_default_val')

* You could contruct a dictionary from pairs using `zip` and `dict` constructor::

  names = ['nikhil', 'aparnna']
  ages = ['29', '24']

  d = dict(zip(names, ages))

* Counting with dictionary. Suppose you had a list with repeating items and you had to count the number of occurrences of each item. The simplest way is to use the following::

  colors = ['red', 'green', 'red', 'blue', 'green', 'red']
  d = {}
  for color in colors:
      d[color] = d.get(color, 0) + 1

* We could use `defaultdict` instead of plain `dict` from python if we know the type of values being stored. Suppose I know that my values are integers, like the code above, I could write the following code::

  from collections import defaultdict
  colors = ['red', 'green', 'red', 'blue', 'green', 'red']
  d = defaultdict(int) # default value of int is 0
  for color in colors:
      d[color] += 1 # defaultdict never raises a KeyError

  # ice_cream = defaultdict(lambda: 'Vanilla') <-- Assigning a function object to the defaultdict


* You can also group a set of items in a list using a defaultdict. For instance::

  from collections import defaultdict
  names = ['nikhil', 'aparnna', 'kameswari', 'vamsi', 'prasad', 'p.p.rao']
  d = defaultdict(list) # The default value is an empty list

  for name in names:
      key = len(name) # Grouping the names based on their length
      d[key].append(name)

Miscellaneous
=============

*  To exchange the values of two variables, do not use a third temporary variable. Instead use::

   # This is clean and easy to understand
   x, y = y, x
   

*  You can use an `else` statement even with `try` and `except` to execute statements there were no exceptions. Similarly, you can use `finally` to execute statements regardless of whether an exception occurred or not::

   try:
       print(int('x'))
   except:
       print('Conversion Failed')
   
   # If no-except
   else:
       print('Conversion successful')
   # Always execute this statement.
   finally:
       print('Done')


*  You can also use only `try` and `finally` as follows::

   try:
       f = open('my_file.txt')
   # Contains the clean up code which needs to be executed even if an exception occurred.
   finally:
       f.close()
   

*  While reading a text file we can use `with` statement with context, without having to close it manually::

   with open('my_file.txt') as f:
       for line in f:
           print(line)


* Always clarify function calls with keyword arguments::

  # Bad way
  twitter_search('@obama', False, 20, True)

  # Good way
  twitter_search('@obama', retweets=False, numtweets=20, popular=True)

* Always, return `NamedTuple` instead of plain `Tuple` as it is more informative::

  # Bad way
  def get_body_stats():
      return (70, 6)

  # Good way
  from collections import namedtuple
  def get_body_stats():
      BodyStats = namedTuple('BodyStats', ['weight', 'height'])
      return BodyStats(70, 6)
