concrete NounSlv of Noun = CatSlv ** open ResSlv in {

  lin
    UseN n = {s = \\_ => n.s; g = n.g} ;

    AdjCN ap cn = {
      s = \\spec,c,n => ap.s ! spec ! cn.g ! c ! n ++ cn.s ! Indef ! c ! n ;
      g = cn.g
      } ;

}
