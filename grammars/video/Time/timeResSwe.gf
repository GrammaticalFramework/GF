resource timeResSwe = {
param RefHour = ThisFormal | ThisLex | NextLex ;
oper refs : Str -> Str -> Str -> RefHour => Str = \x,y,z -> table {ThisFormal => x ; ThisLex => y ; NextLex => z } ; 
param MinMin = Form | Past | To ;
oper mins : Str -> Str -> Str -> MinMin => Str = \u,x,y -> table {Form => u ; Past => x ; To => y } ; 

}
