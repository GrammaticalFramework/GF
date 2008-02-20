concrete CatBul of Cat = CommonX ** open ResBul, Prelude in {

  flags optimize=all_subs ;

  lincat

-- Tensed/Untensed

    S  = {s : Str} ;
    QS = {s : QForm => Str} ;

-- Sentence

    Cl = {s : ResBul.Tense => Anteriority => Polarity => Order => Str} ;
    Imp = {s : Polarity => GenNum => Str} ;

-- Question

    QCl = {s : ResBul.Tense => Anteriority => Polarity => QForm => Str} ;
    IP = {s : Str ; gn : GenNum} ;
    IComp = {s : Str} ;    
    IDet = {s : Gender => Str ; n : Number; spec : Species} ;

-- Verb

    VP = {
      s : ResBul.Tense => Anteriority => Polarity => Agr => Str ;
      imp : Polarity => Number => Str ;
      s2 : Agr => Str
    } ;

    Comp = {s : Agr => Str} ; 

-- Noun

    CN = {s : Number => Case => Species => Str; g : Gender} ;
    NP, Pron = {s : Case => Str ; a : Agr} ;
    Det = {s : Gender => Str ; n : Number; spec : Species} ;
    Num = {s : Str; n : Number } ;
    Quant = {s : AForm => Str; spec : Species} ;

-- Numeral

    Numeral = {s : CardOrd => Str; n : Number} ;
    Digits  = {s : CardOrd => Str; n : Number; tail : DTail} ;

-- Structural

    Subj = {s : Str} ;
    Prep = {s : Str} ;

-- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = Verb ;
    V2, V2A = Verb ** {c2 : Str} ;
    V3 = Verb ** {c2, c3 : Str} ;

    A = {s : AForm => Str} ;
    
    N = {s : AForm => Str; g : Gender} ;
}