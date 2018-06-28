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

    Noun = {s : Number => Species => Case => Str ; g : NGender ; co : Str} ; -- co = compounding form

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

      vf : Bool -> Str -> Str -> {fin,inf : Str ; a1  : Polarity => Agr => Str * Str} = \hasInf, fin,inf -> {
        fin = fin ;
	inf = inf ; 
	a1 : Polarity => Agr => Str*Str = \\p,a => case hasInf of {
	  True  => <negation ! p, []> ;
	  False => <[], negation ! p>
	  }
        } ;

    in {
    s = \\d => table {
      VPFinite t Simul => case t of {
--        SPres | SPast => vf (vfin d t) [] ; -- the general rule
        SPast => vf False (vfin d t) [] ;    --# notpresent
        SFut  => vf True auxFut (vinf d) ;    --# notpresent
        SFutKommer => vf True auxFutKommer (auxFutPart ++ infMark ++ vinf d) ;   --# notpresent
        SCond => vf True auxCond (vinf d) ;   --# notpresent
        SPres => vf False (vfin d t) []
        } ;
      VPFinite t Anter => case t of {    --# notpresent
        SPres | SPast => vf True (har t) (vsup d) ; --# notpresent
        SFut  => vf True auxFut (ha ++ vsup d) ; --# notpresent
        SFutKommer => vf True auxFutKommer (auxFutPart ++ infMark ++ ha ++ vsup d) ; --# notpresent
        SCond => vf True auxCond (ha ++ vsup d)  --# notpresent
        } ;                              --# notpresent
      VPImperat => vf False (verb.s ! VF (VImper (diath d))) [] ;
      VPInfinit Anter => vf True [] (ha ++ vsup d) ;  --# notpresent
      VPInfinit Simul => vf True [] (vinf d)
      } ;
    sp = table {
      PartPret a c   => verb.s ! (VI (VPtPret a c)) ;
      PartPres n s c => verb.s ! (VI (VPtPres n s c))
      } ;
    n1 : Agr => Str = \\a => case verb.vtype of {
        VRefl => reflPron a ;
        _ => []
        } ;
    n2  : Agr => Str = \\a => verb.part ; ---- check: hon ser (inte) vacker ut ; spotta (inte) ut snusen
    a2  : Str = [] ;
    ext : Str = [] ;
    en2,ea2,eext : Bool = False ;   -- indicate if the field exists
    isSimple = True
    } ;

}
