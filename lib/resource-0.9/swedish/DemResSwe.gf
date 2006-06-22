instance DemResSwe of DemRes = open Prelude, ResourceSwe, SyntaxSwe in {

  oper
    msS   : S  -> Str = \x -> x.s ! Main ;
    msQS  : QS -> Str = \x -> x.s ! DirQ ;
    msImp : Imp -> Str = \x -> x.s ! Sg ;


} ;
