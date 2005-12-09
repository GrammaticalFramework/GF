interface DiffScand = open ResScand, Prelude in {

-- Parameters.

  param
    Gender ;

  oper
    neutrum, utrum : Gender ;

    gennum : Gender -> Number -> GenNum ;

-- This is the form of the noun in "det stora berget"/"det store berg".

    detDef : Species ;

-- Strings.

    conjThat : Str ;
    conjThan : Str ;
    conjAnd  : Str ;
    infMark  : Str ;

    subjIf : Str ;

    artIndef : Gender => Str ;

    verbHave : {s : VForm => Str} ;
    verbBe   : {s : VForm => Str} ;

    auxFut : Str ;
    auxCond : Str ;

    negation : Polarity => Str ;

-- For determiners; mostly two-valued even in Norwegian.

    genderForms : (x1,x2 : Str) -> Gender => Str ;

-- The forms of a relative pronoun ("som", "vars", "i vilken").

    relPron : GenNum => RCase => Str ;

-- Pronoun "sådan" used in $Relative.RelCl$.

    pronSuch : GenNum => Str ;

-----------------------------------------------------------------------
--
-- The functions and parameters below are here because they depend on
-- the parametrized constants, but their definitions are fully given
-- here relative to the above.

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
      VPFinite t Simul => case t of {
        Pres | Past => vf (vfin t) [] ;
        Fut  => vf auxFut vinf ;
        Cond => vf auxCond vinf
        } ;
      VPFinite t Anter => case t of {
        Pres | Past => vf (har t) vsup ;
        Fut  => vf auxFut (ha ++ vsup) ;
        Cond => vf auxCond (ha ++ vsup) 
        } ;
      VPImperat => vf (verb.s ! VF (VImper Act)) [] ;
      VPInfinit Simul => vf [] vinf ;
      VPInfinit Anter => vf [] (ha ++ vsup)
      } ;
    a1  : Polarity => Str = negation ;
    n2  : Agr  => Str = \\_ => [] ;
    a2  : Str = [] ;
    ext : Str = [] ;
    en2,ea2,eext : Bool = False   -- indicate if the field exists
    } ;


}
