--# -path=.:../scandinavian:../abstract:../../prelude

--1 The Top-Level Swedish Resource Grammar: Structural Words
--
-- Aarne Ranta 2002 -- 2004
--
concrete StructuralDan of Structural = 
  CategoriesDan, NumeralsDan ** open Prelude, MorphoDan, SyntaxDan in {
 lin

  INP    = pronNounPhrase jag_32 ;
  ThouNP = pronNounPhrase du_33 ;
  HeNP   = pronNounPhrase han_34 ;
  SheNP  = pronNounPhrase hon_35 ;
  WeNumNP n = pronNounPhrase (pronWithNum vi_36 n) ;
  YeNumNP n = pronNounPhrase (pronWithNum ni_37 n) ;
  TheyNP = pronNounPhrase de_38 ;
  TheyFemNP = pronNounPhrase de_38 ;

  YouNP  = let {ni = pronNounPhrase ni_37 } in {s = ni.s ; g = ni.g ; n = Sg} ;

  ItNP   = pronNounPhrase det_40 ; ----
  ThisNP = regNameNounPhrase ["det her"] NNeutr ; 
  ThatNP = regNameNounPhrase ["det der"] NNeutr ; 
  TheseNumNP n = 
    {s = \\c => ["de her"] ++ n.s ! npCase c ; g = Neutr ; n = Pl} ;
  ThoseNumNP n = 
    {s = \\c => ["de der"] ++ n.s ! npCase c ; g = Neutr ; n = Pl} ;

  EveryDet = varjeDet ; 
  AllMassDet   = mkDeterminerSgGender2 "all" "alt" IndefP ; 
  AllNumDet  = mkDeterminerPlNum "alle" IndefP ; 
  AnyDet   = mkDeterminerSgGender2 "nogen" "noget" IndefP ; 
  AnyNumDet  = mkDeterminerPlNum "nogle" IndefP ; 
  SomeDet  = mkDeterminerSgGender2 "nogen" "noget" IndefP ; 
  SomeNumDet = mkDeterminerPlNum "nogle" IndefP ; 
  ManyDet  = mkDeterminerPl "mange" IndefP ; 
  HowManyDet  = mkDeterminerPl ["hvor mange"] IndefP ; 
  NoDet    = mkDeterminerSgGender2 "ingen" "ingen" IndefP ; 
  NoNumDet   = mkDeterminerPlNum "ingen" IndefP ; 
  WhichNumDet = mkDeterminerPlNum "hvilke" IndefP ; 

  UseNumeral i = {s = table {Nom => i.s ; Gen => i.s ++ "s"}} ; ---

  WhichDet = vilkenDet ;
  MostDet  = mkDeterminerSgGender2 ["den meste"] ["det meste"] (DefP Def) ;
  MostsDet = flestaDet ;
  MuchDet  = mkDeterminerSg (detSgInvar "meget") IndefP ;

  ThisDet  = mkDeterminerSgGender2 ["den her"] ["det her"] (DefP Def) ;
  ThatDet  = mkDeterminerSgGender2 ["den der"] ["det der"] (DefP Def) ;
  TheseNumDet = mkDeterminerPlNum ["de her"] (DefP Def) ; 
  ThoseNumDet = mkDeterminerPlNum ["de der"] (DefP Def) ; 

  HowIAdv = ss "hvor" ;
  WhenIAdv = ss "hvornår" ;
  WhereIAdv = ss "hver" ;
  WhyIAdv = ss "hvorfor" ;

  AndConj  = ss "og" ** {n = Pl}  ;
  OrConj   = ss "eller" ** {n = Sg} ;
  BothAnd  = sd2 "både" "og" ** {n = Pl}  ;
  EitherOr = sd2 "enten" "eller" ** {n = Sg} ;
  NeitherNor = sd2 "hverken" "eller" ** {n = Sg} ;
  IfSubj   = ss "hvis" ;
  WhenSubj = ss "når" ;

  PhrYes = ss ["Ja ."] ;
  PhrNo = ss ["Nej ."] ;

  VeryAdv = ss "meget" ;
  TooAdv = ss "for" ; ---- ?
  OtherwiseAdv = ss "anderledes" ; ---- ?
  ThereforeAdv = ss "derfor" ;

  EverybodyNP  = let alla = table {Nom => "alle" ; Gen => "alles"} in
                   {s = \\c => alla ! npCase c ; g = Utr ; n = Pl} ;
  SomebodyNP   = nameNounPhrase (mkProperName "nogen" NUtr) ;
  NobodyNP     = nameNounPhrase (mkProperName "ingen" NUtr) ;
  EverythingNP = nameNounPhrase (mkProperName "alt"   NNeutr) ; 
  SomethingNP  = nameNounPhrase (mkProperName "noget" NNeutr) ; 
  NothingNP    = nameNounPhrase (mkProperName "intet" NNeutr) ; 

  CanVV     = mkVerb "kunne" "kan" nonExist  "kunne" "kunnet" nonExist ** {s1 = [] ; isAux = True} ;
  CanKnowVV = mkVerb "kunne" "kan" nonExist  "kunne" "kunnet" nonExist ** {s1 = [] ; isAux = True} ;
  MustVV    = mkVerb "måtte" "må" "mås"  "måtte"  "måttet" "må" ** {s1 = [] ; isAux = True} ; ---- ?
  WantVV    = mkVerb "ville" "vil" nonExist "ville" "villet" nonExist ** {s1 = [] ; isAux = True} ; ---

  EverywhereNP = advPost "overalt" ;
  SomewhereNP = advPost ["et eller andet sted"] ; ---- ?
  NowhereNP = advPost "intetsteds" ;

  AlthoughSubj = ss ["selv om"] ;

  AlmostAdv = ss "næsten" ;
  QuiteAdv = ss "temmelig" ;

  InPrep = ss "i" ;
  OnPrep = ss "på" ;
  ToPrep = ss "til" ;
  ThroughPrep = ss "igennem" ;
  AbovePrep = ss "ovenfor" ;
  UnderPrep = ss "under" ;
  InFrontPrep = ss "fremfor" ; ---- ?
  BehindPrep = ss "bag" ;
  BetweenPrep = ss "mellem" ;
  FromPrep = ss "fra" ;
  BeforePrep = ss "før" ;
  DuringPrep = ss "under" ;
  AfterPrep = ss "efter" ;
  WithPrep = ss "med" ;
  WithoutPrep = ss "uden" ;
  ByMeansPrep = ss "med" ;
  PossessPrep = ss "af" ;
  PartPrep = ss "af" ;
  AgentPrep = ss "af" ;

}
