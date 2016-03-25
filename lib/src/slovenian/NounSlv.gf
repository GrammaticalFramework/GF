concrete NounSlv of Noun = CatSlv ** open ResSlv in {

  lin
    DetCN det cn = {
      s = \\c => det.s ! c ++ cn.s ! det.spec ! c ! det.n ; 
      a = {g=cn.g; n=det.n}
      } ;

    DetQuant quant num = {
      s    = \\c => quant.s ++ num.s ! c;
      spec = quant.spec ;
      n    = num.n ;
      } ;

    NumSg = {s = \\_ => []; n = Sg} ;
    NumPl = {s = \\_ => []; n = Pl} ;

    DefArt = {
      s    = "" ;
      spec = Def
      } ;

    IndefArt = {
      s    = "" ;
      spec = Indef
      } ;

    UseN n = {s = \\_ => n.s; g = n.g} ;

    AdjCN ap cn = {
      s = \\spec,c,n => ap.s ! spec ! cn.g ! c ! n ++ cn.s ! Indef ! c ! n ;
      g = cn.g
      } ;
}
