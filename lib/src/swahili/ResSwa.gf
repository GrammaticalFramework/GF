--# -path=.:../abstract:../common:../../prelude

--1 Swahili auxiliary operations.

-- This module contains operations that are needed to make the
-- resource syntax work. To define everything that is needed to
-- implement $Test$, it moreover contains regular lexical
-- patterns needed for $Lex$.

resource ResSwa = ParamX ** open Prelude in {

  flags optimize=all ;

--For $Noun$

-- This is the worst-case $Case$ needed for pronouns.

  param Case = Nom | Loc ;

  param Animacy = AN | IN ;

  param Gender = g1_2 | g3_4 | g5_6 | g5a_6 | g6 | g7_8 | g9_10 | g11 | g11_6 | g11_10 ; 

--2 For $Adjective$

   AForm = AF Number Gender Animacy 
	 | AA ;
 
-- The order of sentence is needed already in $VP$.

    Order = ODir | OQuest ;

 --2 For $Verb$

-- Verbs will take one of the five forms

  param 
	VForm = VInf
	       | VImper Number Person
	       | VPres Number Gender Animacy Person
               | VPast Number Gender Animacy Person
               | VFut Number Gender Animacy Person;

	
  oper

   Verb : Type = {s : VForm => Str} ;


   VerbForms : Type =  Tense => Anteriority => Polarity => Agr => Str ;

    VP : Type = {
    s  : VerbForms ;
    s2 : Agr => Str
    } ;

	
  mkV : Str -> {s : VForm => Str} = 
     \cheza -> {
     s = table { 
       VInf => case Predef.take 2 cheza of { 
		"ku" => cheza;
		 _ => "ku"+cheza
	 };
       VImper n p => case <n,p> of{
		  <Sg,P2> => init cheza + "eni";
		  <_,_> => cheza}; 
       VPres n g anim p => Verbprefix n g anim p + "na" + cheza; 
       VPast n g anim p => Verbprefix n g anim p + "li" + cheza ;
       VFut n g anim p => Verbprefix n g anim p + "ta" + cheza     
       } 
     } ;

   
  predV : Verb -> VP = \verb -> {
    s = \\t,ant,b,agr => 
      let
        inf  = verb.s ! VInf ;
        imper = verb.s ! VImper agr.n agr.p;
        pres = verb.s ! VPres agr.n agr.g agr.anim agr.p ;
        past  = verb.s ! VPast agr.n agr.g agr.anim agr.p ;
        fut = verb.s ! VFut agr.n agr.g agr.anim agr.p ; 
      in
      case <t,ant,b> of {
        <_,Anter,Pos> => imper;
        <Pres,Simul,Pos> => pres  ;
	<Past,Anter,Pos> => past ;
	<Fut, Anter,Pos> => fut ;
	<_,_,_> => inf
               
        } ;
    s2 = \\_ => []
    } ;

  
  Verbprefix : Number -> Gender -> Animacy -> Person -> Str = \n,g,anim,p ->
   case <anim,n,g,p> of {
    <AN,Sg,_,P1>      => "ni" ;
    <AN,Sg,_,P2>      => "u" ;
    <AN,Pl,_,P1>      => "tu" ;
    <AN,Pl,_,P2>      => "m" ;
    <AN,Sg,_,_>      => "a" ;
    <AN,Pl,_,_>      => "wa" ;
    <_,Sg,g1_2,_>   => "a" ;
    <_,Pl,g1_2,_>   => "wa" ;
    <_,Sg,g3_4,_>   => "u" ;
    <_,Pl,g3_4,_>   => "i"  ;
    <_,Sg,g5_6,_>   => "li" ;
    <_,Pl,g5_6,_>   => "ya" ;
    <_,Sg,g5a_6,_>  => "li" ;
    <_,Pl,g5a_6,_>  => "ya" ;
    <IN,_,g6,_>     => "ya" ;
    <IN,Sg,g7_8,_>   => "ki" ;
    <IN,Pl,g7_8,_>   => "vi" ;
    <IN,Sg,g9_10,_>  => "i" ;
    <IN,Pl,g9_10,_>  => "zi" ;
    <IN,_,g11,_>     => "u" ;
    <IN,Sg,g11_6,_>  => "u" ;
    <IN,Pl,g11_6,_>  => "ya" ;
    <IN,Sg,g11_10,_> => "u" ;
    <IN,Pl,g11_10,_> => "zi"  
   } ;





  

-- Auxiliary verbs have special negative forms.
param
    VVForm = 
       VVF VForm
     | VVPresNeg
     | VVPastNeg  --# notpresent
     ; 
                
--Adjectives 

 oper Adj = {s : AForm => Str} ;

--2 For $Quantifiers$
-- A 3-dimensional system of quantifiers (demonstrative pronouns) based on position of object, hearer + speaker
-- need to find linguistic term to express this

   param Spatial = SpHrObj | SpHr | HrObj ;    --w.r.t object	

-- Agreement of adjectives, verb phrases, and relative pronouns.

oper
  AGR = {n : Number ; g : Gender ; anim : Animacy ; p : Person} ;
  Agr : Type = {n : Number ; g : Gender ; anim : Animacy ; p : Person} ;
  agr : Number -> Gender -> Animacy -> Person -> Agr = \n,g,anim,p -> {n = n ; g = g ; anim = anim ; p = p} ;

-- For $Sentence$.

 Clause : Type = {
    s : Tense => Anteriority => Polarity => Str
    } ;

  mkClause : Str -> Agr -> VP -> Clause =
    \subj,agr,vp -> {
      s = \\t,a,b => 
        let 
          verb  = vp.s ! t ! a ! b ! agr 
        in
          subj ++ verb
    } ;


}
