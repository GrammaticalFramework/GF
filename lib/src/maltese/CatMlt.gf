-- CatMlt.gf: the common type system
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Angelo Zammit 2012
-- Licensed under LGPL

concrete CatMlt of Cat = CommonX ** open ResMlt, Prelude in {

  flags
    optimize=all_subs ;

  lincat

-- Tensed/Untensed

    S  = {s : Str} ;
    -- QS = {s : QForm => Str} ;
    -- RS = {s : Agr => Str ; c : NPCase} ; -- c for it clefts
    -- SSlash = {s : Str ; c2 : Str} ;

-- Sentence

    Cl = {s : ResMlt.Tense => Anteriority => Polarity => Str} ;
    -- ClSlash = {
    --   s : ResMlt.Tense => Anteriority => Polarity => Order => Str ;
    --   c2 : Str
    --   } ;
    -- Imp = {s : Polarity => ImpForm => Str} ;

-- Question

    -- QCl = {s : ResMlt.Tense => Anteriority => Polarity => QForm => Str} ;
    -- IP = {s : NPCase => Str ; n : Number} ;
    -- IComp = {s : Str} ;    
    -- IDet = {s : Str ; n : Number} ;
    -- IQuant = {s : Number => Str} ;

-- Relative

    -- RCl = {
    --   s : ResMlt.Tense => Anteriority => Polarity => Agr => Str ; 
    --   c : NPCase
    --   } ;
    -- RP = {s : RCase => Str ; a : RAgr} ;

-- Verb

    VP = ResMlt.VP ;
    VPSlash = ResMlt.VP ;
    -- Comp = {s : Agr => Str} ;

-- Adjective

    AP = {s : GenNum => Str ; isPre : Bool} ;

-- Noun

    CN = Noun ;
    NP = NounPhrase ;
    Pron = Pronoun ;

    Det = Determiner ;
    -- Predet = {s : Str} ;
    Quant = Quantifier ;

    -- [AZ]
    Num = {
      s : NumCase => Str ;
      n : NumForm ;
      hasCard : Bool ;
      -- isNum : Bool ;
      } ;

    -- [AZ]
    Ord = {
      s : NumCase => Str ;
    --   s : NPCase => GenNum => Str ;
    --   hasBSuperl : Bool
      } ;

    -- [AZ]
    Card = {
      s : NumCase => Str ;
      n : NumForm ;
      } ;

-- Numeral

    -- Cardinal or ordinal in WORDS (not digits)
    Numeral = {
      s : CardOrd => NumCase => Str ;
      n : NumForm -- number to be "treated as", e.g. 103 has n=Num3_10
    } ;

    -- Cardinal or ordinal in DIGITS (not words)
    Digits = {
      s : NumCase => Str ;      -- No need for CardOrd, i.e. no 1st, 2nd etc in Maltese
      n : NumForm ;
      tail : DTail
    };

-- Structural

    Conj = {s1,s2 : Str} ;
--     Subj = {s : Str} ;
    Prep = {
      s : Definiteness => Str ;
      takesDet : Bool
      } ;

-- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = Verb ;
    V2, V2A, V2Q, V2S = Verb ** {prep : Prep} ;
    -- VV = {s : VVForm => Str ; typ : VVType} ;
    V3, V2V = Verb ** {prep1,prep2 : Prep} ; -- ** {typ : VVType} ;

    A = Adjective ;
    A2 = Adjective ;

    N, N2, N3 = Noun ;
    PN = ProperNoun ;

}
