--# -path=.:present

concrete QueryEng of Query = open
  ParadigmsEng,
  IrregEng,
  SyntaxEng,
  ExtraEng,
  (L = LangEng),
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
  [Individual] = [NP] ;

lin
  MQuery  q = q ; ---- mkText (mkPhr q) questMarkPunct ;
  MAnswer a = a ; ---- mkText (mkPhr a) fullStopPunct ;
 
  QSet s = 
    let 
     ss : NP = s 
        | mkNP (mkNP thePl_Det L.name_N) (mkAdv possess_Prep s)
        ---- s's names
    in 
      mkUtt (mkImp (mkVP give_V3 ss (mkNP i_Pron)))
    | mkUtt (mkQS (mkQCl (L.CompIP whatSg_IP) ss))
    | mkUtt (mkQS (mkQCl (L.CompIP (L.IdetIP (mkIDet which_IQuant))) ss))
    | mkUtt ss ;

  QWhere s = mkUtt (mkQS (mkQCl where_IAdv s)) ;
  QInfo  s = 
    let
      info : NP = mkNP (all_NP | (mkNP information_N)) (mkAdv about_Prep s) ;
    in
      mkUtt (mkImp (mkVP give_V3 info (mkNP i_Pron)))
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

  IName n = n ;

  ACalled is = mkVP also_AdV (mkVP (mkAP (mkA2 called_A []) (mkNP or_Conj is))) ;

  BaseIndividual = mkListNP ;
  ConsIndividual = mkListNP ;

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

-- lexical constructors
  mkName : Str -> NP = 
    \s -> mkNP (mkPN s) ;
  mkRelation : Str -> {cn : CN ; prep : Prep} = 
    \s -> {cn = mkCN (mkN s) ; prep = possess_Prep} ;

-- lexicon

lincat
  Country = {np : NP ; a : A} ;
  JobTitle = CN ;
lin
  NCountry c = c.np ;
  PCountry c = mkAP c.a ;

  Located i = 
      mkAP (mkA2 (mkA "located") in_Prep) i
    | mkAP (mkA2 (mkA "situated") in_Prep) i ;

  Employed i = 
      mkAP (mkA2 (mkA "employed") by8agent_Prep) i
    | mkAP (mkA2 (mkA "paid") by8agent_Prep) i
    | mkAP (mkA2 (mkA "active") at_Prep) i
    | mkAP (mkA2 (mkA "professionally active") at_Prep) i ;

  Work i = 
      mkVP (mkV2 (mkV "work") at_Prep) i
    | mkVP (mkV2 (mkV "collaborate") in_Prep) i ;

  HaveTitle t i = 
      mkVP (mkVP (mkAP (mkA2 (mkA "employed") as_Prep) (mkNP t))) (mkAdv at_Prep i)
    | mkVP (mkVP (mkV2 (mkV "work") as_Prep) (mkNP t)) (mkAdv at_Prep i) 
    | mkVP (mkVP have_V2 (mkNP the_Det (mkCN (mkN2 (mkN "title")) (mkNP t)))) (mkAdv at_Prep i) ;

  Organization = mkCN (mkN "organization") ;
  Place = mkCN (mkN "place") ;
  Person = 
      mkCN (mkN "person" "people")
    | mkCN (mkN "person") ;

  Location = mkRelation "location" ;
  Region = mkRelation "region" ;
  Subregion = mkRelation "subregion" ;
  RName = mkRelation "name" ;
  RNickname = mkRelation "nickname" ;

  USA = mkCountry "USA" "American" ;
  Bulgaria = mkCountry "Bulgaria" "Bulgarian" ;
  California = mkCountry "California" "Californian" ;
  OblastSofiya = mkName "Oblast Sofiya" ;

  CEO = mkCN (mkN "CEO") ;

  Microsoft = mkName "Microsoft" ;
  Google = mkName "Google" ;

  SergeyBrin = mkName "Sergey Brin" ;
  LarryPage = mkName "Larry Page" ;
  EricSchmidt = mkName "Eric Schmidt" ;
  MarissaMayer = mkName "Marissa Mayer" ;
  UdiManber = mkName "Udi Manber" ;

oper
  mkCountry : Str -> Str -> {np : NP ; a : A} = 
    \n,a -> {np = mkNP (mkPN n) ; a = mkA a} ;

}
