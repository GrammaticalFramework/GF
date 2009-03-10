--# -path=.:present

concrete TestAttemptoIta of TestAttempto = AttemptoIta ** 
  open SyntaxIta, ParadigmsIta, (C = ConstructX) in {

lin card_N = mkkN "carta" ;
lin water_MCN = mkgN "acqua" feminine ;
lin john_PN = mkPN "John" ;
lin apple_N = mkkN "mela" ;
lin sleep_V = mkV "dormire" ;
lin young_A = mkA "giovane" ;
lin dog_N = mkkN "cane" ;
lin animal_N = mkkN "animale" ;
lin wait_V = mkV "aspattare" ;
lin man_N = mkCN (mkN "uomo" "uomini" masculine) ;
lin woman_N = mkkN "donna" ;
lin give_V3 = mkV3 (mkV "dare") accusative dative ;
lin tired_A = mkA "stanco" ;
lin rich_A = mkA "ricco" ;
lin customer_N = mkkN "cliente" ;
lin enter_V2 = mkV2 "entrare" ;
lin bank_N = mkkN "banco" ;
lin satisfied_A = mkA "contento" ;
lin lucky_A = mkA "fortunato" ;
lin well_known_A = mkA "conosciuto" ;
lin important_A = mkA "importante" ;
lin expensive_A = mkA "caro" ;
lin fill_in_V2 = mkV2 "riempire" ; ----
lin form_N = mkgN "formulario" masculine ; ----
lin age_N = mkgN "età" feminine ;
lin teacher_N = mkkN "professore" ;
lin successful_A = mkA "riuscito" ;
lin fond_A2 = mkA2 (mkA "attaccato") dative ; ----
lin garden_N = mkkN "giardino" ;
lin morning_N = mkkN "mattino" ;
lin code_N = mkgN "code" masculine ; ----
lin drinkable_A = mkA "potabile" ;
lin work_V = mkV "lavorare" ;
lin admitted_A = mkA "ammesso" ;
lin eat_V2 = mkV2 "mangiare" ;
lin burger_N = mkkN "hamburger" ;
lin earn_V2 = mkV2 "guadagnare" ; ----
lin income_N = mkkN "revenuta" ; ----
lin england_PN = mkPN "Inghilterra" ;
lin beginning_N = mkkN "inizio" ;
lin office_N = mkkN "ufficio" ;
lin interested_A2 = mkA2 (mkA "interessato") (mkPrep "per") ;
lin classroom_N = mkgN "classe" feminine ;
lin manually_Adv = mkAdv "manualmente" ;
lin slot_N = mkkN "troco" ; ----
lin patiently_Adv = mkAdv "pazientemente" ; ----
lin course_N = mkkN "corso" ;
lin carefully_Adv = mkAdv "piano" ; ----
lin time_N = mkkN "tempo" ;
lin believe_VS = mkVS (mkV "credere") ; ----
lin seriously_Adv = mkAdv "seriosamente" ;
lin clerk_N = mkkN "clerico" ; ----
lin screen_N = mkkN "screen" ; ----
lin blink_V = mkV "clignotare" ; ----
lin bed_N = mkkN "letto" ;
lin container_N = mkkN "recipiente" ;
lin automated_teller_N = mkgN "automa" masculine ; ----
lin reject_V2 = mkV2 "rigettare" ; ----
lin accept_V2 = mkV2 "accettare" ;
lin type_V2 = mkV2 "stampare" ; ----
lin know_VS = mkVS (mkV "sapere") ; ----
lin manager_N = mkkN "direttore" ;
lin oversleep_V = mkV "dormire" ; ----
lin valid_A = mkA "valido" ;
lin see_V2 = mkV2 (mkV "vedere") ; ----
lin bark_V = mkV "aboiare" ; ----
lin go_V2 = mkV2 (mkV "viaggiare") dative ; ----
lin brother_N = mkgN "fratello" masculine ;
lin mary_PN = mkPN "Mary" ;
lin machine_N = mkkN "macchina" ;
lin correct_A = mkA "corretto" ;

lin kilogram_Unit = mkkN "chilo" ;

oper 
  mkkN : Str -> CN = \n -> mkCN (ParadigmsIta.mkN n) ;
  mkgN : Str -> Gender -> CN = \n,g -> mkCN (ParadigmsIta.mkN n g) ;

lin
  in_Prep = SyntaxIta.in_Prep ;
  at_Prep = SyntaxIta.to_Prep ;
  into_Prep = mkPrep "dentro" ;

}
