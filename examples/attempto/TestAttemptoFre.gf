--# -path=.:/Users/aarne/GF/next-lib/present

concrete TestAttemptoFre of TestAttempto = AttemptoFre ** 
  open SyntaxFre, ParadigmsFre, IrregFre, (C = ConstructX) in {

lin card_N = mkkN "carte" ;
lin water_MCN = mkgN "eau" feminine ;
lin john_PN = mkPN "John" ;
lin apple_N = mkkN "pomme" ;
lin sleep_V = mkV IrregFre.dormir_V2 ;
lin young_A = mkA "jeune" ;
lin dog_N = mkkN "chien" ;
lin animal_N = mkkN "animal" ;
lin wait_V = mkV "attendre" ;
lin man_N = mkgN "homme" masculine ;
lin woman_N = mkkN "femme" ;
lin give_V3 = mkV3 (mkV "donner") accusative dative ;
lin tired_A = mkA "fatigué" ;
lin rich_A = mkA "riche" ;
lin customer_N = mkkN "client" ;
lin enter_V2 = mkV2 "entrer" ;
lin bank_N = mkkN "banque" ;
lin satisfied_A = mkA "content" ;
lin lucky_A = mkA "fortuné" ;
lin well_known_A = mkA "connu" ;
lin important_A = mkA "important" ;
lin expensive_A = mkA "cher" ;
lin fill_in_V2 = mkV2 "remplir" ;
lin form_N = mkgN "formulaire" masculine ;
lin age_N = mkgN "âge" masculine ;
lin teacher_N = mkkN "professeur" ;
lin successful_A = mkA "réussi" ;
lin fond_A2 = mkA2 (mkA "attaché") dative ;
lin garden_N = mkkN "jardin" ;
lin morning_N = mkkN "matin" ;
lin code_N = mkgN "code" masculine ;
lin drinkable_A = mkA "potable" ;
lin work_V = mkV "travailler" ;
lin admitted_A = mkA "admis" ;
lin eat_V2 = mkV2 "manger" ;
lin burger_N = mkkN "hamburger" ;
lin earn_V2 = mkV2 "gagner" ;
lin income_N = mkkN "revenu" ;
lin england_PN = mkPN "Angleterre" ;
lin beginning_N = mkkN "début" ;
lin office_N = mkkN "bureau" ;
lin interested_A2 = mkA2 (mkA "interessé") (mkPrep "par") ;
lin classroom_N = mkkN "classe" ;
lin manually_Adv = mkAdv "manuellement" ;
lin slot_N = mkkN "trou" ;
lin patiently_Adv = mkAdv "patiemment" ;
lin course_N = mkkN "cours" ;
lin carefully_Adv = mkAdv "soigneusement" ;
lin time_N = mkkN "temps" ;
lin believe_V = mkV croire_V2 ;
lin seriously_Adv = mkAdv "sérieusement" ;
lin clerk_N = mkkN "employé" ;
lin screen_N = mkkN "écran" ;
lin blink_V = mkV "clignoter" ;
lin bed_N = mkkN "lit" ;
lin container_N = mkkN "récipient" ;
lin automated_teller_N = mkgN "automate" masculine ;
lin reject_V2 = mkV2 "rejeter" ;
lin accept_V2 = mkV2 "accepter" ;
lin type_V2 = mkV2 "taper" ;
lin know_V = mkV savoir_V2 ;
lin manager_N = mkkN "directeur" ;
lin oversleep_V = mkV dormir_V2 ; ----
lin valid_A = mkA "valide" ;
lin see_V2 = voir_V2 ;
lin bark_V = mkV "aboyer" ;
lin go_V2 = mkV2 aller_V dative ;
lin brother_N = mkgN "frère" masculine ;
lin mary_PN = mkPN "Mary" ;
lin machine_N = mkkN "machine" ;
lin correct_A = mkA "correct" ;

lin kilogram_Unit = mkkN "kilo" ;

oper 
  mkkN : Str -> CN = \n -> mkCN (ParadigmsFre.mkN n) ;
  mkgN : Str -> Gender -> CN = \n,g -> mkCN (ParadigmsFre.mkN n g) ;

lin
  in_Prep = SyntaxFre.in_Prep ;
  at_Prep = SyntaxFre.to_Prep ;
  into_Prep = mkPrep "dans" ;

}
