--# -coding=cp1251
concrete NounBul of Noun = CatBul ** open ResBul, Prelude in {
  flags optimize=all_subs ; coding=cp1251 ;

  lin
    DetCN det cn =
      { s  = \\role => let nf = case <det.nn,det.spec> of {
                                  <NNum Sg,Def>   => case role of {
                                                       RSubj => NFSgDefNom ;
                                                       RVoc  => NFVocative ;
                                                       _     => NF Sg Def
                                                     } ;
                                  <NNum Sg,Indef> => case role of {
				                                       RVoc  => NFVocative ;
				                                       _     => NF Sg Indef
                                                     } ;
                                  <NNum Pl,Def>   => NF Pl Def ;
                                  <NNum Pl,Indef> => NF Pl Indef;
                                  <NCountable,Def>   => NF Pl det.spec ;
                                  <NCountable,Indef> => NFPlCount
                                } ;
                           s = det.s ! True ! cn.g ! role ++ cn.s ! nf
                       in case role of {
                            RObj c => linCase c det.p ++ s;
                            _      => s
                          } ;
        gn = gennum cn.g (numnnum det.nn);
        p  = NounP3 det.p
      } ;

    DetNP det =
      { s  = \\role => let s = det.s ! False ! ANeut ! role
                       in case role of {
                            RObj c => linCase c det.p ++ s;
                            _      => s
                          } ;
        gn = gennum ANeut (numnnum det.nn);
        p  = NounP3 det.p
      } ;
    
    UsePN pn = { s = table {
                       RObj c => linCase c Pos ++ pn.s; 
                       _      => pn.s
                     } ;
                 gn = GSg pn.g ;
                 p = NounP3 Pos
               } ;
    UsePron p = p ;

    PredetNP pred np = {
      s = \\c => case c of {
                   RObj c  => linCase c (personPol np.p) ;
                   _       => ""
                 } ++
                 pred.s ! np.gn ++ np.s ! RObj CPrep ;
      gn = np.gn ;
      p  = NounP3 (personPol np.p)
      } ;

    PPartNP np v2 = {
      s  = \\role => case role of {
                       RObj c => linCase c (personPol np.p) ++ np.s ! RObj CPrep ;
                       role   => np.s ! role
                     } ++ v2.s ! Perf ! VPassive (aform np.gn Indef role) ;
      gn = np.gn ;
      p  = NounP3 (personPol np.p)
      } ;

    AdvNP np adv = {
      s  = \\role => case role of {
                       RObj c => linCase c (personPol np.p) ++ np.s ! RObj CPrep ;
                       role   => np.s ! role
                     } ++ adv.s ;
      gn = np.gn ;
      p  = NounP3 (personPol np.p)
      } ;

    ExtAdvNP np adv = {
      s  = \\role => case role of {
                       RObj c => linCase c (personPol np.p) ++ np.s ! RObj CPrep ;
                       role   => np.s ! role
                     } ++ bindComma ++ adv.s ;
      gn = np.gn ;
      p  = NounP3 (personPol np.p)
      } ;

    DetQuant quant num = {
      s  = \\sp,g,c => let sp' = case num.nonEmpty of { True  => True ;
                                                        False => sp   }
                       in quant.s ! sp' ! aform (gennum g (numnnum num.nn)) (case c of {RVoc=>Indef; _=>Def}) c ++
                          num.s ! dgenderSpecies g quant.spec c ;
      nn = num.nn ;
      spec = case num.nonEmpty of {True=>Indef; _=>quant.spec} ;
      p  = quant.p
      } ;

    DetQuantOrd = \quant, num, ord -> {
      s  = \\_,g,c => quant.s ! True ! aform (gennum g (numnnum num.nn)) (case c of {RVoc=>Indef; _=>Def}) c ++
                      num.s ! dgenderSpecies g quant.spec c ++
                      ord.s ! aform (gennum g (numnnum num.nn)) (case num.nonEmpty of {True=>Indef; _=>quant.spec}) c ; 
      nn = num.nn ;
      spec=Indef ;
      p  = quant.p
      } ;

    PossPron p = {
      s    = \\_ => p.gen ;
      nonEmpty = True ;
      spec = ResBul.Indef ;
      p = Pos
      } ;

    NumSg = {s = \\_ => []; nn = NNum Sg; nonEmpty = False} ;
    NumPl = {s = \\_ => []; nn = NNum Pl; nonEmpty = False} ;

    NumCard n = {s=n.s; nn=case n.n of {Sg => NNum Sg; Pl => NCountable}; nonEmpty = True} ;

    NumDigits n = {s = \\gspec => n.s ! NCard gspec; n = n.n} ;
    OrdDigits n = {s = \\aform => n.s ! NOrd aform} ;

    NumNumeral numeral = {s = \\gspec => numeral.s ! NCard gspec; n = numeral.n; nonEmpty = True} ;
    OrdNumeral numeral = {s = \\aform => numeral.s ! NOrd aform} ;
    
    AdNum adn num = {s = \\gspec => adn.s ++ num.s ! gspec; n = num.n; nonEmpty = num.nonEmpty} ;

    OrdSuperl a = {s = \\aform => "най" ++ hyphen ++ a.s ! aform} ;

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
      spec = ResBul.Def ;
      p = Pos
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
      spec = ResBul.Indef ;
      p = Pos
      } ;

    MassNP cn = {
      s = table {
            RVoc   => cn.s ! NFVocative ;
            RObj c => linCase c Pos ++ cn.s ! (NF Sg Indef) ;
            _      => cn.s ! (NF Sg Indef)
          } ;
      gn = gennum cn.g Sg;
      p = NounP3 Pos
      } ;

    UseN noun = noun ;
    UseN2 noun = noun ;

    ComplN2 f x = {s = \\nf => f.s ! nf ++ f.c2.s ++ x.s ! RObj f.c2.c; g=f.g} ;
    ComplN3 f x = {s = \\nf => f.s ! nf ++ f.c2.s ++ x.s ! RObj f.c2.c; rel = \\af => f.rel ! af ++ f.c2.s ++ x.s ! RObj f.c2.c; relPost = True; c2 = f.c3; g=f.g} ;

    Use2N3 f = {s = f.s ; rel = f.rel ; relPost = f.relPost ; g=f.g ; c2 = f.c2} ;
    Use3N3 f = {s = f.s ; rel = f.rel ; relPost = f.relPost ; g=f.g ; c2 = f.c3} ;


    AdjCN ap cn = {
      s = \\nf => case ap.isPre of {
                    True  => (ap.s ! nform2aform nf cn.g ! P3) ++ (cn.s ! (indefNForm nf)) ;
                    False => (cn.s ! nf) ++ (ap.s ! nform2aform (indefNForm nf) cn.g ! P3)
                  } ;
      g = cn.g
      } ;
    RelCN cn rs = {
      s = \\nf => cn.s ! nf ++ rs.s ! agrP3 (gennum cn.g (numNForm nf)) ;
      g = cn.g
      } ;
    AdvCN cn ad = {
      s = \\nf => cn.s ! nf ++ ad.s ;
      g = cn.g
    } ;

    SentCN cn sc = {s = \\nf => cn.s ! nf ++ sc.s ! agrP3 (gennum cn.g (numNForm nf)); g=cn.g} ;

    ApposCN cn np = {s = \\nf => cn.s ! nf ++ np.s ! RSubj; g=cn.g} ;

    PossNP cn np = {s = \\nf => cn.s ! nf ++ "на" ++ np.s ! (RObj CPrep); g = cn.g} ;
    
    PartNP cn np = {s = \\nf => cn.s ! nf ++ "от" ++ np.s ! (RObj CPrep); g = cn.g} ;

    CountNP det np = {
      s = \\role => let g = case np.gn of { -- this is lossy
                              GSg Masc => AMasc NonHuman ; 
                              GSg Neut => ANeut ;
                              GSg Fem  => AFem ;
                              GPl      => ANeut
                            }
                    in det.s ! False ! g ! role ++ np.s ! (RObj Acc) ;
      gn = gennum ANeut (numnnum det.nn);
      p = NounP3 Pos
      } ;

    RelNP np rs = {
      s  = \\role => case role of {
                       RObj c => linCase c (personPol np.p) ++ np.s ! RObj CPrep ;
                       role   => np.s ! role
                     } ++ rs.s ! personAgr np.gn np.p ;
      gn = np.gn ;
      p  = NounP3 (personPol np.p)
      } ;

    AdjDAP dap ap = {s = \\sp,g,role => let g' = case g of {
                                                AMasc _       => Masc ;
                                                AFem          => Fem ;
                                                ANeut         => Neut
                                              } ;
                                         aform = case <numnnum dap.nn,dap.spec,role> of {
                                                   <Sg,Def,RSubj> => ASgMascDefNom ;
                                                   <Sg,_  ,_    > => ASg g' dap.spec ;
                                                   <Pl,_  ,_    > => APl dap.spec
                                                 } ;
                                     in dap.s ! True ! g ! role ++ ap.s ! aform ! P3 ;
                     nn = dap.nn;
                     spec = dap.spec;
                     p = dap.p
                    } ;
    DetDAP det = det ;
}
