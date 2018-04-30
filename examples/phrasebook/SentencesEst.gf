concrete SentencesEst of Sentences = NumeralEst ** SentencesI -
  [NameNN, ObjMass,
   NPPlace, CNPlace, placeNP, mkCNPlace, mkCNPlacePl, NPNationality, mkNPNationality,
   CitiNat, Citizenship, Nationality, ACitizen, PropCit, PCitizenship,
   GObjectPlease
  ] with 
  (Syntax = SyntaxEst),
  (Symbolic = SymbolicEst),
  (Lexicon = LexiconEst) **
    open SyntaxEst, ExtraEst, (P = ParadigmsEst), (V = VerbEst), Prelude in {

  flags optimize = noexpand ;

  lincat
    Citizenship = ACitizenship ;
    Nationality = NPNationality ;
        
  oper
    NPPlace : Type = {name : NP ; at : Adv ; to : Adv ; from : Adv} ;
    CNPlace : Type = {name : CN ; at : Prep ; to : Prep ; from : Prep ; isPl : Bool} ;
    ACitizenship : Type = { prop : A ; nat : A } ;
    NPNationality : Type = ACitizenship ** {lang : NP ; country : NP} ;

  placeNP : Det -> CNPlace -> NPPlace = \det,kind ->
    let name : NP = mkNP det kind.name in {
      name = name ;
      at = mkAdv kind.at name ;
      to = mkAdv kind.to name ;
      from = mkAdv kind.from name
    } ;

  lin 
    -- The Fin-grammar overloaded the Is and IsMass functions to be
    -- able to use the complement in partitive.
    -- This would be wrong in Est, where the complement is in nominative.
    -- Fin: tämä pizza on herkullista
    -- Is item prop = mkCl item (V.UseComp (CompPartAP prop)) ;
    --
    -- Fin: pizza on herkullista
    -- IsMass mass prop = mkCl (mkNP a_Det mass) (V.UseComp (CompPartAP prop)) ;

    NameNN = mkNP (P.mkPN (P.mkN "NN")) ;

  -- Estonian does not have possessive endings and does not make use of ProDrop
  -- that much, so we do not override SentencesI, like Finnish does.
{--
    IMale, IFemale = 
        {name = mkNP (ProDrop i_Pron) ; isPron = True ; poss = ProDropPoss i_Pron} ; 
    YouFamMale, YouFamFemale = 
        {name = mkNP (ProDrop youSg_Pron) ; isPron = True ; poss = ProDropPoss youSg_Pron} ; 
    YouPolMale, YouPolFemale = 
        {name = mkNP (ProDrop youPol_Pron) ; isPron = True ; poss = ProDropPoss youPol_Pron} ;
--}

    ObjMass = PartCN ;

    GObjectPlease o = lin Text (mkPhr noPConj (mkUtt o) (lin Voc (ss "palun"))) ;

    CitiNat n = n ; -- keep just prop and nat fields
    PropCit c = c.prop ; 
    PCitizenship c = mkPhrase (mkUtt (mkAP c.prop)) ;
    ACitizen p n = mkCl p.name n.nat ;
}
