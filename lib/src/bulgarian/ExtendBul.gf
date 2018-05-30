--# -path=.:../abstract:../common:prelude
concrete ExtendBul of Extend = CatBul ** open Prelude, ResBul in {

lin
  CompoundN n1 n2 = 
    let aform = ASg (case n2.g of {
                       AMasc _       => Masc ;
                       AFem          => Fem ;
                       ANeut         => Neut
                    }) Indef
    in {
         s   = \\nf => n1.rel ! nform2aform nf n2.g ++ n2.s ! (indefNForm nf) ;
         rel = \\af => n1.rel ! aform ++ n2.s ! NF Sg Indef ;
         g   = n2.g
    } ;

  PositAdVAdj a = {s = a.adv} ;

  PresPartAP vp =
    let ap : AForm => Person => Str
           = \\aform,p => vp.ad.s ++
                          vp.s ! Imperf ! VPresPart aform ++
                          case vp.vtype of {
                            VMedial c => reflClitics ! c;
                            _           => []
                          } ++
                          vp.compl ! {gn=aform2gennum aform; p=p} ;
    in {s = ap; adv = ap ! (ASg Neut Indef) ! P3; isPre = True} ;

  PastPartAP vp =
    let ap : AForm => Person => Str
           = \\aform,p => vp.ad.s ++
                          vp.s ! Perf ! VPassive aform ++
                          vp.compl1 ! {gn=aform2gennum aform; p=p} ++
                          vp.compl2 ! {gn=aform2gennum aform; p=p}
    in {s = ap; adv = ap ! ASg Neut Indef ! P3; isPre = True} ;

  PastPartAgentAP vp np =
    let ap : AForm => Person => Str
           = \\aform,p => vp.ad.s ++
                          vp.s ! Perf ! VPassive aform ++
                          vp.compl1 ! {gn=aform2gennum aform; p=p} ++
                          vp.compl2 ! {gn=aform2gennum aform; p=p} ++
                          "от" ++ np.s ! RObj Acc
    in {s = ap; adv = ap ! ASg Neut Indef ! P3; isPre = False} ;

}

