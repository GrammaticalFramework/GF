concrete NounBul of Noun = CatBul ** open ResBul, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN = detCN ;

    DetNP det = detCN det {s = \\_ => [] ; g = DNeut} ; ---- FIXME AR

  oper
    detCN : 
      {s : DGender => Role => Str ; n : Number; countable : Bool; spec : Species} -> 
      {s : NForm => Str; g : DGender} ->
      {s : Role => Str; a : Agr}
      = 
      \det,cn -> 
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
                                 <Pl,Indef> => case cn.g of {
                                                 DMascPersonal => NF Pl Indef;
                                                 _             => case det.countable of {
                                                                    True  => NFPlCount ;
                                                                    False => NF Pl Indef
                                                                  }
                                               }
                               } ;
                          s = det.s ! cn.g ! role ++ cn.s ! nf
                      in case role of {
                           RObj Dat => "на" ++ s; 
                           _        => s
                         } ;
        a = {gn = gennum cn.g det.n; p = P3} ;
      } ;

  lin
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
      s = \\c => np.s ! c ++ v2.s ! Perf ! VPassive (aform np.a.gn Indef c) ;
      a = np.a
      } ;

    AdvNP np adv = {
      s = \\c => np.s ! c ++ adv.s ;
      a = np.a
      } ;

    DetQuantOrd, DetArtOrd = \quant, num, ord -> {
      s = \\g,c => num.s ! dgenderSpecies g quant.spec c ++
                   quant.s ! aform (gennum g num.n) Def c ++                   
                   ord.s ! aform (gennum g num.n) (case num.nonEmpty of {False => quant.spec; _ => Indef}) c ; 
      n = num.n ;
      countable = num.nonEmpty ;
      spec=case <num.nonEmpty,ord.nonEmpty> of {<False,False> => quant.spec; _ => Indef}
      } ;

    DetQuant quant num = {
      s = \\g,c => num.s ! dgenderSpecies g quant.spec c ++
                   quant.s ! aform (gennum g num.n) Def c ;                   
      n = num.n ;
      countable = num.nonEmpty ;
      spec=case num.nonEmpty of {False => quant.spec; _ => Indef} ---- FIXME AR
      } ;

    DetArtCard quant num = {
      s = \\g,c => num.s ! dgenderSpecies g quant.spec c ++
                   quant.s ! aform (gennum g num.n) Def c ;                   
      n = num.n ;
      countable = True ;
      spec= Indef ---- FIXME AR
      } ;

    ---- FIXME AR
    DetArtPl quant = detCN {
      s = \\g,c => quant.s ! aform (gennum g Pl) Def c ;                   
      n = Pl ;
      countable = False ;
      spec=quant.spec;
      } ;

    ---- FIXME AR
    DetArtSg quant = detCN {
      s = \\g,c => quant.s ! aform (gennum g Sg) Def c ;                   
      n = Sg ;
      countable = False ;
      spec=quant.spec;
      } ;

    PossPron p = {
      s = p.gen ;
      spec = Indef
      } ;

    NumSg = {s = \\_ => []; n = Sg; nonEmpty = False} ;
    NumPl = {s = \\_ => []; n = Pl; nonEmpty = False} ;

    NumCard n = n ** {nonEmpty = True} ;

    NumDigits n = {s = \\gspec => n.s ! NCard gspec; n = n.n} ;
    OrdDigits n = {s = \\aform => n.s ! NOrd aform; nonEmpty = True} ;

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

    MassNP = detCN {
      s = \\_,_ => [] ;
      spec = Indef ;
      countable = False ; n = Sg ---- FIXME is this correct? AR
      } ;

    UseN noun = noun ;
    UseN2 noun = noun ;

    ComplN2 f x = {s = \\nf => f.s ! nf ++ f.c2.s ++ x.s ! RObj f.c2.c; g=f.g} ;
    ComplN3 f x = {s = \\nf => f.s ! nf ++ f.c2.s ++ x.s ! RObj f.c2.c; c2 = f.c3; g=f.g} ;

    Use2N3 f = {s = f.s ; g=f.g ; c2 = f.c2} ;
    Use3N3 f = {s = f.s ; g=f.g ; c2 = f.c3} ;


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

---- FIXME AR
    RelNP np rs = {
      s = \\r => np.s ! r ++ rs.s ! np.a.gn ; ---- gennum cn.g (numNForm nf) ;
      a = np.a
      } ;
}
