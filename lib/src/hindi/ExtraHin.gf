concrete ExtraHin of ExtraHinAbs = CatHin ** 
  open ResHin, Coordination, Prelude, MorphoHin, ParadigmsHin,CommonHindustani in {

flags coding = utf8 ;

  lin
 
 GenNP np = {s = \\n,g,c => 
     case <n,g,c> of {
     <Sg,Masc,Obl> => np.s ! NPC Obl ++ "के" ;
     <Sg,Masc,_> => np.s ! NPC Obl ++ "का" ;
     <Pl,Masc,_> => np.s ! NPC Obl ++ "के" ;
     <_,Fem,_> => np.s ! NPC Obl ++ "की"
     };
     
   a = np.a} ;

--    each_Det = mkDet  "हर कwय" "हर कwय" "हर कwय" "हर कwय" Sg ;
    have_V = mkV "राखना";
    IAdvAdv adv = {s = "कितनी" ++ adv.s ! Masc} ;
    ICompAP ap = {s = "कितने" ++ ap.s ! Sg ! Masc ! Dir ! Posit} ;
    cost_V = mkV "क़ीमत" ;
    
    -- added for causitives
    make_CV = mkVerb "नoतहिनग"   ** {c2 = "" };
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
      aux = predV (mkV "जाना")
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