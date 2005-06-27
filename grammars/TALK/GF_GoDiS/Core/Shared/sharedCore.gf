-- general grammar
--# -path=.:../

abstract sharedCore = {

cat

	-- Nuance needs a S category, easiest fix.
	S;

	-- Simple Dialogue Moves
	DMove;



-- Basic forms

	Action Task;
	SingleAction;
	Proposition Task;

	Task;


-- Dialogue moves (DMove) are: ask, answer, greet, quit, request, confirm, report


-- Greet
	-- Simple greet move... 
	Greet ;

-- Quit
-- Simple quit move...
	Quit;

-- Answer
-- Answers are moves that answer questions, posed or not.
	Answer Task;
	NegAnswer Task;

-- Ask
-- Ask moves are those moves that ask for plans.
-- "vad vill du göra?" "vad kan jag göra" "hjälp"(?)
-- Hur är det med ja/nej frågor?
	Ask Task;
	SingleAsk;


-- Request
-- Requests are those moves that have no arguments and 
-- generate no specific informationfilled answers.
	Request;


-- ICM

	ICM;
	Per_ICM;
	Per_ICM_Followed;
	Acc_ICM;
	Acc_ICM_Followed;



fun

	makeS : DMove -> S;

-- Greet
	makeGreetMove : Greet -> DMove;

-- Quit
	makeQuitMove : Quit -> DMove;

-- Answer
	makeAnswer : (t : Task) -> Proposition t -> Answer t;
	makeAnswerMove : (t : Task) -> Answer t -> DMove;


	makeNegAnswer : (t : Task) -> Proposition t -> NegAnswer t;	
	makeNegAnswerMove : (t : Task) -> NegAnswer t -> DMove;

-- Ask
	singleAsk : (t : Task) -> Ask t -> SingleAsk;
	makeYesNoAsk : (t : Task) -> Action t -> SingleAsk;
	makeAsk : SingleAsk -> DMove;


-- Request
	makeRequest : SingleAction -> Request;
	makeRequestMove : Request -> DMove;
	makeNegRequestMove : Request -> DMove;


-- ICM

	makeICMPer : Per_ICM -> ICM;
	makeICMAcc : Acc_ICM -> ICM;



	makeICMMove : ICM -> DMove;


-- LEXICON

	shortAnswer : Task;

	top_command : SingleAction;

	help_command : SingleAction;

	yes : Answer shortAnswer;
	no : Answer shortAnswer;

	greet_command : Greet;
	bye_command : Quit;


	-- ICMs
	per_pos : Per_ICM_Followed;
	per_neg : Per_ICM;
	per_int : Per_ICM;

	acc_pos : Acc_ICM;
	acc_neg_alone : Acc_ICM;
	acc_neg : Acc_ICM_Followed;
	--acc_int : Acc_ICM;

}



