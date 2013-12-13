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
  Idiom [NP, VP, Cl, Tense, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP],
  Construction,
  Documentation,
  ExtraEngAbs [NP, Quant, VPSlash, VP, GenNP, PassVPSlash, PassAgentVPSlash,
               Temp, Tense, Pol, Conj, VPS, ListVPS, S, Num, CN, RP, MkVPS, BaseVPS, ConsVPS, ConjVPS, PredVPS, GenRP,
               VPI, ListVPI, VV, MkVPI, BaseVPI, ConsVPI, ConjVPI, ComplVPIVV, ComplSlashPartLast,
               ClSlash, RCl, EmptyRelSlash, VS, V2S, ComplBareVS, SlashBareV2S],
  DictEngAbs ** {

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
	
cat Feat;
fun FeatN  : N  -> Feat;
    FeatN2 : N2 -> Feat;
    FeatV  : V  -> Feat;
    FeatV2 : V2 -> Feat;
    FeatV3 : V3 -> Feat;
    FeatV2V : V2V -> Feat;
    FeatV2S : V2S -> Feat;
    FeatV2Q : V2Q -> Feat;
    FeatV2A : V2A -> Feat;
    FeatVV : VV -> Feat;
    FeatVS : VS -> Feat;
    FeatVQ : VQ -> Feat;
    FeatVA : VA -> Feat;


-- for displaying inflection tables ---- TODO soon obsolete

cat 
  NDisplay ; ADisplay ; VDisplay ;
fun 
  DisplayN   : N -> NDisplay ;
  DisplayN2  : N2 -> NDisplay ;
  DisplayN3  : N3 -> NDisplay ;
  DisplayA   : A -> ADisplay ;
  DisplayA2  : A2 -> ADisplay ;
  DisplayV   : V -> VDisplay ;
  DisplayV2  : V2 -> VDisplay ;
  DisplayV3  : V3 -> VDisplay ;
  DisplayVA  : VA -> VDisplay ;
  DisplayVQ  : VQ -> VDisplay ;
  DisplayVS  : VS -> VDisplay ;
  DisplayVV  : VV -> VDisplay ;
  DisplayV2A : V2A -> VDisplay ;
  DisplayV2Q : V2Q -> VDisplay ;
  DisplayV2S : V2S -> VDisplay ;
  DisplayV2V : V2V -> VDisplay ;

}
