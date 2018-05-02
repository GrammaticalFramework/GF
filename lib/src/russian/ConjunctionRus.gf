--# -path=.:../abstract:../common:../../prelude

concrete ConjunctionRus of Conjunction = 
  CatRus ** open ResRus, Coordination, Prelude in {

  flags optimize=all_subs ;  coding=utf8 ;

  lin

    ConjS = conjunctDistrSS ;

    ConjAdv = conjunctDistrSS ;
                                                    
    ConjNP c xs =
    conjunctDistrTable PronForm c xs ** {n = conjNumber c.n xs.n ; 
      p = xs.p ; pron = xs.pron ; anim = xs.anim ; 
       g = xs.g } ;
        
    ConjAP or xs = 
      {s = \\af => case af of  {
        AF c a gn => or.s1++ xs.s1 ! AF c a gn ++ or.s2 ++ xs.s2 ! AF c a gn ;
        AFShort gn => case xs.preferShort of {
          PrefShort => or.s1++ xs.s1 ! AFShort gn ++ or.s2 ++ xs.s2 ! AFShort gn ;
          _ => or.s1++ xs.s1 ! AF Nom Inanimate gn ++ or.s2 ++ xs.s2 ! AF Nom Inanimate gn} ;
        AdvF => or.s1++ xs.s1 ! AdvF ++ or.s2 ++ xs.s2 ! AdvF 
        } ;
     p = xs.p ;
     preferShort = xs.preferShort 
      } ;

  ---- AR 17/12/2008
    ConjRS c xs = conjunctDistrTable3 GenNum Case Animacy c xs ** {p = xs.p} ;

-- These fun's are generated from the list cat's.

    BaseS = twoSS ;
    ConsS = consrSS comma ;
    BaseAdv = twoSS ;
    ConsAdv = consrSS comma ;


    ConsNP  x xs =
    consTable PronForm comma xs x ** 
       {n = conjNumber xs.n x.n ; g = conjPGender x.g xs.g ;
          anim = conjAnim x.anim xs.anim ;
          p = conjPerson xs.p x.p; pron = conjPron xs.pron x.pron} ;
      
    ConsAP x xs = consTable AdjForm comma xs x ** {p = andB xs.p x.p ; preferShort = selectAPForm x.preferShort xs.preferShort} ;

    BaseAP x y = twoTable AdjForm x y ** {p = andB x.p y.p ; preferShort = selectAPForm x.preferShort y.preferShort} ;

    BaseNP x y = twoTable PronForm x y ** {n = conjNumber x.n y.n ; 
       g = conjPGender x.g y.g ; p = conjPerson x.p y.p ;
       pron = conjPron x.pron y.pron ; anim = conjAnim x.anim y.anim } ;

  ---- AR 17/12/2008
    BaseRS x y = twoTable3 GenNum Case Animacy x y ** {c = y.c} ;
    ConsRS xs x = consrTable3 GenNum Case Animacy comma xs x ** {c = xs.c} ;

  oper
    selectAPForm : ShortFormPreference -> ShortFormPreference -> ShortFormPreference = \sfp1,sfp2 -> 
      case <sfp1,sfp2> of 
        {<PrefShort, PrefShort> => PrefShort ; 
         _ => PrefFull
        } ;
  
  lincat
    [S] = {s1,s2 : Str} ;
    [Adv] = {s1,s2 : Str} ;
 -- The structure is the same as for sentences. The result is either always plural
 -- or plural if any of the components is, depending on the conjunction.
    [NP] = { s1,s2 : PronForm => Str ; g: PronGen ; 
             anim : Animacy ; n : Number ; p : Person ;  pron : Bool } ;
 -- The structure is the same as for sentences. The result is a prefix adjective
 -- if and only if all elements are prefix.
    [AP] =  {s1,s2 : AdjForm => Str ; p : Bool ; preferShort : ShortFormPreference} ;

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

-- For pron, we let the latter argument win - "Маша или моя мама" (Nominative case)
-- but - "моей или Машина мама" (Genetive case) both corresponds to 
-- "Masha's or my mother"), which is actually not exactly correct, since
-- different cases should be used - "Машина или моя мама".

  conjPron : Bool -> Bool -> Bool = \_,p -> 
    p ;

-- For gender in a similar manner as for person:
-- Needed for adjective predicates like:
-- "Маша или Оля - красивая", "Антон или Олег - красивый",
-- "Маша или Олег - красивый".
-- The later is not totally correct, but there is no correct way to say that.

  conjGender : Gender -> Gender -> Gender = \_,m -> m ; 
 conjPGender : PronGen -> PronGen -> PronGen = \_,m -> m ; 

  conjAnim : Animacy -> Animacy -> Animacy = \_,m -> m ; 


}

