concrete NounBul of Noun = CatBul ** open ResBul, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = 
      { s = \\role => let nf = case <det.n,det.spec> of {
                                 <Sg,Def>   => case role of {
                                                 RSubj => NFSgDefNom ;
                                                 RVoc  => NFVocative ;
                                                 _     => NF Sg Def
                                               } ;
                                 <Sg,Indef> => case role of {
				                 RVoc  => NFVocative ;
				                 _     => NF Sg Indef
                                               } ;
                                 <Pl,Def>   => NF det.n det.spec ;
                                 <Pl,Indef> => case det.countable of {
                                                 True  => NFPlCount ;
                                                 False => NF Pl Indef
                                               }
                               } ;
                          s = det.s ! cn.g ! role ++ cn.s ! nf
                      in case role of {
                           RObj Dat => "на" ++ s; 
                           _        => s
                         } ;
        a = {gn = gennum cn.g det.n; p = P3} ;
      } ;
    UsePN pn = { s = \\role => case role of {
                              RObj Dat => "на" ++ pn.s; 
                              _        => pn.s
                            } ;
                 a = {gn = GSg pn.g; p = P3}
               } ;
    UsePron p = {s = p.s; a=p.a} ;

    PredetNP pred np = {
      s = \\c => pred.s ! np.a.gn ++ np.s ! c ;
      a = np.a
      } ;

    PPartNP np v2 = {
      s = \\c => np.s ! c ++ v2.s ! VPassive (aform np.a.gn Indef c) ;
      a = np.a
      } ;

    AdvNP np adv = {
      s = \\c => np.s ! c ++ adv.s ;
      a = np.a
      } ;

    DetSg quant ord = {
      s = \\g,c => quant.s ! aform (gennum g Sg) (case c of {RVoc=>Indef;_=>Def}) c ++
                   ord.s   ! aform (gennum g Sg) quant.spec c ;
      n = Sg ;
      countable = False ;
      spec=case ord.nonEmpty of {False => quant.spec; _ => Indef}
      } ;

    DetPl quant num ord = {
      s = \\g,c => num.s ! dgenderSpecies g quant.spec c ++
                   quant.s ! aform (gennum g num.n) Def c ++                   
                   ord.s ! aform (gennum g num.n) (case num.nonEmpty of {False => quant.spec; _ => Indef}) c ; 
      n = num.n ;
      countable = num.nonEmpty ;
      spec=case <num.nonEmpty,ord.nonEmpty> of {<False,False> => quant.spec; _ => Indef}
      } ;

    PossPron p = {
      s = p.gen ;
      spec = Indef
      } ;

    NoNum = {s = \\_ => []; n = Pl; nonEmpty = False} ;
    NoOrd = {s = \\_ => []; nonEmpty = False} ;

    NumDigits n = {s = \\gspec => n.s ! NCard gspec; n = n.n; nonEmpty = True} ;
    OrdDigits n = {s = \\aform => n.s ! NOrd aform; nonEmpty = True} ;

    NumInt n = {s = \\gspec => n.s ; n = Pl; nonEmpty = True} ;   -- DEPRECATED
    OrdInt n = {s = \\aform => n.s ++ "th"; nonEmpty = True} ;    -- DEPRECATED

    NumNumeral numeral = {s = \\gspec => numeral.s ! NCard gspec; n = numeral.n; nonEmpty = True} ;
    OrdNumeral numeral = {s = \\aform => numeral.s ! NOrd aform; nonEmpty = True} ;
    
    AdNum adn num = {s = \\gspec => adn.s ++ num.s ! gspec; n = num.n; nonEmpty = num.nonEmpty} ;

    OrdSuperl a = {s = \\aform => "най" ++ "-" ++ a.s ! aform; nonEmpty = True} ;

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

    ComplN2 f x = {s = \\nf => f.s ! nf ++ f.c2.s ++ x.s ! RObj f.c2.c; g=f.g} ;
    ComplN3 f x = {s = \\nf => f.s ! nf ++ f.c2.s ++ x.s ! RObj f.c2.c; c2 = f.c3; g=f.g} ;

    AdjCN ap cn = {
      s = \\nf => preOrPost ap.isPre (ap.s ! nform2aform nf cn.g) (cn.s ! (indefNForm nf)) ;
      g = cn.g
      } ;
    RelCN cn rs = {
      s = \\nf => cn.s ! nf ++ rs.s ! gennum cn.g (numNForm nf) ;
      g = cn.g
      } ;
    AdvCN cn ad = {
      s = \\nf => cn.s ! nf ++ ad.s ;
      g = cn.g
    } ;

    SentCN cn sc = {s = \\nf => cn.s ! nf ++ sc.s; g=DNeut} ;

    ApposCN cn np = {s = \\nf => cn.s ! nf ++ np.s ! RSubj; g=cn.g} ;
}
