instance DiffUrd of DiffHindustani = open CommonHindustani, Prelude in {

flags coding = utf8 ;

oper

addErgative s1 s2 = s1 ++ s2 ;
conjThat = "kh" ;
  insertSubj : UPerson -> Str -> Str = \p,s -> 
      case p of { Pers1 => s ++ "waN" ; _ => s ++ "E"}; -- check with prasad for vn~
      
  agr = "agr" ;
  awr = "awr" ;
  ky = "ky" ;
  ka = "ka" ;
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
  mein = "myN" ; 
  
  na = "na" ;
  nahen = "nhyN" ;
  xayad = "Xayd" ;
  kya = "kya" ;
  

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
           case <g,n> of {
	     <Masc,Sg> => "rha";
	     <Masc,Pl> => "rhE";
	     <Fem,_> => "rhy"
	     
	     };

  cka : Gender -> Number -> Str = \g,n ->
            case <g,n> of {
	     <Masc,Sg> => "cka";
	     <Masc,Pl> => "ckE";
	     <Fem,_> => "cky"
	     
	     };
	  
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
	 
}
