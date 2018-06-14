Useful concepts from IRE
========================

* Term frequency is a function of term and document TF(t, d). Inverse document
  frequency is a function of term and Dataset IDF (t, D).

Stanford Core NLP
-----------------
* When I was running the StanfordCoreNLP server in `10.4.17.63` and passing the
  data from a different server `10.4.17.64` through `nltk.parse.corenlp`, I was
  getting the error "requests.exceptions.HTTPError: 403 Client Error: Forbidden
  for url :http://10.4.17.63:9000/...".  
  
* Fix: I have set the `no_proxy` variable in `~/.bashrc` file of `10.4.17.64`
  which reads like `export no_proxy=10.4.17.63`

* The following is a sample code to get the dependency tree for a sample text::
    
    import nltk
    import nltk.parse.corenlp as corenlp
    parser = corenlp.CoreNLPParser('http://localhost:9000')
    text = 'Let me try this.'
    sample_op = list(parser.parse_text(text))
    sample_op[0].draw()


DBPedia Spotlight
-----------------

* I have created a DBPedia spotlight server locally and used it to ___annotate 
  and disambiguate___ entities or phrases in my text. The following instructions
  would help us to do it better.  Go to the github link for 
  `DBPedia Spotlight <https://github.com/dbpedia-spotlight/dbpedia-spotlight>`_ and read 
  the instructions (especially in the **Run your own server** section).  
  Start the server on a screen session using the command:: 
  
    java -Xmx10g -jar dbpedia-spotlight-1.0.0.jar * en_2+2 http://localhost:2222/rest

* Now you can call the server for three purposes **spot**, **disambiguate** or
  **annotate (spot + disambiguate)**. More help available at 
  `Wiki <https://github.com/dbpedia-spotlight/dbpedia-spotlight/wiki/Web-service>`_.
	  
* A general use case - Pass some text and get the DBPedia concepts annotated. 
  The following command does that::

    bash curl http://localhost:2222/rest/annotate --data-urlencode
    "text=Narendra Modi is the prim minister of India." --data "confidence=0.2"
    --data "support=20"

* My specific use case - I had the concepts marked in my text. I just wanted
  to link it with DBPedia. In that case, I used the following command::

    bash curl http://localhost:2222/rest/disambiguate -H "Accept: text/xml"
    --data 'text=<annotation text="New Delhi is the capital of
    India"><surfaceForm name="New Delhi" offset="0"></surfaceForm></annotation>'

  * **Imp Note** For the above command to work, one must always `escape` the 
    single quote, i.e. **'** in the text.

NLTK
----

* NLTK can be used for a lot of NLP related tasks. I have used stanfordCoreNLPServer 
  to extract NLTK parse trees. The following is the code to print such a parse tree::

    from nltk.tree import Tree
    from nltk.draw.tree import TreeView
    from nltk.draw import TreeWidget
    from nltk.draw.util import CanvasFrame

    t = Tree.fromstring('(S (NP this tree) (VP (V is) (AdjP pretty)))') 
    cf = CanvasFrame()
    tc = TreeWidget(cf.canvas(),t)
    tc['node_font'] = 'arial 14 bold'
    tc['leaf_font'] = 'arial 14'
    tc['node_color'] = '#005990'
    tc['leaf_color'] = '#3F8F57'
    tc['line_color'] = '#175252'
    cf.add_widget(tc,10,10) # (10,10) offsets cf.print_to_file('tree.ps')
    cf.destroy()
