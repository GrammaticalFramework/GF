concrete SentencesFre of Sentences = NumeralFre ** SentencesI - [
  IsMass,
  QProp,
  IFemale, YouFamFemale, YouPolFemale,
  PYesToNo,
  SHaveNo,SHaveNoMass,
  Superlative
 ] 
  with 
    (Syntax = SyntaxFre), 
    (Symbolic = SymbolicFre), 
    (Lexicon = LexiconFre) ** 
  open SyntaxFre, ExtraFre, (P = ParadigmsFre), Prelude in {

    lincat
      Superlative = {s : Ord ; isPre : Bool} ;
    lin 
      IsMass m q = mkCl (mkNP the_Det m) q ; -- le vin allemand est bon
      QProp a = 
        lin QS {s = \\_ => (EstcequeS (mkS a)).s} ;
      IFemale = 
        {name = mkNP i8fem_Pron ; isPron = True ; poss = mkQuant i_Pron} ; 
      YouFamFemale = 
        {name = mkNP youSg8fem_Pron ; isPron = True ; poss = mkQuant youSg_Pron} ; 
      YouPolFemale = 
        {name = mkNP youPol8fem_Pron ; isPron = True ; poss = mkQuant youPol_Pron};

      PYesToNo = mkPhrase (lin Utt (ss "si")) ;

    SHaveNo p k = mkS negativePol (mkCl p.name have_de (mkNP aPl_Det k)) ;
    SHaveNoMass p k = mkS negativePol (mkCl p.name (ComplCN have_de k)) ;

  oper
    have_de : V2 =  P.mkV2 (P.mkV have_V2) P.genitive ;

}
