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

lincat
    VPS   = {s : Agr => Str} ;
    [VPS] = {s1,s2 : Agr => Str} ;

  lin
    BaseVPS = twoTable Agr ;
    ConsVPS = consrTable Agr comma ;

    PredVPS np vpi = {s = np.s ! NPC Dir ++ vpi.s ! np.a} ;

    MkVPS t p vp = {
      s = \\a => 
           
            let 
              verb =  vp.s ! (VPTense VPPast a) ; -- this needs to be fixed --vp.s ! t.t ! t.a ! p.p ! ODir ! a ;
              verbf =   verb.fin ++ verb.inf ;
            in t.s ++ p.s ++ vp.ad ++ vp.cvp ++  verbf ++ vp.obj.s ++ vp.comp ! a
      } ;

    ConjVPS = conjunctDistrTable Agr ;
    
--    ComplVPIVV vv vpi = 
--      insertObj (\\a => vpi.s ! vv.typ ! a) (predVV vv) ;

--PassVPSlash vps = vps ;

-- in progress
PassVPSlash vps = 
    let 
      aux = predV (mkV "جانا")
    in {
   -- s = be.s ;
    s = table {
      VPTense tense agr => {inf = (vps.s ! VPTense VPPast agr).inf ++ (aux.s ! VPTense tense agr).inf ;
                            fin = (aux.s ! VPTense tense agr).fin};
      vform                 => {inf = (vps.s ! vform).inf ++ (aux.s!vform).inf; fin = (vps.s!vform).inf}
      };
    obj = vps.obj ;
      subj = vps.subj ;
      inf = (vps.s ! VPTense VPPast (Ag Masc Sg Pers3_Distant)).inf ++ aux.inf; --this is not correct since, in this case the infinitive form will also inflect for agr i.e. khaya jana, khai jani etc
      ad = vps.ad;
      embComp = vps.embComp;
      prog = vps.prog ;
      comp = vps.comp ;
      cvp = vps.cvp       
   } ;

}