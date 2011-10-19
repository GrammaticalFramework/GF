incomplete concrete AbsParadigmsSweI of AbsParadigmsSwe = AbsToAPI ** {

lincat Gender, Number = {ind : Str; attr : Str} ;


lin Utrum = mkSimpCat "utrum" ;
lin Neutrum = mkSimpCat "neutrum" ;

lin Singular = mkSimpCat "singular" ; 	
lin Plural = mkSimpCat "plural" ;
	
lin mkPrep_1 = mkUnaryStringCat "mkPrep" ; 	
lin NoPrep = mkSimpCat "noPrep" ;	

lin mkN_1 = mkUnaryStringCat "mkN" ; 
lin mkN_2 = mkBinaryStringCat "mkN" ;
lin mkN_3 = mkQuaternaryStringCat "mkN" ;	

lin mkN2_1 = mkBinaryCat "mkN2" ;

lin mkN3_1 = mkTernaryCat "mkN3" ; 

lin mkPN_1 = mkUnaryStringCat "mkPN" ;	
lin mkPN_2 = mkStringCatCat "mkPN" ;	
lin mkPN_3 str1 str2 o3 =  
    let sstr = "mkPN" ++ "'" ++ str1.s ++ "'" ++ "'" ++ str2.s ++ "'"  ++ o3.attr in
                  {ind = sstr; attr = "(" ++ sstr ++ ")" }; 	

lin mkA_1 = mkUnaryStringCat "mkA" ;	
lin mkA_2 = mkBinaryStringCat "mkA" ;	
lin mkA_3 = mkTernaryStringCat "mkA" ;	
lin mkA_4 = mkQuintaryStringCat "mkA" ;
lin mkA_5 str1 str2 str3 str4 str5 str6 str7 =  
  let sstr = "mkA" ++ "'" ++ str1.s ++ "'" ++ "'" ++ str2.s ++ "'" ++ "'" ++ str3.s ++ "'" ++ "'" ++ str4.s ++ "'" ++ "'" ++ str5.s ++ "'" ++ "'" ++ str6.s ++ "'" ++ "'" ++ str7.s ++ "'" in
                  {ind = sstr; attr = "(" ++ sstr ++ ")" };

lin CompoundA = mkUnaryCat "compoundA" ;

lin mkA2_1 = mkBinaryCat "mkA2" ;	

lin mkAdv_1 = mkUnaryStringCat "mkAdv" ;	

lin mkAdV_1 = mkUnaryStringCat "mkAdV" ;	

lin mkAdA_1 = mkUnaryStringCat "mkAdA" ;	

lin mkV_1  = mkUnaryStringCat "mkV" ;
lin mkV_2 = mkTernaryStringCat "mkV" ;
lin mkV_3 str1 str2 str3 str4 str5 str6 =  
  let sstr = "mkA" ++ "'" ++ str1.s ++ "'" ++ "'" ++ str2.s ++ "'" ++ "'" ++ str3.s ++ "'" ++ "'" ++ str4.s ++ "'" ++ "'" ++ str5.s ++ "'" ++ "'" ++ str6.s ++ "'"  in
                  {ind = sstr; attr = "(" ++ sstr ++ ")" };
lin mkV_4 = mkCatStringCat "mkV" ;

lin DepV = mkUnaryCat "depV" ;
lin ReflV = mkUnaryCat "reflV" ;

lin mkV2_1 = mkUnaryCat "mkV2" ;	
lin mkV2_2 = mkBinaryCat "mkV2" ;	

lin mkV3_1 = mkUnaryCat "mkV3" ;	
lin mkV3_2 = mkBinaryCat "mkV3" ;	
lin mkV3_3 = mkTernaryCat "mkV3" ;	

lin mkVS_1 = mkUnaryCat "mkVS" ;	

lin mkV2S_1 = mkBinaryCat "mkV2S" ;	

lin mkVV_1 = mkUnaryCat "mkVV" ;	

lin mkV2V_1 = mkTernaryCat "mkV2V" ;	

lin mkVA_1 = mkUnaryCat "mkVA" ;	

lin mkV2A_1 = mkBinaryCat "mkV2A" ;	

lin mkVQ_1 = mkUnaryCat "mkVQ" ;	

lin mkV2Q_1 = mkBinaryCat "mkV2" ;	





oper mkUnaryStringCat : Str-> String -> {ind : Str ; attr : Str}  = 
      \s,str -> 
            let sstr = s ++ "'" ++ str.s ++ "'" in 
                     {ind  = sstr; attr  = "(" ++ sstr ++ ")"};

oper mkBinaryStringCat : Str -> String -> String -> {ind : Str ; attr : Str} = 
       \s, str1, str2 -> 
             let sstr = s ++ "'" ++ str1.s ++ "'" ++ "'" ++ str2.s ++ "'" in
                  {ind = sstr; attr = "(" ++ sstr ++ ")" };

oper mkTernaryStringCat : Str -> String -> String -> String -> {ind : Str ; attr : Str} =      
       \s, str1, str2, str3 -> 
             let sstr = s ++ "'" ++ str1.s ++ "'" ++ "'" ++ str2.s ++ "'" ++ "'" ++ str3.s ++ "'" in
                  {ind = sstr; attr = "(" ++ sstr ++ ")" };

oper mkQuaternaryStringCat : Str -> String -> String -> String -> String -> {ind : Str ; attr : Str} = 
       \s, str1, str2, str3, str4 -> 
             let sstr = s ++ "'" ++ str1.s ++ "'" ++ "'" ++ str2.s ++ "'" ++ "'" ++ str3.s ++ "'" ++ "'" ++ str4.s ++ "'" in
                  {ind = sstr; attr = "(" ++ sstr ++ ")" };

oper mkQuintaryStringCat : Str -> String -> String -> String -> String -> String -> {ind : Str ; attr : Str} = 
       \s, str1, str2, str3, str4, str5 -> 
             let sstr = s ++ "'" ++ str1.s ++ "'" ++ "'" ++ str2.s ++ "'" ++ "'" ++ str3.s ++ "'" ++ "'" ++ str4.s ++ "'" ++ "'" ++ str5.s ++ "'" in
                  {ind = sstr; attr = "(" ++ sstr ++ ")" };


oper mkCatStringCat : Str -> {ind : Str ; attr : Str} -> String -> {ind : Str ; attr : Str} = 
  \s, ob, str1 -> 
        let sstr = s ++ ob.attr ++ "'" ++ str1.s ++ "'" in
                   {ind = sstr ; attr = "("++sstr ++")"} ;

oper mkStringCatCat : Str -> String -> {ind : Str ; attr : Str} -> {ind : Str ; attr : Str} = 
   \s, str1, ob ->
         let sstr = s ++ "'" ++ str1.s ++ "'" ++ ob.attr in 
                    {ind = sstr ; attr = "("++sstr ++")"} ;
                     

}
