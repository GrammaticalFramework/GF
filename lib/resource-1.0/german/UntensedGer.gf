concrete UntensedGer of Untensed = CatGer ** open ResGer in {

  flags optimize=all_subs ;

  lin
    PosCl cl = {s = cl.s ! Pres ! Simul ! Pos} ;
    NegCl cl = {s = cl.s ! Pres ! Simul ! Neg} ;

--    PosQCl cl = {s = cl.s ! Pres ! Simul ! Pos} ;
--    NegQCl cl = {s = cl.s ! Pres ! Simul ! Neg} ;
--
--    PosRCl cl = {s = cl.s ! Pres ! Simul ! Pos} ;
--    NegRCl cl = {s = cl.s ! Pres ! Simul ! Neg} ;
--
}
