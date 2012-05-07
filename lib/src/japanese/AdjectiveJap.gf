concrete AdjectiveJap of Adjective = CatJap ** open ResJap, ParadigmsJap, Prelude in {

flags coding = utf8 ;

  lin

    PositA adj = {
      pred = adj.pred ;
      attr = \\st => adj.attr ;
      te = \\st => adj.te ;
      ba = \\st => adj.ba ;
      adv = \\st => adj.adv ;
      prepositive = \\st => [] ; 
      compar = NoCompar ;
      dropNaEnging = \\st => adj.dropNaEnging
      } ;
    
    ComparA adj np = {
      pred = \\st,t,p => np.s ! st ++ "より" ++ adj.pred ! st ! t ! p ;  
      attr = \\st => np.s ! st ++ "より" ++ adj.attr ;
      te = \\st => np.s ! st ++ "より" ++ adj.te ;
      ba = \\st => np.s ! st ++ "より" ++ adj.ba ;
      adv = \\st => np.s ! st ++ "より" ++ adj.adv ; 
      prepositive = np.prepositive ; 
      compar = More ;
      dropNaEnging = \\st => np.s ! st ++ "より" ++ adj.dropNaEnging ;
      } ;
    
    ComplA2 a2 np = {
      pred = \\st,t,p => np.s ! st ++ a2.prep ++ a2.pred ! st ! t ! p ;
      attr = \\st => np.s ! st ++ a2.prep ++ a2.attr ;
      te = \\st => np.s ! st ++ a2.prep ++ a2.te ;
      ba = \\st => np.s ! st ++ a2.prep ++ a2.ba ;
      prepositive = np.prepositive ;
      adv = \\st => [] ; 
      compar = NoCompar ;
      dropNaEnging = \\st => np.s ! st ++ a2.prep ++ a2.dropNaEnging
      } ;
    
    ReflA2 a2 = {
      pred = \\st,t,p => "自分" ++ a2.prep ++ a2.pred ! st ! t ! p ;  -- "jibun"
      attr = \\st => "自分" ++ a2.prep ++ a2.attr ;
      te = \\st => "自分" ++ a2.prep ++ a2.te ;
      ba = \\st => "自分" ++ a2.prep ++ a2.ba ;
      adv = \\st => [] ; 
      prepositive = \\st => [] ;
      compar = NoCompar ;
      dropNaEnging = \\st => "自分" ++ a2.prep ++ a2.dropNaEnging
      } ;
    
    UseA2 a2 = {
      pred = a2.pred ;
      attr = \\st => a2.attr ;
      te = \\st => a2.te ;
      ba = \\st => a2.ba ;
      adv = \\st => [] ; 
      prepositive = \\st => [] ;
      compar = NoCompar ;
      dropNaEnging = \\st => a2.dropNaEnging
      } ;
    
    UseComparA adj = {
      pred = \\st,t,p => "もっと" ++ adj.pred ! st ! t ! p ;
      attr = \\st => "もっと" ++ adj.attr ;
      te = \\st => "もっと" ++ adj.te ;
      ba = \\st => "もっと" ++ adj.ba ;
      adv = \\st => "もっと" ++ adj.adv ;
      prepositive = \\st => [] ;
      compar = NoCompar ;  -- "motto" does not change the main NP's particle 
      dropNaEnging = \\st => "もっと" ++ adj.dropNaEnging
      } ;
    
    CAdvAP cadv ap np = {
      pred = \\st,t,p => np.s ! st ++ cadv.s ++ ap.pred ! st ! t ! p ;
      attr = \\st => np.s ! st ++ cadv.s ++ ap.attr ! st ;
      te = \\st => np.s ! st ++ cadv.s ++ ap.te ! st ;
      ba = \\st => np.s ! st ++ cadv.s ++ ap.ba ! st ;
      adv = \\st => np.s ! st ++ cadv.s ++ ap.adv ! st ; 
      prepositive = np.prepositive ;
      compar = cadv.compar ;
      dropNaEnging = \\st => np.s ! st ++ cadv.s ++ ap.dropNaEnging ! st
      } ;
    
    AdjOrd ord = {
      pred = ord.pred ;
      attr = \\st => ord.attr ;
      te = \\st => ord.te ;
      ba = \\st => ord.ba ;
      adv = \\st => ord.adv ;
      prepositive = \\st => [] ;
      compar = NoCompar ;
      dropNaEnging = \\st => ord.dropNaEnging
      } ;

    SentAP ap sc = {
      pred = \\st,t,p => sc.s ! Ga ! st ++ "ことを" ++ ap.pred ! st ! t ! p ;
      attr = \\st => sc.s ! Ga ! st ++ "ことを" ++ ap.attr ! st ;
      te = \\st => sc.s ! Ga ! st ++ "ことを" ++ ap.te ! st ;
      ba = \\st => sc.s ! Ga ! st ++ "ことを" ++ ap.ba ! st ;
      adv = \\st => sc.s ! Ga ! st ++ "ことを" ++ ap.adv ! st ;
      prepositive = ap.prepositive ;
      compar = ap.compar ;
      dropNaEnging = \\st => sc.s ! Ga ! st ++ "ことを" ++ ap.dropNaEnging ! st
      } ;
    
    AdAP ada ap = {
      pred = \\st,t,p => ada.s ++ ap.pred ! st ! t ! p ;
      attr = \\st => ada.s ++ ap.attr ! st ;
      te = \\st => ada.s ++ ap.te ! st ;
      ba = \\st => ada.s ++ ap.ba ! st ;
      adv = \\st => ada.s ++ ap.adv ! st ;
      prepositive = ap.prepositive ;
      compar = ap.compar ;
      dropNaEnging = \\st => ada.s ++ ap.dropNaEnging ! st
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
      ba = \\st => case adv.prepositive of {
        True => ap.ba ! st ;
        False => adv.s ! st ++ ap.ba ! st 
        } ;
      adv = \\st => case adv.prepositive of {
        True => ap.adv ! st ;
        False => adv.s ! st ++ ap.adv ! st 
        } ;
      prepositive = \\st => case adv.prepositive of {
        True => adv.s ! st ;
        False => [] 
        } ;
      compar = ap.compar ;
      dropNaEnging = \\st => case adv.prepositive of {
        True => ap.dropNaEnging ! st ;
        False => adv.s ! st ++ ap.dropNaEnging ! st 
        }
      } ;
}
