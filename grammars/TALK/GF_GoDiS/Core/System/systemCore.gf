-- general grammar
--# -path=.:../Shared

abstract systemCore = sharedCore ** {

cat

	DMoves;


-- internal forms

	--Proposition;
	Other_ICM;
	Other_ICM_Followed;
	Sem_ICM;
	Sem_ICM_Followed;
	Und_ICM;
	Und_ICM_Followed;
	


-- Confirm
-- This is where the system confirms that the action has been taken.
	Confirm;


-- Report
-- This is where the system reports on the actions taken
-- i.e. "The song Leviathan was added to the playlist"

-- The report consists of a Request. 
	Report;
	Status;

-- Asks specific for the System 
	SystemAsk;


-- Issues 

	Issue;
	PropIssue;
	AskIssue;
	ListIssue;
	IssueList;
	ListItem;


fun

-- BASICS

	makeSofDMoves : DMoves -> S;
	makeDMPair : DMove -> DMove -> DMoves;
	makeDMList : DMove -> DMoves -> DMoves;


-- ICM

	-- Plus en som tar en strang... oj oj for genereringen.
--	makeICMPerString : Per_ICM_Followed -> String -> ICM;
	makeICMPerString : Per_ICM_Followed -> ICM;

	makeICMSem : Sem_ICM -> ICM;
	makeICMSemMoveReq : Sem_ICM_Followed -> Request -> ICM;
	makeICMSemMoveAnswer : (t : Task) -> Sem_ICM_Followed -> Answer t -> ICM;
	makeICMSemMoveAsk : (t : Task) -> Sem_ICM_Followed -> Ask t -> ICM;

	makeICMUnd : Und_ICM -> ICM;
	makeICMUndProp : (t : Task) -> Und_ICM_Followed -> Proposition t -> ICM;

	makeICMOther : Other_ICM -> ICM;
	makeICMOtherIssue : Other_ICM_Followed -> ListItem -> ICM;
	makeICMOtherReq : (t : Task) -> Other_ICM_Followed -> Action t -> ICM;

	makeICMAccIssue : Acc_ICM_Followed -> Issue -> ICM;

-- !!! Väldigt rekursivt!!!!




-- Confirm
	--makeConfirm : SingleAction -> Confirm;
	makeConfirmMove : Confirm -> DMove;


-- Report

	-- Behöver en till kategori, en Status... 
	-- Hmm... undrar hur jag ska gora det här snyggt. 


	makeReport : SingleAction -> Status -> Report;
	makeReportMove : Report -> DMove;

-- Ask
	makeSystemAsk : SystemAsk -> DMove;
	makeAskSet : IssueList -> SystemAsk;
	makeInstantiatedAsk : (t : Task) -> Action t -> SystemAsk;
	makeInstantiatedAskSingle : SingleAction -> SystemAsk;


-- Issues

	makePropIssue : (t : Task) -> Proposition t -> PropIssue;

	makeIssueProp : PropIssue -> Issue;
	makeIssueAsk : AskIssue -> Issue;
	makeIssueList : ListIssue -> Issue;

	makePropIssue : (t : Task) -> Proposition t -> PropIssue;
	makeAskIssue : (t : Task) -> Ask t -> AskIssue;

	--makeListItemProp : PropIssue -> ListItem;
	makeListItemAsk : AskIssue -> ListItem;
	makeListItemAction : (t : Task) -> Action t  -> ListItem;
	makeListItemSingleAction : SingleAction -> ListItem;

	makeListIssue : ListItem -> ListItem -> ListIssue;
	makeListIssue2 : ListItem -> ListIssue ->ListIssue;
	
	makeActualListIssue : ListIssue -> IssueList;

-- Lexicon
	makeBasicAsk : SystemAsk;	

	sem_pos : Sem_ICM;
	sem_pos_followed : Sem_ICM_Followed;
	sem_neg : Sem_ICM;
	--sem_int : Sem_ICM;

	und_pos : Und_ICM;
	und_pos_followed : Und_ICM_Followed;
	und_neg : Und_ICM;
	und_int : Und_ICM_Followed;

	reraise : Other_ICM;
	reraise_followed : Other_ICM_Followed;
	loadplan : Other_ICM;
	accomodate : Other_ICM_Followed;
	reaccomodate : Other_ICM_Followed;

	a_String : String;

	status_done : Status;
	status_initiated : Status;
	status_pending : Status;
	status_failed : Status;

}






