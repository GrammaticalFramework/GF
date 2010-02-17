abstract Military = open Merge, Mid_level_ontology in {




--  A modern nation_states' air forces 
-- (the whole branch of service) and not a subdivision thereof.
fun AirForce_BranchOfService : Class ;
fun AirForce_BranchOfService_Class : SubClass AirForce_BranchOfService MilitaryOrganization ;

-- (AvailableForMilitaryServiceMaleFn
--  ?AREA) denotes the Integer that represents the count of the population of 
-- males of military age in the GeopoliticalArea ?AREA.
fun AvailableForMilitaryServiceMaleFn : El GeopoliticalArea -> Ind Integer ;


-- In military terminology, a battalion consists of 
-- two to six companies typically commanded by a lieutenant colonel. The 
-- nomenclature varies by nationality and by branch of arms, e.g. some 
-- armies organize their infantry into battalions, but call battalion_sized 
-- cavalry, reconnaissance, or tank units a squadron or a regiment instead. 
-- There may even be subtle distinctions within a nation's branches of arms, 
-- such a distinction between a tank battalion and an armored squadron, 
-- depending on how the unit's operational role is perceived to fit into the 
-- army's historical organization. A battalion is potentially the smallest 
-- military unit capable of independent operations (i.e. not attached to a 
-- higher command), but is usually part of a regiment or a brigade or both, 
-- depending on the organizational model used by that service. Battalions 
-- are ordinarily homogeneous with respect to type (e.g. an infantry 
-- battalion or a tank battalion), although there are occasional 
-- exceptions. (from Wikipedia)
fun Battalion : Class ;
fun Battalion_Class : SubClass Battalion MilitaryUnit ;

-- Brigade is a term from military science which 
-- refers to a group of several battalions (typically two to four), and 
-- directly attached supporting units (normally including at least an 
-- artillery battery and additional logistic support). A brigade is smaller 
-- than a division and roughly equal to or a little larger than a regiment. 
-- Strength typically ranges between 1,500 and 3,500 personnel. (from Wikipedia)
fun Brigade : Class ;
fun Brigade_Class : SubClass Brigade MilitaryUnit ;

-- In military organizations, an officer 
-- is a member of the service who holds a position of responsibility. 
-- Commissioned officers derive authority directly from a sovereign power 
-- and, as such, hold a commission charging them with the duties and 
-- responsibilities of a specific office or position. Commissioned officers 
-- are typically the only persons in a military able to exercise command 
-- (according to the most technical definition of the word) over a military 
-- unit. Non_commissioned officers in positions of authority can be said to 
-- have control or charge rather than command per se, although the use of the 
-- word command to describe any use of authority is widespread and often 
-- official. (from Wikipedia)
fun CommissionedOfficerRank : Class ;
fun CommissionedOfficerRank_Class : SubClass CommissionedOfficerRank MilitaryRank ;

-- The ranks of junior officers are the 
-- three or four lowest ranks of officers, possibily complicated by the 
-- status of trainee officers. Their units are generally not expected to 
-- operate independently for any significant length of time. Typical ranks 
-- for this level are captains, who typically lead companies and smaller 
-- units Lieutenant. Company grade officers will also fill staff roles in 
-- some units. (from Wikipedia)
fun CompanyGradeRank : Class ;
fun CompanyGradeRank_Class : SubClass CompanyGradeRank CommissionedOfficerRank ;

-- A company is a military unit, typically 
-- consisting of 100_200 soldiers. Most companies are formed of three or 
-- four platoons although the exact number may vary by country, unit type and 
-- structure. (from Wikipedia)
fun Company_Military : Class ;
fun Company_Military_Class : SubClass Company_Military MilitaryUnit ;

-- Soldiers who are enlisted in some 
-- military and have no command.
fun EnlistedSoldierRank : Class ;
fun EnlistedSoldierRank_Class : SubClass EnlistedSoldierRank MilitaryRank ;

-- Senior officers who typically 
-- command units that can be expected to operate independently for short 
-- periods of time (battalions and regiments, large warships). Field Grade 
-- officers also commonly fill staff positions. (from Wikipedia)
fun FieldGradeOfficerRank : Class ;
fun FieldGradeOfficerRank_Class : SubClass FieldGradeOfficerRank CommissionedOfficerRank ;

-- (FitForMilitaryServiceMaleFn
--  ?AREA) denotes the Integer that represents the count of the population of 
-- males of military age in the GeopoliticalArea ?AREA that is also capable
-- of being a member of the military.
fun FitForMilitaryServiceMaleFn : El GeopoliticalArea -> Ind Integer ;


-- Admirals (Navy), Generals (Army) and 
-- Marshals who typically command units that are expected to operate 
-- independently for extended periods of time (brigades and larger, fleets of 
-- ships). (from Wikipedia)
fun FlagOfficerRank : Class ;
fun FlagOfficerRank_Class : SubClass FlagOfficerRank CommissionedOfficerRank ;

-- Military operations conducted to 
-- distribute food to the friendly force. (from FM 100_40)
fun FoodDistributionOperation : Class ;
fun FoodDistributionOperation_Class : SubClass FoodDistributionOperation (both Getting (both Giving MilitaryOperation)) ;


-- A MilitaryUnit composed primarily of Soldiers 
-- who fight on foot, i.e. without the use of heavy artillery.
fun InfantryUnit : Class ;
fun InfantryUnit_Class : SubClass InfantryUnit MilitaryUnit ;

-- Ranks with grade E5 or E6.
fun JuniorNCORank : Class ;
fun JuniorNCORank_Class : SubClass JuniorNCORank NonCommissionedOfficerRank ;

-- Modern nation_states' marine units (the 
-- whole branch of service) and not a subdivision thereof.
fun Marines_BranchOfService : Class ;
fun Marines_BranchOfService_Class : SubClass Marines_BranchOfService MilitaryOrganization ;

-- A Convoy of MilitaryVehicles, travelling to the same 
-- at least intermediate destination, in relatively close proximity.
fun MilitaryConvoy : Class ;
fun MilitaryConvoy_Class : SubClass MilitaryConvoy Convoy ;

-- Trucks used by a military to transport food.
fun MilitaryFoodTruck : Class ;
fun MilitaryFoodTruck_Class : SubClass MilitaryFoodTruck MilitarySupportVehicle ;

-- A MilitaryOperation is distinguished 
-- from the broader class of MilitaryProcess in that it is planned in 
-- advance.
fun MilitaryOperation : Class ;
fun MilitaryOperation_Class : SubClass MilitaryOperation MilitaryProcess ;

-- Military platforms. These are usually mobile 
-- entities which can carry military equipment such as Weapons and 
-- communications equipment. Often, as with a tank outfitted with a gun, a 
-- MilitaryPlatform carrying some Weapon comprises a WeaponSystem.
fun MilitaryPlatform : Class ;
fun MilitaryPlatform_Class : SubClass MilitaryPlatform TransportationDevice ;

-- The class of Positions in a Military. Rank
-- is usually commensurate with degrees of power, prestige and
-- pay.
fun MilitaryRank : Class ;
fun MilitaryRank_Class : SubClass MilitaryRank SkilledOccupation ;

-- Trucks used by a military to transport supplies.
fun MilitarySupplyTruck : Class ;
fun MilitarySupplyTruck_Class : SubClass MilitarySupplyTruck (both MilitarySupportVehicle Truck) ;


-- Vehicles meant to be used for support, rather
-- than combat in a military context.
fun MilitarySupportVehicle : Class ;
fun MilitarySupportVehicle_Class : SubClass MilitarySupportVehicle MilitaryVehicle ;

fun MilitaryVehicle_MilitaryPlatform : SubClass MilitaryVehicle MilitaryPlatform ;

-- Modern nation_states' naval air 
-- forces (the whole branch of service) and not a subdivision thereof.
fun NavalAirForce_BranchOfService : Class ;
fun NavalAirForce_BranchOfService_Class : SubClass NavalAirForce_BranchOfService MilitaryOrganization ;

-- MilitaryOrganizations that are sea forces.
fun Navy_BranchOfService : Class ;
fun Navy_BranchOfService_Class : SubClass Navy_BranchOfService MilitaryOrganization ;

-- Non_commissioned officers, or NCOs, in 
-- positions of authority can be said to have control or charge rather than 
-- command per se, although the use of the word command to describe any use 
-- of authority is widespread and often official. This is distinguished from 
-- the official responsibility for command entrusted to a 
-- CommissionedOfficer. NCOs are enlisted positions. (from Wikipedia)
fun NonCommissionedOfficerRank : Class ;
fun NonCommissionedOfficerRank_Class : SubClass NonCommissionedOfficerRank EnlistedSoldierRank ;

-- A MilitaryUnit, the purpose of which is
-- to prevent violent actions but providing deterrent to such actions through
-- the threat of overwhelming retaliation.
fun PeacekeepingUnit : Class ;
fun PeacekeepingUnit_Class : SubClass PeacekeepingUnit MilitaryUnit ;

-- Platoon is a term from military science. In an 
-- army, a platoon is a unit of thirty to forty soldiers typically commanded 
-- by a Lieutenant assisted by a non_commissioned officer. A platoon is 
-- formed by at least two squads (usually 3 or 4) and is smaller than a 
-- company (typically there are 3 or 4 platoons per company). Most platoons 
-- are infantry platoons, some carry other designations such as mortar or 
-- heavy weapons platoons. A platoon is the smallest military unit led by a 
-- commissioned officer. (from Wikipedia)
fun Platoon : Class ;
fun Platoon_Class : SubClass Platoon MilitaryUnit ;

-- The lowest group of ranks in the military
-- (Grade E1 through E4). These Soldiers usually have no authority
-- based on their ranks.
fun PrivateRank : Class ;
fun PrivateRank_Class : SubClass PrivateRank EnlistedSoldierRank ;

-- (equal 
-- (ReachingMilitaryAgeAnnuallyMaleFn ?AREA ?YEAR) ?COUNT) means that in the
-- GeopoliticalArea ?AREA, there are ?COUNT number of male individuals who for 
-- that year ?YEAR come to be of militaryAge.
fun ReachingMilitaryAgeAnnuallyMaleFn : El GeopoliticalArea -> El Year -> Ind Integer ;


-- Military operations conducted to protect the friendly 
-- force by providing early and accurate warning of enemy operations, to provide the force 
-- being protected with time and maneuver space within which to react to the enemy, and to 
-- develop the situation to allow the commander to effectively use the protected force. 
-- Security operations orient on the force or facility to be protected, rather than on the 
-- enemy. (from FM 100_40).
fun SecurityOperation : Class ;
fun SecurityOperation_Class : SubClass SecurityOperation MilitaryOperation ;

-- Ranks with grade E7 through E9.
fun SeniorNCORank : Class ;
fun SeniorNCORank_Class : SubClass SeniorNCORank NonCommissionedOfficerRank ;

-- Any Soldier who is tasked with
-- carrying the colors of his/her unit in Battles and parades.
fun StandardBearer : Class ;
fun StandardBearer_Class : SubClass StandardBearer Soldier ;

-- Any Soldier who served during the
-- American Civil War
fun USCivilWarSoldier : Ind Soldier ;


-- The class of Positions in the USMilitary.
fun USMilitaryRank : Class ;
fun USMilitaryRank_Class : SubClass USMilitaryRank MilitaryRank ;

-- A USMilitaryRank that is variously called
-- Airman Basic in the Air Force, Private in the USArmy, 
-- Private in the USMarineCorps, and Seaman Recruit in the USNavy.
fun USMilitaryRankE1 : Ind (both PrivateRank USMilitaryRank) ;


-- A USMilitaryRank that is variously called
-- Airman in the Air Force, Private in the USArmy, 
-- Private First Class in the USMarineCorps, and Seaman Apprentice in the USNavy.
fun USMilitaryRankE2 : Ind (both PrivateRank USMilitaryRank) ;


-- A USMilitaryRank that is variously called
-- Airman First Class in the Air Force, Private First Class in the USArmy, 
-- Lance Corporal in the USMarineCorps, and Seaman in the USNavy.
fun USMilitaryRankE3 : Ind (both PrivateRank USMilitaryRank) ;


-- A USMilitaryRank that is variously called
-- Senior Airman in the Air Force, Specialist or Corporal in the USArmy, 
-- Corporal in the USMarineCorps, and Petty Officer 3rd Class in the USNavy.
fun USMilitaryRankE4 : Ind (both PrivateRank USMilitaryRank) ;


-- A USMilitaryRank that is variously called
-- Staff Sergeant in the Air Force, Sergeant in the USArmy, 
-- Sergeant in the USMarineCorps, and Petty Officer 2nd Class in the USNavy.
fun USMilitaryRankE5 : Ind (both JuniorNCORank USMilitaryRank) ;


-- A USMilitaryRank that is variously called
-- Technical Sergeant in the Air Force, Staff Sergeant in the USArmy, 
-- Staff Sergeant in the USMarineCorps, and Petty Officer 1st Class in the USNavy.
fun USMilitaryRankE6 : Ind (both JuniorNCORank USMilitaryRank) ;


-- A USMilitaryRank that is variously called
-- Master Sergeant in the Air Force, Sergeant First Class in the USArmy, 
-- Gunnery Sergeant in the USMarineCorps, and Chief Petty Officer in the USNavy.
fun USMilitaryRankE7 : Ind (both SeniorNCORank USMilitaryRank) ;


-- A USMilitaryRank that is variously called
-- Senior Master Sergeant in the Air Force, Master Sergeant or First Sergeant in the USArmy, 
-- Master Sergeant or First Sergeant in the USMarineCorps, and Senior Chief Petty Officer in the USNavy.
fun USMilitaryRankE8 : Ind (both SeniorNCORank USMilitaryRank) ;


-- A USMilitaryRank that is variously 
-- called Chief Master Sergeant or Command Chief Master Sergeant or Chief 
-- Master Sergeant of the Air Force in the Air Force, Sergeant Major or 
-- Command Sergeant Major or Sergeant Major of the Army in the USArmy, 
-- Master Gunnery Sergeant or Sergeant Major or Sergeant Major of the Marine 
-- Corps in the USMarineCorps, and Master Chief Petty Officer or Command 
-- Master Chief Petty Officer or Master Chief Petty Officer of the Navy in 
-- the USNavy.
fun USMilitaryRankE9 : Ind (both SeniorNCORank USMilitaryRank) ;


-- A special USMilitaryRank
-- above E9 that marks usually the end of carrier of non_commissioned
-- officers.
fun USMilitaryRankE9special : Ind (both USMilitaryRank SeniorNCORank) ;


fun USMilitaryRankO1 : Ind (both CompanyGradeRank USMilitaryRank) ;

fun USMilitaryRankO10 : Ind (both FlagOfficerRank USMilitaryRank) ;

fun USMilitaryRankO2 : Ind (both CompanyGradeRank USMilitaryRank) ;

fun USMilitaryRankO3 : Ind (both CompanyGradeRank USMilitaryRank) ;

fun USMilitaryRankO4 : Ind (both FieldGradeOfficerRank USMilitaryRank) ;

fun USMilitaryRankO5 : Ind (both FieldGradeOfficerRank USMilitaryRank) ;

fun USMilitaryRankO6 : Ind (both FieldGradeOfficerRank USMilitaryRank) ;

fun USMilitaryRankO7 : Ind (both FlagOfficerRank USMilitaryRank) ;

fun USMilitaryRankO8 : Ind (both FlagOfficerRank USMilitaryRank) ;

fun USMilitaryRankO9 : Ind (both FlagOfficerRank USMilitaryRank) ;

fun USMilitaryRankSpecial : Ind (both FlagOfficerRank USMilitaryRank) ;

fun USMilitaryRankWO1 : Ind (both USWarrantOfficerRank USMilitaryRank) ;

fun USMilitaryRankWO2 : Ind (both USWarrantOfficerRank (both USMilitaryRank CommissionedOfficerRank)) ;

fun USMilitaryRankWO3 : Ind (both USWarrantOfficerRank (both USMilitaryRank CommissionedOfficerRank)) ;

fun USMilitaryRankWO4 : Ind (both USWarrantOfficerRank (both USMilitaryRank CommissionedOfficerRank)) ;

fun USMilitaryRankWO5 : Ind (both USWarrantOfficerRank (both USMilitaryRank CommissionedOfficerRank)) ;

-- Any Soldier who served
-- during the American Revolutionary War
fun USRevolutionaryWarSoldier : Ind Soldier ;


-- In the United States military, a 
-- warrant officer was originally, and strictly, a highly skilled, 
-- single_track specialty officer. But as many chief warrant officers assume 
-- positions as officer in charge or department head, along with the high 
-- number of bachelor's and master’s degrees held within the community, their 
-- contribution and expertise as a community is ever_increasing. There are 
-- no 'warrant officers' per se in the U.S. Navy, but rather the term 'chief 
-- warrant officer' is correct. In the U.S. Navy, a sailor must be in one 
-- of the top three enlisted ranks to be eligible to become a Chief Warrant 
-- Officer. In the U.S. Army, a person can progress to the warrant officer 
-- rank at a grade lower than E_7 thus having a longer career and greater 
-- opportunity to serve and grow. In the U.S. Marine Corps, after serving 
-- at least eight years of enlisted service, and reaching the grade of E_5 
-- (sergeant), an enlisted Marine can apply for the Warrant Officer program. 
-- Upon the initial appointment to WO1 a warrant is given by the secretary of 
-- the service, and upon promotion to chief warrant officer (CW2 and above) 
-- they are commissioned by the President of the United States, take the same 
-- oath and receive the same commission and charges as commissioned officers, 
-- thus deriving their authority from the same source.
fun USWarrantOfficerRank : Class ;
fun USWarrantOfficerRank_Class : SubClass USWarrantOfficerRank CommissionedOfficerRank ;

-- (betweenOnPath ?OBJ1 ?OBJ2 ?OBJ3 ?PATH) 
-- means that ?OBJ2 is spatially located between ?OBJ1 and ?OBJ3 on the path 
-- ?PATH. Note that this is a more specialized relation of between since any 
-- object that is between others with respect to a particular path is also 
-- simply between them.
fun betweenOnPath : El Object -> El Object -> El Object -> Formula ;


-- The typical MilitaryRank of
-- the leader of an instance of the given MilitaryEchelon.
fun commandRankOfEchelon: Desc MilitaryUnit -> El MilitaryRank -> Formula ;


-- (fitForMilitaryService ?AGENT ?PROCESS)
-- means that ?AGENT is capable of carrying out the MilitaryProcess ?PROCESS as
-- the agent of the ?PROCESS.
fun fitForMilitaryService: El CognitiveAgent -> Desc MilitaryProcess -> Formula ;


-- (militaryAge ?AREA ?AGE) means that in the 
-- GeopoliticalArea ?AREA, a person must be ?AGE or older in order to be a
-- member of the military of the ?AREA.
fun militaryAge : El GeopoliticalArea -> El TimeDuration -> Formula ;


-- (militaryExpendituresFractionOfGDP ?AREA ?FRACTION) means 
-- that the estimated military spending of the GeopoliticalArea ?AREA is 
-- ?FRACTION of the gross domestic product (GDP) of that area.
fun militaryExpendituresFractionOfGDP : El GeopoliticalArea -> El RationalNumber -> Formula ;


-- (militaryExpendituresFractionOfGDPInPeriod ?AREA ?FRACTION ?PERIOD) 
-- means that the estimated military spending of the GeopoliticalArea ?AREA 
-- was ?FRACTION of the gross domestic product (GDP) of that area during the
-- TimeInterval indicated by ?PERIOD.
fun militaryExpendituresFractionOfGDPInPeriod : El GeopoliticalArea -> El RationalNumber -> El TimeInterval -> Formula ;


-- (militaryExpendituresInUSDollars ?AREA ?AMOUNT) means that the 
-- estimated military spending of the GeopoliticalArea ?AREA is ?AMOUNT 
-- in UnitedStatesDollars. Note: This predicate was created to represent 
-- data from the CIA World Fact Book, which calculates ?AMOUNT by multiplying 
-- estimated percentage of ?AREA's budget spent on defense by its gross 
-- domestic product (GDP) expressed in U.S. dollars. Note that this GDP is 
-- calculated by the exchange rate method rather than by 
-- PPPBasedEconomicValuation. Military expenditures data is approximate.
fun militaryExpendituresInUSDollars : El GeopoliticalArea -> El CurrencyMeasure -> Formula ;


-- (militaryExpendituresInUSDollarsInPeriod ?AREA ?AMOUNT ?PERIOD) means 
-- that the estimated military spending of the GeopoliticalArea ?AREA was 
-- ?AMOUNT in UnitedStatesDollars during the TimeInterval indicated by 
-- ?PERIOD. Note: This predicate was created to represent data from the CIA 
-- World Fact Book, which calculates ?AMOUNT by multiplying estimated defense 
-- spending of an ?AREA in percentage terms by the gross domestic product (GDP) 
-- for ?PERIOD. Note that for this figure, GDP is calculated by the exchange 
-- rate method rather than by PPPBasedEconomicValuation. In any case, 
-- military expenditures data should be treated as only approximate.
fun militaryExpendituresInUSDollarsInPeriod : El GeopoliticalArea -> El CurrencyMeasure -> El TimeInterval -> Formula ;


-- (militaryOfArea ?MILITARY ?AREA) 
-- denotes that ?MILITARY is a MilitaryOrganization serving in defense of 
-- the GeopoliticalArea ?AREA.
fun militaryOfArea : El MilitaryOrganization -> El GeopoliticalArea -> Formula ;


-- A subEchelon is a relationship between
-- named organizational unit types in which a unit of one type is a
-- subOrganization of the other.
fun subEchelon: Desc MilitaryUnit -> Desc MilitaryUnit -> Formula ;
}
