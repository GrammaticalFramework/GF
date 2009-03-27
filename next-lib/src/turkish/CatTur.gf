concrete CatTur of Cat = CommonX ** open ResTur, Prelude in {

  flags optimize=all_subs ;

  lincat

-- Noun
    NP, Pron = {s : Case => Str ; a : Agr} ;

-- Open lexical classes, e.g. Lexicon
    V, VS, VQ, VA = Verb ;
    N = {s : Number => Case => Str} ;
}
