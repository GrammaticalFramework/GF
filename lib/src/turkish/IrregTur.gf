--# -path=.:../abstract:../common:../../prelude

-- (c) 2009 Server Çimen under LGPL

concrete IrregTur of IrregTurAbs = CatTur ** open ParadigmsTur, ResTur in {

  flags
    optimize=values ;
    coding=utf8 ;

  lin
    eat_V = mkV "yemek" "yemek" "yimek" ;
    fear_V = mkV "korkmak" ;
    fight_V = mkV "dövüşmek" ; --suça karşı / suçla savaşmak
    find_V = mkV "bulmak" SgSylConIrreg ;
    hate_V = mkV "nefret" et_Aux ;
    hit_V = mkV "vurmak" SgSylConIrreg ;
    know_V = mkV "bilmek" SgSylConIrreg ;
    leave_V = mkV "ayrılmak";
    like_V = mkV "hoşlanmak";
    see_V = mkV "görmek" SgSylConIrreg ;

  oper
    et_Aux        : V = mkV "etmek" "edmek" ;
    et_Hard_Aux   : V = mkV "etmek" ;
    soyle_Aux     : V = mkV "söylemek" ;
    ol_Aux        : V = mkV "olmak" SgSylConIrreg ;
    koy_Aux       : V = mkV "koymak" ;
    gec_Aux       : V = mkV "geçmek" ;
    against_Prep  : Prep = mkPrep "karşı" Dat;
}
