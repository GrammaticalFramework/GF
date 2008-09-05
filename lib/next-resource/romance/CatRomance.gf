incomplete concrete CatRomance of Cat = 
  CommonX - [Temp,TTAnt,Tense,TPres,TPast,TFut,TCond] 
  ** open Prelude, CommonRomance, ResRomance, (R = ParamX) in {

  flags optimize=all_subs ;

  lincat

-- Tensed/Untensed

    S  = {s : Mood => Str} ;
    QS = {s : QForm => Str} ;
    RS = {s : Mood => Agr => Str ; c : Case} ;
    SSlash = {
      s  : AAgr => Mood => Str ; 
      c2 : Compl
      } ;


-- Sentence

    Cl    = {s : Direct => RTense => Anteriority => Polarity => Mood => Str} ;
    ClSlash = {
      s  : AAgr => Direct => RTense => Anteriority => Polarity => Mood => Str ; 
      c2 : Compl
      } ;
    Imp   = {s : Polarity => ImpForm => Gender => Str} ;

-- Question

    QCl    = {s : RTense => Anteriority => Polarity => QForm => Str} ;
    IP     = {s : Case => Str ; a : AAgr} ;
    IComp  = {s : AAgr => Str} ;     
    IDet   = {s : Gender => Case => Str ; n : Number} ;
    IQuant = {s : Number => Gender => Case => Str} ;

-- Relative

    RCl  = {
      s : Agr => RTense => Anteriority => Polarity => Mood => Str ; 
      c : Case
      } ;
    RP   = {s : Bool => AAgr => Case => Str ; a : AAgr ; hasAgr : Bool} ;

-- Verb

    VP = ResRomance.VP ;
    VPSlash = ResRomance.VP ** {c2 : Compl} ;
    Comp = {s : Agr => Str} ; 

-- Adjective

    AP = {s : AForm => Str ; isPre : Bool} ; 

-- Noun

    CN      = {s : Number => Str ; g : Gender} ;
    NP,Pron = Pronoun ;
    Det     = {
      s : Gender => Case => Str ; 
      n : Number ; 
      s2 : Str ;            -- -ci 
      sp : Gender => Case => Str    -- substantival: mien, mienne
      } ;
    Quant = {
      s  : Bool => Number => Gender => Case => Str ; 
      s2 : Str ; 
      sp : Number => Gender => Case => Str 
      } ;
    Predet  = {s : AAgr   => Case => Str ; c : Case} ; -- c : la plupart de
    Num     = {s : Gender => Str ; isNum : Bool ; n : Number} ;
    Card    = {s : Gender => Str ; n : Number} ;
    Ord     = {s : AAgr   => Str} ;

-- Numeral

    Numeral = {s : CardOrd => Str ; n : Number} ;
    Digits  = {s : CardOrd => Str ; n : Number} ;

-- Structural

---b    Conj  = {s : Str ; n : Number} ;
---b    DConj = {s1,s2 : Str ; n : Number} ;
    Conj = {s1,s2 : Str ; n : Number} ;
    Subj = {s : Str ; m : Mood} ;
    Prep = {s : Str ; c : Case ; isDir : Bool} ;

-- Open lexical classes, e.g. Lexicon

    V, VQ, VA = Verb ;
    V2, VV, V2S, V2Q = Verb ** {c2 : Compl} ;
    V3, V2A, V2V = Verb ** {c2,c3 : Compl} ;
    VS = Verb ** {m : Polarity => Mood} ;

    A  = {s : Degree => AForm => Str ; isPre : Bool} ;
    A2 = {s : Degree => AForm => Str ; c2 : Compl} ;

    N  = Noun ; 
    N2 = Noun  ** {c2 : Compl} ;
    N3 = Noun  ** {c2,c3 : Compl} ;
    PN = {s : Str ; g : Gender} ;

-- tense augmented with passé simple

    Temp  = {s : Str ; t : RTense ; a : Anteriority} ;
    Tense = {s : Str ; t : RTense} ;
  lin
    TTAnt t a = {s = a.s ++ t.s ; a = a.a ; t = t.t} ;
    TPres = {s = []} ** {t = RPres} ;
    TPast = {s = []} ** {t = RPast} ;   --# notpresent
    TFut  = {s = []} ** {t = RFut} ;    --# notpresent
    TCond = {s = []} ** {t = RCond} ;   --# notpresent

}
