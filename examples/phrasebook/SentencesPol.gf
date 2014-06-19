concrete SentencesPol of Sentences = 
  NumeralPol ** SentencesI - [
    Day,PDay,OnDay,LAnguage,PLanguage,Citizenship,
    PCitizenship,CitiNat,PropCit,ACitizen,
    Nationality,Transport,PTransport,ByTransp,
    IFemale,YouFamFemale, YouPolFemale,YouPolMale,
    IMale, YouFamMale --- AR, for pro drop
    ] 
    with 
  (Syntax = SyntaxPol),
  (Symbolic = SymbolicPol),
  (Lexicon = LexiconPol) ** 
  open (N = NounPol),(R = ResPol), (Pron = PronounMorphoPol), (E = ExtraPol), Prelude in {
    
  flags  
    optimize =values ; coding =utf8 ; 

  lincat
    Day = { name,hab,adv:Str } ;
    LAnguage = A ;
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

--- AR 8/12/2010: using pro drop
    IMale = mkPerson (E.ProDrop Pron.pronJa);
    IFemale = mkPerson (E.ProDrop (Pron.pronJaFoo (R.PGen R.Fem)));
    YouFamMale = mkPerson (E.ProDrop (Pron.pronTy));
    YouFamFemale = mkPerson (E.ProDrop (Pron.pronTyFoo (R.PGen R.Fem)));
--    YouPolFemale = mkPerson (E.ProDrop (Pron.pronPani));
--    YouPolMale = mkPerson (E.ProDrop (Pron.pronPan));

--- original
---    IFemale = mkPerson (Pron.pronJaFoo (R.PGen R.Fem));
---    YouFamFemale = mkPerson (Pron.pronTyFoo (R.PGen R.Fem));
    YouPolFemale = mkPerson (Pron.pronPani);
    YouPolMale = mkPerson (Pron.pronPan);
}
