-- Time grammar Symbolic/Numerical

include time.Abs.gf ;

pattern

hour0 = "00" ; 
hour1 = "01" ;
hour2 = "02" ;
hour3 = "03" ;
hour4 = "04" ;
hour5 = "05" ;
hour6 = "06" ;
hour7 = "07" ;
hour8 = "08" ;
hour9 = "09" ;
hour10 = "10" ;
hour11 = "11" ;
hour12 = "12" ;
hour13 = "13" ;
hour14 = "14" ;
hour15 = "15" ;
hour16 = "16" ;
hour17 = "17" ;
hour18 = "18" ;
hour19 = "19" ;
hour20 = "20" ;
hour21 = "21" ;
hour22 = "22" ;
hour23 = "23" ;

--Minutes
minute0 = "00" ;
minute1 = "01" ;
minute2 = "02" ;
minute3 = "03" ;
minute4 = "04" ;
minute5 = "05" ;
minute6 = "06" ;
minute7 = "07" ;
minute8 = "08" ;
minute9 = "09" ;
minute10 = "10" ;
minute11 = "11" ;
minute12 = "12" ;
minute13 = "13" ;
minute14 = "14" ;
minute15 = "15" ;
minute16 = "16" ;
minute17 = "17" ;
minute18 = "18" ;
minute19 = "19" ;
minute20 = "20" ;
minute21 = "21" ;
minute22 = "22" ;
minute23 = "23" ;
minute24 = "24" ;
minute25 = "25" ;
minute26 = "26" ;
minute27 = "27" ;
minute28 = "28" ;
minute29 = "29" ;
minute30 = "30" ;
minute31 = "31" ;
minute32 = "32" ;
minute33 = "33" ;
minute34 = "34" ;
minute35 = "35" ;
minute36 = "36" ;
minute37 = "37" ;
minute38 = "38" ;
minute39 = "39" ;
minute40 = "40" ;
minute41 = "41" ;
minute42 = "42" ;
minute43 = "43" ;
minute44 = "44" ;
minute45 = "45" ;
minute46 = "46" ;
minute47 = "47" ;
minute48 = "48" ;
minute49 = "49" ;
minute50 = "50" ;
minute51 = "51" ;
minute52 = "52" ;
minute53 = "53" ;
minute54 = "54" ;
minute55 = "55" ;
minute56 = "56" ;
minute57 = "57" ;
minute58 = "58" ;
minute59 = "59" ;

-- LexMinuteZero
minuteZero = "00" ;

--LexMinutePast
minuteQuarter = "15" ;
minuteFive = "05" ;
minuteTen = "10" ;
minuteTwenty = "20" ;
--minuteTwentyFive = "25" ;

--LexMinuteToHalf 
minuteTwentyFive = "25" ;

--LexMinutePastHalf 
minuteThirtyFive = "35" ;

--LexMinuteHalf
minuteHalf = "30" ;

--LexMinuteTo
minuteQuarterTo = "45" ;
minuteFiveTo = "55" ;
minuteTenTo = "50" ;
minuteTwentyTo = "40" ;
--minuteTwentyFiveTo = "35" ;

lin
time h m = {s = h.s ++ m.s} ; -- 11 30
timeOnTheHour h m = {s = h.s ++ m.s} ; -- 11 00
timePast h m = {s = h.s ++ m.s} ; -- 11 10
timeTo h m = {s = h.s ++ m.s} ; -- 10 50
timeHalf h m = {s = h.s ++ m.s} ; 
timeFiveToHalf h m = {s = h.s ++ m.s } ;
timeFivePastHalf h m = {s = h.s ++ m.s } ;