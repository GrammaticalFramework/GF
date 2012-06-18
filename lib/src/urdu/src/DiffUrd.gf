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
		VPSubj => quest ++ np.s ! subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! np.a  ++ vp.cvp ++ na ++  vps.inf ++ vps.fin ++ vp.embComp ;
		_      => quest ++ np.s ! subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! np.a ++ vp.cvp ++ nahim  ++  vps.inf ++ vps.fin ++ vp.embComp};

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
		    VPSubj   => {fin = insertSubj p (vp.s ! VPStem).inf ; inf = "Xayd"  }
                    
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
		VPSubj => quest ++ subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! agr  ++ vp.cvp ++ na ++  vps.inf ++ vps.fin ++ vp.embComp;
		_      => quest ++ subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! agr  ++ vp.cvp ++ nahim ++  vps.inf ++ vps.fin ++ vp.embComp};
    } ;

 
 np2pronCase ppf npc a = case npc of {
       NPC c => ppf ! c;
       NPObj => ppf ! Obl ;
       NPErg => case (fromAgr a).p of {
           (Pers3_Near|Pers3_Distant) => ppf ! Obl ++ "nE" ;
	   _			     => ppf ! Dir ++ "nE"
	   }
      } ;
      
      
conjThat = "kh" ;
  insertSubj : UPerson -> Str -> Str = \p,s -> 
      case p of { Pers1 => s ++ "waN" ; _ => s ++ "E"}; -- check with prasad for vn~
      
  agr = "agr" ;
  awr = "awr" ;
  ky = "ky" ;
  jn = "jn" ;
  js = "js" ;
  jw = "jw" ;
  kw = "kw" ;
  mt = "mt" ;
  nE = "nE" ;
  nh = "na" ;
  sE = "sE" ;
  waN = "waN" ; 
  hE = "hE" ;
  comma = "," ;
  indfArt = "" ; 
  kwd = "Kwd" ; 

copula : CTense -> Number -> UPerson -> Gender -> Str = \t,n,p,g -> 
     case <t,n,p,g> of {
        <CPresent,Sg,Pers1,_   > => "hwN" ;
        <CPresent,Sg,Pers2_Casual,_   > => "hE"; 
        <CPresent,Sg,Pers2_Familiar,_   > => "hw" ;
		<CPresent,Sg,Pers2_Respect,_   > => "hyN" ;
        <CPresent,Sg,Pers3_Near,_   > => "hE" ;
        <CPresent,Sg,Pers3_Distant,_   > => "hE" ;
		<CPresent,Pl,Pers1,_   > => "hyN" ;
        <CPresent,Pl,Pers2_Casual,_   > => "hw" ;
        <CPresent,Pl,Pers2_Familiar,_   > => "hw" ;
		<CPresent,Pl,Pers2_Respect,_   > => "hyN" ;
        <CPresent,Pl,Pers3_Near,_   > => "hyN" ;
        <CPresent,Pl,Pers3_Distant,_   > => "hyN" ;
		<CPast,Sg,Pers1,Masc   > => "th'a" ;
		<CPast,Sg,Pers1,Fem   > => "th'y" ;
        <CPast,Sg,Pers2_Casual,Masc   > => "th'a" ;
		<CPast,Sg,Pers2_Casual,Fem   > => "th'y" ;
        <CPast,Sg,Pers2_Familiar,Masc   > => "th'a" ;
		<CPast,Sg,Pers2_Familiar,Fem   > => "th'y" ;
		<CPast,Sg,Pers2_Respect,Masc   > => "th'E" ;
		<CPast,Sg,Pers2_Respect,Fem   > => "th'yN" ;
        <CPast,Sg,Pers3_Near,Masc   > => "th'a" ;
		<CPast,Sg,Pers3_Near,Fem   > => "th'y" ;
        <CPast,Sg,Pers3_Distant,Masc  > => "th'a" ;
		<CPast,Sg,Pers3_Distant,Fem  > => "th'y" ;
		<CPast,Pl,Pers1,Masc   > => "th'E" ;
		<CPast,Pl,Pers1,Fem   > => "th'yN" ;
        <CPast,Pl,Pers2_Casual,Masc   > => "th'E" ;
		<CPast,Pl,Pers2_Casual,Fem   > => "th'yN" ;
        <CPast,Pl,Pers2_Familiar,Masc   > => "th'E" ;
		<CPast,Pl,Pers2_Familiar,Fem   > => "th'yN" ;
		<CPast,Pl,Pers2_Respect,Masc   > => "th'E" ;
		<CPast,Pl,Pers2_Respect,Fem   > => "th'yN" ;
        <CPast,Pl,Pers3_Near,Masc   > => "th'E" ;
		<CPast,Pl,Pers3_Near,Fem   > => "th'yN" ;
		<CPast,Pl,Pers3_Distant,Masc   > => "th'E" ;
		<CPast,Pl,Pers3_Distant,Fem   > => "th'yN" ;
		<CFuture,Sg,Pers1,Masc   > => "ga" ;
		<CFuture,Sg,Pers1,Fem   > => "gy" ;
        <CFuture,Sg,Pers2_Casual,Masc   > => "ga" ;
		<CFuture,Sg,Pers2_Casual,Fem   > => "gy" ;
        <CFuture,Sg,Pers2_Familiar,Masc   > => "gE" ;
		<CFuture,Sg,Pers2_Familiar,Fem   > => "gy" ;
		<CFuture,Sg,Pers2_Respect,Masc   > => "gE" ;
		<CFuture,Sg,Pers2_Respect,Fem   > => "gy" ;
        <CFuture,Sg,Pers3_Near,Masc   > => "ga" ;
		<CFuture,Sg,Pers3_Near,Fem   > => "gy" ;
        <CFuture,Sg,Pers3_Distant,Masc  > => "ga" ;
		<CFuture,Sg,Pers3_Distant,Fem  > => "gy" ;
		<CFuture,Pl,Pers1,Masc   > => "gE" ;
		<CFuture,Pl,Pers1,Fem   > => "gy" ;
        <CFuture,Pl,Pers2_Casual,Masc   > => "gE" ;
		<CFuture,Pl,Pers2_Casual,Fem   > => "gy" ;
        <CFuture,Pl,Pers2_Familiar,Masc   > => "gE" ;
		<CFuture,Pl,Pers2_Familiar,Fem   > => "gy" ;
		<CFuture,Pl,Pers2_Respect,Masc   > => "gE" ;
		<CFuture,Pl,Pers2_Respect,Fem   > => "gy" ;
        <CFuture,Pl,Pers3_Near,Masc   > => "gE" ;
		<CFuture,Pl,Pers3_Near,Fem   > => "gE" ;
		<CFuture,Pl,Pers3_Distant,Masc  > => "gE" ;
		<CFuture,Pl,Pers3_Distant,Fem  > => "gy" 
        
        } ;
	
   raha : Gender -> Number -> Str = \g,n -> 
	   (regAdjective "rha").s ! n ! g ! Dir ! Posit ;

  cka : Gender -> Number -> Str = \g,n -> 
	  (regAdjective "cka").s ! n ! g ! Dir ! Posit ;
	  
  hw : UPerson -> Number -> Str = \pp,n ->    
	 case <pp,n> of {
	 <Pers1,_> => "hwN";
	 <_,Pl>    => "hwN";
	 <_,_>		=> "hw"
	 };
	 
  hwa : Agr -> Str = \agr ->
        let       n    = (fromAgr agr).n;
		  p    = (fromAgr agr).p;
		  g    = (fromAgr agr).g;
	  in
	 case <n,g> of {
	 <Sg,Masc> => "hwa";
	 <Sg,Fem>    => "hwy";
	 <Pl,Masc>	=> "hwE" ;
	 <Pl,Fem>	=> "hwy"
	 };		 
	 
   -----------------------------------------------
   -- Hindustani Adjectives
   -----------------------------------------------
   	 
  Adjective = { s: Number => Gender => Case => Degree => Str };
 
  regAdjective : Str -> Adjective; 
  regAdjective x =  case x of {
	              acch + ("a"|"aN") => mkAdjective x  ("bht" ++ x)          ("sb sE" ++ x)          (acch + "E") ("bht" ++ acch + "E") ("sb sE" ++ acch + "E") (acch + "E") ("bht" ++ acch + "E") ("sb sE" ++ acch + "E")
		                                      (acch + "y") ("bht" ++ acch + "y") ("sb sE" ++ acch + "y") (acch + "y") ("bht" ++ acch + "y") ("sb sE" ++ acch + "y") (acch + "y") ("bht" ++ acch + "y") ("sb sE" ++ acch + "y")
						      (acch +"E")  ("bht" ++ acch + "E") ("sb sE" ++ acch + "E") (acch + "E") ("bht" ++ acch + "E") ("sb sE" ++ acch + "E") (acch + "E") ("bht" ++ acch + "E") ("sb sE" ++ acch + "E")
		                                      (acch + "y") ("bht" ++ acch + "y") ("sb sE" ++ acch + "y") (acch + "y") ("bht" ++ acch + "y") ("sb sE" ++ acch + "y") (acch + "y") ("bht" ++ acch + "y") ("sb sE" ++ acch + "y");
									
                        _                 => mkAdjective  x  ("bht" ++ x)  	("sb sE" ++ x)  x ("bht" ++ x) ("sb sE" ++ x) x ("bht" ++ x) ("sb sE" ++ x)
							  x  ("bht" ++ x) 	("sb sE" ++ x) 	x ("bht" ++ x) ("sb sE" ++ x) x ("bht" ++ x) ("sb sE" ++ x)
							  x  ("bht" ++ x) 	("sb sE" ++ x)  x ("bht" ++ x) ("sb sE" ++ x) x ("bht" ++ x) ("sb sE" ++ x)
							  x  ("bht" ++ x) 	("sb sE" ++ x)  x ("bht" ++ x) ("sb sE" ++ x) x ("bht" ++ x) ("sb sE" ++ x)
																 
                            }; 
	      
}
