concrete ConjunctionChi of Conjunction = CatChi ** open ResChi, Prelude, Coordination in {

  lin

    ConjS c = conjunctDistrSS (c.s ! CSent) ;
    ConjAdv c as = conjunctDistrSS (c.s ! CSent) as ** {advType = as.advType ; hasDe = as.hasDe} ; ---- ??
    ConjNP c = conjunctDistrSS (c.s ! CPhr CNPhrase) ;
    ConjAP c as = conjunctDistrSS (c.s ! CPhr CAPhrase) as ** {monoSyl = notB as.monoSyl ; hasAdA = True} ; ---- add de iff as doesn't
    ConjRS c = conjunctDistrSS (c.s ! CSent) ;
    ConjCN c ns = conjunctDistrSS (c.s ! CPhr CNPhrase) ns ** {c = ns.c} ; 

-- These fun's are generated from the list cat's.

    BaseS = twoSS ;
    ConsS = consrSS duncomma ;
    BaseAdv x y = twoSS x y ** {advType = x.advType ; hasDe = y.hasDe} ; ---- ??
    ConsAdv x xs = consrSS duncomma x xs ** {advType = x.advType ; hasDe = xs.hasDe} ; ---- ??
    BaseNP = twoSS ;
    ConsNP = consrSS duncomma ;
    BaseAP x y = twoSS x y ** {monoSyl = y.monoSyl} ;
    ConsAP x xs = consrSS duncomma x xs ** {monoSyl = xs.monoSyl} ;
    BaseRS = twoSS ;
    ConsRS = consrSS duncomma ;
    BaseCN x y = twoSS x y ** {c = x.c} ;  --- classified comes from first part ; should it rather be ge?
    ConsCN x xs = consrSS duncomma x xs ** {c = x.c} ;

  lincat
    [S] = {s1,s2 : Str} ;
    [Adv] = {s1,s2 : Str ; advType : AdvType ; hasDe : Bool} ;
    [NP] = {s1,s2 : Str} ;
    [AP] = {s1,s2 : Str ; monoSyl : Bool} ;
    [RS] = {s1,s2 : Str} ;
    [CN] = {s1,s2 : Str ; c : Str} ;


}
