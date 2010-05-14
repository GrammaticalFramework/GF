--# -path=.:../romance:../common:../abstract:../../prelude
concrete ExtraRon of ExtraRonAbs = CatRon ** 
  open ResRon, ParadigmsRon, Prelude, MorphoRon in {

  lin
 at_Prep = mkPrep "la" Ac True;
 DatSubjCompCl np vp np2 = let ss = if_then_Str np.isPronoun "" (np.s ! Dat).comp
                              in 
                            mkClause ss np.isPol np2.a (insertDatClit (insertSimpObj (\\_ => (np2.s ! Nom).comp) vp) np);

 AccSubjCl np vp = let ss = if_then_Str np.isPronoun "" (np.s ! Ac).comp
                     in 
                       mkClause ss np.isPol (agrP3 Masc Sg) (insertAccClit vp np) ;

 DatSubjCl np vp = let ss = if_then_Str np.isPronoun "" (np.s ! Da).comp 
                      in mkClause ss np.isPol (agrP3 Masc Sg) (insertDatClit vp np);
i8fem_Pron = mkPronoun "eu" "mine" "mie" [] [] "meu" "mea" "mei" "mele" Fem Sg P1 ;
youSg8fem_Pron = mkPronoun "tu" "tine" "ţie" [] "tu" "tău" "ta" "tăi" "tale"  Fem Sg P2 ;
youPl8fem_Pron = mkPronoun "voi" "voi" "vouă" [] "voi" "vostru" "voastră" "voştri" "voastre" Fem Pl P2 ;
youPol8fem_Pron = let dvs = mkPronoun "dumneavoastră" "dumneavoastră" "dumneavoastră" [] "dumneavoastră" "dumneavoastră" "dumneavoastră" "dumneavoastră" "dumneavoastră" Fem Pl P2 
             in 
            {s = dvs.s; c1 = dvs.c1; 
                c2 = dvs.c2; a = dvs.a; isPol = True; poss = dvs.poss} ;  

refCN n = n ** {isComp = False; needsRefForm = True}; 
 
 oper     
insertDatClit : VerbPhrase -> NounPhrase -> VerbPhrase = \vp, np ->      
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


insertAccClit : VerbPhrase -> NounPhrase -> VerbPhrase = \vp, np ->      
                        let  
                             vcAc = case np.nForm of 
                                        {HasClit => nextClit vp.nrClit PAcc ;
                                         _       => vp.nrClit
                                         };                             
                             vpp = insertObje (\\_ => "") (clitFromNoun np Ac) RNoAg (isAgrFSg np.a) vcAc vp ;
                            in 
                         {isRefl = vpp.isRefl; 
                          s = vpp.s ; isFemSg = vpp.isFemSg ; pReflClit = vp.pReflClit ;
                          nrClit = vpp.nrClit; clAcc = vpp.clAcc ; 
                          clDat = vpp.clDat ; neg   = vpp.neg ;
                          comp  = \\a => vpp.comp ! (np.a);
                          ext   = vpp.ext ;
                          lock_VP = <> };

    
} 
