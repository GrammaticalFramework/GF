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
    harmony4 : Str -> Str -> Str -> Str
      = \base0,suffixC,suffixV ->
          let h : Str =
               case base0 of {
                 _+c@("ı"|"a"|"i"|"e"|"u"|"o"|"ü"|"ö")+
                 ("b"|"v"|"d"|"z"|"j"|"c"|"g"|"ğ"|"l"|"r"|"m"|"n"|"y"|"p"|"f"|"t"|"s"|"ş"|"ç"|"k"|"h")* => 
                    case c of {
                      ("ı"|"a") => "ı" ;
                      ("i"|"e") => "i" ;
                      ("u"|"o") => "u" ;
                      ("ü"|"ö") => "ü"
                    } ;
                 _ => error "harmony4"
               } ;
              base : Str =
                case dp 1 base0 + take 1 suffixC of {
                  ("k")+("ı"|"a"|"i"|"e"|"u"|"o"|"ü"|"ö") => tk 1 base0 + "ğ" ;
                  _                                       => base0
                } ;
              suffix : Str =
                case dp 1 base0 of {
                  ("ı"|"a"|"i"|"e"|"u"|"o"|"ü"|"ö") => case suffixV of {
                                                         s1@("b"|"v"|"d"|"z"|"j"|"c"|"g"|"ğ"|"l"|"r"|"m"|"n"|"y"|"p"|"f"|"t"|"s"|"ş"|"ç"|"k"|"h")
                                                         +   ("ı"|"i"|"u"|"ü")
                                                         +s2 => s1+h+s2 ;
                                                         s   => s
                                                       } ;
                  _                                 => case suffixC of {
                                                         s1@(("b"|"v"|"d"|"z"|"j"|"c"|"g"|"ğ"|"l"|"r"|"m"|"n"|"y"|"p"|"f"|"t"|"s"|"ş"|"ç"|"k"|"h")*)
                                                         +   ("ı"|"i"|"u"|"ü")
                                                         +s2 => s1+h+s2 ;
                                                         s   => s
                                                       }
                }
          in base + suffix ;

    harmony2 : Str -> Str -> Str -> Str
      = \base0,suffixC,suffixV ->
          let h : Str =
               case base0 of {
                 _+c@("ı"|"a"|"i"|"e"|"u"|"o"|"ü"|"ö")+
                 ("b"|"v"|"d"|"z"|"j"|"c"|"g"|"ğ"|"l"|"r"|"m"|"n"|"y"|"p"|"f"|"t"|"s"|"ş"|"ç"|"k"|"h")* =>
                    case c of {
                      ("a"|"ı"|"u"|"o") => "a" ;
                      ("e"|"i"|"ü"|"ö") => "e"
                    } ;
                 _ => error "harmony2"
               } ;
              base : Str =
                case dp 1 base0 + take 1 suffixC of {
                  ("k")+("ı"|"a"|"i"|"e"|"u"|"o"|"ü"|"ö") => tk 1 base0 + "ğ" ;
                  _                                       => base0
                } ;
              suffix : Str =
                case dp 1 base0 of {
                  ("ı"|"a"|"i"|"e"|"u"|"o"|"ü"|"ö") => case suffixV of {
                                                         s1@("b"|"v"|"d"|"z"|"j"|"c"|"g"|"ğ"|"l"|"r"|"m"|"n"|"y"|"p"|"f"|"t"|"s"|"ş"|"ç"|"k"|"h")
                                                         +  ("a"|"e")
                                                         +s2 => s1+h+s2 ;
                                                         s   => s
                                                       } ;
                  ("p"|"f"|"t"|"s"|"ş"|"ç"|"k"|"h") => case suffixC of {
                                                         s1@(("b"|"v"|"z"|"j"|"c"|"g"|"ğ"|"l"|"r"|"m"|"n"|"y"|"p"|"f"|"t"|"s"|"ş"|"ç"|"k"|"h")*)
                                                         +  ("a"|"e")
                                                         +s2 => s1+h+s2 ;
                                                         ("da"|"de")+s => "t"+h+s ;
                                                         s => s
                                                       } ;
                  _                                 => case suffixC of {
                                                         s1@(("b"|"v"|"d"|"z"|"j"|"c"|"g"|"ğ"|"l"|"r"|"m"|"n"|"y"|"p"|"f"|"t"|"s"|"ş"|"ç"|"k"|"h")*)
                                                         +  ("a"|"e")
                                                         +s2 => s1+h+s2 ;
                                                         s   => s
                                                       }
                }
          in base + suffix ;

    add_number : Number -> Str -> Str = \n,base ->
      case n of {
        Sg => base ;
        Pl => harmony2 base "ler" "ler"
      } ;
}
