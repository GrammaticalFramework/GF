--# -path=.:present

concrete DonkeyEng of Donkey = TypesSymb ** open TryEng, IrregEng, Prelude in {

lincat 
  S  = TryEng.S ; 
  CN = {s : TryEng.CN ; p : TryEng.Pron} ; -- since English CN has no gender
  NP = TryEng.NP ;
  VP = TryEng.VP ;
  AP = TryEng.AP ;
  V2 = TryEng.V2 ;
  V  = TryEng.V ;
  PN = TryEng.PN ; 

lin
  PredVP _ Q F = mkS (mkCl Q F) ;
  ComplV2 _ _ F y = mkVP F y ;
  UseV _ F = mkVP F ;
  UseAP _ F = mkVP F ;
  If A B = mkS (mkAdv if_Subj A) (lin S (ss B.s)) ;
  An A = mkNP a_Det A.s ;
  Every A = mkNP every_Det A.s ;
  The A r = mkNP the_Det A.s | mkNP (mkNP the_Det A.s) (lin Adv (parenss r)) ; -- variant showing referent: he ( john' )
  Pron A r = mkNP A.p | mkNP (mkNP A.p) (lin Adv (parenss r)) ;
  UsePN _ a = mkNP a ;
  ModCN A F = {s = mkCN F A.s ; p = A.p} ;

  Man = {s = mkCN (mkN "man" "men") ; p = he_Pron} ;
  Woman = {s = mkCN (mkN "woman" "women") ; p = she_Pron} ;
  Donkey = {s = mkCN (mkN "donkey") ; p = it_Pron} ;
  Own = mkV2 "own" ;
  Beat = mkV2 beat_V ;
  Love _ _ = mkV2 "love" ;
  Walk = mkV "walk" ;
  Talk = mkV "talk" ;
  Old _ = mkAP (mkA "old") ;
  Pregnant = mkAP (mkA "pregnant") ;
  John = mkPN "John" ;

-- for the lexicon in type theory

lin
  Man' = ss "man'" ;
  Woman' = ss "woman'" ;
  Donkey' = ss "donkey'" ;
  Own' = apply "own'" ;
  Beat' = apply "beat'" ;
  Love' _ _ = apply "love'" ;
  Walk' = apply "walk'" ;
  Talk' = apply "talk'" ;
  Old' _ = apply "old'" ; 
  Pregnant' = apply "pregnant'" ; 
  John' = ss "john'" ;

}