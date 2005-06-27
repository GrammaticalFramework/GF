concrete sharedCoreSwe of sharedCore = open GenResSwe in {

--flags lexer=codelit ; unlexer=codelit ;
flags conversion=finite;

--# -path=.:../

lin
	makeS s = {s = s.s};

-- Linearizations of Greet, Quit, Answer, Ask and Request 
-- are moved to User and System respectively because of punctuation.

-- ICM

	makeICMPer perI = {s = perI.s};

	makeICMAcc accI = {s = accI.s};


	makeICMMove icm = {s = icm.s};




-- LEXICON

pattern

	top_command = (variants {["glömma allt"] ; ["börja om"]});
	-- end_command = "avsluta";

	help_command = variants {"få" ; "ha"} ++ "hjälp" ;

	yes = variants {"ja" ; "japp" ; "jajamen"};
	no = variants {"nej" ; "nepp" };

	greet_command = variants { "hej" ; "tjena" ; "hallå"};
	bye_command = variants { ["hejdå"] ; "sluta" ; "avbryt" };


-- ICMs
-- Linearization of ICMs are moved to User and System 
-- respectively because of differing linearizations.


}







