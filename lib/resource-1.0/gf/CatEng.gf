concrete CatEng of Cat = open ResEng, Prelude in {

  lincat
    Text, Phr, Utt = {s : Str} ;

    Imp = {s : Polarity => Number => Str} ;

    S  = {s : Str} ;
    QS = {s : QForm => Str} ;
    RS = {s : Agr => Str} ;

    Cl    = {s : Tense => Anteriority => Polarity => Ord => Str} ;
    Slash = {s : Tense => Anteriority => Polarity => Ord => Str} ** {c2 : Str} ;

    QCl   = {s : Tense => Anteriority => Polarity => QForm => Str} ;
    RCl   = {s : Tense => Anteriority => Polarity => Agr => Str} ;

    VP = {
      s  : Tense => Anteriority => Polarity => Ord => Agr => {fin, inf : Str} ; 
      s2 : Agr => Str
      } ;

    V, VS, VQ = Verb ; -- = {s : VForm => Str} ;
    V2, VV = Verb ** {c2 : Str} ;
    V3 = Verb ** {c2, c3 : Str} ;

    AP = {s : Agr => Str ; isPre : Bool} ; 
    Comp = {s : Agr => Str} ; 

    A  = {s : AForm => Str} ;
    A2 = {s : AForm => Str ; c2 : Str} ;

    Adv, AdV, AdA, AdS = {s : Str} ;
    Prep = {s : Str} ;

    Det, Quant = {s : Str ; n : Number} ;
    Predet, Num, Ord = {s : Str} ;

    CN,N = {s : Number => Case => Str} ;
    PN = {s : Case => Str} ;
    Pron, NP = {s : Case => Str ; a : Agr} ;
    N2 = {s : Number => Case => Str} ** {c2 : Str} ;
    N3 = {s : Number => Case => Str} ** {c2,c3 : Str} ;

    IP = {s : Case => Str ; n : Number} ;
    IDet = {s : Str ; n : Number} ;
    IAdv = {s : Str} ;    

    RP = {s : Case => Str ; a : RAgr} ;

    Numeral = {s : CardOrd => Str ; n : Number} ;

    CAdv = {s : Str} ;    

    Conj = {s : Str ; n : Number} ;
    DConj = {s1,s2 : Str ; n : Number} ;

    SeqS = {s1,s2 : Str} ;
    SeqAdv = {s1,s2 : Str} ;
    SeqNP = {s1,s2 : Case => Str ; a : Agr} ;
    SeqAP = {s1,s2 : Agr => Str ; isPre : Bool} ;

}
