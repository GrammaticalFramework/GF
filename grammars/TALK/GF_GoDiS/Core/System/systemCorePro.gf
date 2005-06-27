

concrete systemCorePro of systemCore = sharedCorePro ** {


flags lexer=codelit ; unlexer=concat ;
flags conversion=finite;


lincat


-- Confirm
-- This is where the system confirms that the action has been taken.
	Confirm = {s : Str};


-- Report
-- This is where the system reports on the actions taken
-- i.e. "The song Leviathan was added to the playlist"

-- The report consists of a Request. 
	Report = {s : Str};

lin

-- BASICS

	makeSofDMoves dms = {s = "[" ++ dms.s ++ "]"};
	makeDMPair dm1 dm2 = {s = dm1.s ++ "," ++ dm2.s};
	makeDMList dm dms = {s = dm.s ++ "," ++ dms.s};



-- Confirm
	--makeConfirm req = { s = "confirm" ++ "(" ++ req.s ++ ")"};
	makeConfirmMove conM = {s = "confirm" ++ "(" ++ conM.s ++ ")"};


-- Report
	makeReport req status = { s = "report" ++ "(" ++ req.s ++ "," ++ status.s ++ ")"};
	makeReportMove repM = {s = repM.s};

-- Ask

	makeSystemAsk sysA = {s = "ask" ++ "(" ++ sysA.s ++ ")"};
	makeAskSet set = {s = set.s};
	makeInstantiatedAsk _ insA = {s = "action" ++ "(" ++ insA.s ++ ")"};
	makeInstantiatedAskSingle insA = {s = "action" ++ "(" ++ insA.s ++ ")"};


-- ICM
	-- Plus en som tar en strang... oj oj for genereringen.
	-- makeICMPerString perI string = {s = perI.s ++ string.s};
	makeICMPerString perI = {s = perI.s };
	
	makeICMSem semI = {s = semI.s};
	makeICMSemMoveReq semI req = {s = semI.s ++ ":" ++ req.s};
	makeICMSemMoveAnswer _ semI ans = {s = semI.s ++ ":" ++ ans.s};
	makeICMSemMoveAsk _ semI ask = {s = semI.s ++ ":" ++ ask.s};

	makeICMUnd undI = {s = undI.s};
	makeICMUndProp _ undI prop = {s = undI.s ++ ":" ++ "usr" ++ "*" ++ prop.s};


	makeICMOther otherI = {s = otherI.s};
	makeICMOtherIssue otherI issue = {s = otherI.s ++ ":" ++ issue.s};
	makeICMOtherReq _ other req = {s = other.s ++ ":" ++ req.s};

	makeICMAccIssue otherI issue = {s = otherI.s ++ ":" ++ issue.s};

-- !!! Väldigt rekursivt!!!!

-- Isues

	makePropIssue _ prop = {s = prop.s};

	makeIssueProp pi = {s = pi.s};
	makeIssueAsk ai = {s = ai.s};
	makeIssueList li = {s = li.s};

	makePropIssue _ prop = {s = prop.s};
	makeAskIssue _ ask = {s = "X" ++ "^" ++ ask.s ++ "(" ++ "X" ++ ")"};

	--makeListItemProp propI = {s = propI.s};
	makeListItemAsk askI = {s = "issue" ++ "(" ++ askI.s ++ ")"};
	makeListItemAction _ action = {s = variants {("action" ++ "(" ++ action.s ++ ")") ;
							action.s }};
	makeListItemSingleAction action = {s = variants { ("action" ++ "(" ++ action.s ++ ")") ;
							action.s }};

	makeListIssue prop1 prop2 = {s = prop1.s ++ "," ++ prop2.s};
	makeListIssue2 prop list = {s = prop.s ++ "," ++ list.s};

	makeActualListIssue list = {s = "set" ++ "(" ++ "[" ++ list.s ++ "]" ++ ")"};	


pattern

-- LEXICON

	makeBasicAsk = ["x ^ action ( x )"];  -- OBS OBS!!!

	sem_pos = ["sem * pos"];
	sem_pos_followed = ["sem * pos"];
	sem_neg = ["sem * neg"];
	--sem_int = ["sem * int"];

	und_pos = ["und * pos"];
	und_pos_followed = ["und * pos"];
	und_neg = ["und * neg"];
	und_int = ["und * int"];

	reraise = "reraise";
	reraise_followed = "reraise";
	loadplan = "loadplan";
	accomodate = "accomodate";
	reaccomodate = "reaccomodate"; 

	status_done = "done";
	status_initiated = "initiated";
	status_pending = "pending";
	status_failed = "failed";



}

