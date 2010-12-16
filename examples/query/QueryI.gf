incomplete concrete QueryI of Query = open
  Syntax,
  LexQuery,
  Lang,
  Prelude
in {

lincat
  Move = Utt ; ---- Text ;
  Query = Utt ;
  Answer = Cl ; -- Utt ;
  Set = NP ;
  Interrogative = IP ;
  Function = Fun ; -- = {cn : CN ; prep : Prep} ;
  Kind = CN ;
  Property = Prop ; -- = {ap : AP ; vp : VP} ;
  Relation = Rel ; -- = {ap : AP ; vp : VP ; prep : Prep} ;
  Individual = NP ;
  Name = NP ;
  Loc = NP ;
  Org = NP ;
  Pers = NP ;
  [Individual] = [NP] ;

lin
  MQuery  q = q ; ---- mkText (mkPhr q) questMarkPunct ;
  MAnswer a = mkUtt a ; ---- mkText (mkPhr a) fullStopPunct ;
 
  QSet s = 
    let 
     ss : NP = s 
        | mkNP (mkNP theSg_Det Lang.name_N) (mkAdv namePrep s)
        | mkNP (mkNP thePl_Det Lang.name_N) (mkAdv namePrep s)
----        | mkNP (GenNP s) sgNum Lang.name_N 
----        | mkNP (GenNP s) plNum Lang.name_N ;
    in 
      mkUtt (mkImp (giveMe ss))
    | mkUtt (mkQS (mkQCl (Lang.CompIP whatSg_IP) ss))
    | mkUtt (mkQS (mkQCl (Lang.CompIP (Lang.IdetIP (mkIDet which_IQuant))) ss))
    | mkUtt ss ;

  QWhere s = 
      mkUtt (mkQS (mkQCl where_IAdv s))
    | mkUtt (mkQS (mkQCl where_IAdv (mkCl s located_A))) ;
  QWhat i p = mkUtt (mkQS (mkQCl i p.vp)) ;
  QRelWhere s p = mkUtt (mkQS (mkQCl where_IAdv (mkCl s p.vp))) ;

  QFun r s = 
      mkUtt 
        (mkImp (giveMe (mkNP and_Conj s (detSet s r.cn))))
    | mkUtt (mkQS (mkQCl (mkIP what_IQuant plNum r.cn) s have_V2))
    | mkUtt (mkQS (mkQCl whatSg_IP 
        (mkClSlash (mkClSlash s have_V2) (mkAdv LexQuery.as_Prep (mkNP aPl_Det r.cn))))) ; 

  QFunPair s f = 
    let 
     ss0 : NP = s 
              | mkNP (mkNP thePl_Det Lang.name_N) (mkAdv namePrep s) ;
     ss  : NP = mkNP and_Conj ss0 (mkNP (mkQuant they_Pron) plNum f.cn)
              | mkNP ss0 (mkAdv with_Prep (mkNP (mkQuant they_Pron) plNum f.cn))
    in 
      mkUtt (mkImp (giveMe ss))
    | mkUtt (mkQS (mkQCl (Lang.CompIP whatPl_IP) ss))
    | mkUtt (mkQS (mkQCl (Lang.CompIP (Lang.IdetIP (mkIDet which_IQuant))) ss))
    | mkUtt ss ;

  QInfo  s = 
    let
      info : NP = mkNP (all_NP | (mkNP information_N)) (mkAdv about_Prep s) ;
    in
      mkUtt (mkImp (giveMe info))
    | mkUtt (mkQCl whatSg_IP 
        (mkClSlash (mkClSlash (mkNP youSg_Pron) LexQuery.know_V2) (mkAdv about_Prep s)))
    | mkUtt info ;

  QCalled i = mkUtt (mkQS (mkQCl how_IAdv (mkCl i 
    (mkVP (also_AdV | otherwise_AdV) (mkVP called_A))))) ;

  QWhether a = mkUtt (mkQS a) ;

  AInd s i = (mkCl s i) ;
  AName s n = (mkCl n (mkNP the_Det (mkCN Lang.name_N (mkAdv namePrep s)))) ;
  AProp s p = (mkCl s p.vp) ;

  SAll k = mkNP all_Predet (mkNP aPl_Det k) | mkNP thePl_Det k ;
  SOne k = mkNP n1_Numeral k ;
  SIndef k = mkNP a_Det k ;
  SDef k = mkNP the_Det k ;
  SPlural k = mkNP aPl_Det k ;
  SOther k = mkNP aPl_Det (mkCN other_A k) ;
  SInd i = i ;
  SInds is = mkNP and_Conj is ;

  IWhich k = 
      mkIP what_IQuant  (sgNum | plNum) k
    | mkIP which_IQuant (sgNum | plNum) k ;

  IWho = whoSg_IP | whoPl_IP ;
  IWhat = whatSg_IP | whatPl_IP ;

  KFunSet r s = 
     mkCN r.cn (mkAdv r.prep s) ;

  KFunKind k r s = 
     mkCN k (mkRS (mkRCl which_RP (mkVP (mkNP aPl_Det (mkCN r.cn (mkAdv r.prep s))))))
   | mkCN k (mkRS (mkRCl that_RP (mkVP (mkNP aPl_Det (mkCN r.cn (mkAdv r.prep s)))))) 
   ;
  
  KFunPair k r = mkCN k (mkAdv with_Prep (mkNP (mkQuant they_Pron) plNum r.cn)) ;
  KProp p k = 
      participlePropCN p k
    | mkCN k (mkRS (mkRCl which_RP p.vp)) 
    | mkCN k (mkRS (mkRCl that_RP p.vp)) 
     ;
  KFun r = r.cn ;

  IName n = n ;

  PCalled  i  = propCalled i ;
  PCalleds is = propCalled (mkNP or_Conj is) ;

  BaseIndividual = mkListNP ;
  ConsIndividual = mkListNP ;

-- these need new things in resource
lin
  KFunsSet r q s = 
     mkCN (ConjCN and_Conj (BaseCN r.cn q.cn)) (mkAdv r.prep s) ;
  SFun s r = mkNP (GenNP s) plNum r.cn | mkNP (GenNP s) sgNum r.cn ;
  QWhatWhat i j p = mkUtt (mkQS (QuestQVP i (AdvQVP p.vp (mkIAdv p.prep j)))) ;
  QWhatWhere i p = mkUtt (mkQS (QuestQVP i (AdvQVP p.vp where_IAdv))) ;
  PIs i = propVP (mkVP i) ;
  AKind s k = (mkCl s (Lang.UseComp (Lang.CompCN k))) ;

  PRelation r s = {
    ap = AdvAP r.ap (mkAdv r.prep s) ; 
    vp = mkVP r.vp (mkAdv r.prep s)
    } ;

oper
  namePrep : Prep = possess_Prep ;

  relVP : VP -> Prep -> Rel = \vp,p -> {
    ap = vpAP vp ;
    vp = vp ;
    prep = p
    } ;

  propVP : VP -> Prop = \vp -> {
    ap = vpAP vp ;
    vp = vp
    } ;

  propAP : AP -> Prop = \ap -> {
    ap = ap ;
    vp = mkVP ap
    } ;

  relAP : AP -> Prep -> Rel = \ap,p -> {
    ap = ap ;
    vp = mkVP ap ;
    prep = p
    } ;

  propCalled : NP -> Prop = \i -> 
    propAP (mkAP (also_AdA | otherwise_AdA) (mkAP (mkA2 called_A (mkPrep [])) i)) ;

  detSet : NP -> CN -> NP = \s,c -> 
    mkNP (mkQuant they_Pron) plNum c ;


-- lexicon

lincat
  Country = {np : NP ; a : A} ;
  JobTitle = CN ;
lin
  NCountry c = c.np ;
  PCountry c = propAP (mkAP c.a) ;

  NLoc n = n ;
  NOrg n = n ;
  NPers n = n;
}

