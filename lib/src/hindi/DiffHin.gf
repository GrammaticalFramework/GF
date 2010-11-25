instance DiffHin of DiffHindustani = open CommonHindustani, Prelude in {
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
		   VPFut      => case vp.prog of { True => {fin = [] ;inf = Prelude.glue ((vp.s !  VPTense VPFutr agr).inf ++ hw p n) ((vp.s !  VPTense VPFutr agr).fin) } ;
                                                   _    => {fin = [] ; inf = Prelude.glue (vp.s !  VPTense VPFutr agr).inf (vp.s !  VPTense VPFutr agr).fin  }} ;
                   VPContPres => {fin = copula CPresent n p g ; inf = (vp.s ! VPStem).inf ++ raha g n } ;
		   VPContPast => {fin = copula CPast n p g ; inf = (vp.s ! VPStem).inf ++ raha g n } ;
		   VPContFut  => {fin = [] ; inf = Prelude.glue ((vp.s ! VPStem).inf ++ raha g n ++ hw p n) (copula CFuture n p g) } ;
		   VPPerfPres => {fin = copula CPresent n p g ; inf = (vp.s ! VPTense VPPerf agr).inf } ;  
		   VPPerfPast => {fin = copula CPast n p g ; inf = (vp.s ! VPTense VPPerf agr).inf } ;  
		   VPPerfFut  => {fin = [] ; inf = Prelude.glue ((vp.s ! VPTense VPPerf agr).inf  ++ hw p n) (copula CFuture n p g) } ;
		   VPPerfPresCont => {fin = copula CPresent n p g ; inf = (vp.s ! VPTense VPPres agr).inf ++ raha g n } ;					
	           VPPerfPastCont => {fin = copula CPast n p g ; inf = (vp.s ! VPTense VPPres agr).inf ++ raha g n } ;					
		   VPPerfFutCont =>  {fin = [] ; inf = Prelude.glue ((vp.s ! VPTense VPPres agr).inf ++ raha g n  ++ hw p n) (copula CFuture n p g )} ;					
		   VPSubj   => case vp.prog of { True => {fin = (vp.s !  VPTense VPFutr agr).inf ++ hw p n ; inf = "Xयद" } ;
		   _    => {fin = (vp.s !  VPTense VPFutr agr).inf ; inf = "Xयद" } } 
                   
		  };
					
		    
          quest =
            case ord of
              { ODir => [];
                OQuest => "कय" }; 
		  na =
            case b of
              { Pos => [];
                Neg => "न" };
           nahim =
            case b of 
              { Pos => [];
                Neg => "नहयं" };
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
		    VPFut      => {fin = [] ; inf = Prelude.glue (vp.s !  VPTense VPFutr agr).inf ((vp.s !  VPTense VPFutr agr).fin) }  ;
		    VPContPres => {fin = copula CPresent n p g ; inf = (vp.s ! VPStem).inf ++ raha g n  } ;
		    VPContPast => {fin = copula CPast n p g ; inf = (vp.s ! VPStem).inf ++ raha g n } ;
		    VPContFut  => {fin = [] ; inf = Prelude.glue ((vp.s ! VPStem).inf ++ raha g n ++ hw p n) (copula CFuture n p g) } ;
		    VPPerfPres => {fin = copula CPresent n p g ; inf = (vp.s ! VPStem).inf ++ cka g n } ;
		    VPPerfPast => {fin = copula CPast n p g ; inf = (vp.s ! VPStem).inf ++ cka g n } ;
		    VPPerfFut  => {fin = [] ; inf = Prelude.glue ((vp.s ! VPStem).inf ++ cka g n ++ hw p n) (copula CFuture n p g) } ;
		    VPPerfPresCont => {fin = copula CPresent n p g ; inf = (vp.s ! VPStem).inf ++ raha g n } ; 
		    VPPerfPastCont => {fin = copula CPast n p g ; inf = (vp.s ! VPStem).inf ++ raha g n } ; 
		    VPPerfFutCont =>  {fin = [] ; inf = Prelude.glue ((vp.s ! VPStem).inf ++ raha g n ++ hw p n) (copula CFuture n p g ) } ;
		    VPSubj   => {fin = insertSubj p (vp.s ! VPStem).inf ; inf = "xयद"  }
                    
			  };

	  quest =
            case ord of
              { ODir => [];
                OQuest => "कय" }; 
	  na =
            case b of
              { Pos => [];
                Neg => "न" };
          nahim =
            case b of 
              { Pos => [];
                Neg => "नहयं" };		
        in
		case t of {
		VPSubj => quest ++ subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! agr  ++ na ++  vps.inf ++ vps.fin ++ vp.embComp;
		_      => quest ++ subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! agr  ++ nahim ++  vps.inf ++ vps.fin ++ vp.embComp};
    } ;

{- Verb : Type = {s : VerbForm => Str} ;

 
 predV v = {
         s = \\vh => 
	   case vh of {
	     VPTense VPPres (Ag g n p) => {fin = copula CPresent n p g ; inf = v.s ! VF Imperf p n g } ;
		 VPTense VPPast (Ag g n p) => {fin = [] ; inf =v.s ! VF Perf p n g} ;
                 VPTense VPFutr (Ag g n p) =>  {fin = [] ; inf = Prelude.glue (v.s ! VF Subj p n g) (copula CFuture n p g)} ;
		 VPTense VPPerf (Ag g n p) => { fin = [] ; inf = v.s ! Root ++ cka g n } ; 
		 VPStem => {fin = []  ; inf =  v.s ! Root};
		 _ => {fin = [] ; inf = v.s ! Root} 
		 };
	    obj = {s = [] ; a = defaultAgr} ;
		subj = VIntrans ;
		inf = v.s ! Inf;
		ad = [];
        embComp = [];
	prog = False ;
        comp = \\_ => []
      } ;
-}      
 np2pronCase ppf npc a = case npc of {
       NPC c => ppf ! c;
       NPObj => ppf ! Obl ;
       NPErg =>case (fromAgr a).p of {
           (Pers3_Near|Pers3_Distant) => Prelude.glue (ppf ! Obl) "नै" ; -- in hindi in case of pronouns nE is tagged to pron rather than a separate word
	   _			     => Prelude.glue (ppf ! Dir) "नै"
	   }
      } ;
  
}