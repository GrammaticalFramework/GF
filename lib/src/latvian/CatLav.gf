concrete CatLav of Cat = CommonX - [CAdv, Voc] ** open ResLav, Prelude in {

  flags optimize=all_subs ;

  lincat
    S  = {s : Str} ;
    QS = {s : Str} ;  
	RS = {s : Agr => Str} ; -- ; c : Case    c for it clefts
	SSlash = {s : Str; p : Prep};
  
	N = {s : Number => Case => Str ; g : Gender} ;
	N2 = {s : Number => Case => Str ; g : Gender} ** {p : Prep; isPre : Bool};  -- case / preposition used. if isPre, then located before the noun.
	N3 = {s : Number => Case => Str ; g : Gender} ** {p1,p2 : Prep; isPre1, isPre2 : Bool};  
	PN = {s : Case => Str ; g : Gender; n : Number} ;
	A = {s : AForm => Str };
	A2 = A ** {p : Prep};
	V, VQ, VA, VV = Verb ;
	VS = Verb ** {subj : Subj} ;
	V2, V2A, V2Q, V2V = Verb ** {p : Prep} ; -- TODO - valence, pieòemam ka viena; bûtu jânorâda semantika - integrçt ar FrameNet?
	V2S = Verb ** {p : Prep; subj : Subj} ;
	V3 = Verb ** {p1, p2 : Prep} ;
	
    Pron = {s : Case => Str ; a : ResLav.Agr; possessive : Gender => Number => Case => Str} ;
	Conj = {s1,s2 : Str ; n : Number} ; 
	Subj = {s : Str} ;
	Prep = {s : Str; c : Number => Case} ; -- e.g. 'ar' + Sg-Acc or Pl-Dat; Preposition may be empty [] for simple case-based valences
										   -- TODO - pozîcija nav noteikta; daşi ir pirms daşi pçc		
		
	Cl = {s : VerbMood => Polarity => Str} ;
	ClSlash = {s : VerbMood => Polarity => Str; p : Prep};
	
	Imp = {s : Polarity => Number => Str} ;
	
	QCl = {s : VerbMood => Polarity => Str} ;	
	IP = {s : Case => Str; n: Number };
	IQuant = {s : Gender => Number => Str} ;
	IDet = {s : Gender => Str ; n : Number} ;

    RCl = {s : VerbMood => Polarity => Agr => Str} ;
    RP = {s : Case => Str} ;
	
    CN  = {s : Definite => Number => Case => Str ; g : Gender} ;
    Det = {s : Gender => Case => Str ; n : Number ; d: Definite} ;	
    Predet = {s : Gender => Str} ;
	Quant = {s : Gender => Number => Case => Str ; d: Definite} ;	
	Card = { s : Gender => Case => Str ; n: Number} ;
	Ord = { s : Gender => Case => Str } ;
    NP = {s : Case => Str ; a : ResLav.Agr} ;
	AP = {s : Definite => Gender => Number => Case => Str} ;
	VP = ResLav.VP;
	VPSlash = VP ** {p : Prep};
	Comp = {s : ResLav.Agr => Str} ; 
	
	Num  = {s : Gender => Case => Str ; n : Number ; hasCard : Bool} ;
	Numeral = {s : CardOrd => Gender => Case => Str ; n : Number} ;
    Digits  = {s : CardOrd => Str ; n : Number} ;
	
	CAdv = { s : Str; p : Str; d: Degree } ; 
{-  
-- Tensed/Untensed

    S  = {s : Str} ;
    QS = {s : QForm => Str} ;
    RS = {s : Agr => Str ; c : Case} ; -- c for it clefts
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
    IP = {s : Case => Str ; n : Number} ;
    IComp = {s : Str} ;    
    IDet = {s : Str ; n : Number} ;
    IQuant = {s : Number => Str} ;

-- Relative

    RCl = {
      s : ResEng.Tense => Anteriority => CPolarity => Agr => Str ; 
      c : Case
      } ;

-- Verb

    VP = ResEng.VP ;
    VPSlash = ResEng.VP ** {c2 : Str} ;
    Comp = {s : Agr => Str} ; 

-- Adjective

    AP = {s : Agr => Str ; isPre : Bool} ; 

-- Noun

    CN = {s : Number => Case => Str ; g : Gender} ;
    NP = {s : Case => Str ; a : Agr} ;
    Pron = {s : Case => Str ; sp : Case => Str ; a : Agr} ;
    Det = {s : Str ; sp : Case => Str ; n : Number} ;
    Predet = {s : Str} ;
    Ord = { s : Case => Str } ;
    Num  = {s : Case => Str ; n : Number ; hasCard : Bool} ;
    Card = {s : Case => Str ; n : Number} ;
    Quant = {s : Bool => Number => Str ; sp : Bool => Number => Case => Str} ;

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
    VV = {s : VVForm => Str ; isAux : Bool} ;
    V2V = Verb ** {c2 : Str ; isAux : Bool} ;

    A = {s : AForm => Str} ;
    A2 = {s : AForm => Str ; c2 : Str} ;

    N = {s : Number => Case => Str ; g : Gender} ;
    N2 = {s : Number => Case => Str ; g : Gender} ** {c2 : Str} ;
    N3 = {s : Number => Case => Str ; g : Gender} ** {c2,c3 : Str} ;
    PN = {s : Case => Str ; g : Gender} ;
-}
}
