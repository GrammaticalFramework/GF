resource AdjParadigmsBul = open
  (Predef=Predef),
  Prelude,
  MorphoBul,
  CatBul
  in {
oper
  mkA76 : Str -> A =
    \nov -> mkAdjective nov
                        (nov+"ия")
                        (nov+"ият")
                        (nov+"а")
                        (nov+"ата")
                        (nov+"о")
                        (nov+"ото")
                        (nov+"и")
                        (nov+"ите")
            ** {lock_A = <>} ;
  mkA77 : Str -> A =
    \vish -> mkAdjective vish
                         (vish+"ия")
                         (vish+"ият")
                         (vish+"а")
                         (vish+"ата")
                         (vish+"е")
                         (vish+"ето")
                         (vish+"и")
                         (vish+"ите")
             ** {lock_A = <>} ;
  mkA78 : Str -> A =
    \bylgarski -> 
             let bylgarsk = init bylgarski
             in mkAdjective bylgarski
                            (bylgarsk+"ия")
                            (bylgarsk+"ият")
                            (bylgarsk+"а")
                            (bylgarsk+"ата")
                            (bylgarsk+"о")
                            (bylgarsk+"ото")
                            (bylgarsk+"и")
                            (bylgarsk+"ите")
                ** {lock_A = <>} ;
  mkA79 : Str -> A =
    \silen -> let siln : Str = case silen of { sil+"ен" => sil+"н" }
              in mkAdjective silen
                             (siln+"ия")
                             (siln+"ият")
                             (siln+"а")
                             (siln+"ата")
                             (siln+"о")
                             (siln+"ото")
                             (siln+"и")
                             (siln+"ите")
                 ** {lock_A = <>} ;
  mkA80 : Str -> A =
    \dobyr -> let dobr : Str = case dobyr of { dob+"ъ"+r@("ш"|"р"|"л"|"к"|"г"|"в") => dob+r }
              in mkAdjective dobyr
                             (dobr+"ия")
                             (dobr+"ият")
                             (dobr+"а")
                             (dobr+"ата")
                             (dobr+"о")
                             (dobr+"ото")
                             (dobr+"и")
                             (dobr+"ите")
                 ** {lock_A = <>} ;
  mkA81 : Str -> A =
    \bial ->  let bel : Str = ia2e bial
              in mkAdjective bial
                             (bel+"ия")
                             (bel+"ият")
                             (bial+"а")
                             (bial+"ата")
                             (bial+"о")
                             (bial+"ото")
                             (bel+"и")
                             (bel+"ите")
                 ** {lock_A = <>} ;
  mkA82 : Str -> A =
    \ostrowryh -> let ostrowyrh : Str = case ostrowryh of { ostrow+"ръ"+h@("з"|"х"|"б") => ostrow+"ър"+h }
                  in mkAdjective ostrowryh
                                 (ostrowyrh+"ия")
                                 (ostrowyrh+"ият")
                                 (ostrowyrh+"а")
                                 (ostrowyrh+"ата")
                                 (ostrowyrh+"о")
                                 (ostrowyrh+"ото")
                                 (ostrowyrh+"и")
                                 (ostrowyrh+"ите")
                     ** {lock_A = <>} ;
  mkA82а : Str -> A =
    \dyrzyk -> let dryzk : Str = case dyrzyk of { d+"ързък" => d+"ръзк" }
                  in mkAdjective dyrzyk
                                 (dryzk+"ия")
                                 (dryzk+"ият")
                                 (dryzk+"а")
                                 (dryzk+"ата")
                                 (dryzk+"о")
                                 (dryzk+"ото")
                                 (dryzk+"и")
                                 (dryzk+"ите")
                     ** {lock_A = <>} ;
  mkA83 : Str -> A =
    \riadyk ->let riadk : Str = case riadyk of { riad+"ък" => riad+"к"}
              in mkAdjective riadyk
                             (ia2e riadk+"ия")
                             (ia2e riadk+"ият")
                             (riadk+"а")
                             (riadk+"ата")
                             (riadk+"о")
                             (riadk+"ото")
                             (ia2e riadk+"и")
                             (ia2e riadk+"ите")
                 ** {lock_A = <>} ;
  mkA84 : Str -> A = 
    \veren -> let viarn : Str = case veren of { v + "е" + r@("д"|"з"|"н"|"р"|"с"|"т")+"ен" => v+"я"+r+"н" }
              in mkAdjective veren
                             (ia2e viarn+"ия")
                             (ia2e viarn+"ият")
                             (viarn+"а")
                             (viarn+"ата")
                             (viarn+"о")
                             (viarn+"ото")
                             (ia2e viarn+"и")
                             (ia2e viarn+"ите")
                 ** {lock_A = <>} ;
  mkA84а : Str -> A =
    \svesten ->
              let sviastn : Str = case svesten of { sv + "естен" => sv+"ястн" }
              in mkAdjective svesten
                             (ia2e sviastn+"ия")
                             (ia2e sviastn+"ият")
                             (sviastn+"а")
                             (sviastn+"ата")
                             (sviastn+"о")
                             (sviastn+"ото")
                             (ia2e sviastn+"и")
                             (ia2e sviastn+"ите")
                 ** {lock_A = <>} ;
  mkA85 : Str -> A =
    \stroen ->
              let stroin : Str = case stroen of { stro + "ен" => stro+"йн" }
              in mkAdjective stroen
                             (stroin+"ия")
                             (stroin+"ият")
                             (stroin+"а")
                             (stroin+"ата")
                             (stroin+"о")
                             (stroin+"ото")
                             (stroin+"и")
                             (stroin+"ите")
                 ** {lock_A = <>} ;
  mkA86 : Str -> A =
    \sin ->   mkAdjective sin
                          (sin+"ия")
                          (sin+"ият")
                          (sin+"я")
                          (sin+"ята")
                          (sin+"ьо")
                          (sin+"ьото")
                          (sin+"и")
                          (sin+"ите")
              ** {lock_A = <>} ;
  mkA87 : Str -> A =
    \ovchi -> let ovch : Str = case ovchi of { ovch+"и" => ovch }
              in mkAdjective ovchi
                             (ovch+"ия")
                             (ovch+"ият")
                             (ovch+"а")
                             (ovch+"ата")
                             (ovch+"е")
                             (ovch+"ето")
                             (ovch+"и")
                             (ovch+"ите")
                 ** {lock_A = <>} ;
  mkA88 : Str -> A =
    \kozi ->  let koz : Str = case kozi of { koz+"и" => koz }
              in mkAdjective kozi
                             (koz+"ия")
                             (koz+"ият")
                             (koz+"я")
                             (koz+"ята")
                             (koz+"е")
                             (koz+"ето")
                             (koz+"и")
                             (koz+"ите")
                 ** {lock_A = <>} ;
}