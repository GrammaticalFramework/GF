--# -path=.:src/chunk:src/translator:../examples/phrasebook/gfos

concrete AppSpa of App = 
  TenseSpa,
  NounSpa - [PPartNP],
  AdjectiveSpa,
  NumeralSpa,
  SymbolSpa [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionSpa,
  VerbSpa [ 
    UseV,ComplVV,SlashV2a,ComplSlash,UseComp,CompAP,CompNP,CompAdv,CompCN
    ,AdvVP,AdVVP
    ],
  AdverbSpa,
  PhraseSpa,
  SentenceSpa [
    PredVP,SlashVP,ImpVP,AdvS,
    UseCl,UseQCl,UseSlash,SSubjS,UseRCl
    ],        
  QuestionSpa - [
    ComplSlashIP,AdvQVP,AddAdvQVP,QuestQVP
    ],
  RelativeSpa,
  IdiomSpa [
    NP, VP, Tense, Cl, ProgrVP, ExistNP, 
    neutr, sjalv
    ],
----  ConstructionSpa,

  ChunkSpa,

  ExtensionsSpa [
     CompoundCN,AdAdV,UttAdV,ApposNP,
     MkVPI, MkVPS, PredVPS, that_RP, who_RP
     ],

  DocumentationSpa,
  DictionarySpa 

  ,PhrasebookSpa - [PSentence, PQuestion, PGreetingMale, PGreetingFemale, GObjectPlease, cheap_A,expensive_A, open_A]

    ** open MorphoSpa, ResSpa, ParadigmsSpa, SyntaxSpa, CommonScand, (E = ExtraSpa), Prelude in {

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
