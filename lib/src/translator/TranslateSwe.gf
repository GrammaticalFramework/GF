--# -path=.:../chunk:alltenses

concrete TranslateSwe of Translate = 
  TenseSwe,
  NounSwe - [PPartNP,PossNP],
  AdjectiveSwe,
  NumeralSwe,
  SymbolSwe [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionSwe,
  VerbSwe -  [
    UseCopula,  -- not needed  
    PassV2      -- generalized in Extensions
    ],
  AdverbSwe,
  PhraseSwe,
  SentenceSwe,
  QuestionSwe - [
    QuestSlash -- replaced by QuestSlash | PiedPipingQuestSlash
    ], 
  RelativeSwe - [
    RelSlash  -- replaced by RelSlash | PiedPipingRelSlash
   ,IdRP  -- replaced by IdRP | emptyRP
    ],
  IdiomSwe,
  ConstructionSwe,
  DocumentationSwe,

  ChunkSwe,
  ExtensionsSwe [
    ListVPS,BaseVPS,ConsVPS,ConjVPS,ListVPI,BaseVPI,ConsVPI,ConjVPI,
      CompoundN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, PassVPSlash, PassAgentVPSlash, CompoundAP
    , DirectComplVS, DirectComplVQ, FocusObjS
    , PastPartAP, PastPartAgentAP, PresPartAP, GerundNP, GerundAdv
    , WithoutVP, InOrderToVP, ByVP
    ],

  DictionarySwe ** 
open MorphoSwe, ResSwe, ParadigmsSwe, SyntaxSwe, CommonScand, (E = ExtraSwe), (G = GrammarSwe), Prelude in {

flags
  literal=Symb ;

-- exceptions

lin 
  PossNP cn np =   -- min frus stora bil
     G.PossNP cn np 
   | {s = \\n,d,c => np.s ! NPPoss (gennum (ngen2gen cn.g) n) Nom ++ cn.s ! n ! DDef Indef ! c ; g = cn.g ; isMod = True} ---- overgenerating
   ;

  IdRP = G.IdRP | E.emptyRP ;

  RelSlash rp cls = G.RelSlash rp cls | E.PiedPipingRelSlash rp cls ;

  QuestSlash ip cls = G.QuestSlash ip cls | E.PiedPipingQuestSlash ip cls ;

}
