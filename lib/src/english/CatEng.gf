concrete CatEng of Cat = CommonX - [Pol] ** open ResEng, Prelude in {

  flags optimize=all_subs ;

  lincat

-- exception to CommonX, due to the distinction contracted/uncontracted negation

    Pol = {s : Str ; p : CPolarity} ;

-- Tensed/Untensed

    S  = {s : Str} ;
    QS = {s : QForm => Str} ;
    RS = {s : Agr => Str ; c : NPCase} ; -- c for it clefts
    SSlash = {s : Str ; c2 : Str} ;

-- Sentence

    Cl = {s : ResEng.Tense => Anteriority => CPolarity => Order => Str} ;
    ClSlash = {
      s : ResEng.Tense => Anteriority => CPolarity => Order => Str ;
      c2 : Str
      } ;
    Imp = {s : CPolarity => ImpForm => Str} ;

-- Question

    QCl = {s : ResEng.Tense => Anteriority => CPolarity => QForm => Str} ;
    IP = {s : NPCase => Str ; n : Number} ;
    IComp = {s : Str} ;    
    IDet = {s : Str ; n : Number} ;
    IQuant = {s : Number => Str} ;

-- Relative

    RCl = {
      s : ResEng.Tense => Anteriority => CPolarity => Agr => Str ; 
      c : NPCase
      } ;
    RP = {s : RCase => Str ; a : RAgr} ;

-- Verb

    VP = ResEng.VP ;
    VPSlash = ResEng.SlashVP ;
    Comp = {s : Agr => Str} ; 

-- Adjective

    AP = {s : Agr => Str ; isPre : Bool} ; 

-- Noun

    CN = {s : Number => Case => Str ; g : Gender} ;
    NP = {s : NPCase => Str ; a : Agr} ;

    -- Pronoun
    -- In English, most of the personal pronouns have distinct
    -- case forms (nominative and accusative) which is why NPCase is used here.
    --
    -- Structure of a pronoun:
    --    gf             | form                | ex
    --    ---------------+---------------------+-------
    --    s (NCase Nom)  | Pers. pron. (subj.) | I
    --    s (NCase Gen)  | Poss. determiner    | my
    --    s NPAcc        | Pers. pron. (obj.)  | me
    --    s NPNomPoss    | Poss. pron. (subj.) | mine
    --    sp Nom         | Poss. pron. (subj.) | mine
    --    sp Gen         | Poss. pron. (obj.)  | mine's
    Pron = {s : NPCase => Str ; sp : Case => Str ; a : Agr} ;
    Det = {s : Str ; sp : NPCase => Str ; n : Number ; hasNum : Bool} ;
    Predet = {s : Str} ;
    Ord = { s : Case => Str } ;
    Num  = {s : Case => Str ; n : Number ; hasCard : Bool} ;
    Card = {s : Case => Str ; n : Number} ;
    Quant = {s : Bool => Number => Str ; sp : Bool => Number => NPCase => Str} ;

-- Numeral

    Numeral = {s : CardOrd => Case => Str ; n : Number} ;
    Digits  = {s : CardOrd => Case => Str ; n : Number ; tail : DTail} ;

-- Structural

    Conj = {s1,s2 : Str ; n : Number} ;
---b    Conj = {s : Str ; n : Number} ;
---b    DConj = {s1,s2 : Str ; n : Number} ;
    Subj = {s : Str} ;
    Prep = {s : Str} ;

-- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = Verb ; -- = {s : VForm => Str} ;
    V2, V2A, V2Q, V2S = Verb ** {c2 : Str} ;
    V3 = Verb ** {c2, c3 : Str} ;
    VV = {s : VVForm => Str ; p : Str ; typ : VVType} ;
    V2V = Verb ** {c2,c3 : Str ; typ : VVType} ;

    A = {s : AForm => Str} ;
    A2 = {s : AForm => Str ; c2 : Str} ;

    N = {s : Number => Case => Str ; g : Gender} ;
    N2 = {s : Number => Case => Str ; g : Gender} ** {c2 : Str} ;
    N3 = {s : Number => Case => Str ; g : Gender} ** {c2,c3 : Str} ;
    PN = {s : Case => Str ; g : Gender} ;

}
