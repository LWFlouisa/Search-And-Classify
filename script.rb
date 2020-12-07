require "naive_bayes"
a = NaiveBayes.new(:clogs, 
:sneaker)
a.db_filepath = "data/baysian/language.nb"
a.train(:clogs, 'clogs', 'word');
a.train(:sneaker, 'sneaker', 'word');

a.save
