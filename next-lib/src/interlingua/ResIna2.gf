--# -path=.:../abstract:../common:../../prelude

--1 Interlingua auxiliary operations.

-- This module contains operations that are needed to make the
-- resource syntax work. To define everything that is needed to
-- implement $Test$, it moreover contains regular lexical
-- patterns needed for $Lex$.

resource ResIna2 = ParamX ** open Prelude in {

  flags optimize=all ;


-- Some parameters, such as $Number$, are inherited from $ParamX$.

--2 For $Noun$

-- This is the worst-case $Case$ needed for pronouns.


  param
    VForm
      = VInf
      | VPres
      | VPPart
      | VPresPart
      | VPast      --# notpresent
      | VFut       --# notpresent
      | VCond      --# notpresent
      ;

  oper



    mkVerb : Str -> Verb = \crear->
      let crea = init crear
      in {s = table {
    	    VInf    => crear;
	    VPres   => crea;
	    VPast   => crea + "va"; 
	    VFut    => crear + "a"; 
	    VCondit => crear + "ea";
 	    VPPart  => case crear of {
 	      rid + "er" => rid + "ite";
 	      _         => crea + "te" 
 	      };
 	    VPresPart => case crear of {
 	      aud + "ir" => aud + "iente";
 	      _         => crea  + "nte"
 	      }}};


  ---- For $Verb$.
    --
    Verb : Type = {
      s : VForm => Str ;
      --    isRefl : Bool
      } ;


}
