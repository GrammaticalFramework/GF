instance DiffHin of DiffHindustani = open CommonHindustani, ResHindustani,Prelude in {
--instance DiffHin of DiffHindustani = CommonHindustani ** open Prelude in {
flags coding = utf8;
oper
  
  addErgative s1 s2 = Prelude.glue s1 s2 ;
  conjThat = "ki" ;
  insertSubj : UPerson -> Str -> Str = \p,s -> 
      case p of { Pers1 => s ++ "va:n~" ; _ => Prelude.glue s "E:"}; -- check with prasad for vn~
      
  agr = "agar" ;
  awr = "O+r" ;
  ky = "ki:" ;
  ka = "ka:" ;
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
  indfArt = "" ; -- removed
  kwd = "xud" ; -- check with prasad
  na = "na" ;
  nahen = "nahi:m." ;
  xayad = "s*a:yd" ;
  kya = "kX,ya:" ;
  mein = "me:m." ;
  
  oper 
  copula : CTense -> Number -> UPerson -> Gender -> Str = \t,n,p,g ->
    case <t,n,p,g> of {
       <CPresent,Sg,Pers1,_   > => "hu:n~" ;
       <CPresent,Sg,Pers2_Casual,_   > => "he+" ;
       <CPresent,Sg,Pers2_Familiar,_   > => "ho:" ;
      <CPresent,Sg,Pers2_Respect,_   > => "he+m." ;
       <CPresent,Sg,Pers3_Near,_   > => "he+" ;
       <CPresent,Sg,Pers3_Distant,_   > => "he+" ;
	<CPresent,Pl,Pers1,_   > => "he+m." ;
       <CPresent,Pl,Pers2_Casual,_   > => "ho:" ;
       <CPresent,Pl,Pers2_Familiar,_   > => "ho:" ;
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
           case <g,n> of {
	     <Masc,Sg> => "raha:";
	     <Masc,Pl> => "rahe:";
	     <Fem,_> => "rahi:"
	     
	     };

  cka : Gender -> Number -> Str = \g,n ->
            case <g,n> of {
	     <Masc,Sg> => "cuka:";
	     <Masc,Pl> => "cuke:";
	     <Fem,_> => "cuki:"
	     
	     };
	  
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
}