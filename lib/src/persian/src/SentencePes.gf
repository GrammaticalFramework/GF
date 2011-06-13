concrete SentencePes of Sentence = CatPes ** open Prelude, ResPes,Predef in {

  flags optimize=all_subs ;
  coding = utf8;

  lin

    PredVP np vp = mkClause np vp ;

    PredSCVP sc vp = mkSClause ("Ayn" ++ sc.s) (defaultAgrPes) vp ;

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
      mkClause np vp ** {c2 = vp.c2} ;

    AdvSlash slash adv = {
	  s  = \\t,p,o =>  adv.s ++ slash.s ! t ! p ! o  ;
      c2 = slash.c2
    } ;

    SlashPrep cl prep = cl **  {c2 = { s = prep.s ; ra = [] ; c = VIntrans}} ;

    SlashVS np vs slash = 
      mkClause  np 
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
      s = case <temp.t,temp.a> of {
	      <Pres,Simul> => temp.s ++ p.s ++ clslash.s ! VPres ! p.p ! ODir;
          <Pres,Anter> => temp.s ++ p.s ++ clslash.s ! VPerfPres ! p.p ! ODir;
          <Past,Simul> => temp.s ++ p.s ++ clslash.s ! VPast ! p.p ! ODir ;
          <Past,Anter> => temp.s ++ p.s ++ clslash.s ! VPerfPast ! p.p ! ODir;
          <Fut,Simul>  => temp.s ++ p.s ++ clslash.s ! VFut ! p.p ! ODir;
          <Fut,Anter>  => temp.s ++ p.s ++ clslash.s ! VPerfFut ! p.p ! ODir;
          <Cond,Simul> => temp.s ++ p.s ++ clslash.s ! VCondSimul ! p.p ! ODir;
          <Cond,Anter> => temp.s ++ p.s ++ clslash.s ! VCondSimul ! p.p ! ODir
     };		  
      c2 = clslash.c2
    } ;

    AdvS a s = {s = a.s ++ s.s} ;

    RelS s r = {s = s.s ++ r.s ! agrPesP3 Sg} ;
    SSubjS s sj s = { s = s.s ++ sj.s ++ s.s};

}
