resource icm100ResSwe = {

  param RefPol = Pos | Neg | Inter ;
  param RefLev = Per | Sem | Und | Acc ;

  oper ex1 : RefPol => RefLev => Str = table {
	Pos => table {
		Per => ["jag hörde"];	
		Sem => [""];
		Und => [""];
		Acc => ["okej"]
		};	

	Neg => table {
		Per => ["ursäkta jag hörde inte alls vad du sa"];	
		Sem => ["jag förstår inte vad du menar"];
		Und => ["jag förstår inte riktigt vad du menar"];
		Acc => ["tyvärr kan inte hantera"]
		};	
	
	Inter => table {
		Per => (variants{});	
	     	Sem => (variants{});
--		Und => ["stämmer det"]; --hack!
		Und => (variants{});
		Acc => (variants{})
		}
	};

}