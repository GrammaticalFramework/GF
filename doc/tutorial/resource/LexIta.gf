--# -path=.:prelude

resource LexIta = open SyntaxIta, MorphoIta, Prelude in {

  oper

  -- constructors for genders

    Gender : Type ;
    masculine, feminine : Gender ;

  -- constructors for open lexicon

    mkN   : Gender -> (vino,vini : Str) -> CN ;
    regN  : (vino : Str) -> CN ;
    femN  : CN -> CN ;

    mkA   : (nero,nera,neri,nere : Str) -> AP ;
    regA  : (nero : Str) -> AP ;

    mkV   : (ama,amano : Str) -> V ;
    regV  : (amare : Str) -> V ;

    mkV2  : (aspettare : V) -> (a : Str) -> V2 ;
    dirV2 : (mangiare  : V)              -> V2 ;

  --------------------------------------------
  -- definitions, hidden from users

    Gender = MorphoIta.Gender ;
    masculine = Masc ;
    feminine = Fem ;

    mkN g x y = mkNoun g x y ** {lock_CN = <>} ;
    regN x  = regNoun x  ** {lock_CN = <>} ;

    mkA x y z u = mkAdjective x y z u ** {lock_AP = <>} ;
    regA x = regAdjective x ** {lock_AP = <>} ;

    mkV x y = mkVerb x y ** {lock_V = <>} ;
    regV x  = regVerb x  ** {lock_V = <>} ;

    mkV2 x p = x ** {c = p ; lock_V2 = <>} ;
    dirV2 x = mkV2 x [] ;

}
