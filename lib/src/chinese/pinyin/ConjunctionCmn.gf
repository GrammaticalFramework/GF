concrete ConjunctionCmn of Conjunction = CatCmn ** open ResCmn, Prelude, Coordination in {

  lin

    ConjS c = conjunctDistrSS (c.s ! CSent) ;
    ConjAdv c as = conjunctDistrSS (c.s ! CSent) as ** {advType = ATPlace} ; ---- ??
    ConjNP c = conjunctDistrSS (c.s ! CPhr CNPhrase) ;
    ConjAP c as = conjunctDistrSS (c.s ! CPhr CAPhrase) as ** {monoSyl = False} ;
    ConjRS c = conjunctDistrSS (c.s ! CSent) ;

-- These fun's are generated from the list cat's.

    BaseS = twoSS ;
    ConsS = consrSS thcomma ;
    BaseAdv = twoSS ;
    ConsAdv = consrSS thcomma ;
    BaseNP = twoSS ;
    ConsNP = consrSS thcomma ;
    BaseAP = twoSS ;
    ConsAP = consrSS thcomma ;
    BaseRS = twoSS ;
    ConsRS = consrSS thcomma ;

  lincat
    [S] = {s1,s2 : Str} ;
    [Adv] = {s1,s2 : Str} ;
    [NP] = {s1,s2 : Str} ;
    [AP] = {s1,s2 : Str} ;
    [RS] = {s1,s2 : Str} ;

  oper
    thcomma : Str = [] ; ---- should be a space

}
