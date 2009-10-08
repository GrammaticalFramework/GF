concrete TrigramCnc of Trigram = {

lincat 
    S,Word,Seq = Str;

    Unigram, Bigram, Trigram, Prob = {} ;

lin
    sent _ _ l = l ;
    nil  a b c _   = a ++ b ++ c ;
    cons _ _ l c _ = l ++ c ;

}