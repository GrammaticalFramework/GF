--# -path=.:../romance:../abstract:../../prelude

concrete StructuralIta of Structural = CategoriesIta, NumeralsIta ** 
  open SyntaxIta, MorphoIta, Prelude in {

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

  ThisNP = mkNameNounPhrase ["questo"] Masc ;
  ThatNP = mkNameNounPhrase ["quello"] Masc ;
  TheseNumNP n = mkNameNounPhrase ("questi" ++ n.s ! Masc) Masc ;
  ThoseNumNP n = mkNameNounPhrase ("quelli" ++ n.s ! Masc) Masc ;

  ItNP   = pronNounPhrase pronIl ;

  EveryDet = chaqueDet ; 
  AllMassDet   = mkDeterminer singular "tutto" "tutta" ;
  AllNumDet  = mkDeterminerNum plural ["tutti i"] ["tutte le"] ; --- gli
  WhichDet = quelDet ;
  WhichNumDet = mkDeterminerNum plural "quali" "quali" ;
  MostsDet = plupartDet ;
  MostDet  = mkDeterminer1 singular (["la maggior parte"] ++ elisDe) ; --- de
  SomeDet  = mkDeterminer1 singular "qualche" ;
  SomeNumDet = mkDeterminerNum plural "alcuni" "alcune" ;
  NoDet    = mkDeterminer singular "nessuno" "nessuna" ; --- non
  NoNumDet   = mkDeterminerNum plural "nessuni" "nessune" ; ---- ??
  AnyDet   = mkDeterminer1 singular "qualche" ; ---
  AnyNumDet  = mkDeterminerNum plural "alcuni" "alcune" ; ---
  ManyDet  = mkDeterminer plural "molti" "molte" ;
  MuchDet  = mkDeterminer1 singular "molto" ;
  ThisDet  = mkDeterminer singular "questo" "questa" ;
  ThatDet  = mkDeterminer singular "quello" "quella" ;
  TheseNumDet = mkDeterminerNum plural "questi" "queste" ; --- ci
  ThoseNumDet = mkDeterminerNum plural "quelli" "quelle" ; --- quegli

  UseNumeral n = {s = \\_ => n.s} ; ---- gender

  HowIAdv = commentAdv ;
  WhenIAdv = quandAdv ;
  WhereIAdv = ouAdv ;
  WhyIAdv = pourquoiAdv ;

  AndConj = etConj ;
  OrConj = ouConj  ;
  BothAnd = etetConj ;
  EitherOr = ououConj  ;
  NeitherNor = niniConj  ; --- requires ne !
  IfSubj = siSubj ;
  WhenSubj = quandSubj ;

  PhrYes = ouiPhr ;  
  PhrNo = nonPhr ; --- and also Si!

  VeryAdv = ss "molto" ;
  TooAdv = ss "troppo" ;
  OtherwiseAdv = ss "altramente" ;
  ThereforeAdv = ss "quindi" ;

  EverybodyNP  = normalNounPhrase (\\c => prepCase c ++ "tutti") Masc Pl ;
  SomebodyNP   = mkNameNounPhrase ["qualcuno"] Masc ;
  NobodyNP     = mkNameNounPhrase ["nessuno"] Masc ;  --- ne
  EverythingNP = mkNameNounPhrase ["tutto"] Masc ;
  SomethingNP  = mkNameNounPhrase ["qualche cosa"] Masc ;
  NothingNP    = mkNameNounPhrase ["niente"] Masc ; --- ne

  CanVV     = mkVerbVerbDir (verbPres (potere_72 "potere") AHabere) ;
  CanKnowVV = mkVerbVerbDir (verbPres (sapere_81 "sapere") AHabere) ;
  MustVV    = mkVerbVerbDir (verbPres (dovere_50 "dovere") AHabere) ;
  WantVV    = mkVerbVerbDir (verbPres (volere_99 "volere") AHabere) ;

  EverywhereNP = ss "dappertutto" ;
  SomewhereNP = ss ["qualche parte"] ; --- ne - pas
  NowhereNP = ss ["nessun parte"] ;

  AlthoughSubj = ss "benché" ** {m = Con} ;

  AlmostAdv = ss "quasi" ;
  QuiteAdv = ss "assai" ;

  InPrep = justCase (CPrep P_in) ;
  OnPrep = justCase (CPrep P_su) ;
  ToPrep = justCase dative ; ---
  ThroughPrep = justPrep "per" ;
  AbovePrep = justPrep "sopra" ;
  UnderPrep = justPrep "sotto" ;
  InFrontPrep = justPrep "davanti" ;
  BehindPrep = justPrep "dietro" ;
  BetweenPrep = justPrep "tra" ;
  FromPrep = justCase (CPrep P_da) ;
  BeforePrep = justPrep "prima" ;
  DuringPrep = justPrep "durante" ;
  AfterPrep = justPrep "dopo" ;
  WithPrep = justCase (CPrep P_con) ;
  WithoutPrep = justPrep "senza" ;
  ByMeansPrep = justPrep "per" ;
  PossessPrep = justCase genitive ;
  PartPrep = justCase genitive ; ---
  AgentPrep = justCase (CPrep P_da) ;

}
