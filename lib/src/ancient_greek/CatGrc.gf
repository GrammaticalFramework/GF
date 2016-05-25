--# -path=.:../abstract:../common:prelude

concrete CatGrc of Cat = CommonX - [Temp,Tense] ** open ResGrc, Prelude in {

  flags optimize=all_subs ;

  lincat

    Temp  = {s : Str ; t : VTense ; a : Anteriority } ; 
    Tense = {s : Str ; t : VTense } ;  -- cf. TenseGrc, ResGrc

-- Tensed/Untensed

    S  = {s : Str} ;
    QS = {s : QForm => Str} ;
    RS = { s : Agr => Str } ; 
    SSlash = {s : Str ; c2 : Preposition} ;

-- Sentence  

-- We parameterize clauses by VTense rather than Temp or Tense and Anteriority, 
-- since absolute or relative tenses are hardly expressed in Greek.

    Cl = ResGrc.Clause ; -- {s : VTense => Polarity => Order => Str} ;
    ClSlash = {
      s : VTense => Polarity => Order => Str ;
      c2 : Preposition 
      } ;
    Imp = {s : Polarity => VPImpForm => Str} ;

-- Question

    QCl = {s : VTense => Polarity => QForm => Str} ; 
    IP = { s : Case => Str ; n : Number } ;
--    IComp = {s : Str} ;    
    IDet = {s : Gender => Case => Str ; n : Number} ;
    IQuant = {s : Number => Gender => Case => Str} ;

-- Relative

   RCl = {
     s : VTense => Polarity => Agr => Str ; 
     c : Case
     } ;
   RP = {s : Gender => Number => Case => Str } ;

-- Verb

    VP = ResGrc.VP ; 
    VPSlash = ResGrc.VP ** {c2 : Preposition} ;
    Comp = { s : Agr => Str } ; 

-- Adverb is defined in CommonX as Adv = { s : Str } ;
-- TODO: Adverbs derived from adjectives have comparative and superlative forms 

-- Adjective

    AP = { s : AForm => Str } ; -- ResGrc: AForm = AF Gender Number Case  
                                -- TODO: s : Agr => AForm => Str  for possessive:  one's nice 

-- Noun, whose adjective or genitive object may depend on the subject (reflexive possessive)

    CN = { s : Number => Case => Str ;        -- noun only
          s2 : Number => Case => Str ;        -- attributes (pre- or postnominal)
          isMod : Bool ;                      -- attribute nonempty?
          rel : Number => Str ;               -- relative clause (dep. on Agr ?)
          g : Gender } ; 

    NP = {s : Case => Str ; 
          isPron : Bool ;
          e : Case => Str ; -- emphasized pronoun, or ignored
          a : Agr } ;    -- We need: isPron: PronTon | PronAton | None
                         -- pron: Tonicity 
         -- TODO: For CompNP in Verb, we would like to suppress the article 
         --       At sentence beginnings, (kai|men|de) may be inserted between DefArt and CN

-- NPRefl: noun phrase which may depend on the subject (via reflexive object or possessive)
-- See ExtraGrc

    Pron = { s : PronForm => Str ; a : Agr } ;        -- personal and possessive

    Det = Determiner ;     -- = { s : Gender => Case => Str ; n : Number } ;
--    Predet = {s : Str} ;  s : Number => Gender => Case => Str ??
    Num  = {s : Gender => Case => Str ; n : Number ; isCard : Bool} ;
    Card = {s : Gender => Case => Str ; n : Number} ;  -- cardinals > 200 are adjectives
    Ord  = {s : AForm => Str} ;                        -- number: oi tritoi anthropoi?
    Quant = Quantifier ;   -- = { s : Number => Gender => Case => Str } ;

-- Numeral

    Numeral = {s : CardOrd => Str ; n : Number} ;
    Digits  = {s : Str ; unit : Unit} ;

-- Structural

    Conj = {s1,s2 : Str ; n : Number} ;
    Subj = {s : Str} ;
    Prep = Preposition ;   -- = {s : Str ; c : Case} ;

-- Open lexical classes, e.g. Lexicon

    V, VS, VA, VQ, VV = Verb ;
    V2, V2A, V2S = Verb ** {c2 : Preposition} ;
    V2V,V2Q = Verb ** {c2 : Preposition ; isAux : Bool} ;
    V3 = Verb ** {c2, c3 : Preposition} ;

    A  = Adjective ;                   -- including degree
    A2 = Adjective ** {c2 : Preposition} ;   -- TODO: add degree

    N = Noun ;        -- = {s : Number => Case => Str ; g : Gender}
    N2 = Noun ** {c2 : Preposition ; obj : Agr => Str } ;  
    -- we add obj to N2 to have ComplN3 : N3 -> NP -> N2 (which should be N3 -> NP -> CN2!)

    N3 = Noun ** {c2,c3 : Preposition} ;
    PN = ProperNoun ; -- = {s : Case => Str ; g : Gender ; n : Number} ;

  -- default linearizations, stolen from CatGer.gf and modified:
  linref
    -- SSlash = \ss -> ss.s ! Main ++ ss.c2.s  ;
    -- ClSlash = \cls -> cls.s ! MIndic ! Pres ! Simul ! Pos ! Main ++ cls.c2.s ;

    VP = \vp -> useInfVP vp ;
    VPSlash = \vps -> useInfVP vps ++ vps.c2.s ;

    V, VS, VQ, VA = \v -> useInfVP (predV v) ;
    V2, V2A, V2Q, V2S = \v -> useInfVP (predV v) ++ v.c2.s ;
    V3 = \v -> useInfVP (predV v) ++ v.c2.s ++ v.c3.s ;

    VV = \v -> useInfVP (predV v) ;
    V2V = \v -> useInfVP (predV v) ++ v.c2.s ;

    Conj = \c -> c.s1 ++ c.s2 ;

    CN = \cn -> cn.s2 ! Sg ! Nom ++ cn.s ! Sg ! Nom ++ cn.rel ! Sg ;

}
