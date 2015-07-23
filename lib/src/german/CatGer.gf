concrete CatGer of Cat = 
  CommonX - [Tense,Temp] ** 
  open ResGer, Prelude in {

  flags optimize=all_subs ;

  lincat

-- Tensed/Untensed

    S  = {s : Order => Str} ;
    QS = {s : QForm => Str} ;
    RS = {s : RelGenNum => Str ; c : Case} ;
    SSlash = {s : Order => Str} ** {c2 : Preposition} ;

-- Sentence

    Cl = {s : Mood => ResGer.Tense => Anteriority => Polarity => Order => Str} ;
    ClSlash = {
      s : Mood => ResGer.Tense => Anteriority => Polarity => Order => Str ; 
      c2 : Preposition
      } ;
    Imp = {s : Polarity => ImpForm => Str} ;

-- Question

    QCl = {s : Mood => ResGer.Tense => Anteriority => Polarity => QForm => Str} ;
    IP = {s : Case => Str ; n : Number} ;
    IComp = {s : Agr => Str ; ext : Str} ; 
    IDet = {s : Gender => Case => Str ; n : Number} ;
    IQuant = {s : Number => Gender => Case => Str} ;

-- Relative

    RCl = {s : Mood => ResGer.Tense => Anteriority => Polarity => RelGenNum => Str ; c : Case} ;
    RP = {s : RelGenNum => Case => Str ; a : RAgr} ;

-- Verb

    VP = ResGer.VP ;
    VPSlash = ResGer.VPSlash ;
    Comp = {s : Agr => Str ; ext : Str} ; 

-- Adjective

    AP = {s : AForm => Str ; isPre : Bool ; c: Str * Str ; ext : Str} ; 
    -- ich bin [c1 ihm] treu 
	-- du bist so klug gewesen [ext ihn zu lesen]
	-- ich bin stolz [c2 auf dich]

-- Noun

    CN = {s : Adjf => Number => Case => Str ;
		  rc : Number => Str ; -- Frage , [rc die ich gestellt habe]
		  ext : Str ; -- Frage , [sc wo sie schläft])
		  adv : Str ; -- Frage [a von Max]
		  g : Gender} ;
    NP = ResGer.NP ; 
    Pron = {s : NPForm => Str ; a : Agr} ;
    Det = {s,sp : Gender => PCase => Str ; n : Number ; a : Adjf ; isDef : Bool} ;
    Quant = {
      s   : Bool => Number => Gender => PCase => Str ;  -- Bool is True if a cardinal number is present
      sp  : Bool => Number => Gender => PCase => Str ; 
      a   : Adjf ;
      aPl : Adjf ;  --- to distinguish "meine guten Freunde" / "gute Freunde"
      } ;
    Predet = {
      s : Number => Gender => PCase => Str ; 
      c : {p : Str ; k : PredetCase} ;
      a : PredetAgr -- if an agr is forced, e.g. jeder von uns ist ...
      } ;
    Num = {s : Gender => Case => Str ; n : Number ; isNum : Bool} ;
    Card = {s : Gender => Case => Str ; n : Number} ;
    Ord = {s : AForm => Str} ;

-- Numeral

    Numeral = {s : CardOrd => Str ; n : Number } ;
    Digits = {s : CardOrd => Str ; n : Number } ;

-- Structural

    Conj = {s1,s2 : Str ; n : Number} ;
    Subj = {s : Str} ;
    Prep = Preposition ;

-- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = ResGer.Verb ; -- = {s : VForm => Str} ;
    VV = Verb ** {isAux : Bool} ;
    V2, V2A, V2S, V2Q = Verb ** {c2 : Preposition} ;
    V2V = Verb ** {c2 : Preposition ; isAux : Bool} ;
    V3 = Verb ** {c2, c3 : Preposition} ;

    A  = {s : Degree => AForm => Str} ;
    A2 = {s : Degree => AForm => Str ; c2 : Preposition} ;

    N  = ResGer.Noun ;
    N2 = ResGer.Noun ** {c2 : Preposition} ;
    N3 = ResGer.Noun ** {c2,c3 : Preposition} ;
    PN = {s : Case => Str; g : Gender} ;

-- tense with possibility to choose conjunctive forms

    Temp = {s : Str ; t : ResGer.Tense ; a : Anteriority ; m : Mood} ;
    Tense = {s : Str ; t : ResGer.Tense ; m : Mood} ;

  linref
    SSlash = \ss -> ss.s ! Main ++ ss.c2.s  ;
    ClSlash = \cls -> cls.s ! MIndic ! Pres ! Simul ! Pos ! Main ++ cls.c2.s ;

    VP = \vp -> useInfVP False vp ;
    VPSlash = \vps -> useInfVP False vps ++ vps.c2.s ;

    V, VS, VQ, VA = \v -> useInfVP False (predV v) ;
    V2, V2A, V2Q, V2S = \v -> useInfVP False (predV v) ++ v.c2.s ;
    V3 = \v -> useInfVP False (predV v) ++ v.c2.s ++ v.c3.s ;

    VV = \v -> useInfVP v.isAux (predVGen v.isAux v) ;
    V2V = \v -> useInfVP v.isAux (predVGen v.isAux v) ++ v.c2.s ;

    Conj = \c -> c.s1 ++ c.s2 ;
}
