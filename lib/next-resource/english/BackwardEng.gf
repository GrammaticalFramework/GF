concrete BackwardEng of Backward = CatEng ** open ResEng in {

  flags optimize=all_subs ;

  lin

-- A repository of obsolete constructs, needed for backward compatibility.
-- They create spurious ambiguities if used in combination with Lang.

-- from Verb 19/4/2008

    ComplV2 v np = insertObj (\\_ => v.c2 ++ np.s ! Acc) (predV v) ;
    ComplV3 v np np2 = 
      insertObj (\\_ => v.c2 ++ np.s ! Acc ++ v.c3 ++ np2.s ! Acc) (predV v) ;
    ComplV2V v np vp = 
      insertObj (\\a => infVP v.isAux vp a)
        (insertObj (\\_ => v.c2 ++ np.s ! Acc) (predV v)) ;
    ComplV2S v np s = 
      insertObj (\\_ => conjThat ++ s.s)
        (insertObj (\\_ => v.c2 ++ np.s ! Acc) (predV v)) ;
    ComplV2Q v np q = 
      insertObj (\\_ => q.s ! QIndir) 
        (insertObj (\\_ => v.c2 ++ np.s ! Acc) (predV v)) ;
    ComplV2A v np ap = 
      insertObj (\\_ => v.c2 ++ np.s ! Acc ++ ap.s ! np.a) (predV v) ;

    ReflV2 v = insertObj (\\a => v.c2 ++ reflPron ! a) (predV v) ;

-- from Sentence 19/4/2008

    SlashV2 np v2 = 
      mkClause (np.s ! Nom) np.a (predV v2) ** {c2 = v2.c2} ;

    SlashVVV2 np vv v2 = 
      mkClause (np.s ! Nom) np.a 
        (insertObj (\\a => infVP vv.isAux (predV v2) a) (predVV vv))  **
        {c2 = v2.c2} ;

-- from Noun 19/4/2008

    NumInt n = {s = n.s ; n = Pl} ; 
    OrdInt n = {s = n.s ++ "th"} ; --- DEPRECATED

    DetSg quant ord = {
      s = quant.s ! Sg ++ ord.s ; 
      n = Sg
      } ;

    DetPl quant num ord = {
      s = quant.s ! num.n ++ num.s ++ ord.s ; 
      n = num.n
      } ;

    NoNum = {s = []; n = Pl } ;

    DefArt = {s = \\_ => artDef} ;

    IndefArt = {
      s = table {
        Sg => artIndef ; 
        Pl => []
        }
      } ;

    MassDet = {s = \\_ => []} ;



-- from Structural 19/4/2008

    that_NP = regNP "that" Sg ;
    these_NP = regNP "these" Pl ;
    this_NP = regNP "this" Sg ;
    those_NP = regNP "those" Pl ;

}
