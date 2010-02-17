fof(axMilitaryPred0, axiom, 
 f_subEchelon(type_Brigade,type_Battalion)).

fof(axMilitaryPred1, axiom, 
 f_subEchelon(type_Battalion,type_Company_Military)).

fof(axMilitaryPred2, axiom, 
 f_commandRankOfEchelon(type_Battalion,inst_USMilitaryRankO5)).

fof(axMilitaryPred3, axiom, 
 f_subEchelon(type_Company_Military,type_Platoon)).

fof(axMilitaryPred4, axiom, 
 f_commandRankOfEchelon(type_Company_Military,f_UnionFn(inst_USMilitaryRankO3,inst_USMilitaryRankO4))).

fof(axMilitaryPred5, axiom, 
 f_commandRankOfEchelon(type_Platoon,inst_USMilitaryRankO2)).

