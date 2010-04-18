--# -path=.:../romance:../common:../abstract:../../prelude
concrete ExtraRon of ExtraRonAbs = CatRon ** 
  open ResRon, ParadigmsRon, Prelude, MorphoRon in {

  lin
 at_Prep = mkPrep "la" Ac;  
 DatSubjCl np vp = mkClause (np.s ! Da).comp (agrP3 Masc Sg) (insertClit vp np);
 
 
 
 oper     
insertClit : VerbPhrase -> NounPhrase -> VerbPhrase = \vp, np ->      
                        let  
                             vcDa = case np.nForm of 
                                        {HasClit => nextClit vp.nrClit PDat ;
                                         _       => vp.nrClit
                                         };                             
                             vpp = insertObje (\\_ => "") RNoAg (clitFromNoun np Da) False vcDa vp;
                            in 
                         {isRefl = vpp.isRefl; 
                          s = vpp.s ; isFemSg = vpp.isFemSg ; pReflClit = vp.pReflClit ;
                          nrClit = vpp.nrClit; clAcc = vpp.clAcc ; 
                          clDat = vpp.clDat ; neg   = vpp.neg ;
                          comp  = \\a => vpp.comp ! (np.a);
                          ext   = vpp.ext ;
                          lock_VP = <> };


    
} 
