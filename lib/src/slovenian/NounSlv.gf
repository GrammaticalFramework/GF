concrete NounSlv of Noun = CatSlv ** open ResSlv,Prelude in {

  lin
    DetCN det cn = {
      s = \\c => det.s ! agender2gender cn.g ! c ++ 
                 case det.n of {
                   UseNum n => cn.s ! det.spec ! c ! n ;
                   UseGen   => cn.s ! det.spec ! Gen ! Pl
                 } ;
      a = {g = agender2gender cn.g ;
           n = case det.n of {
                 UseNum n => n ;
                 UseGen   => Pl
               } ;
           p = P3
          } ;
      isPron = False
      } ;

    UsePN pn = {
      s = pn.s;
      a = {g=agender2gender pn.g; n=pn.n; p=P3};
      isPron = False
      } ;

    UsePron p = {
      s = p.s;
      a = p.a;
      isPron = True
    } ;

    DetQuant quant num = {
      s    = \\g,c => quant.s ! g ! c ! (numAgr2num ! num.n) ++ num.s ! g ! c;
      spec = quant.spec ;
      n    = num.n ;
      } ;

    DetNP det = {
      s = det.s ! Masc ;
      a = {g=Masc; n=case det.n of {UseNum n=>n; UseGen=>Pl}; p=P3} ;
      isPron = False
      } ;

    PossPron p = {
      s    = p.poss ;
      spec = Indef
      } ;

    NumSg = {s = \\_,_ => []; n = UseNum Sg} ;
    NumDl = {s = \\_,_ => []; n = UseNum Dl} ; --not working?
    NumPl = {s = \\_,_ => []; n = UseNum Pl} ;

    NumCard n = n ;

    NumNumeral numeral = {s = numeral.s; n = numeral.n} ;

    DefArt = {
      s    = \\_,_,_ => "" ;
      spec = Def
      } ;

    IndefArt = {
      s    = \\_,_,_ => "" ;
      spec = Indef
      } ;

    MassNP n = {
      s = \\c => n.s ! Indef ! c ! Sg ;
      a = {g=agender2gender n.g; n=Sg; p=P3} ;
      isPron = False
      } ;

    UseN n = {s = \\_ => n.s; g = n.g} ;

    AdjCN ap cn = {
      s = \\spec,c,n => ap.s ! spec ! cn.g ! c ! n ++ cn.s ! Indef ! c ! n ;
      g = cn.g
      } ;
    AdvCN cn ad = {s = \\spec,c,n => cn.s ! spec ! c ! n ++ ad.s ; g = cn.g} ;

}
