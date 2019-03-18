===========================
Natural Language Processing
===========================

Spacy
-----

* Installing spacy :bash:`pip install spacy`.
* Download the English model using :bash:`python -m spacy download en`
* There are other ready to use `spacy models <https://spacy.io/usage/models>`_ too.
* Basic usage:
  ::
    
      import spacy
      nlp = spacy.load("en") # Load the default English model
      text = "This is sample text. This is second sentence. This is the third one."
      doc = nlp(text)
      for token in doc:
          print(token.is_punct)
          print(token.is_punct)
          print(token.is_punct)
          print(token.is_punct)
          print(token.is_punct)
          print(token.is_punct)
          # More attributes of token are mentioned here: https://spacy.io/api/token


* Spacy has a lot of `Language Processing Pipeline <https://spacy.io/usage/processing-pipelines>`_

