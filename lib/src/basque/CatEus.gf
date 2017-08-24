concrete CatEus of Cat = CommonX ** open ResEus, Prelude in {

  flags optimize=all_subs ;

  lincat

--2 Sentences and clauses
-- Constructed in SentenceEus, and also in IdiomEus

    S  = { s : ResEus.Sentence } ; --must keep words separate, because we may add Subj particles for Adv
    QS = { s : ClType => ResEus.Sentence } ;
    RS = { s : Agr => Str };  -- relative sentence. Tense and polarity fixed,
                              -- but agreement may depend on the CN/NP it modifies:
                              -- `gorriak diren txakurrak' vs. `gorria den txakurra'
                              -- mutil|ak| maite |du|en neska / mutil|ak| maite |ditu|en nesk|ak|
                              -- mutil|ek| maite |dute|n nesk|a| / mutil|ek| maite |ditute|n nesk|ak|
                              -- neska maite duen mutila / neskak maite dituen mutila / neska maite duten mutilak / neskak maite dituten mutilak

    Cl = ResEus.Clause ; 
    ClSlash = ResEus.ClSlash ;
    SSlash  = { s : ResEus.Sentence } ; -- sentence missing NP           e.g. "she has looked at"
    Imp     = { s : Str } ;   -- imperative                    e.g. "look at this"

--2 Questions and interrogatives

-- Constructed in QuestionEus.

    QCl = ResEus.Clause ;
    IP = ResEus.NounPhrase ;
    IComp = { s : Str } ; -- interrogative complement of copula  e.g. "where"
    IDet = ResEus.Determiner ;  -- interrogative determiner            e.g. "how many"
    IQuant = ResEus.Quant ; -- interrogative quantifier            e.g. "which"




--2 Relative clauses and pronouns

-- Constructed in RelativeEus.

    RCl = ResEus.RClause ;
    RP = { s : Str } ;



--2 Verb phrases

-- Constructed in VerbEus.

    VP = ResEus.VerbPhrase ; 
    VPSlash = ResEus.VPSlash ;
    Comp = ResEus.Complement ;


--2 Adjectival phrases

-- Constructed in AdjectiveEus.

    AP = ResEus.AdjPhrase ; 


--2 Nouns and noun phrases

-- Constructed in NounEus.
-- Many atomic noun phrases e.g. "everybody"
-- are constructed in StructuralEus.
-- The determiner structure is
-- ``` Predet (QuantSg | QuantPl Num) Ord
-- as defined in NounEus.

    CN = ResEus.CNoun ;
    NP = ResEus.NounPhrase ; 
    Pron = ResEus.Pronoun ; --Pronouns need enough info to turn it into NP or Quant.
    Det = ResEus.Determiner ;
    Predet = {s : Str} ; 
    Quant = ResEus.Quant ;
    Num = { s : Str ; n : Number ; isNum : Bool } ;
    Card, Ord = { s : Str ; n : Number } ; 
    DAP = ResEus.Determiner ;


--2 Numerals

-- Constructed in NumeralEus.

    Numeral = { s : Str ; n : Number } ; 
    Digits = { s : CardOrd => Str ; n : Number } ;



--2 Structural words

-- Constructed in StructuralEus.
    Conj = { s1,s2 : Str ; nbr : Number } ; --Ni eta Inari gara/*naiz ; Fran edo Mikel da/*dira
    Subj = { s : Str ; isPre : Bool } ; --ba+dut vs. dut+en
    Prep = ResEus.Postposizio ;



--2 Words of open classes

-- These are constructed in LexiconEus and in 
-- additional lexicon modules.

    V,
    V2,
    V3,
    VV,    -- verb-phrase-complement verb         e.g. "want"
    VS,    -- sentence-complement verb            e.g. "claim"
    VQ,    -- question-complement verb            e.g. "wonder"  
    VA,    -- adjective-complement verb           e.g. "look"
    V2V,   -- verb with NP and V complement       e.g. "cause"
    V2S,   -- verb with NP and S complement       e.g. "tell"
    V2Q,   -- verb with NP and Q complement       e.g. "ask"
    V2A = ResEus.Verb ;   -- verb with NP and AP complement      e.g. "paint"

    A = ResEus.Adjective ;
    A2  = ResEus.Adjective2 ;

    N = ResEus.Noun ;
    N2 = ResEus.Noun2 ;
    N3 = ResEus.Noun3 ;
    PN = ResEus.PNoun ; 


linref
    S = \s -> linS s.s ;
    Cl = linCl ;
    VP = linVP ;
    CN = linCNIndef ;
}
