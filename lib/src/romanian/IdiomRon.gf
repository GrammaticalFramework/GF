concrete IdiomRon of Idiom = 
-- CatRon **   open (P = ParamX), MorphoRon, ParadigmsRon,Prelude 
CatRon ** open Prelude, ResRon,BeschRon
in {

  flags optimize=all_subs ;



  lin
    ImpersCl vp = mkClause "" (agrP3 Masc Sg) vp  ;
    
    GenericCl vp = mkClause "cineva" (agrP3 Masc Sg) vp ; -- an exact correspondent does not exist !

    ExistNP np = 
      mkClause "" np.a (insertSimpObj (\\ag => (np.s ! No ).comp) (useVerb (v_besch20 "existã"))) ;
-- v_besch20 "exista"
   
    ExistIP ip = {
      s = \\t,a,p,_ => 
        ip.s ! No ++ 
        (mkClause "" (agrP3 (ip.a.g) (ip.a.n))
              copula).s 
           ! DDir ! t ! a ! p ! Indic       } ;

    CleftNP np rs = mkClause ""  np.a 
      (insertSimpObj (\\_ => rs.s ! Indic ! np.a) 
        (insertSimpObj (\\_ => (np.s ! rs.c).comp) copula)) ;
--need adverb for 
    
    CleftAdv ad s = mkClause "" (agrP3 Masc Sg) 
      (insertSimpObj (\\_ => conjThat ++ s.s ! Indic) 
        (insertSimpObj (\\_ => ad.s) copula)) ;


    ProgrVP vp = vp; -- for the moment, since there is no particular way to express continuous action, except for the imperfect, which wouldn't work for all tenses

    ImpPl1 vp = let a = {p = P1 ; n = Pl ; g = Masc} in
      { s =  "sã"  ++ (flattenSimpleClitics vp.nrClit vp.clAcc vp.clDat (vp.isRefl ! a)) ++ conjVP vp a ++vp.comp ! a ++ vp.ext ! Pos };

}


