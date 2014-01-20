abstract Translate = 

-- modules in Grammar, excluding Structural
  Tense,
  Noun - [PPartNP],               -- to be generalized
  Adjective,
  Numeral,
  Conjunction,
  Verb - [
     SlashV2V, PassV2, ComplVV,   -- to be generalized
     UseCopula                    ---- overgenerating ?? 
     ],
  Adverb,
  Phrase,
  Sentence,
  Question,
  Relative,
  Idiom [NP, VP, Cl, Tense, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP], ---- why only these?

  Symbol [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP],          ---- why only these?

  Construction,
  Extensions,
  Dictionary,
  Documentation

              ** {
flags
  startcat=Phr;
  heuristic_search_factor=0.60;
  meta_prob=1.0e-5;
  meta_token_prob=1.1965149246222233e-9;

}
