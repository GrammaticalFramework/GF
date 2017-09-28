concrete SentencePes of Sentence = CatPes ** open Prelude, ResPes,Predef in {

  flags optimize=all_subs ;
  coding = utf8;

  lin

    PredVP np vp = mkClause np vp ;

    PredSCVP sc vp = mkSClause ("این" ++ sc.s) (defaultAgrPes) vp ;

    ImpVP vp = {
      s = \\pol,n => 
        let 
          agr   = AgPes (numImp n) PPers2 ;
	  in case pol of {
          CPos =>  vp.ad ++ vp.comp ! agr  ++ vp.obj.s ++ vp.vComp ! agr ++  ((vp.s ! VPImp Pos (numImp n)).inf) ++ vp.embComp;
	  CNeg _ =>  vp.ad ++ vp.comp ! agr ++ vp.obj.s ++ vp.vComp ! agr ++  ((vp.s ! VPImp Neg (numImp n)).inf) ++ vp.embComp
	  } ;     
    } ;


    SlashVP np vp = 
      mkSlClause np vp ** {c2 = vp.c2} ;

    AdvSlash slash adv = slash ** {
	  vp = \\t,p,o => adv.s ++ slash.vp ! t ! p ! o  ;
      } ;

    SlashPrep cl prep = {
      subj = [] ; ---- AR 18/9/2017 this can destroy SOV ; Cl should be made discont
      vp = cl.s ;
      c2 = { s = prep.s ; ra = [] ; c = VIntrans}
      } ;

    SlashVS np vs slash = 
      mkSlClause  np 
        (insertObj2 (conjThat ++ slash.s) (predV vs))  **
        {c2 = slash.c2} ;

    EmbedS  s  = {s = conjThat ++ s.s} ;
    EmbedQS qs = {s = qs.s ! QIndir} ;
    EmbedVP vp = {s = vp.obj.s ++ vp.inf ++ vp.comp ! defaultAgrPes} ; --- agr


    UseCl  temp p cl = 
	 { s = case <temp.t,temp.a> of {
	  <Pres,Simul> => temp.s ++ p.s ++ cl.s ! VPres ! p.p ! ODir;
          <Pres,Anter> => temp.s ++ p.s ++ cl.s ! VPerfPres ! p.p ! ODir;
          <Past,Simul> => temp.s ++ p.s ++ cl.s ! VPast ! p.p ! ODir;
          <Past,Anter> => temp.s ++ p.s ++ cl.s ! VPerfPast ! p.p ! ODir;
          <Fut,Simul>  => temp.s ++ p.s ++ cl.s ! VFut ! p.p ! ODir;
          <Fut,Anter>  => temp.s ++ p.s ++ cl.s ! VPerfFut ! p.p ! ODir;
          <Cond,Simul> => temp.s ++ p.s ++ cl.s ! VCondSimul ! p.p ! ODir;
          <Cond,Anter> => temp.s ++ p.s ++ cl.s ! VCondAnter ! p.p ! ODir -- this needs to be fixed by making SubjPerf in ResPnb		  

   };
  } ;
     UseQCl temp p cl = {
      s = \\q => case <temp.t,temp.a> of {
	      <Pres,Simul> => temp.s ++ p.s ++ cl.s ! VPres ! p.p ! q;
          <Pres,Anter> => temp.s ++ p.s ++ cl.s ! VPerfPres ! p.p ! q;
          <Past,Simul> => temp.s ++ p.s ++ cl.s ! VPast ! p.p ! q;
          <Past,Anter> => temp.s ++ p.s ++ cl.s ! VPerfPast ! p.p ! q;
          <Fut,Simul>  => temp.s ++ p.s ++ cl.s ! VFut ! p.p ! q;
          <Fut,Anter>  => temp.s ++ p.s ++ cl.s ! VPerfFut ! p.p ! q;
          <Cond,Simul> => temp.s ++ p.s ++ cl.s ! VCondSimul ! p.p ! q;
          <Cond,Anter> => temp.s ++ p.s ++ cl.s ! VCondAnter ! p.p ! q		  
 
   };
  } ;

    UseRCl temp p rcl = {
      s = \\q => case <temp.t,temp.a> of {
	      <Pres,Simul> => temp.s ++ p.s ++ rcl.s ! VPres ! p.p ! ODir ! q;
          <Pres,Anter> => temp.s ++ p.s ++ rcl.s ! VPerfPres ! p.p ! ODir ! q;
          <Past,Simul> => temp.s ++ p.s ++ rcl.s ! VPast ! p.p ! ODir ! q;
          <Past,Anter> => temp.s ++ p.s ++ rcl.s ! VPerfPast ! p.p ! ODir ! q;
          <Fut,Simul>  => temp.s ++ p.s ++ rcl.s ! VFut ! p.p ! ODir ! q;
          <Fut,Anter>  => temp.s ++ p.s ++ rcl.s ! VPerfFut ! p.p ! ODir ! q;
          <Cond,Simul> => temp.s ++ p.s ++ rcl.s ! VCondSimul ! p.p ! ODir ! q;
          <Cond,Anter> => temp.s ++ p.s ++ rcl.s ! VCondAnter ! p.p ! ODir ! q
     };		  
      c = rcl.c
    } ;
    
    UseSlash temp p clslash = {
      s = temp.s ++ p.s ++ clslash.subj ++
          case <temp.t,temp.a> of {
	    <Pres,Simul> => clslash.vp ! VPres ! p.p ! ODir;
            <Pres,Anter> => clslash.vp ! VPerfPres ! p.p ! ODir;
            <Past,Simul> => clslash.vp ! VPast ! p.p ! ODir ;
            <Past,Anter> => clslash.vp ! VPerfPast ! p.p ! ODir;
            <Fut,Simul>  => clslash.vp ! VFut ! p.p ! ODir;
            <Fut,Anter>  => clslash.vp ! VPerfFut ! p.p ! ODir;
            <Cond,Simul> => clslash.vp ! VCondSimul ! p.p ! ODir;
            <Cond,Anter> => clslash.vp ! VCondSimul ! p.p ! ODir
     };		  
      c2 = clslash.c2
    } ;

    AdvS a s = {s = a.s ++ s.s} ;

    RelS s r = {s = s.s ++ r.s ! agrPesP3 Sg} ;
    SSubjS s sj s = { s = s.s ++ sj.s ++ s.s};

}
