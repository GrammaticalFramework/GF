concrete NounTur of Noun = CatTur ** open ResTur, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = {
      s = \\c => det.s ++ cn.s ! det.n ! c ; 
      a = agrP3 det.n
      } ;

    UsePron p = p ;

    DetQuant quant num = {
      s  = quant.s ++ num.s ;
      n  = num.n
      } ;

    NumSg = {s = []; n = Sg} ;
    NumPl = {s = []; n = Pl} ;

    DefArt = {
      s = []
      } ;
    IndefArt = {
      s = []
      } ;

    UseN n = n ;
}
