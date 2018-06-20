--# -coding=cp1251
concrete NounBul of Noun = CatBul ** open ResBul, Prelude in {
  flags optimize=all_subs ; coding=cp1251 ;

  lin
    DetCN det cn =
      { s = \\role => let nf = case <det.nn,det.spec> of {
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
                                 <NCountable,Indef> => case cn.g of {
                                                         AMasc Human => NF Pl Indef;
                                                         _           => NFPlCount
                                                       }
                               } ;
                          s = det.s ! True ! cn.g ! role ++ cn.s ! nf
                      in case role of {
                           RObj Dat      => "на" ++ s;
                           RObj WithPrep => case det.p of {
                                              Pos => with_Word ++ s ;
                                              Neg => "без" ++ s
                                            } ;
                           _             => s
                         } ;
        a = {gn = gennum cn.g (numnnum det.nn); p = P3} ;
        p = det.p
      } ;

    DetNP det =
      { s = \\role => let s = det.s ! False ! ANeut ! role
                      in case role of {
                           RObj Dat => "на" ++ s;
                           _        => s
                         } ;
        a = {gn = gennum ANeut (numnnum det.nn); p = P3} ;
        p = Pos
      } ;
    
    UsePN pn = { s = table {
                       RObj Dat      => "на" ++ pn.s; 
                       RObj WithPron => with_Word ++ pn.s; 
                       _             => pn.s
                     } ;
                 a = {gn = GSg pn.g; p = P3} ;
                 p = Pos
               } ;
    UsePron p = {s = p.s; a=p.a; p=Pos} ;

    PredetNP pred np = {
      s = \\c => case c of {
                   RObj Dat      => "на";
                   RObj WithPrep => with_Word; 
                   _             => ""
                 } ++
                 pred.s ! np.a.gn ++ np.s ! RObj Acc ;
      a = np.a ;
      p = np.p
      } ;

    PPartNP np v2 = {
      s = \\c => np.s ! c ++ v2.s ! Perf ! VPassive (aform np.a.gn Indef c) ;
      a = np.a ;
      p = np.p
      } ;

    AdvNP np adv = {
      s = \\c => np.s ! c ++ adv.s ;
      a = np.a ;
      p = np.p
      } ;

    ExtAdvNP np adv = {
      s = \\c => np.s ! c ++ comma ++ adv.s ;
      a = np.a ;
      p = np.p
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
            RVoc          => cn.s ! NFVocative ;
            RObj Dat      => "на" ++ cn.s ! (NF Sg Indef) ;
            RObj WithPrep => with_Word ++ cn.s ! (NF Sg Indef); 
            _             => cn.s ! (NF Sg Indef)
          } ;
      a = {gn = gennum cn.g Sg; p = P3} ;
      p = Pos
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

    PossNP cn np = {s = \\nf => cn.s ! nf ++ "на" ++ np.s ! (RObj Acc); g = cn.g} ;
    
    PartNP cn np = {s = \\nf => cn.s ! nf ++ "от" ++ np.s ! (RObj Acc); g = cn.g} ;

    CountNP det np = {
      s = \\role => let g = case np.a.gn of { -- this is lossy
                              GSg Masc => AMasc NonHuman ; 
                              GSg Neut => ANeut ;
                              GSg Fem  => AFem ;
                              GPl      => ANeut
                            }
                    in det.s ! False ! g ! role ++ np.s ! (RObj Acc) ;
      a = {gn = gennum ANeut (numnnum det.nn); p = P3} ;
      p = Pos
      } ;

    RelNP np rs = {
      s = \\r => np.s ! r ++ rs.s ! np.a ;
      a = np.a ;
      p = np.p
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
    DetDAP det = {s = \\sp,g,role => det.s ! sp ! g ! role;
                  nn = det.nn;
                  spec = det.spec;
                  p = det.p
                 } ;
}
