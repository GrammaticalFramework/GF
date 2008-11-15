--# -path=.:/Users/aarne/GF/next-lib/present

concrete TestAttemptoGer of TestAttempto = AttemptoGer ** 
  open SyntaxGer, ParadigmsGer, IrregGer, (C = ConstructX) in {

lin card_N = mkkN "Karte" ;
lin water_MCN = mkgN "Wasser" "Wasser" neuter ;
lin john_PN = mkPN "John" ;
lin apple_N = mkgN "Apfel" "Äpfel" masculine ;
lin sleep_V = IrregGer.schlafen_V ;
lin young_A = mkA "jung" ;
lin dog_N = mkgN "Hund" "Hunde" masculine ;
lin animal_N = mkgN "Tier" "Tiere" neuter ;
lin wait_V = mkV "warten" ;
lin man_N = mkgN "Mann" "Männer" masculine ;
lin woman_N = mkgN "Frau" "Frauen" feminine ;
lin give_V3 = accdatV3 geben_V ;
lin tired_A = mkA "müde" ;
lin rich_A = mkA "reich" ;
lin customer_N = mkgN "Kunde" "Kunden" masculine ;
lin enter_V2 = mkV2 (mkV "ein" treten_V) (mkPrep "in" accusative) ;
lin bank_N = mkgN "Bank" "Banken" feminine ;
lin satisfied_A = mkA "zufrieden" ;
lin lucky_A = mkA "glücklich" ;
lin well_known_A = mkA "bekannt" ;
lin important_A = mkA "wichtig" ;
lin expensive_A = mkA "teuer" ;
lin fill_in_V2 = mkV2 (mkV "ab" (mkV "füllen")) ;
lin form_N = mkgN "Formular" "Formulare" neuter ;
lin age_N = mkgN "Alter" "Älter" masculine ;
lin teacher_N = mkgN "Lehrer" "Lehrer" masculine ;
lin successful_A = mkA "erfolgreich" ;
lin fond_A2 = mkA2 (mkA "verliebt") (mkPrep "in" dative) ;
lin garden_N = mkgN "Garten" "Gärten" masculine ;
lin morning_N = mkgN "Morgen" "Morgen" masculine ;
lin code_N = mkgN "Code" "Codes" masculine ;
lin drinkable_A = mkA "trinkbar" ;
lin work_V = mkV "arbeiten" ;
lin admitted_A = mkA "zugelassen" ;
lin eat_V2 = mkV2 essen_V ;
lin burger_N = mkgN "Hamburger" "Hamburger" masculine ;
lin earn_V2 = mkV2 (no_geV (mkV "verdienen")) ;
lin income_N = mkgN "Einkommen" "Einkommen" neuter ;
lin england_PN = mkPN "England" ;
lin beginning_N = mkgN "Anfang" "Anfänge" masculine ;
lin office_N = mkgN "Büro" "Büros" neuter ;
lin interested_A2 = mkA2 (mkA "interessiert") (mkPrep "an" dative) ; ----
lin classroom_N = mkkN "Klasse" ;
lin manually_Adv = mkAdv "manuell" ;
lin slot_N = mkgN "Hohl" "Höhle" masculine ; ----
lin patiently_Adv = mkAdv "geduldig" ;
lin course_N = mkkN "Kurse" ; ----
lin carefully_Adv = mkAdv "vorsichtig" ;
lin time_N = mkgN "Zeit" "Zeiten" feminine ;
lin believe_VS = mkVS (mkV "glauben") ;
lin seriously_Adv = mkAdv "seriös" ; ----
lin clerk_N = mkgN "Angestellt" "Angestellten" masculine ; ----
lin screen_N = mkgN "Schirm" "Schirme" masculine ;
lin blink_V = mkV "blinken" ; ----
lin bed_N = mkgN "Bett" "Bette" neuter ;
lin container_N = mkgN "Gehälter" "Gehälter" masculine ;
lin automated_teller_N = mkgN "Automat" "Automate" neuter ;
lin reject_V2 = mkV2 (mkV "verwerfen" "verwirft" "verwarf" "verwürfe" "verworfen") ;
lin accept_V2 = mkV2 (mkV "an" nehmen_V) ;
lin type_V2 = mkV2 schreiben_V ;
lin know_VS = mkVS wissen_V ;
lin manager_N = mkgN "Manager" "Manager" masculine ; ----
lin oversleep_V = schlafen_V ; ----
lin valid_A = mkA "gültig" ;
lin see_V2 = mkV2 sehen_V ;
lin bark_V = mkV "bellen" ;
lin go_V2 = mkV2 gehen_V to_Prep ;
lin brother_N = mkgN "Bruder" "Brüder" masculine ;
lin mary_PN = mkPN "Mary" ;
lin machine_N = mkkN "Maschine" ;
lin correct_A = mkA "korrekt" ;

lin kilogram_Unit = mkgN "Kilo" "Kilo" neuter ;

oper 
  mkkN : Str -> CN = \n -> mkCN (ParadigmsGer.mkN n) ;
  mkgN : Str -> Str -> Gender -> CN = \s,n,g -> mkCN (ParadigmsGer.mkN s n g) ;

lin
  in_Prep = SyntaxGer.in_Prep ;
  at_Prep = SyntaxGer.to_Prep ;
  into_Prep = mkPrep "in" accusative ;

}
