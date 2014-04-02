--# -path=.:src/chunk:src/translator:../examples/phrasebook/gfos

concrete AppBul of App = 
  TenseX - [IAdv, CAdv],
  NounBul - [PPartNP],
  AdjectiveBul,
  NumeralBul,
  SymbolBul [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionBul,
  VerbBul [ 
    UseV,ComplVV,SlashV2a,ComplSlash,UseComp,CompAP,CompNP,CompAdv,CompCN
    ],
  AdverbBul,
  PhraseBul,
  SentenceBul [
    PredVP,SlashVP,ImpVP,
    UseCl,UseQCl,UseSlash,SSubjS,UseRCl
    ],        
  QuestionBul - [
    ComplSlashIP,AdvQVP,AddAdvQVP,QuestQVP
    ],
  RelativeBul,
  IdiomBul [
    NP, VP, Tense, Cl, ProgrVP, ExistNP, 
    neutr, sjalv
    ],
----  ConstructionBul,

  ChunkBul,

  ExtensionsBul [
     CompoundCN,AdAdV,UttAdV,ApposNP,
     MkVPI, MkVPS, PredVPS, that_RP, who_RP
     ],

  DocumentationBul,
  DictionaryBul 

  ,PhrasebookBul - [PSentence, PQuestion, PGreetingMale, PGreetingFemale, GObjectPlease, open_Adv, closed_A, open_A]

    ** open MorphoBul, ResBul, ParadigmsBul, SyntaxBul, CommonScand, (E = ExtraBul), Prelude in {

flags
  literal=Symb ;

-- to suppress punctuation
lin
  PSentence, PQuestion = \s -> lin Text (mkUtt s) ;
  PGreetingMale, PGreetingFemale = \s -> lin Text s ;

  GObjectPlease o = lin Text (mkUtt o) ;


lin
  PhrasePhr p = {s = "+" ++ p.s} | p ;

  Phrase_Chunk p = p ;

}
