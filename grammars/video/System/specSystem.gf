-- File name System/specific.Abs.gf

abstract specSystem = specific, genSystem ** {

cat
StartTimeQ ;
EndTimeQ ;
ChToStoreQ ;
WdToStoreQ ;

fun
confirmRecJob :  Action -> DMove; 
---- vcr_add_rec_job_no_args : Action ; -- spela in! moved to specific

q_lambdaActionDel : DelAction -> WHQuestion ;

-- Time in question
startTimeToStoreQ : Time -> StartTimeQ ; 
endTimeToStoreQ : Time -> EndTimeQ ;

--- Channel and Weekday in question
channelToStoreQ : Channel -> ChToStoreQ ;
weekdayToStoreQ : Weekday -> WdToStoreQ ;

--- WHQuestions --- Lambdas
q_lambdaStartTime : StartTime -> WHQuestion ; 
q_lambdaEndTime : EndTime -> WHQuestion ; 
q_lambdaWeekday : WdToStore -> WHQuestion ; 
q_lambdaChannel : ChToStore -> WHQuestion ; 


--- Constructions for ynquestions
ynQuST : StartTimeQ -> YNQuestion ; 
ynQuET : EndTimeQ -> YNQuestion ; 
ynQuCH : ChToStoreQ -> YNQuestion ; 
ynQuWD: WdToStoreQ -> YNQuestion ; 


--- Props
startTimeToStoreProp : StartTime -> Prop ; 
endTimeToStoreProp : EndTime -> Prop ;
channelToStoreProp : ChToStore -> Prop ;
weekdayToStoreProp : WdToStore -> Prop ;


cat
ChannelList ;
Channels ;
ChannelAction ;

fun
channelListing : Channels -> ChannelList ;
channels1 : Channel -> Channels ;
channels2 : Channel -> Channels -> Channel ;
channelListAction : ChannelList -> ChannelAction ;
--channelListAction : ChannelList -> DMove ;
channelListActionDMove : ChannelAction -> DMove ;

}
