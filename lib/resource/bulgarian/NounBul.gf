concrete NounBul of Noun = CatBul ** open ResBul, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = 
      { s = \\c => det.s ! cn.g ++ cn.s ! det.n ! c ! det.det ; 
        a = agrP3 (gennum cn.g det.n)
      } ;
    UsePron p = p ;

    DetSg quant ord = {
      s = \\g => quant.s ! ASg g NDet ++ ord.s ; 
      n = Sg ;
      det=quant.det
      } ;

    DetPl quant num ord = {
      s = \\g => quant.s ! aformGenNum (gennum g num.n) ++ num.s ++ ord.s ; 
      n = num.n ;
      det=quant.det
      } ;

    PossPron p = {s = \\aform => p.s ! Gen aform; det = NDet} ;

    NoNum = {s = []; n = Pl } ;
    NoOrd = {s = []} ;

    DefArt = {
      s = \\_ => [] ; 
      det = ResBul.Det
      } ;

    IndefArt = {
      s = \\_ => [] ; 
      det = ResBul.NDet
      } ;

    MassDet = {s = \\_ => [] ; n = Sg ; det = NDet} ;

    UseN noun = {
      s = \\n,c,dt => let aform = case n of {
                                    Sg => case <noun.g,c,dt> of {
                                            <Masc,Nom,Det> => AFullDet ;
                                            _              => ASg noun.g dt
                                          } ;
                                    Pl => APl dt
                                    }
                      in noun.s ! aform ;
      g = noun.g
      } ;
}
