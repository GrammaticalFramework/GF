--# -path=.:prelude

resource LexEng = open SyntaxEng, MorphoEng, Prelude in {

  oper

  -- constructors for open lexicon

    mkN   : (man,men : Str) -> CN ;
    regN  : (car     : Str) -> CN ;

    mkA   : (hot : Str) -> AP ;

    mkV   : (go,goes : Str) -> V ;
    regV  : (walk    : Str) -> V ;

    mkV2  : (look : V) -> (at : Str) -> V2 ;
    dirV2 : (eat  : V)               -> V2 ;

  --------------------------------------------
  -- definitions, hidden from users

    mkN x y = mkNoun x y ** {lock_CN = <>} ;
    regN x  = regNoun x  ** {lock_CN = <>} ;

    mkA x = ss x ** {lock_AP = <>} ;

    mkV x y = mkVerb x y ** {lock_V = <>} ;
    regV x  = regVerb x  ** {lock_V = <>} ;

    mkV2 x p = x ** {c = p ; lock_V2 = <>} ;
    dirV2 x = mkV2 x [] ;

}
