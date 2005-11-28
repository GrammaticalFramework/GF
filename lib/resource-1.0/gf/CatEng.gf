concrete CatEng of Cat = open ResEng, Prelude in {

  lincat
    S  = {s : Str} ;
    QS = {s : QForm => Str} ;

    Cl    = {s : Tense => Anteriority => Polarity => Ord => Str} ;
    Slash = {s : Tense => Anteriority => Polarity => Ord => Str} ** {c2 : Str} ;

    QCl   = {s : Tense => Anteriority => Polarity => QForm => Str} ;

    VP = {
      s  : Tense => Anteriority => Polarity => Ord => Agr => {fin, inf : Str} ; 
      s2 : Agr => Str
      } ;

    V, VS, VQ = Verb ; -- = {s : VForm => Str} ;
    V2, VV = Verb ** {c2 : Str} ;
    V3 = Verb ** {c2, c3 : Str} ;

    AP = {s : Str ; isPre : Bool} ; 
    Comp = {s : Agr => Str} ; 

    A  = {s : AForm => Str} ;
    A2 = {s : AForm => Str ; c2 : Str} ;

    Adv, AdV, AdA, AdS = {s : Str} ;

    Det, Quant = {s : Str ; n : Number} ;
    Predet, Num = {s : Str} ;

    CN,N = {s : Number => Case => Str} ;
    PN = {s : Case => Str} ;
    Pron, NP = {s : Case => Str ; a : Agr} ;
    N2 = {s : Number => Case => Str} ** {c2 : Str} ;
    N3 = {s : Number => Case => Str} ** {c2,c3 : Str} ;

    IP = {s : Case => Str ; n : Number} ;
    IDet = {s : Str ; n : Number} ;
    IAdv = {s : Str} ;    

    Numeral = {s : CardOrd => Str ; n : Number} ;

}
