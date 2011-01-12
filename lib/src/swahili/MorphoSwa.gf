--# -path=.:../abstract:../../prelude:../common

--1 A Simple Swahili Resource Morphology
--
-- This resource morphology contains definitions needed in the resource
-- syntax. To build a lexicon, it is better to use $ParadigmsSwa$, which
-- gives a higher-level access to this module.

resource MorphoSwa = open Prelude, (Predef=Predef), ResSwa in {

  flags optimize=all ;
--$Nouns--
oper

  CommonNoun : Type = {s : Number => Str; g : Gender ; anim : Animacy } ;

  numForms : Str -> Str -> Number => Str = \bon,bons ->
    table {Sg => bon ; Pl => bons} ; 

  mkNoun : (Number => Str) -> Gender -> Animacy -> CommonNoun = \mecmecs,gen,anim -> 
    {s = mecmecs ; g = gen ; anim = anim} ;

  mkNounIrreg : Str -> Str -> Gender -> Animacy -> CommonNoun = \mec,mecs,gen,anim -> 
    mkNoun (numForms mec mecs) gen anim ;

  mkNomReg : Str -> Gender -> Animacy -> CommonNoun = \mtu,gen,anim -> 
   let watu = case gen of {
      g1_2   => case Predef.take 3 mtu of {
	"mwa"  => Predef.drop 1 mtu ;
        "mwi"  => "wa"+ Predef.drop 2 mtu ;
        _     => "wa" + Predef.drop 1 mtu 
           };	-- mtu/watu
     g3_4   => "mi" + Predef.drop 1 mtu ;	-- mti/miti
     g5_6   => "me" + Predef.drop 2 mtu ;	-- jicho/macho
     g5a_6  => "ma" + mtu ;			-- somo/masomo
     g7_8   => "vi" + Predef.drop 2 mtu ;	-- kitabu/vitabu
     g11_6  => "ma" + Predef.drop 1 mtu ;	-- ugonjwa/magonjwa 
     g11_10 => Predef.drop 1 mtu ;		-- ukuta/kuta
     _       => mtu				-- ma_ma (maji/maji); e_e (taa/taa); u_u (uhuru/uhuru)
   };
   in mkNounIrreg mtu watu gen anim ;

  mkNn : Str -> Str -> Gender -> Animacy -> CommonNoun = \mec,mecs,gen,anim -> 
    mkNoun (numForms mec mecs) gen anim ;

--Autonomous Personal Pronoun
  mkPronoun :Number -> Person-> Str= \n,p ->
  case <n,p> of {
  <Sg,P1> => "mimi" ;
  <Sg,P2> => "wewe" ;
  <Sg,P3> => "yeye" ;
  <Pl,P1> => "sisi" ;
  <Pl,P2> => "nyinyi" ;
  <Pl,P3> => "wao" 
  
  };
   

--$Verbs
 {--  
  VerbprefixR : Agr -> Str = \a -> Verbprefix a.n a.g a.anim a.p ;

   
   	 
   Verbprefix : Number -> Gender -> Animacy -> Person -> Str = \n,g,anim,p ->
   case <anim,n,g,p> of {
    <_,Sg,_,P1>      => "ni" ;
    <_,Sg,_,P2>      => "u" ;
    <_,Pl,_,P1>      => "tu" ;
    <_,Pl,_,P2>      => "m" ;
    <AN,Sg,_,_>      => "a" ;
    <AN,Pl,_,_>      => "wa" ;
    <_,Sg,g1_2,_>   => "a" ;
    <_,Pl,g1_2,_>   => "wa" ;
    <_,Sg,g3_4,_>   => "u" ;
    <_,Pl,g3_4,_>   => "i"  ;
    <_,Sg,g5_6,_>   => "li" ;
    <_,Pl,g5_6,_>   => "ya" ;
    <_,Sg,g5a_6,_>  => "li" ;
    <_,Pl,g5a_6,_>  => "ya" ;
    <AN,Sg,g6,_>     => "a" ;
    <AN,Pl,g6,_>     => "wa" ;
    <_,Sg,g6,_>     => "ya" ;
    <_,Pl,g6,_>     => "ya" ;
    <_,Sg,g7_8,_>   => "ki" ;
    <_,Pl,g7_8,_>   => "vi" ;
    <_,Sg,g9_10,_>  => "i" ;
    <_,Pl,g9_10,_>  => "zi" ;
    <_,_,g11,_>     => "u" ;
    <_,Sg,g11_6,_>  => "u" ;
    <_,Pl,g11_6,_>  => "ya" ;
    <_,Sg,g11_10,_> => "u" ;
    <_,Pl,g11_10,_> => "zi"  
   } ;


  Verbprefix : Number -> Gender -> Animacy -> Person -> Str = \n,g,anim,p ->
   case <anim,n,g,p> of {
    	<AN,Sg,_,P1>      => "ni" ;
	<AN,Pl,_,P1>      => "tu" ;
	<_,_,_,_>      => "" 	
   
   } ;


    mkV : Str -> {s : VForm => Str} = 
     \cheza -> {
     s = table { 
       --VInf => "ku"+cheza ;
       VInf => case Predef.take 2 cheza of { 
		"ku" => cheza;
		 _ => "ku"+cheza
	 };
       VImper n p => case <n,p> of {<Sg,P2> => init cheza + "eni";<_,_> => cheza}; 
       VPres n g anim p => Verbprefix n g anim p ++ "na" ++ cheza; 
       VPast n g anim p => Verbprefix n g anim p ++ "li" ++ cheza ;
       VFut n g anim p => Verbprefix n g anim p ++ "ta" ++ cheza     
       } 
     } ;

 --}	

--2 Adjectives
-- To form the adjectival and the adverbial forms, two strings are needed
-- in the worst case. (First without degrees.)

 Adj = {s : AForm => Str} ;
  
 VowelAdjprefix : Number -> Gender -> Animacy -> Str = \n,g,anim ->
   case <anim,n,g> of {
    <AN,Sg,_> => "mw" ;
    <AN,Pl,_> => "w" ;
    <_,Sg,g1_2> => "mw" ;
    <_,Pl,g1_2> => "w" ;
    <_,Sg,g3_4> => "mw" ;
    <_,Pl,g3_4> => "m" ;
    <_,Sg,g5_6> => "nj" ;
    <_,Pl,g5_6> => "m" ;
    <_,Sg,g5a_6> => "mw" ;
    <_,Pl,g5a_6> => "ny" ;
    <_,Sg,g6> => "m" ;
    <_,Pl,g6> => "m" ;
    <_,Sg,g7_8> => "ki" ;
    <_,Pl,g7_8> => "vi" ;
    <_,Sg,g9_10> => "ny" ;
    <_,Pl,g9_10> => "" ;
    <_,_,g11> => "m" ;
    <_,Sg,g11_6> => "m" ;
    <_,Pl,g11_6> => "ma" ;
    <_,Sg,g11_10> => "ny" ;
    <_,Pl,g11_10> => "m"  
   } ;


  ConsonantAdjprefix : Number -> Gender -> Animacy -> Str = \n,g,anim ->
   case <anim,n,g> of {
    <AN,Sg,_> => "m" ;
    <AN,Pl,_> => "wa" ;
    <_,Sg,g1_2> => "m" ;
    <_,Pl,g1_2> => "wa" ;
    <_,Sg,g3_4> => "" ;
    <_,Pl,g3_4> => "" ;
    <_,Sg,g5_6> => "" ;
    <_,Pl,g5_6> => "ma" ;
    <_,Sg,g5a_6> => "" ;
    <_,Pl,g5a_6> => "ma" ;
    <_,Sg,g6> => "ma" ;
    <_,Pl,g6> => "ma" ;
    <_,Sg,g7_8> => "ki" ;
    <_,Pl,g7_8> => "vi" ;
    <_,Sg,g9_10> => "i" ;
    <_,Pl,g9_10> => "" ;
    <_,_,g11> => "m" ;
    <_,Sg,g11_6> => "m" ;
    <_,Pl,g11_6> => "ma" ;
    <_,Sg,g11_10> => "m" ;
    <_,Pl,g11_10> => "n"  
   } ;	

 
mkAdjective : Str -> Adj = \zuri ->
    {  
       s = table {
       AF n g anim => case Predef.take 1 zuri of { 
		"a"|"e"|"i"|"o"|"u"  => VowelAdjprefix n g anim + zuri;
		 _ => ConsonantAdjprefix n g anim +zuri
	 };
       AA => zuri
       }
    } ;
     

mkDeterminer : Number -> Str -> {s : Str ; n : Number} = \n,s ->
    {s = s ; n = n} ;

mkQuant : Spatial -> Number -> Gender -> Animacy -> Case -> Person -> Str = \sp,n,g,anim,c,p ->
   let 
     pfx   = "foo" ; ---- Verbprefix n g anim p ;
   in 
   case <anim,n,c> of {
    <AN,Sg,Nom> => case <sp> of {
                 <SpHrObj> => "huyu" ;
                 <HrObj>   => "huyo" ;
                 <_>       => "yule" } ;
   
    <_,_,_>   => case <sp> of {
                 <SpHrObj> => "h" + Predef.dp 1 (Verbprefix n g anim p) + Verbprefix n g anim p ; --sphrobj ;
--                 <HrObj>   => mkQuantEnd (Predef.tk 1 sphrobj) ;
                 <HrObj>   => mkQuantEnd (Predef.tk 1 ("h" + Predef.dp 1 (Verbprefix n g anim p) + Verbprefix n g anim p)) ;
                 <_>       => Verbprefix n g anim p + "le" } 
    } ;

mkQuantEnd : Str -> Str = \stem ->
   let 
     suffix = Predef.dp 1 stem ;
     front  = Predef.tk 1 stem 
   in
   case <suffix> of {
    <"i"> => stem + "yo" ;
    <"k"> => front + "cho" ;
    <"v"> => front + "vyo" ;
    <"w"> => front + "o" ;
    <_>   => stem + "o"
   } ;



} ;

