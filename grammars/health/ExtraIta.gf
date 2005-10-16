-- use this path to read the grammar from the same directory
--# -path=.:../../lib/resource-0.6/abstract:../../lib/prelude:../../lib/resource-0.6/italian:../../lib/resource-0.6/romance

--1 Functions that are not in the API, but common in Italian
--
-- Aarne Ranta, Janna Khegai 2003

resource ExtraIta = open PredicationIta, Prelude, SyntaxIta, MorphoIta, ResourceIta in {

oper 

  averBisogno : CN -> VP = \cn ->
    PosVG (PredTV (mkTransVerbPrep (verbPres avere) "bisogno"** {lock_TV = <>}) (IndefOneNP cn)) ;

-- the following are too low-level and should be provided by the resources

  injuredBody: AP -> NP -> CN -> S = \injured, patient, head ->
    (PredVP patient
      {s = \\g,v => pronRefl patient.n patient.p ++
              verbEssere.s ! v ++
              injured.s ! (AF g patient.n) ++
              (DefOneNP head).s ! case2pform accusative ;
       lock_VP = <> 
      } ) ** {lock_S = <> };

  partitNP : CN -> NP = \cn ->
    let {np = DefOneNP cn} in {s = \\_ => np.s ! Aton genitive} ** np ;

  datAdv : NP -> AdV = \np ->
    {s = np.s ! Aton dative; lock_AdV = <> } ;
 
};


