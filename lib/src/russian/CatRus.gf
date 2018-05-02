--# -path=.:../abstract:../common:../../prelude

concrete CatRus of Cat = CommonX ** open ResRus, Prelude in {

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
    
    AP = {s : AdjForm => Str ; p : IsPostfixAdj ; preferShort : ShortFormPreference} ; 

-- Noun

    CN = {nounpart : NForm => Str; relcl : Number => Case => Str; g : Gender; anim : Animacy} ;  
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

    Det = {s : Case => Animacy => Gender => Str; n: Number; g: PronGen; c: Case; size: Size} ; 
    Predet, Quant = {s : AdjForm => Str; g: PronGen; c: Case; size: Size} ; 

-- Numeral

    Num = {s : Gender => Animacy => Case => Str ; n : Number ; size: Size} ;
    Numeral, Card = {s : Gender => Animacy => Case => Str ; n : Number ; size: Size} ;
    Digits = {s : Str ; n : Number ; size: Size} ; ---- 
    
-- Structural
-- The conjunction has an inherent number, which is used when conjoining
-- noun phrases: "Иван и Маша поют" vs. "Иван или Маша поет"; in the
-- case of "или", the result is however plural if any of the disjuncts is.

    Conj = {s1,s2 : Str ; n : Number} ; 
    Subj = {s : Str} ;
    Prep = Complement ;

-- Open lexical classes, e.g. Lexicon

    V, VS, VV, VQ, VA = Verbum ; -- = {s : VerbForm => Str ; asp : Aspect } ;
    V2, V2A = Verbum ** {c2 : Complement} ; 
    V2V, V2S, V2Q = Verbum ** {c2 : Complement} ; --- AR 
    V3 = Verbum ** {c2,c3 : Complement} ; 
--    VV = {s : VVForm => Str ; isAux : Bool} ;

    Ord =  {s : AdjForm => Str} ;
    A =  {s : Degree => AdjForm => Str ; p : IsPostfixAdj ; preferShort : ShortFormPreference} ;
    A2 = A ** {c2 : Complement} ;

 -- Substantives moreover have an inherent gender. 
    N  = {s : NForm => Str; g : Gender; anim : Animacy} ;   
    N2 = {s : NForm => Str; g : Gender; anim : Animacy} ** {c2 : Complement} ;
    N3 = {s : NForm => Str; g : Gender; anim : Animacy} ** {c2,c3 : Complement} ;
    PN = {s :  Case => Str ; g : Gender ; anim : Animacy} ;


}

