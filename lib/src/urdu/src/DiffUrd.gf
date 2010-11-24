instance DiffUrd of DiffHindustani = open CommonHindustani, Prelude in {

flags coding = utf8 ;

oper

Clause : Type = {s : VPHTense => Polarity => Order => Str} ;
  mkClause : NP -> VPH -> Clause = \np,vp -> {
      s = \\vt,b,ord => 
        let 
          subjagr : NPCase * Agr = case vt of {
            VPImpPast => case vp.subj of {
              VTrans     => <NPErg, vp.obj.a> ;
              VTransPost => <NPErg, defaultAgr> ;
              _          => <NPC Dir, np.a>
              } ;
            _ => <NPC Dir, np.a>
            } ;
          subj = subjagr.p1 ;
          agr  = subjagr.p2 ;
		  n    = (fromAgr agr).n;
		  p    = (fromAgr agr).p;
		  g    = (fromAgr agr).g;
          vps  = case vt of {

		   VPGenPres  => vp.s !  VPTense VPPres agr ;
		   VPImpPast  => vp.s !  VPTense VPPast agr ;		    
		   VPFut      => case vp.prog of { True => {fin = (vp.s !  VPTense VPFutr agr).fin ; inf = (vp.s !  VPTense VPFutr agr).inf ++ hw p n} ;
                                                   _    => vp.s !  VPTense VPFutr agr } ;
                   VPContPres => {fin = copula CPresent n p g ; inf = (vp.s ! VPStem).inf ++ raha g n } ;
		   VPContPast => {fin = copula CPast n p g ; inf = (vp.s ! VPStem).inf ++ raha g n } ;
		   VPContFut  => {fin = copula CFuture n p g ; inf = (vp.s ! VPStem).inf ++ raha g n ++ hw p n} ;
		   VPPerfPres => {fin = copula CPresent n p g ; inf = (vp.s ! VPTense VPPerf agr).inf } ;  
		   VPPerfPast => {fin = copula CPast n p g ; inf = (vp.s ! VPTense VPPerf agr).inf } ;  
		   VPPerfFut  => {fin = copula CFuture n p g ; inf = (vp.s ! VPTense VPPerf agr).inf  ++ hw p n } ;
		   VPPerfPresCont => {fin = copula CPresent n p g ; inf = (vp.s ! VPTense VPPres agr).inf ++ raha g n } ;					
	           VPPerfPastCont => {fin = copula CPast n p g ; inf = (vp.s ! VPTense VPPres agr).inf ++ raha g n } ;					
		   VPPerfFutCont =>  {fin = copula CFuture n p g ; inf = (vp.s ! VPTense VPPres agr).inf ++ raha g n  ++ hw p n } ;					
		   VPSubj   => case vp.prog of { True => {fin = (vp.s !  VPTense VPFutr agr).inf ++ hw p n ; inf = "Xayd" } ;
		   _    => {fin = (vp.s !  VPTense VPFutr agr).inf ; inf = "Xayd" } } 
                   
		  };
					
		    
          quest =
            case ord of
              { ODir => [];
                OQuest => "kya" }; 
		  na =
            case b of
              { Pos => [];
                Neg => "na" };
           nahim =
            case b of 
              { Pos => [];
                Neg => "nhyN" };
        in
		case vt of {
		VPSubj => quest ++ np.s ! subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! np.a  ++ na ++  vps.inf ++ vps.fin ++ vp.embComp ;
		_      => quest ++ np.s ! subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! np.a  ++ nahim  ++  vps.inf ++ vps.fin ++ vp.embComp};

  } ;

  mkSClause : Str -> Agr -> VPH -> Clause =
    \subj,agr,vp -> {
      s = \\t,b,ord => 
        let 
		  n    = (fromAgr agr).n;
		  p    = (fromAgr agr).p;
		  g    = (fromAgr agr).g;
          vps  = case t of {
                    VPGenPres  => vp.s !  VPTense VPPres agr ;
		    VPImpPast  => vp.s !  VPTense VPPast agr ;
		    VPFut      => vp.s !  VPTense VPFutr agr ;
		    VPContPres => {fin = copula CPresent n p g ; inf = (vp.s ! VPStem).inf ++ raha g n  } ;
		    VPContPast => {fin = copula CPast n p g ; inf = (vp.s ! VPStem).inf ++ raha g n } ;
		    VPContFut  => {fin = copula CFuture n p g  ; inf = (vp.s ! VPStem).inf ++ raha g n ++ hw p n  } ;
		    VPPerfPres => {fin = copula CPresent n p g ; inf = (vp.s ! VPStem).inf ++ cka g n } ;
		    VPPerfPast => {fin = copula CPast n p g ; inf = (vp.s ! VPStem).inf ++ cka g n } ;
		    VPPerfFut  => {fin = copula CFuture n p g ; inf = (vp.s ! VPStem).inf ++ cka g n ++ hw p n } ;
		    VPPerfPresCont => {fin = copula CPresent n p g ; inf = (vp.s ! VPStem).inf ++ raha g n } ; 
		    VPPerfPastCont => {fin = copula CPast n p g ; inf = (vp.s ! VPStem).inf ++ raha g n } ; 
		    VPPerfFutCont =>  {fin = copula CFuture n p g ; inf = (vp.s ! VPStem).inf ++ raha g n ++ hw p n } ;
		    VPSubj   => {fin = insertSubj p (vp.s ! VPStem).inf ; inf = "xayd"  }
                    
			  };

	  quest =
            case ord of
              { ODir => [];
                OQuest => "kya" }; 
	  na =
            case b of
              { Pos => [];
                Neg => "na" };
          nahim =
            case b of 
              { Pos => [];
                Neg => "nhyN" };		
        in
		case t of {
		VPSubj => quest ++ subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! agr  ++ na ++  vps.inf ++ vps.fin ++ vp.embComp;
		_      => quest ++ subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! agr  ++ nahim ++  vps.inf ++ vps.fin ++ vp.embComp};
    } ;

 
 np2pronCase ppf npc a = case npc of {
       NPC c => ppf ! c;
       NPObj => ppf ! Obl ;
       NPErg => case (fromAgr a).p of {
           (Pers3_Near|Pers3_Distant) => ppf ! Obl ++ "nE" ;
	   _			     => ppf ! Dir ++ "nE"
	   }
      } ;
}
