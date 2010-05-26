concrete SentencesFin of Sentences = NumeralFin ** SentencesI - 
  [Is, NameNN, ObjMass,
   IFemale, YouFamFemale, YouPolFemale, IMale, YouFamMale, YouPolMale
  ] with 
  (Syntax = SyntaxFin),
  (Symbolic = SymbolicFin),
  (Lexicon = LexiconFin) ** open SyntaxFin, ExtraFin, (P = ParadigmsFin), (V = VerbFin) in {

  lin 
    Is item prop = mkCl item (V.UseComp (CompPartAP prop)) ; -- pizza on herkullista
    NameNN = mkNP (P.mkPN (P.mkN "NN" "NN:iä")) ;

    IMale, IFemale = 
        {name = mkNP (ProDrop i_Pron) ; isPron = True ; poss = mkQuant i_Pron} ; 
    YouFamMale, YouFamFemale = 
        {name = mkNP (ProDrop youSg_Pron) ; isPron = True ; poss = mkQuant youSg_Pron} ; 
    YouPolMale, YouPolFemale = 
        {name = mkNP (ProDrop youPol_Pron) ; isPron = True ; poss = mkQuant youPol_Pron} ;

    ObjMass = PartCN ;

  }
