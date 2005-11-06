instance DemResEng of DemRes = open Prelude, ResourceEng, SyntaxEng in {

  oper
    msS   : S  -> Str = \x -> x.s ;
    msQS  : QS -> Str = \x -> x.s ! DirQ ;
    msImp : Imp -> Str = \x -> x.s ! Sg ;


} ;
