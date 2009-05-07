--# -path=.:../abstract:../common:../../prelude

resource ResTur = ParamX ** open Prelude, Predef in {

--2 For $Noun$

  flags
    coding=utf8 ;

  param
    Case = Nom | Acc | Dat | Gen | Loc | Ablat | Abess Polarity ;

    Species = Indef | Def ;

  oper
    Agr = {n : Number ; p : Person} ;
    Noun = {s : Number => Case => Str; gen : Number => Agr => Str} ;
    Pron = {s : Case => Str; a : Agr} ;

    agrP3 : Number -> Agr ;
    agrP3 n = {n = n; p = P3} ;

-- For $Verb$.

  param
    VForm = 
       VPres      Number Person
     | VPast      Number Person
     | VFuture    Number Person
     | VAorist    Number Person
     | VImperative
     | VInfinitive
     ;

  oper
    Verb : Type = {
      s : VForm => Str
      } ;

--2 For $Numeral$
  param
    DForm = unit | ten ;

-- For $Numeral$.
  oper
    mkNum : Str -> Str -> {s : DForm => Str} = 
      \two, twenty ->
      {s = table {
         unit => two ; 
         ten  => twenty
         }
      } ;
      
    mkPron : (ben,beni,bana,banin,bende,benden:Str) -> Number -> Person -> Pron =
     \ben,beni,bana,benim,bende,benden,n,p -> {
     s = table {
       Nom => ben ;
       Acc => beni ;
       Dat => bana ;
       Gen => benim ;
       Loc => bende ;
       Abl => benden
       } ;
     a = {n=n; p=p} ;
     } ;

  oper
    harmony4 : Str -> Str -> Str
      = \base0,suffix0 ->
          let buffer : Str =
                case dp 1 base0 + take 1 suffix0 of {
                  ("ı"|"a"|"i"|"e"|"u"|"o"|"ü"|"ö")+("ı"|"a"|"i"|"e"|"u"|"o"|"ü"|"ö") => "y" ;
                  _                                                                   => ""
                } ;
              h : Str =
               case base0 of {
                 _+c@("ı"|"a"|"i"|"e"|"u"|"o"|"ü"|"ö")+
                 ("b"|"v"|"d"|"z"|"j"|"c"|"g"|"ğ"|"l"|"r"|"m"|"n"|"y"|"p"|"f"|"t"|"s"|"ş"|"ç"|"k"|"h")* => 
                    case c of {
                      ("ı"|"a") => "ı" ;
                      ("i"|"e") => "i" ;
                      ("u"|"o") => "u" ;
                      ("ü"|"ö") => "ü"
                    } ;
                 _ => error ("harmony4")
               } ;
              base : Str =
                case dp 1 base0 + take 1 suffix0 of {
                  ("k")+("ı"|"a"|"i"|"e"|"u"|"o"|"ü"|"ö") => tk 1 base0 + "ğ" ;
                  _                                       => base0
                } ;
              suffix : Str = 
               case suffix0 of {
                  s1@(("b"|"v"|"d"|"z"|"j"|"c"|"g"|"ğ"|"l"|"r"|"m"|"n"|"y"|"p"|"f"|"t"|"s"|"ş"|"ç"|"k"|"h")*)
                 +   ("ı"|"i"|"u"|"ü")
                 +s2 => s1+h+s2 ;
                 s => s
               }
          in base + buffer + suffix ;

    harmony2 : Str -> Str -> Str
      = \base,suffix0 ->
          let buffer : Str =
                case dp 1 base + take 1 suffix0 of {
                  ("ı"|"a"|"i"|"e"|"u"|"o"|"ü"|"ö")+("ı"|"a"|"i"|"e"|"u"|"o"|"ü"|"ö") => "n" ;
                  _                                                                   => ""
                } ;
              h : Str =
               case base of {
                 _+c@("ı"|"a"|"i"|"e"|"u"|"o"|"ü"|"ö")+
                 ("b"|"v"|"d"|"z"|"j"|"c"|"g"|"ğ"|"l"|"r"|"m"|"n"|"y"|"p"|"f"|"t"|"s"|"ş"|"ç"|"k"|"h")* =>
                    case c of {
                      ("a"|"ı"|"u"|"o") => "a" ;
                      ("e"|"i"|"ü"|"ö") => "e"
                    } ;
                 _ => error "harmony2"
               } ;
              suffix1 : Str = 
               case suffix0 of {
                  s1@(("b"|"v"|"d"|"z"|"j"|"c"|"g"|"ğ"|"l"|"r"|"m"|"n"|"y"|"p"|"f"|"t"|"s"|"ş"|"ç"|"k"|"h")*)
                 +   ("a"|"e")
                 +s2 => s1+h+s2 ;
                 s => s
               } ;
              suffix : Str =
                case dp 1 base + take 1 suffix1 of {
                  ("ç"|"p"|"ş"|"k"|"f")+("d") => "t"+drop 1 suffix1 ;
                  _                           => suffix1
                } ;
          in base + buffer + suffix ;
}
