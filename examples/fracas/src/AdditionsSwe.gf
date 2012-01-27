--# -path=.:alltenses

concrete AdditionsSwe of Additions = CatSwe ** 
  open CommonScand, Coordination, ResSwe, ParamX,
  Prelude,
  (E=ExtraSwe),
  (M=MorphoSwe),
  (P=ParadigmsSwe),
  (I=IrregSwe),
  (G=GrammarSwe),
  (X=ParamX),
  (C=Coordination)
  in {

-- First we start with the contents of the RGL's ExtraSwe.gf, as it looked like in October 2011.

lin
  GenNP = E.GenNP ;
  ComplBareVS = E.ComplBareVS ;
  StrandRelSlash = E.StrandRelSlash ; 
  EmptyRelSlash = E.EmptyRelSlash ; 

lincat
  VPI   = E.VPI ;
  [VPI] = E.ListVPI ;

lin
  BaseVPI = E.BaseVPI ;
  ConsVPI = E.ConsVPI ;
  MkVPI = E.MkVPI ;
  ConjVPI = E.ConjVPI ;
  ComplVPIVV = E.ComplVPIVV ;

lincat
  VPS   = E.VPS ;
  [VPS] = E.ListVPS ;

lin
  BaseVPS = E.BaseVPS ;
  ConsVPS = E.ConsVPS ;
  PredVPS = E.PredVPS ;
  MkVPS = E.MkVPS ;
  ConjVPS = E.ConjVPS ;

lin
  PassVPSlash vps = variants{} ;  -- M.insertObj (\\a => "[??]") (UseV M.verbBecome) ;
  PartVP vp = variants{} ;  -- {s = \\ap => "[??]"; isPre = False} ;
  EmbedPresPart vp = variants{} ;

-- And then we give some FraCaS-specific additions to the original ExtraSwe.gf.

lincat
  [QS] = {s1,s2 : X.QForm => Str} ;
  [Det] = {s1,s2,sp1,sp2 : Bool => M.NGender => Str ; n : M.Number ; det : M.DetSpecies} ;

lin
  RelNPa np rs = {
    s = \\c => np.s ! c ++ rs.s ! np.a ! M.RNom ;
    a = np.a ;
    isMod = np.isMod
    } ;

  UseComparA_prefix a = {s = (G.UseComparA a).s; isPre = True};

  PassV2s v2 = predV (P.depV (lin V v2)) ;

  SoDoI subj = M.mkClause "det" (M.agrP3 M.neutrum M.Sg) 
    (M.insertObj (\\_ => subj.s ! M.nominative ++ "också") (G.UseV I.göra_V)) ;
  -- error in Anter: "det har gjort han också"
  -- error in PNeg: "det gör inte han också" (better: "inte heller")
  -- probably error in Inv/Sub word order too

  ExtAdvQS a s = {s = \\q => a.s ++ "," ++ s.s ! q} ;

  ConjQS conj ss = C.conjunctDistrTable X.QForm conj ss ;
  BaseQS x y = C.twoTable X.QForm x y ;
  ConsQS x xs = C.consrTable X.QForm C.comma x xs ;

  ConjDet conj ss = variants{} ;
  BaseDet x y = variants{} ;
  ConsDet x xs = variants{} ;

}
