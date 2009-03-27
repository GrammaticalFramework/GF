--# -path=.:../abstract:../common:../../prelude

resource ResTur = ParamX ** open Prelude, Predef in {

--2 For $Noun$

  param
    Case = Nom | Acc | Dat | Gen | Loc | Ablat | Abess ;

    Species = Indef | Def ;

  oper
    Agr = {n : Number ; p : Person} ;
    Noun = {s : Number => Case => Str; gen : Number => Agr => Str} ;
    Pron = {s : Case => Str; a : Agr} ;

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
      = \base,suffix0 ->
          let c : Str = 
               case base of {
                 _+c@("ı"|"a"|"i"|"e"|"u"|"o"|"ü"|"ö")+
                 ("b"|"v"|"d"|"z"|"j"|"c"|"g"|"ğ"|"l"|"r"|"m"|"n"|"y"|"p"|"f"|"t"|"s"|"ş"|"ç"|"k"|"h")* => c ;
                 _ => error "harmony4"
               } ;
              h : Str =
               case c of {
                 ("ı"|"a") => "ı" ;
                 ("i"|"e") => "i" ;
                 ("u"|"o") => "u" ;
                 ("ü"|"ö") => "ü"
               } ;
              suffix : Str = 
               case suffix0 of {
                  s1@(("b"|"v"|"d"|"z"|"j"|"c"|"g"|"ğ"|"l"|"r"|"m"|"n"|"y"|"p"|"f"|"t"|"s"|"ş"|"ç"|"k"|"h")*)
                 +   ("ı"|"a"|"i"|"e"|"u"|"o"|"ü"|"ö")
                 +s2 => s1+h+s2 ;
                 s => s
               }
          in base + suffix ;

    harmony2 : Str -> Str -> Str
      = \base,suffix0 ->
          let c : Str = 
               case base of {
                 _+c@("ı"|"a"|"i"|"e"|"u"|"o"|"ü"|"ö")+
                 ("b"|"v"|"d"|"z"|"j"|"c"|"g"|"ğ"|"l"|"r"|"m"|"n"|"y"|"p"|"f"|"t"|"s"|"ş"|"ç"|"k"|"h")* => c ;
                 _ => error "harmony2"
               } ;
              h : Str =
               case c of {
                 ("a"|"ı"|"u"|"o") => "a" ;
                 ("e"|"i"|"ü"|"ö") => "e"
               } ;
              suffix : Str = 
               case suffix0 of {
                  s1@(("b"|"v"|"d"|"z"|"j"|"c"|"g"|"ğ"|"l"|"r"|"m"|"n"|"y"|"p"|"f"|"t"|"s"|"ş"|"ç"|"k"|"h")*)
                 +   ("ı"|"a"|"i"|"e"|"u"|"o"|"ü"|"ö")
                 +s2 => s1+h+s2 ;
                 s => s
               }
          in base + suffix ;
}
