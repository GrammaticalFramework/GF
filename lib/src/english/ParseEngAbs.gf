abstract ParseEngAbs = 
  Tense,
  Cat,
  Noun - [PPartNP],
  Adjective,
  Numeral,
  Symbol [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP],
  Conjunction,
  Verb - [SlashV2V, PassV2, UseCopula, ComplVV],
  Adverb,
  Phrase,
  Sentence,
  Question,
  Relative,
  Idiom [NP, VP, Cl, Tense, ProgrVP, ExistNP],
  Extra [NP, Quant, VPSlash, VP, GenNP, PassVPSlash,
         Temp, Tense, Pol, Conj, VPS, ListVPS, S, Num, CN, RP, MkVPS, BaseVPS, ConsVPS, ConjVPS, PredVPS, GenRP,
         VPI, ListVPI, VV, MkVPI, BaseVPI, ConsVPI, ConjVPI, ComplVPIVV,
         ClSlash, RCl, EmptyRelSlash],
  DictEngAbs ** {

flags
  startcat=Phr;

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
    ourself_NP : NP ;
    yourselfPl_NP : NP ;
    themself_NP : NP ;
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

    CompS : S -> Comp ;
    CompQS : QS -> Comp ;
    CompVP : Ant -> Pol -> VP -> Comp ;

	VPSlashVS : VS -> VP -> VPSlash ;

	UncNeg : Pol ;

	PastPartRS : Ant -> Pol -> VPSlash -> RS ;
    PresPartRS : Ant -> Pol -> VP -> RS ;

	ApposNP : NP -> NP -> NP ;
	
	AdAdV : AdA -> AdV -> AdV ;

	UttAdV : AdV -> Utt;
}
