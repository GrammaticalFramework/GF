--# -path=.:alltenses

concrete FraCaSSwe of FraCaS = GrammarSwe, AdditionsSwe, FraCaSLexSwe ** open
  Prelude,
  (G=GrammarSwe),
  (A=AdditionsSwe),
  (I=IrregSwe),
  (M=MorphoSwe),
  (P=ParadigmsSwe),
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
  UncNeg = G.PNeg ;

lin
  ComplVSa = G.ComplVS ;
  ProgrVPa vp = vp ;

lin
  elliptic_V = {s = \\_ => ellipsis; part = ""; vtype = M.VAct};
  elliptic_NP_Sg = {s = \\_ => ellipsis; a = M.agrP3 M.utrum M.Sg} ;
  elliptic_NP_Pl = {s = \\_ => ellipsis; a = M.agrP3 M.utrum M.Pl} ;
  elliptic_VP = G.UseV elliptic_V ;
  elliptic_Cl = {s = \\_,_,_,_ => ellipsis} ;
  elliptic_VPSlash = G.UseV elliptic_V ** {c2 = {s=ellipsis; hasPrep=False}; n3 = \\_ => ellipsis};
  elliptic_V2V = elliptic_V ** {c2,c3 = M.mkComplement ""} ;
  elliptic_CN = {s = \\_,_,_ => ellipsis; g = M.utrum; isMod = False} ;

oper
  ellipsis : Str = "[..]" ;

}
