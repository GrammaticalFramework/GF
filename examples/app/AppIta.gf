--# -path=.:src/chunk:src/translator:../examples/phrasebook/gfos

concrete AppIta of App = 
  TenseIta,
  NounIta - [PPartNP],
  AdjectiveIta,
  NumeralIta,
  SymbolIta [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionIta,
  VerbIta [ 
    UseV,ComplVV,SlashV2a,ComplSlash,UseComp,CompAP,CompNP,CompAdv,CompCN
    ],
  AdverbIta,
  PhraseIta,
  SentenceIta [
    PredVP,SlashVP,ImpVP,
    UseCl,UseQCl,UseSlash,SSubjS,UseRCl
    ],        
  QuestionIta - [
    ComplSlashIP,AdvQVP,AddAdvQVP,QuestQVP
    ],
  RelativeIta,
  IdiomIta [
    NP, VP, Tense, Cl, ProgrVP, ExistNP, 
    neutr, sjalv
    ],
----  ConstructionIta,

  ChunkIta,

  ExtensionsIta [
     CompoundCN,AdAdV,UttAdV,ApposNP,
     MkVPI, MkVPS, PredVPS, that_RP, who_RP
     ],

  DocumentationIta,
  DictionaryIta 

  ,PhrasebookIta - [PSentence, PQuestion, PGreetingMale, PGreetingFemale, GObjectPlease, open_A]

    ** open MorphoIta, ResIta, ParadigmsIta, SyntaxIta, CommonScand, (E = ExtraIta), Prelude in {

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
