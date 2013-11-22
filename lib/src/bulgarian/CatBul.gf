--# -coding=cp1251
concrete CatBul of Cat = CommonX - [IAdv,CAdv] ** open ResBul, Prelude, Predef, (R = ParamX) in {

  flags 
    coding=cp1251; optimize=all_subs;

  lincat
-- Tensed/Untensed

    S  = {s : Str} ;
    QS = {s : QForm => Str} ;
    RS = {s : Agr => Str} ;
    SSlash = {s : Agr => Str ; c2 : Preposition} ;

-- Sentence

    Cl = {s : ResBul.Tense => Anteriority => Polarity => Order => Str} ;
    ClSlash = {
      s : Agr => ResBul.Tense => Anteriority => Polarity => Order => Str ;
      c2 : Preposition
      } ;
    Imp = {s : Polarity => GenNum => Str} ;

-- Question

    QCl = {s : ResBul.Tense => Anteriority => Polarity => QForm => Str} ;
    IP = {s : Role => QForm => Str; gn : GenNum} ;
    IComp = {s : QForm => Str} ;
    IDet = {s : AGender => QForm => Str; n : Number ; nonEmpty : Bool} ;
    IQuant = {s : GenNum => QForm => Str} ;

-- Relative

    RCl = {s : ResBul.Tense => Anteriority => Polarity => Agr => Str} ;
    RP = {s : GenNum => Str} ;

-- Verb

    VP = ResBul.VP ;
    VPSlash = ResBul.VPSlash ;

    Comp = {s : Agr => Str} ; 

-- Adjective

    AP = {s : AForm => Str; adv : Str; isPre : Bool} ;

-- Adjective

    CAdv = {s : Str; sn : Str} ;
    IAdv = {s : QForm => Str} ;

-- Noun

    CN = {s : NForm => Str; g : AGender} ;
    NP = {s : Role => Str; a : Agr} ;
    Pron = {s : Role => Str; gen : AForm => Str; a : Agr} ;
    Det = {s : Bool => AGender => Role => Str; nn : NNumber; spec : Species} ;
    Predet = {s : GenNum => Str} ;
    Ord = {s : AForm => Str} ;
    Num = {s : CardForm => Str; nn : NNumber; nonEmpty : Bool} ;
    Card = {s : CardForm => Str; n : Number} ;
    Quant = {s : Bool => AForm => Str; nonEmpty : Bool; spec : Species} ;

-- Numeral

    Numeral = {s : CardOrd => Str; n : Number} ;
    Digits  = {s : CardOrd => Str; n : Number; tail : DTail} ;

-- Structural

    Conj = {s : Str; distr : Bool; conj : Ints 2; n : Number} ;
    Subj = {s : Str} ;
    Prep = {s : Str; c : Case} ;

-- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = Verb ;
    V2, V2A = Verb ** {c2 : Preposition} ;
    V2V, V2S, V2Q = Verb ** {c2, c3 : Preposition} ; --- AR
    V3 = Verb ** {c2, c3 : Preposition} ;
    VV = Verb ** {typ : VVType};

    A = {s : AForm => Str; adv : Str} ;
    A2 = {s : AForm => Str; adv : Str; c2 : Str} ;
    
    N = {s : NForm => Str; rel : AForm => Str; g : AGender} ;
    N2 = {s : NForm => Str; g : AGender} ** {c2 : Preposition} ;
    N3 = {s : NForm => Str; g : AGender} ** {c2,c3 : Preposition} ;
    PN = {s : Str; g : Gender} ;
    
  lindef
    SSlash = \s -> {s = \\_ => s; c2 = {s=""; c=Acc}};
    ClSlash = \s -> {s = \\_,_,_,_,_ => s; c2 = {s=""; c=Acc}};
    
    VP = \s -> predV {s = \\_,_ => s; vtype = VNormal};
    VPSlash = \s -> slashV {s = \\_,_ => s; vtype = VNormal} {s=""; c=Acc};
    
    V, VS, VQ, VA = \s -> {s = \\_,_ => s; vtype = VNormal};
    V2, V2A = \s -> {s = \\_,_ => s; vtype = VNormal; c2 = {s=""; c=Acc}};
    V2V, V2S, V2Q = \s -> {s = \\_,_ => s; vtype = VNormal; c2,c3 = {s=""; c=Acc}};
    V3 = \s -> {s = \\_,_ => s; vtype = VNormal; c2,c3 = {s=""; c=Acc}};
    VV = \s -> {s = \\_,_ => s; vtype = VNormal; typ = VVInf};

	A = \s -> {s = \\_ => s; adv = s};
    A2 = \s -> {s = \\_ => s; adv = s; c2 = ""};
    
    N  = \s -> {s = \\_ => s; rel = \\_ => s; g = AMasc NonHuman};
    N2 = \s -> {s = \\_ => s; g = AMasc NonHuman; c2 = {s=""; c=Acc}};
    N3 = \s -> {s = \\_ => s; g = AMasc NonHuman; c2,c3 = {s=""; c=Acc}};
    
  linref
    SSlash = \ss -> ss.s ! agrP3 (GSg Masc) ++ ss.c2.s;
    ClSlash = \cl -> cl.s ! agrP3 (GSg Masc) ! Pres ! Simul ! Pos ! Main ++ cl.c2.s;

    VP = \vp -> linrefVP vp;
    VPSlash = \vps -> let vp : ResBul.VP
                             = {s  = vps.s ;
                                ad = vps.ad ;
                                compl = \\a => vps.compl1 ! a ++ vps.c2.s ++ vps.compl2 ! a ;
                                vtype = vps.vtype
                               }
                      in linrefVP vp;

    V, VS, VQ, VA = \v -> linrefVP (predV v);
    V2, V2A = \v -> linrefVP (predV v) ++ v.c2.s;
    V2V, V2S, V2Q = \v -> linrefVP (predV v) ++ v.c2.s ++ v.c3.s;
    V3 = \v -> linrefVP (predV v) ++ v.c2.s ++ v.c3.s;
    VV = \v -> linrefVP (predV v);

	A = \a -> a.s ! ASg Masc Indef;
    A2 = \a -> a.s ! ASg Masc Indef ++ a.c2;

    N  = \n -> n.s ! NF Sg Indef;
    N2 = \n -> n.s ! NF Sg Indef ++ n.c2.s;
    N3 = \n -> n.s ! NF Sg Indef ++ n.c2.s ++ n.c3.s;
}
