--# -path=present
concrete NLGEng of NLG = LogicEng ** open (Eng=GrammarEng), ParadigmsEng, ResEng in {

lincat
  Det = Eng.Det;
  N  = Eng.N;
  A  = Eng.A;
  CN = Eng.CN;
  PN = Eng.PN;
  NP = Eng.NP;
  AP = Eng.AP;
  VP = Eng.VP;
  VPSlash = Eng.VPSlash;
  V2 = Eng.V2;
  V  = Eng.V;
  Comp=Eng.Comp;
  Pol= Eng.Pol;
  Cl = Eng.Cl;
  ClSlash = Eng.ClSlash;
  S  = Eng.S;
  Utt= Eng.Utt;
  Conj = Eng.Conj;
  ListNP = Eng.ListNP;
  ListS = Eng.ListS;

lin
  DetCN _ _ = Eng.DetCN;
  UseN _ = Eng.UseN;
  UsePN _ = Eng.UsePN;
  SlashV2a _ = Eng.SlashV2a;
  ComplSlash _ _ = Eng.ComplSlash;
  SlashVP _ _ = Eng.SlashVP;
  ComplClSlash _ _ cl np = lin Cl {
    s = \\t,a,p,o => cl.s ! t ! a ! p ! o ++ cl.c2 ++ np.s ! NCase Nom
    } ;

  UseComp _ = Eng.UseComp ;
  CompAP _ = Eng.CompAP ;
  CompNP _ = Eng.CompNP ;
  PredVP _ _ = Eng.PredVP;
  PositA _ = Eng.PositA;
  AdjCN _ _ = Eng.AdjCN;
  UseV _ = Eng.UseV;
  PPos = Eng.PPos;
  PNeg = Eng.PNeg;
  BaseNP _ _ = Eng.BaseNP;
  ConsNP _ _ = Eng.ConsNP;
  ConjNP _ _ = Eng.ConjNP;
  BaseS _ _ = Eng.BaseS;
  ConsS _ _ = Eng.ConsS;
  ConjS _ _ = Eng.ConjS;
  UseCl _ _ p x = Eng.UseCl (Eng.TTAnt Eng.TPres Eng.ASimul) p x;
  UttS _ s = Eng.UttS s;

  john_PN = mkPN "John";
  mary_PN = mkPN "Mary";
  love_V2 = mkV2 (mkV "love");
  leave_V = mkV "leave" "left" "left";
  somebody_NP = Eng.somebody_NP;
  everybody_NP = Eng.everybody_NP;
  boy_N = mkN "boy";
  every_Det = Eng.every_Det;
  some_Det = Eng.someSg_Det;
  a_Det = Eng.DetQuant Eng.IndefArt Eng.NumSg;
  smart_A = mkA "smart";
  and_Conj = Eng.and_Conj;
  or_Conj = Eng.or_Conj;

}
