--# -path=.:../chunk:alltenses

concrete TranslateJpn of Translate = 
  TenseJpn,
  NounJpn - [PPartNP],
  AdjectiveJpn,
  NumeralJpn,
  SymbolJpn [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionJpn,

  VerbJpn - [
    UseCopula,  -- just removed
    PassV2 -- generalized
    ],
  AdverbJpn,
  PhraseJpn,
  SentenceJpn,
  QuestionJpn,
  RelativeJpn,
  IdiomJpn,
----  ConstructionJpn, ---- TODO
----  DocumentationJpn, ---- TODO

  ChunkJpn,
  ExtensionsJpn [
    ListVPS,BaseVPS,ConsVPS,ConjVPS,ListVPI,BaseVPI,ConsVPI,ConjVPI,
    CompoundN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, PassVPSlash, PassAgentVPSlash, CompoundAP
    , DirectComplVS, DirectComplVQ, FocusObjS
    , PastPartAP, PastPartAgentAP, PresPartAP, GerundNP, GerundAdv
    , WithoutVP, InOrderToVP, ByVP
    ],

  DictionaryJpn ** 
 
  open ResJpn, ParadigmsJpn, SyntaxJpn, Prelude, (G = GrammarJpn), (E = ExtraJpn) in {

flags
  literal = Symb ;
  coding = utf8 ;

---- TODO: everything

-- Japanese-specific overrides (if any) here


}

