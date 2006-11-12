--# -path=.:abstract:common:prelude

concrete ExtraFin of ExtraFinAbs = CatFin ** open ResFin, MorphoFin, Coordination, Prelude, StructuralFin in {

  lin
    GenNP np = {
      s1 = \\_,_ => np.s ! NPCase Gen ;
      s2 = [] ;
      isNum  = False ;
      isPoss = False ;
      isDef  = True  --- "Jussin kolme autoa ovat" ; thus "...on" is missing
      } ;


  lincat
    VPI   = {s : Str} ;
    [VPI] = {s1,s2 : Str} ;
  lin
    BaseVPI = twoSS ;
    ConsVPI = consrSS comma ;

    MkVPI vp = {s = infVP (NPCase Nom) Pos (agrP3 Sg) vp} ;
    ConjVPI = conjunctSS ;
    ComplVPIVV vv vpi = 
      insertObj (\\_,_,_ => vpi.s) (predV vv) ;

    AdvExistNP adv np = 
      mkClause (\_ -> adv.s) np.a (insertObj 
        (\\_,b,_ => np.s ! NPCase Nom) (predV (verbOlla ** {sc = NPCase Nom}))) ;

    AdvPredNP  adv v np =
      mkClause (\_ -> adv.s) np.a (insertObj 
        (\\_,b,_ => np.s ! NPCase Nom) (predV v)) ;

    i_implicPron = mkPronoun [] "minun" "minua" "minuna" "minuun" Sg P1 ;
    whatPart_IP = {
      s = table {
        NPCase Nom | NPAcc => "mitä" ;
        c => whatSg_IP.s ! c
        } ;
      n = Sg
    } ;


} 
