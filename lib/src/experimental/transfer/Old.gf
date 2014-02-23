--# -path=..:../../translator

abstract Old =

--- abstract ParseEngAbs = 
  Tense,
  Cat,
  Noun - [PPartNP],
  Adjective,
----  Numeral,
  Symbol [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP],
  Conjunction,
  Verb - [SlashV2V, PassV2, UseCopula, ComplVV],
  Adverb,
  Phrase,
  Sentence,
  Question,
  Relative,
  Idiom [NP, VP, Cl, Tense, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP],
---  Construction,
---  Documentation,
  ExtraEngAbs [NP, Quant, VPSlash, VP, GenNP, PassVPSlash, PassAgentVPSlash,
               Temp, Tense, Pol, Conj, VPS, ListVPS, S, Num, CN, RP, MkVPS, BaseVPS, ConsVPS, ConjVPS, PredVPS, GenRP,
               VPI, ListVPI, VV, MkVPI, BaseVPI, ConsVPI, ConjVPI, ComplVPIVV, ComplSlashPartLast,
               ClSlash, RCl, EmptyRelSlash, VS, V2S, ComplBareVS, SlashBareV2S]
----  Dictionary 
** {

flags
  startcat=Phr;
  heuristic_search_factor=0.60;
  meta_prob=1.0e-5;
  meta_token_prob=1.1965149246222233e-9;

fun CompoundCN : Num -> N -> CN -> CN ;
    DashCN : N -> N -> N ;
    GerundN : V -> N ;
    GerundAP : V -> AP ;
    PastPartAP : V2 -> AP ;
    myself_NP : NP ;
    yourselfSg_NP : NP ;
    himself_NP : NP ;
    herself_NP : NP ;
    itself_NP : NP ;
    ourselves_NP : NP ;
    yourselfPl_NP : NP ;
    themselves_NP : NP ;
    OrdCompar : A -> Ord ;

    PositAdVAdj : A -> AdV ;

    UseQuantPN : Quant -> PN -> NP;

    SlashV2V : V2V -> Ant -> Pol -> VP -> VPSlash ;
    SlashVPIV2V : V2V -> Pol -> VPI -> VPSlash ;

    SlashSlashV2V : V2V -> Ant -> Pol -> VPSlash -> VPSlash ;
    
    ComplVV : VV -> Ant -> Pol -> VP -> VP ;

    PredVPosv,PredVPovs : NP -> VP -> Cl ;
    
    that_RP : RP ;
    who_RP : RP ;

    CompS : S -> Comp ;
    CompQS : QS -> Comp ;
    CompVP : Ant -> Pol -> VP -> Comp ;

	VPSlashVS : VS -> VP -> VPSlash ;

	PastPartRS : Ant -> Pol -> VPSlash -> RS ;
    PresPartRS : Ant -> Pol -> VP -> RS ;

	ApposNP : NP -> NP -> NP ;
	
	AdAdV : AdA -> AdV -> AdV ;

	UttAdV : AdV -> Utt;

}
