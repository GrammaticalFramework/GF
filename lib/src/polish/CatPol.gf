--# -path=.:../abstract:../common:../prelude

-- Adam Slaski, 2009 <adam.slaski@gmail.com>

concrete CatPol of Cat = CommonPol ** open ResPol, Prelude, (R = ParamX) in {

  flags optimize=all_subs; coding=utf8;

  lincat

---- Tensed/Untensed

  S  = {s : Str};
  QS = {s : Str};
  RS = {s : GenNum => Str};
  SSlash = {s : Str; c : Complement};

---- Sentence
-- clause (variable tense) e.g. "John walks"/"John walked"
  Cl = {s : Polarity => Anteriority => R.Tense => Str};
  ClSlash = {s : Polarity => Anteriority => R.Tense => Str} 
    ** { c : Complement };
  Imp = { s : Polarity => Number => Str };

---- Question

   QCl = {s : Polarity => Anteriority => R.Tense => Str};

-- interrogative pronoun "who"
   IP = NounPhrase;

-- interrrogatove complement of copula "where"  
   IComp = {s : Str};    

-- interrogative determiner "which" : "który", "jaki"
   IDet = IDeterminer;
   IQuant = { s : AForm => Str };

---- Relative

   RCl = {s : GenNum => Polarity => Anteriority => R.Tense => Str};
   RP = {s : AForm => Str; mgn : MaybeGenNum};

-- Verb
-- s - verb
-- s2 - adverbials
-- s3 - object
    
---- Adjective

    AP = AdjPhrase;

---- Noun
  
--   CommNoun : Type = { s : SubstForm => Str; g : Gender };
    CN = { s : Number => Case => Str; g : Gender };

--   NounPhrase : Type = { s : PronForm => Str; n : Number; g: Gender; p : Person };
    NP = NounPhrase;

--  oper Pron = { s : PronForm => Str ; sp: AForm => Str ; n : Number ; p : Person ;
-- 		   g: PronGen } ;
    Pron = ResPol.Pron;
    
    Det = Determiner;
    Predet = {s : AForm => Str; np:NounPhrase; adj:Bool }; 
-- 'all', 'most' and 'only' belong in Polish to three completly different parts of speach
    Quant = {s,sp : AForm => Str};


---- Numeral

    Num = { s: Case => Gender => Str; 
                a:Accom; n : Number; hasCard : Bool };
    Numeral = { s: Case => Gender => Str; 
                o: AForm => Str;
                a:Accom; n:Number };
    Card = { s: Case => Gender => Str; 
                a:Accom; n:Number };
    Ord = {  s: AForm => Str };
    Digits = { s:Str; o:Str; a:Accom; n:Number };


---- Structural

    Conj = {s1,s2,sent1,sent2 : Str};  
    Subj = {s : Str};
    Prep = Complement; --{s : Str; c: ComplCase };

---- Open lexical classes, e.g. Lexicon

    V  = Verb; -- defined in ResPol.gf
    V2 = Verb ** { c : Complement };
    V3 = Verb ** { c, c2 : Complement };

    VV = Verb;    -- verb-phrase-complement verb         e.g. "want"
    VS = Verb;    -- sentence-complement verb            e.g. "claim"
    VQ = Verb;    -- question-complement verb            e.g. "wonder"
--     VA ;    -- adjective-complement verb           e.g. "look"
    V2V = Verb ** { c : Complement };   -- verb with NP and V complement       e.g. "cause"
    V2S = Verb ** { c : Complement };   -- verb with NP and S complement       e.g. "tell"
    V2Q = Verb ** { c : Complement };   -- verb with NP and Q complement       e.g. "ask"
--     V2A ;   -- verb with NP and AP complement      e.g. "paint"
    
    VA = Verb  ** { c:{ c:Case; s:Str; adv:Bool } };
    V2A = Verb ** { c:{ c:Case; s:Str; adv:Bool }; c2:Complement };
    
    VPSlash = VerbPhrase ** { c : Complement };
    
    VP = VerbPhrase;
    Comp = { s: GenNum => Str };
    
    Ord =  { s : AForm => Str };

    A = Adj;
    A2 = Adj ** { c : Complement };


-- Substantives moreover have an inherent gender. 
    N  = {s : SubstForm => Str; g : Gender};   

    N2 = {s : SubstForm => Str; g : Gender} ** { c : Complement } ;

    N3 = {s : SubstForm => Str; g : Gender} ** { c, c2 : Complement } ;

    PN = NounPhrase;
};

