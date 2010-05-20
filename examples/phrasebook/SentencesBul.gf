concrete SentencesBul of Sentences = 
  NumeralBul ** SentencesI - [IMale, IFemale, YouFamMale, YouFamFemale, YouPolMale, 
                              YouPolFemale, ACitizen, Citizenship, PCitizenship, 
                              LangNat, CitiNat, CountryNat, PropCit,
                              Nationality, Country, Language, PLanguage, PCountry] with 
  (Syntax = SyntaxBul),
  (Symbolic = SymbolicBul),
  (Lexicon = LexiconBul) ** open ExtraBul, (R = ResBul) in {

lincat
    Citizenship = {s1 : R.Gender => R.NForm => Str;                 -- there are two nouns for every citizenship - one for males and one for females
                   s2 : A                                           -- furthermore, adjective for Property
                  } ;           
    Nationality = {s1 : R.Gender => R.NForm => Str;                 -- there are two nouns for every citizenship - one for males and one for females
                   s2 : A;                                          -- furthermore, adjective for Property
                   s3 : PN                                          -- country name
                  } ;
    Language = A ;
    Country = PN ;

lin IMale = mkPerson i_Pron ;
    IFemale = mkPerson i8fem_Pron ;

lin YouFamMale = mkPerson youSg_Pron ;
    YouFamFemale = mkPerson youSg8fem_Pron ;
    YouPolMale, YouPolFemale = mkPerson youPol_Pron ;

lin ACitizen p cit = 
      let noun : N
               = case p.name.a.gn of {
                   R.GSg g => lin N {s = \\nf => cit.s1 ! g      ! nf; g = case g of {R.Masc=>R.AMasc R.Human; R.Fem=>R.AFem; R.Neut=>R.ANeut}} ;
                   R.GPl   => lin N {s = \\nf => cit.s1 ! R.Masc ! nf; g = R.AMasc R.Human}
                 } ;
      in mkCl p.name noun ;

    PCitizenship cit =
      mkPhrase (mkUtt (mkAP cit.s2)) ;

    LangNat n = n.s2 ;
    CitiNat n = n ;
    CountryNat n = n.s3 ;
    PropCit cit = cit.s2 ;

    PLanguage x = mkPhrase (mkUtt (mkAP x)) ;
    PCountry x = mkPhrase (mkUtt (mkNP x)) ;

}
