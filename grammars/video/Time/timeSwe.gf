-- Time grammar Swedish

concrete timeSwe of time = open timeResSwe in {

lincat Time = {s : Str} ;

--Hours
lin
-- Some of the time expressions is omitted because of the prolog in godis.
-- hours after 13 and 00 are only interpreted as 13,14 etc when explicitly uttered, 
-- one o'clock is ONLY interpreted as 01:00, not 13:00. 
-- if someone needs the more elaborated forms of time use 
-- the commented lines, and comment the corresponding units.  

--hour0 = {s = refs (variants{["noll noll"];["noll"]}) "tolv" "ett"} ; 
hour0 = {s = refs (variants{["noll noll"];["noll"]})(variants{}) (variants{})} ; 
hour1 = {s = refs "ett" "ett" "två"} ; 
hour2 = {s = refs "två" "två" "tre"} ; 
hour3 = {s = refs "tre" "tre" "fyra"} ; 
hour4 = {s = refs "fyra" "fyra" "fem"} ; 
hour5 = {s = refs "fem" "fem" "sex"} ; 
hour6 = {s = refs "sex" "sex" "sju"} ; 
hour7 = {s = refs "sju" "sju" "åtta"} ; 
hour8 = {s = refs "åtta" "åtta" "nio"} ; 
hour9 = {s = refs "nio" "nio" "tio"} ; 
hour10 = {s = refs "tio" "tio" "elva"} ; 
hour11 = {s = refs "elva""elva" "tolv"} ; 
hour12 = {s = refs "tolv" "tolv" "ett" } ;
 
--hour13 = {s = refs "tretton" "ett" "två" };
--hour14 = {s = refs "fjorton" "två" "tre" };
--hour15 = {s = refs "femton" "tre" "fyra" };
--hour16 = {s = refs "sexton" "fyra" "fem" };
--hour17 = {s = refs "sjutton" "fem" "sex" };
--hour18 = {s = refs "arton" "sex" "sju" };
--hour19 = {s = refs "nitton" "sju" "åtta" } ;
--hour20 = {s = refs "tjugo" "åtta" "nio" } ;
--hour21 = {s = refs ["tjugo ett"] "nio" "tio" } ;
--hour22 = {s = refs ["tjugo två"] "tio" "elva" } ;
--hour23 = {s = refs ["tjugo tre"] "elva" "tolv" };

hour13 = {s = refs "tretton" (variants{})(variants{}) };
hour14 = {s = refs "fjorton"(variants{})(variants{})};
hour15 = {s = refs "femton"(variants{})(variants{})};
hour16 = {s = refs "sexton"(variants{})(variants{})};
hour17 = {s = refs "sjutton"(variants{})(variants{})};
hour18 = {s = refs "arton"(variants{})(variants{})};
hour19 = {s = refs "nitton"(variants{})(variants{})} ;
hour20 = {s = refs "tjugo"(variants{})(variants{})} ;
hour21 = {s = refs ["tjugo ett"](variants{})(variants{})} ;
hour22 = {s = refs ["tjugo två"](variants{})(variants{})} ;
hour23 = {s = refs ["tjugo tre"](variants{})(variants{})};


--Minutes
--0-9
--minute0 = {s = mins (variants{["noll noll"]}) (variants{}) (variants{}) (variants{[""]})} ;
minute0 = {s = mins ["noll noll"] (variants{[""]}) (variants{})} ;
minute1 = {s = mins ["noll ett"] (variants {["ett över"] ; ["en minut över"]}) (variants{}) } ;
minute2 = {s = mins ["noll två"] (variants {["två över"] ; ["två minuter över"]}) (variants{})} ;
minute3 = {s = mins ["noll tre"] (variants { ["tre över"] ; ["tre minuter över"]}) (variants{})} ;
minute4 = {s = mins ["noll fyra"] (variants { ["fyra över"] ; ["fyra minuter över"]}) (variants{})} ;
minute5 = {s = mins ["noll fem"] (variants { ["fem över"] ; ["fem minuter över"]}) (variants{})} ;
minute6 = {s = mins ["noll sex"] (variants { ["sex över"] ; ["sex minuter över"]}) (variants{})} ;
minute7 = {s = mins ["noll sju"] (variants { ["sju över"] ; ["sju minuter över"]}) (variants{})} ;
minute8 = {s = mins ["noll åtta"] (variants { ["åtta över"] ; ["åtta minuter över"]}) (variants{})} ;
minute9 = {s = mins ["noll nio"] (variants { ["nio över"] ; ["nio minuter över"]}) (variants{})} ;

--10-19
minute10 = {s = mins ["tio"] (variants { ["tio över"] ; ["tio minuter över"]}) (variants{})} ;
minute11 = {s = mins ["elva"] (variants { ["elva över"] ; ["elva minuter över"]}) (variants{})} ;
minute12 = {s = mins ["tolv"] (variants { ["tolv över"] ; ["tolv minuter över"]}) (variants{})} ;
minute13 = {s = mins ["tretton"] (variants { ["tretton över"] ; ["tretton minuter över"]}) (variants{})} ;
minute14 = {s = mins ["fjorton"] (variants { ["fjorton över"] ; ["fjorton minuter över"]}) (variants{})} ;
minute15 = {s = mins ["femton"] (variants { ["femton över"] ; ["femton minuter över"] ; ["kvart över"]}) (variants{})} ;
minute16 = {s = mins ["sexton"] (variants { ["sexton över"] ; ["sexton minuter över"]}) (variants{})} ;
minute17 = {s = mins ["sjutton"] (variants { ["sjutton över"] ; ["sjutton minuter över"]}) (variants{})} ;
minute18 = {s = mins ["arton"] (variants { ["arton över"] ; ["arton minuter över"]}) (variants{})} ;
minute19 = {s = mins ["nitton"] (variants { ["nitton över"] ; ["nitton minuter över"]}) (variants{})} ;

--20-29
minute20 = {s = mins ["tjugo"] (variants { ["tjugo över"] ; ["tjugo minuter över"]}) (variants {})} ;
minute21 = {s = mins ["tjugo ett"] (variants { ["tjugo en över"] ;["tjugo ett över"] ; ["tjugo en minuter över"]}) (variants {}) } ;
minute22 = {s = mins ["tjugo två"] (variants { ["tjugo två över"] ; ["tjugo två minuter över"]}) (variants {}) } ;
minute23 = {s = mins ["tjugo tre"] (variants { ["tjugo tre över"] ; ["tjugo tre minuter över"]}) (variants {}) } ;
minute24 = {s = mins ["tjugo fyra"] (variants { ["tjugo fyra över"] ; ["tjugo fyra minuter över"]}) (variants {["sex minuter i halv"];["sex i halv"]}) } ;
minute25 = {s = mins ["tjugo fem"] (variants { ["tjugo fem över"] ; ["tjugo fem minuter över"]}) (variants {["fem minuter i halv"];["fem i halv"]}) } ;
minute26 = {s = mins ["tjugo sex"] (variants { ["tjugo sex över"] ; ["tjugo sex minuter över"]}) (variants {["fyra minuter i halv"];["fyra i halv"]}) } ;
minute27 = {s = mins ["tjugo sju"] (variants { ["tjugo sju över"] ; ["tjugo sju minuter över"]}) (variants {["tre minuter i halv"];["tre i halv"]}) } ;
minute28 = {s = mins ["tjugo åtta"] (variants { ["tjugo åtta över"] ; ["tjugo åtta minuter över"]}) (variants {["två minuter i halv"];["två i halv"]}) } ;
minute29 = {s = mins ["tjugo nio"] (variants { ["tjugo nio över"] ; ["tjugo nio minuter över"]}) (variants {["en minut i halv"];["en i halv"]}) } ;

--30-39
minute30 = {s = mins ["trettio"] (variants { ["trettio minuter över"]}) ["halv"] } ;
minute31 = {s = mins ["trettio ett"] (variants { ["trettio en över"] ; ["trettio ett över"] ; ["trettio en minuter över"]}) (variants {["tjugo nio minuter i"];["tjugo nio i"];["en minut över halv"];["en över halv"]}) } ;
minute32 = {s = mins ["trettio två"] (variants { ["trettio två över"] ; ["trettio två minuter över"]}) (variants {["tjugo åtta minuter i"];["tjugo åtta i"];["två minuter över halv"];["två över halv"]}) } ;
minute33 = {s = mins ["trettio tre"] (variants { ["trettio tre över"] ; ["trettio tre minuter över"]}) (variants {["tjugo sju minuter i"];["tjugo sju i"];["tre minuter över halv"];["tre över halv"]}) } ;
minute34 = {s = mins ["trettio fyra"] (variants { ["trettio fyra över"] ; ["trettio fyra minuter över"]}) (variants {["tjugosex minuter i"];["tjugosex i"];["fyra minuter över halv"];["fyra över halv"]}) } ;
minute35 = {s = mins ["trettio fem"] (variants { ["trettio fem över"] ; ["trettio fem minuter över"]}) (variants {["tjugo fem minuter i"];["tjugo fem i"];["fem minuter över halv"]; ["fem över halv"]}) } ;
minute36 = {s = mins ["trettio sex"] (variants { ["trettio sex över"] ; ["trettio sex minuter över"]}) (variants {["tjugo fyra minuter i"];["tjugo fyra i"];["sex minuter över halv"];["sex över halv"]}) } ;
minute37 = {s = mins ["trettio sju"] (variants { ["trettio sju över"] ; ["trettio sju minuter över"]}) (variants {["tjugo tre minuter i"];["tjugo tre i"];["sju minuter över halv"];["sju över halv"]}) } ;
minute38 = {s = mins ["trettio åtta"] (variants { ["trettio åtta över"] ; ["trettio åtta minuter över"]}) (variants {["tjugo två minuter i"];["tjugo två i"]}) } ;
minute39 = {s = mins ["trettio nio"] (variants { ["trettio nio över"] ; ["trettio nio minuter över"]}) (variants {["tjugo en minuter i"];["tjugo en i"];["tjugo ett i"]}) } ;

--40-49
minute40 = {s = mins ["fyrtio"] (variants {}) (variants {["tjugo minuter i"];["tjugo i"]}) } ;
minute41 = {s = mins ["fyrtio ett"] (variants {}) (variants {["nitton minuter i"];["nitton i"]}) } ;
minute42 = {s = mins ["fyrtio två"] (variants {}) (variants {["arton minuter i"];["arton i"]}) } ;
minute43 = {s = mins ["fyrtio tre"] (variants {}) (variants {["sjutton minuter i"];["sjutton i"]}) } ;
minute44 = {s = mins ["fyrtio fyra"] (variants {}) (variants {["sexton minuter i"];["sexton i"]}) } ;
minute45 = {s = mins (variants {["fyrtio fem"];["tre kvart"]}) (variants {}) (variants {["femton minuter i"];["femton i"];["kvart i"]}) } ;
minute46 = {s = mins ["fyrtio sex"] (variants {}) (variants {["fjorton minuter i"];["fjorton i"]}) } ;
minute47 = {s = mins ["fyrtio sju"] (variants {}) (variants {["tretton minuter i"];["tretton i"]}) } ;
minute48 = {s = mins ["fyrtio åtta"] (variants {}) (variants {["tolv minuter i"];["tolv i"]}) } ;
minute49 = {s = mins ["fyrtio nio"] (variants {}) (variants {["elva minuter i"];["elva i"]}) } ;

--50-59
minute50 = {s = mins ["femtio"] (variants {}) (variants {["tio minuter i"];["tio i"]}) } ;
minute51 = {s = mins ["femtio ett"] (variants {}) (variants {["nio minuter i"];["nio i"]}) } ;
minute52 = {s = mins ["femtio två"] (variants {}) (variants {["åtta minuter i"];["åtta i"]}) } ;
minute53 = {s = mins ["femtio tre"] (variants {}) (variants {["sju minuter i"];["sju i"]}) } ;
minute54 = {s = mins ["femtio fyra"] (variants {}) (variants {["sex minuter i"];["sex i"]}) } ;
minute55 = {s = mins ["femtio fem"] (variants {}) (variants {["fem minuter i"];["fem i"]}) } ;
minute56 = {s = mins ["femtio sex"] (variants {}) (variants {["fyra minuter i"];["fyra i"]}) } ;
minute57 = {s = mins ["femtio sju"] (variants {}) (variants {["tre minuter i"];["tre i"]}) } ;
minute58 = {s = mins ["femtio åtta"] (variants {}) (variants {["två minuter i"];["två i"]}) } ;
minute59 = {s = mins ["femtio nio"] (variants {}) (variants {["en minut i"];["en i"];["ett i"]}) } ;

lincat Hour = {s : RefHour => Str} ;

lincat Minute = {s : MinMin => Str} ;

-- Time expressions
lin 
--timeDotty h m = {s = h.s ! ThisLex ++ m.s ! Dot };
--timeInformal h m = {s = variants { 
	--m.s ! Past ++ h.s ! ThisLex ; 
	--m.s ! To ++ h.s ! NextLex 
	--} 
       --};
--timeFormal h m = {s = h.s ! ThisFormal ++ m.s ! Form} ;
time h m = {s = variants { 
	h.s ! ThisFormal ++ m.s ! Form ;
	h.s ! ThisFormal ++ "och" ++ m.s ! Form ;
	m.s ! Past ++ h.s ! ThisLex ; 
	m.s ! To ++ h.s ! NextLex 
	} 
       };
}
