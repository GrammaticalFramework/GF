concrete NounBul of Noun = CatBul ** open ResBul, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = 
      { s = \\c => det.s ! cn.g ++ cn.s ! det.n ! c ! det.spec ; 
        a = agrP3 (gennum cn.g det.n)
      } ;
    UsePron p = p ;

    DetSg quant ord = {
      s = \\g => quant.s ! ASg g Indef ++ ord.s ; 
      n = Sg ;
      spec=quant.spec
      } ;

    DetPl quant num ord = {
      s = \\g => quant.s ! aformGenNum (gennum g num.n) ++ num.s ++ ord.s ; 
      n = num.n ;
      spec=quant.spec
      } ;

    PossPron p = {s = \\aform => p.s ! Gen aform; spec = Indef} ;

    NoNum = {s = []; n = Pl } ;
    NoOrd = {s = []} ;

    DefArt = {
      s = \\_ => [] ; 
      spec = ResBul.Def
      } ;

    IndefArt = {
      s = \\_ => [] ; 
      spec = ResBul.Indef
      } ;

    MassDet = {s = \\_ => [] ; n = Sg ; spec = Indef} ;

    UseN noun = {
      s = \\n,c,dt => let aform = case n of {
                                    Sg => case <noun.g,c,dt> of {
                                            <Masc,Nom,Def> => AFullDef ;
                                            _              => ASg noun.g dt
                                          } ;
                                    Pl => APl dt
                                    }
                      in noun.s ! aform ;
      g = noun.g
      } ;
}
