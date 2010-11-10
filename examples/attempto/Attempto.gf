abstract Attempto = 
  Numeral, Symbols ** {

flags startcat = ACEText ;

cat CN ;
cat NP ;
cat Card ;
---cat Numeral ;
cat PN ;
cat A ;
cat A2 ;
cat AP ;
cat RS ;
cat Pron ;
cat Prep ;
cat S ;
cat VP ;
cat V ;
cat VS ;
cat V2 ;
cat V3 ;
cat Adv ;
cat Conj ;
cat IP ;
cat IAdv ;
cat QS ;
cat Text ;
cat RP ;

fun aNP : CN -> NP ;
fun theNP : CN -> NP ;
fun cardNP : Card -> CN -> NP ;
fun noNP : CN -> NP ;
fun everyNP : CN -> NP ;
fun eachNP : CN -> NP ;
fun notEveryNP : CN -> NP ;
fun notEachNP : CN -> NP ;
  

fun theCollNP : CN -> NP ;
fun someCollNP : CN -> NP ;
fun allCollNP : CN -> NP ;
fun noCollNP : CN -> NP ;


fun eachTheNP : CN -> NP ;
fun eachSomeNP : CN -> NP ;
fun eachNumNP : Card -> CN -> NP ;

cat MCN ;

fun someMassNP : MCN -> NP ;
fun noMassNP : MCN -> NP ;
fun allMassNP : MCN -> NP ;
fun notAllMassNP : MCN -> NP ;

---fun one_Card : Card ;
---fun two_Card : Card ;
---fun five_Card : Card ;
---fun ten_Card : Card ;


fun pnNP : PN -> NP ;
fun intNP : Int -> NP ;
fun floatNP : Float -> NP ;


-- arithmetic expressions with + - * /

-- strings "foo" and "foo" & "bar

-- sets {a,b,c}

-- lists [a,b,c]

fun it_NP : NP ;
fun he_NP : NP ;
fun she_NP : NP ;
fun he_she_NP : NP ;
fun they_NP : NP ;


-- reflexive pronouns: itself, himself, herself, himself/herself, themselves

--fun someone_NP : NP ;
fun somebody_NP : NP ;
fun something_NP : NP ;
--fun noone_NP : NP ;
fun nobody_NP : NP ;
fun nothing_NP : NP ;
--fun not_everyoneNP : NP ;
fun not_everybodyNP : NP ;
fun not_everythingNP : NP ;

fun at_leastNP : Card -> CN -> NP ;
fun not_at_leastNP : Card -> CN -> NP ;
fun at_mostNP : Card -> CN -> NP ;
fun not_at_mostNP : Card -> CN -> NP ;
fun more_thanNP : Card -> CN -> NP ;
fun not_more_thanNP : Card -> CN -> NP ;

fun nothing_butNP : CN -> NP ; -- nothing but apples
fun nothing_butMassNP : MCN -> NP ; -- nothing but water
fun nobody_butNP : PN -> NP ; -- nobody but John
fun no_butNP : CN -> PN -> NP ; -- no man but John

cat Unit ; -- SI measurement units

fun unitNP : Card -> Unit -> NP ;
fun unit_ofNP : Card -> Unit -> CN -> NP ;      -- 3 kg of apples
fun unit_ofMassNP : Card -> Unit -> MCN -> NP ; -- 3 l of water

fun apposVarCN : CN -> Var -> CN ;  -- a man X
fun termNP : Term -> NP ;

fun conjNP : NP -> NP -> NP ;

-- 2.2.1

fun adjCN : AP -> CN -> CN ;
fun positAP : A -> AP ;
fun comparAP : A -> AP ;
fun superlAP : A -> AP ; 


-- 2.2.2

fun relCN : CN -> RS -> CN ;
fun relNP : NP -> RS -> NP ;
fun andRS : RS -> RS -> RS ;
fun orRS : RS -> RS -> RS ;

fun suchCN : CN -> S -> CN ;

fun predRS : RP -> VP -> RS ;
fun slashRS : RP -> NP -> V2 -> RS ;

fun which_RP : RP ;
fun eachRP : RP ;

-- 2.2.4

fun genNP : NP -> CN -> NP ; -- everybody's customer
fun ofCN : CN -> NP -> CN ; -- dog of John and Mary
fun genOwnNP : NP -> CN -> NP ; -- his own customer

-- 2.3.1

fun vpS : NP -> VP -> S ;
fun neg_vpS : NP -> VP -> S ;
fun not_provably_vpS : NP -> VP -> S ;

fun vVP  : V -> VP ;
fun vsVP : VS -> S  -> VP ;
fun v2VP : V2 -> NP -> VP ;
fun v3VP : V3 -> NP -> NP -> VP ;

-- 2.3.2

fun apVP    : AP -> VP ;
fun compVP  : A -> NP -> VP ;  -- John is richer than Mary
fun as_asVP : AP -> NP -> VP ; -- John is as rich as Mary
fun more_thanVP : AP -> NP -> VP ; -- John is as rich as Mary

-- John is as fond-of Mary as of Sue
-- John is more fond-of Mary than of Sue

cat PP ;
--cat [PP] {1} ;
--fun ppVP : [PP] -> VP ; -- John is in the garden in the morning
fun ppVP : PP -> VP ; -- iteration is done by advPP and modVP

fun prepPP : Prep -> NP -> PP ;
fun advPP : PP -> Adv ;

-- 2.3.5

fun canVP : VP -> VP ;
fun mustVP : VP -> VP ;
fun have_toVP : VP -> VP ;

-- 2.4

fun modVP : VP -> Adv -> VP ;

-- 3.2

fun thereNP : NP -> S ;  -- there is/are

-- 3.3

fun formulaS : Formula -> S ;

-- 3.4.1

fun coordS : Conj -> S -> S -> S ;

fun and_Conj : Conj ;
fun or_Conj : Conj ;
fun commaAnd_Conj : Conj ; -- lower precedence
fun commaOr_Conj : Conj ;

-- 3.4.3

fun for_everyS : CN -> S -> S ;
fun for_eachS : CN -> S -> S ;
fun for_each_ofS : Card -> CN -> S -> S ; -- for each of 3 men
fun for_allMassS : MCN -> S -> S ; -- for all water

-- 3.4.4

fun if_thenS : S -> S -> S ;
fun falseS : S -> S ; -- it is false that
fun not_provableS : S -> S ; -- it is not provable that
fun possibleS : S -> S ; -- it is possible that
fun not_possibleS : S -> S ; 
fun necessaryS : S -> S ; 
fun not_necessaryS : S -> S ; 

-- 3.5

fun npQS : NP -> VP -> QS ;
fun ipQS : IP -> VP -> QS ;
fun iadvQS : IAdv -> NP -> VP -> QS ;

fun where_IAdv : IAdv ;
fun when_IAdv : IAdv ;
fun whoSg_IP : IP ;
fun whoPl_IP : IP ;

fun there_ipQS : IP -> QS ; -- there is who

fun whoseIP : CN -> IP ;  -- whose dog

-- 3.6

fun np_impVP : NP -> VP -> Text ; -- John, go to the bank!

-- 4

cat ACEText ;
fun consText : Text -> ACEText -> ACEText ;

fun baseText : Text -> ACEText ;

fun sText : S -> Text ;
fun qsText : QS -> Text ;

-- more

fun npVP  : NP -> VP ;              -- is a bank
fun impVP : VP -> Text ;            -- go to the bank!
fun numeralCard : Numeral -> Card ; -- fifteen banks
fun digitsCard : Digits -> Card ;   -- 8 banks
fun have_V2 : V2 ;                  -- has (an apple)
fun v2_byVP : V2 -> NP -> VP ;      -- is bought by a customer


}


