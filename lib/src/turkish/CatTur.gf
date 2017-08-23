--# -path=.:../abstract:../common:../../prelude

concrete CatTur of Cat = CommonX ** open ResTur, Prelude in {

  flags optimize=all_subs ;

  lincat

    -- Noun
    CN = {s : Number => Case => Str; gen : Number => Agr => Str} ;
    NP = {s : Case => Str ; a : Agr} ;
    VP = Verb ;
    VPSlash = VP ** {c : Prep} ;

    Pron = ResTur.Pron ;
    Det = {s : Str; n : Number; useGen : UseGen} ;
    Num  = {s : Number => Case => Str; n : Number} ;
    Card = {s : Number => Case => Str} ;
    Ord  = {s : Number => Case => Str} ;
    Quant = {s : Str; useGen : UseGen} ;
    Prep = {s : Str; c : Case} ;
    PrepNP = {s : Str} ;

    Numeral = {s : CardOrd => Number => Case => Str ; n : Number} ;
    Digits  = {s : CardOrd => Number => Case => Str ; n : Number; tail : DTail} ;

    -- Adjective
    AP = {s : Number => Case => Str} ;

    -- Open lexical classes, e.g. Lexicon
    V, VS, VQ, VA = Verb ;
    V2, V2Q, V2V, V2A, V2S = Verb ** {c : Prep} ;
    V3 = Verb ** {c1,c2 : Prep} ;

    A = Adjective ;
    A2 = Adjective ** {c : Prep} ;

    N  = Noun ;
    N2 = Noun ** {c : Prep} ;
    N3 = Noun ** {c1,c2 : Prep} ;
    PN = Noun ;
}
