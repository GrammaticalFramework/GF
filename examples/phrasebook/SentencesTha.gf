concrete SentencesTha of Sentences = NumeralTha ** open
    (R = ResTha),
    (S = StringsTha),
    Prelude
  in {
  lincat
    Phrase = SS ;
--    Word = Text ;
--    Message = Text ;
    Greeting = SS ;
    Sentence = SS ;
    Question = SS ;
    Proposition = R.Clause ;
    Item = SS ;
    Kind = R.Noun ;

    MassKind = SS ; --
    Quality = R.Adj ;
    Property = R.Adj ;
    Object = R.NP ;
    PrimObject = R.NP ;
{-
    Place = NPPlace ; -- {name : NP ; at : Adv ; to : Adv} ;
    PlaceKind = CNPlace ; -- {name : CN ; at : Prep ; to : Prep} ;
    Currency = CN ;
    Price = NP ;
-}
    Action = R.Clause ;
    Person = R.NP ;
{-
    Nationality = NPNationality ; -- {lang : NP ; country : NP ; prop : A} ; 
    Language = NP ;
    Citizenship = A ;
    Country = NP ;
    Day = NPDay ; -- {name : NP ; point : Adv ; habitual : Adv} ;
    Date = Adv ;
    Name = NP ;
-}
    Number = SS ;
{-
    ByTransport = Adv ;
    Transport = {name : CN ; by : Adv} ;
    Superlative = Det ;
-}
  lin
    MPhrase p = p ;
--    MContinue p m = mkText p m ;

    PSentence s = s ;
    PQuestion q = q ;

    PGreeting g = g ;

    PWord w = w ;

    PNumber x = x ;
{-
    PPrice x = mkSentence (mkUtt x) ;

    PObject x = mkPhrase (mkUtt x) ;
    PKind x = mkPhrase (mkUtt x) ;
    PMassKind x = mkPhrase (mkUtt x) ;
    PQuality x = mkPhrase (mkUtt x) ;
    PPlace x = mkPhrase (mkUtt x.name) ;
    PPlaceKind x = mkPhrase (mkUtt x.name) ;
    PCurrency x = mkPhrase (mkUtt x) ;
    PLanguage x = mkPhrase (mkUtt x) ;
    PCountry x = mkPhrase (mkUtt x) ;
    PCitizenship x = mkPhrase (mkUtt (mkAP x)) ;
    PDay d = mkPhrase (mkUtt d.name) ;
    PTransport t = mkPhrase (mkUtt t.name) ;
    PByTransport t = mkPhrase (mkUtt t) ;
-}
    PYes = ss S.chay_s ;
    PNo = ss S.may_s ;
    PYesToNo = ss S.chay_s ; ----

--    GObjectPlease o = lin Text (mkPhr noPConj (mkUtt o) please_Voc) ;

    Is np q = R.mkClause np (R.adjVP q) ;
    IsMass m q = R.mkClause m (R.adjVP q) ;

    SProp p = ss (p.s ! R.ClDecl ! R.Pos) ;
    SPropNot p = ss (p.s ! R.ClDecl ! R.Neg) ;
    QProp p = ss (p.s ! R.ClQuest ! R.Pos) ;

--    WherePlace place = mkQS (mkQCl where_IAdv place.name) ;
--    WherePerson person = mkQS (mkQCl where_IAdv person.name) ;

    PropAction a = a ;

--    AmountCurrency num curr = mkNP num curr ;

    ObjItem i = i ;
{-
    ObjNumber n k = mkNP n k ;
    ObjIndef k = mkNP a_Quant k ;
    ObjPlural k = mkNP aPl_Det k ;
    ObjMass k = mkNP k ;
    ObjAndObj = mkNP and_Conj ;
-}
    OneObj o = o ; 

    This kind = ss (R.thbind kind.s S.nii_s) ;
    That kind = ss (R.thbind kind.s S.nan_s) ;
{-
    These kind = mkNP this_Quant plNum kind ;
    Those kind = mkNP that_Quant plNum kind ;
    The kind = mkNP the_Quant kind ;
    Thes kind = mkNP the_Quant plNum kind ;
-}
    ThisMass kind = ss (R.thbind kind.s S.nii_s) ;
    ThatMass kind =  ss (R.thbind kind.s S.nan_s) ;
    TheMass kind = kind ;

    SuchKind quality kind = {s = R.thbind kind.s quality.s ; c = kind.c} ; 
    SuchMassKind quality kind = {s = R.thbind kind.s quality.s ; c = kind.c} ; 


    Very property = ss (R.thbind property.s S.mak_s) ;
--    Too property = ss (property.s ++ mak_s) ;
    PropQuality property = property ;

{-
    ThePlace kind = let dd = if_then_else Det kind.isPl thePl_Det theSg_Det 
                     in placeNP dd kind ;
    APlace kind = let dd = if_then_else Det kind.isPl aPl_Det aSg_Det 
                     in placeNP dd kind ;
-}

    IMale = ss S.phom_s ;
    IFemale = ss (R.thbind S.di_s S.chan_s) ;
    YouFamMale,
    YouFamFemale, 
    YouPolMale, YouPolFemale = ss S.khun_s ; ---- there are degrees

{-
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
-}
    NNumeral n = n ;
{-
    SHave   p obj = mkS (mkCl p.name have_V2 obj) ;
    SHaveNo p k = mkS negativePol (mkCl p.name have_V2 (mkNP aPl_Det k)) ;
    SHaveNoMass p m = mkS negativePol (mkCl p.name have_V2 (mkNP m)) ;
    QDoHave p obj = mkQS (mkQCl (mkCl p.name have_V2 obj)) ;

    AHaveCurr p curr = mkCl p.name have_V2 (mkNP aPl_Det curr) ;
    ACitizen p n = mkCl p.name n ;
    ABePlace p place = mkCl p.name place.at ;
    ByTransp t = t.by ;

    AKnowSentence p s = mkCl p.name Lexicon.know_VS s ;
    AKnowQuestion p s = mkCl p.name Lexicon.know_VQ s ;
    AKnowPerson p q = mkCl p.name Lexicon.know_V2 q.name ;

oper 

-- These operations are used internally in Sentences.

  mkPhrase : Utt -> Text = \u -> lin Text u ; -- no punctuation
-}
oper
  mkGreeting : Str -> SS = ss ; 
{-
  mkSentence : Utt -> Text = \t -> lin Text (postfixSS "." t | t) ; -- optional .

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
  CNPlace : Type = {name : CN ; at : Prep ; to : Prep; isPl : Bool} ;

  mkCNPlace : CN -> Prep -> Prep -> CNPlace = \p,i,t -> {
    name = p ;
    at = i ;
    to = t ;
    isPl = False
    } ;

 mkCNPlacePl : CN -> Prep -> Prep -> CNPlace = \p,i,t -> {
    name = p ;
    at = i ;
    to = t ;
    isPl = True
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
-}

}
