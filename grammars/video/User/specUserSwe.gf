--# -path=.:..:../Shared:../Weekday:../Time:../Channel

-- File name User/specific.Swe.gf

concrete specUserSwe of specUser = specificSwe, genUserSwe ** {

lin 
--- Answers in request list
vcr_add_rec_job_args4 chts wdts stts etts = {s = 
					["spela in"] ++ stts.s ++ "," ++ etts.s ++ "," ++ wdts.s ++ "," ++ chts.s };
vcr_add_rec_job_args3 chts wdts stts = {s = 
					["spela in"] ++ chts.s ++ "," ++ wdts.s ++ "," ++ stts.s }; 
vcr_add_rec_job_args2 chts wdts = {s = 
					["spela in"] ++ chts.s ++ "," ++ wdts.s };
vcr_add_rec_job_args1 chts = {s = ["spela in"] ++ chts.s } ;
---- vcr_add_rec_job_no_args = {s = ["spela in"]} ;

lin

--- Possible answers in request list
startTimeToStoreReq v = {s= v.s} ; 
endTimeToStoreReq v = {s= v.s} ;
channelToStoreReq v = {s= v.s} ;
weekdayToStoreReq v = {s= v.s} ;

--- AnswerList
answerListReq4 chts wdts stts etts = {s = stts.s ++ "," ++ etts.s ++ "," ++ wdts.s ++ "," ++ chts.s }; 
answerListReq3 chts wdts stts = {s = chts.s ++ "," ++ wdts.s ++ "," ++ stts.s };
answerListReq2 chts wdts = {s = chts.s ++ "," ++ wdts.s };
answerListReq aL = {s = aL.s} ;

answerReq v = {s= v.s} ;

requestChannels = {s= (variants{["lista alla kanaler"];["vilka kanaler finns det"]})};
}
