--# -path=.:../abstract:../common:../prelude

concrete CatLav of Cat = CommonX - [CAdv, Voc] ** open
  ResLav,
  Prelude
  in {

flags
  coding = utf8 ;
  optimize = all_subs ;

lincat
  -- Tensed/Untensed
  S  = { s : Str } ;
  QS = { s : Str } ;
  RS = { s : Agr => Str } ; -- Eng: c : Case -- c for it clefts
  SSlash = { s : Str ; p : Prep } ;

  -- Sentence
  Cl = { s : VerbMood => Polarity => Str } ;
  ClSlash = { s : VerbMood => Polarity => Str ; p : Prep } ;
  Imp = { s : Polarity => Number => Str } ;

  -- Question
  QCl = { s : VerbMood => Polarity => Str } ;
  IP = { s : Case => Str ; n: Number } ;
  --IComp = { s : Str ; a : ResLav.Agr } ;
  IDet = { s : Gender => Str ; n : Number } ;
  IQuant = { s : Gender => Number => Str } ;

  -- Relative
  RCl = { s : VerbMood => Polarity => Agr => Str } ;
  RP = { s : Gender => Case => Str } ;

  -- Verb
  VP = ResLav.VP ;
  VPSlash = ResLav.VP ** { p : Prep } ;
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
  Prep = { s : Str ; c : Number => Case } ;
  -- e.g. 'ar' + Sg-Acc or Pl-Dat; preposition may be empty ([]) for case-based valences
  -- TODO: pozīcija (pre/post) nav noteikta

  -- Open lexical classes, e.g. Lexicon
  N = { s : Number => Case => Str ; g : Gender } ;
  N2 = { s : Number => Case => Str ; g : Gender } ** { p : Prep ; isPre : Bool } ;
  -- case/preposition used; if isPre, then located before the noun
  N3 = { s : Number => Case => Str ; g : Gender } ** { p1, p2 : Prep ; isPre1, isPre2 : Bool } ;
  PN = { s : Case => Str ; g : Gender ; n : Number } ;

  A = { s : AForm => Str } ;
  A2 = A ** { p : Prep } ;

  V, VQ, VA, VV = Verb ;
  VS = Verb ** { subj : Subj } ;
  V2, V2A, V2Q, V2V = Verb ** { p : Prep } ;
  V2S = Verb ** { p : Prep ; subj : Subj } ;
  V3 = Verb ** { p1, p2 : Prep } ;
  -- TODO: pieņemam ka viena valence; būtu jānorāda semantika - integrēt ar FrameNet

  CAdv = { s, p : Str ; d : Degree } ;

}
