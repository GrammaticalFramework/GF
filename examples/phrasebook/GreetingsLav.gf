--# -path=.:present
concrete GreetingsLav of Greetings = SentencesLav [Greeting, mkGreeting] **
open Prelude 
in {

	flags
		coding = utf8 ;

	lin
		GBye = mkGreeting "atā" ;
		GCheers = mkGreeting "priekā" ;
		GDamn = mkGreeting "sasodīts" ;
		GExcuse, GExcusePol = mkGreeting "atvainojiet" ;
		GGoodDay = mkGreeting "labdien" ;
		GGoodEvening = mkGreeting "labvakar" ;
		GGoodMorning = mkGreeting "labrīt" ;
		GGoodNight = mkGreeting "ar labunakti" ;
		GGoodbye = mkGreeting "visu labu" ;
		GHello = mkGreeting "sveiki" ;
		GHelp = mkGreeting "palīdziet" ;
		GHowAreYou = mkGreeting "kā klājas" ;
		GLookOut = mkGreeting "uzmanīgi" ;
		GNiceToMeetYou, GNiceToMeetYouPol = mkGreeting "prieks iepazīties" ;
		GPleaseGive, GPleaseGivePol = mkGreeting "lūdzu" ;
		GSeeYouSoon = mkGreeting "uz drīzu tikšanos" ;
		GSorry, GSorryPol = mkGreeting "piedodiet" ;
		GThanks = mkGreeting "paldies" ;
		GTheCheck = mkGreeting "rēķins" ;
		GCongratulations = mkGreeting "apsveicu" ;
		GHappyBirthday = mkGreeting "daudz laimes dzimšanas dienā" ;
		GGoodLuck = mkGreeting "veiksmīgi" ;

}
