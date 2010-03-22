--# -path=.:../abstract:../common:../../prelude

concrete NounTur of Noun = CatTur ** open ResTur, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = {
      s = \\c => det.s ++ cn.s ! det.n ! c ; 
      a = agrP3 det.n
      } ;

    UsePron p = p ;

    DetQuant quant num = {
      s  = quant.s ++ num.s ! Sg ! Nom ;
      n  = num.n
      } ;

    NumSg = {s = \\num,c => []; n = Sg} ;
    NumPl = {s = \\num,c => []; n = Pl} ;

    NumCard n = n ** {n = Sg} ;

    NumNumeral numeral = {s = numeral.s ! NCard} ;

    OrdDigits  dig = {s = \\c => dig.s ! NOrd ! c} ;
    OrdNumeral num = {s = \\c => num.s ! NOrd ! c} ;
    OrdSuperl  a = {s = \\n,c => "en" ++ a.s ! n ! c} ;

    DefArt = {
      s = []
      } ;
    IndefArt = {
      s = []
      } ;

    UseN n = n ;
}