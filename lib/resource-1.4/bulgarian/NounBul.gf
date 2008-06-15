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

    DetQuant quant num = {
      s = \\g,c => quant.s ! aform (gennum g num.n) (case c of {RVoc=>Indef; _=>Def}) c ++
                   num.s ! dgenderSpecies g Indef c ;                   
      n = num.n ;
      countable = num.nonEmpty ;
      spec=Indef
      } ;

    DetQuantOrd = \quant, num, ord -> {
      s = \\g,c => quant.s ! aform (gennum g num.n) (case c of {RVoc=>Indef; _=>Def}) c ++
                   num.s ! dgenderSpecies g Indef c ++
                   ord.s ! aform (gennum g num.n) Indef c ; 
      n = num.n ;
      countable = num.nonEmpty ;
      spec=Indef
      } ;

    DetArtCard art card = {
      s = \\g,c => art.s ++
                   card.s ! dgenderSpecies g art.spec c ;
      n = card.n ;
      countable = True ;
      spec=Indef
      } ;

    DetArtOrd art num ord = {
      s = \\g,c => art.s ++
                   num.s ! dgenderSpecies g art.spec c ++
                   ord.s ! aform (gennum g num.n) (case num.nonEmpty of {False => art.spec; _ => Indef}) c ; 
      n = num.n ;
      countable = num.nonEmpty ;
      spec=Indef
      } ;

    DetArtPl art = detCN {
      s = \\g,c => art.s ;
      n = Pl ;
      countable = False ;
      spec=art.spec;
      } ;

    DetArtSg art = detCN {
      s = \\g,c => art.s ;
      n = Sg ;
      countable = False ;
      spec=art.spec;
      } ;

    PossPron p = {
      s = p.gen
      } ;

    NumSg = {s = \\_ => []; n = Sg; nonEmpty = False} ;
    NumPl = {s = \\_ => []; n = Pl; nonEmpty = False} ;

    NumCard n = n ** {nonEmpty = True} ;

    NumDigits n = {s = \\gspec => n.s ! NCard gspec; n = n.n} ;
    OrdDigits n = {s = \\aform => n.s ! NOrd aform} ;

    NumNumeral numeral = {s = \\gspec => numeral.s ! NCard gspec; n = numeral.n; nonEmpty = True} ;
    OrdNumeral numeral = {s = \\aform => numeral.s ! NOrd aform} ;
    
    AdNum adn num = {s = \\gspec => adn.s ++ num.s ! gspec; n = num.n; nonEmpty = num.nonEmpty} ;

    OrdSuperl a = {s = \\aform => "най" ++ "-" ++ a.s ! aform} ;

    DefArt = {
      s = [] ; 
      spec = ResBul.Def
      } ;

    IndefArt = {
      s = [] ;
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
