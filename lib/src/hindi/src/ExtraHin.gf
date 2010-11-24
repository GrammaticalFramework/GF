--# -path=.:../abstract:../common:../prelude:/Users/virk/gf_1/lib/src/hindustani
concrete ExtraHin of ExtraHinAbs = CatHin ** 
  open ResHin, Coordination, Prelude, MorphoHin, ParadigmsHin in {

  lin
--    GenNP np = {s = \\_,_,_ => np.s ! NPC Obl ++ "ka" ; a = np.a} ;

--    each_Det = mkDet  "hr kwy" "hr kwy" "hr kwy" "hr kwy" Sg ;
    have_V = mkV "rakh-na";
--    IAdvAdv adv = {s = "ktny" ++ adv.s} ;
--    ICompAP ap = {s = "ktnE" ++ ap.s ! Sg ! Masc ! Dir ! Posit} ;
--    CompoundCN cn1 cn2 = {s = \\n,c => cn1.s ! n ! c ++ cn2.s ! n ! c ; g = cn2.g } ;
--    ImperfAP verb = {s = \\n,g,_,_ => verb.s ! VF Habitual Pers3_Distant n g ++ hwa n g } ;
--    SlashVP vp = {
--     s = vp.s ;
--     obj = vp.obj ;
--     inf = vp.inf ;
--     subj = vp.subj ;
--	 ad = vp.ad ;
--     embComp = vp.embComp;
--     comp = vp.comp  
--    } ;

-- for VP conjunction
} 
