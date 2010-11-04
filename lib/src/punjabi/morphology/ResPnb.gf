--# -path=.:prelude
--
--1 Punjabi auxiliary operations.
--
-- This module contains operations that are needed to make the
-- morphology work. 

resource ResPnb = open Prelude, Predef in {

  flags optimize = noexpand ;
  coding = utf8;

  param 
    Number = Sg | Pl ;
    Case = Dir | Obl | Voc | Abl ;
    Gender = Masc | Fem ;
    Tense = Subj | Perf | Imperf;
    Person = Pers1
	    | Pers2_Casual
	    | Pers2_Respect
	    | Pers3_Near
	    | Pers3_Distant;
    

    VerbForm1 =
       MVF1 Tense Person Number Gender -- 3*5*2*2=60
      | Caus1 Tense Person Number Gender -- 60
      | Caus2 Tense Person Number Gender -- 60
      | Inf | Inf_Fem | Inf_Obl | Ablative -- 13
      | Caus1_Inf | Caus1_Fem | Caus1_Obl | Caus1_Ablative
      | Caus2_Inf | Caus2_Fem | Caus2_Obl | Caus2_Ablative
      | Root ;

    VerbForm4 =
        MVF4 Tense Person Number Gender
      | Inf4 | Inf_Fem4 | Inf_Obl4 | Ablative4
      | Root4 ;
      
  oper
    CommonVF = {s : Tense => Person => Number => Gender => Str} ;
    Noun = {s : Number => Case => Str ; g : Gender} ;
    Verb1 = {s : VerbForm1 => Str} ;    
    Verb4 = {s : VerbForm4 => Str} ;

    Adjective1 = {s : Gender => Number => Case => Str} ;
    Adjective2 = {s : Number => Case => Str} ;
    
    --Preposition = {s : Str};
    --DemPronForm = {s : Number => Gender => Case => Str};
    --PossPronForm = {s : Number => Gender => Case => Str};
    --Determiner = {s : Number => Gender => Str ; n : Number};
  
-- a useful oper
    eq : Str -> Str -> Bool = \s1,s2-> (pbool2bool (eqStr s1 s2)) ;

}
