interface DiffScand = open ResScand, Prelude in {

-- Parameters.

  param
    Gender ;

  oper
    neutrum, utrum : Gender ;

    gennum : Gender -> Number -> GenNum ;

    agrP3 : Gender -> Number -> Agr = \g,n -> {
      gn = gennum g n ;
      p = P3
      } ;

-- This is the form of the noun in "det stora berget"/"det store berg".

    detDef : Species ;

-- Strings.

    conjThat : Str ;
    conjThan : Str ;
    infMark  : Str ;

    artIndef : Gender => Str ;

    verbHave : {s : VForm => Str} ;

    auxFut : Str ;
    auxCond : Str ;

    negation : Polarity => Str ;

-- This function is here because it depends on $verbHave, auxFut, auxCond$.

  predV : Verb -> VP = \verb -> 
    let
      vfin : Tense -> Str = \t -> verb.s ! vFin t Act ;
      vsup = verb.s ! VI (VSupin Act) ;  
      vinf = verb.s ! VI (VInfin Act) ;

      har : Tense -> Str = \t -> verbHave.s ! vFin t Act ;
      ha  : Str = verbHave.s ! VI (VInfin Act) ;

      vf : Str -> Str -> {fin,inf : Str} = \fin,inf -> {
        fin = fin ; inf = inf
        } ;

    in {
    s = table {
      VFinite t Simul => case t of {
        Pres | Past => vf (vfin t) [] ;
        Fut  => vf auxFut vinf ;
        Cond => vf auxCond vinf
        } ;
      VFinite t Anter => case t of {
        Pres | Past => vf (har t) vsup ;
        Fut  => vf auxFut (ha ++ vsup) ;
        Cond => vf auxCond (ha ++ vsup) 
        } ;
      VImperat => vf (verb.s ! VF (VImper Act)) [] ;
      VInfinit Simul => vf [] vinf ;
      VInfinit Anter => vf [] (ha ++ vsup)
      } ;
    a1  : Polarity => Str = negation ;
    n2  : Agr  => Str = \\_ => [] ;
    a2  : Str = [] ;
    ext : Str = [] ;
    en2,ea2,eext : Bool = False   -- indicate if the field exists
    } ;

}
