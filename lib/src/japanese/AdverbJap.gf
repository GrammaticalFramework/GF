concrete AdverbJap of Adverb = CatJap ** open ResJap, ParadigmsJap, Prelude in {

flags coding = utf8 ;

  lin
  
    PositAdvAdj a = {s = \\st => a.adv ; prepositive = False ; compar = NoCompar} ;
  
    PrepNP prep np = {s = \\st => np.s ! st ++ prep.s ; 
                      prepositive = False ; compar = NoCompar} ;
    
    ComparAdvAdj cadv a np = {s = \\st => np.s ! st ++ cadv.s ++ a.adv ; 
                              prepositive = False ; compar = cadv.compar} ;
    
    ComparAdvAdjS cadv a s = {s = \\st => s.s ! Ga ! Plain ++ "こと" ++ cadv.s ++ a.adv ; 
                              prepositive = False ; compar = cadv.compar} ;
    
    AdAdv ada adv = {s = \\st => ada.s ++ adv.s ! st ; 
                     prepositive = adv.prepositive ; compar = NoCompar} ;
    
    PositAdAAdj a = {s = a.adv} ;
    
    SubjS subj s = {
      s = \\st => case subj.type of {
        If => s.ba ! (Wa | Ga) ! st ++ subj.s ;
        _ => s.s ! (Wa | Ga) ! st ++ subj.s
        } ; 
      prepositive = True ;
      compar = NoCompar
      } ;
    
    AdnCAdv cadv = {
      s = case cadv.compar of {
        More => "以上" ;  -- "ijou"
        Less => "以下" ;  -- "ika" ;
        NoCompar => "もの"
        } ;
      postposition = True
      } ;
}
