--# -path=.:src/chunk:src/translator:../examples/phrasebook/gfos
--# -path=.:src/chunk:src/finnish/stemmed:src/finnish:src/api:src/translator:../examples/phrasebook/gfos

concrete AppFin of App = 
  TenseX,
  NounFin - [
    PPartNP,
    UsePron, PossPron  -- Fin specific: replaced by variants with prodrop
    ],
  AdjectiveFin,
  NumeralFin,
  SymbolFin [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionFin,
  VerbFin [ 
    UseV,ComplVV,SlashV2a,ComplSlash,UseComp,CompAP,CompNP,CompAdv,CompCN
    ,AdvVP,AdVVP
    ],
  AdverbFin,
  PhraseFin,
  SentenceFin [
    PredVP,SlashVP,ImpVP,
    UseCl,UseQCl,UseSlash,SSubjS,UseRCl
    ],        
  QuestionFin - [
    ComplSlashIP,AdvQVP,AddAdvQVP,QuestQVP
    ],
  RelativeFin,
  IdiomFin [
    NP, VP, Tense, Cl, ProgrVP, ExistNP, 
    neutr, sjalv
    ],
----  ConstructionFin,

  ChunkFin,

  ExtensionsFin [
     CompoundCN,AdAdV,UttAdV,ApposNP,
     MkVPI, MkVPS, PredVPS, that_RP, who_RP
     ],

  DocumentationFin,
  DictionaryFin 

  ,PhrasebookFin - [PSentence, PQuestion, PGreetingMale, PGreetingFemale, GObjectPlease, open_A]

    ** open MorphoFin, ResFin, ParadigmsFin, SyntaxFin, CommonScand, (E = ExtraFin), (G = GrammarFin), Prelude in {

flags
  literal=Symb ;

-- pro-drop exceptions: here as second rather than first alternative
lin
  UsePron p = G.UsePron p | G.UsePron (E.ProDrop p) ;
  PossPron p = G.PossPron p | E.ProDropPoss p ;

-- to suppress punctuation
lin
  PSentence, PQuestion = \s -> lin Text (mkUtt s) ;
  PGreetingMale, PGreetingFemale = \s -> lin Text s ;

  GObjectPlease o = lin Text (mkUtt o) ;


lin
  PhrasePhr p = {s = "+" ++ p.s} | p ;

  Phrase_Chunk p = p ;

}
