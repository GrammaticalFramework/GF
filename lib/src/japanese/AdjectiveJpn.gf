concrete AdjectiveJpn of Adjective = CatJpn ** open ResJpn, ParadigmsJpn, Prelude in {

flags coding = utf8 ;

  lin

    PositA adj = {
      pred = adj.pred ;
      attr = \\st => adj.attr ;
      te = \\st => adj.te ;
      ba = \\st => adj.ba ;
      adv = \\st => adj.adv ! Pos ;
      prepositive = \\st => [] ;
      dropNaEnging = \\st => adj.dropNaEnging ;
      needSubject = True
      } ;
    
    ComparA adj np = {
      pred = \\st,t,p => np.s ! st ++ "より" ++ adj.pred ! st ! t ! p ;
      attr = \\st => np.s ! st ++ "より" ++ adj.attr ;
      te = \\st,p => np.s ! st ++ "より" ++ adj.te ! p ;
      ba = \\st,p => np.s ! st ++ "より" ++ adj.ba ! p ;
      adv = \\st => np.s ! st ++ "より" ++ adj.adv ! Pos ; 
      prepositive = np.prepositive ; 
      dropNaEnging = \\st => np.s ! st ++ "より" ++ adj.dropNaEnging ;
      needSubject = True
      } ;
    
    ComplA2 a2 np = {
      pred = \\st,t,p => np.s ! st ++ a2.prep ++ a2.pred ! st ! t ! p ;
      attr = \\st => np.s ! st ++ a2.prep ++ a2.attr ;
      te = \\st,p => np.s ! st ++ a2.prep ++ a2.te ! p ;
      ba = \\st,p => np.s ! st ++ a2.prep ++ a2.ba ! p ;
      prepositive = np.prepositive ;
      adv = \\st => np.s ! st ++ a2.prep ++ a2.adv ! Pos ; 
      dropNaEnging = \\st => np.s ! st ++ a2.prep ++ a2.dropNaEnging ;
      needSubject = True
      } ;
    
    ReflA2 a2 = {
      pred = \\st,t,p => "自分" ++ a2.prep ++ a2.pred ! st ! t ! p ;  -- "jibun"
      attr = \\st => "自分" ++ a2.prep ++ a2.attr ;
      te = \\st,p => "自分" ++ a2.prep ++ a2.te ! p ;
      ba = \\st,p => "自分" ++ a2.prep ++ a2.ba ! p ;
      adv = \\st => "自分" ++ a2.prep ++ a2.adv ! Pos ; 
      prepositive = \\st => [] ;
      dropNaEnging = \\st => "自分" ++ a2.prep ++ a2.dropNaEnging ;
      needSubject = True
      } ;
    
    UseA2 a2 = {
      pred = a2.pred ;
      attr = \\st => a2.attr ;
      te = \\st => a2.te ;
      ba = \\st => a2.ba ;
      adv = \\st => a2.adv ! Pos ; 
      prepositive = \\st => [] ;
      dropNaEnging = \\st => a2.dropNaEnging ;
      needSubject = True
      } ;
    
    UseComparA adj = {
      pred = \\st,t,p => "もっと" ++ adj.pred ! st ! t ! p ;
      attr = \\st => "もっと" ++ adj.attr ;
      te = \\st,p => "もっと" ++ adj.te ! p ;
      ba = \\st,p => "もっと" ++ adj.ba ! p ;
      adv = \\st => "もっと" ++ adj.adv ! Pos ;
      prepositive = \\st => [] ;
      dropNaEnging = \\st => "もっと" ++ adj.dropNaEnging ;
      needSubject = True
      } ;
    
    CAdvAP cadv ap np = {
      pred = \\st,t => case cadv.less of {
        True => table {
          Pos => np.s ! st ++ cadv.s ++ ap.pred ! st ! t ! Neg ;
          Neg => np.s ! st ++ cadv.s ++ ap.pred ! st ! t ! Pos
          } ;
        False => \\p => np.s ! st ++ cadv.s ++ ap.pred ! st ! t ! p
        } ;
      attr = \\st => case cadv.less of {
        True => np.s ! st ++ cadv.s ++ ap.pred ! Plain ! TPres ! Neg ;
        False => np.s ! st ++ cadv.s ++ ap.attr ! st 
        } ;
      te = \\st => case cadv.less of {
        True => table {
          Pos => np.s ! st ++ cadv.s ++ ap.te ! st ! Neg ;
          Neg => np.s ! st ++ cadv.s ++ ap.te ! st ! Pos
          } ;
        False => \\p => np.s ! st ++ cadv.s ++ ap.te ! st ! p
        } ;
      ba = \\st => case cadv.less of {
        True => table {
          Pos => np.s ! st ++ cadv.s ++ ap.ba ! st ! Neg ;
          Neg => np.s ! st ++ cadv.s ++ ap.ba ! st ! Pos
          } ;
        False => \\p => np.s ! st ++ cadv.s ++ ap.ba ! st ! p
        } ;
      adv = \\st => np.s ! st ++ cadv.s ++ ap.adv ! st ; 
      prepositive = np.prepositive ;
      dropNaEnging = \\st => case cadv.less of {
        True => np.s ! st ++ cadv.s ++ ap.pred ! Plain ! TPres ! Neg ;
        False => np.s ! st ++ cadv.s ++ ap.dropNaEnging ! st
        } ;
      needSubject = True
      } ;
    
    AdjOrd ord = {
      pred = ord.pred ;
      attr = \\st => ord.attr ;
      te = \\st => ord.te ;
      ba = \\st => ord.ba ;
      adv = \\st => ord.adv ! Pos ;
      prepositive = \\st => [] ;
      dropNaEnging = \\st => ord.dropNaEnging ;
      needSubject = True
      } ;

    SentAP ap sc = {
      pred = \\st,t,p => sc.s ! Wa ! st ++ "ことが" ++ ap.pred ! st ! t ! p ;
      attr = \\st => sc.s ! Wa ! st ++ "ことが" ++ ap.attr ! st ;
      te = \\st,p => sc.s ! Wa ! st ++ "ことが" ++ ap.te ! st ! p ;
      ba = \\st,p => sc.s ! Wa ! st ++ "ことが" ++ ap.ba ! st ! p ;
      adv = \\st => sc.s ! Wa ! st ++ "ことが" ++ ap.adv ! st ;
      prepositive = ap.prepositive ;
      dropNaEnging = \\st => sc.s ! Wa ! st ++ "ことが" ++ ap.dropNaEnging ! st ;
      needSubject = False
      } ;
    
    AdAP ada ap = {
      pred = \\st,t,p => ada.s ++ ap.pred ! st ! t ! p ;
      attr = \\st => ada.s ++ ap.attr ! st ;
      te = \\st,p => ada.s ++ ap.te ! st ! p ;
      ba = \\st,p => ada.s ++ ap.ba ! st ! p ;
      adv = \\st => ada.s ++ ap.adv ! st ;
      prepositive = ap.prepositive ;
      dropNaEnging = \\st => ada.s ++ ap.dropNaEnging ! st ;
      needSubject = True
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
        False => \\p => adv.s ! st ++ ap.te ! st ! p 
        } ;
      ba = \\st => case adv.prepositive of {
        True => ap.ba ! st ;
        False => \\p => adv.s ! st ++ ap.ba ! st ! p 
        } ;
      adv = \\st => case adv.prepositive of {
        True => ap.adv ! st ;
        False => adv.s ! st ++ ap.adv ! st 
        } ;
      prepositive = \\st => case adv.prepositive of {
        True => adv.s ! st ;
        False => [] 
        } ;
      dropNaEnging = \\st => case adv.prepositive of {
        True => ap.dropNaEnging ! st ;
        False => adv.s ! st ++ ap.dropNaEnging ! st 
        } ;
      needSubject = True
      } ;
}
