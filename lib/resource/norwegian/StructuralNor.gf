--# -path=.:../scandinavian:../abstract:../../prelude

--1 The Top-Level Norwegian Resource Grammar: Structural Words
--
-- Aarne Ranta 2002 -- 2004
--
concrete StructuralNor of Structural = 
  CategoriesNor, NumeralsNor ** open Prelude, MorphoNor, SyntaxNor in {
 lin

  INP    = pronNounPhrase jag_32 ;
  ThouNP = pronNounPhrase du_33 ;
  HeNP   = pronNounPhrase han_34 ;
  SheNP  = pronNounPhrase hon_35 ;
  WeNumNP n = pronNounPhrase (pronWithNum vi_36 n) ;
  YeNumNP n = pronNounPhrase (pronWithNum ni_37 n) ;
  TheyNP = pronNounPhrase de_38 ;
  TheyFemNP = pronNounPhrase de_38 ;

  YouNP  = pronNounPhrase De_38 ;

  ItNP   = pronNounPhrase det_40 ; ----
  ThisNP = regNameNounPhrase ["dette"] NNeutr ; 
  ThatNP = regNameNounPhrase ["det"] NNeutr ; 
  TheseNumNP n = 
    {s = \\c => ["disse"] ++ n.s ! npCase c ; g = Neutr ; n = Pl ; p =
  P3} ;
  ThoseNumNP n = 
    {s = \\c => ["de der"] ++ n.s ! npCase c ; g = Neutr ; n = Pl ; p
  = P3} ;

  EveryDet = varjeDet ; 
  AllMassDet   = mkDeterminerSgGender2 "all" "alt" IndefP ; 
  AllNumDet  = mkDeterminerPlNum "alle" IndefP ; 
  AnyDet   = mkDeterminerSgGender2 "noen" "noe" IndefP ; 
  AnyNumDet  = mkDeterminerPlNum "noen" IndefP ; 
  SomeDet  = mkDeterminerSgGender2 "noen" "noe" IndefP ; 
  SomeNumDet = mkDeterminerPlNum "noen" IndefP ; 
  ManyDet  = mkDeterminerPl "mange" IndefP ; 
  HowManyDet  = mkDeterminerPl ["hvor mange"] IndefP ; 
  NoDet    = mkDeterminerSgGender2 "ingen" "ingen" IndefP ; 
  NoNumDet   = mkDeterminerPlNum "ingen" IndefP ; 
  WhichNumDet = mkDeterminerPlNum "hvilke" IndefP ; 

  UseNumeral i = {s = table {Nom => i.s ; Gen => i.s ++ "s"}} ; ---

  WhichDet = vilkenDet ;
  MostDet  = mkDeterminerSgGender2 ["den meste"] ["det meste"] (DefP Def) ;
  MostsDet = flestaDet ;
  MuchDet  = mkDeterminerSg (detSgInvar "mye") IndefP ;

  ThisDet  = mkDeterminerSgGender2 ["denne"] ["dette"] (DefP Def) ;
  ThatDet  = mkDeterminerSgGender2 ["den der"] ["det der"] (DefP Indef) ;
  TheseNumDet = mkDeterminerPlNum ["disse"] (DefP Def) ; 
  ThoseNumDet = mkDeterminerPlNum ["de der"] (DefP Def) ; 

  HowIAdv = ss "hvor" ;
  WhenIAdv = ss "når" ;
  WhereIAdv = ss "hver" ;
  WhyIAdv = ss "hvorfor" ;

  AndConj  = ss "og" ** {n = Pl}  ;
  OrConj   = ss "eller" ** {n = Sg} ;
  BothAnd  = sd2 "både" "og" ** {n = Pl}  ;
  EitherOr = sd2 "enten" "eller" ** {n = Sg} ;
  NeitherNor = sd2 "verken" "eller" ** {n = Sg} ;
  IfSubj   = ss "hvis" ;
  WhenSubj = ss "når" ;

  PhrYes = ss ["Ja ."] ;
  PhrNo = ss ["Nei ."] ;

  VeryAdv = ss "meget" ;
  TooAdv = ss "for" ; ---- ?
  OtherwiseAdv = ss "annerledes" ; ---- ?
  ThereforeAdv = ss "derfor" ;

  EverybodyNP  = let alla = table {Nom => "alle" ; Gen => "alles"} in
                   {s = \\c => alla ! npCase c ; g = Utr Masc ; n = Pl
                   ; p = P3} ;
  SomebodyNP   = nameNounPhrase (mkProperName "noen" (NUtr Masc)) ;
  NobodyNP     = nameNounPhrase (mkProperName "ingen" (NUtr Masc)) ;
  EverythingNP = nameNounPhrase (mkProperName "alt"   NNeutr) ; 
  SomethingNP  = nameNounPhrase (mkProperName "noe" NNeutr) ; 
  NothingNP    = nameNounPhrase (mkProperName "intet" NNeutr) ; 

  CanVV     = mkVerb "kunne" "kan" nonExist  "kunne" "kunnet" nonExist ** {s1 = [] ; s3 = []} ;
  CanKnowVV = mkVerb "kunne" "kan" nonExist  "kunne" "kunnet" nonExist ** {s1 = [] ; s3 = []} ;
  MustVV    = mkVerb "måtte" "må" "mås"  "måtte"  "måttet" "mått" ** {s1 = [] ; s3 = []} ; ---- ?
  WantVV    = mkVerb "ville" "vil" nonExist "ville" "villet" "vill" ** {s1 = [] ; s3 = []} ; ---

  EverywhereNP = advPost "overalt" ;
  SomewhereNP = advPost ["et eller annet sted"] ; ---- ?
  NowhereNP = advPost "ingensteds" ;

  AlthoughSubj = ss ["selv om"] ;

  AlmostAdv = ss "nesten" ;
  QuiteAdv = ss "temmelig" ;

  InPrep = ss "i" ;
  OnPrep = ss "på" ;
  ToPrep = ss "til" ;
  ThroughPrep = ss "gjennom" ;
  AbovePrep = ss "ovenfor" ;
  UnderPrep = ss "under" ;
  InFrontPrep = ss "foran" ;
  BehindPrep = ss "bakom" ;
  BetweenPrep = ss "mellom" ;
  FromPrep = ss "fra" ;
  BeforePrep = ss "før" ;
  DuringPrep = ss "under" ;
  AfterPrep = ss "etter" ;
  WithPrep = ss "med" ;
  WithoutPrep = ss "uten" ;
  ByMeansPrep = ss "med" ;
  PossessPrep = ss "av" ;
  PartPrep = ss "av" ;
  AgentPrep = ss "av" ;

}
