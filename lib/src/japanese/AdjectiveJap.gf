concrete AdjectiveJap of Adjective = CatJap ** open ResJap, ParadigmsJap, Prelude in {

flags coding = utf8 ;

  lin

    PositA adj = {
      pred = adj.pred ;
      attr = \\st => adj.attr ;
      te = \\st => adj.te ;
      tara = \\st => adj.tara ;
      adv = \\st => adj.adv ;
      prepositive = \\st => [] ; 
      compar = NoCompar
      } ;
    
    ComparA adj np = {
      pred = \\st,t,p => np.s ! st ++ "より" ++ adj.pred ! st ! t ! p ;  
      attr = \\st => np.s ! st ++ "より" ++ adj.attr ;
      te = \\st => np.s ! st ++ "より" ++ adj.te ;
      tara = \\st => np.s ! st ++ "より" ++ adj.tara ;
      adv = \\st => np.s ! st ++ "より" ++ adj.adv ; 
      prepositive = np.prepositive ; 
      compar = More
      } ;
    
    ComplA2 a2 np = {
      pred = \\st,t,p => np.s ! st ++ a2.prep ++ a2.pred ! st ! t ! p ;
      attr = \\st => np.s ! st ++ a2.prep ++ a2.attr ;
      te = \\st => np.s ! st ++ a2.prep ++ a2.te ;
      tara = \\st => np.s ! st ++ a2.prep ++ a2.tara ;
      prepositive = np.prepositive ;
      adv = \\st => [] ; 
      compar = NoCompar
      } ;
    
    ReflA2 a2 = {
      pred = \\st,t,p => "自分" ++ a2.prep ++ a2.pred ! st ! t ! p ;  -- "jibun"
      attr = \\st => "自分" ++ a2.prep ++ a2.attr ;
      te = \\st => "自分" ++ a2.prep ++ a2.te ;
      tara = \\st => "自分" ++ a2.prep ++ a2.tara ;
      adv = \\st => [] ; 
      prepositive = \\st => [] ;
      compar = NoCompar
      } ;
    
    UseA2 a2 = {
      pred = a2.pred ;
      attr = \\st => a2.attr ;
      te = \\st => a2.te ;
      tara = \\st => a2.tara ;
      adv = \\st => [] ; 
      prepositive = \\st => [] ;
      compar = NoCompar
      } ;
    
    UseComparA adj = {
      pred = \\st,t,p => "もっと" ++ adj.pred ! st ! t ! p ;
      attr = \\st => "もっと" ++ adj.attr ;
      te = \\st => "もっと" ++ adj.te ;
      tara = \\st => "もっと" ++ adj.tara ;
      adv = \\st => "もっと" ++ adj.adv ;
      prepositive = \\st => [] ;
      compar = NoCompar   -- "motto" does not change the main NP's particle
      } ;
    
    CAdvAP cadv ap np = {
      pred = \\st,t,p => np.s ! st ++ cadv.s ++ ap.pred ! st ! t ! p ;
      attr = \\st => np.s ! st ++ cadv.s ++ ap.attr ! st ;
      te = \\st => np.s ! st ++ cadv.s ++ ap.te ! st ;
      tara = \\st => np.s ! st ++ cadv.s ++ ap.tara ! st ;
      adv = \\st => np.s ! st ++ cadv.s ++ ap.adv ! st ; 
      prepositive = np.prepositive ;
      compar = cadv.compar
      } ;
    
    AdjOrd ord = {
      pred = ord.pred ;
      attr = \\st => ord.attr ;
      te = \\st => ord.te ;
      tara = \\st => ord.tara ;
      adv = \\st => ord.adv ;
      prepositive = \\st => [] ;
      compar = NoCompar
      } ;

    SentAP ap sc = {
      pred = \\st,t,p => sc.s ! Ga ! st ++ "ことを" ++ ap.pred ! st ! t ! p ;
      attr = \\st => sc.s ! Ga ! st ++ "ことを" ++ ap.attr ! st ;
      te = \\st => sc.s ! Ga ! st ++ "ことを" ++ ap.te ! st ;
      tara = \\st => sc.s ! Ga ! st ++ "ことを" ++ ap.tara ! st ;
      adv = \\st => sc.s ! Ga ! st ++ "ことを" ++ ap.adv ! st ;
      prepositive = ap.prepositive ;
      compar = ap.compar
      } ;
    
    AdAP ada ap = {
      pred = \\st,t,p => ada.s ++ ap.pred ! st ! t ! p ;
      attr = \\st => ada.s ++ ap.attr ! st ;
      te = \\st => ada.s ++ ap.te ! st ;
      tara = \\st => ada.s ++ ap.tara ! st ;
      adv = \\st => ada.s ++ ap.adv ! st ;
      prepositive = ap.prepositive ;
      compar = ap.compar
      } ;
    
    AdvAP ap adv = {
      pred = \\st,t,p => case adv.prepositive of {
        True => ap.pred ! st ! t ! p ;
        False => adv.s ! st ++ ap.pred ! st ! t ! p 
        } ;
      attr = \\st => case adv.prepositive of {
        True => ap.attr ! st ;
        False => adv.s ! st ++ ap.attr ! st 
        } ;
      te = \\st => case adv.prepositive of {
        True => ap.te ! st ;
        False => adv.s ! st ++ ap.te ! st 
        } ;
      tara = \\st => case adv.prepositive of {
        True => ap.tara ! st ;
        False => adv.s ! st ++ ap.tara ! st 
        } ;
      adv = \\st => case adv.prepositive of {
        True => ap.adv ! st ;
        False => adv.s ! st ++ ap.adv ! st 
        } ;
      prepositive = \\st => case adv.prepositive of {
        True => adv.s ! st ;
        False => [] 
        } ;
      compar = ap.compar
      } ;
}
