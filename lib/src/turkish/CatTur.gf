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
    Prep = Compl ;

    Numeral = {s : CardOrd => Number => Case => Str ; n : Number} ;
    Digits  = {s : CardOrd => Number => Case => Str ; n : Number; tail : DTail} ;

-- Open lexical classes, e.g. Lexicon
    V, VS, VQ, VA = Verb ;
    V2, V2Q, V2V, V2A, V2S = Verb ** {c : Compl} ;
    V3 = Verb ** {c1,c2 : Compl} ;

    A = Adjective ;
    A2 = Adjective ** {c : Compl} ;

    N  = Noun ;
    N2 = Noun ** {c : Compl} ;
    N3 = Noun ** {c1,c2 : Compl} ;
    PN = Noun ;
}
