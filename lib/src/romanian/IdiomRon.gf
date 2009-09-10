incomplete concrete IdiomRon of Idiom = 
-- CatRon **   open (P = ParamX), MorphoRon, ParadigmsRon,Prelude 
CatRon ** open Prelude, ResRon
in {

  flags optimize=all_subs ;



  lin
    ImpersCl vp = mkClause "" True (agrP3 Masc Sg) vp  ;
    GenericCl vp = mkClause "" True (agrP3 Masc Sg) vp ; -- an exact correspondent does not exist !

    ExistNP np = 
      mkClause "" True np.a (insertSimpObj (\\ag => (np.s ! No ).comp) (UseV copula)) ;
-- v_besch20 "exista"
   
 ExistIP ip = {
      s = \\t,a,p,_ => 
        ip.s ! No ++ 
        (mkClause "" True (agrP3 (ip.a.g) (ip.a.n))
              (UseV copula)).s 
           ! DDir ! t ! a ! p ! Indic       } ;

    CleftNP np rs = mkClause ""  True np.a 
      (insertSimpObj (\\_ => rs.s ! Indic ! np.a) 
        (insertSimpObj (\\_ => (np.s ! rs.c).comp) (predV copula))) ;
--need adverb for 
    CleftAdv ad s = mkClause "" True (agrP3 Masc Sg) 
      (insertSimpObj (\\_ => conjThat ++ s.s ! Indic) 
        (insertSimpObj (\\_ => ad.s) (predV copula))) ;


    ProgrVP vp = vp; -- for the moment, since there is no particular way to express continuous action, except for the imperfect, which wouldn't work for all tenses
{-
    ImpPl1 vpr = let vp = useVP vpr in {s =
      (mkImperative False P1 vp).s ! Pos ! {n = Pl ; g = Masc} --- fem
      } ;
-- insert clitics here also 
-}  

}


