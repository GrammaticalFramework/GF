concrete systemCoreEng of systemCore = sharedCoreEng ** {

--flags lexer=text ; unlexer=text ; startcat=DMoveList ;
--# -path=.:../:../Shared
flags conversion=finite;


lin

-- Greet
	makeGreetMove gre = {s = gre.s ++ "!"};

-- Quit
	makeQuitMove qui = {s = qui.s ++ "!"};

-- Answer
	makeAnswer _ ans = {s = ans.s};
	makeNegAnswer _ ans = {s = "not" ++ ans.s};
	makeAnswerMove _ sha = {s = sha.s ++ "."};
	makeNegAnswerMove  _ sha = {s = sha.s ++ "."};

-- Ask
	singleAsk _ ask = {s = ask.s};
	makeYesNoAsk _ action = {s = action.s};
	makeAsk ask = {s = ask.s ++ "."};


-- Request

	-- makeRequestMove moved to System and User respectively 
	-- because of differing linearizations

	makeRequest req = {s = req.s ++ "."};
	makeRequestMove req = {s =  req.s };
	makeNegRequestMove req = {s = req.s};

-- BASICS

	makeSofDMoves dms = {s = dms.s};
	makeDMPair dm1 dm2 = {s = dm1.s ++ dm2.s};
	makeDMList dm dms = {s = dm.s ++ dms.s};


-- Confirm

	--makeConfirm req = {s = ["managed to"] ++ req.s ++ "."};
	makeConfirmMove conM = {s = conM.s ++ "."};

-- Report 
	makeReport req status =  {s = status.s ++ req.s ++ "." };
	makeReportMove repM = {s = repM.s};


-- ICM

	-- makeICMPerString perI string = {s = perI.s ++ string.s ++ "."};
	makeICMPerString perI = {s = perI.s};
	
	makeICMSem semI = {s = semI.s};
	makeICMSemMoveReq semI req = {s = semI.s ++ req.s ++ "."};
	makeICMSemMoveAnswer _ semI ans = {s = semI.s ++ ans.s ++ "."};
	makeICMSemMoveAsk _ semI ask = {s = semI.s ++ ask.s ++ "."};


	makeICMUnd undI = {s = undI.s};
	makeICMUndProp _ undI prop = {s = prop.s ++ undI.s };

	makeICMAccIssue accI issue = {s = accI.s ++ [", i cannot answer questions about"] ++ issue.s ++ "."};

	makeICMOther otherI = {s = otherI.s };
	makeICMOtherIssue otherI issue = {s = otherI.s ++ issue.s ++ "."};
	makeICMOtherReq _ other req  = {s = other.s ++ req.s ++ "."};


-- Ask

	makeSystemAsk sysA = {s = sysA.s ++ "?"};
	makeAskSet set = {s = ["do you want to"] ++ set.s};
	makeInstantiatedAsk _ insA = {s = ["do you want to"] ++ insA.s };
	makeInstantiatedAskSingle insA = {s = ["do you want to"] ++ insA.s};

-- Isues

	makePropIssue _ prop = {s = prop.s};

	makeIssueProp pi = {s = pi.s};
	makeIssueAsk ai = {s = ai.s};
	makeIssueList li = {s = li.s};

	--makePropIssue _ prop = {s = prop.s};
	makeAskIssue _ ask = {s = ask.s};

	-- makeListItemProp propI = {s = propI.s};
	makeListItemAsk askI = {s = "ask" ++ "about" ++ askI.s};
	makeListItemAction _ action = {s = action.s};
	makeListItemSingleAction action = {s = action.s};

	makeListIssue prop1 prop2 = {s = prop1.s ++ "or" ++ prop2.s};
	makeListIssue2 prop list = {s = prop.s ++ "," ++ list.s};

	makeActualListIssue list = {s = list.s};	


pattern

	makeBasicAsk = ["what can i do for you"];

	sem_pos = "okay";
	sem_pos_followed = [""];
	sem_neg = ["i am sorry i do not understand ."];
	-- sem_int = ["what do you mean with"];

	und_pos = ["okay ."];
	und_pos_followed = ["."];
	und_neg = ["i do not understand what you mean ."];
	und_int = [", is this correct ?"]; -- följer yttrandet!!!

	per_pos = ["i thought you said"]; -- följs av en sträng

	reraise = ["so ,"];
	reraise_followed = ["so ,"];
	loadplan = ["lets see ."];
	accomodate = ["i assume you mean"];
	reaccomodate =  ["returning to "];


	-- ICMs
	-- Moved from General because of differing linearisations user and system.

	per_neg = variants {["pardon i did not hear what you said ."] ; ["pardon ?"]; ["sorry ?"]};
	per_int = variants { ["pardon ?"] ; ["what did you say ?"] };

	acc_pos = "okay";
	acc_neg = "sorry"; 
	acc_neg_alone = "sorry";


	status_done = ["managed to"];
	status_initiated = ["started to"];
	status_pending = ["waiting to"];
	status_failed = ["failed to"];


}


