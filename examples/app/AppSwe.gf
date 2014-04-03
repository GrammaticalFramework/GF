--# -path=.:src/chunk:src/translator:../examples/phrasebook/gfos

concrete AppSwe of App = 
  TenseSwe,
  NounSwe - [PPartNP],
  AdjectiveSwe,
  NumeralSwe,
  SymbolSwe [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionSwe,
  VerbSwe [ 
    UseV,ComplVV,SlashV2a,ComplSlash,UseComp,CompAP,CompNP,CompAdv,CompCN
    ,AdvVP,AdVVP
    ],
  AdverbSwe,
  PhraseSwe,
  SentenceSwe [
    PredVP,SlashVP,ImpVP,
    UseCl,UseQCl,UseSlash,SSubjS,UseRCl
    ],        
  QuestionSwe - [
    ComplSlashIP,AdvQVP,AddAdvQVP,QuestQVP
    ],
  RelativeSwe,
  IdiomSwe [
    NP, VP, Tense, Cl, ProgrVP, ExistNP, 
    neutr, sjalv
    ],
----  ConstructionSwe,

  ChunkSwe,

  ExtensionsSwe [
     CompoundCN,AdAdV,UttAdV,ApposNP,
     MkVPI, MkVPS, PredVPS, that_RP, who_RP
     ],

  DocumentationSwe,
  DictionarySwe 

  ,PhrasebookSwe - [PSentence, PQuestion, PGreetingMale, PGreetingFemale, GObjectPlease, open_Adv, closed_A, open_A]

    ** open MorphoSwe, ResSwe, ParadigmsSwe, SyntaxSwe, CommonScand, (E = ExtraSwe), Prelude in {

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
