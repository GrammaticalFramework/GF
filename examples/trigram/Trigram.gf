abstract Trigram = {

cat 
    -- A sentence
    S ;

    -- A lexicon is a set of 'Word's
    Word ;

    -- All N-gram instances seen in the corpus are abstract syntax constants
    Unigram (a     : Word) ;
    Bigram  (a,b   : Word) ;
    Trigram (a,b,c : Word) ;

    -- A text is a sequence words where the sequence is indexed by the last two tokens
    Seq (a,b : Word) ;

    -- The estimated probability of the trigram 'a b c' is the total probability of all 
    -- trees of type Prob a b c.
    Prob (a,b,c : Word) ;

data
    sent : ({a,b} : Word) -> Seq a b -> S ;

    -- Here we construct sequence by using nil and cons. The Prob argument ensures
    -- that the sequence contains only valid N-grams and contributes with the right
    -- probability mass
    nil  : (a,b,c : Word) -> Prob a b c -> Seq b c ;
    cons : ({a,b} : Word) -> Seq a b -> (c : Word) -> Prob a b c -> Seq b c ;

    -- Here we construct probabilities. There are two ways: by trigrams, by bigrams and
    -- by unigrams. Since the trigramP, bigramP, unigramP functions have some associated
    -- probabilities as well this results in linear smoothing between the unigram, bigram 
    -- and trigram models
    trigramP : ({a,b,c} : Word) -> Trigram a b c -> Prob a b c ;
    bigramP  : ({a,b,c} : Word) -> Bigram a b -> Bigram b c -> Prob a b c ;
    unigramP : ({a,b,c} : Word) -> Unigram a -> Unigram b -> Unigram c -> Prob a b c ;

}