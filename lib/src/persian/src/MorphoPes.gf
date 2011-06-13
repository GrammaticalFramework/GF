--# -path=.:../../prelude
--
----1 A Simple Punjabi Resource Morphology
----
----  Shafqat Virk, Aarne Ranta,2010
----
---- This resource morphology contains definitions needed in the resource
---- syntax. To build a lexicon, it is better to use $ParadigmsPnb$, which
---- gives a higher-level access to this module.
--
resource MorphoPes = ResPes ** open Prelude,Predef in {

  flags optimize=all ;
   coding = utf8;

----2 Nouns

oper
    
    mkN : (x1,x2 : Str) -> Animacy -> Noun = 
      \sg,pl,ani -> {
      s = table {
         bEzafa => table { Sg => sg ;
                           Pl => pl
                        } ;
         aEzafa => table { Sg => mkEzafa sg ;
                           Pl => mkEzafa pl
                         } ;
         enClic => table { Sg => mkEnclic sg ;
                           Pl => mkEnclic pl
                         }                
          };
      animacy = ani ;
      definitness = True
      } ;
    
    
    
-- masculine nouns end with alif, choTi_hay, ain Translitration: (a, h, e)
-- Arabic nouns ends with h. also taken as Masc
  ------------------------------------------------------------------
----Verbs
------------------------------------------------------------------
{- 
 mkVerb : (x1,x2 : Str) -> Verb = \inf,root2 ->
   let root1  = (tk 1 inf) ;    
    in { 
     s = table {

     Root1     => root1 ;
     Root2     => root2 ;
     Inf      => inf ;

     VF tense aspect person number   => (mkCmnVF root1 root2 tense aspect person number).s 
--     Caus1 tense person number gender => (mkCmnVF root1 tense person number gender).s ;
--     Caus2 tense person number gender => (mkCmnVF root2 tense person number gender).s 
    }
  } ;

--1. Basic stem form, direct & indirect causatives exists
-- v1 nechna nechaana nechwana

  mkVerb1 : (_: Str) -> Verb = \inf ->
   let root1  = (tk 1 inf) ; 
       root2 = (tk 3 inf)  ;    
    in { 
     s = table {

     Root1     => root1 ;
     Root2     => root2 ;
     Inf      => inf ;

     VF tense aspect person number   => (mkCmnVF root1 root2 tense aspect person number).s 
--     Caus1 tense person number gender => (mkCmnVF root1 tense person number gender).s ;
--     Caus2 tense person number gender => (mkCmnVF root2 tense person number gender).s 
    }
  } ;


mkVerb2 : (_: Str) -> Verb = \inf ->
   let root1  = (tk 1 inf) ; 
       root2 = (tk 2 inf)  ;    
    in { 
     s = table {

     Root1     => root1 ;
     Root2     => root2 ;
     Inf      => inf ;

     VF tense aspect person number   => (mkCmnVF root1 root2 tense aspect person number).s 
--     Caus1 tense person number gender => (mkCmnVF root1 tense person number gender).s ;
--     Caus2 tense person number gender => (mkCmnVF root2 tense person number gender).s 
    }
  } ;



mkCmnVF : Str -> Str -> VTense -> PAspect -> PPerson -> Number -> {s:Str}= \root1,root2,t,a,p,n ->
  {s  = (mkCmnVF1 root1 root2 t a p n).s ;
   };
  

 mkCmnVF1 : Str -> Str -> VTense -> PAspect -> PPerson -> Number -> {s:Str}= \root1,root2,t,a,p,n ->
  {s = let khordh = root1 + "h";
           mekhor = "my" ++ root2 ;
	   mekhord = "my" ++ root1 ;
	   mekhordh = "my" ++ khordh ;
	   khah = "KvAh" ;
	   mekhah = "my" ++ khah ;
	   bvdh = "bvdh"
  in
  case <t,a,p,n> of {
    <PPresent,PPerf,PPers1,Sg> => khordh ++ "Am" ;
    <PPresent,PPerf,PPers1,Pl> => khordh ++ "Aym" ;
    <PPresent,PPerf,PPers2,Sg> => khordh ++ "Ay" ;
    <PPresent,PPerf,PPers2,Pl> => khordh ++ "Ayd" ;
    <PPresent,PPerf,PPers3,Sg> => khordh ++ "Ast" ;
    <PPresent,PPerf,PPers3,Pl> => khordh ++ "And" ;
    
    <PPresent,PImperf,PPers1,Sg> => mekhor + "m" ; -- toHave need to have khor instead of mekhor
    <PPresent,PImperf,PPers1,Pl> => mekhor + "ym" ;
    <PPresent,PImperf,PPers2,Sg> => mekhor + "y" ;
    <PPresent,PImperf,PPers2,Pl> => mekhor + "yd" ;
    <PPresent,PImperf,PPers3,Sg> => mekhor + "d" ;
    <PPresent,PImperf,PPers3,Pl> => mekhor + "nd" ;
    
    <PPresent,Aorist,PPers1,Sg> => "" ;
    <PPresent,Aorist,PPers1,Pl> => "" ;
    <PPresent,Aorist,PPers2,Sg> => "" ;
    <PPresent,Aorist,PPers2,Pl> => "" ;
    <PPresent,Aorist,PPers3,Sg> => "" ;
    <PPresent,Aorist,PPers3,Pl> => "" ;
    
    <PPast,PPerf,PPers1,Sg> => khordh ++ "bvdm" ;
    <PPast,PPerf,PPers1,Pl> => khordh ++ "bvdym" ;
    <PPast,PPerf,PPers2,Sg> => khordh ++ "bvdy" ;
    <PPast,PPerf,PPers2,Pl> => khordh ++ "bvdyd" ;
    <PPast,PPerf,PPers3,Sg> => khordh ++ "bvd" ;
    <PPast,PPerf,PPers3,Pl> => khordh ++ "bvdnd" ;
    
    <PPast,PImperf,PPers1,Sg> => mekhord + "m" ; -- toHave need to have khor instead of mekhor
    <PPast,PImperf,PPers1,Pl> => mekhord + "ym" ;
    <PPast,PImperf,PPers2,Sg> => mekhord  + "y";
    <PPast,PImperf,PPers2,Pl> => mekhord + "yd" ;
    <PPast,PImperf,PPers3,Sg> => mekhord ;
    <PPast,PImperf,PPers3,Pl> => mekhord + "nd" ;
    
    <PPast,Aorist,PPers1,Sg> => root1 + "m" ;
    <PPast,Aorist,PPers1,Pl> => root1 + "ym" ;
    <PPast,Aorist,PPers2,Sg> => root1  + "y";
    <PPast,Aorist,PPers2,Pl> => root1 + "yd" ;
    <PPast,Aorist,PPers3,Sg> => root1 ;
    <PPast,Aorist,PPers3,Pl> => root1 + "nd" ;
    
    -- check this one
    <PFut,PPerf,PPers1,Sg> => "" ;
    <PFut,PPerf,PPers1,Pl> => "" ;
    <PFut,PPerf,PPers2,Sg> => "" ;
    <PFut,PPerf,PPers2,Pl> => "" ;
    <PFut,PPerf,PPers3,Sg> => "" ;
    <PFut,PPerf,PPers3,Pl> => "" ;
    
    <PFut,PImperf,PPers1,Sg> => mekhah + "m"   ++ addBh root2 + "m" ;
    <PFut,PImperf,PPers1,Pl> => mekhah + "ym" ++  addBh root2 + "ym" ;
    <PFut,PImperf,PPers2,Sg> => mekhah + "y" ++  addBh root2 + "y" ;
    <PFut,PImperf,PPers2,Pl> => mekhah + "yd" ++  addBh root2 + "yd" ;
    <PFut,PImperf,PPers3,Sg> => mekhah + "d" ++  addBh root2 + "d" ;
    <PFut,PImperf,PPers3,Pl> => mekhah + "nd" ++  addBh root2 + "nd" ;
    
    <PFut,Aorist,PPers1,Sg> => khah + "m"  ++ root1  ;
    <PFut,Aorist,PPers1,Pl> => khah + "ym"  ++ root1 ;
    <PFut,Aorist,PPers2,Sg> => khah + "y"  ++ root1 ;
    <PFut,Aorist,PPers2,Pl> => khah + "yd"  ++ root1 ;
    <PFut,Aorist,PPers3,Sg> => khah + "d"  ++ root1 ;
    <PFut,Aorist,PPers3,Pl> => khah + "nd"  ++ root1  ;
    
    
    <Infr_Past,PPerf,PPers1,Sg> => khordh ++ bvdh ++ "Am" ;
    <Infr_Past,PPerf,PPers1,Pl> => khordh ++ bvdh ++ "Aym" ;
    <Infr_Past,PPerf,PPers2,Sg> => khordh ++ bvdh ++ "Ay" ;
    <Infr_Past,PPerf,PPers2,Pl> => khordh ++ bvdh ++ "Ayd" ;
    <Infr_Past,PPerf,PPers3,Sg> => khordh ++ bvdh ++ "Ast" ;
    <Infr_Past,PPerf,PPers3,Pl> => khordh ++ bvdh ++ "And" ;
    
    <Infr_Past,PImperf,PPers1,Sg> => mekhordh ++ "Am" ;  -- toHave need to have khordh instead of mekhor
    <Infr_Past,PImperf,PPers1,Pl> => mekhordh ++ "Aym" ;
    <Infr_Past,PImperf,PPers2,Sg> => mekhordh ++ "Ay" ;
    <Infr_Past,PImperf,PPers2,Pl> => mekhordh ++ "Ayd" ;
    <Infr_Past,PImperf,PPers3,Sg> => mekhordh ++ "Ast" ;
    <Infr_Past,PImperf,PPers3,Pl> => mekhordh ++ "And" ;
    
    
    -- check this one
    <Infr_Past,Aorist,PPers1,Sg> => "" ;
    <Infr_Past,Aorist,PPers1,Pl> => "" ;
    <Infr_Past,Aorist,PPers2,Sg> => "" ;
    <Infr_Past,Aorist,PPers2,Pl> => "" ;
    <Infr_Past,Aorist,PPers3,Sg> => "" ;
    <Infr_Past,Aorist,PPers3,Pl> => "" 
    
    
  }
 } ;
 -}
 mkVerb : (x1,x2 : Str) -> Verb = \inf,root2 ->
   let root1  = (tk 1 inf) ;
   impRoot = mkimpRoot root2;
    in { 
     s = table {

     Root1     => root1 ;
     Root2     => root2 ;
     Inf      => inf ;
     Imp Pos Sg => addBh impRoot ;
     Imp Pos Pl => (addBh impRoot) + "yd" ;
     Imp Neg Sg => "n" + impRoot ;
     Imp Neg Pl => "n" +  impRoot + "yd" ;

     VF pol tense person number   => (mkCmnVF root1 root2 pol tense person number).s ;
--     VF Neg tense person number   => addN (mkCmnVF root1 root2 tense person number).s ;
     Vvform (AgPes number person) => (mkvVform root2 number person).s
   }
  } ;

 mkVerb1 : (_: Str) -> Verb = \inf ->
   let root1  = (tk 1 inf) ; 
       root2 = (tk 3 inf)  ;
       impRoot = mkimpRoot root2 ;
    in { 
     s = table {

     Root1     => root1 ;
     Root2     => root2 ;
     Inf      => inf ;
     Imp Pos Sg => addBh impRoot ;
     Imp Pos Pl => (addBh impRoot) + "yd" ;
     Imp Neg Sg => "n" + impRoot ;
     Imp Neg Pl => "n" +  impRoot + "yd" ;

     VF pol tense person number   => (mkCmnVF root1 root2 pol tense person number).s ;
--     VF Neg tense person number   => addN (mkCmnVF root1 root2 tense person number).s ;
     Vvform (AgPes number person) => (mkvVform root2 number person).s
     }
    };
    
  
mkVerb2 : (_: Str) -> Verb = \inf ->
   let root1  = (tk 1 inf) ; 
       root2 = (tk 2 inf)  ;
       impRoot = mkimpRoot root2 ;
    in { 
     s = table {

     Root1     => root1 ;
     Root2     => root2 ;
     Inf      => inf ;
     Imp Pos Sg => addBh impRoot ;
     Imp Pos Pl => (addBh impRoot) + "yd" ;
     Imp Neg Sg => "n" + impRoot ;
     Imp Neg Pl => "n" +  impRoot + "yd" ;

     VF pol tense person number   => (mkCmnVF root1 root2 pol tense person number).s ;
--     VF Neg tense person number   => addN (mkCmnVF root1 root2 tense person number).s ;
     Vvform (AgPes number person) => (mkvVform root2 number person).s
    }
  } ;
  
  mkHave : Verb = 
  
     { 
     s = table {

     Root1     => "dACt" ;
     Root2     => "dAr" ;
     Inf      => "dACtn" ;
     Imp Pos Sg => ["dACth bAC"] ;
     Imp Pos Pl => ["dACth bACyd"];
     Imp Neg Sg => ["ndACth bAC"]  ;
     Imp Neg Pl => ["ndACth bACyd"] ;

     VF pol tense person number   => (toHave pol tense number person).s ;
--     VF Neg tense person number   => addN (mkCmnVF root1 root2 tense person number).s ;
     Vvform (AgPes Sg PPers1) => ["dACth bACm"] ;
     Vvform (AgPes Sg PPers2) => ["dACth bACy"] ;
     Vvform (AgPes Sg PPers3) => ["dACth bACd"] ;
     Vvform (AgPes Pl PPers1) => ["dACth bACym"] ;
     Vvform (AgPes Pl PPers2) => ["dACth bACyd"] ;
     Vvform (AgPes Pl PPers3) => ["dACth bACnd"] 
    }
  } ;
  
  
mkCmnVF : Str -> Str -> Polarity -> VTense2 ->  PPerson -> Number -> {s:Str}= \root1,root2,pol,t,p,n ->
  {s  = (mkCmnVF1 root1 root2 pol t p n).s ;
   };
  

 mkCmnVF1 : Str -> Str -> Polarity -> VTense2 -> PPerson -> Number -> {s:Str}= \root1,root2,pol,t,p,n ->
  {s = let khordh = root1 + "h";
           nkhordh = (addN root1) + "h" ;
           mekhor = "my" ++ root2 ;
	   nmekhor =  "nmy" ++ root2 ;
	   mekhord = "my" ++ root1 ;
	   nmekhord = "nmy" ++ root1 ;
	   mekhordh = "my" ++ khordh ;
	   nmekhordh = "nmy" ++ khordh ;
	   khah = "KvAh" ;
	   nkhah = "nKvAh" ;
	   mekhah = "my" ++ khah ;
	   nmekhah = "nmy" ++ khah ;
	   bvdh = "bvdh"
  in
  case <pol,t,p,n> of {
    <Pos,PPresent2 PrPerf,PPers1,Sg> => khordh ++ "Am" ;  
    <Pos,PPresent2 PrPerf,PPers1,Pl> => khordh ++ "Aym" ;
    <Pos,PPresent2 PrPerf,PPers2,Sg> => khordh ++ "Ay" ;
    <Pos,PPresent2 PrPerf,PPers2,Pl> => khordh ++ "Ayd" ;
    <Pos,PPresent2 PrPerf,PPers3,Sg> => khordh ++ "Ast" ;
    <Pos,PPresent2 PrPerf,PPers3,Pl> => khordh ++ "And" ;
    
    <Pos,PPresent2 PrImperf,PPers1,Sg> => mekhor + "m" ;
    <Pos,PPresent2 PrImperf,PPers1,Pl> => mekhor + "ym" ;
    <Pos,PPresent2 PrImperf,PPers2,Sg> => mekhor + "y" ;
    <Pos,PPresent2 PrImperf,PPers2,Pl> => mekhor + "yd" ;
    <Pos,PPresent2 PrImperf,PPers3,Sg> => mekhor + "d" ;
    <Pos,PPresent2 PrImperf,PPers3,Pl> => mekhor + "nd" ;
    
    
    <Pos,PPast2 PstPerf,PPers1,Sg> => khordh ++ "bvdm" ;
    <Pos,PPast2 PstPerf,PPers1,Pl> => khordh ++ "bvdym" ;
    <Pos,PPast2 PstPerf,PPers2,Sg> => khordh ++ "bvdy" ;
    <Pos,PPast2 PstPerf,PPers2,Pl> => khordh ++ "bvdyd" ;
    <Pos,PPast2 PstPerf,PPers3,Sg> => khordh ++ "bvd" ;
    <Pos,PPast2 PstPerf,PPers3,Pl> => khordh ++ "bvdnd" ;
    
    <Pos,PPast2 PstImperf,PPers1,Sg> => mekhord + "m" ;
    <Pos,PPast2 PstImperf,PPers1,Pl> => mekhord + "ym" ;
    <Pos,PPast2 PstImperf,PPers2,Sg> => mekhord  + "y";
    <Pos,PPast2 PstImperf,PPers2,Pl> => mekhord + "yd" ;
    <Pos,PPast2 PstImperf,PPers3,Sg> => mekhord ;
    <Pos,PPast2 PstImperf,PPers3,Pl> => mekhord + "nd" ;
    
    <Pos,PPast2 PstAorist,PPers1,Sg> => root1 + "m" ;
    <Pos,PPast2 PstAorist,PPers1,Pl> => root1 + "ym" ;
    <Pos,PPast2 PstAorist,PPers2,Sg> => root1  + "y";
    <Pos,PPast2 PstAorist,PPers2,Pl> => root1 + "yd" ;
    <Pos,PPast2 PstAorist,PPers3,Sg> => root1 ;
    <Pos,PPast2 PstAorist,PPers3,Pl> => root1 + "nd" ;
    
   {- 
    <Pos,PFut2 FtImperf,PPers1,Sg> => mekhah + "m"   ++ addBh root2 + "m" ;
    <Pos,PFut2 FtImperf,PPers1,Pl> => mekhah + "ym" ++  addBh root2 + "ym" ;
    <Pos,PFut2 FtImperf,PPers2,Sg> => mekhah + "y" ++  addBh root2 + "y" ;
    <Pos,PFut2 FtImperf,PPers2,Pl> => mekhah + "yd" ++  addBh root2 + "yd" ;
    <Pos,PFut2 FtImperf,PPers3,Sg> => mekhah + "d" ++  addBh root2 + "d" ;
    <Pos,PFut2 FtImperf,PPers3,Pl> => mekhah + "nd" ++  addBh root2 + "nd" ;
    -}
    <Pos,PFut2 FtAorist,PPers1,Sg> => khah + "m"  ++ root1  ;
    <Pos,PFut2 FtAorist,PPers1,Pl> => khah + "ym"  ++ root1 ;
    <Pos,PFut2 Ftorist,PPers2,Sg> => khah + "y"  ++ root1 ;
    <Pos,PFut2 FtAorist,PPers2,Pl> => khah + "yd"  ++ root1 ;
    <Pos,PFut2 FtAorist,PPers3,Sg> => khah + "d"  ++ root1 ;
    <Pos,PFut2 FtAorist,PPers3,Pl> => khah + "nd"  ++ root1  ;
    
    
    <Pos,Infr_Past2 InfrPerf,PPers1,Sg> => khordh ++ bvdh ++ "Am" ;
    <Pos,Infr_Past2 InfrPerf,PPers1,Pl> => khordh ++ bvdh ++ "Aym" ;
    <Pos,Infr_Past2 InfrPerf,PPers2,Sg> => khordh ++ bvdh ++ "Ay" ;
    <Pos,Infr_Past2 InfrPerf,PPers2,Pl> => khordh ++ bvdh ++ "Ayd" ;
    <Pos,Infr_Past2 InfrPerf,PPers3,Sg> => khordh ++ bvdh ++ "Ast" ;
    <Pos,Infr_Past2 InfrPerf,PPers3,Pl> => khordh ++ bvdh ++ "And" ;
    
    <Pos,Infr_Past2 InfrImperf,PPers1,Sg> => mekhordh ++ "Am" ;
    <Pos,Infr_Past2 InfrImperf,PPers1,Pl> => mekhordh ++ "Aym" ;
    <Pos,Infr_Past2 InfrImperf,PPers2,Sg> => mekhordh ++ "Ay" ;
    <Pos,Infr_Past2 InfrImperf,PPers2,Pl> => mekhordh ++ "Ayd" ;
    <Pos,Infr_Past2 InfrImperf,PPers3,Sg> => mekhordh ++ "Ast" ;
    <Pos,Infr_Past2 InfrImperf,PPers3,Pl> => mekhordh ++ "And" ;
    
 -- negatives
 
    <Neg,PPresent2 PrPerf,PPers1,Sg> => addN khordh ++ "Am" ;  
    <Neg,PPresent2 PrPerf,PPers1,Pl> => addN khordh ++ "Aym" ;
    <Neg,PPresent2 PrPerf,PPers2,Sg> => addN khordh ++ "Ay" ;
    <Neg,PPresent2 PrPerf,PPers2,Pl> => addN khordh ++ "Ayd" ;
    <Neg,PPresent2 PrPerf,PPers3,Sg> => addN khordh ++ "Ast" ;
    <Neg,PPresent2 PrPerf,PPers3,Pl> => addN khordh ++ "And" ;
    
    
    <Neg,PPresent2 PrImperf,PPers1,Sg> => nmekhor + "m" ;
    <Neg,PPresent2 PrImperf,PPers1,Pl> => nmekhor + "ym" ;
    <Neg,PPresent2 PrImperf,PPers2,Sg> => nmekhor + "y" ;
    <Neg,PPresent2 PrImperf,PPers2,Pl> => nmekhor + "yd" ;
    <Neg,PPresent2 PrImperf,PPers3,Sg> => nmekhor + "d" ;
    <Neg,PPresent2 PrImperf,PPers3,Pl> => nmekhor + "nd" ;
         
    <Neg,PPast2 PstPerf,PPers1,Sg> => nkhordh ++ "bvdm" ;
    <Neg,PPast2 PstPerf,PPers1,Pl> => nkhordh ++ "bvdym" ;
    <Neg,PPast2 PstPerf,PPers2,Sg> => nkhordh ++ "bvdy" ;
    <Neg,PPast2 PstPerf,PPers2,Pl> => nkhordh ++ "bvdyd" ;
    <Neg,PPast2 PstPerf,PPers3,Sg> => nkhordh ++ "bvd" ;
    <Neg,PPast2 PstPerf,PPers3,Pl> => nkhordh ++ "bvdnd" ;
      
    <Neg,PPast2 PstImperf,PPers1,Sg> => nmekhord + "m" ;
    <Neg,PPast2 PstImperf,PPers1,Pl> => nmekhord + "ym" ;
    <Neg,PPast2 PstImperf,PPers2,Sg> => nmekhord  + "y";
    <Neg,PPast2 PstImperf,PPers2,Pl> => nmekhord + "yd" ;
    <Neg,PPast2 PstImperf,PPers3,Sg> => nmekhord ;
    <Neg,PPast2 PstImperf,PPers3,Pl> => nmekhord + "nd" ;
  
 
    <Neg,PPast2 PstAorist,PPers1,Sg> => addN root1 + "m" ;
    <Neg,PPast2 PstAorist,PPers1,Pl> => addN root1 + "ym" ;
    <Neg,PPast2 PstAorist,PPers2,Sg> => addN root1  + "y";
    <Neg,PPast2 PstAorist,PPers2,Pl> => addN root1 + "yd" ;
    <Neg,PPast2 PstAorist,PPers3,Sg> => addN root1 ;
    <Neg,PPast2 PstAorist,PPers3,Pl> => addN root1 + "nd" ;
      
 {-     
    <Neg,PFut2 FtImperf,PPers1,Sg> => nmekhah + "m"   ++ addBh root2 + "m" ;
    <Neg,PFut2 FtImperf,PPers1,Pl> => nmekhah + "ym" ++  addBh root2 + "ym" ;
    <Neg,PFut2 FtImperf,PPers2,Sg> => nmekhah + "y" ++  addBh root2 + "y" ;
    <Neg,PFut2 FtImperf,PPers2,Pl> => nmekhah + "yd" ++  addBh root2 + "yd" ;
    <Neg,PFut2 FtImperf,PPers3,Sg> => nmekhah + "d" ++  addBh root2 + "d" ;
    <Neg,PFut2 FtImperf,PPers3,Pl> => nmekhah + "nd" ++  addBh root2 + "nd" ;
 -}   
    <Neg,PFut2 FtAorist,PPers1,Sg> => nkhah + "m"  ++ root1  ;
    <Neg,PFut2 FtAorist,PPers1,Pl> => nkhah + "ym"  ++ root1 ;
    <Neg,PFut2 Ftorist,PPers2,Sg> => nkhah + "y"  ++ root1 ;
    <Neg,PFut2 FtAorist,PPers2,Pl> => nkhah + "yd"  ++ root1 ;
    <Neg,PFut2 FtAorist,PPers3,Sg> => nkhah + "d"  ++ root1 ;
    <Neg,PFut2 FtAorist,PPers3,Pl> => nkhah + "nd"  ++ root1  ;
    
   
    <Neg,Infr_Past2 InfrPerf,PPers1,Sg> => nkhordh ++ bvdh ++ "Am" ;
    <Neg,Infr_Past2 InfrPerf,PPers1,Pl> => nkhordh ++ bvdh ++ "Aym" ;
    <Neg,Infr_Past2 InfrPerf,PPers2,Sg> => nkhordh ++ bvdh ++ "Ay" ;
    <Neg,Infr_Past2 InfrPerf,PPers2,Pl> => nkhordh ++ bvdh ++ "Ayd" ;
    <Neg,Infr_Past2 InfrPerf,PPers3,Sg> => nkhordh ++ bvdh ++ "Ast" ;
    <Neg,Infr_Past2 InfrPerf,PPers3,Pl> => nkhordh ++ bvdh ++ "And" ;
    
    <Neg,Infr_Past2 InfrImperf,PPers1,Sg> => nmekhordh ++ "Am" ;
    <Neg,Infr_Past2 InfrImperf,PPers1,Pl> => nmekhordh ++ "Aym" ;
    <Neg,Infr_Past2 InfrImperf,PPers2,Sg> => nmekhordh ++ "Ay" ;
    <Neg,Infr_Past2 InfrImperf,PPers2,Pl> => nmekhordh ++ "Ayd" ;
    <Neg,Infr_Past2 InfrImperf,PPers3,Sg> => nmekhordh ++ "Ast" ;
    <Neg,Infr_Past2 InfrImperf,PPers3,Pl> => nmekhordh ++ "And" 
   
     
     }
     
   } ;
   
  mkvVform : Str -> Number -> PPerson -> {s: Str} = \root2,n,p ->
  {s =
    case <n,p> of {
     <Sg,PPers1> => addBh root2 + "m" ;
     <Sg,PPers2> => addBh root2 + "y" ;
     <Sg,PPers3> => addBh root2 + "d" ;
     <Pl,PPers1> => addBh root2 + "ym" ;
     <Pl,PPers2> => addBh root2 + "yd" ;
     <Pl,PPers3> => addBh root2 + "nd" 
     }
    };

 mkimpRoot : Str -> Str ;
 mkimpRoot root =
             case root of {
                   st + "y" => st ;
                   _        => root
                   };


addBh : Str -> Str ;
addBh str = 
            case (take 1 str) of { 
	       "A" => "by" + str ;  
	       "A:" => "byA" + (drop 1 str) ;
	       _    => "b" + str
       };
       
 ---------------------
 --Determiners
 --------------------
 
 makeDet : Str -> Number -> Bool -> {s: Str ; n : Number ; isNum : Bool ; fromPron : Bool} =\str,n,b -> {
      s = str;
      isNum = b;
      fromPron = False ;
      n = n
   };
 makeQuant : Str -> Str  -> {s : Number => Str ; a : AgrPes ; fromPron : Bool } = \sg,pl -> {
            s = table {Sg => sg ; Pl => pl} ;
            fromPron = False ;
	    a = agrPesP3 Sg
	    };
---------------------------
-- Adjectives
--------------------------
mkAdj : Str -> Str -> Adjective = \adj,adv -> {
 s = table { bEzafa => adj;
             aEzafa => mkEzafa adj ;
             enClic => mkEnclic adj
            } ;
  adv = adv          
  };
}