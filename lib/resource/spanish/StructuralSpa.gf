--# -path=.:../romance:../abstract:../../prelude

concrete StructuralSpa of Structural = CategoriesSpa, NumeralsSpa ** 
  open SyntaxSpa, MorphoSpa, Prelude in {

lin
  INP    = pronNounPhrase pronJe ;
  ThouNP = pronNounPhrase pronTu ;
  HeNP   = pronNounPhrase pronIl ;
  SheNP  = pronNounPhrase pronElle ;
  WeNumNP n = pronNounPhrase (pronWithNum pronNous n) ;
  YeNumNP n = pronNounPhrase (pronWithNum pronVous n) ;
  YouNP  = pronNounPhrase pronVous ;
  TheyNP = pronNounPhrase pronIls ; 

-- Here is a point where the API is really inadequate for French,
-- which distinguishes between masculine and feminine "they".
-- The following solution is not attractive.

---  TheyNP = pronNounPhrase (variants {pronIls ; pronElles}) ;

  ThisNP = mkNameNounPhrase ["esto"] Masc ;
  ThatNP = mkNameNounPhrase ["eso"] Masc ;
  TheseNumNP n = mkNameNounPhrase ("éstos" ++ n.s ! Masc) Masc ;
  ThoseNumNP n = mkNameNounPhrase ("ésos" ++ n.s ! Masc) Masc ;

  ItNP   = pronNounPhrase pronIl ;

  EveryDet = chaqueDet ; 
  AllMassDet   = mkDeterminer singular "todo" "toda" ;
  AllNumDet  = mkDeterminerNum plural ["todos los"] ["todas las"] ;
  WhichDet = quelDet ;
  WhichNumDet = mkDeterminerNum plural "cuales" "cuales" ;
  MostsDet = plupartDet ;
  MostDet  = mkDeterminer1 singular (["la mayor parte"] ++ elisDe) ; --- de
  SomeDet  = mkDeterminer singular "alguno" "alguna" ;
  SomeNumDet = mkDeterminerNum plural "algunos" "algunas" ;
  NoDet    = mkDeterminer singular "ninguno" "ninguna" ; --- non
  NoNumDet   = mkDeterminerNum plural "ningunos" "ningunas" ; ---- ??
  AnyDet   = mkDeterminer singular "alguno" "alguna" ; ---
  AnyNumDet  = mkDeterminerNum plural "algunos" "algunas" ; ---
  ManyDet  = mkDeterminer plural "muchos" "muchas" ;
  MuchDet  = mkDeterminer1 singular "mucho" ;
  ThisDet  = mkDeterminer singular "esto" "esta" ;
  ThatDet  = mkDeterminer singular "eso" "esa" ;
  TheseNumDet = mkDeterminerNum plural "estos" "estas" ;
  ThoseNumDet = mkDeterminerNum plural "esos" "esas" ; 

  UseNumeral n = {s = \\_ => n.s} ; ---- gender

  HowIAdv = commentAdv ;
  WhenIAdv = quandAdv ;
  WhereIAdv = ouAdv ;
  WhyIAdv = pourquoiAdv ;

  AndConj = etConj ;
  OrConj = ouConj  ;
  BothAnd = etetConj ;
  EitherOr = ououConj  ;
  NeitherNor = niniConj  ; 
  IfSubj = siSubj ;
  WhenSubj = quandSubj ;

  PhrYes = ouiPhr ;  
  PhrNo = nonPhr ; --- and also Si!

  VeryAdv = ss "muy" ;
  TooAdv = ss "demasiado" ;
  OtherwiseAdv = ss "otramente" ;
  ThereforeAdv = ss ["por eso"] ;

  EverybodyNP  = mkNameNounPhrase ["todos"] Masc ;
  SomebodyNP   = mkNameNounPhrase ["algún"] Masc ;
  NobodyNP     = mkNameNounPhrase ["nadién"] Masc ;  --- ne
  EverythingNP = mkNameNounPhrase ["todo"] Masc ;
  SomethingNP  = mkNameNounPhrase ["algo"] Masc ;
  NothingNP    = mkNameNounPhrase ["nada"] Masc ; --- ne

----  CanVV     = mkVerbVerbDir (verbPres (potere_72 "potere") AHabere) ;
----  CanKnowVV = mkVerbVerbDir (verbPres (sapere_81 "sapere") AHabere) ;
----  MustVV    = mkVerbVerbDir (verbPres (dovere_50 "dovere") AHabere) ;
----  WantVV    = mkVerbVerbDir (verbPres (volere_99 "volere") AHabere) ;

  EverywhereNP = ss ["en todas partes"] ;
  SomewhereNP = ss ["en ninguna parte"] ;
  NowhereNP = ss ["en alguna parte"] ; ----

  AlthoughSubj = ss "benché" ** {m = Con} ;

  AlmostAdv = ss "casi" ;
  QuiteAdv = ss "bastante" ;

  InPrep = justPrep "en" ;
  OnPrep = justPrep "sobre" ; ----
  ToPrep = justCase dative ; ---
  ThroughPrep = justPrep "por" ;
  AbovePrep = justPrep "sobre" ;
  UnderPrep = justPrep "bajo" ;
  InFrontPrep = {s = "delante" ; c = genitive} ;
  BehindPrep = {s = "detrás" ; c = genitive} ;
  BetweenPrep = justPrep "entre" ;
  FromPrep = justCase (CPrep P_de) ;
  BeforePrep = {s = "antes" ; c = genitive} ;
  DuringPrep = justPrep "durante" ; ----
  AfterPrep = {s = "después" ; c = genitive} ;
  WithPrep = justPrep "con" ;
  WithoutPrep = justPrep "sin" ;
  ByMeansPrep = justPrep "por" ;
  PossessPrep = justCase genitive ;
  PartPrep = justCase genitive ; ---
  AgentPrep = justPrep "por" ;

}
