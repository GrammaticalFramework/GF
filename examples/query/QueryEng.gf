--# -path=.:present

concrete QueryEng of Query = open
  ParadigmsEng,
  IrregEng,
  SyntaxEng,
  ExtraEng,
  (L = LangEng),
  (M = MakeStructuralEng),
  Prelude
in {

lincat
  Move = Utt ; ---- Text ;
  Query = Utt ;
  Answer = Cl ; -- Utt ;
  Set = NP ;
  Relation = {cn : CN ; prep : Prep} ;
  Kind = CN ;
  Property = {ap : AP ; vp : VP} ;
  Individual = NP ;
  Name = NP ;
  [Individual] = [NP] ;

lin
  MQuery  q = q ; ---- mkText (mkPhr q) questMarkPunct ;
  MAnswer a = mkUtt a ; ---- mkText (mkPhr a) fullStopPunct ;
 
  QSet s = 
    let 
     ss : NP = s 
        | mkNP (mkNP theSg_Det L.name_N) (mkAdv possess_Prep s)
        | mkNP (mkNP thePl_Det L.name_N) (mkAdv possess_Prep s)
        | mkNP (GenNP s) sgNum L.name_N 
        | mkNP (GenNP s) plNum L.name_N ;
    in 
      mkUtt (mkImp (mkVP give_V3 ss (mkNP i_Pron)))
    | mkUtt (mkQS (mkQCl (L.CompIP whatSg_IP) ss))
    | mkUtt (mkQS (mkQCl (L.CompIP (L.IdetIP (mkIDet which_IQuant))) ss))
    | mkUtt ss ;

  QWhat k p = 
    mkUtt (mkQS (mkQCl (mkIP (what_IQuant | which_IQuant) (sgNum | plNum) k) p.vp)) ;
  QWho p = mkUtt (mkQS (mkQCl whoSg_IP p.vp)) ;

  QWhere s = 
      mkUtt (mkQS (mkQCl where_IAdv s))
    | mkUtt (mkQS (mkQCl where_IAdv (mkCl s (mkA "located" | mkA "situated")))) ;
  QRel r s = 
      mkUtt 
        (mkImp (mkVP give_V3 (mkNP and_Conj s (mkNP (mkQuant they_Pron) plNum r.cn)) (mkNP i_Pron)))
    | mkUtt (mkQS (mkQCl (mkIP what_IQuant plNum r.cn) s have_V2))
    | mkUtt (mkQS (mkQCl whatSg_IP 
        (mkClSlash (mkClSlash s have_V2) (mkAdv as_Prep (mkNP aPl_Det r.cn))))) ; 
  QInfo  s = 
    let
      info : NP = mkNP (all_NP | (mkNP information_N)) (mkAdv about_Prep s) ;
    in
      mkUtt (mkImp (mkVP give_V3 info (mkNP i_Pron)))
    | mkUtt (mkQCl whatSg_IP 
        (mkClSlash (mkClSlash (mkNP youSg_Pron) (mkV2 know_V)) (mkAdv about_Prep s)))
    | mkUtt info ;

  QCalled i = mkUtt (mkQS (mkQCl how_IAdv (mkCl i 
    (mkVP (also_AdV | otherwise_AdV) (mkVP called_A))))) ;

  QWhether a = mkUtt (mkQS a) ;

  AKind s k = (mkCl s (L.UseComp (L.CompCN k))) ;
  AInd s i = (mkCl s i) ;
  AName s n = (mkCl n (mkNP the_Det (mkCN L.name_N (mkAdv possess_Prep s)))) ;
  AProp s p = (mkCl s p.vp) ;

  SAll k = mkNP all_Predet (mkNP aPl_Det k) | mkNP thePl_Det k ;
  SRel s r = mkNP (GenNP s) plNum r.cn | mkNP (GenNP s) sgNum r.cn ;
  SOne k = mkNP n1_Numeral k ;
  SIndef k = mkNP a_Det k ;
  SDef k = mkNP the_Det k ;
  SPlural k = mkNP aPl_Det k ;
  SOther k = mkNP aPl_Det (mkCN other_A k) ;
  SInd i = i ;
  SInds is = mkNP and_Conj is ;

  KRelSet r s = 
     mkCN r.cn (mkAdv r.prep s) ;

  KRelsSet r q s = 
     mkCN (ConjCN and_Conj (BaseCN r.cn q.cn)) (mkAdv r.prep s) ;

  KRelKind k r s = 
    mkCN k (mkRS (mkRCl that_RP (mkVP (mkNP aPl_Det (mkCN r.cn (mkAdv r.prep s)))))) ;
  
  KRelPair k r = mkCN k (mkAdv with_Prep (mkNP (mkQuant they_Pron) plNum r.cn)) ;
  KProp p k = 
     mkCN p.ap k 
   | mkCN k (mkRS (mkRCl that_RP p.vp)) ;
  KRel r = r.cn ;

  IName n = n ;

  PCalled  i  = propCalled i ;
  PCalleds is = propCalled (mkNP or_Conj is) ;

  PIs i = propVP (mkVP i) ;

  BaseIndividual = mkListNP ;
  ConsIndividual = mkListNP ;

oper
-- structural words
  about_Prep = mkPrep "about" ;
  all_NP = mkNP (mkPN "all") ; ---
  also_AdV = mkAdV "also" ;
  also_AdA = mkAdA "also" ;
  as_Prep = mkPrep "as" ;
  at_Prep = mkPrep "at" ;
  called_A = mkA "called" | mkA "named" ;
  give_V3 = mkV3 give_V ;
  information_N = mkN "information" ;
  other_A = mkA "other" ;
  otherwise_AdV = mkAdV "otherwise" ;
  otherwise_AdA = mkAdA "otherwise" ;
  what_IQuant = M.mkIQuant "what" "what" ;

-- lexical constructors
  mkName : Str -> NP = 
    \s -> mkNP (mkPN s) ;
  mkRelation : Str -> {cn : CN ; prep : Prep} = 
    \s -> {cn = mkCN (mkN s) ; prep = possess_Prep} ;

  propAP : AP -> {ap : AP ; vp : VP} = \ap -> {
    ap = ap ;
    vp = mkVP ap
    } ;

  propVP : VP -> {ap : AP ; vp : VP} = \vp -> {
    ap = PartVP vp ;
    vp = vp
    } ;

  propCalled : NP -> {ap : AP ; vp : VP} = \i -> 
    propAP (mkAP (also_AdA | otherwise_AdA) (mkAP (mkA2 called_A []) i)) ;


-- lexicon

lincat
  Country = {np : NP ; a : A} ;
  JobTitle = CN ;
lin
  NCountry c = c.np ;
  PCountry c = propAP (mkAP c.a) ;

  Located i = propAP (
      mkAP (mkA2 (mkA "located") in_Prep) i
    | mkAP (mkA2 (mkA "situated") in_Prep) i
    ) ;

  In i = propVP (mkVP (mkAdv in_Prep i)) ;

  Employed i = propAP ( 
      mkAP (mkA2 (mkA "employed") by8agent_Prep) i
    | mkAP (mkA2 (mkA "paid") by8agent_Prep) i
    | mkAP (mkA2 (mkA "active") at_Prep) i
    | mkAP (mkA2 (mkA "professionally active") at_Prep) i
    )
   |
    propVP (
      mkVP (mkV2 (mkV "work") at_Prep) i
    | mkVP (mkV2 (mkV "collaborate") in_Prep) i
    ) ;

  HaveTitle t = 
    propAP (
      mkAP (mkA2 (mkA "employed") as_Prep) (mkNP t)
      )
    |
    propVP (
      mkVP (mkNP a_Det t)
    | mkVP (mkV2 (mkV "work") as_Prep) (mkNP t) 
--    | mkVP have_V2 (mkNP the_Det (mkCN (mkN2 (mkN "title")) (mkNP t))) 
    ) ;

  HaveTitleAt t i = 
    propAP (
      mkAP (mkA2 (mkA "employed") as_Prep) (mkNP (mkNP t) (mkAdv at_Prep i))
      )
    |
    propVP (
      mkVP (mkVP (mkNP a_Det t)) (mkAdv at_Prep i) 
    | mkVP (mkVP (mkV2 (mkV "work") as_Prep) (mkNP t)) (mkAdv at_Prep i) 
--    | mkVP (mkVP have_V2 (mkNP the_Det (mkCN (mkN2 (mkN "title")) (mkNP t)))) 
--           (mkAdv at_Prep i)
    ) ;

  Named n = propAP  (mkAP (mkA2 (mkA "named") []) n) ;
  Start n = propVP (mkVP (mkV2 "start" with_Prep) n) ;

  Organization = mkCN (mkN "organization") ;
  Place = mkCN (mkN "place") ;
  Person = 
      mkCN (mkN "person" "people")
    | mkCN (mkN "person") ;

  Location = mkRelation "location" ;
  Region = mkRelation "region" ;
  Subregion = mkRelation "subregion" | mkRelation "sub-region" ;
  RName = mkRelation "name" ;
  RNickname = mkRelation "nickname" ;
  RJobTitle = mkRelation "job title" | mkRelation "job" | mkRelation "position" |
    mkRelation "appointment" | mkRelation "job position" | mkRelation "mandate" |
    mkRelation "title" ;

  USA = mkCountry "USA" "American" ;
  Bulgaria = mkCountry "Bulgaria" "Bulgarian" ;
  California = mkCountry "California" "Californian" ;
  OblastSofiya = mkName "Oblast Sofiya" ;

  CEO = mkCN (mkN "CEO") ;
  ChiefInformationOfficer = mkCN (mkN "Chief Information Officer") ;

  Microsoft = mkName "Microsoft" ;
  Google = mkName "Google" ;

  SergeyBrin = mkName "Sergey Brin" ;
  LarryPage = mkName "Larry Page" ;
  EricSchmidt = mkName "Eric Schmidt" ;
  MarissaMayer = mkName "Marissa Mayer" ;
  UdiManber = mkName "Udi Manber" ;
  CarlGustavJung = mkName "Carl Gustav Jung" ;
  Jung = mkName "Jung" ;
  BenFried = mkName "Ben Fried" ;

oper
  mkCountry : Str -> Str -> {np : NP ; a : A} = 
    \n,a -> {np = mkNP (mkPN n) ; a = mkA a} ;

}
