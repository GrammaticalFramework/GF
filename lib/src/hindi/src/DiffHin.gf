instance DiffHin of DiffHindustani = open CommonHindustani, ResHindustani,Prelude in {
--instance DiffHin of DiffHindustani = CommonHindustani ** open Prelude in {
flags coding = utf8;
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
		   VPPerfFutCont =>  {fin = [] ; inf = Prelude.glue ((vp.s ! VPTense VPPres agr).inf ++ raha g n  ++ hw p n) (copula CFuture n p g) } ;					
		   VPSubj   => case vp.prog of { True => {fin = (vp.s !  VPTense VPFutr agr).inf ++ hw p n ; inf = "s*a:yd" } ;
		   _    => {fin = (vp.s !  VPTense VPFutr agr).inf ; inf = "s*a:yd" } } 
                   
		  };
					
		    
          quest =
            case ord of
              { ODir => [];
                OQuest => "kya:" }; 
		  na =
            case b of
              { Pos => [];
                Neg => "na" };
           nahim =
            case b of 
              { Pos => [];
                Neg => "nahi:m." };
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
		    VPPerfFutCont =>  {fin = [] ; inf = Prelude.glue ((vp.s ! VPStem).inf ++ raha g n ++ hw p n) (copula CFuture n p g) } ;
		    VPSubj   => {fin = insertSubj p (vp.s ! VPStem).inf ; inf = "s*a:yd"  }
                    
			  };

	  quest =
            case ord of
              { ODir => [];
                OQuest => "kya:" }; 
	  na =
            case b of
              { Pos => [];
                Neg => "na" };
          nahim =
            case b of 
              { Pos => [];
                Neg => "nahi:m." };		
        in
		case t of {
		VPSubj => quest ++ subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! agr  ++ na ++  vps.inf ++ vps.fin ++ vp.embComp;
		_      => quest ++ subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! agr  ++ nahim ++  vps.inf ++ vps.fin ++ vp.embComp};
    } ;

 np2pronCase ppf npc a = case npc of {
       NPC c => ppf ! c;
       NPObj => ppf ! Obl ;
       NPErg =>case (fromAgr a).p of {
           (Pers3_Near|Pers3_Distant) => Prelude.glue (ppf ! Obl) "ne:" ; -- in hindi in case of pronouns nE is tagged to pron rather than a separate word
	   _			     => Prelude.glue (ppf ! Dir) "ne:"
	   }
      } ;
  conjThat = "ki" ;
  insertSubj : UPerson -> Str -> Str = \p,s -> 
      case p of { Pers1 => s ++ "va:n~" ; _ => Prelude.glue s "E:"}; -- check with prasad for vn~
      
  agr = "a-gar" ;
  awr = "O+r" ;
  ky = "ki:" ;
  jn = "jin" ;
  js = "jis" ;
  jw = "jo:" ;
  kw = "ko:" ;
  mt = "mat" ;
  nE = "ne:" ;
  nh = "na" ;
  sE = "se:" ;
  waN = "va:n~" ; -- check with prasad
  hE = "he:" ;
  comma = "," ;
  indfArt = "E:k" ; -- check with prasad
  kwd = "xud" ; -- check with prasad

  oper 
  copula : CTense -> Number -> UPerson -> Gender -> Str = \t,n,p,g ->
    case <t,n,p,g> of {
       <CPresent,Sg,Pers1,_   > => "hu:n~" ;
       <CPresent,Sg,Pers2_Casual,_   > => "he+" ;
       <CPresent,Sg,Pers2_Familiar,_   > => "ho:" ;
      <CPresent,Sg,Pers2_Respect,_   > => "he+m." ;
       <CPresent,Sg,Pers3_Near,_   > => "he+" ;
       <CPresent,Sg,Pers3_Distant,_   > => "he+" ;
	<CPresent,Pl,Pers1,_   > => "he+n~" ;
       <CPresent,Pl,Pers2_Casual,_   > => "ho+" ;
       <CPresent,Pl,Pers2_Familiar,_   > => "ho+" ;
	<CPresent,Pl,Pers2_Respect,_   > => "he+m." ;
       <CPresent,Pl,Pers3_Near,_   > => "he+m." ;
       <CPresent,Pl,Pers3_Distant,_   > => "he+m." ;
      <CPast,Sg,Pers1,Masc   > => "t'a:" ;
      <CPast,Sg,Pers1,Fem   > => "t'i:" ;
       <CPast,Sg,Pers2_Casual,Masc   > => "t'a:" ;
      <CPast,Sg,Pers2_Casual,Fem   > => "t'i:" ;
       <CPast,Sg,Pers2_Familiar,Masc   > => "t'a:" ;
      <CPast,Sg,Pers2_Familiar,Fem   > => "t'i:" ;
      <CPast,Sg,Pers2_Respect,Masc   > => "t'e:" ;
      <CPast,Sg,Pers2_Respect,Fem   > => "t'i:m." ;
       <CPast,Sg,Pers3_Near,Masc   > => "t'a:" ;
      <CPast,Sg,Pers3_Near,Fem   > => "t'i:" ;
       <CPast,Sg,Pers3_Distant,Masc  > => "t'a:" ;
      <CPast,Sg,Pers3_Distant,Fem  > => "t'i:" ;
      <CPast,Pl,Pers1,Masc   > => "t'e:" ;
      <CPast,Pl,Pers1,Fem   > => "t'i:m." ;
       <CPast,Pl,Pers2_Casual,Masc   > => "t'e:" ;
      <CPast,Pl,Pers2_Casual,Fem   > => "t'i:m." ;
       <CPast,Pl,Pers2_Familiar,Masc   > => "t'e:" ;
      <CPast,Pl,Pers2_Familiar,Fem   > => "t'i:m." ;
      <CPast,Pl,Pers2_Respect,Masc   > => "t'e:" ;
      <CPast,Pl,Pers2_Respect,Fem   > => "t'i:m." ;
       <CPast,Pl,Pers3_Near,Masc   > => "t'e:" ;
      <CPast,Pl,Pers3_Near,Fem   > => "t'i:m." ;
      <CPast,Pl,Pers3_Distant,Masc   > => "t'e:" ;
      <CPast,Pl,Pers3_Distant,Fem   > => "t'i:m." ;
      <CFuture,Sg,Pers1,Masc   > => "ga:" ;
      <CFuture,Sg,Pers1,Fem   > => "gi:" ;
       <CFuture,Sg,Pers2_Casual,Masc   > => "ga:" ;
      <CFuture,Sg,Pers2_Casual,Fem   > => "gi:" ;
       <CFuture,Sg,Pers2_Familiar,Masc   > => "ge:" ;
      <CFuture,Sg,Pers2_Familiar,Fem   > => "gi:" ;
      <CFuture,Sg,Pers2_Respect,Masc   > => "ge:" ;
      <CFuture,Sg,Pers2_Respect,Fem   > => "gi:" ;
       <CFuture,Sg,Pers3_Near,Masc   > => "ga:" ;
      <CFuture,Sg,Pers3_Near,Fem   > => "gi:" ;
       <CFuture,Sg,Pers3_Distant,Masc  > => "ga:" ;
      <CFuture,Sg,Pers3_Distant,Fem  > => "gi:" ;
      <CFuture,Pl,Pers1,Masc   > => "ge:" ;
      <CFuture,Pl,Pers1,Fem   > => "gi:" ;
       <CFuture,Pl,Pers2_Casual,Masc   > => "ge:" ;
      <CFuture,Pl,Pers2_Casual,Fem   > => "gi:" ;
       <CFuture,Pl,Pers2_Familiar,Masc   > => "ge:" ;
      <CFuture,Pl,Pers2_Familiar,Fem   > => "gi:" ;
      <CFuture,Pl,Pers2_Respect,Masc   > => "ge:" ;
      <CFuture,Pl,Pers2_Respect,Fem   > => "gi:" ;
       <CFuture,Pl,Pers3_Near,Masc   > => "ge:" ;
      <CFuture,Pl,Pers3_Near,Fem   > => "gi:" ;
      <CFuture,Pl,Pers3_Distant,Masc  > => "ge:" ;
      <CFuture,Pl,Pers3_Distant,Fem  > => "gi:"

       } ;
  

  raha : Gender -> Number -> Str = \g,n -> 
	   (regAdjective "raha:").s ! n ! g ! Dir ! Posit ;

  cka : Gender -> Number -> Str = \g,n -> 
	  (regAdjective "cuka:").s ! n ! g ! Dir ! Posit ;
	  
  hw : UPerson -> Number -> Str = \pp,n ->    
	 case <pp,n> of {
	 <Pers1,_> => "hu:n~";
	 <_,Pl>    => "ho:n~";
	 <_,_>		=> "ho:"
	 };
  hwa : Agr -> Str = \agr ->
        let       n    = (fromAgr agr).n;
		  p    = (fromAgr agr).p;
		  g    = (fromAgr agr).g;
	  in
	 case <n,g> of {
	 <Sg,Masc> => "huA:";
	 <Sg,Fem>    => "huI:";
	 <Pl,Masc>	=> "huE:" ;
	 <Pl,Fem>	=> "huI:"
	 };	 
   -----------------------------------------------
   -- Hindustani Adjectives
   -----------------------------------------------
   	 
 
  regAdjective : Str -> Adjective; 
  regAdjective x =  case x of {
	              acch + ("a:"|"an") => mkAdjective x  ("bahut" ++ x)          ("sab se:" ++ x)          (acch + "e:") ("bahut" ++ acch + "e:") ("sab se:" ++ acch + "E") (acch + "e:") ("bahut" ++ acch + "e:") ("sab se:" ++ acch + "e:")
		                                      (acch + "i:") ("bahut" ++ acch + "i:") ("sab se:" ++ acch + "i:") (acch + "i:") ("bahut" ++ acch + "i:") ("sab se:" ++ acch + "i:") (acch + "i:") ("bahut" ++ acch + "i:") ("sab se:" ++ acch + "i:")
						      (acch +"e:")  ("bahut" ++ acch + "e:") ("sab se:" ++ acch + "e:") (acch + "e:") ("bahut" ++ acch + "e:") ("sab se:" ++ acch + "e:") (acch + "e:") ("bahut" ++ acch + "e:") ("sab se:" ++ acch + "e:")
		                                      (acch + "i:") ("bahut" ++ acch + "i:") ("sab se:" ++ acch + "i:") (acch + "i:") ("bahut" ++ acch + "i:") ("sab se:" ++ acch + "i:") (acch + "i:") ("bahut" ++ acch + "i:") ("sab se:" ++ acch + "i:");
									
                        _                 => mkAdjective  x  ("bahut" ++ x)  	("sab se:" ++ x)  x ("bahut" ++ x) ("sab se:" ++ x) x ("bahut" ++ x) ("sab se:" ++ x)
							  x  ("bahut" ++ x) 	("sab se:" ++ x) 	x ("bahut" ++ x) ("sab se:" ++ x) x ("bahut" ++ x) ("sab se:" ++ x)
							  x  ("bahut" ++ x) 	("sab se:" ++ x)  x ("bahut" ++ x) ("sab se:" ++ x) x ("bahut" ++ x) ("sab se:" ++ x)
							  x  ("bahut" ++ x) 	("sab se:" ++ x)  x ("bahut" ++ x) ("sab se:" ++ x) x ("bahut" ++ x) ("sab se:" ++ x)
																 
                            }; 
IrregAdjective : Str -> Adjective;
IrregAdjective x =   mkAdjective  x  ("bahut" ++ x)  	("sab se:" ++ x)  x ("bahut" ++ x) ("sab se:" ++ x) x ("bahut" ++ x) ("sab se:" ++ x)
							  x  ("bahut" ++ x) 	("sab se:" ++ x) 	x ("bahut" ++ x) ("sab se:" ++ x) x ("bahut" ++ x) ("sab se:" ++ x)
							  x  ("bahut" ++ x) 	("sab se:" ++ x)  x ("bahut" ++ x) ("sab se:" ++ x) x ("bahut" ++ x) ("sab se:" ++ x)
							  x  ("bahut" ++ x) 	("sab se:" ++ x)  x ("bahut" ++ x) ("sab se:" ++ x) x ("bahut" ++ x) ("sab se:" ++ x) ;
																 
                  					 


  
       
}