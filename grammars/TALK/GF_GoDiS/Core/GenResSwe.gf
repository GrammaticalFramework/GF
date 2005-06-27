-- A file with PreReq and PostReq etc... 

resource GenResSwe = {

param Form = Ques | Req | ReqNeg;


oper choosePre : Form => Str 
   = table {
		Ques => ["kan jag"];
		Req => variants{ ["jag vill"] ; ["jag skulle vilja"] };
		ReqNeg => variants{ ["jag vill inte"] ; ["jag skulle inte vilja"] }
		
	};
	

oper choosePost : Form => Str
	= table {
		Ques => "";
		Req => "tack";
		ReqNeg => "tack"
	};

}


