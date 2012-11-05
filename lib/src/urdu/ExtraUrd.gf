concrete ExtraUrd of ExtraUrdAbs = CatUrd ** 
  open ResUrd, Coordination, Prelude, MorphoUrd, ParadigmsUrd,CommonHindustani in {

flags coding = utf8 ;

  lin
 --   GenNP np = {s = \\_,_,_ => np.s ! NPC Obl ++ "کا" ; a = np.a} ;
  GenNP np = {s = \\n,g,c => 
     case <n,g,c> of {
     <Sg,Masc,Obl> => np.s ! NPC Obl ++ "کے" ;
     <Sg,Masc,_> => np.s ! NPC Obl ++ "کا" ;
     <Pl,Masc,_> => np.s ! NPC Obl ++ "کے" ;
     <_,Fem,_> => np.s ! NPC Obl ++ "کی"
     };
     
   a = np.a} ;

    each_Det = mkDet  "ہر کوی" "ہر کوی" "ہر کوی" "ہر کوی" Sg ;
    have_V = mkV "راکھنا";
    IAdvAdv adv = {s = "کتنی" ++ adv.s ! Masc} ;
    ICompAP ap = {s = "کتنے" ++ ap.s ! Sg ! Masc ! Dir ! Posit} ;
    cost_V = mkV "قیمت" ;
    
    -- added for causitives
    make_CV = mkVerb "نoتہiنگ"   ** {c2 = "" };

-- for VP conjunction

PassVPSlash vps = vps ;
{-
--{
  --  let 
  --    be = predAux auxBe 
   -- in {
   -- s = be.s ;
   s = vps.s ;
    obj = vps.obj ;
      subj = vps.c2.c ;
      inf = vps.inf;
      ad = vps.ad;
      embComp = vps.embComp;
      prog = vps.prog ;
      comp = vps.comp ;
      cvp = vps.cvp       
   -- } ;

--};
-}
}