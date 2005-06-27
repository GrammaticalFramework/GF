resource ResEng = {

param RefHour = ThisFormal | ThisLex | NextLex ;
oper refs : Str -> Str -> Str -> RefHour => Str = 
	\x,y,z -> table {ThisFormal => x ; ThisLex => y ; NextLex => z } ; 
param MinMin = Form | Past | To ;
oper mins : Str -> Str -> Str -> MinMin => Str = \x,y,z -> table {Form => x ; Past => y ; To => z } ; 
--oper mins : Str -> Str -> Str -> MinMin => Str = \x,y,z -> table {Form => x ; Past => y ; To => z } ; 
-- jag vill ha en variantsexpanderare, tänk tänk
--oper mins : Str -> Str -> Str -> MinMin => Str = \x,y,z -> table {Form => (variants{x}) ; Past => (variants{y}) ; To => (variants{z}) } ; 
-- Time expressions
}
