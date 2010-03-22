--# -path=.:../abstract:../common:../../prelude

concrete CatTur of Cat = CommonX ** open ResTur, Prelude in {

  flags optimize=all_subs ;

  lincat

-- Noun
    CN = {s : Number => Case => Str} ;
    NP = {s : Case => Str ; a : Agr} ;

    Pron = ResTur.Pron ;
    Det = {s : Str; n : Number} ;
    Num  = {s : Number => Case => Str; n : Number} ;
    Card = {s : Number => Case => Str} ;
    Ord  = {s : Number => Case => Str} ;
    Quant = {s : Str} ;
    Prep = {s : Str} ;

    Numeral = {s : CardOrd => Number => Case => Str ; n : Number} ;
    Digits  = {s : CardOrd => Number => Case => Str ; n : Number; tail : DTail} ;

-- Open lexical classes, e.g. Lexicon
    V, VS, VQ, VA = Verb ;
    V2, V2Q, V2V, V2A, V2S = Verb ** {c : Case; p : Prep} ;
    V3 = Verb ** {c1 : Case; p1 : Prep; c2 : Case; p2 : Prep} ;

    A = Adjective ;
    A2 = Adjective ** {c : Case; p : Prep} ;

    N  = Noun ;
    N2 = Noun ** {c : Case} ;
    N3 = Noun ** {c1 : Case; c2 : Case} ;
    PN = Noun ;
}