--# -path=.:/Users/aarne/GF/next-lib/present

concrete TestAttemptoSwe of TestAttempto = AttemptoSwe ** 
  open SyntaxSwe, ParadigmsSwe, IrregSwe, (C = ConstructX) in {

lin card_N = mkkN "kort" neutrum ;
lin water_MCN = mkCN (mkN "vatten" "vattnet" "vatten" "vattnen") ;
lin john_PN = mkPN "John" ;
lin apple_N = mkkN "äpple" neutrum ;
lin sleep_V = IrregSwe.sova_V ;
lin young_A = mkA "ung" ;
lin dog_N = mkkN "hund" utrum ;
lin animal_N = mkkN "djur" neutrum ;
lin wait_V = mkV "vänta" ;
lin man_N = mkCN (mkN "man" "mannen" "män" "männen") ;
lin woman_N = mkkN "kvinna" utrum ;
lin give_V3 = mkV3 giva_V (mkPrep []) (mkPrep "till") ;
lin tired_A = mkA "trött" ;
lin rich_A = mkA "rik" ;
lin customer_N = mkCN (mkN "kund" "kunder") ;
lin enter_V2 = mkV2 (mkV (mkV "träder") "in") (mkPrep "i") ;
lin bank_N = mkCN (mkN "bank" "banker") ;
lin satisfied_A = mkA "nöjd" "nöjt" ;
lin lucky_A = mkA "lycklig" ;
lin well_known_A = mkA "välkänd" ;
lin important_A = mkA "viktig" ;
lin expensive_A = mkA "dyr" ;
lin fill_in_V2 = mkV2 (mkV (mkV "fyller") "i") ;
lin form_N = mkkN "formulär" neutrum ;
lin age_N = mkkN "ålder" utrum ;
lin teacher_N = mkkN "lärare" utrum ;
lin successful_A = mkA "framgångsrik" ;
lin fond_A2 = mkA2 (mkA "förtjust") (mkPrep "i") ;
lin garden_N = mkkN "trädgård" utrum ;
lin morning_N = mkCN (mkN "morgon" "morgonen" "morgnar" "morgnarna") ;
lin code_N = mkCN (mkN "kod" "koder") ;
lin drinkable_A = mkA "drickbar" ;
lin work_V = mkV "arbeta" ;
lin admitted_A = mkA "godkänd" ;
lin eat_V2 = mkV2 äta_V ;
lin burger_N = mkkN "hamburgare" utrum ;
lin earn_V2 = mkV2 "tjäna" ;
lin income_N = mkCN (mkN "inkomst" "inkomster") ;
lin england_PN = mkPN "England" ;
lin beginning_N = mkCN (mkN "början" "början" "början" "början") ;
lin office_N = mkkN "kontor" neutrum ;
lin interested_A2 = mkA2 (compoundA (mkA "intresserad" "intresserat")) (mkPrep "i") ;
lin classroom_N = mkCN (mkN "klassrum" "klassrummet" "klassrum" "klassrummen") ;
lin manually_Adv = mkAdv "manuellt" ;
lin slot_N = mkkN "hål" neutrum ;
lin patiently_Adv = mkAdv "tålamodigt" ;
lin course_N = mkCN (mkN "kurs" "kurser") ;
lin carefully_Adv = mkAdv "försiktigt" ;
lin time_N = mkCN (mkN "tid" "tider") ;
lin believe_VS = mkVS (mkV "tro") ;
lin seriously_Adv = mkAdv "seriöst" ;
lin clerk_N = mkCN (mkN "kontorist" "kontorister") ;
lin screen_N = mkkN "skärm" neutrum ;
lin blink_V = mkV "blinka" ;
lin bed_N = mkkN "säng" utrum ;
lin container_N = mkkN "behållare" utrum ;
lin automated_teller_N = mkCN (mkN "automat" "automater") ;
lin reject_V2 = mkV2 "förkasta" ;
lin accept_V2 = mkV2 "acceptera" ;
lin type_V2 = mkV2 skriva_V ; ----
lin know_VS = mkVS veta_V ;
lin manager_N = mkCN (mkN "chef" "chefer") ;
lin oversleep_V = mkV "försova" "försov" "försovit" ;
lin valid_A = mkA "giltig" ;
lin see_V2 = mkV2 se_V ;
lin bark_V = mkV "skäller" ;
lin go_V2 = mkV2 gå_V to_Prep ;
lin brother_N = mkCN (mkN "bror" "brodern" "bröder" "bröderna") ;
lin mary_PN = mkPN "Mary" ;
lin machine_N = mkCN (mkN "maskin" "maskiner") ;
lin correct_A = mkA "korrekt" ;

oper mkkN : Str -> Gender -> CN = \n,g -> mkCN (ParadigmsSwe.mkN n g) ;

lin kilogram_Unit = mkCN (mkN "kilo" "kilot" "kilo" "kilon") ;

lin
  in_Prep = SyntaxSwe.in_Prep ;
  at_Prep = mkPrep "på" ;
  into_Prep = mkPrep "in i" ;

}
