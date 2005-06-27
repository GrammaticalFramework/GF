concrete userCoreEng of userCore = sharedCoreEng ** open GenResEng in {

flags conversion=finite;


lin

-- Greet
	makeGreetMove gre = {s = gre.s};

-- Quit
	makeQuitMove qui = {s = qui.s};

-- Answer
	makeAnswer _ ans = {s = ans.s};
	makeNegAnswer _ ans = {s = "not" ++ ans.s};
	makeAnswerMove _ sha = {s = sha.s};
	makeNegAnswerMove _ sha = {s = sha.s};

-- Ask
	singleAsk _ ask = {s = ask.s};
	makeYesNoAsk _ action = {s = action.s};
	makeAsk ask = {s = ask.s};




-- Requests


	makeAnswerListS _ alist = {s = alist.s};
	requestCompounded _ req obj = {s = req.s ++ obj.s};
	requestCompoundedMulti _ req obj = {s = req.s ++ obj.s };

	makeRequest req = {s = req.s};	

	makeCompoundedRequest crq = {s = variants { 
					( (choosePre ! Req) ++ crq.s ++ (choosePost ! Req) );
					( (choosePre ! Req) ++ crq.s                       );
					(                      crq.s ++ (choosePost ! Req) );
					(                      crq.s                       )
				    }
		      };

      	makeNegCompoundedRequest crq = {s = variants { 
					( (choosePre ! ReqNeg) ++ crq.s ++ (choosePost ! Req) );
					( (choosePre ! ReqNeg) ++ crq.s                       );
					(                "not" ++ crq.s ++ (choosePost ! Req) );
					(                "not" ++ crq.s                       )
				    }
		      };


	makeRequestMove req = {s = variants { 
					(                      req.s                       );
					( (choosePre ! Req) ++ req.s ++ (choosePost ! Req) );
					( (choosePre ! Req) ++ req.s                       );
					(                      req.s ++ (choosePost ! Req) )

				    }
		      };

	makeNegRequestMove req = {s = variants { 
					(                "not" ++ req.s                       );
					( (choosePre ! ReqNeg) ++ req.s ++ (choosePost ! Req) );
					( (choosePre ! ReqNeg) ++ req.s                       );
					(                "not" ++ req.s ++ (choosePost ! Req) )

				    }
		      };



-- Asks
	makeCompoundedAsk ask = {s = ask.s};

	makeAskMove _ ques answer = {s = ques.s ++ answer.s};

pattern
	-- ICMs
	-- Moved from General because of differing linearisations for user and system.

	per_neg = variants {"what" ; "pardon"; ["pardon i did not hear what you said"]};
	per_int = variants { "pardon" ; ["what did you say"] };

	acc_pos = variants { "okay" ; "ok" ; "sure" ; "yup" ; "right" };
	acc_neg = ["i do not know"]; 
	acc_neg_alone = ["i do not know"];


}


