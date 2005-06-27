concrete sharedCoreEng of sharedCore = open GenResEng in {

--flags lexer=codelit ; unlexer=codelit ; startcat=DMoveList ;
flags conversion=finite;


--# -path=.:../

lin
	makeS s = {s = s.s};



-- Linearization of Greet, Quit, Answer, Ask and Request are moved to 
-- System and User respectively because of differing linearizations


-- ICM

	makeICMPer perI = {s = perI.s};

	makeICMAcc accI = {s = accI.s};

	makeICMMove icm = {s = icm.s};




-- LEXICON

pattern

	top_command = (variants {["top"] ; ["forget everything"] ; ["start over"]});
	-- end_command = "quit";

	help_command = variants {"get" ; ""} ++ "help" ;

	yes = variants {"yes" ; "yup" ; "yeppers"};
	no = variants {"no" ; "nope" };

	greet_command = variants { "hello" ; "hi" ; "yo"};
	bye_command = variants { ["goodbye"] ; "bye" ; "end" };

-- ICMs
-- Moved to User and System respectively because of differing linearisations
-- for user and system.


}






