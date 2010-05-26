concrete SentencesPol of Sentences = 
  NumeralPol ** SentencesI - [
    Day,PDay,OnDay,Language,PLanguage,
    Nationality,Transport,PTransport,ByTransp,
    IFemale,YouFamFemale,YouPolFemale,YouPolMale] 
    with 
  (Syntax = SyntaxPol),
  (Symbolic = SymbolicPol),
  (Lexicon = LexiconPol) ** open (R = ResPol), (Pron = PronounMorphoPol), Prelude in {
    
  flags  
    optimize =values ; coding =utf8 ; 

  lincat
    Day = { name,hab,adv:Str } ;
    Language = A ;
    Citizenship = A ;
    Nationality = { lang: A; prop: A; country: NP } ;
    Transport = CN ;

  lin
    PDay d = (ss d.name) ** {lock_Text = <>};
    OnDay d = (ss d.adv) ** {lock_Adv = <>};
    PLanguage l = (ss l.pos.s1) ** {lock_Text = <>};    
    PTransport t = mkPhrase (mkUtt t) ;
    ByTransp t = (ss (t.s!R.Sg!R.Instr)) ** {lock_Adv = <>};
    IFemale = mkPerson (Pron.pronJaFoo (R.PGen R.Fem));
    YouFamFemale = mkPerson (Pron.pronTyFoo (R.PGen R.Fem));
    YouPolFemale = mkPerson (Pron.pronPani);
    YouPolMale = mkPerson (Pron.pronPan);

}
