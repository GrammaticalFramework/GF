concrete AdverbJpn of Adverb = CatJpn ** open ResJpn, ParadigmsJpn, Prelude in {

flags coding = utf8 ;

  lin
  
    PositAdvAdj a = {s = \\st => a.adv ! Pos ; prepositive = False} ;
  
    PrepNP prep np = {s = \\st => np.s ! st ++ prep.s ; 
                      prepositive = False} ;
    
    ComparAdvAdj cadv a np = {
      s = \\st => case cadv.less of {
        True => np.s ! st ++ cadv.s ++ a.adv ! Neg ;
        False => np.s ! st ++ cadv.s ++ a.adv ! Pos 
        } ; 
      prepositive = False} ;
    
    ComparAdvAdjS cadv a s = {
      s = \\st => case cadv.less of {
        True => s.subj ! Ga ! st ++ s.pred ! Plain ++ "こと" ++ cadv.s ++ a.adv ! Neg ; 
        False => s.subj ! Ga ! st ++ s.pred ! Plain ++ "こと" ++ cadv.s ++ a.adv ! Pos
        } ;
      prepositive = False} ;
    
    AdAdv ada adv = {s = \\st => ada.s ++ adv.s ! st ; 
                     prepositive = adv.prepositive} ;
    
    PositAdAAdj a = {s = a.adv ! Pos } ;
    
    SubjS subj s = {
      s = \\st => case subj.type of {
      
        If => s.ba ! Wa ! st ++ subj.s ;
        _ => s.s ! Wa ! st ++ subj.s
        } ; 
      prepositive = True
      } ;
    
    AdnCAdv cadv = {s = cadv.s_adn ; postposition = True} ;
}
