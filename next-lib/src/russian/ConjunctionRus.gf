--# -path=.:../abstract:../common:../../prelude

concrete ConjunctionRus of Conjunction = 
  CatRus ** open ResRus, Coordination, Prelude in {

  flags optimize=all_subs ;  coding=utf8 ;

  lin

    ConjS = conjunctDistrSS ;

    ConjAdv = conjunctDistrSS ;
                                                    
    ConjNP c xs = conjunctDistrTable PronForm c xs ** {
       a = {n = conjNumber c.n xs.a.n;
            p = xs.a.p;
            g = xs.a.g
           };
       anim = xs.anim
       } ;

    ConjAP c xs = conjunctDistrTable AdjForm c xs ** {p = xs.p} ;

  ---- AR 17/12/2008
    ConjRS c xs = conjunctDistrTable3 GenNum Case Animacy c xs ** {p = xs.p} ;

-- These fun's are generated from the list cat's.

    BaseS = twoSS ;
    ConsS = consrSS comma ;
    BaseAdv = twoSS ;
    ConsAdv = consrSS comma ;


    ConsNP  x xs = consTable PronForm comma xs x ** {
       a = {n = conjNumber xs.a.n x.a.n;
            g = conjPGender x.a.g xs.a.g;
            p = conjPerson xs.a.p x.a.p
           };
       anim = conjAnim x.anim xs.anim
       } ;
      
    ConsAP x xs = consTable AdjForm comma xs x ** {p = andB xs.p x.p} ;


    BaseAP x y = twoTable AdjForm x y ** {p = andB x.p y.p} ;

    BaseNP x y = twoTable PronForm x y ** {
       a = {n = conjNumber x.a.n y.a.n; 
            g = conjPGender x.a.g y.a.g;
            p = conjPerson x.a.p y.a.p
           };
       anim = conjAnim x.anim y.anim
       } ;

  ---- AR 17/12/2008
    BaseRS x y = twoTable3 GenNum Case Animacy x y ** {c = y.c} ;
    ConsRS xs x = consrTable3 GenNum Case Animacy comma xs x ** {c = xs.c} ;



  lincat
    [S] = {s1,s2 : Str} ;
    [Adv] = {s1,s2 : Str} ;
 -- The structure is the same as for sentences. The result is either always plural
 -- or plural if any of the components is, depending on the conjunction.
    [NP] = {s1,s2 : PronForm => Str; a : Agr; anim : Animacy} ;
 -- The structure is the same as for sentences. The result is a prefix adjective
 -- if and only if all elements are prefix.
    [AP] =  {s1,s2 : AdjForm => Str ; p : Bool} ;

  ---- AR 17/12/2008
   [RS] = {s1,s2 : GenNum => Case => Animacy => Str} ;

oper

-- We have to define a calculus of numbers of persons. For numbers,
-- it is like the conjunction with $Pl$ corresponding to $False$.
--
-- The following are given in $ParamX$.
--
--  conjNumber : Number -> Number -> Number = \m,n -> case <m,n> of {
--    <Sg,Sg> => Sg ;
--    _ => Pl 
--    } ;

-- For persons, we let the latter argument win ("либо ты, либо я пойду"
-- but "либо я, либо ты пойдешь"). This is not quite clear.

--  conjPerson : Person -> Person -> Person = \_,p -> 
--    p ;

-- For gender in a similar manner as for person:
-- Needed for adjective predicates like:
-- "Маша или Оля - красивая", "Антон или Олег - красивый",
-- "Маша или Олег - красивый".
-- The later is not totally correct, but there is no correct way to say that.

  conjGender : Gender -> Gender -> Gender = \_,m -> m ; 
 conjPGender : PronGen -> PronGen -> PronGen = \_,m -> m ; 

  conjAnim : Animacy -> Animacy -> Animacy = \_,m -> m ; 


}

