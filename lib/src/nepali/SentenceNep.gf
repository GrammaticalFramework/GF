concrete SentenceNep of Sentence = CatNep ** open Prelude, ResNep in {

  flags optimize=all_subs ;
  coding = utf8;

  lin

    PredVP np vp = mkClause np vp ;
    
    PredSCVP sc vp = mkSClause sc.s (defaultAgr) vp ;

    ImpVP vp = {
      s = \\pol,n => 
        let 
          agr   = Ag Masc (numImp n) Pers2_M ; 
          --verb  = vp.obj.s ++ (vp.s ! PVForm).inf ++ vp.comp ! agr ;
          verb  = vp.obj.s ++ (vp.s ! Root).inf ++ vp.comp ! agr ;
          --verb  = vp.obj.s ++ vp.comp ! agr ++ (vp.s ! Root).inf ;
          dont  = case pol of {
            CNeg True => "नगर" ;
            CNeg False => "नगर" ;
            _ => []
            }
        in
        dont ++ verb
    } ;

    SlashVP np vp = 
      mkClause np vp ** {c2 = vp.c2} ;

    AdvSlash slash adv = {
	  s  = \\t,p,o =>  adv.s ++ slash.s ! t ! p ! o  ;
      c2 = slash.c2
    } ;

    SlashPrep cl prep = cl **  {c2 = { s = prep.s ; c = VIntrans}} ;

    SlashVS np vs slash = 
      mkClause  np 
        (insertObj2 (conjThat ++ slash.s) (predV vs))  **
        {c2 = slash.c2} ;

    EmbedS  s  = {s = conjThat ++ s.s} ;
    EmbedQS qs = {s = qs.s ! QIndir} ;
    EmbedVP vp = {s = vp.obj.s ++ (vp.s! PVForm).inf ++ vp.comp ! defaultAgr} ; --- agr


  UseCl  temp p cl = 
	 { s = case <temp.t,temp.a> of {
	      <Pres,Simul> => temp.s ++ p.s ++ cl.s ! VPGenPres ! p.p ! ODir;
          <Pres,Anter> => temp.s ++ p.s ++ cl.s ! VPPerfPres ! p.p ! ODir;
          <Past,Simul> => temp.s ++ p.s ++ cl.s ! VPSmplPast ! p.p ! ODir;
          <Past,Anter> => temp.s ++ p.s ++ cl.s ! VPPerfPast ! p.p ! ODir;
          <Fut,Simul>  => temp.s ++ p.s ++ cl.s ! VPFut ! p.p ! ODir;
          <Fut,Anter>  => temp.s ++ p.s ++ cl.s ! VPPerfFut ! p.p ! ODir;
          <Cond,Simul> => temp.s ++ p.s ++ cl.s ! VPCondPres ! p.p ! ODir;
          <Cond,Anter> => temp.s ++ p.s ++ cl.s ! VPCondPast ! p.p ! ODir 

   };
  } ;
  
    UseQCl temp p cl = {
      s = \\q => case <temp.t,temp.a> of {
	      <Pres,Simul> => temp.s ++ p.s ++ cl.s ! VPGenPres ! p.p ! q;
          <Pres,Anter> => temp.s ++ p.s ++ cl.s ! VPPerfPres ! p.p ! q;
          <Past,Simul> => temp.s ++ p.s ++ cl.s ! VPSmplPast ! p.p ! q;
          <Past,Anter> => temp.s ++ p.s ++ cl.s ! VPPerfPast ! p.p ! q;
          <Fut,Simul>  => temp.s ++ p.s ++ cl.s ! VPFut ! p.p ! q;
          <Fut,Anter>  => temp.s ++ p.s ++ cl.s ! VPPerfFut ! p.p ! q;
          <Cond,Simul> => temp.s ++ p.s ++ cl.s ! VPCondPres ! p.p ! q;
          <Cond,Anter> => temp.s ++ p.s ++ cl.s ! VPCondPast ! p.p ! q		  
 
   };
  } ;
  
    UseRCl temp p rcl = {
      s = \\q => case <temp.t,temp.a> of {
	      <Pres,Simul> => temp.s ++ p.s ++ rcl.s ! VPGenPres ! p.p ! ODir ! q;
          <Pres,Anter> => temp.s ++ p.s ++ rcl.s ! VPPerfPres ! p.p ! ODir ! q;
          <Past,Simul> => temp.s ++ p.s ++ rcl.s ! VPSmplPast ! p.p ! ODir ! q;
          <Past,Anter> => temp.s ++ p.s ++ rcl.s ! VPPerfPast ! p.p ! ODir ! q;
          <Fut,Simul>  => temp.s ++ p.s ++ rcl.s ! VPFut ! p.p ! ODir ! q;
          <Fut,Anter>  => temp.s ++ p.s ++ rcl.s ! VPPerfFut ! p.p ! ODir ! q;
          <Cond,Simul> => temp.s ++ p.s ++ rcl.s ! VPCondPres ! p.p ! ODir ! q;
          <Cond,Anter> => temp.s ++ p.s ++ rcl.s ! VPCondPast ! p.p ! ODir ! q
     };		  
      c = rcl.c
    } ;
    
    UseSlash temp p clslash = {
      s = case <temp.t,temp.a> of {
	      <Pres,Simul> => temp.s ++ p.s ++ clslash.s ! VPGenPres ! p.p ! ODir;
          <Pres,Anter> => temp.s ++ p.s ++ clslash.s ! VPPerfPres ! p.p ! ODir;
          <Past,Simul> => temp.s ++ p.s ++ clslash.s ! VPSmplPast ! p.p ! ODir ;
          <Past,Anter> => temp.s ++ p.s ++ clslash.s ! VPPerfPast ! p.p ! ODir;
          <Fut,Simul>  => temp.s ++ p.s ++ clslash.s ! VPFut ! p.p ! ODir;
          <Fut,Anter>  => temp.s ++ p.s ++ clslash.s ! VPPerfFut ! p.p ! ODir;
          <Cond,Simul> => temp.s ++ p.s ++ clslash.s ! VPCondPres ! p.p ! ODir;
          <Cond,Anter> => temp.s ++ p.s ++ clslash.s ! VPCondPast ! p.p ! ODir
     };		  
      c2 = clslash.c2
    } ;

    AdvS a s = {s = a.s  ++ s.s} ;

    RelS s r = {s = s.s ++ r.s ! agrP3 Masc Sg} ;
    SSubjS s sj s = { s = s.s ++ sj.s ++ s.s};
    
}
