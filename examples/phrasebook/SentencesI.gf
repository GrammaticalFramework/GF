incomplete concrete SentencesI of Sentences = Numeral ** 
  open
    DiffPhrasebook, 
    Syntax,
    (R = Roles),
    Prelude
  in {
  lincat
    Phrase = Text ;
    Politeness = {s : Str ; p : R.Politeness} ;
    Sentence = {s : R.Politeness => S} ; 
    Question = {s : R.Politeness => QS} ; 
    Item = NP ;
    Kind = CN ;
    Quality = AP ;
    Object = NP ;
    Place = NP ;
    PlaceKind = CN ;
    Currency = CN ;
    Price = NP ;
    Action = {s : R.Politeness => Cl} ;
    Person = {s : R.Politeness => NP} ;
    Language = NP ;
  lin
--- todo: add speaker and hearer genders
    PSentence p g = let s = g.s ! p.p in 
                    mkText (mkText s | lin Text (mkUtt s)) (lin Text (ss p.s)) ;  -- optional '.'
    PQuestion p g = let s = g.s ! p.p in 
                    mkText (mkText s | lin Text (mkUtt s)) (lin Text (ss p.s)) ;  -- optional '?'

    PObject x = mkPhrase (mkUtt x) ;
    PKind x = mkPhrase (mkUtt x) ;
    PQuality x = mkPhrase (mkUtt x) ;
    PNumeral x = mkPhrase (mkUtt (mkCard (x ** {lock_Numeral = <>}))) ;
    PPlace x = mkPhrase (mkUtt x) ;
    PPlaceKind x = mkPhrase (mkUtt x) ;
    PCurrency x = mkPhrase (mkUtt x) ;
    PPrice x = mkPhrase (mkUtt x) ;
    PLanguage x = mkPhrase (mkUtt x) ;

    Is item quality = neutralS (mkS (mkCl item quality)) ;
    IsNot item quality = neutralS (mkS negativePol (mkCl item quality)) ;
    WhetherIs item quality = neutralQS (mkQS (mkQCl (mkCl item quality))) ;
    WhereIs place = neutralQS (mkQS (mkQCl where_IAdv place)) ;

    SAction a = {s = \\p => mkS (a.s ! p)} ;
    SNotAction a = {s = \\p => mkS negativePol (a.s ! p)} ;
    QAction a = {s = \\p => mkQS (mkQCl (a.s ! p))} ;

    HowMuchCost item = neutralQS (mkQS (mkQCl how8much_IAdv (mkCl item cost_V))) ; 
    ItCost item price = neutralS (mkS (mkCl item cost_V2 price)) ;
 
    AmountCurrency num curr = mkNP <lin Numeral num : Numeral> curr ;

    ObjItem i = i ;
    ObjNumber n k = mkNP <lin Numeral n : Numeral> k ;

    This kind = mkNP this_Quant kind ;
    That kind = mkNP that_Quant kind ;
    These kind = mkNP this_Quant plNum kind ;
    Those kind = mkNP that_Quant plNum kind ;
    The kind = mkNP the_Quant kind ;
    The kind = mkNP the_Quant kind ;
    Thes kind = mkNP the_Quant plNum kind ;
    SuchKind quality kind = mkCN quality kind ;
    Very quality = mkAP very_AdA quality ;
    Too quality = mkAP too_AdA quality ;
    ThePlace kind = mkNP the_Quant kind ;

    I   = {s = \\_ => mkNP i_Pron} ;
    You = {s = table {R.PPolite => mkNP youPol_Pron ; R.PFamiliar => mkNP youSg_Pron}} ;

    Polite = {s = [] ; p = R.PPolite} ;
    Familiar = {s = [] ; p = R.PFamiliar} ;
--  Male = {s = [] ; g = R.Male} ;
--  Female = {s = [] ; g = R.Female} ;

oper 
  mkPhrase : Utt -> Text = \u -> lin Text u ; -- no punctuation

  politeS   : S -> S   -> {s : R.Politeness => S}  = \pol,fam -> 
    {s = table {R.PPolite => pol ; R.PFamiliar => fam}} ;
  neutralS  : S        -> {s : R.Politeness => S}  = \pol -> politeS pol pol ;
  politeQS  : QS -> QS -> {s : R.Politeness => QS} = \pol,fam -> 
    {s = table {R.PPolite => pol ; R.PFamiliar => fam}} ;
  neutralQS : QS       -> {s : R.Politeness => QS} = \pol -> politeQS pol pol ;
---- it would be greate to use overloading here

}
