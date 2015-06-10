abstract Translate = 

-- modules in Grammar, excluding Structural
  Tense,
  Noun - [PPartNP],               -- to be generalized
  Adjective,
  Numeral,
  Conjunction,
  Verb - [
     PassV2,                -- generalized to VPSlash and agents
--     SlashV2V, ComplVV,   -- generalized in Extensions, used in Penn. But (1) more expensive (2) not available for all languages
     UseCopula              ---- overgenerating, unnecessary
     ],
  Adverb,
  Phrase,
  Sentence,
  Question,
  Relative,
  Idiom,

  Symbol [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP],          ---- why only these?

  Chunk,

  Construction,
  Extensions [

{-
-- used in Penn treebank
    CompQS,CompS,CompVP,ComplVPIVV,GenNP,GenRP,GenIP,PastPartRS,PositAdVAdj,
    PredFrontVS,PredFrontVQ,PresPartRS,SlashSlashV2V,GerundCN,
    SlashV2V,ComplVV,
    SlashVPIV2V,UseQuantPN,VPSlashVS,
-}

    ListVPS,BaseVPS,ConsVPS,ConjVPS,ListVPI,BaseVPI,ConsVPI,ConjVPI,
    CompoundN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, PassVPSlash, PassAgentVPSlash, CompoundAP,
    DirectComplVS, DirectComplVQ, FocusObjS
    , PastPartAP, PastPartAgentAP, PresPartAP, GerundNP, GerundAdv ---- not yet available for all languages
    , WithoutVP, InOrderToVP, ByVP
    ],
  Dictionary,
  Documentation

              ** {
flags
  startcat=Phr;
---  heuristic_search_factor=0.60; ---- what should we choose here?
---- robustness by Chunk now
----  meta_prob=1.0e-5;
----  meta_token_prob=1.1965149246222233e-9;

}
