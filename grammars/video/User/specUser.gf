-- File name User/specific.Abs.gf


abstract specUser = specific, genUser ** {

cat
AnswerReq ;
AnswerListReq ;
Request ;

fun
--- Answers in request list
vcr_add_rec_job_args4 : AnswerReq -> AnswerReq ->  AnswerReq -> AnswerReq -> Action ;
vcr_add_rec_job_args3 : AnswerReq -> AnswerReq ->  AnswerReq -> Action ;
vcr_add_rec_job_args2 : AnswerReq -> AnswerReq -> Action ;
vcr_add_rec_job_args1 : AnswerReq -> Action ;
---- vcr_add_rec_job_no_args : Action ; -- spela in! moved to specific

fun
--- Possible answers in request list
startTimeToStoreReq : StartTime -> AnswerReq ;
endTimeToStoreReq : EndTime -> AnswerReq ;
channelToStoreReq : ChToStore -> AnswerReq ;
weekdayToStoreReq : WdToStore -> AnswerReq ;

--- AnswerList
answerListReq4 : AnswerReq -> AnswerReq ->  AnswerReq -> AnswerReq -> AnswerListReq ;
answerListReq3 : AnswerReq -> AnswerReq ->  AnswerReq -> AnswerListReq ;
answerListReq2 : AnswerReq -> AnswerReq -> AnswerListReq ;
answerListReq : AnswerListReq -> DMove;

answerReq : AnswerReq -> Answer ;

--requestChannelsDMove : Request -> DMove;
requestChannels : Action ;
}
