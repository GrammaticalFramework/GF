-- File name System/specific.Prolog.gf

include
	specific.Abs.gf ;

lin
-- Confirm recording job
confirmRecJob act = {s = app "confirm" act.s } ; 

q_lambdaActionDel dact = {s = ["rec_job_to_delete"]} ;

vcr_add_rec_job_no_args = {s = ["add_rec_job"]} ; -- hack!!!

--- Time in question
startTimeToStoreQ st = {s = app "start_time_to_store" st.s } ; 
endTimeToStoreQ et = {s = app "stop_time_to_store" et.s } ; 

--- Channel and Weekday in question
channelToStoreQ ch = {s = app "channel_to_store" ch.s } ; 
weekdayToStoreQ wd = {s = app "weekday_to_store" wd.s } ; 

--- WHQuestions --- Lambdas
q_lambdaWeekday wdts = {s = ["weekday_to_store"]} ;
q_lambdaChannel chts = {s = ["channel_to_store"]} ;
q_lambdaStartTime stts = {s = ["start_time_to_store"]} ;
q_lambdaEndTime etts = {s = ["stop_time_to_store"]} ;


--- Constructions for ynquestions
lin
ynQuST y = {s = y.s} ;
ynQuET y = {s = y.s} ;
ynQuCH y = {s = y.s} ;
ynQuWD y = {s = y.s} ;

--- Props
startTimeToStoreProp st = {s = st.s } ; 
endTimeToStoreProp et = {s = et.s } ; 
channelToStoreProp chst = {s = chst.s } ; 
weekdayToStoreProp wdts = {s = wdts.s } ; 

channelListing chs = {s = chs.s } ; 
channels1 ch = {s = ch.s } ; 
channels2 ch chs = {s = ch.s ++ "," ++ chs.s } ; 
channelListAction ch = {s = ch.s } ; 
channelListActionDMove ch = {s = ch.s } ; 