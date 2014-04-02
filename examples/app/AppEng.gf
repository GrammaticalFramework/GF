--# -path=.:src/chunk:src/translator:../examples/phrasebook/gfos

concrete AppEng of App = 
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
  VerbEng [ 
    UseV,ComplVV,SlashV2a,ComplSlash,UseComp,CompAP,CompNP,CompAdv,CompCN
    ],
  AdverbEng,
  PhraseEng,
  SentenceEng [
    PredVP,SlashVP,ImpVP,
    UseQCl,UseSlash,SSubjS,UseRCl
    ],        
  QuestionEng - [
    ComplSlashIP,AdvQVP,AddAdvQVP,QuestQVP
    ],
  RelativeEng,
  IdiomEng [NP, VP, Tense, Cl, ProgrVP, ExistNP], 

----  ConstructionEng,


  ChunkEng,

  ExtensionsEng [
     CompoundCN,AdAdV,UttAdV,ApposNP,
     MkVPI, MkVPS, PredVPS, that_RP, who_RP
     ],
  DocumentationEng,
  DictionaryEng 

  ,PhrasebookEng - [PSentence, PQuestion, PGreetingMale, PGreetingFemale, GObjectPlease, open_Adv]

   ** open MorphoEng, ResEng, ParadigmsEng, SyntaxEng, (G = GrammarEng), (E = ExtraEng), Prelude in {

flags
  literal=Symb ;

-- exceptional linearizations
lin
  UseCl t p cl = 
     G.UseCl t p cl              -- I am here
   | E.ContractedUseCl t p cl    -- I'm here
   ;

  PPos = {s = [] ; p = CPos} ;
  PNeg = {s = [] ; p = CNeg True} | {s = [] ; p = CNeg False} ;


-- to suppress punctuation
lin
  PSentence, PQuestion = \s -> lin Text (mkUtt s) ;
  PGreetingMale, PGreetingFemale = \s -> lin Text s ;

  GObjectPlease o = lin Text (mkUtt o) ;


lin
  PhrasePhr p = {s = "+" ++ p.s} | p ;

  Phrase_Chunk p = p ;

}
