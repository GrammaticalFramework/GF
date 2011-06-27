--# -path=.:../../prelude
--
-- 1 Morpholical inflection of Noun and Verbs of Nepali
--
--  by Dinesh Simkhada, Shafqat Virk - 2011
--

resource MorphoNep = ResNep ** open Prelude,Predef in {

  flags optimize=all ;
  coding = utf8;

  param 
    {-
    For distinguishing root ending in -a- and rest of other.
    Root ending in -a/अ or h - is regarded as reg and rest ireg 
    -}
    VCase = VReg | VIReg ; 
    

--1 Nouns
  oper
    
    mkN : (x1,_,_,_,_,_,_,_,_,_,_,x12 : Str) -> Gender -> NType -> NPerson -> Noun = 
      \sn,sa,si,sd,sab,sl,pn,pa,pi,pd,pab,pl,g,t,h -> {
      s = table {
      Sg => table {
        Nom => sn ;
        Acc => sa ;
        Ins => si ;
        Dat => sd ;
        Abl => sab ;
        Loc => sl
        } ;
      Pl => table {
        Nom => pn ;
        Acc => pa ;
        Ins => pi ;
        Dat => pd ;
        Abl => pab ;
        Loc => pl
        }
      } ;
      g = g ;
      t = t ;
      h = h
    } ;    

  -- TODO
  -- ?? NEED TO ADD CASE IF ENDS WITH 'o' (PG. 99 Jaya)
  
  -- Regular nouns
  mkNMF : Str -> Gender -> NType -> NPerson -> Noun ;
  mkNMF str g t h = mkN str (str + "लाई") (str + "ले") (str + "लाई") (str + "बाट") (str + "मा") 
                   (str + "हरु") (str + "हरुलाई") (str + "हरुले") (str + "हरुलाई") (str + "हरुबाट") (str + "हरुमा") g t h ;  
  
  -- Regular Nouns
  mkNReg : Str -> NType -> NPerson -> Noun ;
  mkNReg str typ hnr = mkNMF str Masc typ hnr ;
  
  -- Faminine nouns
  mkNFem : Str -> NType -> NPerson -> Noun ;
  mkNFem str typ hnr = mkNMF str Fem typ hnr ; 
  
  
  -- Uncountable nouns, which have same singular and plular form
  -- eg water
  mkNUnc : Str -> Gender -> NType -> NPerson -> Noun ;
  mkNUnc str g t h = mkN str (str + "लाई") (str + "ले") (str + "लाई") (str + "बाट") (str + "मा") 
                     str (str + "लाई") (str + "ले") (str + "लाई") (str + "बाट") (str + "मा")  g t h ;  

  -- Proper Names
  regN1 : Str -> Gender -> NType -> NPerson -> Noun ;
  regN1 str g t h = mkN str (str + "लाई") (str + "ले") (str + "लाई") (str + "बाट") (str + "मा")
                    str str str str str str g t h ;


-- pronouns
  makePron : (x1,_,_,_,_,x6 : Str) -> {s : Case => Str} = 
    \n,ac,i,d,ab,l-> { 
        s = table {
              Nom => n ;
              Acc => ac ;
              Ins => i ;
              Dat => d ;
              Abl => ab ;
              Loc => l
            }
        } ;
    
  makePronReg : Str -> {s : Case => Str} ;
  makePronReg str = makePron str (str + "लाई") (str + "ले") (str + "लाई") (str + "बाट") (str + "मा") ;

--2. Derminers  
  makeDet : Str -> Str -> Str -> Str -> Number -> Determiner = 
   \s1,s2,s3, s4, n -> {
     s = table {
         Sg => table { Masc => s1 ;
                       Fem  => s2 } ;
         Pl => table { Masc => s3 ;
                       Fem  => s4 }
	     }  ;
      n = n
	} ;	

-- maIdetn helper    
  makeIDet : Str -> Str -> {s : Gender => Str} = 
    \s1,s2 -> {
      s = table {
          Masc => s1 ;
		  Fem  => s2
	      } 
     } ;

-- Quantifiers
  makeQuant : Str -> Str -> Str -> Str -> {s : Number => Gender => Str } =
   \sm,sf,pm,pf -> {
    s = table { 
        Sg => table { Masc => sm ;
                      Fem  => sf } ;
	    Pl => table { Masc => pm ;
                      Fem  => pf }
	    }
    } ; 
    
-- Proposition     
  makePrep : Str -> Preposition = \str -> {s = str } **  { lock_Prep = <>};

  
--3. Verbs
  mkVerb : (_: Str) -> Verb = \inf ->
   let root  = (tk 2 inf) ; 
   
    in { 
     s = table {
         Root     => root ;
         Inf      => inf ;
         PVForm   => (tk 1 inf) ;
         Imp      => (mkImpForm root).s ;
         ProgRoot aspect number gender => (mkProgRoot root aspect number gender).s ;

         VF tense aspect polarity person number gender => 
            case aspect of {
                 Imperf => (mkVImperf root tense polarity person number gender).s ;
                 Perf   => (mkVPerf root tense polarity person number gender).s
            }
          }
       } ;
  
  --For the case of lets (lets sleep)
  mkImpForm : Str -> {s:Str} ;
  mkImpForm str =
   let vcase = (rootCheck str).vcase;
       root2 = (rootCheck str).root2
    in { 
     s = case vcase of {
         VReg => root2 + "ौँ" ;
         _    => root2 + "आँ"
      };
    };
    
  
  --For the progressive root case
  mkProgRoot : Str -> Aspect -> Number -> Gender -> {s : Str } = 
   \root,aspect,number,gender -> 
    let root1 = (rootCheck root).root1 ;
        root2 = (rootCheck root).root2 ;
        vcase = (rootCheck root).vcase
     in {
      s= case <vcase,root> of {
        <VReg, _> => (mkProgReg  root2 aspect number gender).s ;
        <_, "जा"> => (mkProgIReg root  aspect number gender).s ;
        <_, "हा"> => (mkProgIReg root  aspect number gender).s ;
        <_,    _> => (mkProgIReg root2 aspect number gender).s 
        };
      };
   
   
   mkProgReg : Str -> Aspect -> Number -> Gender -> {s : Str } =
     \root2,aspect,number,gender -> {
      s = case <aspect,number,gender> of {
        <Imperf, _,    _> => root2 + "दै" ;
       
        <Perf,  Sg, Masc> => root2 + "िरहेको" ;
        <Perf,  Sg, Fem>  => root2 + "िरहेकि" ;
        <Perf,  Pl,    _> => root2 + "िरहेका"
        };
      };
    
   
   mkProgIReg : Str -> Aspect -> Number -> Gender -> {s : Str } =
     \root,aspect,number,gender -> {
      s = case <aspect,number,gender> of {
        <Imperf, _,    _> => root + "दै" ;
       
        <Perf,  Sg, Masc> => root + "इरहेको" ;
        <Perf,  Sg, Fem>  => root + "इरहेकि" ;
        <Perf,  Pl,    _> => root + "इरहेका" 
        };
      } ;       
       
   --need to check for want_VV <- Not inflected correctly
   rootCheck : Str -> {root1:Str; root2:Str; vcase: VCase} = 
     \root -> {
     {-
     Root inflection case
     1. irregular case of Janu/जानु/go 
     root = जा     root1 = जान्       root2 = ग     
     
     2. irregular case of Hunu/हुनु/Become 
     root = हु     root1 = हुन्       root2 = भ
     
     3. reg Verbs ending in Consonants - पढनु/to study
     root = पढ्,     root1 = पढ   root2 = पढ् <- original
     root = पढ्,     root1 = पढ्,  root2 = पढ <- changed to this
                                         make sure it doesn't break
     
     4. Khanu/खानु/to eat, Dinu/दिनु /to Give
     root = खा      root1 = खान्     root2 = खा
     
     5. Dhunu/धुनु/wash, Runu/रुनु/Cry
     root = धु       root1 = धुन्      root2 = धो     
     
     6. Aaunu/आउनु/to Come, Pathaunu/पठाउनु/to Send
     root = आउ    root1 = आउँ     root2 = आ        
     -}
     
    root1 = case root of {
          "जा"                => root + "न्" ;
          "हु"                => root + "न्" ;
          rot + "्"          => root ;
          rot + ("ह")         => root + "न्" ; --cmnt
          rot + ("ा"|"ि"|"ी") => root + "न्" ;
          rot + ("े"|"ु"|"ू") => root + "न्" ;
          rot + ("उ"|"ऊ")     => root + "ँ" ;
          _                   => root
        } ; 
    root2 = case root of {
          "जा"                => "ग" ;
          "हु"                => "भ" ;
          rot + "्"          => rot ;
          rot + ("ा"|"ि"|"ी") => root ;
          rot + ("ह")         => root + "न्" ; --cmnt
          rot + ("े"|"ु"|"ू") => rot + "ो" ;
          rot + ("उ"|"ऊ")     => rot ;
          _                   => root
        } ; 
    vcase = case root of {
          rot + "्" => VReg;   
          --rot + "ह"  => VReg;   
          _          => VIReg
        }
    } ;

   mkVImperf : Str -> VTense -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, t, po, pn, n, g ->
       let root1 = (rootCheck root).root1 ;
           root2 = (rootCheck root).root2 ;
           vcase = (rootCheck root).vcase ;
        in
        {s = case t of {
             NPresent       => (mkVPreNP  root root1 vcase po pn n g).s ;
             NPast Simpl    => (mkVPstSNP root root2 vcase po pn n g).s ;
             NPast Hab      => (mkVPstHNP root root1 vcase po pn n g).s ;
             --NPast Unknown  => (mkVPstUNP root root2 vcase po pn n g).s ;
             NFuture Defin  => (mkVFutDNP root po pn n g).s ;
             NFuture NDefin => (mkVFutNDNP root root2 vcase po pn n g).s 
            } 
         } ;

 
   mkVPerf : Str -> VTense -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, t, po, pn, n, g ->
       let root1 = (rootCheck root).root1 ;
           root2 = (rootCheck root).root2 ;
           vcase = (rootCheck root).vcase ;
        in
        {s = case t of {
             --it seems root has no use in these cases, root2 worsk for all
             --if no problem arises better to remove root parameter
             NPresent       => (mkVPreP  root root2 vcase po pn n g).s ;
             NPast Simpl    => (mkVPstSP root root2 vcase po pn n g).s ;
             NPast Hab      => (mkVPstHP root root2 vcase po pn n g).s ;
             --NPast Unknown  => (mkVPstUP root root2 vcase po pn n g).s ;             
             NFuture Defin  => (mkVFutDefP root root2 vcase po pn n g).s ;
             NFuture NDefin => (mkVFutNDefP root root2 vcase po pn n g).s         
            }
         };
  
 
-- Present, Nonperfective aspect, Non-progressive mode, 
   mkVPreNP : Str -> Str -> VCase -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root1, vc, po, pn, n, g ->
      {s = case vc of {
           VReg  => (mkVPreNPReg root po pn n g).s ;
           VIReg => (mkVPreNPIReg root root1 po pn n g).s
           }
        } ;
  
   -- mkVPreNP Helper for VRrg case
   mkVPreNPReg : Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, po, pn, n, g ->
      {s = case <po, pn, n, g> of { 
          -- Positive case
          <Pos, Pers1,    Sg,    _> => root + "छु" ;   -- छु 
          <Pos, Pers1,    Pl,    _> => root + "छौँ" ;   -- छौं      
          <Pos, Pers2_L,  Sg, Masc> => root + "छस्" ; -- छस्
          <Pos, Pers2_L,  Sg, Fem>  => root + "छेस्" ; -- छेस्      
          <Pos, Pers2_L,  Pl,   _>  => root + "छौ" ;    -- छौ 
          <Pos, Pers2_M,  Sg, Fem>  => root + "छ्यौ" ;  -- छ्यौ
          <Pos, Pers2_M,  _ ,   _>  => root + "छौ" ;    -- छौ          
          <Pos, Pers3_L,  Sg, Masc> => root + "छ" ;  -- छ
          <Pos, Pers3_L,  Sg, Fem>  => root + "छे" ;  -- छे
          <Pos, Pers3_L,  Pl,   _>  => root + "छन्" ;  -- छन्      
          <Pos, Pers3_M,  Sg, Fem>  => root + "छिन्" ;  -- छिन्
          <Pos, Pers3_M,  _,    _>  => root + "छन्" ;  -- छन्      
          <Pos,      _ ,  _,    _>  => root + "नुहुन्छ" ; -- नुहुन्छ
          
          -- Negative Case
          <Neg, Pers1,    Sg,    _> => root + "दिनँ" ;  -- इनँ (पढ्दिनँ)
          <Neg, Pers1,    Pl,    _> => root + "दैनैँ" ;   -- ऐनैँ (पढ्दैनैँ)
          <Neg, Pers2_L,  Sg, Masc> => root + "दैनस्" ; -- ऐनस् (पढदैनस्)
          <Neg, Pers2_L,  Sg, Fem>  => root + "दिनस्" ; -- इनस् (पढदिनस्) 
          <Neg, Pers2_L,  Pl,   _>  => root + "दैनै" ; -- ऐनै 
          <Neg, Pers2_M,  Sg, Fem>  => root + "दिनै" ; -- इनै
          <Neg, Pers2_M,  _ ,   _>  => root + "दैनै" ; -- ऐनै           
          <Neg, Pers3_L,  Sg, Masc> => root + "दैन" ;  -- ऐन
          <Neg, Pers3_L,  Sg, Fem>  => root + "दिन" ;  -- इन
          <Neg, Pers3_L,  Pl,   _>  => root + "दैन्न" ;  -- ऐनन्
          <Neg, Pers3_M,  Sg, Fem>  => root + "दिन्न" ;  -- इनन्
          <Neg, Pers3_M,  _,    _>  => root + "दैन्न" ;  -- ऐनन्
          <Neg,      _ ,  _,    _>  => root + "नुहुन्न" -- नुहुन्न
          }
     } ;          
   
   -- mkVPreNP Helper for VIRrg case
   mkVPreNPIReg : Str -> Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
    \root, root1, po, pn, n, g ->
     {s = case <po, pn, n, g> of { 
          -- Positive case
          <Pos, Pers1,    Sg,    _> => root1 + "छु" ;   -- छु 
          <Pos, Pers1,    Pl,    _> => root1 + "छौं" ;   -- छौं      
          <Pos, Pers2_L,  Sg, Masc> => root1 + "छस्" ; -- छस्
          <Pos, Pers2_L,  Sg, Fem>  => root1 + "छेस्" ; -- छेस्      
          <Pos, Pers2_L,  Pl,   _>  => root1 + "छौ" ;    -- छौ 
          <Pos, Pers2_M,  Pl, Fem>  => root1 + "छ्यौ" ;  -- छ्यौ
          <Pos, Pers2_M,  _ ,   _>  => root1 + "छौ" ;    -- छौ      
          <Pos, Pers3_L,  Sg, Masc> => root1 + "छ" ;  -- छ
          <Pos, Pers3_L,  Sg, Fem>  => root1 + "छे" ;  -- छे
          <Pos, Pers3_L,  Pl,   _>  => root1 + "छन्" ;  -- छन्      
          <Pos, Pers3_M,  Sg, Fem>  => root1 + "छिन्" ;  -- छिन्
          <Pos, Pers3_M,  _,    _>  => root1 + "छन्" ;  -- छन्      
          <Pos,      _ ,  _,    _>  => root + "नुहुन्छ" ; -- नुहुन्छ
          
          -- Negative Case
          <Neg, Pers1,    Sg,    _> => root + "ँदिनँ" ;  -- इनँ (खाँदिनँ)
          <Neg, Pers1,    Pl,    _> => root + "ँदैनैँ" ;  -- ऐनैँ (खाँदैनैँ)
          <Neg, Pers2_L,  Sg, Masc> => root + "ँदैनस्" ; -- ऐनस्  (आउँदैनस्)
          <Neg, Pers2_L,  Sg, Fem>  => root + "ँदिनस्" ; -- इनस् (खाँदिनस्) 
          <Neg, Pers2_L,  Pl,   _>  => root + "ँदैनै" ; -- ऐनै  (खाँदैनै)
          <Neg, Pers2_M,  Sg, Fem>  => root + "ँदिनै" ; -- इनै
          <Neg, Pers2_M,  _ ,   _>  => root + "ँदैनै" ; -- ऐनै           
          <Neg, Pers3_L,  Sg, Masc> => root + "ँदैन" ;  -- ऐन
          <Neg, Pers3_L,  Sg, Fem>  => root + "ँदिन" ;  -- इन (खाँदिन)
          <Neg, Pers3_L,  Pl,   _>  => root + "ँदैन्न" ;  -- ऐनन्
          <Neg, Pers3_M,  Sg, Fem>  => root + "ँदिन्न" ;  -- इनन्
          <Neg, Pers3_M,  _,    _>  => root + "ँदैन्न" ;  -- ऐनन्
          <Neg,      _ ,  _,    _>  => root + "ँनुहुन्‍न" -- नुहुन्‍न
          }
     } ;
  
  
   
-- Past Simple, Nonprogressive mode, nonperfective aspect
   mkVPstSNP : Str -> Str -> VCase -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root2, vc, po, pn, n, g ->
      {s = case vc of {
           VReg  => (mkVPstSNPReg root root2 po pn n g).s ;
           VIReg => (mkVPstSNPIReg root root2 po pn n g).s
           }
        } ;         
         
   -- mkVPstSNP Helper for VRrg case
   mkVPstSNPReg : Str -> Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root2, po, pn, n, g ->
      {s = case <po, pn, n, g> of {   
           -- Positive case
           <Pos, Pers1,    Sg,   _>  => root2 + "ेँ" ; -- एँ
           <Pos, Pers1,    Pl,   _>  => root  + "यौं" ; -- यौं
           <Pos, Pers2_L,  Sg,   _>  => root2 + "िस्" ; -- इस्
           <Pos, Pers2_L,  Pl,   _>  => root  + "यौ" ; -- यौ
           <Pos, Pers2_M,   _,   _>  => root  + "यौ" ; -- यौ             
           <Pos, Pers3_L,  Sg, Masc> => root  + "यो" ; -- यो
           <Pos, Pers3_L,  Sg, Fem>  => root2 + "ी" ; -- इ (पढी)
           <Pos, Pers3_L,  Pl,   _>  => root2 + "े" ; -- ए (पढे)     
           <Pos, Pers3_M,  Sg, Fem>  => root2 + "िन्" ; -- इन् (पढिन्)
           <Pos, Pers3_M,   _,   _>  => root2 + "े" ; -- ए (पढे)     
           <Pos,       _,   _,   _>  => root  + "नुभयो" ; -- नुभयो
          
           -- Negative case
           <Neg, Pers1,    Sg,   _>  => root2 + "िनँ" ; -- इनँ
           <Neg, Pers1,    Pl,   _>  => root2 + "ेनैँ" ; -- एनैँ
           <Neg, Pers2_L,  Sg,   _>  => root2 + "िनस्" ; -- इनस्
           <Neg, Pers2_L,  Pl,   _>  => root2 + "ेनै" ; -- एनै
           <Neg, Pers2_M,  Sg, Fem>  => root2 + "िनै" ; -- इनै    
           <Neg, Pers2_M,   _,   _>  => root2 + "ेनै" ; -- एनै             
           <Neg, Pers3_L,  Sg, Masc> => root2 + "ेन" ; -- एन
           <Neg, Pers3_L,  Sg, Fem>  => root2 + "िन" ; -- इन (पढिन)
           <Neg, Pers3_L,  Pl,   _>  => root2 + "ेनन्" ; -- एनन् (पढेनन्)     
           <Neg, Pers3_M,  Sg, Fem>  => root2 + "िनन्" ; -- इनन् (पढिनन्)
           <Neg, Pers3_M,   _,   _>  => root2 + "ेनन्" ; -- एनन् (पढेनन्)     
           <Neg,       _,   _,   _>  => root  + "नुभएन" -- नुभएन
           } 
      } ;
  
   -- mkVPstSNP Helper for VIRrg case
   mkVPstSNPIReg : Str -> Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root2, po, pn, n, g ->
      {s = case <po, pn, n, g> of {   
           -- Positive case
           <Pos, Pers1,    Sg,   _>  => root2 + "एँ" ; -- एँ
           <Pos, Pers1,    Pl,   _>  => root2 + "यौं" ; -- यौं
           <Pos, Pers2_L,  Sg,   _>  => root2 + "इस्" ; -- इस्
           <Pos, Pers2_L,  Pl,   _>  => root2 + "यौ" ; -- यौ
           <Pos, Pers2_M,   _,   _>  => root2 + "यौ" ; -- यौ      
           <Pos, Pers3_L,  Sg, Masc> => root2 + "यो" ; -- यो
           <Pos, Pers3_L,  Sg, Fem>  => root2 + "ई" ; -- ई 
           <Pos, Pers3_L,  Pl,   _>  => root2 + "ए" ; -- ए   
           <Pos, Pers3_M,  Sg, Fem>  => root2 + "इन्" ; -- इन्
           <Pos, Pers3_M,   _,   _>  => root2 + "ए" ; -- ए   
           <Pos,       _,   _,   _>  => root  + "नुभयो" ; -- नुभयो
          
           -- Negative case
           <Neg, Pers1,    Sg,   _>  => root2 + "इनँ" ; -- इनँ
           <Neg, Pers1,    Pl,   _>  => root2 + "एनैँ" ; -- एनैँ
           <Neg, Pers2_L,  Sg,   _>  => root2 + "इनस्" ; -- इनस्
           <Neg, Pers2_L,  Pl,   _>  => root2 + "एनै" ; -- एनै
           <Neg, Pers2_M,  Sg, Fem>  => root2 + "इनै" ; -- इनै    
           <Neg, Pers2_M,   _,   _>  => root2 + "एनै" ; -- एनै             
           <Neg, Pers3_L,  Sg, Masc> => root2 + "एन" ; -- एन
           <Neg, Pers3_L,  Sg, Fem>  => root2 + "इन" ; -- इन (पढिन)
           <Neg, Pers3_L,  Pl,   _>  => root2 + "एनन्" ; -- एनन् (पढेनन्)     
           <Neg, Pers3_M,  Sg, Fem>  => root2 + "इनन्" ; -- इनन् (पढिनन्)
           <Neg, Pers3_M,   _,   _>  => root2 + "एनन्" ; -- एनन् (पढेनन्)     
           <Neg,       _,   _,   _>  => root  + "नुभएन" -- नुभएन          
           } 
      } ;
  

-- Past Habitual, Nonprogressive mode, nonperfective aspect  
   mkVPstHNP : Str -> Str -> VCase -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root1, vc, po, pn, n, g ->
      {s = case vc of {
           VReg  => (mkVPstHNPGen root root1 po pn n g).s ;
           VIReg => (mkVPstHNPGen root1 root po pn n g).s
           }
        } ;        
        
   -- mkVPstHNP helper, handles bith VReg and VIReg cases
   mkVPstHNPGen : Str -> Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root1, po, pn, n, g ->
      let neg = "दैन" ; -- दैन    (TODO : CHECK FOR MAKE GENERIC FINCTION FOR POS AND NEG)
      in
      {s = case <po, pn, n, g> of {
          <Pos, Pers1,   Sg,    _> => root + "थें" ; -- थें
          <Pos, Pers1,   Pl,    _> => root + "थ्यौं" ; -- थ्यौं
          <Pos, Pers2_L, Sg,    _> => root + "थिस्" ; -- थिस्
          <Pos, Pers2_L, Pl,    _> => root + "थ्यौ" ; -- थ्यौ
          <Pos, Pers2_M,  _,    _> => root + "थ्यौ" ; -- थ्यौ
          <Pos, Pers3_L, Sg, Masc> => root + "थ्यो" ; -- थ्यो
          <Pos, Pers3_L, Sg, Fem>  => root + "थी" ; -- थी
          <Pos, Pers3_L, Pl,   _>  => root + "थे" ; -- थे
          <Pos, Pers3_M, Sg, Fem>  => root + "थिन्" ; -- थिन्
          <Pos, Pers3_M,  _,   _>  => root + "थे" ; -- थे          
          <Pos,       _,  _,   _>  => root1 + "नुहुन्‌थ्यो" ; -- नुहुन्‌थ्यो
          
          <Neg, Pers1,   Sg,    _> => root + neg + "थें" ; -- थें
          <Neg, Pers1,   Pl,    _> => root + neg + "थ्यौं" ; -- थ्यौं
          <Neg, Pers2_L, Sg,    _> => root + neg + "थिस्" ; -- थिस्
          <Neg, Pers2_L, Pl,    _> => root + neg + "थ्यौ" ; -- थ्यौ
          <Neg, Pers2_M,  _,    _> => root + neg + "थ्यौ" ; -- थ्यौ
          <Neg, Pers3_L, Sg, Masc> => root + neg + "थ्यो" ; -- थ्यो
          <Neg, Pers3_L, Sg, Fem>  => root + neg + "थी" ; -- थी
          <Neg, Pers3_L, Pl,   _>  => root + neg + "थे" ; -- थे
          <Neg, Pers3_M, Sg, Fem>  => root + neg + "थीन्" ; -- थिन्
          <Neg, Pers3_M,  _,   _>  => root + neg + "थे" ; -- थे          
          <Neg,       _,  _,   _>  => root1 + "नुहुँदैनथ्यो" -- नुहुँदैनथ्यो
          }
      };
   
{-
-- Past Unknown, Nonprogressive mode, nonperfective aspect     
   mkVPstUNP : Str -> Str -> VCase -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \ root, root2, vc, po, p, n, g -> 
      {s = case vc of {
           VReg  => case po of {
                    Pos => (mkVPstUNPReg root root2 ""  p n g).s ;
                    Neg => (mkVPstUNPReg root root2 "न" p n g).s 
                    } ;
           VIReg => case po of {
                    Pos => (mkVPstUNPIReg root root2 ""  p n g).s ;
                    Neg => (mkVPstUNPIReg root root2 "न" p n g).s 
                    }
           }
      };

   -- mkVPstUNP helper for VReg case
   mkVPstUNPReg : Str -> Str -> Str -> NPerson -> Number -> Gender -> {s:Str} = 
      \root, root2, na, pn, nu, g ->
      {s = case <pn, nu, g> of {
          <Pers1,   Sg, Masc> => root2  + "े" + na + "छु" ; -- एछु
          <Pers1,   Sg, Fem>  => root2  + "ि" + na + "छु" ; -- इछु
          <Pers1,   Pl,    _> => root2  + "े" + na + "छौँ" ; -- एछौँ
          <Pers2_L, Sg, Masc> => root2  + "े" + na + "छस्" ; -- एछस्
          <Pers2_L, Sg, Fem>  => root2  + "ि" + na + "छस्" ; -- इछस्
          <Pers2_L, Pl,    _> => root2  + "े" + na + "छौ" ; -- एछौ                    
          <Pers2_M, Sg, Fem>  => root2  + "ि" + na + "छौ" ; -- इछौ
          <Pers2_M,  _,    _> => root2  + "े" + na + "छौ" ; -- एछौ               
          <Pers3_L, Sg, Masc> => root2  + "े" + na + "छ" ; -- एछ
          <Pers3_L, Sg, Fem>  => root2  + "ि" + na + "छ" ; -- इछ
          <Pers3_L, Pl,   _>  => root2  + "े" + na + "छन्" ; -- एछन्
          <Pers3_M, Sg, Fem>  => root2  + "ि" + na + "छन्" ; -- इछन्
          <Pers3_M,  _,   _>  => root2  + "े" + na + "छन्" ; -- एछन्
          <      _,  _,   _>  => root   + "नुभए" + na +"छ" -- नुभएछ
        }
      } ;
   
   
   -- mkVPstUNP helper for VIReg case
   mkVPstUNPIReg : Str -> Str -> Str -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root2, na, pn, nu, g -> 
      {s = case <pn, nu, g> of {
           <Pers1,   Sg, Masc> => root2 + "ए" + na + "छु" ; -- एछु
           <Pers1,   Sg, Fem>  => root2 + "इ" + na + "छु" ; -- इछु
           <Pers1,   Pl,    _> => root2 + "ए" + na + "छौँ" ; -- एछौँ
           <Pers2_L, Sg, Masc> => root2 + "ए" + na + "छस्" ; -- एछस्
           <Pers2_L, Sg, Fem>  => root2 + "इ" + na + "छस्" ; -- इछस्
           <Pers2_L, Pl,    _> => root2 + "ए" + na + "छौ" ; -- एछौ                    
           <Pers2_M, Sg, Fem>  => root2 + "इ" + na + "छौ" ; -- इछौ
           <Pers2_M,  _,    _> => root2 + "ए" + na + "छौ" ; -- एछौ        
          
           <Pers3_L, Sg, Masc> => root2 + "ए" + na + "छ" ; -- एछ
           <Pers3_L, Sg, Fem>  => root2 + "इ" + na + "छ" ; -- इछ
           <Pers3_L, Pl,   _>  => root2 + "ए" + na + "छन्" ; -- एछन्
           <Pers3_M, Sg, fem>  => root2 + "इ" + na + "छन्" ; -- इछन्
           <Pers3_M,  _,   _>  => root2 + "ए" + na + "छन्" ; -- एछन्
           <      _,  _,   _>  => root  + "नुभए" + na +"छ" -- नुभएनछ
           }
     } ;
-}     

-- Future Definitive, Nonprogressive mode, nonperfective aspect
   -- Handles Both cases
   mkVFutDNP : Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, po, pn, n, g ->
      {s = case <po, pn, n, g> of { 
          -- Positive case
          <Pos, Pers1,    Sg,   _>  => root + "नेछु" ; -- नेछु
          <Pos, Pers1,    Pl,   _>  => root + "नेछौं" ; -- नेछौं      
          <Pos, Pers2_L,  Sg,   _>  => root + "नेछस्" ; -- नेछस्
          <Pos, Pers2_L,  Pl,   _>  => root + "नेछौं" ; -- नेछौ
          <Pos, Pers2_M,   _,   _>  => root + "नेछौं" ; -- नेछौ               
          <Pos, Pers3_L,  Sg,   _>  => root + "नेछ" ; -- नेछ
          <Pos, Pers3_L,  Pl,   _>  => root + "नेछन्" ; -- नेछन्      
          <Pos, Pers3_M,   _, Masc> => root + "नेछन्" ; -- नेछन्
          <Pos, Pers3_M,  Sg, Fem>  => root + "नेछिन्" ; -- नेछिन्      
          <Pos, Pers3_M,  Pl, Fem>  => root + "नेछिन्" ; -- नेछन्            
          <Pos,       _,   _,   _>  => root + "नुहुनेछ" ; -- नुहुनेछ      
          
          -- Negative Case
          <Neg, Pers1,    Sg,   _>  => root + "नेछैन" ; -- नेछैन
          <Neg, Pers1,    Pl,   _>  => root + "नेछैनैँ" ; -- नेछैनैँ
          <Neg, Pers2_L,  Sg,   _>  => root + "नेछैनस्" ; -- नेछैनस्
          <Neg, Pers2_L,  Pl,   _>  => root + "नेछैनै" ; -- नेछैनै
          <Neg, Pers2_M,   _,   _>  => root + "नेछैनै" ; -- नेछैनै           
          <Neg, Pers3_L,  Sg,   _>  => root + "नेछैन्" ; -- नेछैन्
          <Neg, Pers3_L,  Pl,   _>  => root + "नेछैनन्" ; -- नेछैनन्
          <Neg, Pers3_M,  Sg,   _>  => root + "नेछैनन्" ; -- नेछैनन्          
          <Neg, Pers3_M,  Pl,   _>  => root + "नेछैनै" ; -- नेछैनै
          <Neg,       _,   _,   _>  => root + "नुहुनेछैन्" -- नुहुनेछैन्
          }
     } ;
          
 
-- Future Nondefinitive, Nonperfective aspect, NonPregressive mode
   mkVFutNDNP : Str -> Str -> VCase -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root2, vc, po, pn, n, g ->
      {s = case vc of {
           VReg  => (mkVFutNDNPReg root root2 po pn n g).s ;
           VIReg => (mkVFutNDNPIReg root2 po pn n g).s
           }
      } ;
   
   -- mkVFutNDNP helper for VReg case
   mkVFutNDNPReg : Str -> Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root2, po, pn, n, g ->
      {s = case <po, pn, n, g> of {
          <Pos, Pers1,   Sg,    _> => root2 + "ुँला" ; -- उँला 
          <Pos, Pers1,   Pl,    _> => root2 + "ौँला" ; -- आँला
          <Pos, Pers2_L, Sg, Masc> => root  + "‍लास्" ; -- लास् 
          <Pos, Pers2_L, Sg, Fem>  => root  + "लीस्" ; -- लिस्
          <Pos, Pers2_L, Pl,    _> => root2 + "ौला" ; -- औला 
          <Pos, Pers2_M, Pl,  Fem> => root2 + "ौलि" ; -- औलि 
          <Pos, Pers3_L, Sg, Masc> => root  + "ला" ; -- ला
          <Pos, Pers3_L, Sg, Fem>  => root  + "ली" ; -- ली
          <Pos, Pers3_L, Pl,   _>  => root  + "लान्" ; -- लान्
          <Pos, Pers3_M, Sg, Fem>  => root  + "लीन्" ; -- लिन्
          <Pos, Pers3_M,  _,   _>  => root  + "लान्" ; -- लान्
          <Pos,       _,  _,   _>  => root  + "‍नुहोला" ; -- नुहोला
          
          -- TODO : NOT CLEAR DEFINITION IN BOOK
          <Neg,       _,  _,   _>  => "टुडु" 
        }
      } ;
 
   -- mkVFutNDNP helper for VIReg case
   mkVFutNDNPIReg : Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, po, pn, n, g ->
      {s = case <po, pn, n, g> of {
           <Pos, Pers1,   Sg,    _> => root + "उँला" ; -- उँला
           <Pos, Pers1,   Pl,    _> => root + "औँला" ; -- आँला
           <Pos, Pers2_L, Sg, Masc> => root + "लास्" ; -- लास्
           <Pos, Pers2_L, Sg, Fem>  => root + "लिस्" ; -- लिस् 
           <Pos, Pers2_L, Pl,    _> => root + "औला" ; -- औला 
           <Pos, Pers2_M, Pl,  Fem> => root + "औलि" ; -- औलि 
           <Pos, Pers3_L, Sg, Masc> => root + "ला" ; -- ला
           <Pos, Pers3_L, Sg, Fem>  => root + "ली" ; -- ली
           <Pos, Pers3_L, Pl,   _>  => root + "लान्" ; -- लान्
           <Pos, Pers3_M, Sg, Fem>  => root + "लिन्" ; -- लिन्
           <Pos, Pers3_M,  _,   _>  => root + "लान्" ; -- लान्
           <Pos,       _,  _,   _>  => root + "नुहोला" ; -- नुहोला
           
           -- TODO : NOT CLEAR DEFINITION IN BOOK
           <Neg,       _,  _,   _>  => "टुडु" 
           }
        } ;
   


-- Past Simple, Perfective aspect, Nonprogressive Mode
   mkVPstSP : Str -> Str -> VCase -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root2, vc, po, pn, n, g ->
      {s = case vc of {
           VReg  => (mkVPstSPGen root2 "ेको"  "ेकि"  "ेका" po pn n g).s ;
           VIReg => (mkVPstSPGen root2 "एको" "एकि" "एका" po pn n g).s
           }
      } ;
   
   -- mkVPstSP Helper handles both VReg and VIreg cases
   mkVPstSPGen : Str -> Str -> Str -> Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
      \root, sreg, sfem, spl, po, pn, n, g ->
      {s = case <po, pn, n, g> of {
          -- Positive case
          <Pos, Pers1,   Sg,    _> => root + sreg + "थिएँ" ; -- थिएँ
          <Pos, Pers1,   Pl,    _> => root + spl + "थियौँ" ; -- थियौँ          
          <Pos, Pers2_L, Sg, Masc> => root + sreg + "थिइस्" ; -- थिइस्
          <Pos, Pers2_L, Sg, Fem>  => root + sfem + "थिइस्" ; -- थिइस्
          <Pos, Pers2_L, Pl,    _> => root + spl + "थियौ" ; -- थियौ
          <Pos, Pers2_M,  _,    _> => root + spl + "थियौ" ; -- थियौ          
          <Pos, Pers3_L, Sg, Masc> => root + sreg + "थियो" ; -- थियो
          <Pos, Pers3_L, Sg, Fem>  => root + sfem + "थिई" ; --थिई
          <Pos, Pers3_L, Pl,   _>  => root + spl + "थिए" ; -- थिए
          <Pos, Pers3_M, Sg, Fem>  => root + sfem + "थिइन्" ; -- थिइन्
          <Pos, Pers3_M,  _,   _>  => root + spl + "थिए" ; -- थिए
          <Pos,       _,  _,   _>  => root + sreg + "हुनुहुन्‌थ्यो" ; -- हुनुहुन्‌थ्यो (TODO: CONFIRM CORRECT)
          
          -- Negative case
          <Neg, Pers1,   Sg,    _> => root + sreg +"थिइनँ" ; -- 
          <Neg, Pers1,   Pl,    _> => root + spl + "थिएनैँ" ; --
          
          <Neg, Pers2_L, Sg, Masc> => root + sreg + "थिइनस्" ; -- 
          <Neg, Pers2_L, Sg, Fem>  => root + sfem + "थिइनस्" ; -- 
          <Neg, Pers2_L, Pl,    _> => root + spl + "थिएनै" ; -- 
          <Neg, Pers2_M,  _,    _> => root + spl + "थिनै" ; -- 
          
          <Neg, Pers3_L, Sg, Masc> => root + sreg + "थिएन" ; -- 
          <Neg, Pers3_L, Sg, Fem>  => root + sfem + "थिइङ" ; --
          <Neg, Pers3_L, Pl,   _>  => root + spl + "थिएनन्" ; -- 
          <Neg, Pers3_M, Sg, Fem>  => root + sfem + "थिइनन्" ; -- 
          <Neg, Pers3_M,  _,   _>  => root + spl + "थिएनन्" ; -- 
          <Neg,       _,  _,   _>  => root + sreg + "हुनुहुन्‌नथ्यो" -- हुनुहुन्‌नथ्यो (TODO: CONFIRM CORRECT)
        }
      };
   
   
-- Past Habitual, Perfective aspect, Nonprogressive Mode
   mkVPstHP : Str -> Str -> VCase -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root2, vc, po, pn, n, g ->
      {s = case vc of {
           VReg  => (mkVPstHPGen root2 "ेको"  "ेकि"  "ेका"  po pn n g).s ;
           VIReg => (mkVPstHPGen root2 "एको" "एकि" "एका" po pn n g).s
           }
        } ;
   
   -- mkVPstSP Helper handles both VReg and VIreg cases
   mkVPstHPGen : Str -> Str -> Str -> Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
      \root, sreg, sfem, spl, po, pn, n, g ->
      {s = case <po, pn, n, g> of {
          <Pos, Pers1,   Sg,    _> => root + sreg + "हुन्थेँ" ; -- हुन्थेँ
          <Pos, Pers1,   Pl,    _> => root + spl + "हुन्थौँ" ; -- हुन्थौँ          
          <Pos, Pers2_L, Sg, Masc> => root + sreg + "हुन्थिस्" ; -- हुन्थिस् 
          <Pos, Pers2_L, Sg, Fem>  => root + sfem + "हुन्थइस्" ; -- हुन्थिस् 
          <Pos, Pers2_L, Pl,    _> => root + spl + "हुन्थ्यौ" ; -- हुन्थ्यौ 
          <Pos, Pers2_M,  _,    _> => root + spl + "हुन्थ्यौ" ; -- हुन्थ्यौ           
          <Pos, Pers3_L, Sg, Masc> => root + sreg + "हुन्‌थ्यौ" ; -- हुन्‌थ्यौ
          <Pos, Pers3_L, Sg, Fem>  => root + sfem + "हुन्थी" ; -- हुन्थी
          <Pos, Pers3_L, Pl,   _>  => root + spl + "हुन्थे" ; -- हुन्थे  
          <Pos, Pers3_M, Sg, Fem>  => root + sfem + "हुन्‌थि" ; -- हुन्थि
          <Pos, Pers3_M,  _,   _>  => root + spl + "हुन्थे" ; -- हुन्थे 
          <Pos,       _,  _,   _>  => root + sreg + "हुनुहुन्थ्यो" ; -- (TODO : हुनुहुन्थ्यो need to Confirm)
          
          -- Negative case (TODO)        
          <Neg, Pers1,   Sg,    _> => root + sreg + "हुन्थेँ" ; -- हुन्थेँ
          <Neg, Pers1,   Pl,    _> => root + spl + "हुन्थौँ" ; -- हुन्थौँ          
          <Neg, Pers2_L, Sg, Masc> => root + sreg + "हुन्थिइस्" ; -- हुन्थिइस् ???? G Check
          <Neg, Pers2_L, Sg, Fem>  => root + sfem + "हुन्थिइस्" ; -- हुन्थिइस्
          <Neg, Pers2_L, Pl,    _> => root + spl + "हुन्थियौ" ; -- हुन्थियौ / or हुन्थ्यौ (hunx:Tx:yw)
          <Neg, Pers2_M,  _,    _> => root + spl + "हुन्थियौ" ; -- हुन्थियौ / or हुन्थ्यौ (hunx:Tx:yw)          
          <Neg, Pers3_L, Sg, Masc> => root + sreg + "हुन्थ्यौ" ; -- हुन्थ्यौ / (थियो ????)
          <Neg, Pers3_L, Sg, Fem>  => root + sfem + "हुन्थी" ; -- हुन्थी/ (थिई ????)
          <Neg, Pers3_L, Pl,   _>  => root + spl + "हुन्थे" ; -- हुन्थे / (थिए)
          <Neg, Pers3_M, Sg, Fem>  => root + sfem + "हुन्थि" ; -- हुन्थि
          <Neg, Pers3_M,  _,   _>  => root + spl + "हुन्थे" ; -- हुन्थे / (थिए)
          <Neg,       _,  _,   _>  => root + sreg + "हुनुहुन्‌नथ्यो" -- हुनुहुन्‌नथ्यो (TODO: CONFIRM CORRECT)
        }
      };
      
{-   
-- Past Unknown, Perfective aspect, Nonprogressive Mode
   mkVPstUP : Str -> Str -> VCase -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root2, vc, po, pn, n, g ->
      {s = case vc of {
           VReg  => (mkVPstHPGen root2 "ेको"  "ेकि"  "ेका"  po pn n g).s ;
           VIReg => (mkVPstHPGen root2 "एको" "एकि" "एका" po pn n g).s
           }
      } ;

   -- mkVPstUP Helper handles both VReg and VIreg cases
   mkVPstUPGen : Str -> Str -> Str -> Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
      \root, sreg, sfem, spl, po, pn, n, g ->
      {s = case <po, pn, n, g> of {
          <Pos, Pers1,   Sg, Masc> => root + sreg + "रहेछु" ; -- रहेछु
          <Pos, Pers1,   Sg, Fem > => root + sfem + "रहेछु" ; -- रहेछु (खाएकिरहेछु)
          <Pos, Pers1,   Pl,    _> => root + spl + "रहेछौँ" ; -- रहेछौँ          
          <Pos, Pers2_L, Sg, Masc> => root + sreg + "रहिछस्" ; --रहिछस्
          <Pos, Pers2_L, Sg, Fem>  => root + sfem + "रहिछस्" ; --रहिछस्
          <Pos, Pers2_L, Pl,    _> => root + spl + "रहेछौ" ; -- रहेछौ          
          <Pos, Pers2_M, Sg, Masc> => root + spl + "रहेछौ" ; -- रहेछौ
          <Pos, Pers2_M, Sg, Fem>  => root + sfem + "रहिछौ" ; -- रहिछौ (छ्यौ ????)
          <Pos, Pers2_M, Pl,    _> => root + spl + "रहेछौ" ; -- रहेछौ          
          <Pos, Pers3_L, Sg, Masc> => root + sreg + "रहेछ" ; -- रहेछ
          <Pos, Pers3_L, Sg, Fem>  => root + sfem + "रहिछ" ; -- रहिछ
          <Pos, Pers3_L, Pl,   _>  => root + spl + "रहेछन्" ; -- रहेछन्          
          <Pos, Pers3_M, Sg, Fem>  => root + sfem + "रहिछीन्" ; -- रहिछीन्          
          <Pos, Pers3_M, Sg, Masc> => root + spl + "रहेछन्" ; -- रहेछन्
          <Pos, Pers3_M,  _,   _>  => root + spl + "रहेछन्" ; -- रहेछन्
          <Pos,       _,  _,   _>  => root + sreg + "हुनुहुदोरहेछ" ; -- हुनुहुदोरहेछ/नुभएकोरहेछ(nuBe:korhec)
          
          -- Negative Case (TODO)
          <Neg,       _,  _,   _>  => "टुडु" -- TODO--           
        }
      };

-}
-- Present, Perfective aspect, Nonprogressive Mode
   mkVPreP : Str -> Str -> VCase -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root2, vc, po, pn, n, g ->
      {s = case vc of {
           VReg  => (mkVPreGen root2 "ेको"  "ेकि"  "ेका"  po pn n g).s ;
           VIReg => (mkVPreGen root2 "एको" "एकि" "एका" po pn n g).s
           }
      } ;
   
   -- mkVPreP helper handles both VReg and VIreg cases
   mkVPreGen : Str -> Str -> Str -> Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
      \root, sreg, sfem, spl, po, pn, n, g ->
      {s = case <po, pn, n, g> of {
          <Pos, Pers1,   Sg,    _> => root + sreg + "छु" ;   -- छु 
          <Pos, Pers1,   Pl,    _> => root + spl + "छौं" ;   -- छौं           
          <Pos, Pers2_L, Sg, Masc> => root + sreg + "छस्" ; -- छस्
          <Pos, Pers2_L, Sg, Fem>  => root + sfem + "छेस्" ; -- छेस्      
          <Pos, Pers2_L, Pl,    _> => root + spl + "छौ" ;    -- छौ 
          <Pos, Pers2_M, Sg, Fem>  => root + sfem + "छ्यौ" ; --छ्यौ
          <Pos, Pers2_M,  _,    _> => root + spl + "छौ" ;    -- छौ           
          <Pos, Pers3_L, Sg, Masc> => root + sreg + "छ" ;  -- छ
          <Pos, Pers3_L, Sg, Fem>  => root + sfem + "छे" ;  -- छे
          <Pos, Pers3_L, Pl,   _>  => root + spl + "छन्" ;  -- छन्      
          <Pos, Pers3_M, Sg, Fem>  => root + sfem + "छिन्" ;  -- छिन्
          <Pos, Pers3_M,  _,   _>  => root + spl + "छन्" ;  -- छन्      
          <Pos,       _,  _,   _>  => root + sreg + "हुनुहुन्छ" ; -- हुनुहुन्छ
          
          -- Negative Case (TODO)
          <Neg,       _,  _,   _>  => "टुडु" -- TODO--     
          }
      };
      
 
-- Future Definitive, Perfective aspect, Nonprogressive Mode
   mkVFutDefP : Str -> Str -> VCase -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root2, vc, po, pn, n, g ->
      {s = case vc of {
           VReg  => (mkVFutDefGen root2 "ेको"  "ेकि"  "ेका"  po pn n g).s ;
           VIReg => (mkVFutDefGen root2 "एको" "एकि" "एका" po pn n g).s
           }
        } ;
      
      
   -- mkVFutDef helper handles both VReg and VIreg cases
   mkVFutDefGen : Str -> Str -> Str -> Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
      \root, sreg, sfem, spl, po, pn, n, g ->
      {s = case <po, pn, n, g> of {
          <Pos, Pers1,   Sg,    _> => root + sreg + ("हुने"+"छु") ; -- हुनेछु
          <Pos, Pers1,   Pl,    _> => root + spl + "हुनेछौँ" ; -- हुनेछौँ           
          <Pos, Pers2_L, Sg, Masc> => root + sreg + "हुनेछस्" ; -- हुनेछस्
          <Pos, Pers2_L, Sg, Fem>  => root + sfem + "हुनेछेस्" ; -- हुनेछेस्
          <Pos, Pers2_L, Pl,    _> => root + spl + "हुनेछौ" ; -- हुनेछौ
          <Pos, Pers2_M, Sg, Fem>  => root + sfem + "हुनेछ्यौ" ; -- हुनेछ्यौ
          <Pos, Pers2_M,  _,    _> => root + spl + "हुनेछौ" ; -- हुनेछौ          
          <Pos, Pers3_L, Sg, Masc> => root + sreg + "हुनेछ" ;  -- हुनेछ
          <Pos, Pers3_L, Sg, Fem>  => root + sfem + "हुन्छे" ;  -- हुन्छे
          <Pos, Pers3_L, Pl,   _>  => root + spl + "हुनेछन्" ;  -- हुनेछन्      
          <Pos, Pers3_M, Sg, Fem>  => root + sfem + "हुनेछिन्" ;  -- हुनेछिन्
          <Pos, Pers3_M,  _,   _>  => root + spl + "हुनेछन्" ;  -- हुनेछन्      
          <Pos,       _,  _,   _>  => root + sreg + "हुनुहुनेछ" ; -- हुनुहुनेछ
          
          -- Negative Case (TODO)
          <Neg,       _,  _,   _>  => "टुडु" -- TODO--     
        }
      };


-- Future Nondefinitive, Perfective aspect, Nonprogressive Mode
   mkVFutNDefP : Str -> Str -> VCase -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root2, vc, po, pn, n, g ->
      {s = case vc of {
           VReg  => (mkVFutDefGen root2 "ेको"  "ेकि"  "ेका"  po pn n g).s ;
           VIReg => (mkVFutDefGen root2 "एको" "एकि" "एका" po pn n g).s
           }
      } ;      
      
   -- Helper mkVFutNDef handles both VReg and VIreg cases
   mkVFutNDefGen : Str -> Str -> Str -> Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, sreg, sfem, spl, po, pn, n, g ->
      {s = case <po, pn, n, g> of {
           <Pos, Pers1,   Sg,    _> => root + sreg + "हुँला" ; -- हुँला
           <Pos, Pers1,   Pl,    _> => root + spl + "हौँलाँ" ; -- हौँलाँ          
           <Pos, Pers2_L, Sg, Masc> => root + sreg + "होलास्" ; -- होलास्
           <Pos, Pers2_L, Sg, Fem>  => root + sfem + "होलिस्" ; -- होलिस्
           <Pos, Pers2_L, Pl,    _> => root + spl + "हौला" ; -- हौला
           <Pos, Pers2_M, Sg, Fem>  => root + sfem + "होलि" ; -- होलि
           <Pos, Pers2_M,  _,    _> => root + spl + "हौला" ; -- हौला          
           <Pos, Pers3_L, Sg, Masc> => root + sreg + "होला" ; -- होला
           <Pos, Pers3_L, Sg, Fem>  => root + sfem + "होली" ; -- होली
           <Pos, Pers3_L, Pl,   _>  => root + spl + "होलान्" ; -- होलान्
           <Pos, Pers3_M, Sg, Fem>  => root + sfem + "होलिन्" ; -- होलिन्
           <Pos, Pers3_M,  _,   _>  => root + spl + "होलान्" ; -- होलान्
           <Pos,       _,  _,   _>  => root + sreg + "हुनुहोला" ; -- हुनुहोला
          
          -- Negative Case (TODO)
          <Neg,       _,  _,   _>  => "टुडु" -- TODO--     
        }
      };
      
  -- TODO - Refactor
  IntPronForm = {s: Case => Str};
  mkIntPronForm : (x1,x2,x3,x4:Str) -> IntPronForm =
   \y1,y2,y3,y4 -> {
    s = table {
	    Nom => y1;
        _   => y2
		}
	};
	   
 }
