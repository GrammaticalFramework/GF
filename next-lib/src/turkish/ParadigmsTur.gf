resource ParadigmsTur = open
  Predef,
  Prelude,
  ResTur
  in {
  
oper
  regV : Str -> Verb = \inf ->
    let base : Str
             = case inf of {
                 base+"mak" => base ;
                 base+"mek" => base
               }
    in { s = table {
               VPres   Sg P1 => harmony4 (harmony4 base "iyor") "im" ;
               VPres   Sg P2 => harmony4 (harmony4 base "iyor") "sin" ;
               VPres   Sg P3 => harmony4 base "iyor" ;
               VPres   Pl P1 => harmony4 (harmony4 base "iyor") "iz" ;
               VPres   Pl P2 => harmony4 (harmony4 (harmony4 base "iyor") "sin") "iz" ;
               VPres   Pl P3 => harmony4 (harmony4 base "iyor") "ler" ;
               VPast   Sg P1 => harmony4 base "dim" ;
               VPast   Sg P2 => harmony4 base "din" ;
               VPast   Sg P3 => harmony4 base "di" ;
               VPast   Pl P1 => harmony4 base "dik" ;
               VPast   Pl P2 => harmony4 (harmony4 base "din") "iz" ;
               VPast   Pl P3 => harmony4 base "diler" ;
               VFuture Sg P1 => harmony4 (harmony2 base "ecek") "im" ;
               VFuture Sg P2 => harmony4 (harmony2 base "ecek") "sin" ;
               VFuture Sg P3 => harmony2 base "ecek" ;
               VFuture Pl P1 => harmony4 (harmony2 base "ecek") "iz" ;
               VFuture Pl P2 => harmony4 (harmony2 base "ecek") "siniz" ;
               VFuture Pl P3 => harmony4 (harmony2 base "ecek") "ler" ;
               VAorist Sg P1 => harmony4 base "im" ;
               VAorist Sg P2 => harmony4 base "sin" ;
               VAorist Sg P3 => base ;
               VAorist Pl P1 => harmony4 base "iz" ;
               VAorist Pl P2 => harmony4 (harmony4 base "sin") "iz" ;
               VAorist Pl P3 => harmony4 base "ler" ;
               VImperative => base ;
               VInfinitive => inf
             }
       } ;  
       
  add_number : Number -> Str -> Str = \n,base ->
    case n of {
      Sg => base ;
      Pl => harmony2 base "ler"
    } ;

  regN : Str -> Noun = \base -> {
    s   = \\n => table {
                   Nom     => add_number n base ;
                   Acc     => harmony4 (add_number n base) "i" ;
                   Dat     => harmony2 (add_number n base) "e" ;
                   Gen     => harmony4 (add_number n base) "in" ;
                   Loc     => harmony2 (add_number n base) "de" ;
                   Ablat   => harmony2 (add_number n base) "den" ;
                   Abess p => case p of {
                                Pos => harmony4 (add_number n base) "li" ;
                                Neg => harmony4 (add_number n base) "siz"
                              }
                 } ;
    gen = \\n => table {
                   {n=Sg; p=P1} => harmony4 (add_number n base) "im" ;
                   {n=Sg; p=P2} => harmony4 (add_number n base) "in" ;
                   {n=Sg; p=P3} => harmony4 (add_number n base) "i" ;
                   {n=Pl; p=P1} => harmony4 (add_number n base) "imiz" ;
                   {n=Pl; p=P2} => harmony4 (add_number n base) "iniz" ;
                   {n=Pl; p=P3} => harmony4 (add_number n base) "i"
                 }
    } ;
}