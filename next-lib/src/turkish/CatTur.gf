concrete CatTur of Cat = CommonX ** open ResTur, Prelude in {

  flags optimize=all_subs ;

  lincat

-- Noun
    CN = {s : Number => Case => Str} ;
    NP = {s : Case => Str ; a : Agr} ;
    Pron = ResTur.Pron ;
    Det = {s : Str; n : Number} ;
    Num  = {s : Str; n : Number} ;
    Quant = {s : Str} ;

-- Open lexical classes, e.g. Lexicon
    V, VS, VQ, VA = Verb ;
    N  = Noun ;
    N2 = Noun ;
}
