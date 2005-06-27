concrete userCoreSwe of userCore = sharedCoreSwe ** open GenResSwe in {

flags conversion=finite;


lin

-- Greet
	makeGreetMove gre = {s = gre.s};

-- Quit
	makeQuitMove qui = {s = qui.s};

-- Answer
	makeAnswer _ ans = {s = ans.s};
	makeNegAnswer _ ans = {s = "inte" ++ ans.s};
	makeAnswerMove _ sha = {s = sha.s};
	makeNegAnswerMove _ sha = {s = sha.s};

-- Ask
	singleAsk _ ask = {s = ask.s};
	makeYesNoAsk _ action = {s = action.s};
	makeAsk ask = {s = ask.s };

	
-- Request

	-- makeRequestMove moved to System and User respectively 
	-- because of differing linearizations

	makeRequest req = {s = req.s};



-- Requests


	makeAnswerListS _ alist = {s = alist.s};
	requestCompounded _ req obj = {s = req.s ++ obj.s};
	requestCompoundedMulti _ req obj = {s = req.s ++ obj.s };


	makeRequestMove req = {s = variants { 
					(                      req.s                       );
					( (choosePre ! Req) ++ req.s ++ (choosePost ! Req) );
					( (choosePre ! Req) ++ req.s                       );
					(                      req.s ++ (choosePost ! Req) )

				    }
		      };

      	makeNegCompoundedRequest crq = {s = variants { 
					( (choosePre ! ReqNeg) ++ crq.s ++ (choosePost ! Req) );
					( (choosePre ! ReqNeg) ++ crq.s                       );
					(                "inte" ++ crq.s ++ (choosePost ! Req) );
					(                "inte" ++ crq.s                       )
				    }
		      };



	makeCompoundedRequest crq = {s = variants { 
					( (choosePre ! Req) ++ crq.s ++ (choosePost ! Req) );
					( (choosePre ! Req) ++ crq.s                       );
					(                      crq.s ++ (choosePost ! Req) );
					(                      crq.s                       )
				    }
		      };

	makeNegRequestMove req = {s = variants { 
					(                "inte" ++ req.s                       );
					( (choosePre ! ReqNeg) ++ req.s ++ (choosePost ! Req) );
					( (choosePre ! ReqNeg) ++ req.s                       );
					(                "inte" ++ req.s ++ (choosePost ! Req) )

				    }
		      };


-- Asks
	makeCompoundedAsk ask = {s = ask.s};

	makeAskMove _ ques answer = {s = ques.s ++ answer.s};

pattern
	-- ICMs
	-- Moved from General because of differing linearisations for user and system.

	per_neg = variants {"va" ; "ursäkta"; "förlåt" ; ["ursäkta jag hörde inte vad du sa"]};
	per_int = variants { "ursäkta" ; ["vad sa du"] };

	acc_pos = variants { "okej" ; "ok" ; "visst" ; "japp" ; "jaha" };
	acc_neg = ["vet inte"]; 


}


