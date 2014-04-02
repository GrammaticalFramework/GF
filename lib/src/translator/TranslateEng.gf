--# -path=.:src/chunk

concrete TranslateEng of Translate = 
  TenseX - [Pol, PNeg, PPos],
  CatEng,
  NounEng - [PPartNP],
  AdjectiveEng,
  NumeralEng,
  SymbolEng [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP,
    addGenitiveS
    ],
  ConjunctionEng,
  VerbEng - [
    UseCopula,               -- just removed
    SlashV2V, PassV2, ComplVV,  -- generalized in Extensions
    ComplVS, SlashV2S, ComplSlash -- Eng exceptions
    ],
  AdverbEng,
  PhraseEng,
  SentenceEng - [
    UseCl     -- replaced by UseCl | ContractedUseCl
    ],        
  QuestionEng,
  RelativeEng,
  IdiomEng [NP, VP, Tense, Cl, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP],
  ConstructionEng,
  DocumentationEng,

  ChunkEng,

  ExtensionsEng - [
     VPI,VPS
     ],
  DictionaryEng ** 
open MorphoEng, ResEng, ParadigmsEng, (G = GrammarEng), (E = ExtraEng), Prelude in {

flags
  literal=Symb ;

-- exceptional linearizations
lin
  UseCl t p cl = 
     G.UseCl t p cl              -- I am here
   | E.ContractedUseCl t p cl    -- I'm here
   ;

  ComplVS vs s = G.ComplVS vs s | E.ComplBareVS vs s ;
  SlashV2S vs s = G.SlashV2S vs s | E.SlashBareV2S vs s ;
  ComplSlash vps np = G.ComplSlash vps np | E.ComplSlashPartLast vps np ;

  PPos = {s = [] ; p = CPos} ;
  PNeg = {s = [] ; p = CNeg True} | {s = [] ; p = CNeg False} ;


}
