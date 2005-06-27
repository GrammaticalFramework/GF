--# -path=.:../

concrete sharedCorePro of sharedCore = {


flags lexer=code ; unlexer=concat ;
flags conversion=finite;

lin

	-- Borde inte request, question, etc.. ligga i en 
	-- generell resursfil så att man kan komma åt dem.
	-- Det är inte speciellt snyggt att skriva ut det 
	-- ibland här och ibland i den specifika filen..
	-- Det känns som om det borde vara en "resurs"fråga. 

	-- Det ÄR en resursgrej... titta i video grammatiken:
	-- prologResource.gf och generalProlog.gf 
	-- som Aarne fixade till från Karins pyssel. 
	-- Hakparanteserna borde också fixas till på samma sätt... 

	makeS s = {s = "[" ++ s.s ++ "]"};

-- Greet
	makeGreetMove gre = {s = gre.s };

-- Quit
	makeQuitMove qui = {s = qui.s };

-- Answer
	makeAnswer _ ans = {s = "answer" ++ "(" ++ ans.s ++ ")"};
	makeNegAnswer _ ans = {s =  "answer" ++ "(" ++ "not" ++ "(" ++ ans.s ++ ")" ++ ")"};
	makeAnswerMove _ sha = {s = sha.s };
	makeNegAnswerMove _ sha = {s = sha.s};

-- Ask
	singleAsk _ ask = {s = "X" ++ "^" ++ ask.s ++ "(" ++ "X" ++ ")"};
	makeYesNoAsk _ action = {s = action.s};
	makeAsk ask = {s = "ask" ++ "(" ++ ask.s ++ ")"};

-- Request
	makeRequest req   = {s = "request" ++ "(" ++ req.s ++ ")" };
	makeRequestMove reqM = {s = reqM.s};
	makeNegRequestMove reqM = {s = "not" ++ "(" ++ reqM.s ++ ")"};


-- ICM

	makeICMPer perI = {s = perI.s};

	makeICMAcc accI = {s = accI.s};
--	makeICMAccProp accI prop = {s = accI.s ++ ":" ++ prop.s};


	makeICMMove icm = {s = "icm" ++ ":" ++ icm.s};

-- LEXICON

pattern
	top_command = "top";
	-- end_command = "quit";

	help_command = "help";

	yes = "yes";
	no = "no";

	greet_command = "greet";
	bye_command = "quit";

	-- ICMs
	per_pos = ["per * pos"];
	per_neg = ["per * neg"];
	per_int = ["per * int"];


	acc_pos = ["acc * pos"];
	acc_neg = ["acc * neg"];
	acc_neg_alone = ["acc * neg"];
	--acc_int = "acc*int";


}









