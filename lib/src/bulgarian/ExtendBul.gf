--# -path=.:../abstract:../common:prelude
concrete ExtendBul of Extend = CatBul ** open ResBul in {

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

}

