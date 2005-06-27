-- A file with PreReq and PostReq etc... 

resource GenResEng = {

param Form = Ques | Req | ReqNeg ;


oper choosePre : Form => Str 
   = table {
		Ques => ["can i"];
		Req => variants{ ["i want to"] ; ["i would like to"] };
		ReqNeg => variants{ ["i do not want to"] ; ["i would not like to"] }
		
	};
	

oper choosePost : Form => Str
	= table {
		Ques => "";
		Req => "please";
		ReqNeg => "please"
	};

}


