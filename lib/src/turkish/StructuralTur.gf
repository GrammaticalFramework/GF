--# -path=.:../abstract:../common:../../prelude

concrete StructuralTur of Structural = CatTur **
  open ResTur, ParadigmsTur in {

  flags
    optimize=all ; coding = utf8 ;

  lin
    he_Pron =
      mkPron "o" "onu" "ona" "onun" "onda" "ondan" "onlu" "onsuz" Sg P3 ;

    i_Pron  =
      mkPron "ben" "beni" "bana" "benim" "bende" "benden" "benli" "bensiz" Sg P1 ;

    it_Pron =
      mkPron "o" "onu" "ona" "onun" "onda" "ondan" "onlu" "onsuz" Sg P3 ;

    she_Pron =
      mkPron "o" "onu" "ona" "onun" "onda" "ondan" "onlu" "onsuz" Sg P3 ;

    that_Quant =
      mkQuant "o" ;

    they_Pron =
      mkPron "onlar" "onları" "onlara" "onların" "onlarda" "onlardan" "onlarlı"
             "onlarsız" Pl P3 ;

    this_Quant =
      mkQuant "bu" ;

    we_Pron =
      mkPron "biz" "bizi" "bize" "bizim" "bizde" "bizden" "bizli" "bizsiz" Pl P1 ;

    youSg_Pron =
      mkPron "sen" "seni" "sana" "senin" "sende" "senden" "senli" "sensiz" Sg P2 ;

    youPl_Pron =
      mkPron "siz" "sizi" "size" "sizin" "sizde" "sizden" "sizli" "sizsiz" Pl P2 ;

    youPol_Pron =
      mkPron "siz" "sizi" "size" "sizin" "sizde" "sizden" "sizli" "sizsiz" Pl P2 ;

    with_Prep =
      mkPrep "ile" Nom ;

    after_Prep =
      mkPrep "sonra" Ablat ;

    before_Prep =
      mkPrep "önce" Ablat ;

    above_Prep =
      mkPrep "üzerinde" Gen ;

    behind_Prep =
      mkPrep "arkasında" Gen;

    between_Prep =
      mkPrep "arasında" Gen ;

}
