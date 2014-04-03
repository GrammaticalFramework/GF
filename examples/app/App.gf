abstract App = 

-- modules in Grammar, excluding Structural
  Tense,
  Noun - [PPartNP],               -- to be generalized
  Adjective,
  Numeral,
  Conjunction,
  Verb [
    UseV,ComplVV,SlashV2a,ComplSlash,UseComp,CompAP,CompNP,CompAdv,CompCN
    ,AdvVP,AdVVP
     ],
  Adverb,
  Phrase,
  Sentence,
  Question - [
    ComplSlashIP,AdvQVP,AddAdvQVP,QuestQVP
    ],
  Relative,
  Idiom [NP, VP, Cl, Tense, ProgrVP, ExistNP], 

  Symbol [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP],          ---- why only these?

  Chunk,

----  Construction,
  Extensions [
     CompoundCN,AdAdV,UttAdV,ApposNP,
     MkVPI, MkVPS, PredVPS, that_RP, who_RP
     ],
  Dictionary,
  Documentation

  ,Phrasebook

              ** {
flags
  startcat=Phr ;

fun
  PhrasePhr : Phrase -> Phr ;
  Phrase_Chunk : Phrase -> Chunk ;

}
