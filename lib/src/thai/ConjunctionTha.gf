concrete ConjunctionTha of Conjunction = CatTha ** open Prelude, Coordination in {

  lin

    ConjS = conjunctDistrSS ;
    ConjAdv = conjunctDistrSS ;
    ConjNP = conjunctDistrSS ;
    ConjAP = conjunctDistrSS ;
    ConjRS = conjunctDistrSS ;

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
