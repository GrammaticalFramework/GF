--# -path=.:present

concrete DonkeyEng of Donkey = TypesSymb ** open TryEng, IrregEng, Prelude in {

lincat 
  S  = TryEng.S ; 
  CN = {s : TryEng.CN ; p : TryEng.Pron} ; -- since English CN has no gender
  NP = TryEng.NP ;
  VP = TryEng.VP ;
  V2 = TryEng.V2 ;
  V  = TryEng.V ;

lin
  PredVP _ Q F = mkS (mkCl Q F) ;
  ComplV2 _ _ F y = mkVP F y ;
  UseV _ F = mkVP F ;
  If A B = mkS (mkAdv if_Subj A) (lin S (ss B.s)) ;
  An A = mkNP a_Det A.s ;
  The A _ = mkNP the_Det A.s ;
  Pron A _ = mkNP A.p ;

  Man = {s = mkCN (mkN "man" "men") ; p = he_Pron} ;
  Donkey = {s = mkCN (mkN "donkey") ; p = it_Pron} ;
  Own = mkV2 "own" ;
  Beat = mkV2 beat_V ;
  Walk = mkV "walk" ;
  Talk = mkV "talk" ;

-- for the lexicon in type theory

lin
  Man' = ss "man'" ;
  Donkey' = ss "donkey'" ;
  Own' = apply "own'" ;
  Beat' = apply "beat'" ;
  Walk' = apply "walk'" ;
  Talk' = apply "talk'" ;

}