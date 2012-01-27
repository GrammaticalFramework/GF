--# -path=.:alltenses

concrete FraCaSEng of FraCaS = GrammarEng, AdditionsEng, FraCaSLexEng ** open
  Prelude,
  (G=GrammarEng),
  (A=AdditionsEng),
  (E=ExtraEng),
  (R=ResEng),
  (P=ParadigmsEng),
  (X=ParamX),
  (C=Coordination)
  in {

-- language independent functions

lin
  ComparAsAs x0 x1 = (G.CAdvAP (G.as_CAdv) (G.PositA x0) x1);

lin
  Adverbial x0 = (PAdverbial (G.NoPConj) x0);
  PAdverbial x0 x1 = (G.PhrUtt x0 (G.UttAdv x1) (G.NoVoc));
  Nounphrase x0 = (PNounphrase (G.NoPConj) x0);
  PNounphrase x0 x1 = (G.PhrUtt x0 (G.UttNP x1) (G.NoVoc));
  Question x0 = (PQuestion (G.NoPConj) x0);
  PQuestion x0 x1 = (G.PhrUtt x0 (G.UttQS x1) (G.NoVoc));
  Sentence x0 = (PSentence (G.NoPConj) x0);
  PSentence x0 x1 = (G.PhrUtt x0 (G.UttS x1) (G.NoVoc));

lin
  Past = (G.TTAnt (G.TPast) (G.ASimul));
  PastPerfect = (G.TTAnt (G.TPast) (G.AAnter));
  Present = (G.TTAnt (G.TPres) (G.ASimul));
  PresentPerfect = (G.TTAnt (G.TPres) (G.AAnter));
  Future = (G.TTAnt (G.TFut) (G.ASimul));
  FuturePerfect = (G.TTAnt (G.TFut) (G.AAnter));
  Conditional = (G.TTAnt (G.TCond) (G.ASimul));

lin
  ConjCN2 c n1 n2 = (G.ConjCN c (G.BaseCN n1 n2));
  ConjNP2 c n1 n2 = (G.ConjNP c (G.BaseNP n1 n2));
  ConjNP3 c n1 n2 n3 = (G.ConjNP c (G.ConsNP n1 (G.BaseNP n2 n3)));
  ConjQS2 c q1 q2 = (A.ConjQS c (A.BaseQS q1 q2));
  ConjS2 c s1 s2 = (G.ConjS c (G.BaseS s1 s2));
  ConjVPI2 c v1 v2 = (A.ConjVPI c (A.BaseVPI (A.MkVPI v1) (A.MkVPI v2)));
  ConjVPS2 c t1 p1 v1 t2 p2 v2 = (A.ConjVPS c (A.BaseVPS (A.MkVPS t1 p1 v1) (A.MkVPS t2 p2 v2)));

-- language dependent functions

lin
  UncNeg = E.UncNeg ;

lin
  ComplVSa = A.ComplBareVS ;
  ProgrVPa = G.ProgrVP ;

lin
  elliptic_V = P.mkV ellipsis ellipsis ellipsis ellipsis ellipsis ;
  elliptic_NP_Sg = {s = \\c => ellipsis; a = R.AgP3Sg R.Neutr} ;
  elliptic_NP_Pl = {s = \\c => ellipsis; a = R.AgP3Pl} ;
  elliptic_VP = R.predV elliptic_V ;
  elliptic_Cl = {s = \\_,_,_,_ => ellipsis} ;
  elliptic_VPSlash = R.predV elliptic_V ** {c2 = ""};
  elliptic_V2V = P.mkV2V elliptic_V P.noPrep P.noPrep ;
  elliptic_CN = {s = \\n,c => ellipsis; g = R.Neutr} ;

oper
  ellipsis : Str = "[..]" ;

}
