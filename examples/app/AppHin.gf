--# -path=.:src/chunk:src/translator:../examples/phrasebook/gfos

concrete AppHin of App = 
  TenseX - [AdN,Adv,SC,PPos,PNeg],
  NounHin - [PPartNP],
  AdjectiveHin,
  NumeralHin,
  SymbolHin [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionHin,
  VerbHin [ 
    UseV,ComplVV,SlashV2a,ComplSlash,UseComp,CompAP,CompNP,CompAdv,CompCN
    ,AdvVP,AdVVP
    ],
  AdverbHin,
  PhraseHin,
  SentenceHin [
    PredVP,SlashVP,ImpVP,
    UseCl,UseQCl,UseSlash,SSubjS,UseRCl
    ],        
  QuestionHin - [
    ComplSlashIP,AdvQVP,AddAdvQVP,QuestQVP
    ],
  RelativeHin,
  IdiomHin [
    NP, VP, Tense, Cl, ProgrVP, ExistNP, 
    neutr, sjalv
    ],
----  ConstructionHin,

  ChunkHin,

  ExtensionsHin [
     CompoundCN,AdAdV,UttAdV,ApposNP,
     MkVPI, MkVPS, PredVPS, that_RP, who_RP
     ],

  DocumentationHin,
  DictionaryHin 

  ,PhrasebookHin - [PSentence, PQuestion, PGreetingMale, PGreetingFemale, GObjectPlease, open_Adv, closed_A, open_A]

    ** open MorphoHin, ResHin, ParadigmsHin, SyntaxHin, CommonScand, (E = ExtraHin), Prelude in {

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
