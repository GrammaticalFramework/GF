--# -path=.:abstract:common:prelude

concrete CatLav of Cat = CommonX - [CAdv, Voc] ** open ResLav, Prelude in {

flags

  coding = utf8 ;
  optimize = all_subs ;

lincat

  -- Sentences and clauses

  S, QS = { s : Str } ;

  RS = { s : Agreement => Str } ;

  Cl = { s : VMood => Polarity => Str } ;

  ClSlash = { s : VMood => Polarity => Str ; prep : Preposition } ;

  SSlash = { s : Str ; prep : Preposition } ;

  Imp = { s : Polarity => Number => Str } ;

  -- Questions and interrogatives

  QCl = { s : VMood => Polarity => Str } ;

  IP = { s : Case => Str ; num : Number } ;

  -- TODO: IComp = { s : Str ; agr : Agreement } ;

  IDet = { s : Gender => Str ; num : Number } ;

  IQuant = { s : Gender => Number => Str } ;

  -- Relative clauses and pronouns

  RCl = { s : VMood => Polarity => Agreement => Str } ;

  RP = { s : Gender => Case => Str } ;

  -- Verb phrases

  VP = ResLav.VP ;

  VPSlash = ResLav.VPSlash ;

  Comp = { s : Agreement => Str } ;

  -- Adjectival phrases

  AP = { s : Definiteness => Gender => Number => Case => Str } ;

  -- Nouns and noun phrases

  CN = { s : Definiteness => Number => Case => Str ; gend : Gender } ;

  NP = { s : Case => Str ; agr : Agreement ; pol : Polarity } ;

  Pron = Pronoun ;

  Det = { s : Gender => Case => Str ; num : Number ; defin : Definiteness ; pol : Polarity } ;

  Predet = { s : Gender => Str } ;

  Quant = { s : Gender => Number => Case => Str ; defin : Definiteness ; pol : Polarity } ;

  Num = { s : Gender => Case => Str ; num : Number ; hasCard : Bool } ;

  Card = { s : Gender => Case => Str ; num : Number } ;

  Ord = { s : Gender => Case => Str } ;

  -- Numerals

  Numeral = { s : CardOrd => Gender => Case => Str ; num : Number } ;

  Digits = { s : CardOrd => Str ; num : Number } ;

  -- Structural words

  Conj = { s1, s2 : Str ; num : Number } ;

  Subj = { s : Str } ;

  Prep = Preposition ;

  -- Words of open classes

  V, VV, VQ, VA = Verb ;

  V2, V2V, V2Q, V2A = Verb ** { rightVal : Preposition } ;

  V3 = Verb ** { rightVal1, rightVal2 : Preposition } ;

  VS = Verb ** { conj : Subj } ;

  V2S = Verb ** { conj : Subj ; rightVal : Preposition } ;

  A = Adjective ;

  A2 = Adjective ** { prep : Preposition } ;

  N = Noun ;

  N2 = Noun ** { prep : Preposition ; isPre : Bool } ;

  N3 = Noun ** { prep1, prep2 : Preposition ; isPre1, isPre2 : Bool } ;

  PN = ProperNoun ;

  -- Overriden from CommonX

  CAdv = { s, prep : Str ; deg : Degree } ;

}
