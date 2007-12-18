--# -path=.:../abstract:../common:../../prelude

concrete CatRus of Cat = CommonX ** open ResRus, Prelude in {

  flags optimize=all_subs ; coding=utf8 ;

  lincat

-- Tensed/Untensed

   S  = {s : Str} ;
   QS = {s :                 QForm => Str} ;
   RS = {s :                   GenNum => Case => Animacy => Str} ;
   SlashS = {s : Str; s2: Str ; c: Case} ;

-- Sentence
   -- clause (variable tense) e.g. "John walks"/"John walked"
   Cl ={s : Polarity => ClForm => Str} ;
   Slash = {s : Polarity => ClForm => Str; s2: Str; c: Case} ;
   Imp = { s: Polarity => Gender => Number => Str } ;

-- Question

    QCl = {s :Polarity => ClForm => QForm => Str};  
    IP = { s : PronForm => Str ; n : Number ; p : Person ;
           g: PronGen ; anim : Animacy ;  pron: Bool} ;     
    IComp = {s : Str} ;    
    IDet = Adjective ** {n: Number; g: PronGen; c: Case} ; 

-- Relative

    RCl = {s :  Polarity => ClForm => GenNum => Case => Animacy => Str} ;
    RP = {s :                   GenNum => Case => Animacy => Str} ;

-- Verb
   -- Polarity =>
   Comp, VP = {s : ClForm => GenNum => Person => Str ; asp : Aspect ; w: Voice} 
          ** {s2 : Str ; s3 : Gender => Number => Str ; negBefore: Bool} ;


-- Adjective
    
    AP = {s : AdjForm => Str; p : IsPostfixAdj} ; 

-- Noun

    CN = {s : Number => Case => Str; g : Gender; anim : Animacy} ;  
    NP = { s : PronForm => Str ; n : Number ; p : Person ;
           g: PronGen ; anim : Animacy ;  pron: Bool} ;     
    Pron = { s : PronForm => Str ; n : Number ; p : Person ;
           g: PronGen ;  pron: Bool} ;     

-- Determiners (only determinative pronouns 
-- (or even indefinite numerals: "много" (many)) in Russian) are inflected 
-- according to the gender of nouns they determine.
-- extra parameters (Number and Case) are added for the sake of                            	
-- the determinative pronoun "bolshinstvo" ("most");
-- Gender parameter is due to multiple determiners (Numerals in Russian)
-- like "mnogo"
-- The determined noun has the case parameter specific for the determiner
--- DEPREC    QuantSg, QuantPl , 
    Det = {s : AdjForm => Str; n: Number; g: PronGen; c: Case} ; 
    Predet, Quant= {s : AdjForm => Str; g: PronGen; c: Case} ; 

-- Numeral

    Num, Numeral = {s : Case => Gender => Str ; n : Number} ;
    Digits = {s : Str ; n : Number} ; ---- 
    
-- Structural
-- The conjunction has an inherent number, which is used when conjoining
-- noun phrases: "Иван и Маша поют" vs. "Иван или Маша поет"; in the
-- case of "или", the result is however plural if any of the disjuncts is.

    Conj = {s : Str ; n : Number} ;  
    DConj = {s1,s2 : Str ; n : Number} ; 
    Subj = {s : Str} ;
    Prep = {s : Str ; c: Case } ;

-- Open lexical classes, e.g. Lexicon

    V, VS, VV, VQ, VA = Verbum ; -- = {s : VerbForm => Str ; asp : Aspect } ;
    V2, V2A = Verbum ** Complement ; 
    V3 = Verbum ** Complement** {s4 : Str; c2: Case} ; 
--    VV = {s : VVForm => Str ; isAux : Bool} ;

    Ord =  {s : AdjForm => Str} ;
    A =  {s : Degree => AdjForm => Str} ;
    A2 = A ** Complement ;

 -- Substantives moreover have an inherent gender. 
    N = {s : SubstForm => Str ; g : Gender ; anim : Animacy } ;   
    N2 = {s : Number => Case => Str; g : Gender; anim : Animacy} ** Complement ;
    N3 = {s : Number => Case => Str; g : Gender; anim : Animacy} ** Complement ** {s3 : Str; c2: Case} ;
    PN = {s :  Case => Str ; g : Gender ; anim : Animacy} ;

}

