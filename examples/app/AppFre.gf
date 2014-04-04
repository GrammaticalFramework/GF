--# -path=.:src/chunk:src/translator:../examples/phrasebook/gfos

concrete AppFre of App = 
  TenseFre,
  NounFre - [PPartNP],
  AdjectiveFre,
  NumeralFre,
  SymbolFre [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionFre,
  VerbFre [ 
    UseV,ComplVV,SlashV2a,ComplSlash,UseComp,CompAP,CompNP,CompAdv,CompCN
    ,AdvVP,AdVVP
    ],
  AdverbFre,
  PhraseFre,
  SentenceFre [
    PredVP,SlashVP,ImpVP,AdvS,
    UseCl,UseQCl,UseSlash,SSubjS,UseRCl
    ],        
  QuestionFre - [
    ComplSlashIP,AdvQVP,AddAdvQVP,QuestQVP,
    QuestCl, QuestIAdv
    ],
  RelativeFre,
  IdiomFre [
    NP, VP, Tense, Cl, ProgrVP, ExistNP, 
    neutr, sjalv
    ],
----  ConstructionFre,

  ChunkFre,

  ExtensionsFre [
     CompoundCN,AdAdV,UttAdV,ApposNP,
     MkVPI, MkVPS, PredVPS, that_RP, who_RP
     ],

  DocumentationFre,
  DictionaryFre 

  ,PhrasebookFre - [PSentence, PQuestion, PGreetingMale, PGreetingFemale, GObjectPlease, open_A]

    ** open MorphoFre, PhonoFre, ResFre, ParadigmsFre, SyntaxFre, CommonScand, (E = ExtraFre), (G = GrammarFre), Prelude in {

flags
  literal=Symb ;

---------------------------
lin
  QuestCl cl = 
    {s = \\t,a,p =>                             -- est-ce qu'il dort ?
            let cls = cl.s ! DDir ! t ! a ! p 
            in table {
              QDir   => "est-ce" ++ elisQue ++ cls ! Indic ;
              QIndir => subjIf ++ cls ! Indic
              }
      }
  | {s = \\t,a,p =>                             -- dort-il ?
            let cls = cl.s ! DInv ! t ! a ! p 
            in table {
              QDir   => cls ! Indic ;
              QIndir => subjIf ++ cls ! Indic
              }
      }
  | G.QuestCl cl                                -- il dort ?
  ;


  QuestIAdv iadv cl = 
     G.QuestIAdv iadv cl                       -- où dort-il
   | {s = \\t,a,p,q =>                         -- où est-ce qu'il dort        
            let 
              ord = DDir ;
              cls = cl.s ! ord ! t ! a ! p ! Indic ;
              why = iadv.s
            in why ++ "est-ce" ++ elisQue ++ cls
      } ;

---------------------------

-- to suppress punctuation
lin
  PSentence, PQuestion = \s -> lin Text (mkUtt s) ;
  PGreetingMale, PGreetingFemale = \s -> lin Text s ;

  GObjectPlease o = lin Text (mkUtt o) ;


lin
  PhrasePhr p = {s = "+" ++ p.s} | p ;

  Phrase_Chunk p = p ;

}
