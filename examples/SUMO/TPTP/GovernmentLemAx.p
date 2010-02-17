fof(axGovLem0, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(( ! [Var_TYPE] : 
 ((hasType(type_FormOfGovernment, Var_TYPE) & hasType(type_Attribute, Var_TYPE)) => 
(((f_governmentType(Var_AREA,Var_TYPE)) => (f_attribute(f_GovernmentFn(Var_AREA),Var_TYPE)))))))))).

fof(axGovLem1, axiom, 
 ( ! [Var_TYPE] : 
 (hasType(type_FormOfGovernment, Var_TYPE) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeopoliticalArea, Var_AREA) & hasType(type_Agent, Var_AREA)) => 
(((f_attribute(f_GovernmentFn(Var_AREA),Var_TYPE)) => (f_governmentType(Var_AREA,Var_TYPE)))))))))).

fof(axGovLem2, axiom, 
 ( ! [Var_TYPE] : 
 ((hasType(type_FormOfGovernment, Var_TYPE) & hasType(type_Attribute, Var_TYPE)) => 
(( ! [Var_PLACE] : 
 ((hasType(type_Agent, Var_PLACE) & hasType(type_GeopoliticalArea, Var_PLACE)) => 
(((((f_governmentType(Var_PLACE,Var_TYPE)) & (f_subAttribute(Var_TYPE,inst_Monarchy)))) => (( ? [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) &  
(( ? [Var_ROLE] : 
 ((hasType(type_Position, Var_ROLE) & hasType(type_Attribute, Var_ROLE)) &  
(((f_chiefOfState(Var_PLACE,Var_ROLE,Var_PERSON)) & (f_subAttribute(Var_ROLE,inst_Monarch)))))))))))))))))).

fof(axGovLem3, axiom, 
 ( ! [Var_PLACE] : 
 (hasType(type_GeopoliticalArea, Var_PLACE) => 
(((f_governmentType(Var_PLACE,inst_AbsoluteMonarchy)) => (f_leaderPosition(Var_PLACE,inst_Monarch))))))).

fof(axGovLem4, axiom, 
 ( ! [Var_PLACE] : 
 (hasType(type_GeopoliticalArea, Var_PLACE) => 
(( ! [Var_TYPE] : 
 ((hasType(type_FormOfGovernment, Var_TYPE) & hasType(type_Attribute, Var_TYPE)) => 
(((((f_governmentType(Var_PLACE,Var_TYPE)) & (f_subAttribute(Var_TYPE,inst_ParliamentaryGovernment)))) => (( ? [Var_ORG] : 
 (hasType(type_Parliament, Var_ORG) &  
(f_subOrganization(Var_ORG,f_GovernmentFn(Var_PLACE)))))))))))))).

fof(axGovLem5, axiom, 
 ( ! [Var_PLACE] : 
 (hasType(type_Agent, Var_PLACE) => 
(((f_governmentType(Var_PLACE,inst_MilitaryDictatorship)) => (f_leaderPosition(Var_PLACE,inst_MilitaryCommander))))))).

fof(axGovLem6, axiom, 
 ( ! [Var_COUNT] : 
 ((hasType(type_NonnegativeInteger, Var_COUNT) & hasType(type_Entity, Var_COUNT)) => 
(( ! [Var_SET] : 
 ((hasType(type_SetOrClass, Var_SET) & (hasType(type_SetOrClass, Var_SET) | hasType(type_Collection, Var_SET))) => 
(((f_cardinality(Var_SET,Var_COUNT)) => (f_CardinalityFn(Var_SET) = Var_COUNT))))))))).

fof(axGovLem7, axiom, 
 ( ! [Var_SET] : 
 (hasType(type_SetOrClass, Var_SET) => 
(( ! [Var_COUNT] : 
 ((hasType(type_Entity, Var_COUNT) & hasType(type_NonnegativeInteger, Var_COUNT)) => 
(((f_CardinalityFn(Var_SET) = Var_COUNT) => (f_cardinality(Var_SET,Var_COUNT)))))))))).

fof(axGovLem8, axiom, 
 ( ! [Var_COUNTRY] : 
 (hasType(type_Agent, Var_COUNTRY) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(((f_dependentGeopoliticalArea(Var_AREA,Var_COUNTRY)) => (f_possesses(Var_COUNTRY,Var_AREA)))))))))).

fof(axGovLem9, axiom, 
 ( ! [Var_COUNTRY] : 
 ((hasType(type_Agent, Var_COUNTRY) & hasType(type_GeopoliticalArea, Var_COUNTRY)) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_GeopoliticalArea, Var_AREA)) => 
(((f_dependentGeopoliticalArea(Var_AREA,Var_COUNTRY)) => (( ~ (f_geopoliticalSubdivision(Var_AREA,Var_COUNTRY)))))))))))).

fof(axGovLem10, axiom, 
 ( ! [Var_COUNTRY] : 
 ((hasType(type_GeopoliticalArea, Var_COUNTRY) & hasType(type_Agent, Var_COUNTRY)) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeopoliticalArea, Var_AREA) & hasType(type_GeographicArea, Var_AREA)) => 
(((f_geopoliticalSubdivision(Var_AREA,Var_COUNTRY)) => (( ~ (f_dependentGeopoliticalArea(Var_AREA,Var_COUNTRY)))))))))))).

fof(axGovLem11, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_OverseasArea, Var_AREA) => 
(( ? [Var_COUNTRY] : 
 (hasType(type_Nation, Var_COUNTRY) &  
(f_dependentGeopoliticalArea(Var_AREA,Var_COUNTRY)))))))).

fof(axGovLem12, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_UnincorporatedUnitedStatesTerritory, Var_AREA) => 
(f_dependentAreaOfType(Var_AREA,inst_UnitedStates,type_OverseasArea))))).

fof(axGovLem13, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_BritishCrownColony, Var_AREA) => 
(f_dependentAreaOfType(Var_AREA,inst_UnitedKingdom,type_BritishCrownColony))))).

fof(axGovLem14, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_ParliamentaryTerritory, Var_AREA) => 
(f_governmentType(f_GovernmentFn(Var_AREA),inst_ParliamentaryGovernment))))).

fof(axGovLem15, axiom, 
 ( ! [Var_DOC] : 
 (hasType(type_ConstitutionDocument, Var_DOC) => 
(( ? [Var_CONST] : 
 (hasType(type_Constitution, Var_CONST) &  
(f_containsInformation(Var_DOC,Var_CONST)))))))).

fof(axGovLem16, axiom, 
 ( ! [Var_TYPE] : 
 ((hasType(type_LegalSystemAttribute, Var_TYPE) & hasType(type_Attribute, Var_TYPE)) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(((f_legalSystemType(Var_AREA,Var_TYPE)) => (f_attribute(f_JudiciaryFn(Var_AREA),Var_TYPE)))))))))).

fof(axGovLem17, axiom, 
 ( ! [Var_CORPUS] : 
 (hasType(type_RegionalLaw, Var_CORPUS) => 
(f_attribute(Var_CORPUS,inst_Law))))).

fof(axGovLem18, axiom, 
 ( ! [Var_CORPUS] : 
 (hasType(type_RegionalLaw, Var_CORPUS) => 
(( ! [Var_PART] : 
 (hasType(type_Proposition, Var_PART) => 
(((f_subProposition(Var_PART,Var_CORPUS)) => (f_attribute(Var_CORPUS,inst_Law)))))))))).

fof(axGovLem19, axiom, 
 ( ! [Var_TYPE] : 
 ((hasType(type_LegalSystemAttribute, Var_TYPE) & hasType(type_Attribute, Var_TYPE)) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(((f_legalSystemType(Var_AREA,Var_TYPE)) => (f_attribute(f_RegionalLawFn(Var_AREA),Var_TYPE)))))))))).

fof(axGovLem20, axiom, 
 ( ! [Var_COUNTRY] : 
 (hasType(type_Nation, Var_COUNTRY) => 
(((f_governmentType(Var_COUNTRY,inst_Democracy)) => (( ? [Var_SUFFRAGE] : 
 (hasType(type_SuffrageLaw, Var_SUFFRAGE) &  
(f_subProposition(Var_SUFFRAGE,f_RegionalLawFn(Var_COUNTRY))))))))))).

fof(axGovLem21, axiom, 
 ( ! [Var_COUNTRY] : 
 (hasType(type_GeopoliticalArea, Var_COUNTRY) => 
(((f_governmentType(Var_COUNTRY,inst_Democracy)) => (f_subProposition(inst_VoterCitizenshipRequirement,f_RegionalLawFn(Var_COUNTRY)))))))).

fof(axGovLem22, axiom, 
 ( ! [Var_COUNTRY] : 
 (hasType(type_Nation, Var_COUNTRY) => 
(( ? [Var_AGERULE] : 
 (hasType(type_VoterAgeRequirement, Var_AGERULE) &  
(f_subProposition(Var_AGERULE,f_RegionalLawFn(Var_COUNTRY))))))))).

fof(axGovLem23, axiom, 
 ( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(( ! [Var_BRANCH] : 
 (hasType(type_Organization, Var_BRANCH) => 
(((f_executiveBranch(Var_BRANCH,Var_ORG)) => (f_subOrganization(Var_BRANCH,Var_ORG)))))))))).

fof(axGovLem24, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(( ! [Var_BRANCH] : 
 (hasType(type_Organization, Var_BRANCH) => 
(((f_executiveBranch(Var_BRANCH,Var_AREA)) => (f_subOrganization(Var_BRANCH,f_GovernmentFn(Var_AREA))))))))))).

fof(axGovLem25, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(( ! [Var_BRANCH] : 
 (hasType(type_Organization, Var_BRANCH) => 
(((((f_executiveBranch(Var_BRANCH,Var_AREA)) & (f_subOrganization(Var_ORG,Var_BRANCH)))) => (f_subOrganization(Var_ORG,f_GovernmentFn(Var_AREA)))))))))))))).

fof(axGovLem26, axiom, 
 ( ! [Var_AGENT] : 
 (hasType(type_Agent, Var_AGENT) => 
(( ! [Var_BRANCH] : 
 ((hasType(type_Organization, Var_BRANCH) & hasType(type_Entity, Var_BRANCH)) => 
(((f_executiveBranch(Var_BRANCH,Var_AGENT)) => (Var_BRANCH = f_ExecutiveBranchFn(Var_AGENT)))))))))).

fof(axGovLem27, axiom, 
 ( ! [Var_ORGANIZATION] : 
 ((hasType(type_Organization, Var_ORGANIZATION) & hasType(type_Agent, Var_ORGANIZATION)) => 
(( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(((f_occupiesPosition(Var_PERSON,inst_Leader,Var_ORGANIZATION)) => (f_leader(Var_ORGANIZATION,Var_PERSON)))))))))).

fof(axGovLem28, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(((f_occupiesPosition(Var_PERSON,inst_Leader,Var_AREA)) => (f_leader(f_GovernmentFn(Var_AREA),Var_PERSON)))))))))).

fof(axGovLem29, axiom, 
 ( ! [Var_ORG] : 
 (hasType(type_Agent, Var_ORG) => 
(( ! [Var_ROLE] : 
 (hasType(type_Position, Var_ROLE) => 
(( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(((((f_leader(Var_ORG,Var_PERSON)) & (f_occupiesPosition(Var_PERSON,Var_ROLE,Var_ORG)))) => (f_leaderPosition(Var_ORG,Var_ROLE))))))))))))).

fof(axGovLem30, axiom, 
 ( ! [Var_COUNTRY] : 
 (hasType(type_Nation, Var_COUNTRY) => 
(( ! [Var_ROLE] : 
 (hasType(type_Position, Var_ROLE) => 
(( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(((((f_leader(Var_COUNTRY,Var_PERSON)) & (f_occupiesPosition(Var_PERSON,Var_ROLE,f_GovernmentFn(Var_COUNTRY))))) => (f_leaderPosition(Var_COUNTRY,Var_ROLE))))))))))))).

fof(axGovLem31, axiom, 
 ( ! [Var_COUNTRY] : 
 (hasType(type_Nation, Var_COUNTRY) => 
(( ! [Var_ROLE] : 
 (hasType(type_Position, Var_ROLE) => 
(((f_leaderPosition(f_GovernmentFn(Var_COUNTRY),Var_ROLE)) => (f_leaderPosition(Var_COUNTRY,Var_ROLE)))))))))).

fof(axGovLem32, axiom, 
 ( ! [Var_COUNTRY] : 
 (hasType(type_Nation, Var_COUNTRY) => 
(( ! [Var_ROLE] : 
 (hasType(type_Position, Var_ROLE) => 
(((f_leaderPosition(Var_COUNTRY,Var_ROLE)) => (f_leaderPosition(f_GovernmentFn(Var_COUNTRY),Var_ROLE)))))))))).

fof(axGovLem33, axiom, 
 ( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(( ! [Var_ROLE] : 
 (hasType(type_Position, Var_ROLE) => 
(( ! [Var_ORG] : 
 (hasType(type_Agent, Var_ORG) => 
(((((f_leaderPosition(Var_ORG,Var_ROLE)) & (f_occupiesPosition(Var_PERSON,Var_ROLE,Var_ORG)))) => (f_leader(Var_ORG,Var_PERSON))))))))))))).

fof(axGovLem34, axiom, 
 ( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(( ! [Var_ROLE] : 
 (hasType(type_Position, Var_ROLE) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(((((f_leaderPosition(Var_AREA,Var_ROLE)) & (f_occupiesPosition(Var_PERSON,Var_ROLE,f_GovernmentFn(Var_AREA))))) => (f_leader(Var_AREA,Var_PERSON))))))))))))).

fof(axGovLem35, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(f_subOrganization(f_CabinetFn(Var_AREA),f_ExecutiveBranchFn(Var_AREA)))))).

fof(axGovLem36, axiom, 
 ( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(( ! [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(((f_chiefOfState(Var_AREA,Var_POSITION,Var_PERSON)) => (f_occupiesPosition(Var_PERSON,Var_POSITION,f_GovernmentFn(Var_AREA)))))))))))))).

fof(axGovLem37, axiom, 
 ( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(( ! [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(((f_chiefOfState(Var_AREA,Var_POSITION,Var_PERSON)) => (f_occupiesPosition(Var_PERSON,inst_Leader,f_GovernmentFn(Var_AREA)))))))))))))).

fof(axGovLem38, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_Nation, Var_AREA) => 
(( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(( ! [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) => 
(((f_chiefOfState(Var_AREA,Var_POSITION,Var_PERSON)) => (f_citizen(Var_PERSON,Var_AREA))))))))))))).

fof(axGovLem39, axiom, 
 ( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(( ! [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(((f_chiefOfState(Var_AREA,Var_POSITION,Var_PERSON)) => (f_chiefOfStateType(Var_AREA,Var_POSITION))))))))))))).

fof(axGovLem40, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_Nation, Var_AREA) => 
(( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(( ! [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) => 
(((f_headOfGovernment(Var_AREA,Var_POSITION,Var_PERSON)) => (f_citizen(Var_PERSON,Var_AREA))))))))))))).

fof(axGovLem41, axiom, 
 ( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(( ! [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(((f_headOfGovernment(Var_AREA,Var_POSITION,Var_PERSON)) => (f_occupiesPosition(Var_PERSON,Var_POSITION,f_GovernmentFn(Var_AREA)))))))))))))).

fof(axGovLem42, axiom, 
 ( ! [Var_ROLE] : 
 (hasType(type_SocialRole, Var_ROLE) => 
(( ! [Var_ELECTION] : 
 (hasType(type_Election, Var_ELECTION) => 
(((f_electionForPosition(Var_ELECTION,Var_ROLE)) => (( ? [Var_CANDIDATE] : 
 (hasType(type_Human, Var_CANDIDATE) &  
(f_candidateForPosition(Var_ELECTION,Var_ROLE,Var_CANDIDATE))))))))))))).

fof(axGovLem43, axiom, 
 ( ! [Var_AGENT] : 
 (hasType(type_Agent, Var_AGENT) => 
(( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(((f_member(Var_AGENT,Var_ORG)) => (f_attribute(Var_AGENT,f_MemberFn(Var_ORG))))))))))).

fof(axGovLem44, axiom, 
 ( ! [Var_AGENT] : 
 (hasType(type_Agent, Var_AGENT) => 
(( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(((f_attribute(Var_AGENT,f_MemberFn(Var_ORG))) => (f_member(Var_AGENT,Var_ORG)))))))))).

fof(axGovLem45, axiom, 
 ( ! [Var_AGENT] : 
 (hasType(type_Human, Var_AGENT) => 
(( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(( ! [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) => 
(((f_attribute(Var_AGENT,f_MemberRoleFn(Var_ORG,Var_POSITION))) => (f_attribute(Var_AGENT,f_MemberFn(Var_ORG)))))))))))))).

fof(axGovLem46, axiom, 
 ( ! [Var_AGENT] : 
 (hasType(type_Human, Var_AGENT) => 
(( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(( ! [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) => 
(((f_attribute(Var_AGENT,f_MemberRoleFn(Var_ORG,Var_POSITION))) => (f_member(Var_AGENT,Var_ORG))))))))))))).

fof(axGovLem47, axiom, 
 ( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(( ! [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) => 
(((f_attribute(Var_PERSON,f_MemberRoleFn(Var_ORG,Var_POSITION))) => (f_occupiesPosition(Var_PERSON,Var_POSITION,Var_ORG))))))))))))).

fof(axGovLem48, axiom, 
 ( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(( ! [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) => 
(( ! [Var_PERSON] : 
 ((hasType(type_Human, Var_PERSON) & hasType(type_Object, Var_PERSON)) => 
(((f_occupiesPosition(Var_PERSON,Var_POSITION,Var_ORG)) => (f_attribute(Var_PERSON,f_MemberRoleFn(Var_ORG,Var_POSITION)))))))))))))).

fof(axGovLem49, axiom, 
 ( ! [Var_GROUP] : 
 (hasType(type_Organization, Var_GROUP) => 
(( ! [Var_ELECTION] : 
 (hasType(type_Election, Var_ELECTION) => 
(((f_electionForOrganization(Var_ELECTION,Var_GROUP)) => (f_electionForPosition(Var_ELECTION,f_MemberFn(Var_GROUP))))))))))).

fof(axGovLem50, axiom, 
 ( ! [Var_GROUP] : 
 (hasType(type_Organization, Var_GROUP) => 
(( ! [Var_ELECTION] : 
 (hasType(type_Election, Var_ELECTION) => 
(((f_electionForPosition(Var_ELECTION,f_MemberFn(Var_GROUP))) => (f_electionForOrganization(Var_ELECTION,Var_GROUP)))))))))).

fof(axGovLem51, axiom, 
 ( ! [Var_CONTENDER] : 
 (hasType(type_Agent, Var_CONTENDER) => 
(( ! [Var_POSITION] : 
 (hasType(type_SocialRole, Var_POSITION) => 
(( ! [Var_ELECTION] : 
 (hasType(type_Election, Var_ELECTION) => 
(((f_candidateForPosition(Var_ELECTION,Var_POSITION,Var_CONTENDER)) => (f_electionForPosition(Var_ELECTION,Var_POSITION))))))))))))).

fof(axGovLem52, axiom, 
 ( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Organization, Var_AGENT)) => 
(( ! [Var_CONTENDER] : 
 ((hasType(type_Agent, Var_CONTENDER) & hasType(type_CognitiveAgent, Var_CONTENDER)) => 
(( ! [Var_POSITION] : 
 ((hasType(type_SocialRole, Var_POSITION) & hasType(type_Position, Var_POSITION)) => 
(( ! [Var_ELECTION] : 
 ((hasType(type_Election, Var_ELECTION) & hasType(type_Process, Var_ELECTION)) => 
(((((f_candidateForPosition(Var_ELECTION,Var_POSITION,Var_CONTENDER)) & (f_agent(Var_ELECTION,Var_AGENT)))) => (f_desires(Var_CONTENDER,occupiesPosition(Var_CONTENDER,Var_POSITION,Var_AGENT))))))))))))))))).

fof(axGovLem53, axiom, 
 ( ! [Var_FRACTION] : 
 (hasType(type_RealNumber, Var_FRACTION) => 
(( ! [Var_CONTENDER] : 
 (hasType(type_Agent, Var_CONTENDER) => 
(( ! [Var_POSITION] : 
 (hasType(type_SocialRole, Var_POSITION) => 
(( ! [Var_ELECTION] : 
 (hasType(type_Election, Var_ELECTION) => 
(((f_voteFractionReceived(Var_ELECTION,Var_POSITION,Var_CONTENDER,Var_FRACTION)) => (f_candidateForPosition(Var_ELECTION,Var_POSITION,Var_CONTENDER)))))))))))))))).

fof(axGovLem54, axiom, 
 ( ! [Var_ELECTION] : 
 (hasType(type_PopularElection, Var_ELECTION) => 
(( ! [Var_NUMBER1] : 
 ((hasType(type_RealNumber, Var_NUMBER1) & hasType(type_Quantity, Var_NUMBER1)) => 
(( ! [Var_PERSON1] : 
 ((hasType(type_Agent, Var_PERSON1) & hasType(type_Entity, Var_PERSON1)) => 
(( ! [Var_POSITION] : 
 (hasType(type_SocialRole, Var_POSITION) => 
(((((f_electionWinner(Var_ELECTION,Var_POSITION,Var_PERSON1)) & (f_voteFractionReceived(Var_ELECTION,Var_POSITION,Var_PERSON1,Var_NUMBER1)))) => (( ? [Var_NUMBER2] : 
 ((hasType(type_RealNumber, Var_NUMBER2) & hasType(type_Quantity, Var_NUMBER2)) &  
(( ~ ( ? [Var_PERSON2] : 
 ((hasType(type_Agent, Var_PERSON2) & hasType(type_Entity, Var_PERSON2)) &  
(((f_voteFractionReceived(Var_ELECTION,Var_POSITION,Var_PERSON2,Var_NUMBER2)) & (((Var_PERSON1 != Var_PERSON2) & (f_greaterThanOrEqualTo(Var_NUMBER2,Var_NUMBER1))))))))))))))))))))))))))).

fof(axGovLem55, axiom, 
 ( ! [Var_ELECTION] : 
 (hasType(type_PopularElection, Var_ELECTION) => 
(( ! [Var_NUMBER2] : 
 ((hasType(type_RealNumber, Var_NUMBER2) & hasType(type_Quantity, Var_NUMBER2)) => 
(( ! [Var_PERSON2] : 
 ((hasType(type_Agent, Var_PERSON2) & hasType(type_Entity, Var_PERSON2)) => 
(( ! [Var_NUMBER1] : 
 ((hasType(type_RealNumber, Var_NUMBER1) & hasType(type_Quantity, Var_NUMBER1)) => 
(( ! [Var_PERSON1] : 
 ((hasType(type_Agent, Var_PERSON1) & hasType(type_Entity, Var_PERSON1)) => 
(( ! [Var_POSITION] : 
 (hasType(type_SocialRole, Var_POSITION) => 
(((((f_electionWinner(Var_ELECTION,Var_POSITION,Var_PERSON1)) & (((f_voteFractionReceived(Var_ELECTION,Var_POSITION,Var_PERSON1,Var_NUMBER1)) & (((f_voteFractionReceived(Var_ELECTION,Var_POSITION,Var_PERSON2,Var_NUMBER2)) & (Var_PERSON1 != Var_PERSON2))))))) => (f_greaterThan(Var_NUMBER1,Var_NUMBER2)))))))))))))))))))))).

fof(axGovLem56, axiom, 
 ( ! [Var_CHAMBER1] : 
 (hasType(type_LegislativeChamber, Var_CHAMBER1) => 
(( ! [Var_CHAMBER2] : 
 (hasType(type_LegislativeChamber, Var_CHAMBER2) => 
(( ! [Var_AREA] : 
 ((hasType(type_Agent, Var_AREA) & hasType(type_GeopoliticalArea, Var_AREA)) => 
(( ! [Var_ORG] : 
 ((hasType(type_Object, Var_ORG) & hasType(type_Organization, Var_ORG)) => 
(((((f_attribute(Var_ORG,inst_UnicameralLegislature)) & (((f_legislativeBranch(Var_ORG,Var_AREA)) & (((f_subOrganization(Var_CHAMBER1,f_GovernmentFn(Var_AREA))) & (f_subOrganization(Var_CHAMBER2,f_GovernmentFn(Var_AREA))))))))) => (Var_CHAMBER1 = Var_CHAMBER2))))))))))))))).

fof(axGovLem57, axiom, 
 ( ! [Var_AGENT] : 
 (hasType(type_Organization, Var_AGENT) => 
(( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(((f_legislativeBranch(Var_ORG,Var_AGENT)) => (f_subOrganization(Var_ORG,Var_AGENT)))))))))).

fof(axGovLem58, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(((f_legislativeBranch(Var_ORG,Var_AREA)) => (f_subOrganization(Var_ORG,f_GovernmentFn(Var_AREA))))))))))).

fof(axGovLem59, axiom, 
 ( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_GeopoliticalArea, Var_AGENT)) => 
(( ! [Var_BRANCH] : 
 ((hasType(type_Organization, Var_BRANCH) & hasType(type_Entity, Var_BRANCH)) => 
(((f_legislativeBranch(Var_BRANCH,Var_AGENT)) => (Var_BRANCH = f_LegislatureFn(Var_AGENT)))))))))).

fof(axGovLem60, axiom, 
 ( ! [Var_ORG] : 
 (hasType(type_GovernmentOrganization, Var_ORG) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(f_judicialBranch(Var_ORG,Var_AREA)))))))).

fof(axGovLem61, axiom, 
 ( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(( ! [Var_BRANCH] : 
 (hasType(type_Organization, Var_BRANCH) => 
(((f_judicialBranch(Var_BRANCH,Var_ORG)) => (f_subOrganization(Var_BRANCH,Var_ORG)))))))))).

fof(axGovLem62, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(( ! [Var_BRANCH] : 
 (hasType(type_Organization, Var_BRANCH) => 
(((f_judicialBranch(Var_BRANCH,Var_AREA)) => (f_subOrganization(Var_BRANCH,f_GovernmentFn(Var_AREA))))))))))).

fof(axGovLem63, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(( ! [Var_BRANCH] : 
 (hasType(type_Organization, Var_BRANCH) => 
(((((f_judicialBranch(Var_BRANCH,Var_AREA)) & (f_subOrganization(Var_ORG,Var_BRANCH)))) => (f_subOrganization(Var_ORG,f_GovernmentFn(Var_AREA)))))))))))))).

fof(axGovLem64, axiom, 
 ( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_GeopoliticalArea, Var_AGENT)) => 
(( ! [Var_BRANCH] : 
 ((hasType(type_Organization, Var_BRANCH) & hasType(type_Entity, Var_BRANCH)) => 
(((f_judicialBranch(Var_BRANCH,Var_AGENT)) => (Var_BRANCH = f_JudiciaryFn(Var_AGENT)))))))))).

fof(axGovLem65, axiom, 
 ( ! [Var_COURT] : 
 (hasType(type_IslamicLawCourt, Var_COURT) => 
(f_attribute(Var_COURT,inst_IslamicLaw))))).

fof(axGovLem66, axiom, 
 ( ! [Var_PERSON] : 
 ((hasType(type_Object, Var_PERSON) & hasType(type_CognitiveAgent, Var_PERSON)) => 
(((f_attribute(Var_PERSON,inst_JudgeAtLaw)) => (( ? [Var_ORG] : 
 ((hasType(type_JudicialOrganization, Var_ORG) & hasType(type_GovernmentOrganization, Var_ORG)) &  
(f_employs(Var_ORG,Var_PERSON)))))))))).

fof(axGovLem67, axiom, 
 ( ! [Var_ORGANIZATION] : 
 (hasType(type_PoliticalParty, Var_ORGANIZATION) => 
(( ! [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) => 
(( ! [Var_PERSON] : 
 ((hasType(type_Human, Var_PERSON) & hasType(type_SelfConnectedObject, Var_PERSON)) => 
(((f_occupiesPosition(Var_PERSON,Var_POSITION,Var_ORGANIZATION)) => (f_member(Var_PERSON,Var_ORGANIZATION))))))))))))).

fof(axGovLem68, axiom, 
 ( ! [Var_ORG] : 
 ((hasType(type_Organization, Var_ORG) & hasType(type_Entity, Var_ORG)) => 
(( ! [Var_PERSON] : 
 ((hasType(type_Human, Var_PERSON) & hasType(type_Agent, Var_PERSON)) => 
(((f_occupiesPosition(Var_PERSON,inst_Leader,Var_ORG)) => (( ? [Var_LEADING] : 
 (hasType(type_Guiding, Var_LEADING) &  
(((f_patient(Var_LEADING,Var_ORG)) & (f_agent(Var_LEADING,Var_PERSON))))))))))))))).

fof(axGovLem69, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(( ! [Var_PERSON] : 
 ((hasType(type_Human, Var_PERSON) & hasType(type_Agent, Var_PERSON)) => 
(((f_occupiesPosition(Var_PERSON,inst_Leader,f_GovernmentFn(Var_AREA))) => (( ? [Var_LEADING] : 
 (hasType(type_Guiding, Var_LEADING) &  
(((f_patient(Var_LEADING,Var_AREA)) & (f_agent(Var_LEADING,Var_PERSON))))))))))))))).

fof(axGovLem70, axiom, 
 ( ! [Var_GROUP] : 
 (hasType(type_PoliticalPressureGroup, Var_GROUP) => 
(( ? [Var_REQ] : 
 (hasType(type_Requesting, Var_REQ) &  
(( ? [Var_ORG] : 
 (hasType(type_GovernmentOrganization, Var_ORG) &  
(((f_agent(Var_REQ,Var_GROUP)) & (f_patient(Var_REQ,Var_ORG))))))))))))).

fof(axGovLem71, axiom, 
 ( ! [Var_GROUP] : 
 (hasType(type_PoliticalPressureGroup, Var_GROUP) => 
(( ! [Var_ORG] : 
 (hasType(type_GovernmentOrganization, Var_ORG) => 
(( ! [Var_AIM] : 
 (hasType(type_AreaOfConcern, Var_AIM) => 
(((((f_organizationalObjective(Var_GROUP,Var_AIM)) & (f_organizationalObjective(Var_ORG,Var_AIM)))) => (f_inScopeOfInterest(Var_GROUP,Var_ORG))))))))))))).

fof(axGovLem72, axiom, 
 ( ! [Var_X] : 
 (hasType(type_ForeignTerroristOrganization, Var_X) => 
(( ? [Var_EV] : 
 (hasType(type_Declaring, Var_EV) &  
(((f_agent(Var_EV,inst_USStateDepartment)) & (f_patient(Var_EV,Var_X)))))))))).

fof(axGovLem73, axiom, 
 ( ! [Var_GROUP] : 
 (hasType(type_Group, Var_GROUP) => 
(( ! [Var_STATUS] : 
 (hasType(type_RelationalAttribute, Var_STATUS) => 
(( ! [Var_AGENT] : 
 (hasType(type_Agent, Var_AGENT) => 
(((f_associateWithStatus(Var_AGENT,Var_STATUS,Var_GROUP)) => (f_associateInOrganization(Var_AGENT,Var_GROUP))))))))))))).

fof(axGovLem74, axiom, 
 ( ! [Var_GROUP] : 
 ((hasType(type_Group, Var_GROUP) & hasType(type_Collection, Var_GROUP)) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_SelfConnectedObject, Var_AGENT)) => 
(((f_associateWithStatus(Var_AGENT,inst_FullMember,Var_GROUP)) => (f_member(Var_AGENT,Var_GROUP)))))))))).

fof(axGovLem75, axiom, 
 ( ! [Var_GROUP] : 
 ((hasType(type_Group, Var_GROUP) & hasType(type_Collection, Var_GROUP)) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_SelfConnectedObject, Var_AGENT)) => 
(((f_associateWithStatus(Var_AGENT,inst_SuspendedMember,Var_GROUP)) => (( ~ (f_member(Var_AGENT,Var_GROUP)))))))))))).

fof(axGovLem76, axiom, 
 ( ! [Var_ORG] : 
 (hasType(type_InternationalOrganization, Var_ORG) => 
(( ? [Var_COUNTRY1] : 
 (hasType(type_Nation, Var_COUNTRY1) &  
(( ? [Var_COUNTRY2] : 
 (hasType(type_Nation, Var_COUNTRY2) &  
(((f_agentOperatesInArea(Var_ORG,Var_COUNTRY1)) & (((f_agentOperatesInArea(Var_ORG,Var_COUNTRY2)) & (Var_COUNTRY1 != Var_COUNTRY2)))))))))))))).

fof(axGovLem77, axiom, 
 ( ! [Var_ORG2] : 
 ((hasType(type_Organization, Var_ORG2) & hasType(type_Physical, Var_ORG2)) => 
(( ! [Var_ORG1] : 
 ((hasType(type_Organization, Var_ORG1) & hasType(type_Physical, Var_ORG1)) => 
(((f_successorOrganization(Var_ORG1,Var_ORG2)) => (f_earlier(f_WhenFn(Var_ORG1),f_WhenFn(Var_ORG2))))))))))).

fof(axGovLem78, axiom, 
 ( ! [Var_OVERAIM] : 
 ((hasType(type_Attribute, Var_OVERAIM) & hasType(type_AreaOfConcern, Var_OVERAIM)) => 
(( ! [Var_AIM] : 
 ((hasType(type_AreaOfConcern, Var_AIM) & hasType(type_Attribute, Var_AIM)) => 
(( ! [Var_ORG] : 
 (hasType(type_Agent, Var_ORG) => 
(((((f_organizationalObjective(Var_ORG,Var_AIM)) & (f_subAttribute(Var_AIM,Var_OVERAIM)))) => (f_organizationalObjective(Var_ORG,Var_OVERAIM))))))))))))).

fof(axGovLem79, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_Nation, Var_AREA) => 
(((f_member(Var_AREA,inst_EuropeanMonetaryUnion)) => (f_currencyType(Var_AREA,inst_EuroDollar))))))).

fof(axGovLem80, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_Nation, Var_AREA) => 
(((f_currencyType(Var_AREA,inst_EuroDollar)) => (f_member(Var_AREA,inst_EuropeanMonetaryUnion))))))).

fof(axGovLem81, axiom, 
 ( ! [Var_AGENT] : 
 ((hasType(type_SelfConnectedObject, Var_AGENT) & hasType(type_Object, Var_AGENT) & hasType(type_Agent, Var_AGENT)) => 
(((((f_member(Var_AGENT,inst_InternationalCourtOfJustice)) & (f_attribute(Var_AGENT,inst_JudgeAtLaw)))) => (( ? [Var_POLITY] : 
 (hasType(type_GeopoliticalArea, Var_POLITY) &  
(f_representativeAgentToAgent(Var_POLITY,Var_AGENT,inst_InternationalCourtOfJustice)))))))))).

fof(axGovLem82, axiom, 
 ( ! [Var_PART] : 
 (hasType(type_SelfConnectedObject, Var_PART) => 
(((f_member(Var_PART,inst_InternationalRedCrossAndRedCrescentMovement)) <=> (f_member(Var_PART,inst_InternationalFederationOfRedCrossAndRedCrescentSocieties))))))).

fof(axGovLem83, axiom, 
 ( ! [Var_ROLE] : 
 (hasType(type_ForeignServicePosition, Var_ROLE) => 
(f_subAttribute(Var_ROLE,inst_DiplomaticAgent))))).

fof(axGovLem84, axiom, 
 ( ! [Var_AGENT1] : 
 (hasType(type_Nation, Var_AGENT1) => 
(( ! [Var_AGENT2] : 
 (hasType(type_Agent, Var_AGENT2) => 
(( ! [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) => 
(( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(((f_diplomaticRepresentativeInRole(Var_AGENT1,Var_PERSON,Var_POSITION,Var_AGENT2)) => (( ? [Var_ORG] : 
 (hasType(type_DiplomaticOrganization, Var_ORG) &  
(((f_subOrganization(Var_ORG,f_GovernmentFn(Var_AGENT1))) & (f_occupiesPosition(Var_PERSON,Var_POSITION,Var_ORG))))))))))))))))))))).

fof(axGovLem85, axiom, 
 ( ! [Var_AGENT1] : 
 (hasType(type_Organization, Var_AGENT1) => 
(( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(( ! [Var_AGENT2] : 
 (hasType(type_Agent, Var_AGENT2) => 
(( ! [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) => 
(( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(((f_diplomaticRepresentativeInRole(Var_AGENT1,Var_PERSON,Var_POSITION,Var_AGENT2)) => (f_occupiesPosition(Var_PERSON,Var_POSITION,Var_ORG))))))))))))))))))).

fof(axGovLem86, axiom, 
 ( ! [Var_AGENT1] : 
 (hasType(type_GeopoliticalArea, Var_AGENT1) => 
(( ! [Var_AGENT2] : 
 (hasType(type_Agent, Var_AGENT2) => 
(( ! [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) => 
(( ! [Var_PERSON] : 
 ((hasType(type_Human, Var_PERSON) & hasType(type_CognitiveAgent, Var_PERSON)) => 
(((f_diplomaticRepresentativeInRole(Var_AGENT1,Var_PERSON,Var_POSITION,Var_AGENT2)) => (f_employs(f_GovernmentFn(Var_AGENT1),Var_PERSON)))))))))))))))).

fof(axGovLem87, axiom, 
 ( ! [Var_AGENT1] : 
 (hasType(type_Organization, Var_AGENT1) => 
(( ! [Var_AGENT2] : 
 (hasType(type_Agent, Var_AGENT2) => 
(( ! [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) => 
(( ! [Var_PERSON] : 
 ((hasType(type_Human, Var_PERSON) & hasType(type_CognitiveAgent, Var_PERSON)) => 
(((f_diplomaticRepresentativeInRole(Var_AGENT1,Var_PERSON,Var_POSITION,Var_AGENT2)) => (f_employs(Var_AGENT1,Var_PERSON)))))))))))))))).

fof(axGovLem88, axiom, 
 ( ! [Var_AGENT2] : 
 (hasType(type_GeopoliticalArea, Var_AGENT2) => 
(( ! [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) => 
(( ! [Var_PERSON] : 
 ((hasType(type_Human, Var_PERSON) & hasType(type_Agent, Var_PERSON)) => 
(( ! [Var_AGENT1] : 
 (hasType(type_Agent, Var_AGENT1) => 
(((f_diplomaticRepresentativeInRole(Var_AGENT1,Var_PERSON,Var_POSITION,Var_AGENT2)) => (f_agentOperatesInArea(Var_PERSON,Var_AGENT2)))))))))))))))).

fof(axGovLem89, axiom, 
 ( ! [Var_AGENT1] : 
 (hasType(type_Organization, Var_AGENT1) => 
(( ! [Var_AGENT2] : 
 (hasType(type_GeopoliticalArea, Var_AGENT2) => 
(( ! [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) => 
(( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(((f_diplomaticRepresentativeInRole(Var_AGENT1,Var_PERSON,Var_POSITION,Var_AGENT2)) => (f_agentOperatesInArea(Var_AGENT1,Var_AGENT2)))))))))))))))).

fof(axGovLem90, axiom, 
 ( ! [Var_AGENT1] : 
 (hasType(type_Nation, Var_AGENT1) => 
(( ! [Var_AGENT2] : 
 (hasType(type_GeopoliticalArea, Var_AGENT2) => 
(( ! [Var_ORG] : 
 (hasType(type_DiplomaticOrganization, Var_ORG) => 
(( ! [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) => 
(( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(((((f_diplomaticRepresentativeInRole(Var_AGENT1,Var_PERSON,Var_POSITION,Var_AGENT2)) & (((f_subOrganization(Var_ORG,f_GovernmentFn(Var_AGENT1))) & (f_occupiesPosition(Var_PERSON,Var_POSITION,Var_ORG)))))) => (f_agentOperatesInArea(Var_ORG,Var_AGENT2))))))))))))))))))).

fof(axGovLem91, axiom, 
 ( ! [Var_AGENT2] : 
 (hasType(type_Agent, Var_AGENT2) => 
(( ! [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) => 
(( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(( ! [Var_AGENT1] : 
 (hasType(type_Agent, Var_AGENT1) => 
(((f_diplomaticRepresentativeInRole(Var_AGENT1,Var_PERSON,Var_POSITION,Var_AGENT2)) => (f_diplomaticRepresentationType(Var_AGENT1,Var_POSITION,Var_AGENT2)))))))))))))))).

fof(axGovLem92, axiom, 
 ( ! [Var_AGENT3] : 
 (hasType(type_Nation, Var_AGENT3) => 
(( ! [Var_AGENT2] : 
 ((hasType(type_Agent, Var_AGENT2) & hasType(type_GeopoliticalArea, Var_AGENT2)) => 
(( ! [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) => 
(( ! [Var_AGENT1] : 
 (hasType(type_Agent, Var_AGENT1) => 
(((((f_diplomaticRepresentationType(Var_AGENT1,Var_POSITION,Var_AGENT2)) & (f_geopoliticalSubdivision(Var_AGENT2,Var_AGENT3)))) => (f_diplomaticRepresentationType(Var_AGENT1,Var_POSITION,Var_AGENT3)))))))))))))))).

fof(axGovLem93, axiom, 
 ( ! [Var_COUNTRY2] : 
 ((hasType(type_Agent, Var_COUNTRY2) & hasType(type_GeopoliticalArea, Var_COUNTRY2)) => 
(( ! [Var_ROLE] : 
 (hasType(type_Position, Var_ROLE) => 
(( ! [Var_COUNTRY1] : 
 ((hasType(type_Agent, Var_COUNTRY1) & hasType(type_GeopoliticalArea, Var_COUNTRY1)) => 
(((f_diplomaticRepresentationType(Var_COUNTRY1,Var_ROLE,Var_COUNTRY2)) => (f_diplomaticRelations(Var_COUNTRY1,Var_COUNTRY2))))))))))))).

fof(axGovLem94, axiom, 
 ( ! [Var_COUNTRY2] : 
 ((hasType(type_GeopoliticalArea, Var_COUNTRY2) & hasType(type_Agent, Var_COUNTRY2)) => 
(( ! [Var_COUNTRY1] : 
 ((hasType(type_GeopoliticalArea, Var_COUNTRY1) & hasType(type_Agent, Var_COUNTRY1)) => 
(((f_diplomaticRelations(Var_COUNTRY1,Var_COUNTRY2)) => (( ? [Var_ROLE] : 
 (hasType(type_ForeignServicePosition, Var_ROLE) &  
(((f_subAttribute(Var_ROLE,inst_DiplomaticAgent)) & (f_diplomaticRepresentationType(Var_COUNTRY1,Var_ROLE,Var_COUNTRY2))))))))))))))).

fof(axGovLem95, axiom, 
 ( ! [Var_COUNTRY2] : 
 ((hasType(type_GeopoliticalArea, Var_COUNTRY2) & hasType(type_Agent, Var_COUNTRY2)) => 
(( ! [Var_COUNTRY1] : 
 ((hasType(type_GeopoliticalArea, Var_COUNTRY1) & hasType(type_Agent, Var_COUNTRY1)) => 
(((f_diplomaticRelations(Var_COUNTRY1,Var_COUNTRY2)) => (( ? [Var_ROLE] : 
 (hasType(type_ForeignServicePosition, Var_ROLE) &  
(((f_subAttribute(Var_ROLE,inst_DiplomaticAgent)) & (f_diplomaticRepresentationType(Var_COUNTRY2,Var_ROLE,Var_COUNTRY1))))))))))))))).

fof(axGovLem96, axiom, 
 ( ! [Var_COUNTRY2] : 
 ((hasType(type_GeopoliticalArea, Var_COUNTRY2) & hasType(type_Agent, Var_COUNTRY2)) => 
(( ! [Var_COUNTRY1] : 
 ((hasType(type_GeopoliticalArea, Var_COUNTRY1) & hasType(type_Agent, Var_COUNTRY1)) => 
(((f_diplomaticRelations(Var_COUNTRY1,Var_COUNTRY2)) => (( ? [Var_ROLE1] : 
 (hasType(type_Position, Var_ROLE1) &  
(( ? [Var_ROLE2] : 
 (hasType(type_Position, Var_ROLE2) &  
(((f_diplomaticRepresentationType(Var_COUNTRY1,Var_ROLE1,Var_COUNTRY2)) & (f_diplomaticRepresentationType(Var_COUNTRY2,Var_ROLE2,Var_COUNTRY1)))))))))))))))))).

fof(axGovLem97, axiom, 
 ( ! [Var_COUNTRY2] : 
 (hasType(type_Agent, Var_COUNTRY2) => 
(( ! [Var_ROLE] : 
 ((hasType(type_Position, Var_ROLE) & hasType(type_Attribute, Var_ROLE)) => 
(( ! [Var_COUNTRY1] : 
 ((hasType(type_Agent, Var_COUNTRY1) & hasType(type_Nation, Var_COUNTRY1)) => 
(((((f_diplomaticRepresentationType(Var_COUNTRY1,Var_ROLE,Var_COUNTRY2)) & (f_subAttribute(Var_ROLE,inst_DiplomaticAgent)))) => (( ? [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) &  
(((f_citizen(Var_PERSON,Var_COUNTRY1)) & (f_diplomaticRepresentativeInRole(Var_COUNTRY1,Var_PERSON,Var_ROLE,Var_COUNTRY2)))))))))))))))))).

fof(axGovLem98, axiom, 
 ( ! [Var_COUNTRY2] : 
 (hasType(type_Agent, Var_COUNTRY2) => 
(( ! [Var_ROLE] : 
 (hasType(type_Position, Var_ROLE) => 
(( ! [Var_PERSON] : 
 ((hasType(type_Human, Var_PERSON) & hasType(type_Agent, Var_PERSON)) => 
(( ! [Var_COUNTRY1] : 
 (hasType(type_Agent, Var_COUNTRY1) => 
(((f_diplomaticRepresentativeInRole(Var_COUNTRY1,Var_PERSON,Var_ROLE,Var_COUNTRY2)) => (f_representativeAgentToAgent(Var_COUNTRY1,Var_PERSON,Var_COUNTRY2)))))))))))))))).

fof(axGovLem99, axiom, 
 ( ! [Var_SENDER] : 
 (hasType(type_Organization, Var_SENDER) => 
(( ! [Var_REP] : 
 (hasType(type_CognitiveAgent, Var_REP) => 
(( ! [Var_RECEIVER] : 
 (hasType(type_Agent, Var_RECEIVER) => 
(((f_representativeAgentToAgent(Var_SENDER,Var_REP,Var_RECEIVER)) => (f_employs(Var_SENDER,Var_REP))))))))))))).

fof(axGovLem100, axiom, 
 ( ! [Var_SENDER] : 
 (hasType(type_Nation, Var_SENDER) => 
(( ! [Var_REP] : 
 (hasType(type_CognitiveAgent, Var_REP) => 
(( ! [Var_RECEIVER] : 
 (hasType(type_Agent, Var_RECEIVER) => 
(((f_representativeAgentToAgent(Var_SENDER,Var_REP,Var_RECEIVER)) => (f_employs(f_GovernmentFn(Var_SENDER),Var_REP))))))))))))).

fof(axGovLem101, axiom, 
 ( ! [Var_SENDER] : 
 (hasType(type_Nation, Var_SENDER) => 
(( ! [Var_RECEIVER] : 
 (hasType(type_Nation, Var_RECEIVER) => 
(( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(( ! [Var_ROLE] : 
 ((hasType(type_Attribute, Var_ROLE) & hasType(type_Position, Var_ROLE)) => 
(((((f_attribute(Var_PERSON,Var_ROLE)) & (((f_subAttribute(Var_ROLE,inst_DiplomaticAgent)) & (f_representativeAgentToAgent(Var_SENDER,Var_PERSON,Var_RECEIVER)))))) => (f_diplomaticRepresentationType(Var_SENDER,Var_ROLE,Var_RECEIVER)))))))))))))))).

fof(axGovLem102, axiom, 
 ( ! [Var_AGENT2] : 
 (hasType(type_Agent, Var_AGENT2) => 
(( ! [Var_AGENT1] : 
 (hasType(type_Agent, Var_AGENT1) => 
(((f_diplomaticOrganizationType(Var_AGENT1,type_ConsulateGeneral,Var_AGENT2)) => (f_diplomaticRepresentationType(Var_AGENT1,inst_ConsulGeneral,Var_AGENT2)))))))))).

fof(axGovLem103, axiom, 
 ( ! [Var_AREA2] : 
 (hasType(type_City, Var_AREA2) => 
(( ! [Var_AGENT2] : 
 (hasType(type_Agent, Var_AGENT2) => 
(( ! [Var_AGENT1] : 
 (hasType(type_Agent, Var_AGENT1) => 
(((f_diplomaticRepresentationType(Var_AGENT1,inst_ConsulGeneral,Var_AGENT2)) => (f_diplomaticOrganizationType(Var_AGENT1,type_ConsulateGeneral,Var_AGENT2))))))))))))).

fof(axGovLem104, axiom, 
 ( ! [Var_AGENT2] : 
 (hasType(type_Agent, Var_AGENT2) => 
(( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(( ! [Var_AGENT1] : 
 (hasType(type_Agent, Var_AGENT1) => 
(((f_diplomaticRepresentativeInRole(Var_AGENT1,Var_PERSON,inst_Ambassador,Var_AGENT2)) => (f_diplomaticOrganizationType(Var_AGENT1,type_Embassy,Var_AGENT2))))))))))))).

fof(axGovLem105, axiom, 
 ( ! [Var_AGENT2] : 
 (hasType(type_Agent, Var_AGENT2) => 
(( ! [Var_AGENT1] : 
 (hasType(type_Agent, Var_AGENT1) => 
(((f_diplomaticRepresentationType(Var_AGENT1,inst_Ambassador,Var_AGENT2)) => (f_diplomaticOrganizationType(Var_AGENT1,type_Embassy,Var_AGENT2)))))))))).

fof(axGovLem106, axiom, 
 ( ! [Var_AGENT2] : 
 (hasType(type_Agent, Var_AGENT2) => 
(( ! [Var_AGENT1] : 
 (hasType(type_Agent, Var_AGENT1) => 
(((f_diplomaticOrganizationType(Var_AGENT1,type_Embassy,Var_AGENT2)) => (f_diplomaticRepresentationType(Var_AGENT1,inst_Ambassador,Var_AGENT2)))))))))).

