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
      diath = case verb.vtype of {
        VPass => Pass ;
        _ => Act
        } ;
      vfin : STense -> Str = \t -> verb.s ! vFin t diath ;
      vsup = verb.s ! VI (VSupin diath) ; --# notpresent  
      vinf = verb.s ! VI (VInfin diath) ;

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
    s = table {
      VPFinite t Simul => case t of {
--        SPres | SPast => vf (vfin t) [] ; -- the general rule
        SPast => vf (vfin t) [] ;    --# notpresent
        SFut  => vf auxFut vinf ;    --# notpresent
        SFutKommer => vf auxFutKommer (auxFutPart ++ infMark ++ vinf) ;   --# notpresent
        SCond => vf auxCond vinf ;   --# notpresent
        SPres => vf (vfin t) []
        } ;
      VPFinite t Anter => case t of {    --# notpresent
        SPres | SPast => vf (har t) vsup ; --# notpresent
        SFut  => vf auxFut (ha ++ vsup) ; --# notpresent
        SFutKommer => vf auxFutKommer (auxFutPart ++ infMark ++ ha ++ vsup) ; --# notpresent
        SCond => vf auxCond (ha ++ vsup)  --# notpresent
        } ;                              --# notpresent
      VPImperat => vf (verb.s ! VF (VImper diath)) [] ;
      VPInfinit Anter => vf [] (ha ++ vsup) ;  --# notpresent
      VPInfinit Simul => vf [] vinf
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


}
