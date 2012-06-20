--# -path=.:..:alltenses

incomplete concrete QueryI of Query = open
  Syntax,
  Lang,
  Prelude
in {



lincat
  Move = Utt ; ---- Text ;
  Query = Utt ;
  Answer = Utt ;
  Set = NP ;
  Relation = {cn : CN ; prep : Prep} ;
  Kind = CN ;
  Property = AP ; ---- {vp : VP ; typ : PropTyp} ;
  Individual = NP ;
  Activity = VP ;
  Name = NP ;
  Loc = NP ;
  Org = NP ;
  Pers = NP ;
  [Individual] = [NP] ;


lin
  MQuery  q = q ; ---- mkText (mkPhr q) questMarkPunct ;
  MAnswer a = a ; ---- mkText (mkPhr a) fullStopPunct ;

  QSet s =
    let
     ss : NP = s
        | mkNP (mkNP thePl_Det name_N) (mkAdv possess_Prep s)
        ---- s's names
    in
      mkUtt (mkImp (mkVP give_V3 (mkNP i_Pron) ss))
    | mkUtt (mkQS (mkQCl (L.CompIP whatSg_IP) ss))
    | mkUtt (mkQS (mkQCl (L.CompIP (L.IdetIP (mkIDet which_IQuant))) ss))
    | mkUtt ss ;

  QWhere s = mkUtt (mkQS (mkQCl where_IAdv s)) ;
  QInfo  s =
    let
      info : NP = mkNP all_Predet (mkNP (mkNP information_N) (mkAdv about_Prep s)) ;
    in
      mkUtt (mkImp (mkVP give_V3 (mkNP i_Pron) info))
    | mkUtt info ;

  QCalled i = mkUtt (mkQS (mkQCl how_IAdv (mkCl i (mkVP also_AdV (mkVP called_A))))) ;

  AKind s k = mkUtt (mkCl s (mkNP aPl_Det k)) ; ---- a, fun of s
  AProp s p = mkUtt (mkCl s p) ;
  AAct s p = mkUtt (mkCl s p) ;

  SAll k = mkNP all_Predet (mkNP aPl_Det k) | mkNP thePl_Det k ;
  SOne k = mkNP n1_Numeral k ;
  SIndef k = mkNP a_Det k ;
  SPlural k = mkNP aPl_Det k ;
  SOther k = mkNP aPl_Det (mkCN other_A k) ;
  SInd i = i ;
  SInds is = mkNP and_Conj is ;

  KRelSet r s =
     mkCN r.cn (mkAdv r.prep s) ;
     ---- | S's R

----  KRelsSet r q s =
----     mkCN r.cn (mkAdv r.prep s) ;

  KRelKind k r s =
    mkCN k (mkRS (mkRCl that_RP (mkVP (mkNP aPl_Det (mkCN r.cn (mkAdv r.prep s)))))) ;

  KRelPair k r = mkCN k (mkAdv with_Prep (mkNP (mkQuant they_Pron) plNum r.cn)) ;
  KProp p k =
     mkCN p k
   | mkCN k (mkRS (mkRCl that_RP (mkVP p))) ;
  KAct p k =
     mkCN k (mkRS (mkRCl that_RP p)) ;
  KRel r = r.cn ;

oper
-- structural words
  about_Prep = mkPrep "about" ;
  all_NP = mkNP (mkPN "all") ; ---
  also_AdV = mkAdV "also" | mkAdV "otherwise" ;
  as_Prep = mkPrep "as" ;
  at_Prep = mkPrep "at" ;
  called_A = mkA "called" | mkA "named" ;
  give_V3 = mkV3 give_V ;
  information_N = mkN "information" ;
  other_A = mkA "other" ;
  name_N = mkN "name" ;

-- lexical constructors
  mkName : Str -> NP =
    \s -> mkNP (mkPN s) ;

oper  
 mkRelation : Str -> {cn : CN ; prep : Prep} =
    \s -> {cn = mkCN (mkN s) ; prep = possess_Prep} ;

}
