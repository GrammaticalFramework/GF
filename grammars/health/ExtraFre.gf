-- use this path to read the grammar from the same directory
--# -path=.:../abstract:../../prelude:../french:../romance

--1 Functions that are not in the API, but common in Russian 
--
-- Aarne Ranta, Janna Khegai 2003

resource ExtraFre = open PredicationFre, ResourceFre, Prelude, SyntaxFre, MorphoFre, ParadigmsFre in {

oper 
  avoirBesoin: CN -> VP = \medicine ->   
    PosVG ( PredTV (tvDir vAvoir) (DetNP nullDet (
           AppFun (funDe (mkCNomReg "besoin" Masc ** {lock_N =<>})) 
           (IndefOneNP medicine)
         )
       )
    ) **{lock_VP =<>} ;

  injuredBody: (Gender => Number => Str) -> NP -> CN -> S =
   \injured, patient, head -> 
    PredVP patient 
      {s = \\g,v => pronRefl patient.n patient.p ++ 
              verbEtre.s ! v ++
              injured ! g ! patient.n ++
              (DefOneNP head).s ! case2pform Acc;
       lock_VP = <> 
      } ;
  
  
  delDet : Det = mkDeterminer Sg (artDef Masc Sg genitive) 
    (artDef Fem Sg genitive)  ** {lock_Det = <>} ;

  nullDet : Det = mkDeterminer1 Sg "" ** {lock_Det =<>} ;

---  tvAvoir = mkTransVerbDir (verbPres (conj3savoir ""))** {lock_TV = <> };

};


