concrete VerbsEng of Verbs = {

lincat
  S, NP, Subcat, V = Str ; Args = Str * Str ;

lin
  cIntr = [] ;
  cTr   = [] ;
  cS    = [] ;

  aIntr su    = <su,[]> ;
  aTr   su ob = <su,ob> ;
  aS    su s  = <su,"that" ++ s> ;

  pred _ v xs = xs.p1 ++ v ++ xs.p2 ;

  john = "John" ; mary = "Mary" ;
  walk = "walks" ;
  love = "loves" ;
  know = "knows" ;

}
