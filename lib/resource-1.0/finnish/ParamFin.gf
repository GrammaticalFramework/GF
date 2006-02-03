--1 Finnish parameters
--
-- This module defines the parameter types specific to Finnish.
-- Some parameters, such as $Number$, are inherited from $ParamX$.

resource ParamFin = ParamX ** open Prelude in {

--2 For $Noun$

-- This is the $Case$ as needed for both nouns and $NP$s.

  param
    Case = Nom | Gen | Part | Transl | Ess 
         | Iness | Elat | Illat | Adess | Ablat | Allat 
         | Abess ;  -- Comit, Instruct in NForm 

    NForm = NCase Number Case 
          | NComit | NInstruct  -- no number dist
          | NPossNom | NPossGenPl | NPossTransl Number | NPossIllat Number ;

-- Agreement of $NP$ is a record. We'll add $Gender$ later.

  oper
    Agr = {n : Number ; p : Person} ;

--
--2 Adjectives
--
-- The major division is between the comparison degrees. A degree fixed,
-- an adjective is like common nouns, except for the adverbial form.

param
  AForm = AN NForm | AAdv ;

oper
  Adjective : Type = {s : Degree => AForm => Str} ;

--2 Noun phrases
--
-- Two forms of *virtual accusative* are needed for nouns in singular, 
-- the nominative and the genitive one ("ostan talon"/"osta talo"). 
-- For nouns in plural, only a nominative accusative exist. Pronouns
-- have a uniform, special accusative form ("minut", etc).

param 
  NPForm = NPCase Case | NPAccNom | NPAccGen ;


--2 For $Verb$

-- A special form is needed for the negated plural imperative.

param
  VForm = 
     Inf
   | Presn Number Person
   | Impf Number Person
   | Condit Number Person
   | Imper Number
   | ImperP3 Number
   | ImperP1Pl
   | ImpNegPl
   | Pass Bool 
   | PastPartAct  AForm
   | PastPartPass AForm
   | Inf3Iness  -- 5 forms acc. to Karlsson
   | Inf3Elat
   | Inf3Illat
   | Inf3Adess
   | Inf3Abess
   ;

  SType = SDecl | SQuest ;

--2 For $Relative$
 
    RAgr = RNoAg | RAg {n : Number ; p : Person} ;

--2 For $Numeral$

    CardOrd = NCard | NOrd ;
    DForm = unit | teen | ten  ;

--2 Transformations between parameter types

  oper
    agrP3 : Number -> Agr = \n -> 
      {n = n ; p = P3} ;

    conjAgr : Agr -> Agr -> Agr = \a,b -> {
      n = conjNumber a.n b.n ;
      p = conjPerson a.p b.p
      } ;

}
