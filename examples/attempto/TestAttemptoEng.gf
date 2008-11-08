--# -path=.:/Users/aarne/GF/next-lib/present

concrete TestAttemptoEng of TestAttempto = AttemptoEng ** 
  open SyntaxEng, ParadigmsEng, IrregEng, (C = ConstructX) in {

lin card_N = mkkN "card" ;
lin water_MCN = mkCN (mkkN "water") ;
lin john_PN = mkPN "John" ;
lin apple_N = mkkN "apple" ;
lin sleep_V = IrregEng.sleep_V ;
lin young_A = mkA "young" ;
lin dog_N = mkkN "dog" ;
lin animal_N = mkkN "animal" ;
lin wait_V = mkV "wait" ;
lin man_N = mkCN (mkN "man" "men") ;
lin woman_N = mkCN (mkN "woman" "women") ;
lin give_V3 = mkV3 give_V (mkPrep []) (mkPrep "to") ;
lin tired_A = mkA "tired" ;
lin rich_A = mkA "rich" ;
lin customer_N = mkkN "customer" ;
lin enter_V2 = mkV2 "enter" ;
lin bank_N = mkkN "bank" ;
lin satisfied_A = mkA "satisfied" ;
lin lucky_A = mkA "lucky" ;
lin well_known_A = mkA "well" ;
lin important_A = mkA "important" ;
lin expensive_A = mkA "expensive" ;
lin fill_in_V2 = mkV2 (partV (mkV "fill") "in") ;
lin form_N = mkkN "form" ;
lin age_N = mkkN "age" ;
lin teacher_N = mkkN "teacher" ;
lin successful_A = mkA "successful" ;
lin fond_A2 = mkA2 (mkA "fond") (mkPrep "of") ;
lin garden_N = mkkN "garden" ;
lin morning_N = mkkN "morning" ;
lin code_N = mkkN "code" ;
lin drinkable_A = mkA "drinkable" ;
lin work_V = mkV "work" ;
lin admitted_A = mkA "admitted" ;
lin eat_V2 = mkV2 eat_V ;
lin burger_N = mkkN "burger" ;
lin earn_V2 = mkV2 "earn" ;
lin income_N = mkkN "income" ;
lin england_PN = mkPN "England" ;
lin beginning_N = mkkN "beginning" ;
lin office_N = mkkN "office" ;
lin interested_A2 = mkA2 (mkA "interested") (mkPrep "in") ;
lin morning_N = mkkN "morning" ;
lin classroom_N = mkkN "classroom" ;
lin manually_Adv = mkAdv "manually" ;
lin slot_N = mkkN "slot" ;
lin patiently_Adv = mkAdv "patiently" ;
lin course_N = mkkN "course" ;
lin carefully_Adv = mkAdv "carefully" ;
lin time_N = mkkN "time" ;
lin believe_V = mkV "believe" ;
lin seriously_Adv = mkAdv "seriously" ;
lin clerk_N = mkkN "clerk" ;
lin screen_N = mkkN "screen" ;
lin blink_V = mkV "blink" ;
lin bed_N = mkkN "bed" ;
lin container_N = mkkN "container" ;
lin automated_teller_N = mkkN "automated" ;
lin reject_V2 = mkV2 "reject" ;
lin accept_V2 = mkV2 "accept" ;
lin type_V2 = mkV2 "type" ;
lin know_V = IrregEng.know_V ;
lin manager_N = mkkN "manager" ;
lin oversleep_V = mkV "oversleep" "overslept" "overslept" ;
lin valid_A = mkA "valid" ;
lin see_V2 = mkV2 see_V ;
lin bark_V = mkV "bark" ;
lin go_V2 = mkV2 go_V to_Prep ;
lin brother_N = mkkN "brother" ;
lin mary_PN = mkPN "mary" ;
lin machine_N = mkkN "machine" ;
lin correct_A = mkA "correct" ;

lin kilogram_Unit = mkkN "kilogram" ;

oper mkkN : Str -> CN = \n -> mkCN (ParadigmsEng.mkN n) ;

lin
  in_Prep = SyntaxEng.in_Prep ;
  at_Prep = mkPrep "at" ;
  into_Prep = mkPrep "into" ;

}
