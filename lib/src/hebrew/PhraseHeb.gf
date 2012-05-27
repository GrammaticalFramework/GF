concrete PhraseHeb of Phrase = CatHeb ** open Prelude, ResHeb in { 

  flags coding=utf8 ;

 lin

  PhrUtt pconj utt voc = {s =  pconj.s ++ utt.s ++ voc.s} ;
  UttAdv adv = {s = adv.s} ;
  UttNP np = {s = (np.s ! Nom).obj } ;

  NoPConj = {s = []} ;
  NoVoc = {s = []} ;
 
}
