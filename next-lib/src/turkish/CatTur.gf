concrete CatTur of Cat = CommonX ** open ResTur, Prelude in {

  flags optimize=all_subs ;

  lincat

-- Noun
    NP = {s : Case => Str ; a : Agr} ;
    Pron = ResTur.Pron ;

-- Open lexical classes, e.g. Lexicon
    V, VS, VQ, VA = Verb ;
    N  = Noun ;
    N2 = Noun ;
}
