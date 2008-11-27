--# -path=.:../abstract:../common:../../prelude

concrete CatRus of Cat = CommonX ** CatSlavic with (ResSlavic = ResRus) ** open ResRus, Prelude, (R = ParamX) in {

  flags optimize=all_subs ; coding=utf8 ;

  lincat

-- Tensed/Untensed

   S  = {s : Str} ;
   QS = {s :                 QForm => Str} ;
   RS = {s :                   GenNum => Case => Animacy => Str} ;
   SSlash = {s : Str; s2: Str ; c: Case} ;

-- Sentence
   -- clause (variable tense) e.g. "John walks"/"John walked"
   Cl ={s : Polarity => ClForm => Str} ;
   ClSlash = {s : Polarity => ClForm => Str; s2: Str; c: Case} ;
   Imp = { s: Polarity => Gender => Number => Str } ;

-- Question

    QCl = {s :Polarity => ClForm => QForm => Str};  
    IP = { s : PronForm => Str ; n : Number ; p : Person ;
           g: PronGen ; anim : Animacy ;  pron: Bool} ;     
    IComp = {s : Str} ;    
    IDet = Adjective ** {n: Number; g: PronGen; c: Case} ; 
    IQuant = {s : Number => AdjForm => Str; g: PronGen; c: Case} ;  -- AR 16/6/2008

-- Relative

    RCl = {s :  Polarity => ClForm => GenNum => Case => Animacy => Str} ;
    RP = {s :                   GenNum => Case => Animacy => Str} ;

-- Verb
   -- Polarity =>
   Comp, VP = VerbPhrase ;  
   VPSlash = VerbPhrase ** {sc : Str ; c : Case} ;

-- Adjective
    
    AP = {s : AdjForm => Str; p : IsPostfixAdj} ; 

-- Noun

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

    Det = {s : AdjForm => Str; n: Number; g: PronGen; c: Case} ; 
    Predet, Quant, Art = {s : AdjForm => Str; g: PronGen; c: Case} ; 

-- Numeral

    Num, Numeral, Card = {s : Case => Gender => Str ; n : Number} ;
    Digits = {s : Str ; n : Number} ; ---- 
    
-- Structural
-- The conjunction has an inherent number, which is used when conjoining
-- noun phrases: "Иван и Маша поют" vs. "Иван или Маша поет"; in the
-- case of "или", the result is however plural if any of the disjuncts is.

    Conj = {s1,s2 : Str ; n : Number} ; 

-- Open lexical classes, e.g. Lexicon

    V, VS, VV, VQ, VA = Verbum ; -- = {s : VerbForm => Str ; asp : Aspect } ;
    V2, V2A = Verbum ** Complement ; 
    V2V, V2S, V2Q = Verbum ** Complement ; --- AR 
    V3 = Verbum ** Complement** {s4 : Str; c2: Case} ; 
--    VV = {s : VVForm => Str ; isAux : Bool} ;

    Ord =  {s : AdjForm => Str} ;
    A =  {s : Degree => AdjForm => Str} ;
    A2 = A ** Complement ;

 -- Substantives moreover have an inherent gender. 
    PN = {s :  Case => Str ; g : Gender ; anim : Animacy} ;


}

