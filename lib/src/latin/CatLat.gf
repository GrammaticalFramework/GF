concrete CatLat of Cat = CommonX ** open ResLat, ParamX, Prelude in {

  flags optimize=all_subs ;

  lincat

---- Tensed/Untensed
--
    S  = {s : Str} ;
    QS = {s : QForm => Str} ;
--    RS = {s : Agr => Str ; c : Case} ; -- c for it clefts
--    SSlash = {s : Str ; c2 : Str} ;
--
---- Sentence
--
    Cl = Clause ;
    ClSlash = Clause ;
    Imp = {s : Polarity => ImpForm => Str} ;
--
---- Question
--
    QCl = {s : ResLat.Tense => Anteriority => Polarity => QForm => Str } ;
    IP = {s : Case => Str ; n : Number} ;
    IComp = {s : Str} ;    
    IDet = Determiner ; --{s : Str ; n : Number} ;
    IQuant = {s : Agr => Str} ;
--
---- Relative
--
--    RCl = {
--      s : ResLat.Tense => Anteriority => CPolarity => Agr => Str ; 
--      c : Case
--      } ;
--    RP = {s : RCase => Str ; a : RAgr} ;
--
---- Verb
--
    VP = ResLat.VerbPhrase ;
    VPSlash = VP ** {c2 : Preposition} ;
    Comp = {s : Agr => Str} ; 
--
---- Adjective
--
--    AP = Adjective ** {isPre : Bool} ; ---- {s : Agr => Str ; isPre : Bool} ; 
    AP = 
      { 
	s : Agr => Str ;
--	isPre : Bool ; -- should have no use in latin because adjectives can appear variably before and after nouns
      } ;
--
---- Noun
--
    CN = ResLat.ComplexNoun ;
    NP = ResLat.NounPhrase ;
    Pron = ResLat.Pronoun ;
    Det = Determiner ;
    Predet, Ord = {s : Str} ;
    Num  = {s : Gender => Case => Str ; n : Number} ;
--    Card = {s : Str ; n : Number} ;
    Quant = Quantifier ;
--
---- Numeral
--
--    Numeral = {s : CardOrd => Str ; n : Number} ;
    Digits  = {s : Str ; unit : Unit} ;
--
---- Structural
--
    Conj = {s1,s2 : Str ; n : Number} ;
    Subj = {s : Str} ;
    Prep = ResLat.Preposition ;
--
---- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = ResLat.Verb ; -- = {s : VForm => Str} ;
    V2, V2A, V2Q, V2S = Verb2 ;
    V3 = Verb3 ;
    VV = ResLat.VV ;
    V2V = Verb ** {c2 : Str ; isAux : Bool} ;

    A = Adjective ;

    N = Noun ;
    N2 = Noun ** { c : Prep } ;
    N3 = Noun ** { c : Prep ; c2 : Prep } ;
    PN = Noun ;
    A2 = Adjective ** { c : Prep} ;
}
