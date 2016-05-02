concrete PhraseSlv of Phrase = CatSlv ** open Prelude, ResSlv in {

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = s ;
    UttNP np = {s = np.s ! Nom} ;
    UttAdv adv = adv ;
    UttCN n = {s = n.s ! Indef ! Nom ! Sg} ;
    UttAP ap = {s = ap.s ! Indef ! Masc ! Nom ! Sg} ;
    UttInterj i = i ;

    NoPConj = {s = []} ;

    NoVoc = {s = []} ;

}
