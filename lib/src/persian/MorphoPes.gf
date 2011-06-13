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
  {s = let khordh = root1 + "ه";
           mekhor = "می" ++ root2 ;
	   mekhord = "می" ++ root1 ;
	   mekhordh = "می" ++ khordh ;
	   khah = "خواه" ;
	   mekhah = "می" ++ khah ;
	   bvdh = "بوده"
  in
  case <t,a,p,n> of {
    <PPresent,PPerf,PPers1,Sg> => khordh ++ "ام" ;
    <PPresent,PPerf,PPers1,Pl> => khordh ++ "ایم" ;
    <PPresent,PPerf,PPers2,Sg> => khordh ++ "ای" ;
    <PPresent,PPerf,PPers2,Pl> => khordh ++ "اید" ;
    <PPresent,PPerf,PPers3,Sg> => khordh ++ "است" ;
    <PPresent,PPerf,PPers3,Pl> => khordh ++ "اند" ;
    
    <PPresent,PImperf,PPers1,Sg> => mekhor + "م" ; -- toHave need to have khor instead of mekhor
    <PPresent,PImperf,PPers1,Pl> => mekhor + "یم" ;
    <PPresent,PImperf,PPers2,Sg> => mekhor + "ی" ;
    <PPresent,PImperf,PPers2,Pl> => mekhor + "ید" ;
    <PPresent,PImperf,PPers3,Sg> => mekhor + "د" ;
    <PPresent,PImperf,PPers3,Pl> => mekhor + "ند" ;
    
    <PPresent,Aorist,PPers1,Sg> => "" ;
    <PPresent,Aorist,PPers1,Pl> => "" ;
    <PPresent,Aorist,PPers2,Sg> => "" ;
    <PPresent,Aorist,PPers2,Pl> => "" ;
    <PPresent,Aorist,PPers3,Sg> => "" ;
    <PPresent,Aorist,PPers3,Pl> => "" ;
    
    <PPast,PPerf,PPers1,Sg> => khordh ++ "بودم" ;
    <PPast,PPerf,PPers1,Pl> => khordh ++ "بودیم" ;
    <PPast,PPerf,PPers2,Sg> => khordh ++ "بودی" ;
    <PPast,PPerf,PPers2,Pl> => khordh ++ "بودید" ;
    <PPast,PPerf,PPers3,Sg> => khordh ++ "بود" ;
    <PPast,PPerf,PPers3,Pl> => khordh ++ "بودند" ;
    
    <PPast,PImperf,PPers1,Sg> => mekhord + "م" ; -- toHave need to have khor instead of mekhor
    <PPast,PImperf,PPers1,Pl> => mekhord + "یم" ;
    <PPast,PImperf,PPers2,Sg> => mekhord  + "ی";
    <PPast,PImperf,PPers2,Pl> => mekhord + "ید" ;
    <PPast,PImperf,PPers3,Sg> => mekhord ;
    <PPast,PImperf,PPers3,Pl> => mekhord + "ند" ;
    
    <PPast,Aorist,PPers1,Sg> => root1 + "م" ;
    <PPast,Aorist,PPers1,Pl> => root1 + "یم" ;
    <PPast,Aorist,PPers2,Sg> => root1  + "ی";
    <PPast,Aorist,PPers2,Pl> => root1 + "ید" ;
    <PPast,Aorist,PPers3,Sg> => root1 ;
    <PPast,Aorist,PPers3,Pl> => root1 + "ند" ;
    
    -- check this one
    <PFut,PPerf,PPers1,Sg> => "" ;
    <PFut,PPerf,PPers1,Pl> => "" ;
    <PFut,PPerf,PPers2,Sg> => "" ;
    <PFut,PPerf,PPers2,Pl> => "" ;
    <PFut,PPerf,PPers3,Sg> => "" ;
    <PFut,PPerf,PPers3,Pl> => "" ;
    
    <PFut,PImperf,PPers1,Sg> => mekhah + "م"   ++ addBh root2 + "م" ;
    <PFut,PImperf,PPers1,Pl> => mekhah + "یم" ++  addBh root2 + "یم" ;
    <PFut,PImperf,PPers2,Sg> => mekhah + "ی" ++  addBh root2 + "ی" ;
    <PFut,PImperf,PPers2,Pl> => mekhah + "ید" ++  addBh root2 + "ید" ;
    <PFut,PImperf,PPers3,Sg> => mekhah + "د" ++  addBh root2 + "د" ;
    <PFut,PImperf,PPers3,Pl> => mekhah + "ند" ++  addBh root2 + "ند" ;
    
    <PFut,Aorist,PPers1,Sg> => khah + "م"  ++ root1  ;
    <PFut,Aorist,PPers1,Pl> => khah + "یم"  ++ root1 ;
    <PFut,Aorist,PPers2,Sg> => khah + "ی"  ++ root1 ;
    <PFut,Aorist,PPers2,Pl> => khah + "ید"  ++ root1 ;
    <PFut,Aorist,PPers3,Sg> => khah + "د"  ++ root1 ;
    <PFut,Aorist,PPers3,Pl> => khah + "ند"  ++ root1  ;
    
    
    <Infr_Past,PPerf,PPers1,Sg> => khordh ++ bvdh ++ "ام" ;
    <Infr_Past,PPerf,PPers1,Pl> => khordh ++ bvdh ++ "ایم" ;
    <Infr_Past,PPerf,PPers2,Sg> => khordh ++ bvdh ++ "ای" ;
    <Infr_Past,PPerf,PPers2,Pl> => khordh ++ bvdh ++ "اید" ;
    <Infr_Past,PPerf,PPers3,Sg> => khordh ++ bvdh ++ "است" ;
    <Infr_Past,PPerf,PPers3,Pl> => khordh ++ bvdh ++ "اند" ;
    
    <Infr_Past,PImperf,PPers1,Sg> => mekhordh ++ "ام" ;  -- toHave need to have khordh instead of mekhor
    <Infr_Past,PImperf,PPers1,Pl> => mekhordh ++ "ایم" ;
    <Infr_Past,PImperf,PPers2,Sg> => mekhordh ++ "ای" ;
    <Infr_Past,PImperf,PPers2,Pl> => mekhordh ++ "اید" ;
    <Infr_Past,PImperf,PPers3,Sg> => mekhordh ++ "است" ;
    <Infr_Past,PImperf,PPers3,Pl> => mekhordh ++ "اند" ;
    
    
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
     Imp Pos Pl => (addBh impRoot) + "ید" ;
     Imp Neg Sg => "ن" + impRoot ;
     Imp Neg Pl => "ن" +  impRoot + "ید" ;

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
     Imp Pos Pl => (addBh impRoot) + "ید" ;
     Imp Neg Sg => "ن" + impRoot ;
     Imp Neg Pl => "ن" +  impRoot + "ید" ;

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
     Imp Pos Pl => (addBh impRoot) + "ید" ;
     Imp Neg Sg => "ن" + impRoot ;
     Imp Neg Pl => "ن" +  impRoot + "ید" ;

     VF pol tense person number   => (mkCmnVF root1 root2 pol tense person number).s ;
--     VF Neg tense person number   => addN (mkCmnVF root1 root2 tense person number).s ;
     Vvform (AgPes number person) => (mkvVform root2 number person).s
    }
  } ;
  
  mkHave : Verb = 
  
     { 
     s = table {

     Root1     => "داشت" ;
     Root2     => "دار" ;
     Inf      => "داشتن" ;
     Imp Pos Sg => ["داشته باش"] ;
     Imp Pos Pl => ["داشته باشید"];
     Imp Neg Sg => ["نداشته باش"]  ;
     Imp Neg Pl => ["نداشته باشید"] ;

     VF pol tense person number   => (toHave pol tense number person).s ;
--     VF Neg tense person number   => addN (mkCmnVF root1 root2 tense person number).s ;
     Vvform (AgPes Sg PPers1) => ["داشته باشم"] ;
     Vvform (AgPes Sg PPers2) => ["داشته باشی"] ;
     Vvform (AgPes Sg PPers3) => ["داشته باشد"] ;
     Vvform (AgPes Pl PPers1) => ["داشته باشیم"] ;
     Vvform (AgPes Pl PPers2) => ["داشته باشید"] ;
     Vvform (AgPes Pl PPers3) => ["داشته باشند"] 
    }
  } ;
  
  
mkCmnVF : Str -> Str -> Polarity -> VTense2 ->  PPerson -> Number -> {s:Str}= \root1,root2,pol,t,p,n ->
  {s  = (mkCmnVF1 root1 root2 pol t p n).s ;
   };
  

 mkCmnVF1 : Str -> Str -> Polarity -> VTense2 -> PPerson -> Number -> {s:Str}= \root1,root2,pol,t,p,n ->
  {s = let khordh = root1 + "ه";
           nkhordh = (addN root1) + "ه" ;
           mekhor = "می" ++ root2 ;
	   nmekhor =  "نمی" ++ root2 ;
	   mekhord = "می" ++ root1 ;
	   nmekhord = "نمی" ++ root1 ;
	   mekhordh = "می" ++ khordh ;
	   nmekhordh = "نمی" ++ khordh ;
	   khah = "خواه" ;
	   nkhah = "نخواه" ;
	   mekhah = "می" ++ khah ;
	   nmekhah = "نمی" ++ khah ;
	   bvdh = "بوده"
  in
  case <pol,t,p,n> of {
    <Pos,PPresent2 PrPerf,PPers1,Sg> => khordh ++ "ام" ;  
    <Pos,PPresent2 PrPerf,PPers1,Pl> => khordh ++ "ایم" ;
    <Pos,PPresent2 PrPerf,PPers2,Sg> => khordh ++ "ای" ;
    <Pos,PPresent2 PrPerf,PPers2,Pl> => khordh ++ "اید" ;
    <Pos,PPresent2 PrPerf,PPers3,Sg> => khordh ++ "است" ;
    <Pos,PPresent2 PrPerf,PPers3,Pl> => khordh ++ "اند" ;
    
    <Pos,PPresent2 PrImperf,PPers1,Sg> => mekhor + "م" ;
    <Pos,PPresent2 PrImperf,PPers1,Pl> => mekhor + "یم" ;
    <Pos,PPresent2 PrImperf,PPers2,Sg> => mekhor + "ی" ;
    <Pos,PPresent2 PrImperf,PPers2,Pl> => mekhor + "ید" ;
    <Pos,PPresent2 PrImperf,PPers3,Sg> => mekhor + "د" ;
    <Pos,PPresent2 PrImperf,PPers3,Pl> => mekhor + "ند" ;
    
    
    <Pos,PPast2 PstPerf,PPers1,Sg> => khordh ++ "بودم" ;
    <Pos,PPast2 PstPerf,PPers1,Pl> => khordh ++ "بودیم" ;
    <Pos,PPast2 PstPerf,PPers2,Sg> => khordh ++ "بودی" ;
    <Pos,PPast2 PstPerf,PPers2,Pl> => khordh ++ "بودید" ;
    <Pos,PPast2 PstPerf,PPers3,Sg> => khordh ++ "بود" ;
    <Pos,PPast2 PstPerf,PPers3,Pl> => khordh ++ "بودند" ;
    
    <Pos,PPast2 PstImperf,PPers1,Sg> => mekhord + "م" ;
    <Pos,PPast2 PstImperf,PPers1,Pl> => mekhord + "یم" ;
    <Pos,PPast2 PstImperf,PPers2,Sg> => mekhord  + "ی";
    <Pos,PPast2 PstImperf,PPers2,Pl> => mekhord + "ید" ;
    <Pos,PPast2 PstImperf,PPers3,Sg> => mekhord ;
    <Pos,PPast2 PstImperf,PPers3,Pl> => mekhord + "ند" ;
    
    <Pos,PPast2 PstAorist,PPers1,Sg> => root1 + "م" ;
    <Pos,PPast2 PstAorist,PPers1,Pl> => root1 + "یم" ;
    <Pos,PPast2 PstAorist,PPers2,Sg> => root1  + "ی";
    <Pos,PPast2 PstAorist,PPers2,Pl> => root1 + "ید" ;
    <Pos,PPast2 PstAorist,PPers3,Sg> => root1 ;
    <Pos,PPast2 PstAorist,PPers3,Pl> => root1 + "ند" ;
    
   {- 
    <Pos,PFut2 FtImperf,PPers1,Sg> => mekhah + "م"   ++ addBh root2 + "م" ;
    <Pos,PFut2 FtImperf,PPers1,Pl> => mekhah + "یم" ++  addBh root2 + "یم" ;
    <Pos,PFut2 FtImperf,PPers2,Sg> => mekhah + "ی" ++  addBh root2 + "ی" ;
    <Pos,PFut2 FtImperf,PPers2,Pl> => mekhah + "ید" ++  addBh root2 + "ید" ;
    <Pos,PFut2 FtImperf,PPers3,Sg> => mekhah + "د" ++  addBh root2 + "د" ;
    <Pos,PFut2 FtImperf,PPers3,Pl> => mekhah + "ند" ++  addBh root2 + "ند" ;
    -}
    <Pos,PFut2 FtAorist,PPers1,Sg> => khah + "م"  ++ root1  ;
    <Pos,PFut2 FtAorist,PPers1,Pl> => khah + "یم"  ++ root1 ;
    <Pos,PFut2 Ftorist,PPers2,Sg> => khah + "ی"  ++ root1 ;
    <Pos,PFut2 FtAorist,PPers2,Pl> => khah + "ید"  ++ root1 ;
    <Pos,PFut2 FtAorist,PPers3,Sg> => khah + "د"  ++ root1 ;
    <Pos,PFut2 FtAorist,PPers3,Pl> => khah + "ند"  ++ root1  ;
    
    
    <Pos,Infr_Past2 InfrPerf,PPers1,Sg> => khordh ++ bvdh ++ "ام" ;
    <Pos,Infr_Past2 InfrPerf,PPers1,Pl> => khordh ++ bvdh ++ "ایم" ;
    <Pos,Infr_Past2 InfrPerf,PPers2,Sg> => khordh ++ bvdh ++ "ای" ;
    <Pos,Infr_Past2 InfrPerf,PPers2,Pl> => khordh ++ bvdh ++ "اید" ;
    <Pos,Infr_Past2 InfrPerf,PPers3,Sg> => khordh ++ bvdh ++ "است" ;
    <Pos,Infr_Past2 InfrPerf,PPers3,Pl> => khordh ++ bvdh ++ "اند" ;
    
    <Pos,Infr_Past2 InfrImperf,PPers1,Sg> => mekhordh ++ "ام" ;
    <Pos,Infr_Past2 InfrImperf,PPers1,Pl> => mekhordh ++ "ایم" ;
    <Pos,Infr_Past2 InfrImperf,PPers2,Sg> => mekhordh ++ "ای" ;
    <Pos,Infr_Past2 InfrImperf,PPers2,Pl> => mekhordh ++ "اید" ;
    <Pos,Infr_Past2 InfrImperf,PPers3,Sg> => mekhordh ++ "است" ;
    <Pos,Infr_Past2 InfrImperf,PPers3,Pl> => mekhordh ++ "اند" ;
    
 -- negatives
 
    <Neg,PPresent2 PrPerf,PPers1,Sg> => addN khordh ++ "ام" ;  
    <Neg,PPresent2 PrPerf,PPers1,Pl> => addN khordh ++ "ایم" ;
    <Neg,PPresent2 PrPerf,PPers2,Sg> => addN khordh ++ "ای" ;
    <Neg,PPresent2 PrPerf,PPers2,Pl> => addN khordh ++ "اید" ;
    <Neg,PPresent2 PrPerf,PPers3,Sg> => addN khordh ++ "است" ;
    <Neg,PPresent2 PrPerf,PPers3,Pl> => addN khordh ++ "اند" ;
    
    
    <Neg,PPresent2 PrImperf,PPers1,Sg> => nmekhor + "م" ;
    <Neg,PPresent2 PrImperf,PPers1,Pl> => nmekhor + "یم" ;
    <Neg,PPresent2 PrImperf,PPers2,Sg> => nmekhor + "ی" ;
    <Neg,PPresent2 PrImperf,PPers2,Pl> => nmekhor + "ید" ;
    <Neg,PPresent2 PrImperf,PPers3,Sg> => nmekhor + "د" ;
    <Neg,PPresent2 PrImperf,PPers3,Pl> => nmekhor + "ند" ;
         
    <Neg,PPast2 PstPerf,PPers1,Sg> => nkhordh ++ "بودم" ;
    <Neg,PPast2 PstPerf,PPers1,Pl> => nkhordh ++ "بودیم" ;
    <Neg,PPast2 PstPerf,PPers2,Sg> => nkhordh ++ "بودی" ;
    <Neg,PPast2 PstPerf,PPers2,Pl> => nkhordh ++ "بودید" ;
    <Neg,PPast2 PstPerf,PPers3,Sg> => nkhordh ++ "بود" ;
    <Neg,PPast2 PstPerf,PPers3,Pl> => nkhordh ++ "بودند" ;
      
    <Neg,PPast2 PstImperf,PPers1,Sg> => nmekhord + "م" ;
    <Neg,PPast2 PstImperf,PPers1,Pl> => nmekhord + "یم" ;
    <Neg,PPast2 PstImperf,PPers2,Sg> => nmekhord  + "ی";
    <Neg,PPast2 PstImperf,PPers2,Pl> => nmekhord + "ید" ;
    <Neg,PPast2 PstImperf,PPers3,Sg> => nmekhord ;
    <Neg,PPast2 PstImperf,PPers3,Pl> => nmekhord + "ند" ;
  
 
    <Neg,PPast2 PstAorist,PPers1,Sg> => addN root1 + "م" ;
    <Neg,PPast2 PstAorist,PPers1,Pl> => addN root1 + "یم" ;
    <Neg,PPast2 PstAorist,PPers2,Sg> => addN root1  + "ی";
    <Neg,PPast2 PstAorist,PPers2,Pl> => addN root1 + "ید" ;
    <Neg,PPast2 PstAorist,PPers3,Sg> => addN root1 ;
    <Neg,PPast2 PstAorist,PPers3,Pl> => addN root1 + "ند" ;
      
 {-     
    <Neg,PFut2 FtImperf,PPers1,Sg> => nmekhah + "م"   ++ addBh root2 + "م" ;
    <Neg,PFut2 FtImperf,PPers1,Pl> => nmekhah + "یم" ++  addBh root2 + "یم" ;
    <Neg,PFut2 FtImperf,PPers2,Sg> => nmekhah + "ی" ++  addBh root2 + "ی" ;
    <Neg,PFut2 FtImperf,PPers2,Pl> => nmekhah + "ید" ++  addBh root2 + "ید" ;
    <Neg,PFut2 FtImperf,PPers3,Sg> => nmekhah + "د" ++  addBh root2 + "د" ;
    <Neg,PFut2 FtImperf,PPers3,Pl> => nmekhah + "ند" ++  addBh root2 + "ند" ;
 -}   
    <Neg,PFut2 FtAorist,PPers1,Sg> => nkhah + "م"  ++ root1  ;
    <Neg,PFut2 FtAorist,PPers1,Pl> => nkhah + "یم"  ++ root1 ;
    <Neg,PFut2 Ftorist,PPers2,Sg> => nkhah + "ی"  ++ root1 ;
    <Neg,PFut2 FtAorist,PPers2,Pl> => nkhah + "ید"  ++ root1 ;
    <Neg,PFut2 FtAorist,PPers3,Sg> => nkhah + "د"  ++ root1 ;
    <Neg,PFut2 FtAorist,PPers3,Pl> => nkhah + "ند"  ++ root1  ;
    
   
    <Neg,Infr_Past2 InfrPerf,PPers1,Sg> => nkhordh ++ bvdh ++ "ام" ;
    <Neg,Infr_Past2 InfrPerf,PPers1,Pl> => nkhordh ++ bvdh ++ "ایم" ;
    <Neg,Infr_Past2 InfrPerf,PPers2,Sg> => nkhordh ++ bvdh ++ "ای" ;
    <Neg,Infr_Past2 InfrPerf,PPers2,Pl> => nkhordh ++ bvdh ++ "اید" ;
    <Neg,Infr_Past2 InfrPerf,PPers3,Sg> => nkhordh ++ bvdh ++ "است" ;
    <Neg,Infr_Past2 InfrPerf,PPers3,Pl> => nkhordh ++ bvdh ++ "اند" ;
    
    <Neg,Infr_Past2 InfrImperf,PPers1,Sg> => nmekhordh ++ "ام" ;
    <Neg,Infr_Past2 InfrImperf,PPers1,Pl> => nmekhordh ++ "ایم" ;
    <Neg,Infr_Past2 InfrImperf,PPers2,Sg> => nmekhordh ++ "ای" ;
    <Neg,Infr_Past2 InfrImperf,PPers2,Pl> => nmekhordh ++ "اید" ;
    <Neg,Infr_Past2 InfrImperf,PPers3,Sg> => nmekhordh ++ "است" ;
    <Neg,Infr_Past2 InfrImperf,PPers3,Pl> => nmekhordh ++ "اند" 
   
     
     }
     
   } ;
   
  mkvVform : Str -> Number -> PPerson -> {s: Str} = \root2,n,p ->
  {s =
    case <n,p> of {
     <Sg,PPers1> => addBh root2 + "م" ;
     <Sg,PPers2> => addBh root2 + "ی" ;
     <Sg,PPers3> => addBh root2 + "د" ;
     <Pl,PPers1> => addBh root2 + "یم" ;
     <Pl,PPers2> => addBh root2 + "ید" ;
     <Pl,PPers3> => addBh root2 + "ند" 
     }
    };

 mkimpRoot : Str -> Str ;
 mkimpRoot root =
             case root of {
                   st + "ی" => st ;
                   _        => root
                   };


addBh : Str -> Str ;
addBh str = 
            case (take 1 str) of { 
	       "ا" => "بی" + str ;  
	       "آ" => "بیا" + (drop 1 str) ;
	       _    => "ب" + str
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