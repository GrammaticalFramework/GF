--1 Scandinavian auxiliary operations

interface ResScand = DiffScand ** open CommonScand, Prelude in {

--2 Constants uniformly defined in terms of language-dependent constants

  param
    CardOrd = NCard Gender | NOrd AFormSup ; -- sic! (AFormSup)

  oper  
    agrP3 : Gender -> Number -> Agr = \g,n -> {
      gn = gennum g n ;
      p = P3
      } ;

    Noun = {s : Number => Species => Case => Str ; g : Gender} ;

-- This function is here because it depends on $verbHave, auxFut, auxCond$.

   predV : Verb -> VP = \verb -> 
    let
      diath = case verb.vtype of {
        VPass => Pass ;
        _ => Act
        } ;
      vfin : Tense -> Str = \t -> verb.s ! vFin t diath ;
      vsup = verb.s ! VI (VSupin diath) ; --# notpresent  
      vinf = verb.s ! VI (VInfin diath) ;

      auxv = case hasAuxBe verb of {
        True => verbBe.s ;
        _ => verbHave.s
        } ;

      har : Tense -> Str = \t -> auxv ! vFin t Act ;
      ha  : Str = auxv ! VI (VInfin Act) ;

      vf : Str -> Str -> {fin,inf : Str} = \fin,inf -> {
        fin = fin ; inf = inf ++ verb.part
        } ;

    in {
    s = table {
      VPFinite t Simul => case t of {
--        Pres | Past => vf (vfin t) [] ; -- the general rule
        Past => vf (vfin t) [] ;    --# notpresent
        Fut  => vf auxFut vinf ;    --# notpresent
        Cond => vf auxCond vinf ;   --# notpresent
        Pres => vf (vfin t) []
        } ;
      VPFinite t Anter => case t of {    --# notpresent
        Pres | Past => vf (har t) vsup ; --# notpresent
        Fut  => vf auxFut (ha ++ vsup) ; --# notpresent
        Cond => vf auxCond (ha ++ vsup)  --# notpresent
        } ;                              --# notpresent
      VPImperat => vf (verb.s ! VF (VImper diath)) [] ;
      VPInfinit Anter => vf [] (ha ++ vsup) ;  --# notpresent
      VPInfinit Simul => vf [] vinf
      } ;
    a1  : Polarity => Str = negation ;
    n2  : Agr  => Str = \\a => case verb.vtype of {
      VRefl => reflPron a ;
      _ => []
      } ;
    a2  : Str = [] ;
    ext : Str = [] ;
    en2,ea2,eext : Bool = False   -- indicate if the field exists
    } ;

}
