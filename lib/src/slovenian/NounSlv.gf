concrete NounSlv of Noun = CatSlv ** open ResSlv in {

  lin
    DetCN det cn = {
      s = \\c => det.s ! cn.g ! c ++ 
                 case det.n of {
                   UseNum n => cn.s ! det.spec ! c ! n ;
                   UseGen   => cn.s ! det.spec ! Gen ! Pl
                 } ;
      a = {g = cn.g ;
           n = case det.n of {
                 UseNum n => n ;
                 UseGen   => Pl
               } ;
           p = P3
          }
      } ;

    UsePron p = p ;

    DetQuant quant num = {
      s    = \\c,g => quant.s ++ num.s ! c ! g;
      spec = quant.spec ;
      n    = num.n ;
      } ;

    NumSg = {s = \\_,_ => []; n = UseNum Sg} ;
    NumPl = {s = \\_,_ => []; n = UseNum Pl} ;

    NumCard n = n ;

    NumNumeral numeral = {s = numeral.s; n = numeral.n} ;

    DefArt = {
      s    = "" ;
      spec = Def
      } ;

    IndefArt = {
      s    = "" ;
      spec = Indef
      } ;

    MassNP n = {
      s = \\c => n.s ! Indef ! c ! Sg ;
      a = {g=n.g; n=Sg; p=P3}
      } ;

    UseN n = {s = \\_ => n.s; g = n.g} ;

    AdjCN ap cn = {
      s = \\spec,c,n => ap.s ! spec ! cn.g ! c ! n ++ cn.s ! Indef ! c ! n ;
      g = cn.g
      } ;
    AdvCN cn ad = {s = \\spec,c,n => cn.s ! spec ! c ! n ++ ad.s ; g = cn.g} ;

}
