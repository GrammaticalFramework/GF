--# -path=.:present

concrete DonkeyEng of Donkey = TypesSymb ** open TryEng, IrregEng, (E = ExtraEng), Prelude in {

lincat 
  S  = TryEng.S ; 
  Cl = TryEng.Cl ;
  Det = TryEng.Det ;
  Conj = TryEng.Conj ;
  CN = {s : TryEng.CN ; p : TryEng.Pron} ; -- since English CN has no gender
  NP = TryEng.NP ;
  VP = TryEng.VP ;
  AP = TryEng.AP ;
  V2 = TryEng.V2 ;
  V  = TryEng.V ;
  PN = TryEng.PN ; 
  RC = TryEng.RS ;

lin
  IfS A B = mkS (mkAdv if_Subj A) (lin S (ss B.s)) ;
  ConjS C A B = mkS C A B ;
  PosCl A = mkS A ;
  NegCl A = mkS negativePol A ;
  PredVP _ Q F = mkCl Q F ;
  ComplV2 _ _ F y = mkVP F y ;
  UseV _ F = mkVP F ;
  UseAP _ F = mkVP F ;
  An = mkDet a_Quant ;
  Every = every_Det ;
  DetCN D A = mkNP D A.s ;
  The A r = mkNP the_Det A.s | mkNP (mkNP the_Det A.s) (lin Adv (parenss r)) ; -- variant showing referent: he ( john' )
  Pron A r = mkNP A.p | mkNP (mkNP A.p) (lin Adv (parenss r)) ;
  UsePN _ a = mkNP a ;
  ConjNP C _ Q R = mkNP C Q R ;
  ModAP A F = {s = mkCN F A.s ; p = A.p} ;
  ModRC A F = {s = mkCN A.s F ; p = A.p} ;
  RelVP A F = mkRS (mkRCl (relPron A) F) ;
  And = and_Conj ;
  Or = or_Conj ;

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

oper
  relPron : {s : CN ; p : Pron} -> RP = \cn -> case isHuman cn.p of { 
---    True  => who_RP ;
---    False => which_RP
    _ => E.that_RP
    } ;
  isHuman : Pron -> Bool = \p -> case p.a of {
---    AgP3Sg Neutr => False ;
    _ => True
    } ;  


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