--# -path=.:present

concrete TestAttemptoFin of TestAttempto = AttemptoFin ** 
  open SyntaxFin, ParadigmsFin, (C = ConstructX) in {

lin card_N = mkkN "kortti" ;
lin water_MCN = mkCN (mkN "vesi" "vesiä") ;
lin john_PN = mkPN "John" ;
lin apple_N = mkkN "omena" ;
lin sleep_V = mkV "nukkua" ;
lin young_A = mkA (mkN "nuori" "nuoria") ;
lin dog_N = mkkN "koira" ;
lin animal_N = mkkN "eläin" ;
lin wait_V = mkV "odottaa" ;
lin man_N = mkCN (mkN "mies" "miehiä") ;
lin woman_N = mkCN (mkN "nainen") ;
lin give_V3 = dirV3 (mkV "antaa") allative ;
lin tired_A = mkA "väsynyt" ;
lin rich_A = mkA "rikas" ;
lin customer_N = mkkN "asiakas" ;
lin enter_V2 = mkV2 (mkV "astua") illative ; ----
lin bank_N = mkkN "pankki" ;
lin satisfied_A = mkA "tyytyväinen" ;
lin lucky_A = mkA "onnekas" ;
lin well_known_A = mkA "tunnettu" ;
lin important_A = mkA "tärkeä" ;
lin expensive_A = mkA "kallis" ;
lin fill_in_V2 = mkV2 (mkV "täyttää") ;
lin form_N = mkkN "kaavake" ;
lin age_N = mkkN "ikä" ;
lin teacher_N = mkkN "opettaja" ;
lin successful_A = mkA "menestyksekäs" ;
lin fond_A2 = mkA2 (mkA "kiintynyt") (casePrep illative) ; ----
lin garden_N = mkkN "puutarha" ; ----
lin morning_N = mkkN "aamu" ;
lin code_N = mkkN "koodi" ;
lin drinkable_A = mkA "juotava" ;
lin work_V = mkV "työskennellä" ;
lin admitted_A = mkA "hyväksytty" ;
lin eat_V2 = mkV2 (mkV "syödä") partitive ;
lin burger_N = mkkN "hampurilainen" ;
lin earn_V2 = mkV2 "ansaita" ;
lin income_N = mkkN "tulo" ; ----
lin england_PN = mkPN "Englanti" ;
lin beginning_N = mkkN "alku" ;
lin office_N = mkkN "toimisto" ;
lin interested_A2 = mkA2 (mkA "kiinnostunut") (casePrep elative) ; ----
lin classroom_N = mkkN "luokkahuone" ;
lin manually_Adv = mkAdv "käsin" ;
lin slot_N = mkkN "aukko" ;
lin patiently_Adv = mkAdv "kärsivällisesti" ;
lin course_N = mkkN "kurssi" ;
lin carefully_Adv = mkAdv "huolellisesti" ;
lin time_N = mkkN "aika" ;
lin believe_VS = mkVS (mkV "uskoa") ;
lin seriously_Adv = mkAdv "vakavasti" ;
lin clerk_N = mkkN "virkailija" ;
lin screen_N = mkkN "kuvaruutu" ;
lin blink_V = mkV "vilkkua" ;
lin bed_N = mkkN "sänky" ;
lin container_N = mkkN "astia" ;
lin automated_teller_N = mkkN "pankkiautomaatti" ;
lin reject_V2 = mkV2 "hylätä" ;
lin accept_V2 = mkV2 "hyväksyä" ;
lin type_V2 = mkV2 "kirjoittaa" ; ----
lin know_VS = mkVS (mkV "tietää") ;
lin manager_N = mkkN "johtaja" ;
lin oversleep_V = mkV "nukkua" ; ----
lin valid_A = mkA "pätevä" ;
lin see_V2 = mkV2 (mkV "nähdä") ;
lin bark_V = mkV "haukkua" ;
lin go_V2 = mkV2 (mkV "mennä") illative ;
lin brother_N = mkkN "veli" ;
lin mary_PN = mkPN "Mary" ; ----
lin machine_N = mkkN "kone" ;
lin correct_A = mkA "oikea" ;

lin kilogram_Unit = mkkN "kilo" ;

oper mkkN : Str -> CN = \n -> mkCN (ParadigmsFin.mkN n) ;

lin
  in_Prep = SyntaxFin.in_Prep ;
  at_Prep = casePrep adessive ;
  into_Prep = casePrep illative ;

}
