concrete userCorePro of userCore = sharedCorePro ** {

flags lexer=code ; unlexer=concat ;
flags conversion=finite;


lin
	makeAnswerListS _ alist = {s = alist.s};	

	makeCompoundedRequest crq = {s = crq.s};
	makeNegCompoundedRequest crq = { s = "~" ++ crq.s};
	makeCompoundedAsk ask = {s = ask.s};


	requestCompounded _ req obj = {s = "request(" ++ req.s ++ ")," ++ obj.s };
	requestCompoundedMulti _ req obj = {s = "request(" ++ req.s ++ ")," ++ obj.s };

	makeAskMove _ ques answer = {s = "ask" ++ "(" ++ "X" ++ "^" ++ ques.s ++ 
					"(" ++ "X" ++ ")" ++ ")," ++ answer.s};
	
}

