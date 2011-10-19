concrete AbsParadigmsEngAbs of AbsParadigmsEng = AbsToAPIAbs ** {

lincat Gender, Number, Case = {ind : Str; attr : Str} ;

lin Human = mkSimpCat "human" ;
lin Nonhuman = mkSimpCat "nonhuman" ;
lin Masculine = mkSimpCat "masculine" ;
lin Feminine = mkSimpCat "feminine" ;

lin Singular = mkSimpCat "singular" ;
lin Plural = mkSimpCat "plural" ;

lin Nominative = mkSimpCat "nominative" ;
lin Genitive = mkSimpCat "genitive" ;

lin mkN_1 = mkUnaryStringCat "mkN" ;
lin mkN_2 = mkBinaryStringCat "mkN" ;
lin mkN_3 = mkQuaternaryStringCat "mkN" ;
lin mkN_4 = mkBinaryCat "mkN" ;
lin mkN_5 = mkStringCatCat "mkN" ;

lin mkN2_1 = mkUnaryStringCat "mkN2" ; 
lin mkN2_2 = mkUnaryCat "mkN2" ; 
lin mkN2_3 = mkCatStringCat "mkN2" ;       
lin mkN2_4 = mkBinaryCat "mkN2" ;
lin mkN2_5 = mkBinaryStringCat "mkN2" ; 

lin mkN3_1 = mkTernaryCat "mkN3"  ;

lin mkPN_1 = mkUnaryStringCat "mkPN" ;
lin mkPN_2 = mkUnaryCat "mkPN" ;

lin mkQuant_1 = mkBinaryStringCat "mkQuant" ;
lin mkQuant_2 = mkQuaternaryStringCat "mkQuant" ;

lin mkA_1  = mkUnaryStringCat "mkA" ;
lin mkA_2 = mkBinaryStringCat "mkA" ;
lin mkA_3 = mkQuaternaryStringCat "mkA" ;

lin CompoundA = mkUnaryCat "compoundA" ;
lin SimpleA = mkUnaryCat "simpleA" ;
lin IrregAdv = mkCatStringCat "irregAdv" ;   


lin mkA2_1 = mkBinaryCat "mkA2" ;
lin mkA2_2 = mkCatStringCat "mkA2" ;
lin mkA2_3  = mkStringCatCat "mkA2" ;
lin mkA2_4 = mkBinaryStringCat "mkA2" ;

lin mkAdv_1 = mkUnaryStringCat "mkAdv" ;

lin mkAdV_1 = mkUnaryStringCat "mkAdV" ;

lin mkAdA_1 = mkUnaryStringCat "mkAdA" ;

lin mkAdN_1 = mkUnaryStringCat "mkAdN" ;

lin mkPrep_1 = mkUnaryStringCat "mkPrep" ;
lin NoPrep  = mkSimpCat "NoPrep" ;

lin mkV_1 = mkUnaryStringCat "mkV" ;
lin mkV_2 = mkBinaryStringCat "mkV" ;
lin mkV_3 = mkTernaryStringCat "mkV" ;
lin mkV_4 = mkQuintaryStringCat "mkV" ;
lin mkV_5 = mkStringCatCat "mkV" ;

lin PartV = mkCatStringCat "partV" ;
lin ReflV = mkUnaryCat "reflV" ;

lin mkV2_1 = mkUnaryCat "mkV2" ;
lin mkV2_2 = mkBinaryCat "mkV2" ;

lin mkV3_1 = mkUnaryCat "mkV3" ;
lin mkV3_2 = mkTernaryCat "mkV3" ;

lin mkVS_1 = mkUnaryCat "mkVS" ;

lin mkV2S_1 = mkBinaryCat "mkV2S" ;

lin mkVV_1 = mkUnaryCat "mkVV" ; 
lin IngVV = mkUnaryCat "ingVV" ;

lin mkV2V_1 = mkTernaryCat "mkV2V" ;
lin IngV2V = mkTernaryCat "mkV2V" ;

lin mkVA_1 = mkUnaryCat "mkVA" ;

lin mkV2A_1 = mkBinaryCat "mkV2A" ;

lin mkVQ_1 = mkUnaryCat "mkVQ" ;

lin mkV2Q_1 = mkBinaryCat "mkV2Q" ;







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
