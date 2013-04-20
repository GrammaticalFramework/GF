instance DiffHin of DiffHindustani = open CommonHindustani, ResHindustani,Prelude in {
--instance DiffHin of DiffHindustani = CommonHindustani ** open Prelude in {
flags coding = utf8;
oper
  
  addErgative s1 s2 = Prelude.glue s1 s2 ;
  conjThat = "कि" ;
  insertSubj : UPerson -> Str -> Str = \p,s -> 
      case p of { Pers1 => s ++ "वाँ" ; _ => Prelude.glue s "ए"}; -- check with prasad for vn~
      
  agr = "गर" ;
  awr = "और" ;
  ky = "की" ;
  ka = "का" ;
  jn = "जिन" ;
  js = "जिस" ;
  jw = "जो" ;
  kw = "को" ;
  mt = "मत" ;
  nE = "ने" ;
  nh = "न" ;
  sE = "से" ;
  waN = "वाँ" ; -- check with prasad
  hE = "हे" ;
  comma = "," ;
  indfArt = "" ; -- removed
  kwd = "ख़ुद" ; -- check with prasad
  na = "न" ;
  nahen = "नहीं" ;
  xayad = "शायद" ;
  kya = "क्या" ;
  mein = "में" ;
  
  oper 
  copula : CTense -> Number -> UPerson -> Gender -> Str = \t,n,p,g ->
    case <t,n,p,g> of {
       <CPresent,Sg,Pers1,_   > => "हूँ" ;
       <CPresent,Sg,Pers2_Casual,_   > => "है" ;
       <CPresent,Sg,Pers2_Familiar,_   > => "हो" ;
      <CPresent,Sg,Pers2_Respect,_   > => "हैं" ;
       <CPresent,Sg,Pers3_Near,_   > => "है" ;
       <CPresent,Sg,Pers3_Distant,_   > => "है" ;
	<CPresent,Pl,Pers1,_   > => "हैं" ;
       <CPresent,Pl,Pers2_Casual,_   > => "हो" ;
       <CPresent,Pl,Pers2_Familiar,_   > => "हो" ;
	<CPresent,Pl,Pers2_Respect,_   > => "हैं" ;
       <CPresent,Pl,Pers3_Near,_   > => "हैं" ;
       <CPresent,Pl,Pers3_Distant,_   > => "हैं" ;
      <CPast,Sg,Pers1,Masc   > => "था" ;
      <CPast,Sg,Pers1,Fem   > => "थी" ;
       <CPast,Sg,Pers2_Casual,Masc   > => "था" ;
      <CPast,Sg,Pers2_Casual,Fem   > => "थी" ;
       <CPast,Sg,Pers2_Familiar,Masc   > => "था" ;
      <CPast,Sg,Pers2_Familiar,Fem   > => "थी" ;
      <CPast,Sg,Pers2_Respect,Masc   > => "थे" ;
      <CPast,Sg,Pers2_Respect,Fem   > => "थीं" ;
       <CPast,Sg,Pers3_Near,Masc   > => "था" ;
      <CPast,Sg,Pers3_Near,Fem   > => "थी" ;
       <CPast,Sg,Pers3_Distant,Masc  > => "था" ;
      <CPast,Sg,Pers3_Distant,Fem  > => "थी" ;
      <CPast,Pl,Pers1,Masc   > => "थे" ;
      <CPast,Pl,Pers1,Fem   > => "थीं" ;
       <CPast,Pl,Pers2_Casual,Masc   > => "थे" ;
      <CPast,Pl,Pers2_Casual,Fem   > => "थीं" ;
       <CPast,Pl,Pers2_Familiar,Masc   > => "थे" ;
      <CPast,Pl,Pers2_Familiar,Fem   > => "थीं" ;
      <CPast,Pl,Pers2_Respect,Masc   > => "थे" ;
      <CPast,Pl,Pers2_Respect,Fem   > => "थीं" ;
       <CPast,Pl,Pers3_Near,Masc   > => "थे" ;
      <CPast,Pl,Pers3_Near,Fem   > => "थीं" ;
      <CPast,Pl,Pers3_Distant,Masc   > => "थे" ;
      <CPast,Pl,Pers3_Distant,Fem   > => "थीं" ;
      <CFuture,Sg,Pers1,Masc   > => "गा" ;
      <CFuture,Sg,Pers1,Fem   > => "गी" ;
       <CFuture,Sg,Pers2_Casual,Masc   > => "गा" ;
      <CFuture,Sg,Pers2_Casual,Fem   > => "गी" ;
       <CFuture,Sg,Pers2_Familiar,Masc   > => "गे" ;
      <CFuture,Sg,Pers2_Familiar,Fem   > => "गी" ;
      <CFuture,Sg,Pers2_Respect,Masc   > => "गे" ;
      <CFuture,Sg,Pers2_Respect,Fem   > => "गी" ;
       <CFuture,Sg,Pers3_Near,Masc   > => "गा" ;
      <CFuture,Sg,Pers3_Near,Fem   > => "गी" ;
       <CFuture,Sg,Pers3_Distant,Masc  > => "गा" ;
      <CFuture,Sg,Pers3_Distant,Fem  > => "गी" ;
      <CFuture,Pl,Pers1,Masc   > => "गे" ;
      <CFuture,Pl,Pers1,Fem   > => "गी" ;
       <CFuture,Pl,Pers2_Casual,Masc   > => "गे" ;
      <CFuture,Pl,Pers2_Casual,Fem   > => "गी" ;
       <CFuture,Pl,Pers2_Familiar,Masc   > => "गे" ;
      <CFuture,Pl,Pers2_Familiar,Fem   > => "गी" ;
      <CFuture,Pl,Pers2_Respect,Masc   > => "गे" ;
      <CFuture,Pl,Pers2_Respect,Fem   > => "गी" ;
       <CFuture,Pl,Pers3_Near,Masc   > => "गे" ;
      <CFuture,Pl,Pers3_Near,Fem   > => "गी" ;
      <CFuture,Pl,Pers3_Distant,Masc  > => "गे" ;
      <CFuture,Pl,Pers3_Distant,Fem  > => "गी"

       } ;
  

  raha : Gender -> Number -> Str = \g,n ->
           case <g,n> of {
	     <Masc,Sg> => "रहा";
	     <Masc,Pl> => "रहे";
	     <Fem,_> => "रही"
	     
	     };

  cka : Gender -> Number -> Str = \g,n ->
            case <g,n> of {
	     <Masc,Sg> => "चुका";
	     <Masc,Pl> => "चुके";
	     <Fem,_> => "चुकी"
	     
	     };
	  
  hw : UPerson -> Number -> Str = \pp,n ->    
	 case <pp,n> of {
	 <Pers1,_> => "हूँ";
	 <_,Pl>    => "होँ";
	 <_,_>		=> "हो"
	 };
  hwa : Agr -> Str = \agr ->
        let       n    = (fromAgr agr).n;
		  p    = (fromAgr agr).p;
		  g    = (fromAgr agr).g;
	  in
	 case <n,g> of {
	 <Sg,Masc> => "हुआ";
	 <Sg,Fem>    => "हुई";
	 <Pl,Masc>	=> "हुए" ;
	 <Pl,Fem>	=> "हुई"
	 };	 
}