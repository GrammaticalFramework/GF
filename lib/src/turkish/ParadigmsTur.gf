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
               VPres   Sg P1 => harmony4 (harmony4 base "iyor" "yiyor") "im" "yim" ;
               VPres   Sg P2 => harmony4 (harmony4 base "iyor" "yiyor") "sin" "sin" ;
               VPres   Sg P3 => harmony4 base "iyor" "yiyor" ;
               VPres   Pl P1 => harmony4 (harmony4 base "iyor" "yiyor") "iz" "yiz" ;
               VPres   Pl P2 => harmony4 (harmony4 (harmony4 base "iyor" "yiyor") "sin" "sin") "iz" "yiz" ;
               VPres   Pl P3 => harmony2 (harmony4 base "iyor" "yiyor") "ler" "ler" ;
               VPast   Sg P1 => harmony4 base "dim" "dim" ;
               VPast   Sg P2 => harmony4 base "din" "din" ;
               VPast   Sg P3 => harmony4 base "di" "di" ;
               VPast   Pl P1 => harmony4 base "dik" "dik" ;
               VPast   Pl P2 => harmony4 (harmony4 base "din" "din") "iz" "yiz" ;
               VPast   Pl P3 => harmony4 base "diler" "diler" ;
               VFuture Sg P1 => harmony4 (harmony2 base "ecek" "yecek") "im" "yim" ;
               VFuture Sg P2 => harmony4 (harmony2 base "ecek" "yecek") "sin" "sin" ;
               VFuture Sg P3 => harmony2 base "ecek" "yecek";
               VFuture Pl P1 => harmony4 (harmony2 base "ecek" "yecek") "iz" "yiz" ;
               VFuture Pl P2 => harmony4 (harmony2 base "ecek" "yecek") "siniz" "siniz" ;
               VFuture Pl P3 => harmony2 (harmony2 base "ecek" "yecek") "ler" "ler" ;
               VAorist Sg P1 => harmony4 base "im" "yim" ;
               VAorist Sg P2 => harmony4 base "sin" "sin" ;
               VAorist Sg P3 => base ;
               VAorist Pl P1 => harmony4 base "iz" "yiz" ;
               VAorist Pl P2 => harmony4 (harmony4 base "sin" "sin") "iz" "yiz" ;
               VAorist Pl P3 => harmony2 base "ler" "ler" ;
               VImperative => base ;
               VInfinitive => inf
             }
       } ;  

  regN : Str -> Noun = \base -> {
    s   = \\n => table {
                   Nom     => add_number n base ;
                   Acc     => harmony4 (add_number n base) "i" "yi" ;
                   Dat     => harmony2 (add_number n base) "e" "ye" ;
                   Gen     => harmony4 (add_number n base) "in" "nin" ;
                   Loc     => harmony2 (add_number n base) "de" "de" ;
                   Ablat   => harmony2 (add_number n base) "den" "den" ;
                   Abess p => case p of {
                                Pos => harmony4 (add_number n base) "li" "li" ;
                                Neg => harmony4 (add_number n base) "siz" "siz"
                              }
                 } ;
    gen = \\n => table {
                   {n=Sg; p=P1} => harmony4 (add_number n base) "im" "yim" ;
                   {n=Sg; p=P2} => harmony4 (add_number n base) "in" "yin" ;
                   {n=Sg; p=P3} => harmony4 (add_number n base) "i" "yi" ;
                   {n=Pl; p=P1} => harmony4 (add_number n base) "imiz" "yimiz" ;
                   {n=Pl; p=P2} => harmony4 (add_number n base) "iniz" "yiniz" ;
                   {n=Pl; p=P3} => harmony4 (add_number n base) "i" "yi"
                 }
    } ;
}