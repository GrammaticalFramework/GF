concrete IdiomFre of Idiom = CatFre ** 
  open (P = ParamX), PhonoFre, MorphoFre, ParadigmsFre, Prelude in {

  flags optimize=all_subs ;

  lin
    ImpersCl vp = mkClause "il" True False (agrP3 Masc Sg) vp ;
    GenericCl vp = mkClause "on" True False (agrP3 Masc Sg) vp ;

    ExistNP np = 
      mkClause "il" True False (agrP3 Masc Sg)
        (insertClit3 "y" (insertComplement (\\_ => (np.s ! Acc).ton) (predV avoir_V))) ;

    ExistIP ip = {
      s = \\t,a,p,_ => 
        ip.s ! Nom ++ 
        (mkClause "il" True False (agrP3 Masc Sg)
              (insertClit3 "y" (predV avoir_V))).s 
           ! DDir ! t ! a ! p ! Indic ---- DInv
      } ;

    CleftNP np rs = mkClause elisCe True np.isPol (agrP3 Masc Sg) 
      (insertComplement (\\_ => rs.s ! Indic ! np.a)
        (insertComplement (\\_ => (np.s ! rs.c).ton) (predV copula))) ;

    CleftAdv ad s = mkClause elisCe True False (agrP3 Masc Sg) 
      (insertComplement (\\_ => conjThat ++ s.s ! Indic)
        (insertComplement (\\_ => ad.s) (predV copula))) ;


    ProgrVP vp = 
      insertComplement 
        (\\a => "en" ++ "train" ++ elisDe ++ infVP vp a) 
        (predV copula) ;

    ImpPl1 vp = {
      s = mkImperative False P1 vp ! RPos ! Masc ! Pl  --- fem
      } ;

    ImpP3 np vp = {
      s = (mkClause (np.s ! Nom).comp np.hasClit False np.a vp).s 
             ! DInv ! RPres ! Simul ! RPos ! Conjunct
      } ;


    SelfAdvVP vp = insertComplement memePron vp ;
    SelfAdVVP vp = insertComplement memePron vp ; ---- should be AdV
    SelfNP np = heavyNP {
      s = \\c => (np.s ! c).ton ++ memePron ! np.a ; ---- moi moi-même ? 
      a = np.a
      } ;

  oper
    elisCe = elision "c" ;

    memePron : Agr => Str = table {
      {n = Sg ; p = P1} => "moi-même" ;
      {n = Sg ; p = P2} => "toi-même" ;
      {g = Masc ; n = Sg ; p = P3} => "lui-même" ;
      {g = Fem  ; n = Sg ; p = P3} => "elle-même" ;
      {n = Pl ; p = P1} => "nous-mêmes" ;
      {n = Pl ; p = P2} => "vous-mêmes" ;
      {g = Masc ; n = Pl ; p = P3} => "eux-mêmes" ;
      {g = Fem  ; n = Pl ; p = P3} => "elles-mêmes"
      } ;


}


