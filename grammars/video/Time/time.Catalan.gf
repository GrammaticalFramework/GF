-- Time grammar Catalan

include time.Abs.gf ;

lin

hour0 = {s = refs "dotze" "una"} ; 
hour1 = {s = refs ["la una"] "dues"} ; 
hour2 = {s = refs "dues" "tres"} ; 
hour3 = {s = refs "tres" "quatre"} ; 
hour4 = {s = refs "quatre" "cinc"} ; 
hour5 = {s = refs "cinc" "sis"} ; 
hour6 = {s = refs "sis" "set"} ; 
hour7 = {s = refs "set" "vuit"} ; 
hour8 = {s = refs "vuit" "nou"} ; 
hour9 = {s = refs "nou" "deu"} ; 
hour10 = {s = refs "deu" "onze"} ; 
hour11 = {s = refs "onze" "dotze"} ; 
hour12 = {s = refs "dotze" "una" } ; 
hour13 = {s = refs "tretze" "dues" };
hour14 = {s = refs "catorze" "tres" };
hour15 = {s = refs "quinze" "quatre" };
hour16 = {s = refs "setze" "cinc" };
hour17 = {s = refs "disset" "sis" };
hour18 = {s = refs "divuit" "set" };
hour19 = {s = refs "dinou" "vuit" } ;
hour20 = {s = refs "vint" "nou" } ;
hour21 = {s = refs "vintiun_a" "deu" } ;
hour22 = {s = refs "vintidues_dos" "onze" } ;
hour23 = {s = refs "vintitres" "dotze" };

pattern
--Minutes
minute0 = "zero" ;
minute1 = "una" ;
minute2 = "dues" ;
minute3 = "tres" ;
minute4 = "quatre" ;
minute5 = "cinc" ;
minute6 = "sis" ;
minute7 = "set" ;
minute8 = "vuit" ;
minute9 = "nou" ;
minute10 = "deu" ;
minute11 = "onze" ;
minute12 = "dotze" ;
minute13 = "tretze" ;
minute14 = "catorze" ;
minute15 = "quinze" ;
minute16 = "setze" ;
minute17 = "disset" ;
minute18 = "divuit" ;
minute19 = "dinou" ;
minute20 = "vint" ;
minute21 = "vintiun_a" ;
minute22 = "vintidues_dos" ;
minute23 = "vintitres"  ;
minute24 = "vintiquatre" ;
minute25 = "vinticinc" ;
minute26 = "vintisis" ;
minute27 = "vintiset" ;
minute28 = "vintivuit" ;
minute29 = "vintinou" ;
minute30 = "trenta" ;
minute31 = "trentauna" ;
minute32 = "trentadues" ;
minute33 = "trentatres" ;
minute34 = "trentaquatre" ;
minute35 = "trentacinc" ;
minute36 = "trentasis" ;
minute37 = "trentaset" ;
minute38 = "trentavuit" ;
minute39 = "trentanou" ;
minute40 = "quaranta" ;
minute41 = "quarantauna" ;
minute42 = "quarantadues" ;
minute43 = "quarantatres" ;
minute44 = "quarantaquatre" ;
minute45 = "quarantacinc" ;
minute46 = "quarantasis" ;
minute47 = "quarantaset" ;
minute48 = "quarantavuit" ;
minute49 = "quarantanou" ;
minute50 = "cinquenta" ;
minute51 = "cinquentauna" ;
minute52 = "cinquentadues" ;
minute53 = "cinquentatres" ;
minute54 = "cinquentaquatre" ;
minute55 = "cinquentacinc" ;
minute56 = "cinquentasis" ;
minute57 = "cinquentaset" ;
minute58 = "cinquentavuit" ;
minute59 = "cinquentanou" ;

-- LexMinuteZero
minuteZero = [] ;

-- LexMinute
minuteQuarter = "un" ++ "quart" ++ "de";
minuteFive = "mig" ++ "quart" ++ "de";
minuteTen = "cinc" ++ "minuts" ++ "per" ++ "a" ++ "un" ++ "quart" ++ "de";
minuteTwenty = "un" ++ "quart" ++ "i" ++ "cinc" ++ "de";

-- LexMinuteHalfFive
minuteTwentyFive = "un" ++ "quart" ++ "i" ++ "deu" ++ "de";
minuteThirtyFive = "dos" ++ "quarts" ++ "i" ++ "cinc" ++ "de";

-- LexMinuteTo
minuteQuarterTo = "tres" ++ "quarts" ++ "de" ;
minuteFiveTo = "tres" ++ "quarts" ++ "i" ++ "deu" ++ "de";
--minuteFiveTo = "cinc" ++ "minuts" ++ "per" ++ "a" ;
minuteTenTo = "tres" ++ "quarts" ++ "i" ++ "cinc" ++ "de";
minuteTwentyTo = "dos" ++ "quarts" ++ "i" ++ "deu" ++ "de";
--minuteTwentyTo = "cinc" ++ "minuts" ++ "per" ++ "a" ++ "tres" ++ "quarts" ++ "de";

-- LexMinuteHalf
minuteHalf = "dos" ++ "quarts" ;

-- Creates tables for each hour, consisting of 
-- Present hour - Formal, Next hour informal,
-- (in catalan of the n:nd hour)
param RefHour = ThisFormal | NextLex ;
oper refs : Str -> Str -> RefHour => Str = 
	\x,y -> table {ThisFormal => x ; NextLex => y } ; 

lincat Hour = {s : RefHour => Str} ;

lin 
time h m = {s = h.s ! ThisFormal ++ "i" ++ m.s} ;
timeOnTheHour h m = {s = h.s ! ThisFormal ++ m.s } ; 
timePast h m = {s = m.s ++ h.s ! NextLex} ;
timeTo h m = {s = m.s ++ h.s ! NextLex } ;
timeHalf h m = {s = m.s ++ h.s ! NextLex } ;
timeFiveToHalf h m = {s = m.s ++ h.s ! NextLex } ;
timeFivePastHalf h m = {s = m.s ++ h.s ! NextLex } ;