--# -path=.:src/chunk:src/translator:../examples/phrasebook/gfos

concrete AppChi of App = 
  TenseChi,
  NounChi - [PPartNP],
  AdjectiveChi,
  NumeralChi,
  SymbolChi [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionChi,
  VerbChi [ 
    UseV,ComplVV,SlashV2a,ComplSlash,UseComp,CompNP,CompAdv,CompCN
    ],
  AdverbChi,
  PhraseChi,
  SentenceChi [
    PredVP,SlashVP,ImpVP,
    UseCl,UseQCl,UseSlash,SSubjS,UseRCl
    ],        
  QuestionChi - [
    ComplSlashIP,AdvQVP,AddAdvQVP,QuestQVP,
    QuestCl -- overridden
    ],
  RelativeChi,
  IdiomChi [
    NP, VP, Tense, Cl, ProgrVP, ExistNP, 
    neutr, sjalv
    ],
----  ConstructionChi,

  ChunkChi,

  ExtensionsChi [
     CompoundCN,AdAdV,UttAdV,ApposNP,
     MkVPI, MkVPS, PredVPS, that_RP, who_RP
     ],

  DocumentationChi,
  DictionaryChi 

  ,PhrasebookChi - [PSentence, PQuestion, PGreetingMale, PGreetingFemale, GObjectPlease, open_Adv, closed_A, open_A, at_Prep]

    ** open ResChi, ParadigmsChi, SyntaxChi, CommonScand, (E = ExtraChi), (G = GrammarChi), Prelude in {

flags
  literal=Symb ;


-- Chinese-specific overrides

lin
  CompAP = G.CompAP | E.CompBareAP ;                     -- he is good | he good

--  AdvVP vp adv = E.TopicAdvVP vp adv | G.AdvVP vp adv ;  -- he *today* here sleeps | *today* he here sleeps

  QuestCl cl = G.QuestCl cl | E.QuestRepV cl ;           -- he comes 'ma' | he come not come





-- to suppress punctuation
lin
  PSentence, PQuestion = \s -> lin Text (mkUtt s) ;
  PGreetingMale, PGreetingFemale = \s -> lin Text s ;

  GObjectPlease o = lin Text (mkUtt o) ;


lin
  PhrasePhr p = {s = "+" ++ p.s} | p ;

  Phrase_Chunk p = p ;

}
