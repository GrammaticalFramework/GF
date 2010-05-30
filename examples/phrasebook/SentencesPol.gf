concrete SentencesPol of Sentences = 
  NumeralPol ** SentencesI - [
    Day,PDay,OnDay,Language,PLanguage,Citizenship,
    PCitizenship,CitiNat,PropCit,ACitizen,
    Nationality,Transport,PTransport,ByTransp,
    IFemale,YouFamFemale,YouPolFemale,YouPolMale] 
    with 
  (Syntax = SyntaxPol),
  (Symbolic = SymbolicPol),
  (Lexicon = LexiconPol) ** 
  open (N = NounPol),(R = ResPol), (Pron = PronounMorphoPol), Prelude in {
    
  flags  
    optimize =values ; coding =utf8 ; 

  lincat
    Day = { name,hab,adv:Str } ;
    Language = A ;
    Citizenship = { prop:A; citizenMSg:Str; citizenMPl:Str; citizenF:Str} ;
    Nationality = { lang: A; prop: A; country: NP; citizenMSg:Str; citizenMPl:Str; citizenF:Str } ;
    Transport = { cn:CN; verb:Str} ;

  lin
    PDay d = (ss d.name) ** {lock_Text = <>};
    OnDay d = (ss d.adv) ** {lock_Adv = <>};
    PLanguage l = (ss l.pos.s1) ** {lock_Text = <>};    
    PTransport t = mkPhrase (mkUtt t.cn) ;
    ByTransp t = { s=t.cn.s!R.Sg!R.Instr; lock_Adv = <>} ;
    PCitizenship c = mkPhrase (mkUtt (mkAP c.prop)) ;
    CitiNat n = {prop=n.prop; citizenMSg=n.citizenMSg; citizenMPl=n.citizenMPl; citizenF=n.citizenF};
    PropCit c = c.prop;
    ACitizen p n = mkCl p.name {s= case p.name.gn of {
          R.MascPersSg=>n.citizenMSg; R.FemSg=>n.citizenF; _=>n.citizenMPl
        };
         lock_Adv=<>};
    IFemale = mkPerson (Pron.pronJaFoo (R.PGen R.Fem));
    YouFamFemale = mkPerson (Pron.pronTyFoo (R.PGen R.Fem));
    YouPolFemale = mkPerson (Pron.pronPani);
    YouPolMale = mkPerson (Pron.pronPan);
}
