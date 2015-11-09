--# -coding=latin1
concrete SentencesEst of Sentences = NumeralEst ** SentencesI

{- ---- TODO functor exceptions
  - [Is, IsMass, NameNN, ObjMass,
   IFemale, YouFamFemale, YouPolFemale, IMale, YouFamMale, YouPolMale,
   WeMale, WeFemale, YouPlurFamMale, YouPlurFamFemale, YouPlurPolFemale, YouPlurPolMale, 
   NPPlace, CNPlace, placeNP, mkCNPlace, mkCNPlacePl,
   GObjectPlease,
   NPNationality, mkNPNationality,
   Country, PCountry
  ]
-}


with 
  (Syntax = SyntaxEst),
  (Symbolic = SymbolicEst),
  (Lexicon = LexiconEst) ** 
    open SyntaxEst, ExtraEst, (P = ParadigmsEst), (V = VerbEst), Prelude in {

{- ---- TODO: functor exceptions for Est

  lincat
    Country = {np : NP ; isExternal : Bool} ;
  lin 
    PCountry x = mkPhrase (mkUtt x.np) ;
  oper
    NPNationality = {lang : NP ; prop : A ; country : {np : NP ; isExternal : Bool}} ;
    NPPlace = {name : NP ; at : Adv ; to : Adv ; from : Adv} ;
    CNPlace = {name : CN ; isExternal : Bool ; isPl : Bool} ;

  placeNP : Det -> CNPlace -> NPPlace = \det,kind ->
    let name : NP = mkNP det kind.name in {
      name = name ;
      at = mkAdv (P.casePrep (if_then_else P.Case kind.isExternal P.adessive P.inessive)) name ;
      to = mkAdv (P.casePrep (if_then_else P.Case kind.isExternal P.allative P.illative)) name ;
      from = mkAdv (P.casePrep (if_then_else P.Case kind.isExternal P.ablative P.elative)) name
    } ;

  lin 
    Is item prop = mkCl item (V.UseComp (CompPartAP prop)) ; -- tämä pizza on herkullista
    IsMass mass prop = mkCl (mkNP a_Det mass) (V.UseComp (CompPartAP prop)) ; -- pizza on herkullista
    NameNN = mkNP (P.mkPN (P.mkN "NN" "NN:iä")) ;

    IMale, IFemale = 
        {name = mkNP (ProDrop i_Pron) ; isPron = True ; poss = ProDropPoss i_Pron} ; 
    YouFamMale, YouFamFemale = 
        {name = mkNP (ProDrop youSg_Pron) ; isPron = True ; poss = ProDropPoss youSg_Pron} ; 
    YouPolMale, YouPolFemale = 
        {name = mkNP (ProDrop youPol_Pron) ; isPron = True ; poss = ProDropPoss youPol_Pron} ;
    WeMale, WeFemale = 
        {name = mkNP (ProDrop we_Pron) ; isPron = True ; poss = ProDropPoss we_Pron} ; 
    YouPlurFamMale, YouPlurFamFemale, YouPlurPolMale, YouPlurPolFemale = 
        {name = mkNP (ProDrop youPl_Pron) ; isPron = True ; poss = ProDropPoss youPl_Pron} ;

    ObjMass = PartCN ;

    GObjectPlease o = lin Text (mkPhr noPConj (mkUtt o) (lin Voc (ss "kiitos"))) ;
-}

  }
