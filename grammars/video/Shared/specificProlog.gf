-- File name Shared/specific.Prolog.gf

concrete specificProlog of specific = 
  generalProlog, weekdayProlog, channelProlog, timeProlog ** 
  open prologResource in  {

lin
indTime t = {s = t.s} ;
indChannel c = {s = c.s} ;
indWeekday w = {s = w.s} ;

delete_rec_job = {s = "delete_rec_job"} ;
delAction dact = {s = dact.s };


startTimeToStore st = {s = app "start_time_to_store" st.s } ; 
endTimeToStore et = {s = app "stop_time_to_store" et.s } ; 
channelToStore ch = {s = app "channel_to_store" ch.s } ; 
weekdayToStore wd = {s = app "weekday_to_store" wd.s } ; 

vcr_add_rec_job_no_args = {s = ["add_rec_job"]} ; -- hack!!!
}
