--# -path=.:alltenses

concrete QuerySwe of Query = open
  ParadigmsSwe,
  IrregSwe,
  SyntaxSwe,
  ExtraSwe,
  (M = MakeStructuralSwe),
  (L = LangSwe),
  Prelude
in {

flags coding = utf8 ;

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
        | mkNP (mkNP thePl_Det L.name_N) (mkAdv on_Prep s)
        ---- s's names
    in
      mkUtt (mkImp (mkVP give_V3 (mkNP i_Pron) ss))
    | mkUtt (mkQS (mkQCl (L.CompIP whatSg_IP) ss))
    | mkUtt (mkQS (mkQCl (L.CompIP (L.IdetIP (mkIDet which_IQuant))) ss))
    | mkUtt ss ;

  QWhere s = mkUtt (mkQS (mkQCl where_IAdv s)) ;
  QInfo  s =
    let
      info : NP = mkNP (all_NP | (mkNP information_N)) (mkAdv about_Prep s) ;
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

  KRelPair k r = mkCN k (mkAdv with_Prep (sina r.cn)) ;
  KProp p k =
     mkCN p k
   | mkCN k (mkRS (mkRCl that_RP (mkVP p))) ;
  KAct p k =
     mkCN k (mkRS (mkRCl that_RP p)) ;
  KRel r = r.cn ;

  IName n = n ;
  NLoc n = n ;
  NOrg n = n ;
  NPers n = n;

  ACalled is = mkVP also_AdV (mkVP (mkAP (mkA2 called_A for_Prep) (mkNP or_Conj is))) ;

  BaseIndividual = mkListNP ;
  ConsIndividual = mkListNP ;

oper
-- structural words
  about_Prep = mkPrep "om" ;
  all_NP = mkNP (mkPN "allt" neutrum) ; ---
  also_AdV = mkAdV "också" | mkAdV "annars" ;
  as_Prep = mkPrep "som" ;
  at_Prep = mkPrep "på" ;
  called_A = mkA "kallad" "kallat" "kallade" ;
  give_V3 = mkV3 giva_V ;
  information_N = mkN "information" "informationer" ;
  other_A = compoundA (mkA "annan" "annat" "andra" "andra" "andra") ;
  that_RP = which_RP ;

  sina : CN -> NP = \cn -> mkNP (M.mkPredet "sin" "sitt" "sina") (mkNP a_Quant plNum cn) ; ---- should be in ExtraSwe

-- lexical constructors
  mkName : Str -> NP =
    \s -> mkNP (mkPN s) ;
  mkRelation : N -> Prep -> {cn : CN ; prep : Prep} =
    \s,p -> {cn = mkCN s ; prep = p} ;

-- lexicon

lincat
  Country = {np : NP ; a : A} ;
  JobTitle = CN ;
lin
  NCountry c = c.np ;
  PCountry c = mkAP c.a ;

  Located i =
      mkAP (mkA2 (mkA "belägen" "beläget") in_Prep) i ;
--    | mkAP (mkA2 (mkA "situated") in_Prep) i ;

  Employed i =
      mkAP (mkA2 (mkA "anställd") by8agent_Prep) i
--    | mkAP (mkA2 (mkA "paid") by8agent_Prep) i
--    | mkAP (mkA2 (mkA "aktiv") at_Prep) i
    | mkAP (mkA2 (mkA "professionellt aktiv") at_Prep) i ;

  Work i =
      mkVP (mkV2 (mkV "jobba") at_Prep) i
    | mkVP (mkV2 (mkV "arbeta") in_Prep) i ;

  HaveTitle t i =
      mkVP (mkVP (mkAP (mkA2 (mkA "anställd") as_Prep) (mkNP t))) (mkAdv at_Prep i)
    | mkVP (mkVP (mkV2 (mkV "jobba") as_Prep) (mkNP t)) (mkAdv at_Prep i) ;
--    | mkVP (mkVP have_V2 (mkNP the_Det (mkCN (mkN2 (mkN "titel" "titlar") po) (mkNP t)))) (mkAdv at_Prep i) ;

  Organization = mkCN (mkN "organisation" "organisationer") ;
  Place = mkCN (mkN "plats" "platser") ;
  Person =
      mkCN (mkN "person" "personer") ;
--    | mkCN (mkN "person" "folk") ;

  Location = mkRelation (mkN "läge" "lägen") possess_Prep ;
  Region = mkRelation (mkN "region" "regioner") in_Prep ;
  Subregion = mkRelation (mkN "delregion" "delregioner") in_Prep ;
  RName = mkRelation (mkN "namn" "namn") on_Prep ;
  RNickname = mkRelation (mkN "tilläggsnamn" "tilläggsnamn")  on_Prep ;

-- JobTitles
  JobTitle1 = mkCN (mkN "'JobTitle1") ;
  JobTitle2 = mkCN (mkN "'JobTitle2") ;
  JobTitle3 = mkCN (mkN "'JobTitle3") ;
  JobTitle4 = mkCN (mkN "'JobTitle4") ;

-- Locations
  Location1 = mkName "'Location1" ;
  Location2 = mkName "'Location2" ;
  Location3 = mkName "'Location3" ;
  Location4 = mkName "'Location4" ;

-- Organizations
  Organization1 = mkName "'Organization1" ;
  Organization2 = mkName "'Organization2" ;
  Organization3 = mkName "'Organization3" ;
  Organization4 = mkName "'Organization4" ;

-- Persons
  Person1 = mkName "'Person1" ;
  Person2 = mkName "'Person2" ;
  Person3 = mkName "'Person3" ;
  Person4 = mkName "'Person4" ;

oper
  mkCountry : Str -> Str -> {np : NP ; a : A} =
    \n,a -> {np = mkNP (mkPN n neutrum) ; a = mkA a} ;

}
