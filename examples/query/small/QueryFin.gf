--# -path=.:present

concrete QueryFin of Query = open
  ParadigmsFin,
  SyntaxFin,
  ExtraFin,
  (G = GrammarFin),
  SymbolicFin,
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
  MQuery  q = q ;
  MAnswer a = a ;

  QSet s = mkUtt (mkImp (mkV2 (mkV "luetella")) s) ;

  QWhere s = mkUtt (mkQS (ICompExistNP (mkIComp where_IAdv) s)) ;
  QInfo s = mkUtt (mkImp (mkVP (mkV2 (mkV "antaa")) 
              (mkNP all_Predet (mkNP thePl_Det (mkCN (mkN "tieto") (mkAdv about_Prep s)))))) ;

  QCalled i = mkUtt (mkQS (mkQCl what_IP (mkNP (GenNP i) (mkCN (mkA "toinen") (mkN "nimi" "nimiä"))))) ;

  AKind s k = mkUtt (mkCl s (mkNP aPl_Det k)) ; ---- a, fun of s
  AProp s p = mkUtt (mkCl s p) ;
  AAct s p = mkUtt (mkCl s p) ;

  SAll k = mkNP all_Predet (mkNP thePl_Det k) ; ---- | mkNP thePl_Det k ;
  SOne k = mkNP n1_Numeral k ;
  SIndef k = mkNP someSg_Det k ;
  SPlural k = mkNP aPl_Det k ;
  SOther k = mkNP aPl_Det (mkCN other_A k) ;
  SInd i = i ;
  SInds is = mkNP and_Conj is ;

  KRelSet r s = GenCN s r.cn ;

  KRelKind k r s = mkCN k (mkRS (mkRCl that_RP (mkVP (mkNP aPl_Det (GenCN s r.cn))))) ;

  KRelPair k r = G.ConjCN and_Conj (G.BaseCN k (GenCN these_NP r.cn)) ;
  KProp p k =
     mkCN p k ;
---   | mkCN k (mkRS (mkRCl that_RP (mkVP p))) ;
  KAct p k =
     mkCN k (mkRS (mkRCl that_RP p)) ;
  KRel r = r.cn ;

  IName n = n ;
  NLoc n = n ;
  NOrg n = n ;
  NPers n = n;

  ACalled is = mkVP also_AdV (mkVP (mkAP (mkA2 called_A (casePrep translative)) (mkNP or_Conj is))) ;

  BaseIndividual = mkListNP ;
  ConsIndividual = mkListNP ;

oper
-- structural words
  about_Prep = casePrep elative ;
  all_NP = mkNP (mkPN (mkN "kaikki" "kaiken" "kaikkia")) ; ---
  also_AdV = ss "myös" ;
  as_Prep = casePrep essive ;
  at_Prep = casePrep adessive ;
  called_A = mkA "kutsuttu" ;
  give_V3 = mkV3 (mkV "antaa") (casePrep allative) (casePrep nominative) ;
  information_N = mkN "tieto" ;
  other_A = mkA "muu" ;
  that_RP = which_RP ;

-- lexical constructors
  mkName : N -> Str -> NP =
    \n,s -> mkNP the_Det (mkCN n (symb s)) ;
  mkRelation : N -> {cn : CN ; prep : Prep} =
    \s -> {cn = mkCN s ; prep = possess_Prep} ;

-- lexicon

lincat
  JobTitle = CN ;
lin
  NCountry c = c.np ;
  PCountry c = mkAP c.a ;

  Located i = mkAP (mkA2 (mkA "sijaitseva") in_Prep) i ;

  Employed i = mkAP (mkA2 (mkA (mkN "työssä" (mkN "oleva"))) in_Prep) i ;

  Work i = mkVP (mkV2 (mkV "työskennellä") in_Prep) i ;

  HaveTitle t i = mkVP (mkVP (mkNP t)) (mkAdv in_Prep i) ;

  Organization = mkCN (mkN "organisaatio" "organisaatioita") ;
  Place = mkCN (mkN "paikka") ;
  Person = mkCN (mkN "henkilö" "henkilöitä") ;

  Location = mkRelation (mkN "sijainti") ;
  Region = mkRelation (mkN "alue") ;
  Subregion = mkRelation (mkN "alue") ;
  RName = mkRelation (mkN "nimi" "nimiä") ;
  RNickname = mkRelation (mkN "lempinimi" "lempinimiä") ;

-- JobTitles
  JobTitle1 = mkCN (mkN "'JobTitle1") ;
  JobTitle2 = mkCN (mkN "'JobTitle2") ;
  JobTitle3 = mkCN (mkN "'JobTitle3") ;
  JobTitle4 = mkCN (mkN "'JobTitle4") ;

-- Locations
  Location1 = mkName (mkN "paikka") "'Location1" ;
  Location2 = mkName (mkN "paikka") "'Location2" ;
  Location3 = mkName (mkN "paikka") "'Location3" ;
  Location4 = mkName (mkN "paikka") "'Location4" ;

-- Organizations
  Organization1 = mkName (mkN "organisaatio") "'Organization1" ;
  Organization2 = mkName (mkN "organisaatio") "'Organization2" ;
  Organization3 = mkName (mkN "organisaatio") "'Organization3" ;
  Organization4 = mkName (mkN "organisaatio") "'Organization4" ;

-- Persons
  Person1 = mkName (mkN "henkilö") "'Person1" ;
  Person2 = mkName (mkN "henkilö") "'Person2" ;
  Person3 = mkName (mkN "henkilö") "'Person3" ;
  Person4 = mkName (mkN "henkilö") "'Person4" ;


}
