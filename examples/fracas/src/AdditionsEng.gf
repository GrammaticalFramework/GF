--# -path=.:alltenses

concrete AdditionsEng of Additions = CatEng **
  open ResEng, Coordination, Prelude, MorphoEng, ParadigmsEng,
  (E=ExtraEng),
  (R=ResEng),
  (G=GrammarEng),
  (P=ParadigmsEng),
  (X=ParamX),
  (C=Coordination)
  in {

-- First we start with the contents of the RGL's ExtraEng.gf, as it looked like in October 2011.

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
  PassVPSlash = E.PassVPSlash ;
  PartVP = E.PartVP ;
  EmbedPresPart = E.EmbedPresPart ;

-- And then we give some FraCaS-specific additions to the original ExtraEng.gf.

lincat
  [QS] = {s1,s2 : X.QForm => Str} ;
  [Det] = {s1,s2 : Str ; sp1,sp2 : R.NPCase => Str ; n : X.Number ; hasNum : Bool} ;

lin
  RelNPa np rs = {
      s = \\c => np.s ! c ++ rs.s ! np.a ;
      a = np.a
      } ;

  UseComparA_prefix = G.UseComparA ;

  PassV2s = G.PassV2 ;

  SoDoI subj = {
    s = \\t,a,b,o =>
      let 
	so = case b of {
	  R.CPos => "so" ; 
	  R.CNeg c => "neither"
	  } ;
	did = case <t,a> of {
	  <X.Pres,X.Simul> => R.agrVerb "does" "do" subj.a ;
	  <X.Pres,X.Anter> => R.agrVerb "has" "have" subj.a ;
	  <X.Past,X.Simul> => "did" ;
	  <X.Past,X.Anter> => "had" ;
	  <X.Fut ,_      > => "will" ;
	  <X.Cond,_      > => "would" 
	  }
      in 
      case o of {
	R.ODir   => so ++ did ++ (subj.s ! R.npNom) ;
	R.OQuest => did ++ (subj.s ! R.npNom) ++ so 
      }
    } ;

  ExtAdvQS a s = {s = \\q => a.s ++ "," ++ s.s ! q} ;

  ConjQS conj ss = C.conjunctDistrTable X.QForm conj ss ;
  BaseQS x y = C.twoTable X.QForm x y ;
  ConsQS x xs = C.consrTable X.QForm C.comma x xs ;

  ConjDet conj ss = C.conjunctDistrSS conj ss ** {
    sp = \\c => conj.s1 ++ ss.sp1 ! c ++ conj.s2 ++ ss.sp2 ! c;
    n = X.conjNumber conj.n ss.n; hasNum = ss.hasNum
    } ;
  BaseDet x y = C.twoSS x y ** {
    sp1 = x.sp; sp2 = y.sp; n = X.conjNumber x.n y.n; hasNum = orB x.hasNum y.hasNum
    } ;
  ConsDet x xs = C.consrSS C.comma x xs ** {
    sp1 = \\c => x.sp ! c ++ C.comma ++ xs.sp1 ! c;
    sp2 = xs.sp2; n = X.conjNumber xs.n x.n; hasNum = orB xs.hasNum x.hasNum
    } ;

}
