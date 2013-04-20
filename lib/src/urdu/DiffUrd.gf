instance DiffUrd of DiffHindustani = open CommonHindustani, Prelude in {

flags coding = utf8 ;

oper

addErgative s1 s2 = s1 ++ s2 ;
conjThat = "کہ" ;
  insertSubj : UPerson -> Str -> Str = \p,s -> 
      case p of { Pers1 => s ++ "واں" ; _ => s ++ "ے"}; -- check with prasad for vn~
      
  agr = "اگر" ;
  awr = "اور" ;
  ky = "کی" ;
  ka = "کا" ;
  jn = "جن" ;
  js = "جس" ;
  jw = "جو" ;
  kw = "کو" ;
  mt = "مت" ;
  nE = "نے" ;
  nh = "نا" ;
  sE = "سے" ;
  waN = "واں" ; 
  hE = "ہے" ;
  comma = "," ;
  indfArt = "" ; 
  kwd = "خود" ;
  mein = "میں" ; 
  
  na = "نا" ;
  nahen = "نہیں" ;
  xayad = "شاید" ;
  kya = "کیا" ;
  

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
        <CPast,Sg,Pers2_Familiar,Masc   > => "تھا" ;
		<CPast,Sg,Pers2_Familiar,Fem   > => "تھی" ;
		<CPast,Sg,Pers2_Respect,Masc   > => "تھے" ;
		<CPast,Sg,Pers2_Respect,Fem   > => "تھیں" ;
        <CPast,Sg,Pers3_Near,Masc   > => "تھا" ;
		<CPast,Sg,Pers3_Near,Fem   > => "تھی" ;
        <CPast,Sg,Pers3_Distant,Masc  > => "تھا" ;
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
           case <g,n> of {
	     <Masc,Sg> => "رہا";
	     <Masc,Pl> => "رہے";
	     <Fem,_> => "رہی"
	     
	     };

  cka : Gender -> Number -> Str = \g,n ->
            case <g,n> of {
	     <Masc,Sg> => "چکا";
	     <Masc,Pl> => "چکے";
	     <Fem,_> => "چکی"
	     
	     };
	  
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
	 
}
