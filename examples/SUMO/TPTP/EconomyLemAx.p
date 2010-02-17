fof(axEconomyLem0, axiom, 
 ( ! [Var_AREA] : 
 ((hasType(type_Object, Var_AREA) & hasType(type_Agent, Var_AREA)) => 
(((f_attribute(Var_AREA,inst_FormerSovietOrEasternEuropeanCountry)) => (f_economyType(Var_AREA,inst_CountryInTransition))))))).

fof(axEconomyLem1, axiom, 
 ( ! [Var_AREA] : 
 ((hasType(type_Object, Var_AREA) & hasType(type_Agent, Var_AREA)) => 
(((f_attribute(Var_AREA,inst_FourDragonsEconomy)) => (f_economyType(Var_AREA,inst_LessDevelopedCountry))))))).

fof(axEconomyLem2, axiom, 
 ( ! [Var_AREA] : 
 ((hasType(type_Object, Var_AREA) & hasType(type_Agent, Var_AREA)) => 
(((f_attribute(Var_AREA,inst_FourDragonsEconomy)) => (f_economyType(Var_AREA,inst_AdvancedEconomy))))))).

fof(axEconomyLem3, axiom, 
 ( ! [Var_AREA] : 
 ((hasType(type_Object, Var_AREA) & hasType(type_Agent, Var_AREA)) => 
(((f_attribute(Var_AREA,inst_LowIncomeCountry)) => (f_economyType(Var_AREA,inst_LeastDevelopedCountry))))))).

fof(axEconomyLem4, axiom, 
 ( ! [Var_AREA] : 
 ((hasType(type_Object, Var_AREA) & hasType(type_SelfConnectedObject, Var_AREA) & hasType(type_Agent, Var_AREA)) => 
(((((f_attribute(Var_AREA,inst_HighIncomeCountry)) & (( ~ (f_member(Var_AREA,inst_OrganizationOfPetroleumExportingCountries)))))) => (f_economyType(Var_AREA,inst_DevelopedCountry))))))).

fof(axEconomyLem5, axiom, 
 ( ! [Var_AREA] : 
 ((hasType(type_Object, Var_AREA) & hasType(type_Agent, Var_AREA)) => 
(((f_attribute(Var_AREA,inst_MajorIndustrialEconomy)) => (f_economyType(Var_AREA,inst_DevelopedCountry))))))).

fof(axEconomyLem6, axiom, 
 ( ! [Var_AREA] : 
 ((hasType(type_Object, Var_AREA) & hasType(type_Agent, Var_AREA)) => 
(((f_attribute(Var_AREA,inst_MajorIndustrialEconomy)) => (f_economyType(Var_AREA,inst_AdvancedEconomy))))))).

fof(axEconomyLem7, axiom, 
 ( ! [Var_STATE] : 
 ((hasType(type_SelfConnectedObject, Var_STATE) & hasType(type_Object, Var_STATE)) => 
(((f_member(Var_STATE,inst_GroupOf7)) => (f_attribute(Var_STATE,inst_MajorIndustrialEconomy))))))).

fof(axEconomyLem8, axiom, 
 ( ! [Var_AREA] : 
 ((hasType(type_Object, Var_AREA) & hasType(type_Agent, Var_AREA)) => 
(((f_attribute(Var_AREA,inst_DemocraticSocialism)) => (f_governmentType(Var_AREA,inst_Democracy))))))).

fof(axEconomyLem9, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_Nation, Var_AREA) => 
(((f_attribute(Var_AREA,inst_CommunistState)) => (f_economyType(Var_AREA,inst_CentrallyPlannedEconomy))))))).

fof(axEconomyLem10, axiom, 
 ( ! [Var_AREA] : 
 ((hasType(type_Object, Var_AREA) & hasType(type_Agent, Var_AREA)) => 
(((f_attribute(Var_AREA,inst_PrivatizingEconomy)) => (f_economyType(Var_AREA,inst_CountryInTransition))))))).

fof(axEconomyLem11, axiom, 
 ( ! [Var_FRACTION] : 
 ((hasType(type_RealNumber, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) => 
(( ! [Var_SECTOR] : 
 (hasType(type_IndustryAttribute, Var_SECTOR) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(((f_sectorCompositionOfGDP(Var_AREA,Var_SECTOR,Var_FRACTION)) => (f_lessThanOrEqualTo(Var_FRACTION,1.0))))))))))))).

fof(axEconomyLem12, axiom, 
 ( ! [Var_FRACTION] : 
 ((hasType(type_RealNumber, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(((f_populationFractionBelowPovertyLine(Var_AREA,Var_FRACTION)) => (f_lessThanOrEqualTo(Var_FRACTION,1.0)))))))))).

fof(axEconomyLem13, axiom, 
 ( ! [Var_FRACTION] : 
 ((hasType(type_RealNumber, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(((f_lowestDecileShareOfHouseholdIncome(Var_AREA,Var_FRACTION)) => (f_lessThanOrEqualTo(Var_FRACTION,1.0)))))))))).

fof(axEconomyLem14, axiom, 
 ( ! [Var_FRACTION] : 
 ((hasType(type_RealNumber, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(((f_highestDecileShareOfHouseholdIncome(Var_AREA,Var_FRACTION)) => (f_lessThanOrEqualTo(Var_FRACTION,1.0)))))))))).

fof(axEconomyLem15, axiom, 
 ( ! [Var_INDEX] : 
 ((hasType(type_NonnegativeRealNumber, Var_INDEX) & hasType(type_Quantity, Var_INDEX)) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(((f_incomeDistributionByGiniIndex(Var_AREA,Var_INDEX)) => (f_lessThanOrEqualTo(Var_INDEX,100)))))))))).

fof(axEconomyLem16, axiom, 
 ( ! [Var_FRACTION] : 
 ((hasType(type_RealNumber, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(((f_inflationRateOfConsumerPrices(Var_AREA,Var_FRACTION)) => (f_lessThanOrEqualTo(Var_FRACTION,1.0)))))))))).

fof(axEconomyLem17, axiom, 
 ( ! [Var_FRACTION] : 
 ((hasType(type_RealNumber, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) => 
(( ! [Var_SECTOR] : 
 (hasType(type_Attribute, Var_SECTOR) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(((f_laborForceFractionByOccupation(Var_AREA,Var_SECTOR,Var_FRACTION)) => (f_lessThanOrEqualTo(Var_FRACTION,1.0))))))))))))).

fof(axEconomyLem18, axiom, 
 ( ! [Var_TOTALAMOUNT] : 
 ((hasType(type_CurrencyMeasure, Var_TOTALAMOUNT) & hasType(type_Quantity, Var_TOTALAMOUNT)) => 
(( ! [Var_CAPAMOUNT] : 
 ((hasType(type_CurrencyMeasure, Var_CAPAMOUNT) & hasType(type_Quantity, Var_CAPAMOUNT)) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(( ! [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) => 
(((((f_holdsDuring(Var_TIME,capitalExpendituresOfArea(Var_AREA,Var_CAPAMOUNT))) & (f_holdsDuring(Var_TIME,annualExpendituresOfArea(Var_AREA,Var_TOTALAMOUNT))))) => (f_greaterThan(Var_TOTALAMOUNT,Var_CAPAMOUNT)))))))))))))))).

fof(axEconomyLem19, axiom, 
 ( ! [Var_NTH] : 
 (hasType(type_PositiveInteger, Var_NTH) => 
(( ! [Var_SECTOR] : 
 (hasType(type_IndustryAttribute, Var_SECTOR) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(((f_industryRankByOutput(Var_AREA,Var_SECTOR,Var_NTH)) => (f_industryOfArea(Var_AREA,Var_SECTOR))))))))))))).

fof(axEconomyLem20, axiom, 
 ( ! [Var_ORG] : 
 (hasType(type_MetallurgicalPlant, Var_ORG) => 
(f_attribute(Var_ORG,inst_MetallurgyIndustry))))).

fof(axEconomyLem21, axiom, 
 ( ! [Var_X] : 
 ((hasType(type_RealNumber, Var_X) & hasType(type_Quantity, Var_X)) => 
(( ! [Var_AMOUNT] : 
 (hasType(type_Entity, Var_AMOUNT) => 
(((Var_AMOUNT = f_MeasureFn(Var_X,inst_KilowattHour)) => (Var_AMOUNT = f_MeasureFn(f_MultiplicationFn(3600000,Var_X),inst_Joule)))))))))).

fof(axEconomyLem22, axiom, 
 ( ! [Var_X] : 
 ((hasType(type_RealNumber, Var_X) & hasType(type_Quantity, Var_X)) => 
(( ! [Var_AMOUNT] : 
 (hasType(type_Entity, Var_AMOUNT) => 
(((Var_AMOUNT = f_MeasureFn(Var_X,inst_Joule)) => (Var_AMOUNT = f_MeasureFn(f_MultiplicationFn(2.778e-4,Var_X),inst_Watt)))))))))).

fof(axEconomyLem23, axiom, 
 ( ! [Var_AGENT2] : 
 ((hasType(type_Agent, Var_AGENT2) & hasType(type_Entity, Var_AGENT2)) => 
(( ! [Var_AGENT1] : 
 ((hasType(type_Agent, Var_AGENT1) & hasType(type_Object, Var_AGENT1)) => 
(((f_exportPartner(Var_AGENT1,Var_AGENT2)) => (( ? [Var_EXPORT] : 
 (hasType(type_Exporting, Var_EXPORT) &  
(((f_origin(Var_EXPORT,Var_AGENT1)) & (f_destination(Var_EXPORT,Var_AGENT2))))))))))))))).

fof(axEconomyLem24, axiom, 
 ( ! [Var_EXPORT] : 
 (hasType(type_Exporting, Var_EXPORT) => 
(( ? [Var_ITEM] : 
 (hasType(type_Object, Var_ITEM) &  
(f_patient(Var_EXPORT,Var_ITEM)))))))).

fof(axEconomyLem25, axiom, 
 ( ! [Var_EXPORT] : 
 (hasType(type_Exporting, Var_EXPORT) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(( ! [Var_ITEM] : 
 ((hasType(type_Entity, Var_ITEM) & hasType(type_Physical, Var_ITEM)) => 
(((((f_patient(Var_EXPORT,Var_ITEM)) & (f_holdsDuring(f_BeginFn(f_WhenFn(Var_EXPORT)),located(Var_ITEM,Var_AREA))))) => (f_holdsDuring(f_EndFn(f_WhenFn(Var_EXPORT)),located(Var_ITEM,Var_AREA)))))))))))))).

fof(axEconomyLem26, axiom, 
 ( ! [Var_EXPORT] : 
 (hasType(type_Exporting, Var_EXPORT) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(( ! [Var_ITEM] : 
 ((hasType(type_Entity, Var_ITEM) & hasType(type_Physical, Var_ITEM)) => 
(((((f_patient(Var_EXPORT,Var_ITEM)) & (f_destination(Var_EXPORT,Var_AREA)))) => (f_holdsDuring(f_EndFn(f_WhenFn(Var_EXPORT)),located(Var_ITEM,Var_AREA)))))))))))))).

fof(axEconomyLem27, axiom, 
 ( ! [Var_EXPORT] : 
 (hasType(type_Exporting, Var_EXPORT) => 
(( ! [Var_AREA1] : 
 (hasType(type_GeopoliticalArea, Var_AREA1) => 
(( ! [Var_AREA2] : 
 (hasType(type_GeopoliticalArea, Var_AREA2) => 
(( ! [Var_ITEM] : 
 ((hasType(type_Entity, Var_ITEM) & hasType(type_Physical, Var_ITEM)) => 
(((((f_patient(Var_EXPORT,Var_ITEM)) & (((f_holdsDuring(f_BeginFn(f_WhenFn(Var_EXPORT)),located(Var_ITEM,Var_AREA1))) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_EXPORT)),located(Var_ITEM,Var_AREA2))))))) => (( ~ (f_located(Var_AREA2,Var_AREA1)))))))))))))))))).

fof(axEconomyLem28, axiom, 
 ( ! [Var_EXPORT] : 
 (hasType(type_Exporting, Var_EXPORT) => 
(( ! [Var_AREA1] : 
 (hasType(type_GeopoliticalArea, Var_AREA1) => 
(( ! [Var_AREA2] : 
 (hasType(type_GeopoliticalArea, Var_AREA2) => 
(( ! [Var_ITEM] : 
 (hasType(type_Entity, Var_ITEM) => 
(((((f_patient(Var_EXPORT,Var_ITEM)) & (((f_origin(Var_EXPORT,Var_AREA1)) & (f_destination(Var_EXPORT,Var_AREA2)))))) => (Var_AREA1 != Var_AREA2))))))))))))))).

fof(axEconomyLem29, axiom, 
 ( ! [Var_EXPORT] : 
 (hasType(type_Exporting, Var_EXPORT) => 
(( ! [Var_AREA1] : 
 (hasType(type_GeopoliticalArea, Var_AREA1) => 
(( ! [Var_AREA2] : 
 (hasType(type_GeopoliticalArea, Var_AREA2) => 
(( ! [Var_ITEM] : 
 (hasType(type_Entity, Var_ITEM) => 
(((((f_patient(Var_EXPORT,Var_ITEM)) & (((f_origin(Var_EXPORT,Var_AREA1)) & (f_destination(Var_EXPORT,Var_AREA2)))))) => (( ~ (f_located(Var_AREA2,Var_AREA1)))))))))))))))))).

fof(axEconomyLem30, axiom, 
 ( ! [Var_YEAR] : 
 (hasType(type_Quantity, Var_YEAR) => 
(( ! [Var_FRACTION] : 
 (hasType(type_PositiveRealNumber, Var_FRACTION) => 
(( ! [Var_AREA2] : 
 (hasType(type_GeopoliticalArea, Var_AREA2) => 
(( ! [Var_AREA1] : 
 (hasType(type_GeopoliticalArea, Var_AREA1) => 
(((f_exportPartnerByFraction(Var_AREA1,Var_AREA2,Var_FRACTION)) => (f_lessThanOrEqualTo(Var_YEAR,1.0)))))))))))))))).

fof(axEconomyLem31, axiom, 
 ( ! [Var_AGENT2] : 
 ((hasType(type_Agent, Var_AGENT2) & hasType(type_Object, Var_AGENT2)) => 
(( ! [Var_AGENT1] : 
 ((hasType(type_Agent, Var_AGENT1) & hasType(type_Entity, Var_AGENT1)) => 
(((f_importPartner(Var_AGENT1,Var_AGENT2)) => (( ? [Var_EXPORT] : 
 (hasType(type_Exporting, Var_EXPORT) &  
(((f_origin(Var_EXPORT,Var_AGENT2)) & (f_destination(Var_EXPORT,Var_AGENT1))))))))))))))).

fof(axEconomyLem32, axiom, 
 ( ! [Var_YEAR] : 
 (hasType(type_Quantity, Var_YEAR) => 
(( ! [Var_FRACTION] : 
 (hasType(type_PositiveRealNumber, Var_FRACTION) => 
(( ! [Var_AREA2] : 
 (hasType(type_GeopoliticalArea, Var_AREA2) => 
(( ! [Var_AREA1] : 
 (hasType(type_GeopoliticalArea, Var_AREA1) => 
(((f_importPartnerByFraction(Var_AREA1,Var_AREA2,Var_FRACTION)) => (f_lessThanOrEqualTo(Var_YEAR,1.0)))))))))))))))).

fof(axEconomyLem33, axiom, 
 ( ! [Var_AG] : 
 (hasType(type_Agriculture, Var_AG) => 
(f_resultType(Var_AG,type_AgriculturalProduct))))).

fof(axEconomyLem34, axiom, 
 ( ! [Var_ITEM] : 
 (hasType(type_PackagedFoodProduct, Var_ITEM) => 
(( ? [Var_FOOD] : 
 (hasType(type_FoodProduct, Var_FOOD) &  
(( ? [Var_PACKAGE] : 
 (hasType(type_ProductPackage, Var_PACKAGE) &  
(f_contains(Var_PACKAGE,Var_FOOD))))))))))).

fof(axEconomyLem35, axiom, 
 ( ! [Var_ITEM] : 
 (hasType(type_PackagedBeverageProduct, Var_ITEM) => 
(( ? [Var_DRINK] : 
 (hasType(type_BeverageProduct, Var_DRINK) &  
(( ? [Var_PACKAGE] : 
 (hasType(type_ProductPackage, Var_PACKAGE) &  
(f_contains(Var_PACKAGE,Var_DRINK))))))))))).

fof(axEconomyLem36, axiom, 
 ( ! [Var_ORE] : 
 (hasType(type_Bauxite, Var_ORE) => 
(( ? [Var_METAL] : 
 (hasType(type_Alumina, Var_METAL) &  
(f_component(Var_METAL,Var_ORE)))))))).

fof(axEconomyLem37, axiom, 
 ( ! [Var_ORE] : 
 (hasType(type_IronOre, Var_ORE) => 
(( ? [Var_METAL] : 
 (hasType(type_Iron, Var_METAL) &  
(f_component(Var_METAL,Var_ORE)))))))).

fof(axEconomyLem38, axiom, 
 ( ! [Var_ORE] : 
 (hasType(type_CopperOre, Var_ORE) => 
(( ? [Var_METAL] : 
 (hasType(type_Copper, Var_METAL) &  
(f_component(Var_METAL,Var_ORE)))))))).

fof(axEconomyLem39, axiom, 
 ( ! [Var_ORE] : 
 (hasType(type_NickelOre, Var_ORE) => 
(( ? [Var_METAL] : 
 (hasType(type_Nickel, Var_METAL) &  
(f_component(Var_METAL,Var_ORE)))))))).

fof(axEconomyLem40, axiom, 
 ( ! [Var_ORE] : 
 (hasType(type_LeadOre, Var_ORE) => 
(( ? [Var_METAL] : 
 (hasType(type_Lead, Var_METAL) &  
(f_component(Var_METAL,Var_ORE)))))))).

fof(axEconomyLem41, axiom, 
 ( ! [Var_ORE] : 
 (hasType(type_ZincOre, Var_ORE) => 
(( ? [Var_METAL] : 
 (hasType(type_Zinc, Var_METAL) &  
(f_component(Var_METAL,Var_ORE)))))))).

fof(axEconomyLem42, axiom, 
 ( ! [Var_ITEM] : 
 (hasType(type_Steel, Var_ITEM) => 
(( ? [Var_PART] : 
 (hasType(type_Iron, Var_PART) &  
(f_part(Var_PART,Var_ITEM)))))))).

fof(axEconomyLem43, axiom, 
 ( ! [Var_ITEM] : 
 (hasType(type_Steel, Var_ITEM) => 
(( ? [Var_PART] : 
 (hasType(type_Carbon, Var_PART) &  
(f_part(Var_PART,Var_ITEM)))))))).

fof(axEconomyLem44, axiom, 
 ( ! [Var_ITEM] : 
 (hasType(type_IronMetal, Var_ITEM) => 
(( ? [Var_PART] : 
 (hasType(type_Iron, Var_PART) &  
(f_part(Var_PART,Var_ITEM)))))))).

fof(axEconomyLem45, axiom, 
 ( ! [Var_ITEM] : 
 (hasType(type_AluminumMetal, Var_ITEM) => 
(( ? [Var_PART] : 
 (hasType(type_Aluminum, Var_PART) &  
(f_part(Var_PART,Var_ITEM)))))))).

fof(axEconomyLem46, axiom, 
 ( ! [Var_ITEM] : 
 (hasType(type_LeadMetal, Var_ITEM) => 
(( ? [Var_PART] : 
 (hasType(type_Lead, Var_PART) &  
(f_part(Var_PART,Var_ITEM)))))))).

fof(axEconomyLem47, axiom, 
 ( ! [Var_CONCRETE] : 
 (hasType(type_Concrete, Var_CONCRETE) => 
(( ? [Var_PART] : 
 (hasType(type_Mineral, Var_PART) &  
(f_component(Var_PART,Var_CONCRETE)))))))).

fof(axEconomyLem48, axiom, 
 ( ! [Var_CONCRETE] : 
 (hasType(type_Concrete, Var_CONCRETE) => 
(( ? [Var_PART] : 
 (hasType(type_Cement, Var_PART) &  
(f_component(Var_PART,Var_CONCRETE)))))))).

