concrete NounBul of Noun = CatBul ** open ResBul, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = 
      { s = \\c => let nf = case <det.n,det.spec> of {
                              <Sg,Def>   => case c of {
                                              Nom => NFSgDefNom ;
                                              _   => NF Sg Def
                                            } ;
                              <Pl,Indef> => case det.countable of {
                                              True  => NFPlCount ;
                                              False => NF Pl Indef
                                            } ;
                              _              => NF det.n det.spec
                            } ;
                   in det.s ! cn.g ! c ++ cn.s ! nf ; 
        a = {gn = gennum cn.g det.n; p = P3} ;
      } ;
    UsePron p = p ;

    DetSg quant ord = {
      s = \\g,c => quant.s ! gennum g Sg ++
                   ord.s   ! aform (gennum g Sg) quant.spec c ;
      n = Sg ;
      countable = False ;
      spec=case ord.nonEmpty of {False => quant.spec; _ => Indef}
      } ;

    DetPl quant num ord = {
      s = \\g,c => quant.s ! gennum g num.n ++
                   num.s ! dgenderSpecies g quant.spec c ++
                   ord.s ! aform (gennum g num.n) (case num.nonEmpty of {False => quant.spec; _ => Indef}) c ; 
      n = num.n ;
      countable = num.nonEmpty ;
      spec=case <num.nonEmpty,ord.nonEmpty> of {<False,False> => quant.spec; _ => Indef}
      } ;

    PossPron p = {
      s = \\gn => p.s ! Gen (aform gn Def Nom) ;
      spec = Indef
      } ;

    NoNum = {s = \\_ => []; n = Pl; nonEmpty = False} ;
    NoOrd = {s = \\_ => []; nonEmpty = False} ;

    NumNumeral numeral = {s = \\gspec => numeral.s ! NCard gspec; n = numeral.n; nonEmpty = False} ;
    OrdNumeral numeral = {s = \\aform => numeral.s ! NOrd aform; nonEmpty = False} ;

    DefArt = {
      s = \\_ => [] ; 
      spec = ResBul.Def
      } ;

    IndefArt = {
      s = \\_ => [] ;
      spec = ResBul.Indef
      } ;

    MassDet = {
      s = \\_ => [] ;
      spec = Indef
      } ;

    UseN noun = noun ;
}
