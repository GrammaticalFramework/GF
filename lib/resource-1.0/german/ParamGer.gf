--1 German parameters
--
-- This module defines the parameter types specific to German.
-- Some parameters, such as $Number$, are inherited from $ParamX$.
--

resource ParamGer = ParamX ** {

--2 For $Noun$

-- These are the standard four-value case and three-value gender.

  param
    Case = Nom | Acc | Dat | Gen ;
    Gender = Masc | Fem | Neutr ;

-- Complex $CN$s, like adjectives, have strong and weak forms.

    Adjf = Strong | Weak ;

-- Gender distinctions are only made in the singular. 

    GenNum = GSg Gender | GPl ;

---- Agreement of $NP$ is a record. We'll add $Gender$ later.
--
  oper Agr = {n : Number ; p : Person} ;

----2 For $Adjective$

-- The predicative form of adjectives is not inflected further.

  param 
    AForm = APred | AMod Adjf GenNum Case ;  


--2 For $Verb$

  param VForm = 
     VInf 
   | VPresInd  Number Person
   | VPresSubj Number Person
   | VImper    Number
   | VImpfInd  Number Person 
   | VImpfSubj Number Person 
   | VPresPart AForm 
   | VPastPart AForm ;

-- The order of sentence is depends on whether it is used as a main
-- clause, inverted, or subordinate.

    Order = ODir | OQuest ;
--
--
----2 For $Relative$
-- 
--    RAgr = RNoAg | RAg {n : Number ; p : Person} ;
--
----2 For $Numeral$
--
--    CardOrd = NCard | NOrd ;
--    DForm = unit | teen | ten  ;
--
----2 Transformations between parameter types
--
--  oper
--    agrP3 : Number -> Agr = \n -> 
--      {n = n ; p = P3} ;
--
--    conjAgr : Agr -> Agr -> Agr = \a,b -> {
--      n = conjNumber a.n b.n ;
--      p = conjPerson a.p b.p
--      } ;
--
}
