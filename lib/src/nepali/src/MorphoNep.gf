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
  mkNMF str g t h = mkN str (str + "laI:") (str + "le") (str + "laI:") (str + "baq") (str + "ma") 
                   (str + "hru") (str + "hrulaI:") (str + "hrule") (str + "hrulaI:") (str + "hrubaq") (str + "hruma") g t h ;  
  
  -- Regular Nouns
  mkNReg : Str -> NType -> NPerson -> Noun ;
  mkNReg str typ hnr = mkNMF str Masc typ hnr ;
  
  -- Faminine nouns
  mkNFem : Str -> NType -> NPerson -> Noun ;
  mkNFem str typ hnr = mkNMF str Fem typ hnr ; 
  
  
  -- Uncountable nouns, which have same singular and plular form
  -- eg water
  mkNUnc : Str -> Gender -> NType -> NPerson -> Noun ;
  mkNUnc str g t h = mkN str (str + "laI:") (str + "le") (str + "laI:") (str + "baq") (str + "ma") 
                     str (str + "laI:") (str + "le") (str + "laI:") (str + "baq") (str + "ma")  g t h ;  

  -- Proper Names
  regN1 : Str -> Gender -> NType -> NPerson -> Noun ;
  regN1 str g t h = mkN str (str + "laI:") (str + "le") (str + "laI:") (str + "baq") (str + "ma")
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
  makePronReg str = makePron str (str + "laI:") (str + "le") (str + "laI:") (str + "baq") (str + "ma") ;

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
         VReg => root2 + "wV" ;
         _    => root2 + "AV"
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
        <_, "ja"> => (mkProgIReg root  aspect number gender).s ;
        <_, "ha"> => (mkProgIReg root  aspect number gender).s ;
        <_,    _> => (mkProgIReg root2 aspect number gender).s 
        };
      };
   
   
   mkProgReg : Str -> Aspect -> Number -> Gender -> {s : Str } =
     \root2,aspect,number,gender -> {
      s = case <aspect,number,gender> of {
        <Imperf, _,    _> => root2 + "dE" ;
       
        <Perf,  Sg, Masc> => root2 + "irheko" ;
        <Perf,  Sg, Fem>  => root2 + "irheki" ;
        <Perf,  Pl,    _> => root2 + "irheka"
        };
      };
    
   
   mkProgIReg : Str -> Aspect -> Number -> Gender -> {s : Str } =
     \root,aspect,number,gender -> {
      s = case <aspect,number,gender> of {
        <Imperf, _,    _> => root + "dE" ;
       
        <Perf,  Sg, Masc> => root + "i:rheko" ;
        <Perf,  Sg, Fem>  => root + "i:rheki" ;
        <Perf,  Pl,    _> => root + "i:rheka" 
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
          "ja"                => root + "nx:" ;
          "hu"                => root + "nx:" ;
          rot + "x:"          => root ;
          rot + ("h")         => root + "nx:" ; --cmnt
          rot + ("a"|"i"|"I") => root + "nx:" ;
          rot + ("e"|"u"|"U") => root + "nx:" ;
          rot + ("f"|"F")     => root + "V" ;
          _                   => root
        } ; 
    root2 = case root of {
          "ja"                => "g" ;
          "hu"                => "B" ;
          rot + "x:"          => rot ;
          rot + ("a"|"i"|"I") => root ;
          rot + ("h")         => root + "nx:" ; --cmnt
          rot + ("e"|"u"|"U") => rot + "o" ;
          rot + ("f"|"F")     => rot ;
          _                   => root
        } ; 
    vcase = case root of {
          rot + "x:" => VReg;   
          --rot + "h"  => VReg;   
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
          <Pos, Pers1,    Sg,    _> => root + "cu" ;   -- छु 
          <Pos, Pers1,    Pl,    _> => root + "cwV" ;   -- छौं      
          <Pos, Pers2_L,  Sg, Masc> => root + "csx:" ; -- छस्
          <Pos, Pers2_L,  Sg, Fem>  => root + "cesx:" ; -- छेस्      
          <Pos, Pers2_L,  Pl,   _>  => root + "cw" ;    -- छौ 
          <Pos, Pers2_M,  Sg, Fem>  => root + "cx:yw" ;  -- छ्यौ
          <Pos, Pers2_M,  _ ,   _>  => root + "cw" ;    -- छौ          
          <Pos, Pers3_L,  Sg, Masc> => root + "c" ;  -- छ
          <Pos, Pers3_L,  Sg, Fem>  => root + "ce" ;  -- छे
          <Pos, Pers3_L,  Pl,   _>  => root + "cnx:" ;  -- छन्      
          <Pos, Pers3_M,  Sg, Fem>  => root + "cinx:" ;  -- छिन्
          <Pos, Pers3_M,  _,    _>  => root + "cnx:" ;  -- छन्      
          <Pos,      _ ,  _,    _>  => root + "nuhunx:c" ; -- नुहुन्छ
          
          -- Negative Case
          <Neg, Pers1,    Sg,    _> => root + "dinV" ;  -- इनँ (पढ्दिनँ)
          <Neg, Pers1,    Pl,    _> => root + "dEnEV" ;   -- ऐनैँ (पढ्दैनैँ)
          <Neg, Pers2_L,  Sg, Masc> => root + "dEnsx:" ; -- ऐनस् (पढदैनस्)
          <Neg, Pers2_L,  Sg, Fem>  => root + "dinsx:" ; -- इनस् (पढदिनस्) 
          <Neg, Pers2_L,  Pl,   _>  => root + "dEnE" ; -- ऐनै 
          <Neg, Pers2_M,  Sg, Fem>  => root + "dinE" ; -- इनै
          <Neg, Pers2_M,  _ ,   _>  => root + "dEnE" ; -- ऐनै           
          <Neg, Pers3_L,  Sg, Masc> => root + "dEn" ;  -- ऐन
          <Neg, Pers3_L,  Sg, Fem>  => root + "din" ;  -- इन
          <Neg, Pers3_L,  Pl,   _>  => root + "dEnx:n" ;  -- ऐनन्
          <Neg, Pers3_M,  Sg, Fem>  => root + "dinx:n" ;  -- इनन्
          <Neg, Pers3_M,  _,    _>  => root + "dEnx:n" ;  -- ऐनन्
          <Neg,      _ ,  _,    _>  => root + "nuhunx:n" -- नुहुन्न
          }
     } ;          
   
   -- mkVPreNP Helper for VIRrg case
   mkVPreNPIReg : Str -> Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
    \root, root1, po, pn, n, g ->
     {s = case <po, pn, n, g> of { 
          -- Positive case
          <Pos, Pers1,    Sg,    _> => root1 + "cu" ;   -- छु 
          <Pos, Pers1,    Pl,    _> => root1 + "cwM" ;   -- छौं      
          <Pos, Pers2_L,  Sg, Masc> => root1 + "csx:" ; -- छस्
          <Pos, Pers2_L,  Sg, Fem>  => root1 + "cesx:" ; -- छेस्      
          <Pos, Pers2_L,  Pl,   _>  => root1 + "cw" ;    -- छौ 
          <Pos, Pers2_M,  Pl, Fem>  => root1 + "cx:yw" ;  -- छ्यौ
          <Pos, Pers2_M,  _ ,   _>  => root1 + "cw" ;    -- छौ      
          <Pos, Pers3_L,  Sg, Masc> => root1 + "c" ;  -- छ
          <Pos, Pers3_L,  Sg, Fem>  => root1 + "ce" ;  -- छे
          <Pos, Pers3_L,  Pl,   _>  => root1 + "cnx:" ;  -- छन्      
          <Pos, Pers3_M,  Sg, Fem>  => root1 + "cinx:" ;  -- छिन्
          <Pos, Pers3_M,  _,    _>  => root1 + "cnx:" ;  -- छन्      
          <Pos,      _ ,  _,    _>  => root + "nuhunx:c" ; -- नुहुन्छ
          
          -- Negative Case
          <Neg, Pers1,    Sg,    _> => root + "VdinV" ;  -- इनँ (खाँदिनँ)
          <Neg, Pers1,    Pl,    _> => root + "VdEnEV" ;  -- ऐनैँ (खाँदैनैँ)
          <Neg, Pers2_L,  Sg, Masc> => root + "VdEnsx:" ; -- ऐनस्  (आउँदैनस्)
          <Neg, Pers2_L,  Sg, Fem>  => root + "Vdinsx:" ; -- इनस् (खाँदिनस्) 
          <Neg, Pers2_L,  Pl,   _>  => root + "VdEnE" ; -- ऐनै  (खाँदैनै)
          <Neg, Pers2_M,  Sg, Fem>  => root + "VdinE" ; -- इनै
          <Neg, Pers2_M,  _ ,   _>  => root + "VdEnE" ; -- ऐनै           
          <Neg, Pers3_L,  Sg, Masc> => root + "VdEn" ;  -- ऐन
          <Neg, Pers3_L,  Sg, Fem>  => root + "Vdin" ;  -- इन (खाँदिन)
          <Neg, Pers3_L,  Pl,   _>  => root + "VdEnx:n" ;  -- ऐनन्
          <Neg, Pers3_M,  Sg, Fem>  => root + "Vdinx:n" ;  -- इनन्
          <Neg, Pers3_M,  _,    _>  => root + "VdEnx:n" ;  -- ऐनन्
          <Neg,      _ ,  _,    _>  => root + "Vnuhunx:z=n" -- नुहुन्‍न
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
           <Pos, Pers1,    Sg,   _>  => root2 + "eV" ; -- एँ
           <Pos, Pers1,    Pl,   _>  => root  + "ywM" ; -- यौं
           <Pos, Pers2_L,  Sg,   _>  => root2 + "isx:" ; -- इस्
           <Pos, Pers2_L,  Pl,   _>  => root  + "yw" ; -- यौ
           <Pos, Pers2_M,   _,   _>  => root  + "yw" ; -- यौ             
           <Pos, Pers3_L,  Sg, Masc> => root  + "yo" ; -- यो
           <Pos, Pers3_L,  Sg, Fem>  => root2 + "I" ; -- इ (पढी)
           <Pos, Pers3_L,  Pl,   _>  => root2 + "e" ; -- ए (पढे)     
           <Pos, Pers3_M,  Sg, Fem>  => root2 + "inx:" ; -- इन् (पढिन्)
           <Pos, Pers3_M,   _,   _>  => root2 + "e" ; -- ए (पढे)     
           <Pos,       _,   _,   _>  => root  + "nuByo" ; -- नुभयो
          
           -- Negative case
           <Neg, Pers1,    Sg,   _>  => root2 + "inV" ; -- इनँ
           <Neg, Pers1,    Pl,   _>  => root2 + "enEV" ; -- एनैँ
           <Neg, Pers2_L,  Sg,   _>  => root2 + "insx:" ; -- इनस्
           <Neg, Pers2_L,  Pl,   _>  => root2 + "enE" ; -- एनै
           <Neg, Pers2_M,  Sg, Fem>  => root2 + "inE" ; -- इनै    
           <Neg, Pers2_M,   _,   _>  => root2 + "enE" ; -- एनै             
           <Neg, Pers3_L,  Sg, Masc> => root2 + "en" ; -- एन
           <Neg, Pers3_L,  Sg, Fem>  => root2 + "in" ; -- इन (पढिन)
           <Neg, Pers3_L,  Pl,   _>  => root2 + "ennx:" ; -- एनन् (पढेनन्)     
           <Neg, Pers3_M,  Sg, Fem>  => root2 + "innx:" ; -- इनन् (पढिनन्)
           <Neg, Pers3_M,   _,   _>  => root2 + "ennx:" ; -- एनन् (पढेनन्)     
           <Neg,       _,   _,   _>  => root  + "nuBe:n" -- नुभएन
           } 
      } ;
  
   -- mkVPstSNP Helper for VIRrg case
   mkVPstSNPIReg : Str -> Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root2, po, pn, n, g ->
      {s = case <po, pn, n, g> of {   
           -- Positive case
           <Pos, Pers1,    Sg,   _>  => root2 + "e:V" ; -- एँ
           <Pos, Pers1,    Pl,   _>  => root2 + "ywM" ; -- यौं
           <Pos, Pers2_L,  Sg,   _>  => root2 + "i:sx:" ; -- इस्
           <Pos, Pers2_L,  Pl,   _>  => root2 + "yw" ; -- यौ
           <Pos, Pers2_M,   _,   _>  => root2 + "yw" ; -- यौ      
           <Pos, Pers3_L,  Sg, Masc> => root2 + "yo" ; -- यो
           <Pos, Pers3_L,  Sg, Fem>  => root2 + "I:" ; -- ई 
           <Pos, Pers3_L,  Pl,   _>  => root2 + "e:" ; -- ए   
           <Pos, Pers3_M,  Sg, Fem>  => root2 + "i:nx:" ; -- इन्
           <Pos, Pers3_M,   _,   _>  => root2 + "e:" ; -- ए   
           <Pos,       _,   _,   _>  => root  + "nuByo" ; -- नुभयो
          
           -- Negative case
           <Neg, Pers1,    Sg,   _>  => root2 + "i:nV" ; -- इनँ
           <Neg, Pers1,    Pl,   _>  => root2 + "e:nEV" ; -- एनैँ
           <Neg, Pers2_L,  Sg,   _>  => root2 + "i:nsx:" ; -- इनस्
           <Neg, Pers2_L,  Pl,   _>  => root2 + "e:nE" ; -- एनै
           <Neg, Pers2_M,  Sg, Fem>  => root2 + "i:nE" ; -- इनै    
           <Neg, Pers2_M,   _,   _>  => root2 + "e:nE" ; -- एनै             
           <Neg, Pers3_L,  Sg, Masc> => root2 + "e:n" ; -- एन
           <Neg, Pers3_L,  Sg, Fem>  => root2 + "i:n" ; -- इन (पढिन)
           <Neg, Pers3_L,  Pl,   _>  => root2 + "e:nnx:" ; -- एनन् (पढेनन्)     
           <Neg, Pers3_M,  Sg, Fem>  => root2 + "i:nnx:" ; -- इनन् (पढिनन्)
           <Neg, Pers3_M,   _,   _>  => root2 + "e:nnx:" ; -- एनन् (पढेनन्)     
           <Neg,       _,   _,   _>  => root  + "nuBe:n" -- नुभएन          
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
      let neg = "dEn" ; -- दैन    (TODO : CHECK FOR MAKE GENERIC FINCTION FOR POS AND NEG)
      in
      {s = case <po, pn, n, g> of {
          <Pos, Pers1,   Sg,    _> => root + "TeM" ; -- थें
          <Pos, Pers1,   Pl,    _> => root + "Tx:ywM" ; -- थ्यौं
          <Pos, Pers2_L, Sg,    _> => root + "Tisx:" ; -- थिस्
          <Pos, Pers2_L, Pl,    _> => root + "Tx:yw" ; -- थ्यौ
          <Pos, Pers2_M,  _,    _> => root + "Tx:yw" ; -- थ्यौ
          <Pos, Pers3_L, Sg, Masc> => root + "Tx:yo" ; -- थ्यो
          <Pos, Pers3_L, Sg, Fem>  => root + "TI" ; -- थी
          <Pos, Pers3_L, Pl,   _>  => root + "Te" ; -- थे
          <Pos, Pers3_M, Sg, Fem>  => root + "Tinx:" ; -- थिन्
          <Pos, Pers3_M,  _,   _>  => root + "Te" ; -- थे          
          <Pos,       _,  _,   _>  => root1 + "nuhunx:z+Tx:yo" ; -- नुहुन्‌थ्यो
          
          <Neg, Pers1,   Sg,    _> => root + neg + "TeM" ; -- थें
          <Neg, Pers1,   Pl,    _> => root + neg + "Tx:ywM" ; -- थ्यौं
          <Neg, Pers2_L, Sg,    _> => root + neg + "Tisx:" ; -- थिस्
          <Neg, Pers2_L, Pl,    _> => root + neg + "Tx:yw" ; -- थ्यौ
          <Neg, Pers2_M,  _,    _> => root + neg + "Tx:yw" ; -- थ्यौ
          <Neg, Pers3_L, Sg, Masc> => root + neg + "Tx:yo" ; -- थ्यो
          <Neg, Pers3_L, Sg, Fem>  => root + neg + "TI" ; -- थी
          <Neg, Pers3_L, Pl,   _>  => root + neg + "Te" ; -- थे
          <Neg, Pers3_M, Sg, Fem>  => root + neg + "TInx:" ; -- थिन्
          <Neg, Pers3_M,  _,   _>  => root + neg + "Te" ; -- थे          
          <Neg,       _,  _,   _>  => root1 + "nuhuVdEnTx:yo" -- नुहुँदैनथ्यो
          }
      };
   
{-
-- Past Unknown, Nonprogressive mode, nonperfective aspect     
   mkVPstUNP : Str -> Str -> VCase -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \ root, root2, vc, po, p, n, g -> 
      {s = case vc of {
           VReg  => case po of {
                    Pos => (mkVPstUNPReg root root2 ""  p n g).s ;
                    Neg => (mkVPstUNPReg root root2 "n" p n g).s 
                    } ;
           VIReg => case po of {
                    Pos => (mkVPstUNPIReg root root2 ""  p n g).s ;
                    Neg => (mkVPstUNPIReg root root2 "n" p n g).s 
                    }
           }
      };

   -- mkVPstUNP helper for VReg case
   mkVPstUNPReg : Str -> Str -> Str -> NPerson -> Number -> Gender -> {s:Str} = 
      \root, root2, na, pn, nu, g ->
      {s = case <pn, nu, g> of {
          <Pers1,   Sg, Masc> => root2  + "e" + na + "cu" ; -- एछु
          <Pers1,   Sg, Fem>  => root2  + "i" + na + "cu" ; -- इछु
          <Pers1,   Pl,    _> => root2  + "e" + na + "cwV" ; -- एछौँ
          <Pers2_L, Sg, Masc> => root2  + "e" + na + "csx:" ; -- एछस्
          <Pers2_L, Sg, Fem>  => root2  + "i" + na + "csx:" ; -- इछस्
          <Pers2_L, Pl,    _> => root2  + "e" + na + "cw" ; -- एछौ                    
          <Pers2_M, Sg, Fem>  => root2  + "i" + na + "cw" ; -- इछौ
          <Pers2_M,  _,    _> => root2  + "e" + na + "cw" ; -- एछौ               
          <Pers3_L, Sg, Masc> => root2  + "e" + na + "c" ; -- एछ
          <Pers3_L, Sg, Fem>  => root2  + "i" + na + "c" ; -- इछ
          <Pers3_L, Pl,   _>  => root2  + "e" + na + "cnx:" ; -- एछन्
          <Pers3_M, Sg, Fem>  => root2  + "i" + na + "cnx:" ; -- इछन्
          <Pers3_M,  _,   _>  => root2  + "e" + na + "cnx:" ; -- एछन्
          <      _,  _,   _>  => root   + "nuBe:" + na +"c" -- नुभएछ
        }
      } ;
   
   
   -- mkVPstUNP helper for VIReg case
   mkVPstUNPIReg : Str -> Str -> Str -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root2, na, pn, nu, g -> 
      {s = case <pn, nu, g> of {
           <Pers1,   Sg, Masc> => root2 + "e:" + na + "cu" ; -- एछु
           <Pers1,   Sg, Fem>  => root2 + "i:" + na + "cu" ; -- इछु
           <Pers1,   Pl,    _> => root2 + "e:" + na + "cwV" ; -- एछौँ
           <Pers2_L, Sg, Masc> => root2 + "e:" + na + "csx:" ; -- एछस्
           <Pers2_L, Sg, Fem>  => root2 + "i:" + na + "csx:" ; -- इछस्
           <Pers2_L, Pl,    _> => root2 + "e:" + na + "cw" ; -- एछौ                    
           <Pers2_M, Sg, Fem>  => root2 + "i:" + na + "cw" ; -- इछौ
           <Pers2_M,  _,    _> => root2 + "e:" + na + "cw" ; -- एछौ        
          
           <Pers3_L, Sg, Masc> => root2 + "e:" + na + "c" ; -- एछ
           <Pers3_L, Sg, Fem>  => root2 + "i:" + na + "c" ; -- इछ
           <Pers3_L, Pl,   _>  => root2 + "e:" + na + "cnx:" ; -- एछन्
           <Pers3_M, Sg, fem>  => root2 + "i:" + na + "cnx:" ; -- इछन्
           <Pers3_M,  _,   _>  => root2 + "e:" + na + "cnx:" ; -- एछन्
           <      _,  _,   _>  => root  + "nuBe:" + na +"c" -- नुभएनछ
           }
     } ;
-}     

-- Future Definitive, Nonprogressive mode, nonperfective aspect
   -- Handles Both cases
   mkVFutDNP : Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, po, pn, n, g ->
      {s = case <po, pn, n, g> of { 
          -- Positive case
          <Pos, Pers1,    Sg,   _>  => root + "necu" ; -- नेछु
          <Pos, Pers1,    Pl,   _>  => root + "necwM" ; -- नेछौं      
          <Pos, Pers2_L,  Sg,   _>  => root + "necsx:" ; -- नेछस्
          <Pos, Pers2_L,  Pl,   _>  => root + "necwM" ; -- नेछौ
          <Pos, Pers2_M,   _,   _>  => root + "necwM" ; -- नेछौ               
          <Pos, Pers3_L,  Sg,   _>  => root + "nec" ; -- नेछ
          <Pos, Pers3_L,  Pl,   _>  => root + "necnx:" ; -- नेछन्      
          <Pos, Pers3_M,   _, Masc> => root + "necnx:" ; -- नेछन्
          <Pos, Pers3_M,  Sg, Fem>  => root + "necinx:" ; -- नेछिन्      
          <Pos, Pers3_M,  Pl, Fem>  => root + "necinx:" ; -- नेछन्            
          <Pos,       _,   _,   _>  => root + "nuhunec" ; -- नुहुनेछ      
          
          -- Negative Case
          <Neg, Pers1,    Sg,   _>  => root + "necEn" ; -- नेछैन
          <Neg, Pers1,    Pl,   _>  => root + "necEnEV" ; -- नेछैनैँ
          <Neg, Pers2_L,  Sg,   _>  => root + "necEnsx:" ; -- नेछैनस्
          <Neg, Pers2_L,  Pl,   _>  => root + "necEnE" ; -- नेछैनै
          <Neg, Pers2_M,   _,   _>  => root + "necEnE" ; -- नेछैनै           
          <Neg, Pers3_L,  Sg,   _>  => root + "necEnx:" ; -- नेछैन्
          <Neg, Pers3_L,  Pl,   _>  => root + "necEnnx:" ; -- नेछैनन्
          <Neg, Pers3_M,  Sg,   _>  => root + "necEnnx:" ; -- नेछैनन्          
          <Neg, Pers3_M,  Pl,   _>  => root + "necEnE" ; -- नेछैनै
          <Neg,       _,   _,   _>  => root + "nuhunecEnx:" -- नुहुनेछैन्
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
          <Pos, Pers1,   Sg,    _> => root2 + "uVla" ; -- उँला 
          <Pos, Pers1,   Pl,    _> => root2 + "wVla" ; -- आँला
          <Pos, Pers2_L, Sg, Masc> => root  + "z=lasx:" ; -- लास् 
          <Pos, Pers2_L, Sg, Fem>  => root  + "lIsx:" ; -- लिस्
          <Pos, Pers2_L, Pl,    _> => root2 + "wla" ; -- औला 
          <Pos, Pers2_M, Pl,  Fem> => root2 + "wli" ; -- औलि 
          <Pos, Pers3_L, Sg, Masc> => root  + "la" ; -- ला
          <Pos, Pers3_L, Sg, Fem>  => root  + "lI" ; -- ली
          <Pos, Pers3_L, Pl,   _>  => root  + "lanx:" ; -- लान्
          <Pos, Pers3_M, Sg, Fem>  => root  + "lInx:" ; -- लिन्
          <Pos, Pers3_M,  _,   _>  => root  + "lanx:" ; -- लान्
          <Pos,       _,  _,   _>  => root  + "z=nuhola" ; -- नुहोला
          
          -- TODO : NOT CLEAR DEFINITION IN BOOK
          <Neg,       _,  _,   _>  => "quxu" 
        }
      } ;
 
   -- mkVFutNDNP helper for VIReg case
   mkVFutNDNPIReg : Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, po, pn, n, g ->
      {s = case <po, pn, n, g> of {
           <Pos, Pers1,   Sg,    _> => root + "fVla" ; -- उँला
           <Pos, Pers1,   Pl,    _> => root + "WVla" ; -- आँला
           <Pos, Pers2_L, Sg, Masc> => root + "lasx:" ; -- लास्
           <Pos, Pers2_L, Sg, Fem>  => root + "lisx:" ; -- लिस् 
           <Pos, Pers2_L, Pl,    _> => root + "Wla" ; -- औला 
           <Pos, Pers2_M, Pl,  Fem> => root + "Wli" ; -- औलि 
           <Pos, Pers3_L, Sg, Masc> => root + "la" ; -- ला
           <Pos, Pers3_L, Sg, Fem>  => root + "lI" ; -- ली
           <Pos, Pers3_L, Pl,   _>  => root + "lanx:" ; -- लान्
           <Pos, Pers3_M, Sg, Fem>  => root + "linx:" ; -- लिन्
           <Pos, Pers3_M,  _,   _>  => root + "lanx:" ; -- लान्
           <Pos,       _,  _,   _>  => root + "nuhola" ; -- नुहोला
           
           -- TODO : NOT CLEAR DEFINITION IN BOOK
           <Neg,       _,  _,   _>  => "quxu" 
           }
        } ;
   


-- Past Simple, Perfective aspect, Nonprogressive Mode
   mkVPstSP : Str -> Str -> VCase -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root2, vc, po, pn, n, g ->
      {s = case vc of {
           VReg  => (mkVPstSPGen root2 "eko"  "eki"  "eka" po pn n g).s ;
           VIReg => (mkVPstSPGen root2 "e:ko" "e:ki" "e:ka" po pn n g).s
           }
      } ;
   
   -- mkVPstSP Helper handles both VReg and VIreg cases
   mkVPstSPGen : Str -> Str -> Str -> Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
      \root, sreg, sfem, spl, po, pn, n, g ->
      {s = case <po, pn, n, g> of {
          -- Positive case
          <Pos, Pers1,   Sg,    _> => root + sreg + "Tie:V" ; -- थिएँ
          <Pos, Pers1,   Pl,    _> => root + spl + "TiywV" ; -- थियौँ          
          <Pos, Pers2_L, Sg, Masc> => root + sreg + "Tii:sx:" ; -- थिइस्
          <Pos, Pers2_L, Sg, Fem>  => root + sfem + "Tii:sx:" ; -- थिइस्
          <Pos, Pers2_L, Pl,    _> => root + spl + "Tiyw" ; -- थियौ
          <Pos, Pers2_M,  _,    _> => root + spl + "Tiyw" ; -- थियौ          
          <Pos, Pers3_L, Sg, Masc> => root + sreg + "Tiyo" ; -- थियो
          <Pos, Pers3_L, Sg, Fem>  => root + sfem + "TiI:" ; --थिई
          <Pos, Pers3_L, Pl,   _>  => root + spl + "Tie:" ; -- थिए
          <Pos, Pers3_M, Sg, Fem>  => root + sfem + "Tii:nx:" ; -- थिइन्
          <Pos, Pers3_M,  _,   _>  => root + spl + "Tie:" ; -- थिए
          <Pos,       _,  _,   _>  => root + sreg + "hunuhunx:z+Tx:yo" ; -- हुनुहुन्‌थ्यो (TODO: CONFIRM CORRECT)
          
          -- Negative case
          <Neg, Pers1,   Sg,    _> => root + sreg +"Tii:nV" ; -- 
          <Neg, Pers1,   Pl,    _> => root + spl + "Tie:nEV" ; --
          
          <Neg, Pers2_L, Sg, Masc> => root + sreg + "Tii:nsx:" ; -- 
          <Neg, Pers2_L, Sg, Fem>  => root + sfem + "Tii:nsx:" ; -- 
          <Neg, Pers2_L, Pl,    _> => root + spl + "Tie:nE" ; -- 
          <Neg, Pers2_M,  _,    _> => root + spl + "TinE" ; -- 
          
          <Neg, Pers3_L, Sg, Masc> => root + sreg + "Tie:n" ; -- 
          <Neg, Pers3_L, Sg, Fem>  => root + sfem + "Tii:n:" ; --
          <Neg, Pers3_L, Pl,   _>  => root + spl + "Tie:nnx:" ; -- 
          <Neg, Pers3_M, Sg, Fem>  => root + sfem + "Tii:nnx:" ; -- 
          <Neg, Pers3_M,  _,   _>  => root + spl + "Tie:nnx:" ; -- 
          <Neg,       _,  _,   _>  => root + sreg + "hunuhunx:z+nTx:yo" -- हुनुहुन्‌नथ्यो (TODO: CONFIRM CORRECT)
        }
      };
   
   
-- Past Habitual, Perfective aspect, Nonprogressive Mode
   mkVPstHP : Str -> Str -> VCase -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root2, vc, po, pn, n, g ->
      {s = case vc of {
           VReg  => (mkVPstHPGen root2 "eko"  "eki"  "eka"  po pn n g).s ;
           VIReg => (mkVPstHPGen root2 "e:ko" "e:ki" "e:ka" po pn n g).s
           }
        } ;
   
   -- mkVPstSP Helper handles both VReg and VIreg cases
   mkVPstHPGen : Str -> Str -> Str -> Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
      \root, sreg, sfem, spl, po, pn, n, g ->
      {s = case <po, pn, n, g> of {
          <Pos, Pers1,   Sg,    _> => root + sreg + "hunx:TeV" ; -- हुन्थेँ
          <Pos, Pers1,   Pl,    _> => root + spl + "hunx:TwV" ; -- हुन्थौँ          
          <Pos, Pers2_L, Sg, Masc> => root + sreg + "hunx:Tisx:" ; -- हुन्थिस् 
          <Pos, Pers2_L, Sg, Fem>  => root + sfem + "hunx:Ti:sx:" ; -- हुन्थिस् 
          <Pos, Pers2_L, Pl,    _> => root + spl + "hunx:Tx:yw" ; -- हुन्थ्यौ 
          <Pos, Pers2_M,  _,    _> => root + spl + "hunx:Tx:yw" ; -- हुन्थ्यौ           
          <Pos, Pers3_L, Sg, Masc> => root + sreg + "hunx:z+Tx:yw" ; -- हुन्‌थ्यौ
          <Pos, Pers3_L, Sg, Fem>  => root + sfem + "hunx:TI" ; -- हुन्थी
          <Pos, Pers3_L, Pl,   _>  => root + spl + "hunx:Te" ; -- हुन्थे  
          <Pos, Pers3_M, Sg, Fem>  => root + sfem + "hunx:z+Ti" ; -- हुन्थि
          <Pos, Pers3_M,  _,   _>  => root + spl + "hunx:Te" ; -- हुन्थे 
          <Pos,       _,  _,   _>  => root + sreg + "hunuhunx:Tx:yo" ; -- (TODO : हुनुहुन्थ्यो need to Confirm)
          
          -- Negative case (TODO)        
          <Neg, Pers1,   Sg,    _> => root + sreg + "hunx:TeV" ; -- हुन्थेँ
          <Neg, Pers1,   Pl,    _> => root + spl + "hunx:TwV" ; -- हुन्थौँ          
          <Neg, Pers2_L, Sg, Masc> => root + sreg + "hunx:Tii:sx:" ; -- हुन्थिइस् ???? G Check
          <Neg, Pers2_L, Sg, Fem>  => root + sfem + "hunx:Tii:sx:" ; -- हुन्थिइस्
          <Neg, Pers2_L, Pl,    _> => root + spl + "hunx:Tiyw" ; -- हुन्थियौ / or हुन्थ्यौ (hunx:Tx:yw)
          <Neg, Pers2_M,  _,    _> => root + spl + "hunx:Tiyw" ; -- हुन्थियौ / or हुन्थ्यौ (hunx:Tx:yw)          
          <Neg, Pers3_L, Sg, Masc> => root + sreg + "hunx:Tx:yw" ; -- हुन्थ्यौ / (थियो ????)
          <Neg, Pers3_L, Sg, Fem>  => root + sfem + "hunx:TI" ; -- हुन्थी/ (थिई ????)
          <Neg, Pers3_L, Pl,   _>  => root + spl + "hunx:Te" ; -- हुन्थे / (थिए)
          <Neg, Pers3_M, Sg, Fem>  => root + sfem + "hunx:Ti" ; -- हुन्थि
          <Neg, Pers3_M,  _,   _>  => root + spl + "hunx:Te" ; -- हुन्थे / (थिए)
          <Neg,       _,  _,   _>  => root + sreg + "hunuhunx:z+nTx:yo" -- हुनुहुन्‌नथ्यो (TODO: CONFIRM CORRECT)
        }
      };
      
{-   
-- Past Unknown, Perfective aspect, Nonprogressive Mode
   mkVPstUP : Str -> Str -> VCase -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root2, vc, po, pn, n, g ->
      {s = case vc of {
           VReg  => (mkVPstHPGen root2 "eko"  "eki"  "eka"  po pn n g).s ;
           VIReg => (mkVPstHPGen root2 "e:ko" "e:ki" "e:ka" po pn n g).s
           }
      } ;

   -- mkVPstUP Helper handles both VReg and VIreg cases
   mkVPstUPGen : Str -> Str -> Str -> Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
      \root, sreg, sfem, spl, po, pn, n, g ->
      {s = case <po, pn, n, g> of {
          <Pos, Pers1,   Sg, Masc> => root + sreg + "rhecu" ; -- रहेछु
          <Pos, Pers1,   Sg, Fem > => root + sfem + "rhecu" ; -- रहेछु (खाएकिरहेछु)
          <Pos, Pers1,   Pl,    _> => root + spl + "rhecwV" ; -- रहेछौँ          
          <Pos, Pers2_L, Sg, Masc> => root + sreg + "rhicsx:" ; --रहिछस्
          <Pos, Pers2_L, Sg, Fem>  => root + sfem + "rhicsx:" ; --रहिछस्
          <Pos, Pers2_L, Pl,    _> => root + spl + "rhecw" ; -- रहेछौ          
          <Pos, Pers2_M, Sg, Masc> => root + spl + "rhecw" ; -- रहेछौ
          <Pos, Pers2_M, Sg, Fem>  => root + sfem + "rhicw" ; -- रहिछौ (छ्यौ ????)
          <Pos, Pers2_M, Pl,    _> => root + spl + "rhecw" ; -- रहेछौ          
          <Pos, Pers3_L, Sg, Masc> => root + sreg + "rhec" ; -- रहेछ
          <Pos, Pers3_L, Sg, Fem>  => root + sfem + "rhic" ; -- रहिछ
          <Pos, Pers3_L, Pl,   _>  => root + spl + "rhecnx:" ; -- रहेछन्          
          <Pos, Pers3_M, Sg, Fem>  => root + sfem + "rhicInx:" ; -- रहिछीन्          
          <Pos, Pers3_M, Sg, Masc> => root + spl + "rhecnx:" ; -- रहेछन्
          <Pos, Pers3_M,  _,   _>  => root + spl + "rhecnx:" ; -- रहेछन्
          <Pos,       _,  _,   _>  => root + sreg + "hunuhudorhec" ; -- हुनुहुदोरहेछ/नुभएकोरहेछ(nuBe:korhec)
          
          -- Negative Case (TODO)
          <Neg,       _,  _,   _>  => "quxu" -- TODO--           
        }
      };

-}
-- Present, Perfective aspect, Nonprogressive Mode
   mkVPreP : Str -> Str -> VCase -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root2, vc, po, pn, n, g ->
      {s = case vc of {
           VReg  => (mkVPreGen root2 "eko"  "eki"  "eka"  po pn n g).s ;
           VIReg => (mkVPreGen root2 "e:ko" "e:ki" "e:ka" po pn n g).s
           }
      } ;
   
   -- mkVPreP helper handles both VReg and VIreg cases
   mkVPreGen : Str -> Str -> Str -> Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
      \root, sreg, sfem, spl, po, pn, n, g ->
      {s = case <po, pn, n, g> of {
          <Pos, Pers1,   Sg,    _> => root + sreg + "cu" ;   -- छु 
          <Pos, Pers1,   Pl,    _> => root + spl + "cwM" ;   -- छौं           
          <Pos, Pers2_L, Sg, Masc> => root + sreg + "csx:" ; -- छस्
          <Pos, Pers2_L, Sg, Fem>  => root + sfem + "cesx:" ; -- छेस्      
          <Pos, Pers2_L, Pl,    _> => root + spl + "cw" ;    -- छौ 
          <Pos, Pers2_M, Sg, Fem>  => root + sfem + "cx:yw" ; --छ्यौ
          <Pos, Pers2_M,  _,    _> => root + spl + "cw" ;    -- छौ           
          <Pos, Pers3_L, Sg, Masc> => root + sreg + "c" ;  -- छ
          <Pos, Pers3_L, Sg, Fem>  => root + sfem + "ce" ;  -- छे
          <Pos, Pers3_L, Pl,   _>  => root + spl + "cnx:" ;  -- छन्      
          <Pos, Pers3_M, Sg, Fem>  => root + sfem + "cinx:" ;  -- छिन्
          <Pos, Pers3_M,  _,   _>  => root + spl + "cnx:" ;  -- छन्      
          <Pos,       _,  _,   _>  => root + sreg + "hunuhunx:c" ; -- हुनुहुन्छ
          
          -- Negative Case (TODO)
          <Neg,       _,  _,   _>  => "quxu" -- TODO--     
          }
      };
      
 
-- Future Definitive, Perfective aspect, Nonprogressive Mode
   mkVFutDefP : Str -> Str -> VCase -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root2, vc, po, pn, n, g ->
      {s = case vc of {
           VReg  => (mkVFutDefGen root2 "eko"  "eki"  "eka"  po pn n g).s ;
           VIReg => (mkVFutDefGen root2 "e:ko" "e:ki" "e:ka" po pn n g).s
           }
        } ;
      
      
   -- mkVFutDef helper handles both VReg and VIreg cases
   mkVFutDefGen : Str -> Str -> Str -> Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
      \root, sreg, sfem, spl, po, pn, n, g ->
      {s = case <po, pn, n, g> of {
          <Pos, Pers1,   Sg,    _> => root + sreg + ("hune"+"cu") ; -- हुनेछु
          <Pos, Pers1,   Pl,    _> => root + spl + "hunecwV" ; -- हुनेछौँ           
          <Pos, Pers2_L, Sg, Masc> => root + sreg + "hunecsx:" ; -- हुनेछस्
          <Pos, Pers2_L, Sg, Fem>  => root + sfem + "hunecesx:" ; -- हुनेछेस्
          <Pos, Pers2_L, Pl,    _> => root + spl + "hunecw" ; -- हुनेछौ
          <Pos, Pers2_M, Sg, Fem>  => root + sfem + "hunecx:yw" ; -- हुनेछ्यौ
          <Pos, Pers2_M,  _,    _> => root + spl + "hunecw" ; -- हुनेछौ          
          <Pos, Pers3_L, Sg, Masc> => root + sreg + "hunec" ;  -- हुनेछ
          <Pos, Pers3_L, Sg, Fem>  => root + sfem + "hunx:ce" ;  -- हुन्छे
          <Pos, Pers3_L, Pl,   _>  => root + spl + "hunecnx:" ;  -- हुनेछन्      
          <Pos, Pers3_M, Sg, Fem>  => root + sfem + "hunecinx:" ;  -- हुनेछिन्
          <Pos, Pers3_M,  _,   _>  => root + spl + "hunecnx:" ;  -- हुनेछन्      
          <Pos,       _,  _,   _>  => root + sreg + "hunuhunec" ; -- हुनुहुनेछ
          
          -- Negative Case (TODO)
          <Neg,       _,  _,   _>  => "quxu" -- TODO--     
        }
      };


-- Future Nondefinitive, Perfective aspect, Nonprogressive Mode
   mkVFutNDefP : Str -> Str -> VCase -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, root2, vc, po, pn, n, g ->
      {s = case vc of {
           VReg  => (mkVFutDefGen root2 "eko"  "eki"  "eka"  po pn n g).s ;
           VIReg => (mkVFutDefGen root2 "e:ko" "e:ki" "e:ka" po pn n g).s
           }
      } ;      
      
   -- Helper mkVFutNDef handles both VReg and VIreg cases
   mkVFutNDefGen : Str -> Str -> Str -> Str -> Polarity -> NPerson -> Number -> Gender -> {s:Str} = 
     \root, sreg, sfem, spl, po, pn, n, g ->
      {s = case <po, pn, n, g> of {
           <Pos, Pers1,   Sg,    _> => root + sreg + "huVla" ; -- हुँला
           <Pos, Pers1,   Pl,    _> => root + spl + "hwVlaV" ; -- हौँलाँ          
           <Pos, Pers2_L, Sg, Masc> => root + sreg + "holasx:" ; -- होलास्
           <Pos, Pers2_L, Sg, Fem>  => root + sfem + "holisx:" ; -- होलिस्
           <Pos, Pers2_L, Pl,    _> => root + spl + "hwla" ; -- हौला
           <Pos, Pers2_M, Sg, Fem>  => root + sfem + "holi" ; -- होलि
           <Pos, Pers2_M,  _,    _> => root + spl + "hwla" ; -- हौला          
           <Pos, Pers3_L, Sg, Masc> => root + sreg + "hola" ; -- होला
           <Pos, Pers3_L, Sg, Fem>  => root + sfem + "holI" ; -- होली
           <Pos, Pers3_L, Pl,   _>  => root + spl + "holanx:" ; -- होलान्
           <Pos, Pers3_M, Sg, Fem>  => root + sfem + "holinx:" ; -- होलिन्
           <Pos, Pers3_M,  _,   _>  => root + spl + "holanx:" ; -- होलान्
           <Pos,       _,  _,   _>  => root + sreg + "hunuhola" ; -- हुनुहोला
          
          -- Negative Case (TODO)
          <Neg,       _,  _,   _>  => "quxu" -- TODO--     
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
