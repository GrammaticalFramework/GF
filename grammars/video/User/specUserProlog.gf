-- File name User/specific.Prolog.gf

concrete specUserProlog of specUser = genUserProlog, specificProlog **
  open prologResource in {



--- Answers in request list
lin
vcr_add_rec_job_args4 chst wdts stts etts = 
			{s = 
			"add_rec_job" ++ "," ++ 
			app "answer" chst.s ++ "," ++ 
			app "answer" wdts.s ++ "," ++ 
			app "answer" stts.s ++ "," ++ 
			"answer" ++ "(" ++ etts.s } ; 

vcr_add_rec_job_args3 chst wdts stts = 
			{s = 
			"add_rec_job" ++ "," ++ 
			app "answer" chst.s ++ "," ++ 
			app "answer" wdts.s ++ "," ++ 
			"answer" ++ "(" ++ stts.s} ;

vcr_add_rec_job_args2 chst wdts = {s = 
			"add_rec_job" ++ "," ++ 
			app "answer" chst.s ++ "," ++ 
			"answer" ++ "(" ++ wdts.s } ;

vcr_add_rec_job_args1 chst = {s = 
			"add_rec_job" ++ "," ++ 	
			"answer" ++ "(" ++ chst.s } ;

---- vcr_add_rec_job_no_args = {s = "add_rec_job"} ; -- moved to specific



--- Possible answers in request list
startTimeToStoreReq v = {s= v.s} ; 
endTimeToStoreReq v = {s= v.s} ;
channelToStoreReq v = {s= v.s} ;
weekdayToStoreReq v = {s= v.s} ;

--- AnswerList
answerListReq4 chts wdts stts etts = 
			{ s =
			app "answer" chts.s ++ "," ++ 
			app "answer" wdts.s ++ "," ++ 
			app "answer" stts.s ++ "," ++ 
			app "answer" etts.s } ; 

answerListReq3 chts wdts stts = 
			{ s =
			app "answer" chts.s ++ "," ++ 
			app "answer" wdts.s ++ "," ++ 
			app "answer" stts.s} ;

answerListReq2  chts wdts = 
			{ s =
			app "answer" chts.s ++ "," ++ 	
			app "answer" wdts.s } ;

answerListReq aL = {s = aL.s} ;

answerReq v = {s= v.s} ;

requestChannels = {s = ["list_channels"]} ;
}
