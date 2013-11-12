--1 Scandinavian auxiliary operations

interface ResScand = DiffScand ** open CommonScand, Prelude in {

--2 Constants uniformly defined in terms of language-dependent constants

  param
    CardOrd = NCard NGender | NOrd AFormSup ; -- sic! (AFormSup)

  oper  
    agrP3 : Gender -> Number -> Agr = \g,n -> {
      g = g ;
      n = n ;
      p = P3
      } ;

    Noun = {s : Number => Species => Case => Str ; g : NGender} ;

-- needed for VP conjunction
  param
    VPIForm = VPIInf | VPISup ; ---- sup not yet used


-- This function is here because it depends on $verbHave, auxFut, auxCond$.
 oper
  predV : Verb -> VP = \verb -> 
    let
      diath : Voice -> Voice = \d -> case verb.vtype of {
        VPass => Pass ;
        _ => d
        } ;
      vfin : Voice -> STense -> Str = \d,t -> verb.s ! vFin t (diath d) ;
      vsup : Voice -> Str = \d -> verb.s ! VI (VSupin (diath d)) ; --# notpresent  
      vinf : Voice -> Str = \d -> verb.s ! VI (VInfin (diath d)) ;

      auxv = case hasAuxBe verb of {
        True => verbBe.s ;
        _ => verbHave.s
        } ;
 

      har : STense -> Str = \t -> auxv ! vFin t Act ;
      ha  : Str = auxv ! VI (VInfin Act) ;

      vf : Str -> Str -> {fin,inf : Str} = \fin,inf -> {
        fin = fin ; inf = inf ++ verb.part
        } ;

    in {
    s = \\d => table {
      VPFinite t Simul => case t of {
--        SPres | SPast => vf (vfin d t) [] ; -- the general rule
        SPast => vf (vfin d t) [] ;    --# notpresent
        SFut  => vf auxFut (vinf d) ;    --# notpresent
        SFutKommer => vf auxFutKommer (auxFutPart ++ infMark ++ vinf d) ;   --# notpresent
        SCond => vf auxCond (vinf d) ;   --# notpresent
        SPres => vf (vfin d t) []
        } ;
      VPFinite t Anter => case t of {    --# notpresent
        SPres | SPast => vf (har t) (vsup d) ; --# notpresent
        SFut  => vf auxFut (ha ++ vsup d) ; --# notpresent
        SFutKommer => vf auxFutKommer (auxFutPart ++ infMark ++ ha ++ vsup d) ; --# notpresent
        SCond => vf auxCond (ha ++ vsup d)  --# notpresent
        } ;                              --# notpresent
      VPImperat => vf (verb.s ! VF (VImper (diath d))) [] ;
      VPInfinit Anter => vf [] (ha ++ vsup d) ;  --# notpresent
      VPInfinit Simul => vf [] (vinf d)
      } ;
    a1  : Polarity => Str = negation ;
    n2  : Agr => Str = \\a => case verb.vtype of {
      VRefl => reflPron a ;
      _ => []
      } ;
    a2  : Str = [] ;
    ext : Str = [] ;
    en2,ea2,eext : Bool = False   -- indicate if the field exists
    } ;

  comma : Str = SOFT_BIND ++ "," ;

}
