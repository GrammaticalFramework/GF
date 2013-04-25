concrete CatGre of Cat = CommonGre ** open ResGre, Prelude in {

  flags coding =utf8 ;

  lincat


    S  = {s : Mood => Str} ;

    QS  = {s : QForm => Str} ; 

    RS = {s : Mood => Agr => Str ; c : Case} ;  

    SSlash = { s  : AAgr => Mood => Str ;n3 : Agr => Str ; c2 : Compl} ;

    Cl = {s :Order => ResGre.TTense => Anteriority =>  Polarity => Mood =>  Str} ; 

    ClSlash = {s : AAgr => Order =>  ResGre.TTense => Anteriority => Polarity => Mood => Str ;n3 : Agr => Str ; c2 : Compl} ; 

    Imp = {s : Polarity =>  Number => Aspect => Str } ;

    QCl = {s : ResGre.TTense => Anteriority => Polarity => QForm => Str} ; 

    IP = {s : Gender => Case => Str ;  n : Number ;a : AAgr};

    IComp = {s : Str} ;    

    IDet   = {s : Gender => Case => Str ; n : Number} ;

    IQuant = {s : Number => Gender => Case => Str } ;

    RCl  = {s : Agr => ResGre.TTense => Anteriority => Polarity => Mood => Str ;  c : Case } ;  

    RP   = {s : Bool => AAgr =>  Case => Str ; a : AAgr ; hasAgr : Bool} ;

    VP = ResGre.VP ;

    VPSlash = ResGre.VP ** {n3 : Agr => Str ; c2 : Compl} ;

    Comp = {s : Agr => Str} ; 

    AP = ResGre.Adj ;

  
-- Noun

    CN = Noun ;

    NP =NounPhrase; 

    Pron = Pronoun ;

    Det = {s : Gender => Case => Str ; sp : Gender => Case => Str ;  n : Number  ;isNeg : Bool};

    Predet = {s :Number =>  Gender => Case =>Str} ;

    Ord = {s :Degree => Gender => Number => Case => Str ; adv : Degree => Str } ;

    Num  = {s : Gender => Case => Str ; isNum : Bool ; n : Number} ;

    Card = {s : Gender => Case => Str ; n : Number} ;

    Quant = ResGre.Quantifier;
 

-- Numerals

    Numeral = {s : CardOrd => Str ; n : Number } ;

    Digits  = {s : CardOrd => Str ; n : Number} ;

-- Structural
   
    Conj = {s1,s2 : Str ; n : Number} ;

    Subj = {s : Str ; m : Mood} ;

    Prep = {s : Str ; c : Case ; isDir : Bool} ;


-- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = Verb ; 

    V2, VV, V2S, V2Q = Verb ** {c2 : Compl} ;

    V3, V2V,V2A = Verb ** {c2, c3 : Compl} ;

    A = ResGre.Adj ; --{s : Degree => Gender => Number => Case => Str } ;

    A2 = {s :Degree => Gender => Number => Case => Str ; adv : Degree => Str ;c2 : Compl }  ;
    

    N = Noun;

    N2 = {s : Number => Case => Str ; g : Gender} ** {c2 : Compl} ;

    N3 = {s : Number => Case => Str ; g : Gender} ** {c2,c3 : Compl} ;

    PN = PName ;

}
