--# -path=.:../abstract:../../prelude

--1 The Top-Level Swedish Resource Grammar: Structural Words
--
-- Aarne Ranta 2002 -- 2004
--
concrete StructuralSwe of Structural = 
                      CategoriesSwe, NumeralsSwe ** open Prelude, SyntaxSwe in {
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
  ThisNP = regNameNounPhrase ["det här"] Neutr NoMasc ; 
  ThatNP = regNameNounPhrase ["det där"] Neutr NoMasc ; 
  TheseNumNP n = 
    {s = \\c => ["de här"] ++ n.s ! npCase c ; g = Neutr ; n = Pl} ;
  ThoseNumNP n = 
    {s = \\c => ["de där"] ++ n.s ! npCase c ; g = Neutr ; n = Pl} ;

  EveryDet = varjeDet ; 
  AllMassDet   = mkDeterminerSgGender2 "all" "allt" IndefP ; 
  AllNumDet  = mkDeterminerPlNum "alla" IndefP ; 
  AnyDet   = mkDeterminerSgGender2 "någon" "något" IndefP ; 
  AnyNumDet  = mkDeterminerPlNum "några" IndefP ; 
  SomeDet  = mkDeterminerSgGender2 "någon" "något" IndefP ; 
  SomeNumDet = mkDeterminerPlNum "några" IndefP ; 
  ManyDet  = mkDeterminerPl "många" IndefP ; 
  HowManyDet  = mkDeterminerPl ["hur många"] IndefP ; 
  NoDet    = mkDeterminerSgGender2 "ingen" "inget" IndefP ; 
  NoNumDet   = mkDeterminerPlNum "inga" IndefP ; 
  WhichNumDet = mkDeterminerPlNum "vilka" IndefP ; 

  UseNumeral i = {s = table {Nom => i.s ; Gen => i.s ++ "s"}} ; ---

  WhichDet = vilkenDet ;
  MostDet  = mkDeterminerSgGender2 ["den mesta"] ["det mesta"] (DefP Def) ;
  MostsDet = flestaDet ;
  MuchDet  = mkDeterminerSg (detSgInvar "mycket") IndefP ;

  ThisDet  = mkDeterminerSgGender2 ["den här"] ["det här"] (DefP Def) ;
  ThatDet  = mkDeterminerSgGender2 ["den där"] ["det där"] (DefP Def) ;
  TheseNumDet = mkDeterminerPlNum ["de här"] (DefP Def) ; 
  ThoseNumDet = mkDeterminerPlNum ["de där"] (DefP Def) ; 

  HowIAdv = ss "hur" ;
  WhenIAdv = ss "när" ;
  WhereIAdv = ss "var" ;
  WhyIAdv = ss "varför" ;

  AndConj  = ss "och" ** {n = Pl}  ;
  OrConj   = ss "eller" ** {n = Sg} ;
  BothAnd  = sd2 "både" "och" ** {n = Pl}  ;
  EitherOr = sd2 "antingen" "eller" ** {n = Sg} ;
  NeitherNor = sd2 "varken" "eller" ** {n = Sg} ;
  IfSubj   = ss "om" ;
  WhenSubj = ss "när" ;

  PhrYes = ss ["Ja ."] ;
  PhrNo = ss ["Nej ."] ;

  VeryAdv = ss "mycket" ;
  TooAdv = ss "för" ;
  OtherwiseAdv = ss "annars" ;
  ThereforeAdv = ss "därför" ;

  EverybodyNP  = let alla = table {Nom => "alla" ; Gen => "allas"} in
                   {s = \\c => alla ! npCase c ; g = Utr ; n = Pl} ;
  SomebodyNP   = nameNounPhrase (mkProperName "någon" Utr Masc) ;
  NobodyNP     = nameNounPhrase (mkProperName "ingen" Utr Masc) ;
  EverythingNP = nameNounPhrase (mkProperName "allting" Neutr NoMasc) ; 
  SomethingNP  = nameNounPhrase (mkProperName "någonting" Neutr NoMasc) ; 
  NothingNP    = nameNounPhrase (mkProperName "ingenting" Neutr NoMasc) ; 

  CanVV     = mkVerb "kunna" "kan" "kunn"  "kunde" "kunnat" "kunnen" ** {isAux = True} ;
  CanKnowVV = mkVerb "kunna" "kan" "kunn"  "kunde" "kunnat" "kunnen" ** {isAux = True} ;
  MustVV    = mkVerb "få"    "måste" "få"  "fick"  "måst"   "måst" ** {isAux = True} ; ---
  WantVV    = mkVerb "vilja" "vill" "vilj" "ville" "velat" "velad" ** {isAux = True} ; ---

  EverywhereNP = advPost "varstans" ;
  SomewhereNP = advPost "någonstans" ;
  NowhereNP = advPost "ingenstans" ;

  AlthoughSubj = ss "fast" ;

  AlmostAdv = ss "nästan" ;
  QuiteAdv = ss "ganska" ;

  InPrep = ss "i" ;
  OnPrep = ss "på" ;
  ToPrep = ss "till" ;
  ThroughPrep = ss "genom" ;
  AbovePrep = ss "ovanför" ;
  UnderPrep = ss "under" ;
  InFrontPrep = ss "framför" ;
  BehindPrep = ss "bakom" ;
  BetweenPrep = ss "mellan" ;
  FromPrep = ss "från" ;
  BeforePrep = ss "före" ;
  DuringPrep = ss "under" ;
  AfterPrep = ss "efter" ;
  WithPrep = ss "med" ;
  WithoutPrep = ss "utan" ;
  ByMeansPrep = ss "med" ;
  PossessPrep = ss "av" ;
  PartPrep = ss "av" ;
  AgentPrep = ss "av" ;

}
