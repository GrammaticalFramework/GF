concrete NounBul of Noun = CatBul ** open ResBul, Prelude in {
  flags optimize=all_subs ; coding=cp1251 ;

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
                                 <Pl,Indef> => case cn.g of {
                                                 DMascPersonal => NF Pl Indef;
                                                 _             => case det.countable of {
                                                                    True  => NFPlCount ;
                                                                    False => NF Pl Indef
                                                                  }
                                               }
                               } ;
                          s = det.s ! True ! cn.g ! role ++ cn.s ! nf
                      in case role of {
                           RObj Dat => "на" ++ s; 
                           _        => s
                         } ;
        a = {gn = gennum cn.g det.n; p = P3} ;
      } ;

    DetNP det =
      { s = \\role => let s = det.s ! False ! DNeut ! role
                      in case role of {
                           RObj Dat => "на" ++ s;
                           _        => s
                         } ;
        a = {gn = gennum DNeut det.n; p = P3} ;
      } ;
    
    UsePN pn = { s = table {
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
      s  = \\sp,g,c => let sp' = case num.nonEmpty of { True  => True ;
                                                        False => sp   }
                       in quant.s ! sp' ! aform (gennum g num.n) (case c of {RVoc=>Indef; _=>Def}) c ++
                          num.s ! dgenderSpecies g quant.spec c ;
      n = num.n ;
      countable = num.nonEmpty ;
      spec = case num.nonEmpty of {True=>Indef; _=>quant.spec}
      } ;

    DetQuantOrd = \quant, num, ord -> {
      s  = \\_,g,c => quant.s ! True ! aform (gennum g num.n) (case c of {RVoc=>Indef; _=>Def}) c ++
                      num.s ! dgenderSpecies g quant.spec c ++
                      ord.s ! aform (gennum g num.n) (case num.nonEmpty of {True=>Indef; _=>quant.spec}) c ; 
      n = num.n ;
      countable = num.nonEmpty ;
      spec=Indef
      } ;

    PossPron p = {
      s    = \\_ => p.gen ;
      nonEmpty = True ;
      spec = ResBul.Indef
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
      s  = table {
             True  => \\_ => [] ;
             False => table {
                        ASg Masc _    => "той" ;
                        ASgMascDefNom => "той" ;
                        ASg Fem  _    => "тя"  ;
                        ASg Neut _    => "то"  ;
                        APl      _    => "те"
                      }
           } ;
      nonEmpty = False ;
      spec = ResBul.Def
      } ;

    IndefArt = {
      s  = table {
             True  => \\_ => [] ;
             False => table {
                        ASg Masc _    => "един" ;
                        ASgMascDefNom => "един" ;
                        ASg Fem  _    => "една" ;
                        ASg Neut _    => "едно" ;
                        APl      _    => "едни"
                      }
           } ;
      nonEmpty = False ;
      spec = ResBul.Indef
      } ;

    MassNP cn = {
      s = table {
            RVoc     => cn.s ! NFVocative ;
            RObj Dat => "на" ++ cn.s ! (NF Sg Indef); 
            _        => cn.s ! (NF Sg Indef)
          } ;
      a = {gn = gennum cn.g Sg; p = P3} ;
      } ;

    UseN noun = noun ;
    UseN2 noun = noun ;

    ComplN2 f x = {s = \\nf => f.s ! nf ++ f.c2.s ++ x.s ! RObj f.c2.c; g=f.g} ;
    ComplN3 f x = {s = \\nf => f.s ! nf ++ f.c2.s ++ x.s ! RObj f.c2.c; c2 = f.c3; g=f.g} ;

    Use2N3 f = {s = f.s ; g=f.g ; c2 = f.c2} ;
    Use3N3 f = {s = f.s ; g=f.g ; c2 = f.c3} ;


    AdjCN ap cn = {
      s = \\nf => case ap.isPre of {
                    True  => (ap.s ! nform2aform nf cn.g) ++ (cn.s ! (indefNForm nf)) ;
                    False => (cn.s ! nf) ++ (ap.s ! nform2aform (indefNForm nf) cn.g)
                  } ;
      g = cn.g
      } ;
    RelCN cn rs = {
      s = \\nf => cn.s ! nf ++ rs.s ! {gn=gennum cn.g (numNForm nf); p=P3} ;
      g = cn.g
      } ;
    AdvCN cn ad = {
      s = \\nf => cn.s ! nf ++ ad.s ;
      g = cn.g
    } ;

    SentCN cn sc = {s = \\nf => cn.s ! nf ++ sc.s; g=DNeut} ;

    ApposCN cn np = {s = \\nf => cn.s ! nf ++ np.s ! RSubj; g=cn.g} ;

    RelNP np rs = {
      s = \\r => np.s ! r ++ rs.s ! np.a ;
      a = np.a
      } ;
}
