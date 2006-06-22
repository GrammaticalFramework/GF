instance DemResFre of DemRes = open Prelude, ResourceFre, SyntaxFre in {

  oper
    msS   : S  -> Str = \x -> x.s ! Ind ;
    msQS  : QS -> Str = \x -> x.s ! DirQ ;
    msImp : Imp -> Str = \x -> x.s ! Masc ! Sg ;


} ;
