--# -path=.:../../prelude



-- This resource morphology contains definitions needed in the resource
-- syntax. To build a lexicon, it is better to use $ParadigmsEng$, which
-- gives a higher-level access to this module.

resource MorphoGre = open Prelude, (Predef=Predef), ResGre in {

  flags coding=utf8 ;

--2 Determiners

  --oper 

  --mkDet : (s1,_,_,_,_,_,_,_,_ : Str)  ->  Number -> Det  = \mn,mg,ma,yn,yg,ya,nn,ng,na,n -> 
  -- {  
 -- s = table {
  --   Masc => table { Nom => mn ; Gen => mg ; Acc => ma } ;
  --   Fem => table { Nom => yn ; Gen => yg ; Acc => ya } ;
  --   Neut => table { Nom => nn ; Gen => ng ; Acc => na }
  --    } ;
  --   n = n ;
  --  } ;


--2 Pronouns


 --mkPronoun: (aftos,tou,ton : Str) -> Gender -> Number -> Person -> Pronoun = 
  --  \aftos,tou,ton,g,n,p -> {
   --   s = table {
   --     Nom => {clit = [] ; obj = aftos; isClit = False} ;
   --     Gen => {clit = tou ; obj = [] ; isClit = True} ;
   --     Acc => {clit = ton ; obj = [] ; isClit = True} 
    --    } ;
    --    g = g;
    --  a = Ag g n p 
    --  } ;

     --  mkPronoun: (aftos,tou,ton, afton : Str) -> Gender -> Number -> Person -> Pronoun = 
   -- \aftos,tou,ton,afton, g,n,p -> {
    --  s = table {
    --    Nom => {clit = [] ; obj = aftos; isClit = False ; emph = [] } ;
    --    Gen => {clit = tou ; obj = [] ; isClit = True ; emph = [] } ;
    --    Acc => {clit = ton ; obj = [] ; isClit = True ; emph = Preposition.c ++ afton} 
    --    } ;
    --    g = g;
    --  a = Ag g n p 
    --  } ;
    
      

   

} ;

