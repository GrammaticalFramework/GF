--# -path=.:../abstract:../common:../prelude

concrete CatLav of Cat = CommonX - [CAdv, Voc] **
open
  Prelude,
  ResLav
in {

flags
  coding = utf8 ;
  optimize = all_subs ;

lincat

  -- Tensed / Untensed

  S, QS = { s : Str } ;
  RS = { s : Agr => Str } ;
  SSlash = { s : Str ; p : ResLav.Prep } ;

  -- Sentence

  Cl = { s : VerbMood => Polarity => Str } ;
  ClSlash = { s : VerbMood => Polarity => Str ; p : ResLav.Prep } ;
  Imp = { s : Polarity => Number => Str } ;

  -- Question

  QCl = { s : VerbMood => Polarity => Str } ;
  IP = { s : Case => Str ; n: Number } ;
  IDet = { s : Gender => Str ; n : Number } ;
  IQuant = { s : Gender => Number => Str } ;
  -- TODO: IComp = { s : Str ; a : ResLav.Agr } ;

  -- Relative

  RCl = { s : VerbMood => Polarity => Agr => Str } ;
  RP = { s : Gender => Case => Str } ;

  -- Verb

  VP = ResLav.VP ;
  VPSlash = ResLav.VP ** { p : ResLav.Prep } ;
  Comp = { s : ResLav.Agr => Str } ;

  -- Adjective

  AP = { s : Definite => Gender => Number => Case => Str } ;

  -- Noun

  CN = { s : Definite => Number => Case => Str ; g : Gender } ;
  NP = { s : Case => Str ; a : ResLav.Agr } ;
  Pron = { s : Case => Str ; a : ResLav.Agr ; possessive : Gender => Number => Case => Str } ;
  Det = { s : Gender => Case => Str ; n : Number ; d : Definite } ;
  Predet = { s : Gender => Str } ;
  Ord = { s : Gender => Case => Str } ;
  Num = { s : Gender => Case => Str ; n : Number ; hasCard : Bool } ;
  Card = { s : Gender => Case => Str ; n : Number } ;
  Quant = { s : Gender => Number => Case => Str ; d : Definite } ;

  -- Numeral

  Numeral = { s : CardOrd => Gender => Case => Str ; n : Number } ;
  Digits = { s : CardOrd => Str ; n : Number } ;

  -- Structural

  Conj = { s1, s2 : Str ; n : Number } ;
  Subj = { s : Str } ;
  Prep = ResLav.Prep ;
  
  -- Open lexical classes (lexicon)

  N = { s : Number => Case => Str ; g : Gender } ;
  N2 = { s : Number => Case => Str ; g : Gender } ** { p : ResLav.Prep ; isPre : Bool } ; -- If isPre then located before the noun
  N3 = { s : Number => Case => Str ; g : Gender } ** { p1, p2 : ResLav.Prep ; isPre1, isPre2 : Bool } ;
  PN = { s : Case => Str ; g : Gender ; n : Number } ;

  A = { s : AForm => Str } ;
  A2 = A ** { p : ResLav.Prep } ;

  V, VA = Verb ;
  VV, VQ = Verb ** { topic : Case } ;
  VS = Verb ** { subj : Subj ; topic : Case } ;
  V2 = Verb ** { p : ResLav.Prep ; topic : Case } ;
  V2A, V2Q, V2V = Verb ** { p : ResLav.Prep } ;
  V2S = Verb ** { p : ResLav.Prep ; subj : Subj } ;
  V3 = Verb ** { p1, p2 : ResLav.Prep ; topic : Case } ;

  CAdv = { s, p : Str ; d : Degree } ;
}
