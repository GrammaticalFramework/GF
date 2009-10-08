concrete TrigramCnc of Trigram = {

lincat 
    Word,Seq = Str;

    Unigram, Bigram, Trigram, Prob = {} ;

lin
    nil  a b c _   = a ++ b ++ c ;
    cons _ _ l c _ = l ++ c ;

}