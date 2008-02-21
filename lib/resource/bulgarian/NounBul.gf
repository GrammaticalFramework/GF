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
    UsePN pn = {s = \\_ => pn.s; a = {gn = GSg pn.g; p = P3}} ;
    UsePron p = {s = p.s; a=p.a} ;

    PredetNP pred np = {
      s = \\c => pred.s ! np.a.gn ++ np.s ! c ;
      a = np.a
      } ;

    PPartNP np v2 = {
      s = \\c => np.s ! c ++ v2.s ! VPassive (aform np.a.gn Indef c) ;
      a = np.a
      } ;

    DetSg quant ord = {
      s = \\g,c => quant.s ! gennum g Sg ++
                   ord.s   ! aform (gennum g Sg) quant.spec c ;
      n = Sg ;
      countable = False ;
      spec=case ord.nonEmpty of {False => quant.spec; _ => Indef}
      } ;

    DetPl quant num ord = {
      s = \\g,c => num.s ! dgenderSpecies g quant.spec c ++
                   quant.s ! gennum g num.n ++                   
                   ord.s ! aform (gennum g num.n) (case num.nonEmpty of {False => quant.spec; _ => Indef}) c ; 
      n = num.n ;
      countable = num.nonEmpty ;
      spec=case <num.nonEmpty,ord.nonEmpty> of {<False,False> => quant.spec; _ => Indef}
      } ;

    PossPron p = {
      s = \\gn => p.gen ! aform gn Indef Nom ;
      spec = Indef
      } ;

    NoNum = {s = \\_ => []; n = Pl; nonEmpty = False} ;
    NoOrd = {s = \\_ => []; nonEmpty = False} ;

    NumNumeral numeral = {s = \\gspec => numeral.s ! NCard gspec; n = numeral.n; nonEmpty = True} ;
    OrdNumeral numeral = {s = \\aform => numeral.s ! NOrd aform; nonEmpty = True} ;

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
    UseN2 noun = noun ;
    UseN3 noun = noun ;

    ComplN2 f x = {s = \\nf => f.s ! nf ++ f.c2 ++ x.s ! Acc; g=f.g} ;
    ComplN3 f x = {s = \\nf => f.s ! nf ++ f.c2 ++ x.s ! Acc; c2 = f.c3; g=f.g} ;

    AdjCN ap cn = {
      s = \\nf => preOrPost ap.isPre (ap.s ! nform2aform nf cn.g) (cn.s ! (indefNForm nf)) ;
      g = cn.g
      } ;
}
