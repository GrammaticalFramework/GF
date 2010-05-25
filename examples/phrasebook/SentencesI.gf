--1 Implementation of MOLTO Phrasebook

--2 The functor for (mostly) common structures

incomplete concrete SentencesI of Sentences = Numeral ** 
  open
    Syntax,
    Lexicon,
    Symbolic,  -- for names as strings
    Prelude
  in {
  lincat
    Phrase = Text ;
    Sentence = S ;
    Question = QS ;
    Proposition = Cl ;
    Item = NP ;
    Kind = CN ;
    MassKind = CN ;
    Quality = AP ;
    Property = A ;
    Object = NP ;
    PrimObject = NP ;
    Place = NPPlace ; -- {name : NP ; at : Adv ; to : Adv} ;
    PlaceKind = CNPlace ; -- {name : CN ; at : Prep ; to : Prep} ;
    Currency = CN ;
    Price = NP ;
    Action = Cl ;
    Person = NPPerson ; -- {name : NP ; isPron : Bool ; poss : Quant} ;
    Nationality = NPNationality ; -- {lang : NP ; country : NP ; prop : A} ; 
    Language = NP ;
    Citizenship = A ;
    Country = NP ;
    Day = NPDay ; -- {name : NP ; point : Adv ; habitual : Adv} ;
    Date = Adv ;
    Name = NP ;
    Number = Card ;
    ByTransport = Adv ;
    Transport = {name : CN ; by : Adv} ;
    Superlative = Det ;
  lin
    PSentence s = mkText s | lin Text (mkUtt s) ;  -- optional '.'
    PQuestion s = mkText s | lin Text (mkUtt s) ;  -- optional '?'

    PObject x = mkPhrase (mkUtt x) ;
    PKind x = mkPhrase (mkUtt x) ;
    PMassKind x = mkPhrase (mkUtt x) ;
    PQuality x = mkPhrase (mkUtt x) ;
    PNumber x = mkPhrase (mkUtt x) ;
    PPlace x = mkPhrase (mkUtt x.name) ;
    PPlaceKind x = mkPhrase (mkUtt x.name) ;
    PCurrency x = mkPhrase (mkUtt x) ;
    PPrice x = mkPhrase (mkUtt x) ;
    PLanguage x = mkPhrase (mkUtt x) ;
    PCountry x = mkPhrase (mkUtt x) ;
    PCitizenship x = mkPhrase (mkUtt (mkAP x)) ;
    PDay d = mkPhrase (mkUtt d.name) ;
    PTransport t = mkPhrase (mkUtt t.name) ;
    PByTransport t = mkPhrase (mkUtt t) ;

    PYes = mkPhrase yes_Utt ;
    PNo = mkPhrase no_Utt ;
    PYesToNo = mkPhrase yes_Utt ;

    Is = mkCl ;

    SProp = mkS ;
    SPropNot = mkS negativePol ;
    QProp p = mkQS (mkQCl p) ;

    WherePlace place = mkQS (mkQCl where_IAdv place.name) ;
    WherePerson person = mkQS (mkQCl where_IAdv person.name) ;

    PropAction a = a ;

    AmountCurrency num curr = mkNP num curr ;

    ObjItem i = i ;
    ObjNumber n k = mkNP n k ;
    ObjIndef k = mkNP a_Quant k ;
    ObjMass k = mkNP k ;
    ObjAndObj = mkNP and_Conj ;
    OneObj o = o ; 

    This kind = mkNP this_Quant kind ;
    That kind = mkNP that_Quant kind ;
    These kind = mkNP this_Quant plNum kind ;
    Those kind = mkNP that_Quant plNum kind ;
    The kind = mkNP the_Quant kind ;
    Thes kind = mkNP the_Quant plNum kind ;
    ThisMass kind = mkNP this_Quant kind ;
    ThatMass kind = mkNP that_Quant kind ;
    TheMass kind = mkNP the_Quant kind ;

    SuchKind quality kind = mkCN quality kind ;
    SuchMassKind quality kind = mkCN quality kind ;
    Very property = mkAP very_AdA (mkAP property) ;
    Too property = mkAP too_AdA (mkAP property) ;
    PropQuality property = mkAP property ;

    ThePlace kind = placeNP the_Det kind ;
    APlace kind = placeNP a_Det kind ;

    IMale, IFemale = mkPerson i_Pron ;
    YouFamMale, YouFamFemale = mkPerson youSg_Pron ;
    YouPolMale, YouPolFemale = mkPerson youPol_Pron ;

    LangNat n = n.lang ;
    CitiNat n = n.prop ;
    CountryNat n = n.country ;
    PropCit c = c ;

    OnDay d = d.point ;
    Today = today_Adv ;

    PersonName n = 
      {name = n ; isPron = False ; poss = mkQuant he_Pron} ; -- poss not used
----    NameString s = symb s ; --%
    NameNN = symb "NN" ;

    NNumeral n = mkCard <lin Numeral n : Numeral>  ;

    AHave p kind = mkCl p.name have_V2 (mkNP aPl_Det kind) ;
    AHaveMass p kind = mkCl p.name have_V2 (mkNP kind) ;
    AHaveCurr p curr = mkCl p.name have_V2 (mkNP aPl_Det curr) ;
    ACitizen p n = mkCl p.name n ;
    ABePlace p place = mkCl p.name place.at ;
    ByTransp t = t.by ;

oper 

-- These operations are used internally in Sentences.

  mkPhrase : Utt -> Text = \u -> lin Text u ; -- no punctuation

  mkPerson : Pron -> {name : NP ; isPron : Bool ; poss : Quant} = \p -> 
    {name = mkNP p ; isPron = True ; poss = mkQuant p} ;

-- These are used in Words for each language.

  NPNationality : Type = {lang : NP ; country : NP ; prop : A} ;

  mkNPNationality : NP -> NP -> A -> NPNationality = \la,co,pro ->
        {lang = la ; 
         country = co ;
         prop = pro
        } ;

  NPDay : Type = {name : NP ; point : Adv ; habitual : Adv} ;

  mkNPDay : NP -> Adv -> Adv -> NPDay = \d,p,h ->
      {name = d ; 
       point = p ;
       habitual = h
      } ;

  NPPlace : Type = {name : NP ; at : Adv ; to : Adv} ;
  CNPlace : Type = {name : CN ; at : Prep ; to : Prep} ;

  mkCNPlace : CN -> Prep -> Prep -> CNPlace = \p,i,t -> {
    name = p ;
    at = i ;
    to = t
    } ;

  placeNP : Det -> CNPlace -> NPPlace = \det,kind ->
    let name : NP = mkNP det kind.name in {
      name = name ;
      at = mkAdv kind.at name ;
      to = mkAdv kind.to name
    } ;

  NPPerson : Type = {name : NP ; isPron : Bool ; poss : Quant} ;

  relativePerson : GNumber -> CN -> (Num -> NP -> CN -> NP) -> NPPerson -> NPPerson = 
    \n,x,f,p -> 
      let num = if_then_else Num n plNum sgNum in {
      name = case p.isPron of {
        True => mkNP p.poss num x ;
        _    => f num p.name x
        } ;
      isPron = False ;
      poss = mkQuant he_Pron -- not used because not pron
      } ;

  GNumber : PType = Bool ;
  sing = False ; plur = True ;

-- for languages without GenNP, use "the wife of p"
  mkRelative : Bool -> CN -> NPPerson -> NPPerson = \n,x,p ->
    relativePerson n x 
      (\a,b,c -> mkNP (mkNP the_Quant a c) (Syntax.mkAdv possess_Prep b)) p ;

-- for languages with GenNP, use "p's wife"
--   relativePerson n x (\a,b,c -> mkNP (GenNP b) a c) p ;

}
