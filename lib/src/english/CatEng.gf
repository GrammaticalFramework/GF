concrete CatEng of Cat = CommonX - [Pol,SC,CAdv] ** open ResEng, Prelude in {

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
    SC = {s : Agr => Str} ;

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
    DAP, Det = {s : Str ; sp : Gender => Bool => NPCase => Str ; n : Number ; hasNum : Bool} ;
    Predet = {s : Str} ;
    Ord = { s : Case => Str } ;
    Num  = {s,sp : Bool => Case => Str ; n : Number ; hasCard : Bool} ;
    Card = {s,sp : Bool => Case => Str ; n : Number} ;
    Quant = {s : Bool => Number => Str ; sp : Gender => Bool => Number => NPCase => Str; isDef : Bool} ;

-- Numeral

    Numeral = {s : CardOrd => Case => Str ; n : Number} ;
    Digits  = {s : CardOrd => Case => Str ; n : Number ; tail : DTail} ;

-- Structural

    Conj = {s1,s2 : Str ; n : Number} ;
    Subj = {s : Str} ;
    Prep = {s : Str; isPre : Bool} ;
    CAdv = {s : Polarity => Str; p : Str} ;

-- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = Verb ; -- = {s : VForm => Str} ;
    V2, V2A, V2Q, V2S = Verb ** {c2 : Str} ;
    V3 = Verb ** {c2, c3 : Str} ;
    VV = {s : VVForm => Str ; p : Str ; typ : VVType} ;
    V2V = Verb ** {c2,c3 : Str ; typ : VVType} ;

    A = {s : AForm => Str ; isPre : Bool} ;
    A2 = {s : AForm => Str ; c2 : Str ; isPre : Bool} ;

    N = {s : Number => Case => Str ; g : Gender} ;
    N2 = {s : Number => Case => Str ; g : Gender} ** {c2 : Str} ;
    N3 = {s : Number => Case => Str ; g : Gender} ** {c2,c3 : Str} ;
    PN = {s : Case => Str ; g : Gender} ;

  lindef
    SSlash = \s -> {s = s; c2 = ""} ;
    ClSlash = \s -> {s = \\t,a,p,o => s; c2 = ""} ;

    VP = \s -> predV {s = \\_ => s; p = ""; isRefl = False} ;
    VPSlash = \s -> predV {s = \\_ => s; p = ""; isRefl = False} ** {c2 = ""; gapInMiddle = False; missingAdv = False } ;

    V, VS, VQ, VA = \s -> {s = \\_ => s; p = ""; isRefl = False} ;
    V2, V2A, V2Q, V2S = \s -> {s = \\_ => s; p = ""; isRefl = False; c2=""} ;
    V3 = \s -> {s = \\_ => s; p = ""; isRefl = False; c2,c3=""} ;
    VV = \s -> {s = \\_ => s; p = ""; isRefl = False; typ = VVInf} ;
    V2V = \s -> {s = \\_ => s; p = ""; isRefl = False; c2,c3="" ; typ = VVInf} ;

    A = \s -> {s = \\_ => s; isPre = True} ;
    A2 = \s -> {s = \\_ => s; c2 = ""; isPre = True} ;

    N = \s -> {s = \\_,_ => s; g = Neutr} ;
    N2 = \s -> {s = \\_,_ => s; c2 = ""; g = Neutr} ;
    N3 = \s -> {s = \\_,_ => s; c2,c3 = ""; g = Neutr} ;

  linref
    SSlash = \ss -> ss.s ++ ss.c2 ;
    ClSlash = \cls -> cls.s ! Pres ! Simul ! CPos ! oDir ++ cls.c2 ;

    VP = \vp -> infVP VVAux vp False Simul CPos (agrP3 Sg) ;
    VPSlash = \vps -> infVP VVAux vps False Simul CPos (agrP3 Sg) ++ vps.c2;

    Conj = \conj -> conj.s1 ++ conj.s2 ;

    V, VS, VQ, VA = \v -> infVP VVAux (predV v) False Simul CPos (agrP3 Sg);
    V2, V2A, V2Q, V2S = \v -> infVP VVAux (predV v) False Simul CPos (agrP3 Sg) ++ v.c2;
    V3 = \v -> infVP VVAux (predV v) False Simul CPos (agrP3 Sg) ++ v.c2 ++ v.c3;
    VV = \v -> infVP VVAux (predVV v) False Simul CPos (agrP3 Sg) ;
    V2V = \v -> infVP VVAux (predVc v) False Simul CPos (agrP3 Sg) ;

    A = \a -> a.s ! AAdj Posit Nom ;
    A2 = \a -> a.s ! AAdj Posit Nom ++ a.c2 ;

    N = \n -> n.s ! Sg ! Nom ;
    N2 = \n -> n.s ! Sg ! Nom ++ n.c2 ;
    N3 = \n -> n.s ! Sg ! Nom ++ n.c2 ++ n.c3 ;

}
