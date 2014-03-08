--# -path=.:../translator

abstract NDTrans =
   NDLift
  ,Extensions [CN,NP,AdA,AdV,CompoundCN,AdAdV,UttAdV,ApposNP]
  ,Documentation - [Pol,Tense]
  ,Dictionary - [Pol,Tense]
  ,Chunk
              ** {
flags
  startcat=Phr;
--  heuristic_search_factor=0.60;
--  meta_prob=1.0e-5;
--  meta_token_prob=1.1965149246222233e-9;

}
