concrete SentenceUrd of Sentence = CatUrd ** open Prelude, ResUrd in {

  flags optimize=all_subs ;

  lin

    PredVP np vp = mkClause np vp ;

    PredSCVP sc vp = mkSClause sc.s (defaultAgr) vp ;

    ImpVP vp = {
      s = \\pol,n => 
        let 
          agr   = Ag Masc (numImp n) Pers2_Casual ;
          verb  = infVP True vp agr ;
          dont  = case pol of {
            CNeg True => mt_Str ;
            CNeg False => nh_Str ;
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
    EmbedVP vp = {s = infVP False vp defaultAgr} ; --- agr

    UseCl  temp p cl = 
	 { s = case <temp.t,temp.a> of {
	      <Pres,Simul> => temp.s ++ p.s ++ cl.s ! VPGenPres ! p.p ! ODir
          ;<Pres,Anter> => temp.s ++ p.s ++ cl.s ! VPPerfPres ! p.p ! ODir;  --# notpresent
          <Past,Simul> => temp.s ++ p.s ++ cl.s ! VPImpPast ! p.p ! ODir; --# notpresent
          <Past,Anter> => temp.s ++ p.s ++ cl.s ! VPPerfPast ! p.p ! ODir; --# notpresent
          <Fut,Simul>  => temp.s ++ p.s ++ cl.s ! VPFut ! p.p ! ODir; --# notpresent
          <Fut,Anter>  => temp.s ++ p.s ++ cl.s ! VPPerfFut ! p.p ! ODir; --# notpresent
          <Cond,Simul> => temp.s ++ p.s ++ cl.s ! VPContPres ! p.p ! ODir; --# notpresent
          <Cond,Anter> => temp.s ++ p.s ++ cl.s ! VPContPast ! p.p ! ODir --# notpresent		  

   };
  } ;
    UseQCl temp p cl = {
      s = \\q => case <temp.t,temp.a> of {
	      <Pres,Simul> => temp.s ++ p.s ++ cl.s ! VPGenPres ! p.p ! q
          ;<Pres,Anter> => temp.s ++ p.s ++ cl.s ! VPPerfPres ! p.p ! q; --# notpresent
          <Past,Simul> => temp.s ++ p.s ++ cl.s ! VPImpPast ! p.p ! q; --# notpresent
          <Past,Anter> => temp.s ++ p.s ++ cl.s ! VPPerfPast ! p.p ! q; --# notpresent
          <Fut,Simul>  => temp.s ++ p.s ++ cl.s ! VPFut ! p.p ! q; --# notpresent
          <Fut,Anter>  => temp.s ++ p.s ++ cl.s ! VPPerfFut ! p.p ! q; --# notpresent
          <Cond,Simul> => temp.s ++ p.s ++ cl.s ! VPContPres ! p.p ! q; --# notpresent
          <Cond,Anter> => temp.s ++ p.s ++ cl.s ! VPContPast ! p.p ! q		   --# notpresent
 
   };
  } ;
    UseRCl temp p rcl = {
      s = \\q => case <temp.t,temp.a> of {
	      <Pres,Simul> => temp.s ++ p.s ++ rcl.s ! VPGenPres ! p.p ! ODir ! q
         ;<Pres,Anter> => temp.s ++ p.s ++ rcl.s ! VPPerfPres ! p.p ! ODir ! q; --# notpresent
          <Past,Simul> => temp.s ++ p.s ++ rcl.s ! VPImpPast ! p.p ! ODir ! q; --# notpresent
          <Past,Anter> => temp.s ++ p.s ++ rcl.s ! VPPerfPast ! p.p ! ODir ! q; --# notpresent
          <Fut,Simul>  => temp.s ++ p.s ++ rcl.s ! VPFut ! p.p ! ODir ! q; --# notpresent
          <Fut,Anter>  => temp.s ++ p.s ++ rcl.s ! VPPerfFut ! p.p ! ODir ! q; --# notpresent
          <Cond,Simul> => temp.s ++ p.s ++ rcl.s ! VPContPres ! p.p ! ODir ! q; --# notpresent
          <Cond,Anter> => temp.s ++ p.s ++ rcl.s ! VPContPast ! p.p ! ODir ! q --# notpresent
     };		  
      c = rcl.c
    } ;
    UseSlash temp p clslash = {
      s = case <temp.t,temp.a> of {
	      <Pres,Simul> => temp.s ++ p.s ++ clslash.s ! VPGenPres ! p.p ! ODir
         ;<Pres,Anter> => temp.s ++ p.s ++ clslash.s ! VPPerfPres ! p.p ! ODir; --# notpresent
          <Past,Simul> => temp.s ++ p.s ++ clslash.s ! VPImpPast ! p.p ! ODir ; --# notpresent
          <Past,Anter> => temp.s ++ p.s ++ clslash.s ! VPPerfPast ! p.p ! ODir; --# notpresent
          <Fut,Simul>  => temp.s ++ p.s ++ clslash.s ! VPFut ! p.p ! ODir; --# notpresent
          <Fut,Anter>  => temp.s ++ p.s ++ clslash.s ! VPPerfFut ! p.p ! ODir; --# notpresent
          <Cond,Simul> => temp.s ++ p.s ++ clslash.s ! VPContPres ! p.p ! ODir; --# notpresent
          <Cond,Anter> => temp.s ++ p.s ++ clslash.s ! VPContPast ! p.p ! ODir --# notpresent
     };		  
      c2 = clslash.c2
    } ;

    AdvS a s = {s = a.s ++ s.s} ;

    RelS s r = {s = s.s ++ r.s ! agrP3 Masc Sg} ;
    SSubjS s sj s = { s = s.s ++ sj.s ++ s.s};

}
