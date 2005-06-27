--# -path=.:../:../../../Resource/Time:../Shared:../../../Core:../../../Core/Shared:

concrete sharedDomainSwe of sharedDomain = sharedCoreSwe, DBSwe, TimeSwe, WeekdaySwe ** open SpecResSwe in{

lin
	-- ANSWERS


	makeAddEventAnswer event = {s = event.s};
	makeRemEventAnswer event = {s = event.s};
	makeCheckupAnswer event = {s = "om" ++ event.s};
	makeCheckTimeAnswer event = {s = event.s};
	makeAddInfoAnswer event = {s = "om" ++ event.s};

	makeAddEventTimeAnswer time = {s = time.s};
	makeRemEventTimeAnswer time = {s = time.s};
	makeCheckupTimeAnswer time = {s = time.s};
	makeCheckTimeTimeAnswer time = {s = time.s};
	makeAddInfoTimeAnswer time = {s = time.s};

	makeAddEventDayAnswer weekday = {s = "på" ++ weekday.s};
	makeRemEventDayAnswer weekday = {s = "på" ++ weekday.s};
	makeCheckupDayAnswer weekday = {s = "på" ++ weekday.s};
	makeCheckTimeDayAnswer weekday = {s = "på" ++ weekday.s};
	makeAddInfoDayAnswer weekday = {s = "på" ++ weekday.s};

	makeCheckAnswer location = {s = location.s};
	makeAddInfoLocAnswer location = {s = "om" ++ location.s};
	makeCheckTimeLocAnswer location = {s = location.s};

-- LEXICON

pattern
	addEntry = varaints {["lägga till"] ; ["anteckna"] ; ["göra en anteckning om"]};
	removeEntry = variants{ ["ta bort"] ; ["radera en anteckning"]};
	changeEntry = ["ändra en anteckning om"];
	augmentEntry = ["lägga till mer information"];
	checkupEntry = ["kolla tiden för"];

	checkup = ["vad har jag uppskrivet"];	

}