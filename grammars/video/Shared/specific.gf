abstract specific = general, weekday, time, channel ** {

cat
StartTime ; 
EndTime ; 
ChToStore ; 
WdToStore ; 

cat 
DelAction ; 

fun
--- Inds
indTime : Time -> Ind; 
indChannel : Channel -> Ind; 
indWeekday : Weekday -> Ind; 

fun 
delAction : DelAction -> Action ; 
delete_rec_job : DelAction ; 

fun
startTimeToStore : Time -> StartTime ; 
endTimeToStore : Time -> EndTime ; 
channelToStore : Channel -> ChToStore ; 
weekdayToStore : Weekday -> WdToStore ;

vcr_add_rec_job_no_args : Action ; ---- moved from specUser and specSystem
}
