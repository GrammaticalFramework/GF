-- CatMlt.gf: the common type system
--
-- Maltese Resource Grammar Library
-- John J. Camilleri, 2012
-- Licensed under LGPL

{-
All code in comments was copied from CatEng.gf and may need to be corrected for Maltese.
The same overall structure should be maintained.
-}

concrete CatMlt of Cat = CommonX ** open ResMlt, Prelude in {

  flags
    optimize=all_subs ;

  lincat

-- Tensed/Untensed

    -- S  = {s : Str} ;
    -- QS = {s : QForm => Str} ;
    -- RS = {s : Agr => Str ; c : NPCase} ; -- c for it clefts
    -- SSlash = {s : Str ; c2 : Str} ;

-- Sentence

    Cl = {s : Tense => Anteriority => Polarity => Str} ;
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

--    AP = {s : Agr => Str ; isPre : Bool} ; 
    AP = {s : GenNum => Str ; isPre : Bool} ;

-- Noun

    CN = Noun ;
    NP = NounPhrase ;
    Pron = Pronoun ;
    -- Pron = {s : NPCase => Str ; sp : Case => Str ; a : Agr} ;
    Det = {s : Str ; n : Num_Number ; hasNum : Bool} ;
    -- Det = {s : Str ; sp : NPCase => Str ; n : Number ; hasNum : Bool} ;
    -- Predet = {s : Str} ;
    -- Ord = { s : Case => Str } ;
    Num  = {s : Num_Case => Str ; n : Num_Number ; hasCard : Bool} ;
    -- Card = {s : Case => Str ; n : Number} ;
    -- Quant = {s : Bool => Number => Str ; sp : Bool => Number => NPCase => Str} ;
    Quant = {s : Bool => Num_Number => Str} ;

-- Numeral

    -- Cardinal or ordinal in WORDS (not digits) [JJC]
    Numeral = {
      s : CardOrd => Num_Case => Str ;
      n : Num_Number
    } ;

    -- Cardinal or ordinal in DIGITS (not words) [JJC]
    Digits = {
      s : Str ;      -- No need for CardOrd, i.e. no 1st, 2nd etc in Maltese
      n : Num_Number ;
      tail : DTail
    };


-- Structural

--     Conj = {s1,s2 : Str ; n : Number} ;
-- ---b    Conj = {s : Str ; n : Number} ;
-- ---b    DConj = {s1,s2 : Str ; n : Number} ;
--     Subj = {s : Str} ;
    Prep = {s : Str} ;

-- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = Verb ;
    V2, V2A, V2Q, V2S = Verb ; -- ** {c2 : Str} ;
    V3 = Verb ; -- ** {c2, c3 : Str} ;
    -- VV = {s : VVForm => Str ; typ : VVType} ;
    -- V2V = Verb ** {c2,c3 : Str ; typ : VVType} ;

    A = Adjective ** {hasComp : Bool} ; -- Does the adjective have a comparative form (e.g. ISBAĦ)?
--    A2 = Adjective ** {c2 : Str} ;

    N, N2, N3 = Noun ;
    PN = ProperNoun ;

}
