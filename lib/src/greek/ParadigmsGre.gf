resource ParadigmsGre = 
  open ResGre, CatGre,BeschGre, Prelude in {
  
flags coding = utf8 ;

oper
    masculine : Gender = Masc ;
    feminine : Gender = Fem ;
    neutral : Gender = Neut ;

    accusative : Case = Acc ;
    genitive : Case = Gen ;
   
    indicative : Mood = Ind ;
    conjunctive : Mood = Con ;
      

    singular : Number = Sg; 
    plural   : Number = Pl;
   
 

  mkN = overload {
      mkN : (dentro : Str) ->   N 
          = \n -> lin N (regN n) ;
      mkN : (s : Str)  -> Gender ->  N 
          = \n,g -> lin N (mkN1 n g) ;
      mkN : (s1,s2,s3,s4,p1,p2,p3,p4 : Str) -> Gender -> N 
          = \s1,s2,s3,s4,p1,p2,p3,p4,g -> lin N (mkNoun s1 s2 s3 s4 p1 p2 p3 p4 g) ;
      mkN : (s1,s2: Str) -> Gender -> N 
          = \s1,s2,g -> lin N (mkNending s1 s2 g) ;
    };


  mkN1 : Str -> Gender ->  N = \x,g ->
        case x of {
          c + ("α"|"η") => mkNoun_thalassa x g ;
          c + ("ας"|"ης"|"ής"|"έας"| "ος") => mkNoun_touristas x g;
          c + ("ι"|"υ"|"όι"|"άι") => mkNoun_agori x  g ;
          c + ("ον"|"όν"|"άν"|"αν" | "εν" ) => mkNoun_endiaferon x  g
        }  ** {lock_N = <>} ;

  mkNending : Str -> Str -> Gender ->  N = \x,n,g ->
        case <x,n> of {
          <c + "ος", c + "ων"> => mkNoun_anthropos x  n g ;
          <c + "η", c + "εις"> => mkNoun_kivernisi x  n g ;
          <c + "ης", c + "ηδες"> => mkNoun_fournaris x  n g ;
          <c + "ας", c + "ων"> => mkNoun_filakas x  n g ;
          <c + "ο", c + "ων"> => mkNoun_prosopo x  n g ;
          <c + ("ώς" | "ός" | "ως" ) , c + ("ος"|"ός" ) > => mkNoun_fws x  n g ;
          <c + ("μα" | "ιμο" ), c + "ατα"> => mkNoun_provlima x  n g ;
          <c + "ος", c + "η"> => mkNoun_megethos x  n g 
        }  ** {lock_N = <>} ;
   


      mkN2 : N -> Prep -> N2 ; ---η μητέρα + γενική
      ofN2 : N -> N2 ; 
      mkN2 = \n,p -> n ** {lock_N2 = <> ; c2 = p} ;
      ofN2 n = mkN2 n gen  ;

      mkN3 : N -> Prep -> Prep  -> N3 ;
      mkN3 = \n,p,q -> n ** {lock_N3 = <> ; c2 = p ; c3 = q} ;



      mkPN = overload {
        mkPN : (anna : Str) -> PN
            = \p -> lin PN (regName p)  ;
        mkPN : (nm,gm,am,vm,pn,pa : Str)  -> Gender -> PN 
            = \ nm,gm,am,vm,pn,pa, g -> lin PN (mkName  nm  gm  am  vm pn pa g) ;
        } ; 

      makeNP = overload {
          makeNP : (_,_,_: Str) -> Number -> Gender -> NP = mkpanta;
          makeNP : Str -> Number -> Gender ->Bool -> NP = mkkati
        } ;


      mkpanta : Str -> Str -> Str -> Number -> Gender -> NP = 
        \tapanta, twnpantwn,stapanta, n, g -> let ag = agrP3 g n in
        {s = \\c => case c of
            {Nom | Vocative => {c1 = [] ; c2 = [];
                   comp = tapanta; isClit = False
                  } ; 
              Gen |CPrep P_Dat => {c1 =  []; c2 = [];
                   comp = twnpantwn; isClit = False};
              Acc => {c1 =  []; c2 = [];
                   comp = tapanta; isClit = False};
              CPrep P_se => {c1 =  []; c2 = [];
                   comp = stapanta ; isClit = False};
              CPrep PNul => {c1 =  []; c2 = [];
                   comp = tapanta; isClit = False}
            };
          a =  ag ;
          isNeg = False ;
          lock_NP = <>
          };

      mkkati : Str ->Number -> Gender -> Bool -> NP = 
        \kati, n, g,b -> let ag = agrP3 g n in
        {s = \\c => case c of
           {Nom | Vocative |Gen |CPrep P_Dat |Acc |CPrep P_se |CPrep PNul=> {c1 = [] ; c2 = [];
              comp = kati; isClit = False} 
            };
          a =  ag ;
          isNeg = b ;
          lock_NP = <>
          };



      mkA = overload {
        mkA : (a : Str) -> A 
            = \a -> lin A (regAdj a) ;     
        mkA : (a,b: Str) -> A 
            = \a,b -> lin A (mkA1 a b)  
        };



      mkAd:  Str -> A = \s -> regAdj1 s **{lock_A = <>} ;
      mkAd2 : Str -> A = \s -> regAdj2 s **{lock_A = <>} ;
      mkAd3 : Str -> A = \s -> regAdj3 s **{lock_A = <>} ;
      mkAd4 : Str -> A = \s -> regAdj4 s **{lock_A = <>} ;
      mkAd5 : Str -> A = \s -> regAdj5 s **{lock_A = <>} ;
      mkAdIrreg : Str -> A = \s -> irregAdj s **{lock_A = <>} ;

      mkA1 : Str -> Str ->  A = \x,n ->
          case <x,n> of {
            <c + "ης", c + "ες"> => mkAdjective4 x n ; 
            <c + "ων", c + "όντων"> => mkAdjective3 x n ;
            <c + "ύς", c + "έως"> => mkAdjectiveIr x n  
            }  ** {lock_A = <>} ;



      mkA2 : A -> Prep -> A2 ;
      mkA2 a p = a ** {c2 = p ; lock_A2 = <>} ;

      mkA2V : A -> Prep -> Prep -> A2V;
      A2S, A2V : Type = A2 ;
      mkA2V v p q = mkA2 v p ** {s3 = q.p2 ; c3 = q.p1 ; lock_A2V = <>} ;
 

      mkAV  v  = v ** { lock_AV = <>} ;
      mkAV  : A ->  AV ;
      AS, AV : Type = A ;

      mkAS  : A -> AS ; 
      mkAS  v = v ** {lock_AS = <>} ;

      mkV2 = overload {
        mkV2 : V -> V2  
            = dirV2 ;  
        mkV2 : V -> Prep -> V2 
            = mmkV2
        } ;
 
      mkVS  : V -> VS ;
      mkVS  v = v ** {m = \\_ => Ind; lock_VS = <>} ;

      mkVQ  : V -> VQ ;
      mkVQ  v = v ** {lock_VQ = <>} ;

 
      mkVV : V -> VV ;
      mkVV  v = v ** {c2 = complAcc ; lock_VV = <>} ;

      mkVA  : V -> VA ;
      mkVA  v = v ** {lock_VA = <>} ;



      acc :  Prep ; 
      gen   : Prep ; 
      dat     : Prep ; 
      prepse : Prep ;
      mkPrep : Str -> Preposition ;
      mkPrep2 : Str -> Preposition ;
      mkPrep3 : Str ->  Preposition ;
      mkPrep4 : Str ->  Preposition ;

      Preposition = Compl ;
      acc = complAcc ** {lock_Prep = <>} ;
      gen = complGen ** {lock_Prep = <>} ;
      dat = complDat ** {lock_Prep = <>} ;
      prepse =  complPrepSe** {lock_Prep = <>} ;
      mkPrep p = {s = p ; c = CPrep PNul ; isDir = False ; lock_Prep = <>} ;
      mkPrep2 p = {s = p ; c = CPrep P_se ; isDir = False ; lock_Prep = <>} ;  -----for compround preposition using a preposition plus "σε"(μέσα σε)
      mkPrep3 p = {s = p ; c = Gen ; isDir = False ; lock_Prep = <>} ;   -----preposition that takes a genitive instead of accusative
      mkPrep4 p = {s = p ; c = CPrep P_Dat ; isDir = False ; lock_Prep = <>} ;   -----for few prepositions that use dative

      Preposition : Type ;
      mkPreposition : Str -> Preposition ;
      mkPreposition = mkPrep ;
      mkPreposition2 : Str -> Preposition ;
      mkPreposition2 = mkPrep2 ;
      mkPreposition3 : Str ->  Preposition ;
      mkPreposition3 = mkPrep3 ;
      mkPreposition4 : Str ->  Preposition ;
      mkPreposition4 = mkPrep4 ;

       mkV3 : overload {
          mkV3 : V -> V3 ;                   
          mkV3 : V -> Prep -> V3 ;        
          mkV3 : V -> Prep -> Prep -> V3  
          } ;

        mkV3 = overload {
          mkV3 : V -> V3 = dirdirV3 ;               -- dino,_,_
          mkV3 : V -> Prep -> V3 = dirV3 ;          -- bazw,_,se
          mkV3 : V -> Prep -> Prep -> V3 = mmkV3    -- milaw, se, gia
          } ;

        mmkV3 v p q = v ** {c2 = p ; c3 = q ; lock_V3 = <>} ;
        dirV3 v p = mmkV3 v acc p ;
        dirdirV3 v = dirV3 v gen ;

        mmkV3    : V -> Prep -> Prep -> V3 ;  -- milaw, se, gia
        dirV3    : V -> Prep -> V3 ;          -- dino,_,se
        dirdirV3 : V -> V3 ;                  -- dino,_,_


        mmkV : V -> Str -> V ;
        mmkV v s = v ** {s = s } ;
        expressV : V -> Str -> V = \v,s -> mmkV v s ;

        mmkV2 : V -> Prep -> V2 ;
        mmkV2 v p = v ** {c2 = p ; lock_V2 = <>} ;
        dirV2 : V -> V2 = \v -> mmkV2 v acc ;
        

         mkV2V : V -> Prep -> Prep -> V2V ;
         mkV2V v p q = mmkV3 v p q ** {lock_V2V = <>} ;

         mkV2S : V -> Prep -> V2S ; 
         mkV2S v p = mmkV2 v p ** {mn,mp = Ind ; lock_V2S = <>} ;

         mkV2Q : V -> Prep -> V2Q ;
         mkV2Q v p = mmkV2 v p ** {lock_V2Q = <>} ;
          
         mkV2A : V -> Prep -> Prep -> V2A ;
         mkV2A v p q = mmkV3 v p q ** {lock_V2A = <>} ;


        mkV0  : V -> V0 ;
        V0 : Type ;
        V0 : Type = V;
        mkV0  v = v ** {lock_V0 = <>} ;

        mkNV : Verb -> V = \v -> {s = v.s ;vtype = v.vtype ;lock_V = <> } ;

        ---- for verbs that are formed periphrastically /usually a verb and a noun ( to lie -> λέω ψέματα / to sunbathe -> κάνω ηλιοθεραπεία)----
        compoundV : Verb -> Str -> V = \v,f -> {s = \\vf => v.s ! vf ++ f; lock_V = <>} ; 


         v_mk_Prepei  :(x1,x2 : Str)   -> V = \x1,x2 -> mkNV (mk_Prepei  x1 x2) ;
         v_Verb1a :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (Verb1a x1 x2 x3 x4) ;
         v_Verb1b :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (Verb1b x1 x2 x3 x4) ;
         v_Verb1c :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (Verb1c x1 x2 x3 x4) ;
         v_Verb1d :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (Verb1d x1 x2 x3 x4) ;
         
         v_Verb1dx :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (Verb1dx x1 x2 x3 x4) ;
         v_Verb1dxx :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (Verb1dxx x1 x2 x3 x4) ;
         v_Verb1dxxx :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (Verb1dxxx x1 x2 x3 x4) ;
         v_Verb1prepSuf :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (Verb1prepSuf x1 x2 x3 x4) ;

         v_Verb2a :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (Verb2a x1 x2 x3 x4) ;
         v_Verb2b :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (Verb2b x1 x2 x3 x4) ;
         v_Verb2c :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (Verb2c x1 x2 x3 x4) ;

         v_Verb2Ba :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (Verb2Ba x1 x2 x3 x4) ;
         v_Verb2Bb :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (Verb2Bb x1 x2 x3 x4) ;
         v_mkVerb2B3 :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (mkVerb2B3 x1 x2 x3 x4) ;
         v_Verbirreg_pigaInw :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (Verbirreg_pigaInw x1 x2 x3 x4) ;
         v_mkVerbAproswpo :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (mkVerbAproswpo x1 x2 x3 x4) ;

         v_VerbContr :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (VerbContr x1 x2 x3 x4) ;
         v_VerbContr2 :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (VerbContr2 x1 x2 x3 x4) ;
         v_VerbContrIrreg :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (VerbContrIrreg x1 x2 x3 x4) ;
         v_VerbContrIrreg2 :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (VerbContrIrreg2 x1 x2 x3 x4) ;
         v_VerbContrIrreg3 :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (VerbContrIrreg3 x1 x2 x3 x4) ;
         v_VerbContrIrregNPassPerf :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (VerbContrIrregNPassPerf x1 x2 x3 x4) ;
         v_VerbExw :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (VerbExw x1 x2 x3 x4) ;
         v_VerbExwNoPass :(x1,x2,x3,x4 : Str)   -> V = \x1,x2,x3,x4 -> mkNV (VerbExwNoPass x1 x2 x3 x4) ;

         v_VerbContr2NoPassive :(x1,x2,x3,x4,x5 : Str)   -> V = \x1,x2,x3,x4,x5 -> mkNV (VerbContr2NoPassive x1 x2 x3 x4 x5) ;
         v_VerbNoPassive1 :(x1,x2,x3,x4,x5 : Str)   -> V = \x1,x2,x3,x4,x5 -> mkNV (VerbNoPassive1 x1 x2 x3 x4 x5) ;
         v_VerbNoPassive2syll :(x1,x2,x3,x4,x5 : Str)   -> V = \x1,x2,x3,x4,x5 -> mkNV (VerbNoPassive2syll x1 x2 x3 x4 x5) ;
         v_Verb2aIrreg :(x1,x2,x3,x4,x5 : Str)   -> V = \x1,x2,x3,x4,x5 -> mkNV (Verb2aIrreg x1 x2 x3 x4 x5) ;
         v_VerbNpperf :(x1,x2,x3,x4,x5 : Str)   -> V = \x1,x2,x3,x4,x5 -> mkNV (VerbNpperf x1 x2 x3 x4 x5) ;
         v_VerbNpperf2 :(x1,x2,x3,x4,x5 : Str)   -> V = \x1,x2,x3,x4,x5 -> mkNV (VerbNpperf2 x1 x2 x3 x4 x5) ;
         v_VerbIN :(x1,x2,x3,x4,x5 : Str)   -> V = \x1,x2,x3,x4,x5 -> mkNV (VerbIN x1 x2 x3 x4 x5) ;
         
         v_VerbDeponent :(x1,x2,x3,x4,x5,x6 : Str)   -> V = \x1,x2,x3,x4,x5,x6-> mkNV (VerbDeponent x1 x2 x3 x4 x5 x6) ;
         v_VerbDeponent2 :(x1,x2,x3,x4,x5,x6 : Str)   -> V = \x1,x2,x3,x4,x5,x6-> mkNV (VerbDeponent2 x1 x2 x3 x4 x5 x6) ;
         v_VerbNoPassive :(x1,x2,x3,x4,x5,x6 : Str)   -> V = \x1,x2,x3,x4,x5,x6-> mkNV (VerbNoPassive x1 x2 x3 x4 x5 x6) ;
         v_VerbNoPassive2 :(x1,x2,x3,x4,x5,x6 : Str)   -> V = \x1,x2,x3,x4,x5,x6-> mkNV (VerbNoPassive2 x1 x2 x3 x4 x5 x6) ;
         v_VerbNoPassive3 :(x1,x2,x3,x4,x5,x6 : Str)   -> V = \x1,x2,x3,x4,x5,x6-> mkNV (VerbNoPassive3 x1 x2 x3 x4 x5 x6) ;
         v_VerbNoPassive4 :(x1,x2,x3,x4,x5,x6 : Str)   -> V = \x1,x2,x3,x4,x5,x6-> mkNV (VerbNoPassive4 x1 x2 x3 x4 x5 x6) ;
         v_VerbNoPassive5 :(x1,x2,x3,x4,x5,x6 : Str)   -> V = \x1,x2,x3,x4,x5,x6-> mkNV (VerbNoPassive5 x1 x2 x3 x4 x5 x6) ;
         v_VerbContracIrregNopassive :(x1,x2,x3,x4,x5,x6 : Str)   -> V = \x1,x2,x3,x4,x5,x6-> mkNV (VerbContracIrregNopassive x1 x2 x3 x4 x5 x6) ;
         v_VerbContracIrregNopassive2 :(x1,x2,x3,x4,x5,x6 : Str)   -> V = \x1,x2,x3,x4,x5,x6-> mkNV (VerbContracIrregNopassive2 x1 x2 x3 x4 x5 x6) ;

         v_VerbDeponent3 :(x1,x2,x3,x4,x5,x6,x7 : Str)   -> V = \x1,x2,x3,x4,x5,x6,x7-> mkNV (VerbDeponent3 x1 x2 x3 x4 x5 x6 x7) ;
         v_VerbDeponent4 :(x1,x2,x3,x4,x5,x6,x7 : Str)   -> V = \x1,x2,x3,x4,x5,x6,x7-> mkNV (VerbDeponent4 x1 x2 x3 x4 x5 x6 x7) ;
         v_VerbDeponent5 :(x1,x2,x3,x4,x5,x6,x7 : Str)   -> V = \x1,x2,x3,x4,x5,x6,x7-> mkNV (VerbDeponent5 x1 x2 x3 x4 x5 x6 x7) ;





      
  }
