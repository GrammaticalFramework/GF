fof(axMilitary0, axiom, 
 ( ! [X] : 
 (hasType(type_AirForce_BranchOfService, X) => hasType(type_MilitaryOrganization, X)))).

fof(axMilitary1, axiom, 
 ( ! [X] : 
 (hasType(type_Battalion, X) => hasType(type_MilitaryUnit, X)))).

fof(axMilitary2, axiom, 
 ( ! [X] : 
 (hasType(type_Brigade, X) => hasType(type_MilitaryUnit, X)))).

fof(axMilitary3, axiom, 
 ( ! [X] : 
 (hasType(type_CommissionedOfficerRank, X) => hasType(type_MilitaryRank, X)))).

fof(axMilitary4, axiom, 
 ( ! [X] : 
 (hasType(type_CompanyGradeRank, X) => hasType(type_CommissionedOfficerRank, X)))).

fof(axMilitary5, axiom, 
 ( ! [X] : 
 (hasType(type_Company_Military, X) => hasType(type_MilitaryUnit, X)))).

fof(axMilitary6, axiom, 
 ( ! [X] : 
 (hasType(type_EnlistedSoldierRank, X) => hasType(type_MilitaryRank, X)))).

fof(axMilitary7, axiom, 
 ( ! [X] : 
 (hasType(type_FieldGradeOfficerRank, X) => hasType(type_CommissionedOfficerRank, X)))).

fof(axMilitary8, axiom, 
 ( ! [X] : 
 (hasType(type_FlagOfficerRank, X) => hasType(type_CommissionedOfficerRank, X)))).

fof(axMilitary9, axiom, 
 ( ! [X] : 
 (hasType(type_FoodDistributionOperation, X) => hasType(type_Getting, X)))).

fof(axMilitary10, axiom, 
 ( ! [X] : 
 (hasType(type_FoodDistributionOperation, X) => hasType(type_Giving, X)))).

fof(axMilitary11, axiom, 
 ( ! [X] : 
 (hasType(type_FoodDistributionOperation, X) => hasType(type_MilitaryOperation, X)))).

fof(axMilitary12, axiom, 
 ( ! [X] : 
 (hasType(type_InfantryUnit, X) => hasType(type_MilitaryUnit, X)))).

fof(axMilitary13, axiom, 
 ( ! [X] : 
 (hasType(type_JuniorNCORank, X) => hasType(type_NonCommissionedOfficerRank, X)))).

fof(axMilitary14, axiom, 
 ( ! [X] : 
 (hasType(type_Marines_BranchOfService, X) => hasType(type_MilitaryOrganization, X)))).

fof(axMilitary15, axiom, 
 ( ! [X] : 
 (hasType(type_MilitaryConvoy, X) => hasType(type_Convoy, X)))).

fof(axMilitary16, axiom, 
 ( ! [X] : 
 (hasType(type_MilitaryFoodTruck, X) => hasType(type_MilitarySupportVehicle, X)))).

fof(axMilitary17, axiom, 
 ( ! [X] : 
 (hasType(type_MilitaryOperation, X) => hasType(type_MilitaryProcess, X)))).

fof(axMilitary18, axiom, 
 ( ! [X] : 
 (hasType(type_MilitaryPlatform, X) => hasType(type_TransportationDevice, X)))).

fof(axMilitary19, axiom, 
 ( ! [X] : 
 (hasType(type_MilitaryRank, X) => hasType(type_SkilledOccupation, X)))).

fof(axMilitary20, axiom, 
 ( ! [X] : 
 (hasType(type_MilitarySupplyTruck, X) => hasType(type_MilitarySupportVehicle, X)))).

fof(axMilitary21, axiom, 
 ( ! [X] : 
 (hasType(type_MilitarySupplyTruck, X) => hasType(type_Truck, X)))).

fof(axMilitary22, axiom, 
 ( ! [X] : 
 (hasType(type_MilitarySupportVehicle, X) => hasType(type_MilitaryVehicle, X)))).

fof(axMilitary23, axiom, 
 ( ! [X] : 
 (hasType(type_MilitaryVehicle, X) => hasType(type_MilitaryPlatform, X)))).

fof(axMilitary24, axiom, 
 ( ! [X] : 
 (hasType(type_NavalAirForce_BranchOfService, X) => hasType(type_MilitaryOrganization, X)))).

fof(axMilitary25, axiom, 
 ( ! [X] : 
 (hasType(type_Navy_BranchOfService, X) => hasType(type_MilitaryOrganization, X)))).

fof(axMilitary26, axiom, 
 ( ! [X] : 
 (hasType(type_NonCommissionedOfficerRank, X) => hasType(type_EnlistedSoldierRank, X)))).

fof(axMilitary27, axiom, 
 ( ! [X] : 
 (hasType(type_PeacekeepingUnit, X) => hasType(type_MilitaryUnit, X)))).

fof(axMilitary28, axiom, 
 ( ! [X] : 
 (hasType(type_Platoon, X) => hasType(type_MilitaryUnit, X)))).

fof(axMilitary29, axiom, 
 ( ! [X] : 
 (hasType(type_PrivateRank, X) => hasType(type_EnlistedSoldierRank, X)))).

fof(axMilitary30, axiom, 
 ( ! [X] : 
 (hasType(type_SecurityOperation, X) => hasType(type_MilitaryOperation, X)))).

fof(axMilitary31, axiom, 
 ( ! [X] : 
 (hasType(type_SeniorNCORank, X) => hasType(type_NonCommissionedOfficerRank, X)))).

fof(axMilitary32, axiom, 
 ( ! [X] : 
 (hasType(type_StandardBearer, X) => hasType(type_Soldier, X)))).

fof(axMilitary33, axiom, 
 ( ! [X] : 
 (hasType(type_USMilitaryRank, X) => hasType(type_MilitaryRank, X)))).

fof(axMilitary34, axiom, 
 ( ! [X] : 
 (hasType(type_USWarrantOfficerRank, X) => hasType(type_CommissionedOfficerRank, X)))).

fof(axMilitary35, axiom, 
 (hasType(type_PrivateRank, inst_USMilitaryRankE1) & hasType(type_USMilitaryRank, inst_USMilitaryRankE1))).

fof(axMilitary36, axiom, 
 (hasType(type_PrivateRank, inst_USMilitaryRankE2) & hasType(type_USMilitaryRank, inst_USMilitaryRankE2))).

fof(axMilitary37, axiom, 
 (hasType(type_PrivateRank, inst_USMilitaryRankE3) & hasType(type_USMilitaryRank, inst_USMilitaryRankE3))).

fof(axMilitary38, axiom, 
 (hasType(type_PrivateRank, inst_USMilitaryRankE4) & hasType(type_USMilitaryRank, inst_USMilitaryRankE4))).

fof(axMilitary39, axiom, 
 (hasType(type_JuniorNCORank, inst_USMilitaryRankE5) & hasType(type_USMilitaryRank, inst_USMilitaryRankE5))).

fof(axMilitary40, axiom, 
 (hasType(type_JuniorNCORank, inst_USMilitaryRankE6) & hasType(type_USMilitaryRank, inst_USMilitaryRankE6))).

fof(axMilitary41, axiom, 
 (hasType(type_SeniorNCORank, inst_USMilitaryRankE7) & hasType(type_USMilitaryRank, inst_USMilitaryRankE7))).

fof(axMilitary42, axiom, 
 (hasType(type_SeniorNCORank, inst_USMilitaryRankE8) & hasType(type_USMilitaryRank, inst_USMilitaryRankE8))).

fof(axMilitary43, axiom, 
 (hasType(type_SeniorNCORank, inst_USMilitaryRankE9) & hasType(type_USMilitaryRank, inst_USMilitaryRankE9))).

fof(axMilitary44, axiom, 
 (hasType(type_USMilitaryRank, inst_USMilitaryRankE9special) & hasType(type_SeniorNCORank, inst_USMilitaryRankE9special))).

fof(axMilitary45, axiom, 
 (hasType(type_CompanyGradeRank, inst_USMilitaryRankO1) & hasType(type_USMilitaryRank, inst_USMilitaryRankO1))).

fof(axMilitary46, axiom, 
 (hasType(type_FlagOfficerRank, inst_USMilitaryRankO10) & hasType(type_USMilitaryRank, inst_USMilitaryRankO10))).

fof(axMilitary47, axiom, 
 (hasType(type_CompanyGradeRank, inst_USMilitaryRankO2) & hasType(type_USMilitaryRank, inst_USMilitaryRankO2))).

fof(axMilitary48, axiom, 
 (hasType(type_CompanyGradeRank, inst_USMilitaryRankO3) & hasType(type_USMilitaryRank, inst_USMilitaryRankO3))).

fof(axMilitary49, axiom, 
 (hasType(type_FieldGradeOfficerRank, inst_USMilitaryRankO4) & hasType(type_USMilitaryRank, inst_USMilitaryRankO4))).

fof(axMilitary50, axiom, 
 (hasType(type_FieldGradeOfficerRank, inst_USMilitaryRankO5) & hasType(type_USMilitaryRank, inst_USMilitaryRankO5))).

fof(axMilitary51, axiom, 
 (hasType(type_FieldGradeOfficerRank, inst_USMilitaryRankO6) & hasType(type_USMilitaryRank, inst_USMilitaryRankO6))).

fof(axMilitary52, axiom, 
 (hasType(type_FlagOfficerRank, inst_USMilitaryRankO7) & hasType(type_USMilitaryRank, inst_USMilitaryRankO7))).

fof(axMilitary53, axiom, 
 (hasType(type_FlagOfficerRank, inst_USMilitaryRankO8) & hasType(type_USMilitaryRank, inst_USMilitaryRankO8))).

fof(axMilitary54, axiom, 
 (hasType(type_FlagOfficerRank, inst_USMilitaryRankO9) & hasType(type_USMilitaryRank, inst_USMilitaryRankO9))).

fof(axMilitary55, axiom, 
 (hasType(type_FlagOfficerRank, inst_USMilitaryRankSpecial) & hasType(type_USMilitaryRank, inst_USMilitaryRankSpecial))).

fof(axMilitary56, axiom, 
 (hasType(type_USWarrantOfficerRank, inst_USMilitaryRankWO1) & hasType(type_USMilitaryRank, inst_USMilitaryRankWO1))).

fof(axMilitary57, axiom, 
 (hasType(type_USWarrantOfficerRank, inst_USMilitaryRankWO2) & hasType(type_USMilitaryRank, inst_USMilitaryRankWO2) & hasType(type_CommissionedOfficerRank, inst_USMilitaryRankWO2))).

fof(axMilitary58, axiom, 
 (hasType(type_USWarrantOfficerRank, inst_USMilitaryRankWO3) & hasType(type_USMilitaryRank, inst_USMilitaryRankWO3) & hasType(type_CommissionedOfficerRank, inst_USMilitaryRankWO3))).

fof(axMilitary59, axiom, 
 (hasType(type_USWarrantOfficerRank, inst_USMilitaryRankWO4) & hasType(type_USMilitaryRank, inst_USMilitaryRankWO4) & hasType(type_CommissionedOfficerRank, inst_USMilitaryRankWO4))).

fof(axMilitary60, axiom, 
 (hasType(type_USWarrantOfficerRank, inst_USMilitaryRankWO5) & hasType(type_USMilitaryRank, inst_USMilitaryRankWO5) & hasType(type_CommissionedOfficerRank, inst_USMilitaryRankWO5))).

fof(axMilitary61, axiom, 
 (hasType(type_Soldier, inst_USCivilWarSoldier))).

fof(axMilitary62, axiom, 
 (hasType(type_Soldier, inst_USRevolutionaryWarSoldier))).

