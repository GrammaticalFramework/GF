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
		   VPSubj   => case vp.prog of { True => {fin = (vp.s !  VPTense VPFutr agr).inf ++ hw p n ; inf = "شاید" } ;
		   _    => {fin = (vp.s !  VPTense VPFutr agr).inf ; inf = "شاید" } } 
                   
		  };
					
		    
          quest =
            case ord of
              { ODir => [];
                OQuest => "كیا" }; 
		  na =
            case b of
              { Pos => [];
                Neg => "نا" };
           nahim =
            case b of 
              { Pos => [];
                Neg => "نہیں" };
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
		    VPSubj   => {fin = insertSubj p (vp.s ! VPStem).inf ; inf = "شاید"  }
                    
			  };

	  quest =
            case ord of
              { ODir => [];
                OQuest => "كیا" }; 
	  na =
            case b of
              { Pos => [];
                Neg => "نا" };
          nahim =
            case b of 
              { Pos => [];
                Neg => "نہیں" };		
        in
		case t of {
		VPSubj => quest ++ subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! agr  ++ na ++  vps.inf ++ vps.fin ++ vp.embComp;
		_      => quest ++ subj ++ vp.obj.s ++ vp.ad ++ vp.comp ! agr  ++ nahim ++  vps.inf ++ vps.fin ++ vp.embComp};
    } ;

 
 np2pronCase ppf npc a = case npc of {
       NPC c => ppf ! c;
       NPObj => ppf ! Obl ;
       NPErg => case (fromAgr a).p of {
           (Pers3_Near|Pers3_Distant) => ppf ! Obl ++ "نے" ;
	   _			     => ppf ! Dir ++ "نے"
	   }
      } ;
      
      
conjThat = "كہ" ;
  insertSubj : UPerson -> Str -> Str = \p,s -> 
      case p of { Pers1 => s ++ "واں" ; _ => s ++ "ے"}; -- check with prasad for vn~
      
  agr = "اگر" ;
  awr = "اور" ;
  ky = "كی" ;
  jn = "جن" ;
  js = "جس" ;
  jw = "جو" ;
  kw = "كو" ;
  mt = "مت" ;
  nE = "نے" ;
  nh = "نا" ;
  sE = "سے" ;
  waN = "واں" ; 
  hE = "ہے" ;
  comma = "," ;
  indfArt = "اك" ; 
  kwd = "خود" ; 

copula : CTense -> Number -> UPerson -> Gender -> Str = \t,n,p,g -> 
     case <t,n,p,g> of {
        <CPresent,Sg,Pers1,_   > => "ہوں" ;
        <CPresent,Sg,Pers2_Casual,_   > => "ہے"; 
        <CPresent,Sg,Pers2_Familiar,_   > => "ہو" ;
		<CPresent,Sg,Pers2_Respect,_   > => "ہیں" ;
        <CPresent,Sg,Pers3_Near,_   > => "ہے" ;
        <CPresent,Sg,Pers3_Distant,_   > => "ہے" ;
		<CPresent,Pl,Pers1,_   > => "ہیں" ;
        <CPresent,Pl,Pers2_Casual,_   > => "ہو" ;
        <CPresent,Pl,Pers2_Familiar,_   > => "ہو" ;
		<CPresent,Pl,Pers2_Respect,_   > => "ہیں" ;
        <CPresent,Pl,Pers3_Near,_   > => "ہیں" ;
        <CPresent,Pl,Pers3_Distant,_   > => "ہیں" ;
		<CPast,Sg,Pers1,Masc   > => "تھا" ;
		<CPast,Sg,Pers1,Fem   > => "تھی" ;
        <CPast,Sg,Pers2_Casual,Masc   > => "تھا" ;
		<CPast,Sg,Pers2_Casual,Fem   > => "تھی" ;
        <CPast,Sg,Pers2_Familiar,Masc   > => "تh-ا" ;
		<CPast,Sg,Pers2_Familiar,Fem   > => "تھی" ;
		<CPast,Sg,Pers2_Respect,Masc   > => "تھے" ;
		<CPast,Sg,Pers2_Respect,Fem   > => "تھیں" ;
        <CPast,Sg,Pers3_Near,Masc   > => "تh-ا" ;
		<CPast,Sg,Pers3_Near,Fem   > => "تھی" ;
        <CPast,Sg,Pers3_Distant,Masc  > => "تh-ا" ;
		<CPast,Sg,Pers3_Distant,Fem  > => "تھی" ;
		<CPast,Pl,Pers1,Masc   > => "تھے" ;
		<CPast,Pl,Pers1,Fem   > => "تھیں" ;
        <CPast,Pl,Pers2_Casual,Masc   > => "تھے" ;
		<CPast,Pl,Pers2_Casual,Fem   > => "تھیں" ;
        <CPast,Pl,Pers2_Familiar,Masc   > => "تھے" ;
		<CPast,Pl,Pers2_Familiar,Fem   > => "تھیں" ;
		<CPast,Pl,Pers2_Respect,Masc   > => "تھے" ;
		<CPast,Pl,Pers2_Respect,Fem   > => "تھیں" ;
        <CPast,Pl,Pers3_Near,Masc   > => "تھے" ;
		<CPast,Pl,Pers3_Near,Fem   > => "تھیں" ;
		<CPast,Pl,Pers3_Distant,Masc   > => "تھے" ;
		<CPast,Pl,Pers3_Distant,Fem   > => "تھیں" ;
		<CFuture,Sg,Pers1,Masc   > => "گا" ;
		<CFuture,Sg,Pers1,Fem   > => "گی" ;
        <CFuture,Sg,Pers2_Casual,Masc   > => "گا" ;
		<CFuture,Sg,Pers2_Casual,Fem   > => "گی" ;
        <CFuture,Sg,Pers2_Familiar,Masc   > => "گے" ;
		<CFuture,Sg,Pers2_Familiar,Fem   > => "گی" ;
		<CFuture,Sg,Pers2_Respect,Masc   > => "گے" ;
		<CFuture,Sg,Pers2_Respect,Fem   > => "گی" ;
        <CFuture,Sg,Pers3_Near,Masc   > => "گا" ;
		<CFuture,Sg,Pers3_Near,Fem   > => "گی" ;
        <CFuture,Sg,Pers3_Distant,Masc  > => "گا" ;
		<CFuture,Sg,Pers3_Distant,Fem  > => "گی" ;
		<CFuture,Pl,Pers1,Masc   > => "گے" ;
		<CFuture,Pl,Pers1,Fem   > => "گی" ;
        <CFuture,Pl,Pers2_Casual,Masc   > => "گے" ;
		<CFuture,Pl,Pers2_Casual,Fem   > => "گی" ;
        <CFuture,Pl,Pers2_Familiar,Masc   > => "گے" ;
		<CFuture,Pl,Pers2_Familiar,Fem   > => "گی" ;
		<CFuture,Pl,Pers2_Respect,Masc   > => "گے" ;
		<CFuture,Pl,Pers2_Respect,Fem   > => "گی" ;
        <CFuture,Pl,Pers3_Near,Masc   > => "گے" ;
		<CFuture,Pl,Pers3_Near,Fem   > => "گے" ;
		<CFuture,Pl,Pers3_Distant,Masc  > => "گے" ;
		<CFuture,Pl,Pers3_Distant,Fem  > => "گی" 
        
        } ;
	
   raha : Gender -> Number -> Str = \g,n -> 
	   (regAdjective "رہا").s ! n ! g ! Dir ! Posit ;

  cka : Gender -> Number -> Str = \g,n -> 
	  (regAdjective "چكا").s ! n ! g ! Dir ! Posit ;
	  
  hw : UPerson -> Number -> Str = \pp,n ->    
	 case <pp,n> of {
	 <Pers1,_> => "ہوں";
	 <_,Pl>    => "ہوں";
	 <_,_>		=> "ہو"
	 };
	 
  hwa : Agr -> Str = \agr ->
        let       n    = (fromAgr agr).n;
		  p    = (fromAgr agr).p;
		  g    = (fromAgr agr).g;
	  in
	 case <n,g> of {
	 <Sg,Masc> => "ہوا";
	 <Sg,Fem>    => "ہوی";
	 <Pl,Masc>	=> "ہوے" ;
	 <Pl,Fem>	=> "ہوی"
	 };		 
	 
   -----------------------------------------------
   -- Hindustani Adjectives
   -----------------------------------------------
   	 
  Adjective = { s: Number => Gender => Case => Degree => Str };
 
  regAdjective : Str -> Adjective; 
  regAdjective x =  case x of {
	              acch + ("ا"|"اں") => mkAdjective x  ("بہت" ++ x)          ("سب سے" ++ x)          (acch + "ے") ("بہت" ++ acch + "ے") ("سب سے" ++ acch + "ے") (acch + "ے") ("بہت" ++ acch + "ے") ("سب سے" ++ acch + "ے")
		                                      (acch + "ی") ("بہت" ++ acch + "ی") ("سب سے" ++ acch + "ی") (acch + "ی") ("بہت" ++ acch + "ی") ("سب سے" ++ acch + "ی") (acch + "ی") ("بہت" ++ acch + "ی") ("سب سے" ++ acch + "ی")
						      (acch +"ے")  ("بہت" ++ acch + "ے") ("سب سے" ++ acch + "ے") (acch + "ے") ("بہت" ++ acch + "ے") ("سب سے" ++ acch + "ے") (acch + "ے") ("بہت" ++ acch + "ے") ("سب سے" ++ acch + "ے")
		                                      (acch + "ی") ("بہت" ++ acch + "ی") ("سب سے" ++ acch + "ی") (acch + "ی") ("بہت" ++ acch + "ی") ("سب سے" ++ acch + "ی") (acch + "ی") ("بہت" ++ acch + "ی") ("سب سے" ++ acch + "ی");
									
                        _                 => mkAdjective  x  ("بہت" ++ x)  	("سب سے" ++ x)  x ("بہت" ++ x) ("سب سے" ++ x) x ("بہت" ++ x) ("سب سے" ++ x)
							  x  ("بہت" ++ x) 	("سب سے" ++ x) 	x ("بہت" ++ x) ("سب سے" ++ x) x ("بہت" ++ x) ("سب سے" ++ x)
							  x  ("بہت" ++ x) 	("سب سے" ++ x)  x ("بہت" ++ x) ("سب سے" ++ x) x ("بہت" ++ x) ("سب سے" ++ x)
							  x  ("بہت" ++ x) 	("سب سے" ++ x)  x ("بہت" ++ x) ("سب سے" ++ x) x ("بہت" ++ x) ("سب سے" ++ x)
																 
                            }; 
	      
}
