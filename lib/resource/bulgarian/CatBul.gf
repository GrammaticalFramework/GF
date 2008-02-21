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
    IDet = {s : DGender => Case => Str; n : Number; countable : Bool; spec : Species} ;

-- Verb

    VP = {
      s : ResBul.Tense => Anteriority => Polarity => Agr => Str ;
      imp : Polarity => Number => Str ;
      s2 : Agr => Str
    } ;

    Comp = {s : Agr => Str} ; 

-- Adjective

    AP = {s : AForm => Str; isPre : Bool} ; 

-- Noun

    CN = {s : NForm => Str; g : DGender} ;
    NP = {s : Case => Str; a : Agr} ;
    Pron = {s : Case => Str; gen : AForm => Str; a : Agr} ;
    Det = {s : DGender => Case => Str ; n : Number; countable : Bool; spec : Species} ;
    Predet = {s : GenNum => Str} ;
    Ord = {s : AForm => Str; nonEmpty : Bool} ;
    Num = {s : DGenderSpecies => Str; n : Number; nonEmpty : Bool} ;
    Quant = {s : GenNum => Str; spec : Species} ;

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
    A2 = {s : AForm => Str ; c2 : Str} ;
    
    N = {s : NForm => Str; g : DGender} ;
    N2 = {s : NForm => Str; g : DGender} ** {c2 : Str} ;
    N3 = {s : NForm => Str; g : DGender} ** {c2,c3 : Str} ;
    PN = {s : Str; g : Gender} ;
}