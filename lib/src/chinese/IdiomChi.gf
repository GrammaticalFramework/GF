concrete IdiomChi of Idiom = CatChi ** open Prelude, ResChi in {

  lin
    ---- formal subject, e.g. it is hot ?? now empty subject
    ImpersCl vp =  mkClause [] vp ;
    --can be empty, or ImpersCl vp =  mkClause "天" vp ; but "天" only used to describe weather(e.g. it's raining)

    ---- one wants to learn Chinese ?? now empty subject
    GenericCl vp = mkClause [] vp ;
    -- GenericCl vp = mkClause "有人" vp ; (meaning: there is a person)

    ---- it is John who did it
    CleftNP np rs = mkClause np.s copula rs.s ;

    CleftAdv ad s = mkClause ad.s (insertObj s (predV copula)) ; ---- it is here she slept

    ExistNP np = mkClause [] (regVerb you_s) np.s ; ---- infl of you

    ExistIP ip = {s = (mkClause [] (regVerb you_s) ip.s).s} ; ---- infl of you

    ProgrVP vp = vp ; ----

    ImpPl1 vp = ss (infVP vp) ; ----

}


