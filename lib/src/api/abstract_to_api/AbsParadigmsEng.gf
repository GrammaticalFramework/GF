abstract AbsParadigmsEng = AbsToAPI ** {

cat Gender ; Number ; Case ;

fun Human : Gender ;
fun Nonhuman : Gender ;
fun Masculine : Gender ;
fun Feminine : Gender ;

fun Singular : Number ;
fun Plural : Number ;

fun Nominative : Case ;
fun Genitive : Case ;

fun mkN_1 : String -> N ;
fun mkN_2 : String -> String -> N ;
fun mkN_3 : String -> String -> String -> String -> N ;
fun mkN_4 : Gender -> N -> N ;
fun mkN_5 : String -> N -> N ;

fun mkN2_1 : String -> N2 ; 
fun mkN2_2 : N -> N2 ; 
fun mkN2_3 : N -> String -> N2 ; 
fun mkN2_4 : N -> Prep -> N2 ;
fun mkN2_5 : String -> String -> N2 ; 

fun mkN3_1 : N -> Prep -> Prep -> N3 ;

fun mkPN_1 : String -> PN ;
fun mkPN_2 : N -> PN ;

fun mkQuant_1 : String -> String -> Quant ;
fun mkQuant_2 : String -> String -> String -> String -> Quant ;

fun mkA_1  : String -> A ;
fun mkA_2 : String -> String -> A ;
fun mkA_3 : String -> String -> String -> String -> A ;

fun CompoundA : A -> A ;
fun SimpleA : A -> A ;
fun IrregAdv : A -> String -> A ;


fun mkA2_1 : A -> Prep -> A2 ;
fun mkA2_2 : A -> String -> A2 ;
fun mkA2_3 : String -> Prep -> A2 ;
fun mkA2_4 : String -> String -> A2 ;

fun mkAdv_1 : String -> Adv ;

fun mkAdV_1 : String -> AdV ;

fun mkAdA_1 : String -> AdA ;

fun mkAdN_1 : String -> AdN ;

fun mkPrep_1 : String -> Prep ;
fun NoPrep : Prep ;

fun mkV_1 : String -> V ;
fun mkV_2 : String -> String -> V ;
fun mkV_3 : String -> String -> String -> V ;
fun mkV_4 : String -> String -> String -> String -> String -> V ;
fun mkV_5 : String -> V -> V ;

fun PartV : V -> String -> V ;
fun ReflV : V -> V ;

fun mkV2_1 : V -> V2 ;
fun mkV2_2 : V -> Prep -> V2 ;

fun mkV3_1 : V -> V3 ;
fun mkV3_2 : V -> Prep -> Prep -> V3 ;

fun mkVS_1 : V -> VS ;

fun mkV2S_1 : V -> Prep -> V2S ;

fun mkVV_1 : V -> VV ;
fun IngVV : V -> VV ;

fun mkV2V_1 : V -> Prep -> Prep -> V2V ;
fun IngV2V : V -> Prep -> Prep -> V2V ;

fun mkVA_1 : V -> VA ;

fun mkV2A_1 : V -> Prep -> V2A ;

fun mkVQ_1 : V -> VQ ;

fun mkV2Q_1 : V -> Prep -> V2Q ;

}
