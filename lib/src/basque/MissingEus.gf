resource MissingEus = open GrammarEus, Prelude in {

-- temporary definitions to enable the compilation of RGL API
oper AddAdvQVP : QVP -> IAdv -> QVP = notYet "AddAdvQVP" ;
oper AdnCAdv : CAdv -> AdN = notYet "AdnCAdv" ;
oper AdvQVP : VP -> IAdv -> QVP = notYet "AdvQVP" ;
oper CleftAdv : Adv -> S -> Cl = notYet "CleftAdv" ;
oper CleftNP : NP -> RS -> Cl = notYet "CleftNP" ;
oper ComparAdvAdjS : CAdv -> A -> S  -> Adv = notYet "ComparAdvAdjS" ;
oper ComplSlashIP  : VPSlash -> IP -> QVP  = notYet "ComplSlashIP" ;
oper ExistIP : IP -> QCl = notYet "ExistIP" ;
oper ExistIPAdv : IP -> Adv -> QCl = notYet "ExistIPAdv" ;
oper ExistNP : NP -> Cl = notYet "ExistNP" ;
oper ExistNPAdv : NP -> Adv -> Cl= notYet "ExistNPAdv" ;
oper GenericCl : VP -> Cl  = notYet "GenericCl" ;
oper ImpP3 : NP -> VP -> Utt = notYet "ImpP3" ;
oper ImpersCl : VP -> Cl = notYet "ImpersCl" ;
oper QuestQVP : IP -> QVP -> QCl  = notYet "QuestQVP" ;
oper SelfAdVVP : VP -> VP = notYet "SelfAdVVP" ;
oper SelfAdvVP : VP -> VP = notYet "SelfAdvVP" ;
oper SelfNP : NP -> NP = notYet "SelfNP" ;
oper SlashPrep : Cl -> Prep -> ClSlash = notYet "SlashPrep" ;
oper SlashVS :  NP -> VS -> SSlash -> ClSlash = notYet "SlashVS" ;
}
