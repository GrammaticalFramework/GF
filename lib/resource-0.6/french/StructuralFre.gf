--# -path=.:../romance:../abstract:../../prelude

concrete StructuralFre of Structural = CombinationsFre ** 
  open SyntaxFre, MorphoFre, Prelude in {

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

  ThisNP = mkNameNounPhrase ["ceci"] Masc ;
  ThatNP = mkNameNounPhrase ["ça"] Masc ;
  TheseNumNP n = mkNameNounPhrase ("ceux" ++ n.s ! Masc ++ "ci") Masc ;
  ThoseNumNP n = mkNameNounPhrase ("ceux" ++ n.s ! Masc ++ "là") Masc ;

  ItNP   = pronNounPhrase pronIl ;

  EveryDet = chaqueDet ; 
  AllMassDet   = toutDet ;
  AllNumDet  = tousDet ;
  WhichDet = quelDet ;
  WhichNumDet = mkDeterminerNum plural "quels" "quelles" ;
  MostsDet = plupartDet ;
  MostDet  = mkDeterminer1 singular (["la plupart"] ++ elisDe) ; --- de
  SomeDet  = mkDeterminer1 singular "quelque" ;
  SomeNumDet = mkDeterminerNum plural "quelques" "quelques" ;
  NoDet = mkDeterminer singular "aucun" "aucune" ; --- ne
  NoNumDet = mkDeterminerNum plural ("aucun" ++ "des") ("aucune" ++ "des") ; --- ne
  AnyDet   = mkDeterminer1 singular "quelque" ; ---
  AnyNumDet  = mkDeterminerNum plural "quelques" "quelques" ; ---
  ManyDet  = mkDeterminer1 plural "plusieurs" ;
  MuchDet  = mkDeterminer1 singular ("beaucoup" ++ elisDe) ; --- de
  ThisDet  = mkDeterminer singular (pre {"ce" ; "cet" / voyelle}) "cette" ; --- ci
  ThatDet  = mkDeterminer singular (pre {"ce" ; "cet" / voyelle}) "cette" ; --- là
  TheseNumDet = mkDeterminerNum plural "ces" "ces" ; --- ci
  ThoseNumDet = mkDeterminerNum plural "ces" "ces" ; --- là

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

  VeryAdv = ss "très" ;
  TooAdv = ss "trop" ;
  OtherwiseAdv = ss "autrement" ;
  ThereforeAdv = ss "donc" ;

  EverybodyNP  = mkNameNounPhrase ["tout le monde"] Masc ;
  SomebodyNP   = mkNameNounPhrase ["quelqu'un"] Masc ;
  NobodyNP     = mkNameNounPhrase ["personne"] Masc ;  --- ne
  EverythingNP = mkNameNounPhrase ["tout"] Masc ;
  SomethingNP  = mkNameNounPhrase ["quelque chose"] Masc ;
  NothingNP    = mkNameNounPhrase ["rien"] Masc ; --- ne

  CanVV     = mkVerbVerbDir (verbPres (conj3pouvoir "pouvoir")) ;
  CanKnowVV = mkVerbVerbDir (verbPres (conj3savoir "savoir")) ;
  MustVV    = mkVerbVerbDir (verbPres (conj3devoir "devoir")) ;
  WantVV    = mkVerbVerbDir (verbPres (conj3vouloir "vouloir")) ;

  EverywhereNP = ss "partout" ;
  SomewhereNP = ss ["quelque part"] ; --- ne - pas
  NowhereNP = ss ["nulle part"] ;

  AlthoughSubj = ss ("bien" ++ elisQue) ** {m = Con} ;

  AlmostAdv = ss "presque" ;
  QuiteAdv = ss "assez" ;

  InPrep = justPrep "dans" ;
  OnPrep = justPrep "sur" ;
  ToPrep = justCase dative ; ---
  ThroughPrep = justPrep "par" ;
  AbovePrep = {s = ["au dessus"] ; c = genitive} ;
  UnderPrep = justPrep "sous" ;
  InFrontPrep = justPrep "devant" ;
  BehindPrep = justPrep "derrière" ;
  BetweenPrep = justPrep "entre" ;
  FromPrep = justCase genitive ; ---
  BeforePrep = justPrep "avant" ;
  DuringPrep = justPrep "pendant" ;
  AfterPrep = justPrep "après" ;
  WithPrep = justPrep "avec" ;
  WithoutPrep = justPrep "sans" ;
  ByMeansPrep = justPrep "par" ;
  PossessPrep = justCase genitive ;
  PartPrep = justCase genitive ; ---
  AgentPrep = justPrep "par" ;

}
