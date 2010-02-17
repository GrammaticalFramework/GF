abstract Government = open Merge, Mid_level_ontology, Geography in {




fun ASEANRegionalForum : Ind OrganizationOfNations ;

fun AbsoluteMonarchy : Ind FormOfGovernment ;

-- AcceptsICJJurisdiction is the 
-- Attribute of a legal system that accepts rulings of the 
-- InternationalCourtOfJustice.
fun AcceptsICJJurisdiction : Ind LegalSystemAttribute ;


fun ActingConsulGeneral : Ind ForeignServicePosition ;

fun AdministrationAndManagement : Ind AreaOfConcern ;

fun AdvisoryCommittee : Ind MemberStatus ;

fun AfricanCaribbeanAndPacificGroupOfStates : Ind OrganizationOfNations ;

fun AfricanDevelopmentBank : Ind OrganizationOfNations ;

fun AgencyForTheFrenchSpeakingCommunity : Ind OrganizationOfNations ;

fun AgencyForTheProhibitionOfNuclearWeaponsInLatinAmericaAndTheCaribbean : Ind OrganizationOfNations ;

fun AgriculturalDevelopment : Ind AreaOfConcern ;

-- Ambassador is the Attribute of the most 
-- highly_ranked foreign service representatives from the government of one 
-- country to another.
fun Ambassador : Ind ForeignServicePosition ;


-- The AmericanInstituteInTaiwan 
-- is a private, nonprofit corporation under United States government 
-- oversight that conducts relations with Taiwan.
fun AmericanInstituteInTaiwan : Ind Organization ;


fun Anarchy : Ind FormOfGovernment ;

fun AndeanCommunityOfNations : Ind OrganizationOfNations ;

fun AntarcticTreatyCouncil : Ind OrganizationOfNations ;

-- Antiterrorism and Effective 
--  Death Penalty Act modifies the Immigration and Nationality Act
--  was enacted in 1996 and specifies that: 
--  (1) It is unlawful to provide funds or other material support to a 
--  designated FTO. 
--  (2) Representatives and certain members of a designated FTO can be denied 
--  visas or excluded from the United States. 
--  (3) US financial institutions must block funds of designated FTOs and their 
--  agents and must report the blockage to the US Department of the Treasury.
fun AntiterrorismAndEffectiveDeathPenaltyAct : Ind Proposition ;


-- AppealsCourt is the class of 
-- JudicialOrganizations that review cases from lower courts on appeal.
fun AppealsCourt : Class ;
fun AppealsCourt_Class : SubClass AppealsCourt JudicialOrganization ;

fun ArabBankForEconomicDevelopmentInAfrica : Ind OrganizationOfNations ;

fun ArabCooperationCouncil : Ind OrganizationOfNations ;

fun ArabFundForEconomicAndSocialDevelopment : Ind OrganizationOfNations ;

fun ArabLeague : Ind OrganizationOfNations ;

fun ArabMaghrebUnion : Ind OrganizationOfNations ;

fun ArabMonetaryFund : Ind OrganizationOfNations ;

fun ArmsControl : Ind TransnationalIssue ;

fun AsiaPacificEconomicCooperation : Ind OrganizationOfNations ;

fun AsianDevelopmentBank : Ind OrganizationOfNations ;

fun AssociateMember : Ind MemberStatus ;

fun AssociatePartner : Ind MemberStatus ;

fun AssociationOfSoutheastAsianNations : Ind OrganizationOfNations ;

fun AustraliaGroup : Ind OrganizationOfNations ;

fun AustraliaNewZealandUnitedStatesSecurityTreaty : Ind OrganizationOfNations ;

-- AuthoritarianRegime is the 
-- attribute of a government that rules autocratically, not allowing 
-- opposition.
fun AuthoritarianRegime : Ind FormOfGovernment ;


fun AuthoritarianSocialist : Ind FormOfGovernment ;

fun BankForInternationalSettlements : Ind OrganizationOfNations ;

fun BeneluxEconomicUnion : Ind OrganizationOfNations ;

-- BicameralLegislature is the 
-- Attribute of governments whose legislative branches have two
-- legislative chambers. For example, in the UnitedStates the legislative 
-- branch comprises the Senate and the House of Representatives.
fun BicameralLegislature : Ind FormOfGovernment ;


fun BigSeven : Ind OrganizationOfNations ;

fun BigSix : Ind OrganizationOfNations ;

fun BlackSeaEconomicCooperationZone : Ind OrganizationOfNations ;

fun BoardOfTrusteesMember : Ind MemberStatus ;

fun BoundaryDetermination : Ind TransnationalIssue ;

fun BritishCrownColony : Class ;
fun BritishCrownColony_Class : SubClass BritishCrownColony OverseasArea ;
fun CBWExportControls : Ind TransnationalIssue ;

-- (CabinetFn ?AREA) denotes the 
-- GovernmentCabinet associated with the government of the 
-- GeopoliticalArea ?AREA.
fun CabinetFn : El GeopoliticalArea -> Ind GovernmentOrganization ;


fun CaribbeanCommunityAndCommonMarket : Ind OrganizationOfNations ;

fun CaribbeanDevelopmentBank : Ind OrganizationOfNations ;

fun CategoryIIIMember : Ind MemberStatus ;

fun CategoryIIMember : Ind MemberStatus ;

fun CategoryIMember : Ind MemberStatus ;

fun CentralAfricanStatesDevelopmentBank : Ind OrganizationOfNations ;

fun CentralAmericanBankForEconomicIntegration : Ind OrganizationOfNations ;

fun CentralAmericanCommonMarket : Ind OrganizationOfNations ;

fun CentralEuropeanInitiative : Ind OrganizationOfNations ;

fun Chairman : Ind Position ;

-- ChargeDAffaires is the Attribute of 
-- foreign servicer officers representing their governments abroad as 
-- Charges d'Affaires.
fun ChargeDAffaires : Ind ForeignServicePosition ;


fun Chiefdom : Ind FormOfGovernment ;

fun ChildHealthServices : Ind AreaOfConcern ;

-- CivilLaw is the attribute of legal systems 
-- based ultimately on the code of civil law developed in Ancient Rome. 
-- Civil law systems are characterized by their expression of laws in written 
-- code and statute and by their effort to use general principles to define 
-- and rationalize the laws.
fun CivilLaw : Ind LegalSystemAttribute ;


fun CivilPoliceTraining : Ind AreaOfConcern ;

fun ColomboPlan : Ind OrganizationOfNations ;

fun CommissionForSocialDevelopment : Ind InternationalOrganization ;

fun CommissionOnCrimePreventionAndCriminalJustice : Ind InternationalOrganization ;

fun CommissionOnHumanRights : Ind InternationalOrganization ;

fun CommissionOnNarcoticsDrugs : Ind InternationalOrganization ;

fun CommissionOnPopulationAndDevelopment : Ind InternationalOrganization ;

fun CommissionOnScienceAndTechnologyForDevelopment : Ind InternationalOrganization ;

fun CommissionOnSustainableDevelopment : Ind InternationalOrganization ;

fun CommissionOnTheStatusOfWomen : Ind InternationalOrganization ;

fun Commissioner : Ind MemberStatus ;

fun Commonwealth : Ind FormOfGovernment ;

fun CommonwealthOfIndependentStates : Ind OrganizationOfNations ;

fun CommonwealthOfNations : Ind OrganizationOfNations ;

fun CommunicationsCoordination : Ind AreaOfConcern ;

fun CommunistState : Ind FormOfGovernment ;

fun CompactOfFreeAssociationWithNewZealand : Ind FormOfGovernment ;

fun CompactOfFreeAssociationWithUnitedStates : Ind FormOfGovernment ;

fun CompensationAndReparation : Ind AreaOfConcern ;

-- CompulsorySuffrageLaw is a law that 
-- requires all eligible voters in a country to vote, under threat of some 
-- penalty.
fun CompulsorySuffrageLaw : Ind SuffrageLaw ;


-- The class Constitution includes the bodies of
-- abstract principles formulated to guide the laws, institutions and practices 
-- of various Governments. Also see ConstitutionDocument.
fun Constitution : Class ;
fun Constitution_Class : SubClass Constitution Proposition ;

-- ConstitutionDocument is the class 
-- of information_containing objects in which the Constitution of a 
-- government is encoded.
fun ConstitutionDocument : Class ;
fun ConstitutionDocument_Class : SubClass ConstitutionDocument ContentBearingObject ;

-- (ConstitutionFn ?AREA) denotes a class 
-- containing all Constitutions adopted by the government of the 
-- GeopoliticalArea ?AREA. For example, (ConstitutionFn UnitedStates) 
-- contains the ConstitutionOfTheUnitedStates.
fun ConstitutionFn: El GeopoliticalArea -> Desc Constitution ;


-- ConstitutionalCourt is the class of 
-- JudicialOrganizations that rule on constitutional matters, in countries 
-- that have a Constitution.
fun ConstitutionalCourt : Class ;
fun ConstitutionalCourt_Class : SubClass ConstitutionalCourt JudicialOrganization ;

fun ConstitutionalDemocracy : Ind FormOfGovernment ;

fun ConstitutionalDemocraticRepublic : Ind FormOfGovernment ;

-- ConstitutionalGovernment is 
-- the attribute of a government whose authority and rule are guided by 
-- principles expressed in a written Constitution.
fun ConstitutionalGovernment : Ind FormOfGovernment ;


fun ConstitutionalMonarchy : Ind FormOfGovernment ;

fun ConstitutionalParliamentaryDemocracy : Ind FormOfGovernment ;

fun ConstitutionalRepublic : Ind FormOfGovernment ;

-- Consul is the Attribute of foreign service 
-- officers representing their governments abroad as Consuls.
fun Consul : Ind ForeignServicePosition ;


-- ConsulGeneral is the Attribute of 
-- foreign service officers representing their governments abroad as 
-- Consuls General.
fun ConsulGeneral : Ind ForeignServicePosition ;


-- Consulate is a class of government 
-- organizations that represent one nation within the territory of a second 
-- nation. Consulates offer services for citizens of their own country 
-- abroad, as well as for citizens of the host country who have dealings 
-- with the country represented by the consulate general. See also 
-- ConsulateGeneral.
fun Consulate : Class ;
fun Consulate_Class : SubClass Consulate DiplomaticOrganization ;

-- ConsulateGeneral is a class of 
-- government organizations that represent one nation within the territory of 
-- a second nation. Consulates General offer a wider variety of services 
-- than do Consulates.
fun ConsulateGeneral : Class ;
fun ConsulateGeneral_Class : SubClass ConsulateGeneral DiplomaticOrganization ;

fun ControlBiologicalAndChemicalWeapons : Ind TransnationalIssue ;

fun ControlNuclearWeapons : Ind TransnationalIssue ;

fun ControlWeaponsOfMassDestruction : Ind TransnationalIssue ;

fun ConventionalArmsControl : Ind TransnationalIssue ;

fun CooperatingState : Ind MemberStatus ;

fun CooperationInCivilAviation : Ind AreaOfConcern ;

fun CoordinateCreditPolicy : Ind TransnationalIssue ;

-- The 
-- CoordinatingCommitteeOnExportControls was abolished as of March 31, 
-- 1994, and its members formed the WassenaarArrangement on July 12, 1996, 
-- with expanded membership and a post_Cold War aim of voluntary export 
-- controls on conventional arms and dual_use goods and technologies.
fun CoordinatingCommitteeOnExportControls : Ind OrganizationOfNations ;


fun Coprincipality : Ind FormOfGovernment ;

fun CorrespondentMember : Ind MemberStatus ;

fun CouncilForMutualEconomicAssistance : Ind OrganizationOfNations ;

-- The 
-- CouncilOfArabEconomicUnity was established in 1957 but did not become 
-- effective until May 30, 1964.
fun CouncilOfArabEconomicUnity : Ind OrganizationOfNations ;


fun CouncilOfEurope : Ind OrganizationOfNations ;

fun CouncilOfTheBalticSeaStates : Ind OrganizationOfNations ;

fun CouncilOfTheEntente : Ind OrganizationOfNations ;

fun CrimePrevention : Ind AreaOfConcern ;

fun CulturalCooperation : Ind TransnationalIssue ;

-- Democracy is the attribute of a government 
-- whose authority and rule are based in the will of the people governed. 
-- The will of the people is usually expressed through Elections, direct or 
-- indirect.
fun Democracy : Ind FormOfGovernment ;


-- The US Government
-- organization founded in 2002 to consolidate and organize
-- national_level preparations to thwart security threats, primarily
-- terrorist attacks, against the United States of America.
fun DepartmentOfHomelandSecurity : Ind GovernmentOrganization ;


-- DependencyOrSpecialSovereigntyArea is a subclass of 
-- GeopoliticalArea, representing the classification 'Dependency or Special 
-- Sovereignty Area' used by the CIA World Fact Book. Cf. 
-- IndependentState.
fun DependencyOrSpecialSovereigntyArea : Class ;
fun DependencyOrSpecialSovereigntyArea_Class : SubClass DependencyOrSpecialSovereigntyArea GeopoliticalArea ;

fun DialoguePartner : Ind MemberStatus ;

fun Dictatorship : Ind FormOfGovernment ;

-- DiplomaticAgent is a generic Attribute 
-- of persons charged to represent one national government to another nation 
-- or international organization. This includes any Ambassador or head of 
-- a diplomatic mission. Individuals with this attribute may also hold a 
-- career diplomatic position (see ForeignServicePosition).
fun DiplomaticAgent : Ind ForeignServicePosition ;


-- DiplomaticOrganization is the 
-- general class of government organizations that represent one nation in 
-- official government business with other nations.
fun DiplomaticOrganization : Class ;
fun DiplomaticOrganization_Class : SubClass DiplomaticOrganization GovernmentOrganization ;

fun EastAfricanDevelopmentBank : Ind OrganizationOfNations ;

fun EcclesiasticalGovernment : Ind FormOfGovernment ;

fun EconomicAndSocialCommissionForAsiaAndThePacific : Ind InternationalOrganization ;

fun EconomicAndSocialCommissionForWesternAsia : Ind InternationalOrganization ;

-- The EconomicAndSocialCouncil is 
-- the coordinating organization for the social and economic work of the 
-- UnitedNations. It comprises five regional commissions and nine 
-- functional commissions.
fun EconomicAndSocialCouncil : Ind OrganizationOfNations ;


fun EconomicCommissionForAfrica : Ind InternationalOrganization ;

fun EconomicCommissionForEurope : Ind InternationalOrganization ;

fun EconomicCommissionForLatinAmericaAndTheCaribbean : Ind InternationalOrganization ;

fun EconomicCommunityOfTheGreatLakesCountries : Ind OrganizationOfNations ;

fun EconomicCommunityOfWestAfricanStates : Ind OrganizationOfNations ;

fun EconomicCooperation : Ind TransnationalIssue ;

fun EconomicCooperationOrganization : Ind OrganizationOfNations ;

fun EconomicDevelopment : Ind AreaOfConcern ;

fun EconomicIntegration : Ind TransnationalIssue ;

fun EconomicPolicyCoordination : Ind TransnationalIssue ;

fun EducationalCooperation : Ind (both TransnationalIssue AreaOfConcern) ;

fun EfficientCustomsAdministration : Ind (both TransnationalIssue AreaOfConcern ) ;

-- (ElectionFn ?ORG) denotes the class of 
-- Elections conducted by the GeopoliticalArea or Organization ?ORG, 
-- in which offices or issues pertaining to ?ORG are voted upon.
fun ElectionFn: El Agent -> Desc Election ;


fun EliminateChemicalWeapons : Ind TransnationalIssue ;

-- Embassy is the class of top_ranked 
-- GovernmentOrganizations that represent one nation within the boundaries 
-- of another. Not all nations have embassy_level representation from other 
-- nations.
fun Embassy : Class ;
fun Embassy_Class : SubClass Embassy DiplomaticOrganization ;

fun EmergingDemocracy : Ind FormOfGovernment ;

fun EmigrationAndImmigrationIssues : Ind (both TransnationalIssue AreaOfConcern) ;

fun EnergyAndTheEnvironment : Ind TransnationalIssue ;

fun EnergyCooperation : Ind (both TransnationalIssue AreaOfConcern) ; 

-- EnglishCommonLaw is the attribute of 
-- legal systems based on the common law developed in England and influential 
-- in its English_speaking colonies. Common law is characterized by laws and 
-- rulings based on precedent and custom, rather than on written statute.
fun EnglishCommonLaw : Ind LegalSystemAttribute ;


fun EnvironmentalCooperation : Ind TransnationalIssue ;

fun EuroAtlanticPartnershipCouncil : Ind OrganizationOfNations ;

fun EuropeanBankForReconstructionAndDevelopment : Ind OrganizationOfNations ;

-- The EuropeanCommunity was merged into 
-- the EuropeanUnion on February 7, 1992.
fun EuropeanCommunity : Ind OrganizationOfNations ;


fun EuropeanFreeTradeAssociation : Ind OrganizationOfNations ;

fun EuropeanInvestmentBank : Ind OrganizationOfNations ;

fun EuropeanMonetaryUnion : Ind OrganizationOfNations ;

fun EuropeanOrganizationForNuclearResearch : Ind OrganizationOfNations ;

fun EuropeanSpaceAgency : Ind OrganizationOfNations ;

fun EuropeanUnion : Ind OrganizationOfNations ;

fun ExclusiveMaleSuffrage : Ind RestrictedSuffrage ;

fun ExecutiveBoardMember : Ind MemberStatus ;

-- (ExecutiveBranchFn ?ORG) denotes the 
-- executive branch of ?ORG, with all its officials and agencies, considered 
-- as a whole.
fun ExecutiveBranchFn : El Agent -> Ind Organization ;


fun ExecutiveCommitteeMember : Ind MemberStatus ;

fun Factionalism : Ind FormOfGovernment ;

fun FederalDemocraticRepublic : Ind FormOfGovernment ;

-- FederalGovernment is the attribute of 
-- a government that is formed by agreement between a collection of political 
-- units that agree to give up some of their power to the central government, 
-- while reserving some powers to themselves. The government of the 
-- UnitedStates is a federal government, in which power is shared between 
-- the states and the central goverment, as set out in the U.S. 
-- Constitution.
fun FederalGovernment : Ind FormOfGovernment ;


fun FederalParliamentaryDemocracy : Ind FormOfGovernment ;

fun FederalRepublic : Ind FormOfGovernment ;

fun Federation : Ind FormOfGovernment ;

fun FinancialCooperation : Ind TransnationalIssue ;

-- FixedHoliday is the class of Holidays 
-- whose observance is fixed to recurrences of the calendar day that the 
-- holiday commemorates. See commemoratesDate.
fun FixedHoliday : Class ;
fun FixedHoliday_Class : SubClass FixedHoliday Holiday ;

fun FoodAid : Ind TransnationalIssue ;

fun FoodAndAgricultureOrganization : Ind OrganizationOfNations ;

-- ForeignServicePosition is the 
-- subclass of Positions that belong to foreign service personnel working 
-- for a national government or international organization.
fun ForeignServicePosition : Class ;
fun ForeignServicePosition_Class : SubClass ForeignServicePosition Position ;

-- A Foreign Terrorist Organization
--  is an Organization designated by the USStateDeparment as one which
--  conducts acts of terrorism. This designation makes it subject to the
--  AntiterrorismAndEffectiveDeathPenaltyAct.
fun ForeignTerroristOrganization : Class ;
fun ForeignTerroristOrganization_Class : SubClass ForeignTerroristOrganization TerroristOrganization ;

fun FrancZone : Ind OrganizationOfNations ;

fun FullMember : Ind MemberStatus ;

fun GenderEquality : Ind AreaOfConcern ;

-- GovernmentCabinet is the class of 
-- GovernmentOrganizations whose purpose is to advise a President, 
-- Governor, or other political leader(s) on policy matters.
fun GovernmentCabinet : Class ;
fun GovernmentCabinet_Class : SubClass GovernmentCabinet GovernmentOrganization ;

fun GovernmentDeputy : Ind Position ;

-- The GroupOf10 (also known as the Paris Club) 
-- is a group of (now) 11 major creditor nations that manage the repayment of 
-- loans by debtor countries. The Group of 10 works closely with the 
-- InternationalMonetaryFund.
fun GroupOf10 : Ind OrganizationOfNations ;


fun GroupOf11 : Ind OrganizationOfNations ;

-- The GroupOf15 was a result of the NonalignedMovement.
fun GroupOf15 : Ind OrganizationOfNations ;


-- The GroupOf24 promotes the interests of 
-- developing countries in Africa, Asia, and Latin America within the 
-- InternationalMonetaryFund.
fun GroupOf24 : Ind OrganizationOfNations ;


fun GroupOf3 : Ind OrganizationOfNations ;

fun GroupOf5 : Ind OrganizationOfNations ;

fun GroupOf6 : Ind OrganizationOfNations ;

-- The memberships of the BigSeven and the 
-- GroupOf7 include the same Nations.
fun GroupOf7 : Ind OrganizationOfNations ;


fun GroupOf77 : Ind OrganizationOfNations ;

-- The GroupOf8 members were participants in the 
-- Conference on International Economic Cooperation (CIEC) between 
-- 1975_1977.
fun GroupOf8 : Ind OrganizationOfNations ;


fun GroupOf9 : Ind OrganizationOfNations ;

fun GuestStatus : Ind MemberStatus ;

fun GulfCooperationCouncil : Ind OrganizationOfNations ;

fun HereditaryMonarchy : Ind FormOfGovernment ;

-- Holiday is the class of time periods that are 
-- observed as holidays in a country, culture, or religion. Holidays may 
-- recur annually on the same date, or they may be moveable, for example, 
-- UnitedStatesThanksgivingDay falls on the last Thursday of each 
-- November.
fun Holiday : Class ;
fun Holiday_Class : SubClass Holiday TimeInterval ;

fun HumanRightsIssues : Ind TransnationalIssue ;

fun HumanitarianAid : Ind TransnationalIssue ;

fun HumanitarianAssistance : Ind TransnationalIssue ;

fun ImmigrationAndNationalityAct_Section219_US : Ind Proposition ;

fun ImmigrationAndNationalityAct_US : Ind Proposition ;

fun ImproveHumanSettlementConditions : Ind AreaOfConcern ;

-- IndependentState is a subclass of 
-- GeopoliticalArea, representing the classification 'Independent State' 
-- used by the CIA World Fact Book. Cf. 
-- DependencyOrSpecialSovereigntyArea.
fun IndependentState : Class ;
fun IndependentState_Class : SubClass IndependentState (both GeopoliticalArea Nation) ;


fun IndianOceanCommission : Ind OrganizationOfNations ;

fun IndustryStandards : Ind AreaOfConcern ;

fun InformationCooperation : Ind AreaOfConcern ;

fun InformationStandards : Ind AreaOfConcern ;

fun InfrastructureCooperation : Ind AreaOfConcern ;

fun IntellectualPropertyProtection : Ind AreaOfConcern ;

fun InterAmericanDevelopmentBank : Ind OrganizationOfNations ;

-- The 
-- InterGovernmentalAuthorityOnDevelopment is the revitalized successor 
-- organization of the Inter_Governmental Authority on Development, which had 
-- been established 15_16 January 1986.
fun InterGovernmentalAuthorityOnDevelopment : Ind OrganizationOfNations ;


fun InternationalAtomicEnergyAgency : Ind OrganizationOfNations ;

fun InternationalBankForReconstructionAndDevelopment : Ind OrganizationOfNations ;

fun InternationalCenterForSecretariatOfInvestmentDisputes : Ind InternationalOrganization ;

fun InternationalChamberOfCommerce : Ind OrganizationOfNations ;

fun InternationalCivilAviationOrganization : Ind OrganizationOfNations ;

fun InternationalCommitteeOfTheRedCross : Ind InternationalOrganization ;

fun InternationalConfederationOfFreeTradeUnions : Ind OrganizationOfNations ;

-- The 
-- InternationalCourtOfJustice superseded the Permanent Court of 
-- International Justice.
fun InternationalCourtOfJustice : Ind (both InternationalOrganization JudicialOrganization) ;


-- Interpol is the 
-- successor organization to the International Criminal Police Organization, 
-- which had been established in 1923.
fun InternationalCriminalPoliceOrganization : Ind OrganizationOfNations ;


fun InternationalCriminalTribunalForRwanda : Ind InternationalOrganization ;

fun InternationalCriminalTribunalForTheFormerYugoslavia : Ind InternationalOrganization ;

fun InternationalDevelopmentAssociation : Ind OrganizationOfNations ;

-- The InternationalEnergyAgency 
-- was established by the OrganizationForEconomicAndCulturalDevelopment.
fun InternationalEnergyAgency : Ind OrganizationOfNations ;


fun InternationalFederationOfRedCrossAndRedCrescentSocieties : Ind OrganizationOfNations ;

-- The 
-- InternationalFinanceCorporation is affiliated with the 
-- InternationalBankForReconstructionAndDevelopment.
fun InternationalFinanceCorporation : Ind OrganizationOfNations ;


fun InternationalFundForAgriculturalDevelopment : Ind OrganizationOfNations ;

fun InternationalHydrographicOrganization : Ind OrganizationOfNations ;

fun InternationalJustice : Ind (both AreaOfConcern TransnationalIssue) ;

-- The 
-- InternationalLaborOrganization became affiliated with the 
-- UnitedNations in 1946.
fun InternationalLaborOrganization : Ind OrganizationOfNations ;


fun InternationalMaritimeAffairs : Ind AreaOfConcern ;

-- The 
-- InternationalMaritimeOrganization was established in 1948 but became 
-- effective ten years later.
fun InternationalMaritimeOrganization : Ind OrganizationOfNations ;


fun InternationalMonetaryFund : Ind OrganizationOfNations ;

fun InternationalOlympicCommittee : Ind OrganizationOfNations ;

fun InternationalOrNonregionalMember : Ind MemberStatus ;

-- InternationalOrganization is 
-- the class of Organizations whose activities have international scope and 
-- which typically have members who are, or are from, different Nations.
fun InternationalOrganization : Class ;
fun InternationalOrganization_Class : SubClass InternationalOrganization Organization ;

fun InternationalOrganizationForMigration : Ind OrganizationOfNations ;

fun InternationalOrganizationForStandardization : Ind OrganizationOfNations ;

fun InternationalPeaceAndSecurity : Ind TransnationalIssue ;

fun InternationalRedCrossAndRedCrescentMovement : Ind InternationalOrganization ;

fun InternationalResearchAndTrainingInstituteForTheAdvancementOfWomen : Ind OrganizationOfNations ;

-- The 
-- InternationalTelecommunicationUnion became affiliated with the 
-- UnitedNations on November 15, 1947.
fun InternationalTelecommunicationUnion : Ind OrganizationOfNations ;


fun InternationalTradeSupport : Ind TransnationalIssue ;

fun IslamicDevelopmentBank : Ind OrganizationOfNations ;

fun IslamicGovernment : Ind FormOfGovernment ;

-- IslamicLaw is the Attribute of 
-- legal systems that are based on religious principles of Islam.
fun IslamicLaw : Ind LegalSystemAttribute ;


-- IslamicLawCourt is the subclass of 
-- JudicialOrganizations that are conducted according to principles of 
-- Islamic Law.
fun IslamicLawCourt : Class ;
fun IslamicLawCourt_Class : SubClass IslamicLawCourt JudicialOrganization ;

-- JudgeAtLaw is the Position of a person who 
-- is a public official with the authority to decide legal matters in a 
-- governmental JudicialOrganization.
fun JudgeAtLaw : Ind Position ;


-- JudicialReviewOfExecutiveActs is an attribute of legal systems 
-- in which the judiciary has authority to review acts of the executive 
-- branch.
fun JudicialReviewOfExecutiveActs : Ind LegalSystemAttribute ;


-- JudicialReviewOfLegislativeActs is an attribute of legal systems 
-- in which the judiciary has authority to review acts of the legislature.
fun JudicialReviewOfLegislativeActs : Ind LegalSystemAttribute ;


-- (JudiciaryFn ?AREA) denotes the judicial 
-- branch of the GeopoliticalArea ?AREA, that is, the 
-- JudicialOrganization(s) associated with the government of ?AREA, 
-- considered as a whole.
fun JudiciaryFn : El GeopoliticalArea -> Ind GovernmentOrganization ;


fun JusticeIssues : Ind AreaOfConcern ;

fun King : Ind Position ;

fun LaborIssues : Ind AreaOfConcern ;

fun LatinAmericanEconomicSystem : Ind OrganizationOfNations ;

fun LatinAmericanIntegrationAssociation : Ind OrganizationOfNations ;

fun Leader : Ind Position ;

-- LegalSystemAttribute is the class 
-- of Attributes that are used to characterize legal systems, as, e.g., 
-- according to their sources, areas of concern, or principles of 
-- organization.
fun LegalSystemAttribute : Class ;
fun LegalSystemAttribute_Class : SubClass LegalSystemAttribute RelationalAttribute ;

-- LegislativeChamber is the class of 
-- LegislativeOrganizations which are a coherent body that considers and 
-- votes upon legislation in common session. For example, the United States 
-- Senate.
fun LegislativeChamber : Class ;
fun LegislativeChamber_Class : SubClass LegislativeChamber LegislativeOrganization ;

-- (LegislatureFn ?AREA) denotes the 
-- legislative branch of the GeopoliticalArea ?AREA.
fun LegislatureFn : El GeopoliticalArea -> Ind LegislativeOrganization ;


-- (MemberFn ?ORG) denotes the Position of 
-- a member in the Organization ?ORG.
fun MemberFn : El Organization -> Ind Position ;


-- (MemberRoleFn ?ORG ?POSITION) denotes the 
-- role of having the Position ?POSITION the Organization ?ORG.
fun MemberRoleFn : El Organization -> El Position -> Ind Position ;


-- MemberStatus is the class of 
-- RelationalAttributes that represent the different kinds of status 
-- that may be held in various organizations. Included in this class are 
-- membership types for InternationalOrganizations covered by the CIA World 
-- Fact Book.
fun MemberStatus : Class ;
fun MemberStatus_Class : SubClass MemberStatus RelationalAttribute ;

fun MembershipApplicant : Ind MemberStatus ;

fun MembershipPending : Ind MemberStatus ;

fun MilitaryCommander : Ind Position ;

fun MilitaryCooperation : Ind TransnationalIssue ;

fun MilitaryDictatorship : Ind FormOfGovernment ;

fun Monarch : Ind Position ;

-- Monarchy is the attribute of a government 
-- that is ruled by a monarch, which is usually a hereditary role.
fun Monarchy : Ind FormOfGovernment ;


fun MonetaryAndEconomicCommunityOfCentralAfrica : Ind OrganizationOfNations ;

fun MonetaryStability : Ind AreaOfConcern ;

fun MonetaryUnion : Ind TransnationalIssue ;

-- MoveableHoliday is the class of 
-- Holidays whose observance is not fixed to recurrences of any particular 
-- calendar day. For example, UnitedStatesMemorialDay is observed on the 
-- last Monday of May.
fun MoveableHoliday : Class ;
fun MoveableHoliday_Class : SubClass MoveableHoliday Holiday ;

fun MulitlateralInvestmentGeographicAgency : Ind InternationalOrganization ;

fun MultipartyDemocracy : Ind FormOfGovernment ;

fun MutualDefensePact : Ind TransnationalIssue ;

-- NapoleonicCode is the specialization of 
-- CivilLaw developed in France under Napoleon Bonaparte. It is still the 
-- basis of French law as well as of legal systems developed under French 
-- influence.
fun NapoleonicCode : Ind LegalSystemAttribute ;


fun NationalCommitteeChairman : Ind Position ;

-- NationalGovernment is the class of 
-- national_level governments of Nations.
fun NationalGovernment : Class ;
fun NationalGovernment_Class : SubClass NationalGovernment Government ;

-- The NonalignedMovement was 
-- established to promote political and military cooperation outside of the 
-- traditional East and West power groups.
fun NonalignedMovement : Ind OrganizationOfNations ;


fun NonpermanentStatus : Ind MemberStatus ;

fun NonregionalMember : Ind MemberStatus ;

fun NonstateParticipant : Ind MemberStatus ;

fun NordicCouncil : Ind OrganizationOfNations ;

fun NordicInvestmentBank : Ind OrganizationOfNations ;

fun NorthAtlanticTreatyOrganization : Ind OrganizationOfNations ;

fun NuclearDisarmament : Ind TransnationalIssue ;

fun NuclearEnergyAgency : Ind OrganizationOfNations ;

fun NuclearExportControls : Ind TransnationalIssue ;

fun NuclearNonproliferation : Ind TransnationalIssue ;

fun NuclearSuppliersGroup : Ind OrganizationOfNations ;

fun ObservationAndMonitoring : Ind AreaOfConcern ;

fun ObserverStatus : Ind MemberStatus ;

fun OrganizationForEconomicCooperationAndDevelopment : Ind OrganizationOfNations ;

-- The 
-- OrganizationForSecurityAndCooperationInEurope, established January 1, 
-- 1995, grew out of the Conference on Security and Cooperation in Europe, 
-- which began meeting in 1975.
fun OrganizationForSecurityAndCooperationInEurope : Ind OrganizationOfNations ;


fun OrganizationForTheProhibitionOfChemicalWeapons : Ind OrganizationOfNations ;

-- The 
-- OrganizationOfAfricanUnity was renamed to African Union 
-- (Union_Africaine) in July, 2002.
fun OrganizationOfAfricanUnity : Ind OrganizationOfNations ;


-- The 
-- OrganizationOfAmericanStates adopted its present charter on April 30, 
-- 1948.
fun OrganizationOfAmericanStates : Ind OrganizationOfNations ;


fun OrganizationOfArabPetroleumExportingCountries : Ind OrganizationOfNations ;

fun OrganizationOfEasternCaribbeanStates : Ind OrganizationOfNations ;

-- This is the 
-- class of Organizations whose members are Nations.
fun OrganizationOfNations : Class ;
fun OrganizationOfNations_Class : SubClass OrganizationOfNations InternationalOrganization ;

fun OrganizationOfPetroleumExportingCountries : Ind OrganizationOfNations ;

fun OrganizationOfTheIslamicConference : Ind OrganizationOfNations ;

fun OrganizeOlympicGames : Ind TransnationalIssue ;

-- OverseasArea is the class of 
-- GeopoliticalAreas that are related to a Nation as overseas 
-- territories, possessions, protectorates, or departments.
fun OverseasArea : Class ;
fun OverseasArea_Class : SubClass OverseasArea (both DependencyOrSpecialSovereigntyArea GeopoliticalArea) ;


-- (OverseasAreaFn ?AREA) denotes the class 
-- of OverseasAreas that belong to the GeopoliticalArea ?AREA.
fun OverseasAreaFn: El GeopoliticalArea -> Desc OverseasArea ;


fun PacificCommunity : Ind OrganizationOfNations ;

fun PacificIslandForum : Ind OrganizationOfNations ;

-- Parliament is the subclass of 
-- LegislativeOrganizations similar to that of the United Kingdom.
fun Parliament : Class ;
fun Parliament_Class : SubClass Parliament LegislativeOrganization ;

fun ParliamentaryDemocracy : Ind FormOfGovernment ;

fun ParliamentaryDemocraticRepublic : Ind FormOfGovernment ;

-- ParliamentaryGovernment is the 
-- attribute of a government whose chief LegislativeOrganization is a 
-- Parliament. A parliamentary government is compatible with various 
-- other government types, including Monarchy.
fun ParliamentaryGovernment : Ind FormOfGovernment ;


fun ParliamentaryRepublic : Ind FormOfGovernment ;

fun ParliamentaryTerritory : Class ;
fun ParliamentaryTerritory_Class : SubClass ParliamentaryTerritory GeopoliticalArea ;
fun PartIIMember : Ind MemberStatus ;

fun PartIMember : Ind MemberStatus ;

fun PartnersForCooperation : Ind MemberStatus ;

fun PartnershipForPeace : Ind OrganizationOfNations ;

fun PeacefulUseOfAtomicPower : Ind TransnationalIssue ;

fun PeacekeepingOperation : Ind (both TransnationalIssue AreaOfConcern) ;

fun PermanentChargeDAffaires : Ind ForeignServicePosition ;

fun PermanentCourtOfArbitration : Ind OrganizationOfNations ;

fun PermanentRepresentative : Ind Position ;

fun PermanentStatus : Ind MemberStatus ;

-- PoliticalCoalition is the class of 
-- political organizations that are constituted by political parties joined 
-- together for some common interest(s).
fun PoliticalCoalition : Class ;
fun PoliticalCoalition_Class : SubClass PoliticalCoalition (both PoliticalOrganization PoliticalParty) ;


fun PoliticalCooperation : Ind AreaOfConcern ;

fun PoliticalDevelopment : Ind AreaOfConcern ;

fun PoliticalIntegration : Ind AreaOfConcern ;

-- PoliticalPressureGroup is the 
-- class of Organizations that exert political pressure and have leaders 
-- who are involved in politics but not standing for election. For example, 
-- corporate lobbying groups, Mothers Against Drunk Driving (MADD), or the 
-- American Civil Liberties Union (ACLU).
fun PoliticalPressureGroup : Class ;
fun PoliticalPressureGroup_Class : SubClass PoliticalPressureGroup PoliticalOrganization ;

fun PopulationPolicySupport : Ind AreaOfConcern ;

fun President : Ind Position ;

fun PresidentialGovernment : Ind FormOfGovernment ;

fun PrimeMinister : Ind Position ;

fun PrincipalOfficer : Ind ForeignServicePosition ;

fun PromotePrivateEnterprise : Ind AreaOfConcern ;

fun PromoteRegionalStability : Ind TransnationalIssue ;

fun PromoteSustainableDevelopment : Ind AreaOfConcern ;

fun PromoteTradeUnionism : Ind AreaOfConcern ;

fun PromotionOfFreeTrade : Ind TransnationalIssue ;

fun PromotionOfPrivateEnterprise : Ind AreaOfConcern ;

fun PromotionOfTourism : Ind AreaOfConcern ;

fun PromotionOfTradeAndInvestment : Ind TransnationalIssue ;

fun PublicHealthConcern : Ind AreaOfConcern ;

fun Queen : Ind Position ;

fun ReducePoverty : Ind AreaOfConcern ;

fun ReducingCrime : Ind AreaOfConcern ;

fun RefugeeAssistance : Ind (both TransnationalIssue AreaOfConcern) ;

-- RegionalLaw is the class of regional 
-- laws, considered as a body, established by particular Governments 
-- to regulate activities under their jurisdictions. For example, 
-- (RegionalLawFn UnitedStates) represents the content of the laws, 
-- statutes, and rulings of the United States.
fun RegionalLaw : Class ;
fun RegionalLaw_Class : SubClass RegionalLaw Proposition ;

-- (RegionalLawFn ?AREA) denotes the laws 
-- pertaining in the GeopoliticalArea ?AREA that are established and 
-- enforced by the Government of ?AREA. For example, (RegionalLawFn 
-- UnitedStates) denotes the laws of the government of the UnitedStates 
-- and its constituent units.
fun RegionalLawFn : El GeopoliticalArea -> Ind RegionalLaw ;


fun RegionalMember : Ind MemberStatus ;

fun RegionalSecurity : Ind AreaOfConcern ;

fun ReproductiveHealthAndFamilyPlannning : Ind AreaOfConcern ;

-- Republic is the attribute of a government 
-- whose power and authority are vested in its members, who elect 
-- representatives to exercise that power.
fun Republic : Ind FormOfGovernment ;


-- RestrictedSuffrage is a subclass of 
-- SuffrageLaw covering laws that restrict suffrage by further 
-- conditions beyond the basics of citizenship and age.
fun RestrictedSuffrage : Class ;
fun RestrictedSuffrage_Class : SubClass RestrictedSuffrage SuffrageLaw ;

-- The RioGroup was the result of fusing the 
-- Contadora Group and the Lima (or Support) Group.
fun RioGroup : Ind OrganizationOfNations ;


-- RomanCanonLaw is the attribute of legal 
-- systems based on the Ecclesiastical law developed by the Roman Catholic 
-- Church.
fun RomanCanonLaw : Ind LegalSystemAttribute ;


fun ScientificCooperation : Ind AreaOfConcern ;

fun SelfGoverningTerritory : Class ;
fun SelfGoverningTerritory_Class : SubClass SelfGoverningTerritory GeopoliticalArea ;
fun SignatoryMember : Ind MemberStatus ;

fun SocialCooperation : Ind TransnationalIssue ;

fun SocialDevelopment : Ind AreaOfConcern ;

fun SocioeconomicResearch : Ind AreaOfConcern ;

fun SouthAsianAssociationForRegionalCooperation : Ind OrganizationOfNations ;

fun SouthPacificRegionalTradeAndEconomicCooperationAgreement : Ind OrganizationOfNations ;

fun SouthernAfricanCustomsUnion : Ind OrganizationOfNations ;

fun SouthernAfricanDevelopmentCommunity : Ind OrganizationOfNations ;

fun SouthernConeCommonMarket : Ind OrganizationOfNations ;

fun SpaceResearchAndTechnology : Ind AreaOfConcern ;

fun Spokesperson : Ind Position ;

fun StatisticalCommission : Ind InternationalOrganization ;

fun SubbureauMember : Ind MemberStatus ;

fun SubscriberMember : Ind MemberStatus ;

-- SuffrageLaw is a class that includes the 
-- various types of suffrage rules of different Nations. Instances of 
-- SuffrageLaw represent the propositional content of various suffrage 
-- laws.
fun SuffrageLaw : Class ;
fun SuffrageLaw_Class : SubClass SuffrageLaw Proposition ;

fun SupportLawEnforcement : Ind AreaOfConcern ;

-- SupremeCourt is the subclass of 
-- JudicialOrganizations that are the ultimate judicial authority for the 
-- matters on which they rule. For example, the UnitedStatesSupremeCourt, 
-- or the InternationalCourtOfJustice (World Court).
fun SupremeCourt : Class ;
fun SupremeCourt_Class : SubClass SupremeCourt JudicialOrganization ;

-- (SupremeCourtFn ?AREA) denotes the class 
-- of the highest court(s) in the judicial system of GeopoliticalArea 
-- ?AREA. For example, the UnitedStatesSupremeCourt belongs to the class
-- (SupremeCourtFn UnitedStates).
fun SupremeCourtFn: El GeopoliticalArea -> Desc SupremeCourt ;


-- SupremeCourtJudge is the Position 
-- of a person who is a JudgeAtLaw on some SupremeCourt.
fun SupremeCourtJudge : Ind Position ;


fun SuspendedMember : Ind MemberStatus ;

fun TechnologyCooperation : Ind AreaOfConcern ;

-- TheocraticGovernment is the 
-- attribute of a government that bases its authority on Religion.
fun TheocraticGovernment : Ind FormOfGovernment ;


fun TheocraticRepublic : Ind FormOfGovernment ;

fun TransitionalAdministration : Ind (both AreaOfConcern TransnationalIssue) ;

-- TransitionalGovernment is the 
-- attribute of a government that is changing from one form of government 
-- to another. This may be accompanied by social unrest or instability.
fun TransitionalGovernment : Ind FormOfGovernment ;


-- TransnationalIssue is a class of 
-- Attributes that characterize the concerns of Nations, international 
-- Non_Governmental Institutions (NGOs), and other transnational agents.
fun TransnationalIssue : Class ;
fun TransnationalIssue_Class : SubClass TransnationalIssue AreaOfConcern ;

fun TransportationCoordination : Ind AreaOfConcern ;

-- The US government organization charged with protecting the
-- integrity of US national borders, primarily by detecting and
-- preventing attempts at illegal immigration.
fun USCustomsAndBorderProtection : Ind (both GovernmentOrganization PoliceOrganization) ;


-- The branch of the US Government that
--  handles relations with foreign governments and entities. It is the chief
--  diplomatic instrument of US foreign policy. It controls US embassies and 
--  consuls.
fun USStateDepartment : Ind Government ;


fun UnicameralLegislature : Ind FormOfGovernment ;

fun UnincorporatedUnitedStatesTerritory : Class ;
fun UnincorporatedUnitedStatesTerritory_Class : SubClass UnincorporatedUnitedStatesTerritory OverseasArea ;
-- UnitaryRule is a FormOfGovernment in which 
-- the central government controls affairs at all levels, including the local 
-- level.
fun UnitaryRule : Ind FormOfGovernment ;


-- The UnitedNations has six principal 
-- subOrganizations: the Secretariat, the General Assembly, the Security 
-- Council, the Economic and Social Council, the Trusteeship Council 
-- (currently inactive), and the International Court of Justice. The United 
-- Nations has numerous subordinate agencies and bodies within those six 
-- major subdivisions.
fun UnitedNations : Ind OrganizationOfNations ;


fun UnitedNationsCenterForHumanSettlements : Ind OrganizationOfNations ;

fun UnitedNationsChildrensFund : Ind OrganizationOfNations ;

fun UnitedNationsCivilianPoliceMissionInHaiti : Ind OrganizationOfNations ;

-- The 
-- UnitedNationsCompensationCommission was created to process claims and 
-- pay compensation for losses and damage suffered as a direct result of 
-- the unlawful invasion and occupation of Kuwait by Iraq.
fun UnitedNationsCompensationCommission : Ind InternationalOrganization ;


fun UnitedNationsConferenceOnTradeAndDevelopment : Ind OrganizationOfNations ;

fun UnitedNationsDevelopmentProgram : Ind OrganizationOfNations ;

-- The 
-- UnitedNationsDisengagementObserverForce was formed by the UN Security 
-- Council in order to observe the 1973 Arab_Israeli cease_fire.
fun UnitedNationsDisengagementObserverForce : Ind OrganizationOfNations ;


fun UnitedNationsEducationalScientificAndCulturalOrganization : Ind OrganizationOfNations ;

fun UnitedNationsEnvironmentProgram : Ind OrganizationOfNations ;

-- The 
-- UnitedNationsGeneralAssembly is the primary deliberative body of the 
-- UnitedNations.
fun UnitedNationsGeneralAssembly : Ind OrganizationOfNations ;


fun UnitedNationsHighCommissionerForHumanRights : Ind InternationalOrganization ;

fun UnitedNationsHighCommissionerForRefugees : Ind OrganizationOfNations ;

fun UnitedNationsIndustrialDevelopmentOrganization : Ind OrganizationOfNations ;

fun UnitedNationsInstituteForDisarmamentResearch : Ind InternationalOrganization ;

fun UnitedNationsInstituteForTrainingAndResearch : Ind OrganizationOfNations ;

fun UnitedNationsInterimAdministrationMissionInKosovo : Ind InternationalOrganization ;

fun UnitedNationsInterimAdminstrationMissionInKosovo : Ind OrganizationOfNations ;

fun UnitedNationsInterimForceInLebanon : Ind OrganizationOfNations ;

-- The UnitedNationsInterregionalCrimeAndJusticeResearchInstitute was 
-- reconstituted (from UNSDRI) into its present form in 1989 to address 
-- broader demands introduced by the participation of more developing 
-- countries in the UnitedNations.
fun UnitedNationsInterregionalCrimeAndJusticeResearchInstitute : Ind InternationalOrganization ;


fun UnitedNationsIraqKuwaitBoundaryDemarcationCommission : Ind InternationalOrganization ;

fun UnitedNationsIraqKuwaitObservationMission : Ind OrganizationOfNations ;

fun UnitedNationsMilitaryObserverGroupInIndiaAndPakistan : Ind OrganizationOfNations ;

fun UnitedNationsMissionForTheReferendumInWesternSahara : Ind OrganizationOfNations ;

fun UnitedNationsMissionInBosniaAndHerzegovina : Ind OrganizationOfNations ;

fun UnitedNationsMissionInEthiopiaAndEritrea : Ind OrganizationOfNations ;

fun UnitedNationsMissionInSierraLeone : Ind OrganizationOfNations ;

fun UnitedNationsMissionOfObserversInPrevlaka : Ind OrganizationOfNations ;

fun UnitedNationsMissionOfObserversInTajikistan : Ind OrganizationOfNations ;

fun UnitedNationsMonitoringAndVerificationCommission : Ind OrganizationOfNations ;

fun UnitedNationsObserverMissionInGeorgia : Ind OrganizationOfNations ;

fun UnitedNationsOfficeOfProjectServices : Ind InternationalOrganization ;

fun UnitedNationsOrganizationMissionInTheDemocraticRepublicOfTheCongo : Ind OrganizationOfNations ;

fun UnitedNationsPeaceKeepingForceInCyprus : Ind OrganizationOfNations ;

fun UnitedNationsPopulationFund : Ind OrganizationOfNations ;

fun UnitedNationsPreventiveDeploymentForce : Ind OrganizationOfNations ;

fun UnitedNationsReliefAndWorksAgencyForPalestineRefugeesInTheNearEast : Ind OrganizationOfNations ;

-- The 
-- UnitedNationsResearchInstituteForSocialDevelopment conducts research 
-- into problems of social and economic development. The Chair of its Board 
-- of Directors is appointed by the UN Secretary General. (No country 
-- members.)
fun UnitedNationsResearchInstituteForSocialDevelopment : Ind InternationalOrganization ;


-- The UnitedNationsSecretariat is 
-- the primary administrative body of the UnitedNations. It is headed by 
-- the United Nations' Secretary General, and constituted by him and his 
-- staff. The UN General Assembly appoints the Secretary General for a 
-- five_year term.
fun UnitedNationsSecretariat : Ind InternationalOrganization ;


fun UnitedNationsSecurityCouncil : Ind OrganizationOfNations ;

fun UnitedNationsSystemStaffCollege : Ind OrganizationOfNations ;

fun UnitedNationsTransitionalAdministrationInEastTimor : Ind OrganizationOfNations ;

fun UnitedNationsTruceSupervisionOrganization : Ind OrganizationOfNations ;

-- The 
-- UnitedNationsTrusteeshipCouncil is one of the six major organs of the 
-- UnitedNations, but it is currently inactive (though not dissolved) 
-- following the transition of the last UN trust territory to an independent 
-- government.
fun UnitedNationsTrusteeshipCouncil : Ind OrganizationOfNations ;


-- The Rector and 24 members of the 
-- UnitedNationsUniversity Council are appointed by the UN Secretary 
-- General and the Director General of UNESCO.
fun UnitedNationsUniversity : Ind InternationalOrganization ;


-- Provides services to farmers in 
-- the UnitedStates.
fun UnitedStatesDepartmentOfAgriculture : Ind GovernmentOrganization ;


-- Entrusted with the national 
-- security of the UnitedStates.
fun UnitedStatesDepartmentOfDefense : Ind GovernmentOrganization ;


-- One of the two legislatures 
-- that make up the UnitedStatesCongress.
fun UnitedStatesHouseOfRepresentatives : Ind LegislativeOrganization ;


-- The GovernmentOrganization of the 
-- UnitedStates that is entrusted with delivering the mail.
fun UnitedStatesPostalService : Ind GovernmentOrganization ;


-- One of the two legislatures that make 
-- up the UnitedStatesCongress.
fun UnitedStatesSenate : Ind LegislativeOrganization ;


-- The UniversalPostalUnion became 
-- affiliated with the UnitedNations on November 15, 1947.
fun UniversalPostalUnion : Ind OrganizationOfNations ;


-- UniversalSuffrageLaw is a law that 
-- enfranchises all citizens of a country who have achieved the applicable 
-- age of maturity (suffrageAgeMinumum).
fun UniversalSuffrageLaw : Ind SuffrageLaw ;


fun ViceChairman : Ind Position ;

fun VicePresident : Ind Position ;

fun VoterAgeRequirement : Class ;
fun VoterAgeRequirement_Class : SubClass VoterAgeRequirement SuffrageLaw ;
fun VoterCitizenshipRequirement : Ind SuffrageLaw ;

-- (VotingFn ?ELECTION) denotes the class of 
-- voting events that occur as part of the Election ?ELECTION.
fun VotingFn: El Election -> Desc Voting ;


fun WarCrimesProsecution : Ind (both AreaOfConcern TransnationalIssue) ;

fun WarsawPact : Ind OrganizationOfNations ;

fun WassenaarArrangement : Ind OrganizationOfNations ;

fun WeaponsInspection : Ind (both AreaOfConcern TransnationalIssue) ;

fun WestAfricanDevelopmentBank : Ind OrganizationOfNations ;

fun WestAfricanEconomicAndMonetaryUnion : Ind OrganizationOfNations ;

fun WesternEuropeanUnion : Ind OrganizationOfNations ;

fun WorldBankGroup : Ind OrganizationOfNations ;

-- The WorldConfederationOfLabor 
-- was previously named the International Federation of Christian Trade 
-- Unions. It was renamed on October 4, 1968.
fun WorldConfederationOfLabor : Ind OrganizationOfNations ;


fun WorldCustomsOrganization : Ind OrganizationOfNations ;

fun WorldFederationOfTradeUnions : Ind OrganizationOfNations ;

fun WorldFoodProgram : Ind OrganizationOfNations ;

fun WorldHealthOrganization : Ind OrganizationOfNations ;

fun WorldIntellectualPropertyOrganization : Ind OrganizationOfNations ;

fun WorldLaborIssues : Ind (both AreaOfConcern TransnationalIssue) ;

fun WorldMeteorologicalOrganization : Ind OrganizationOfNations ;

fun WorldTourismOrganization : Ind OrganizationOfNations ;

-- The WorldTradeOrganization 
-- succeeded the General Agreement on Tariff and Trade (GATT).
fun WorldTradeOrganization : Ind OrganizationOfNations ;


-- The ZanggerCommittee was established 
-- during the 1970s.
fun ZanggerCommittee : Ind OrganizationOfNations ;


-- (abbreviation ?STRING ?THING) means that 
-- ?STRING is an abbreviation used to refer to ?THING. Abbreviations include 
-- acronyms and other abbreviated forms.
fun abbreviation : El SymbolicString -> El Entity -> Formula ;


-- (administrativeCenter ?CENTER 
-- ?REGION) means that ?CENTER is the City (or other area) from which 
-- the larger GeopoliticalArea ?REGION is administered.
fun administrativeCenter : El GeopoliticalArea -> El GeopoliticalArea -> Formula ;


-- (agentOperatesInArea ?AGENT ?AREA) 
-- means that the individual or Organization ?AGENT operates in the 
-- GeographicArea ?AREA.
fun agentOperatesInArea : El Agent -> El GeographicArea -> Formula ;


-- (agreementAdoptionDate ?AGR ?TIME) 
-- means that the agreement ?AGR was adopted on the date indicated by ?TIME. 
-- For example, (agreementAdoptionDate ConstitutionOfTheUnitedStates 
-- (DayFn 17 (MonthFn September (YearFn 1787)))).
fun agreementAdoptionDate: El Proposition -> Desc TimePosition -> Formula ;


-- (agreementEffectiveDate ?AGR 
-- ?TIME) means that the agreement ?AGR becomes effective on the date 
-- indicated by ?TIME. For example, (agreementEffectiveDate 
-- ConstitutionOfTheUnitedStates (DayFn 4 (MonthFn March (YearFn 
-- 1789)))).
fun agreementEffectiveDate: El Proposition -> Desc TimePosition -> Formula ;


-- (agreementEffectiveDuring ?AGR 
-- ?DATE) means that the agreement ?AGR is effective during the time 
-- indicated by ?DATE. The agreement may be effective for longer than ?DATE, 
-- but it is in effect at least throughout the time indicated by ?DATE.
fun agreementEffectiveDuring: El Proposition -> Desc TimePosition -> Formula ;


-- (agreementRevisionDate ?AGR ?DATE ?CHANGE) means that the agreement 
-- ?AGR was revised at the time indicated by ?DATE, with respect to the 
-- part ?CHANGE. Revisions cover additions and removals.
fun agreementRevisionDate: El Proposition -> Desc TimePosition -> El Proposition -> Formula ;


-- (aimOfOrganization ?GROUP ?DESCRIPTION) means that the Organization 
-- ?GROUP has the purpose ?DESCRIPTION, formulated as a quoted text.
fun aimOfOrganization : El Organization -> El SymbolicString -> Formula ;


-- (associateInOrganization 
-- ?AGENT ?GROUP) means that ?AGENT is associated in some way with the 
-- Group ?GROUP. This includes participation as a guest or observer,
-- as well as being a full member. See member for a more specific 
-- relation.
fun associateInOrganization : El Agent -> El Group -> Formula ;


-- (associateWithStatus ?AGT ?STATUS ?GROUP) means that the Agent 
-- ?AGT has the RelationalAttribute ?STATUS in the Group ?GROUP. 
-- For example, (associateWithStatus UnitedStates PermanentMember 
-- UnitedNationsSecurityCouncil) means that the &UnitedStates has the status 
-- of a permanent member in the U.N. Security Council.
fun associateWithStatus : El Agent -> El RelationalAttribute -> El Group -> Formula ;


-- (candidateForPosition ?ELECTION 
-- ?POSITION ?CONTENDER) means that in the Election ?ELECTION for 
-- ?POSITION, the Agent ?CONTENDER was one of the candidates.
fun candidateForPosition : El Election -> El SocialRole -> El Agent -> Formula ;


-- (capitalCity ?CITY ?REGION) means that the 
-- City ?CITY is the capital of the GeopoliticalArea ?REGION.
fun capitalCity : El City -> El GeopoliticalArea -> Formula ;


-- (cardinality ?SET ?NUMBER) means that there 
-- are ?NUMBER of elements in the SetOrClass ?SET.
fun cardinality : El SetOrClass -> El NonnegativeInteger -> Formula ;


-- (chamberOfLegislature ?CHAMBER 
-- ?LEGISLATURE) means that ?CHAMBER is a legislative body within the 
-- ?LEGISLATURE.
fun chamberOfLegislature : El Organization -> El Organization -> Formula ;


-- (chanceryAddressInArea ?AREA1 
-- ?ADDRESS ?AREA2) means that the address of the main foreign service 
-- organization of the GeopoliticalArea ?AREA1 for ?AREA2 is the 
-- SymbolicString ?ADDRESS.
fun chanceryAddressInArea : El GeopoliticalArea -> El SymbolicString -> El GeopoliticalArea -> Formula ;


-- (chanceryFAXNumberInArea ?AREA1 
-- ?FAX ?AREA2) means that the FAX number of the main diplomatic office of 
-- the GeopoliticalArea ?AREA1 located in ?AREA2 is ?FAX.
fun chanceryFAXNumberInArea : El GeopoliticalArea -> El SymbolicString -> El GeopoliticalArea -> Formula ;


-- (chanceryMailingAddressInArea ?AREA1 ?ADDRESS ?AREA2) means that the 
-- mailing address of the main foreign service organization of the 
-- GeopoliticalArea ?AREA1 located in ?AREA2 is the SymbolicString 
-- ?ADDRESS.
fun chanceryMailingAddressInArea : El GeopoliticalArea -> El SymbolicString -> El GeopoliticalArea -> Formula ;


-- (chanceryTelephoneNumberInArea ?AREA1 ?TELEPHONE ?AREA2) means that the 
-- telephone number of the main diplomatic office of the GeopoliticalArea 
-- ?AREA1 located in ?AREA2 is ?TELEPHONE.
fun chanceryTelephoneNumberInArea : El GeopoliticalArea -> El SymbolicString -> El GeopoliticalArea -> Formula ;


-- (chiefOfDiplomaticMission ?AGENT1 ?PERSON ?RANK ?AGENT2) means that 
-- the chief diplomatic representative sent by the Agent ?AGENT1 to the 
-- Agent ?AGENT2 is ?PERSON, whose official position is ?RANK.
fun chiefOfDiplomaticMission : El Agent -> El Human -> El Position -> El Agent -> Formula ;


-- (chiefOfState ?POLITY ?ROLE ?PERSON) means 
-- that ?PERSON is the titular leader of the government of the 
-- GeopoliticalArea ?POLITY and represents it at official functions. The 
-- office held by this chief of state is ?ROLE (e.g., President, Queen, 
-- Chairman). Note: this term is defined as in the CIA World Fact Book.
fun chiefOfState : El GeopoliticalArea -> El Position -> El Human -> Formula ;


-- (chiefOfStateType ?NATION ?ROLE) means 
-- that the chiefOfState of the GeopoliticalArea ?NATION holds the 
-- Position ?ROLE in its government.
fun chiefOfStateType : El GeopoliticalArea -> El Position -> Formula ;


-- (commemoratesDate ?HOLIDAY ?DATE) means 
-- that instances of the Holiday ?HOLIDAY are observed to commemorate 
-- something that happened during the TimeInterval specified by ?DATE. For 
-- example, (commemoratesDate BastilleDay (DayFn 14 (MonthFn July 
-- (YearFn 1789)))).
fun commemoratesDate: El Holiday -> Desc TimeInterval -> Formula ;


-- (conventionalLongName ?NAME ?THING) 
-- means that the string ?NAME is the long form of the name conventionally 
-- used for ?THING.
fun conventionalLongName : El SymbolicString -> El Entity -> Formula ;


-- (conventionalShortName ?NAME 
-- ?THING) means that the string ?NAME is the short form of the name 
-- conventionally used for ?THING. For a more specialized subset of short 
-- names, see abbreviation.
fun conventionalShortName : El SymbolicString -> El Entity -> Formula ;


-- (dateDissolved ?THING ?TIME) means that 
-- the Physical ?THING was dissolved, disbanded, or superseded on the date 
-- indicated by ?TIME. For example, (dateDissolved 
-- UnitedNationsPreventiveDeploymentForce (DayFn 25 (MonthFn March 
-- (YearFn 1999)))).
fun dateDissolved: El Physical -> Desc TimePosition -> Formula ;


-- (dateEstablished ?THING ?TIME) means 
-- that the Physical ?THING was founded on the date indicated by ?TIME. 
-- For example, (dateEstablished UnitedNations 
-- (DayFn 26 (MonthFn June (YearFn 1945)))).
fun dateEstablished: El Physical -> Desc TimePosition -> Formula ;


-- (dependentAreaOfType ?AREA ?COUNTRY 
-- ?TYPE) means that the GeopoliticalArea ?AREA is a dependency of the 
-- independent Nation ?COUNTRY, administered as a unit of ?TYPE. For 
-- example, (dependentAreaOfType SaintHelena 
-- UnitedKingdom OverseasArea).
fun dependentAreaOfType: El GeopoliticalArea -> El GeopoliticalArea -> Desc GeopoliticalArea -> Formula ;


-- (diplomaticOrganizationType ?AGENT1 ?ORG ?AGENT2) means that the 
-- Agent ?AGENT1 has a diplomatic organization of the type ?ORG 
-- in Agent ?AGENT2. For example, 
-- (diplomaticOrganizationType UnitedStates Embassy France), or 
-- (diplomaticOrganizationType UnitedStates ConsulateGeneral 
-- ShanghaiChina).
fun diplomaticOrganizationType: El Agent -> Desc Organization -> El Agent -> Formula ;


-- (diplomaticRelations ?COUNTRY1 ?COUNTRY2) means that there are official 
-- diplomatic relations between the two Nations ?COUNTRY1 and ?COUNTRY2.
fun diplomaticRelations : El GeopoliticalArea -> El GeopoliticalArea -> Formula ;


-- (diplomaticRepresentationType ?AGENT1 ?RANK ?AGENT2) means that the 
-- Agent ?AGENT1 sends a representative with the Position ?RANK 
-- to the Agent ?AGENT2.
fun diplomaticRepresentationType : El Agent -> El Position -> El Agent -> Formula ;


-- (diplomaticRepresentativeInRole ?AGENT1 ?PERSON ?RANK ?AGENT2) means 
-- that the Agent ?AGENT1 sends the individual ?PERSON with the 
-- Position ?RANK as its representative to the Agent ?AGENT2. 
-- Note: it is possible for ?PERSON to be diplomatically accredited to more 
-- than one area. For example, currently the United States Ambassador to 
-- Papua New Guinea is also accredited to Vanuatu, and there is no embassy 
-- in Vanuatu.
fun diplomaticRepresentativeInRole : El Agent -> El Human -> El Position -> El Agent -> Formula ;


-- (electionDatePlannedForPosition ?AGENT ?TIME ?POSITION) means that the 
-- Agent ?AGENT (a Nation, Government, or Organization) plans to hold 
-- an Election on the date indicated by ?TIME for position(s) ?POSITION.
fun electionDatePlannedForPosition: El Agent -> Desc TimePosition -> El SocialRole -> Formula ;


-- (electionForOrganization ?ELECTION ?GROUP) means that in the 
-- Election ?ELECTION, candidates run for election to the organization 
-- ?GROUP.
fun electionForOrganization : El Election -> El Organization -> Formula ;


-- (electionForPosition ?ELECTION 
-- ?POSITION) means that in the Election ?ELECTION, candidates run for 
-- election to the role(s) ?POSITION.
fun electionForPosition : El Election -> El SocialRole -> Formula ;


-- (electionWinner ?ELECTION ?POSITION 
-- ?CONTENDER) means that in the Election ?ELECTION, ?POSITION was won by 
-- the Agent ?CONTENDER. Contenders may be either persons or political 
-- parties.
fun electionWinner : El Election -> El SocialRole -> El Agent -> Formula ;


-- (executiveBranch ?BRANCH ?ORG) means 
-- that the Organization ?BRANCH is the executive branch of the 
-- GeopoliticalArea or Organization ?ORG, that is, its executive offices 
-- and bodies, considered as a whole.
fun executiveBranch : El Organization -> El Agent -> Formula ;


-- (flagDescription ?AREA ?DESCRIPTION) 
-- means that the SymbolicString ?DESCRIPTION is a verbal description of 
-- the flag of the GeopoliticalArea ?AREA.
fun flagDescription : El GeopoliticalArea -> El SymbolicString -> Formula ;


-- (flagImage ?AREA ?POINTER) means that an image 
-- of the flag of the GeopoliticalArea ?AREA is found at the location given 
-- in the SymbolicString ?POINTER.
fun flagImage : El GeopoliticalArea -> El SymbolicString -> Formula ;


-- (governmentType ?BODY ?FORM) means that 
-- the GeopoliticalArea or Organization ?BODY has a government with 
-- characteristic(s) of the type ?FORM.
fun governmentType : El Agent -> El FormOfGovernment -> Formula ;


-- (headOfGovernment ?POLITY ?ROLE 
-- ?PERSON) means that ?PERSON is the top administrative leader of the 
-- Government of the GeopoliticalArea ?POLITY, with authority for 
-- managing its day_to_day functions. The office held by this person 
-- is the Position ?ROLE (e.g., President, Prime Minister, Governor). 
-- Note: this term is defined as in the CIA World Fact Book.
fun headOfGovernment : El GeopoliticalArea -> El Position -> El Human -> Formula ;


-- (holidayTimeInArea ?AREA 
-- ?TIME) means that ?TIME is a particular time period during which Holiday 
-- is observed, thus during which normal government, business, and other 
-- services may not operate.
fun holidayTimeInArea : El GeopoliticalArea -> El TimePosition -> Formula ;


-- (independenceDate ?AREA ?DATE) means 
-- that the GeopoliticalArea ?AREA achieved its sovereignty on the date 
-- ?DATE. For example, (independenceDate Afghanistan (DayFn 19 
-- (MonthFn August (YearFn 1919)))).
fun independenceDate: El GeopoliticalArea -> Desc TimeInterval -> Formula ;


-- (judicialBranch ?BRANCH ?ORG) means that 
-- the Organization ?BRANCH is the judicial branch of the 
-- GeopoliticalArea or Organization ?ORG, that is, all of its courts and 
-- judicial offices, considered as a whole.
fun judicialBranch : El Organization -> El Agent -> Formula ;


-- (leaderPosition ?ORG ?ROLE)
-- means that in the organization ?ORG, the leader is the person 
-- who holds the Position ?ROLE in the organization.
fun leaderPosition : El Agent -> El Position -> Formula ;


-- (legalSystemType ?AREA ?TYPE) means 
-- that the GeopoliticalArea ?AREA has a legal system characterized by 
-- the LegalSystemAttribute ?TYPE. For example, (legalSystemType 
-- UnitedStates EnglishCommonLaw). A legal system may have multiple 
-- characteristics.
fun legalSystemType : El GeopoliticalArea -> El LegalSystemAttribute -> Formula ;


-- (legislativeBranch ?BRANCH ?ORG) means 
-- that the Organization ?BRANCH is the legislative branch of the 
-- GeopoliticalArea or Organization ?ORG.
fun legislativeBranch : El Organization -> El Agent -> Formula ;


-- (nationalCelebration ?AREA ?HOLIDAY) 
-- means that the primary day of national celebration in the 
-- GeopoliticalArea ?AREA is ?HOLIDAY. For example, (nationalCelebration 
-- Afghanistan AfghanIndependenceDay).
fun nationalCelebration: El GeopoliticalArea -> Desc Holiday -> Formula ;


-- (nationalHoliday ?AREA ?HOLIDAY) means 
-- that ?HOLIDAY is a national holiday observed in ?AREA. The 
-- GeopoliticalArea ?AREA observes a holiday on days specified as a 
-- ?HOLIDAY, during which national government offices and other facilities 
-- typically are closed. There may be multiple nationalHolidays. For 
-- example, (nationalHoliday UnitedStates UnitedStatesMemorialDay).
fun nationalHoliday: El GeopoliticalArea -> Desc Holiday -> Formula ;


-- (organizationalObjective ?AGENT 
-- ?FOCUS) means that the Agent ?AGENT has significant aims and 
-- concerns characterized by the AreaOfConcern ?FOCUS.
fun organizationalObjective : El Agent -> El AreaOfConcern -> Formula ;


-- (politicalPartyOfCountry ?PARTY 
-- ?AREA) means that the PoliticalParty ?PARTY participates in politics in 
-- the GeopoliticalArea ?AREA.
fun politicalPartyOfCountry : El PoliticalParty -> El GeopoliticalArea -> Formula ;


-- (primaryGeopoliticalSubdivision ?AREA ?COUNTRY) means that the 
-- GeopoliticalArea ?AREA is one of the first_order administrative 
-- divisions of the Nation ?COUNTRY. For example, in the United States, 
-- any of the fifty states. This does not include subordinate regions that 
-- have a lesser status, such as British Crown colonies, U.S. territories, 
-- or protectorates. See geopoliticalSubdivision.
fun primaryGeopoliticalSubdivision : El GeopoliticalArea -> El GeopoliticalArea -> Formula ;


-- (primaryGeopoliticalSubdivisionType ?COUNTRY ?TYPE) means that the 
-- first_order administrative divisons of ?COUNTRY are of the type ?TYPE.
fun primaryGeopoliticalSubdivisionType: El GeopoliticalArea -> Desc GeopoliticalArea -> Formula ;


-- representativeAgentToAgent ?SENDER ?REP ?RECEIVER) means that 
-- the Agent ?SENDER has the Agent ?REP as its representative 
-- to the Agent ?RECEIVER. ?REP works for ?SENDER and is not assumed 
-- to be an impartial mediator.
fun representativeAgentToAgent : El Agent -> El Agent -> El Agent -> Formula ;


-- (roleAppointsRole ?ORG ?APPOINTER 
-- ?APPOINTED) means that in the Organization or GeopoliticalArea ?ORG, 
-- the agent holding the SocialRole ?APPOINTER has the authority to 
-- appoint a person to fill the role ?APPOINTED.
fun roleAppointsRole : El Agent -> El SocialRole -> El SocialRole -> Formula ;


-- (roleApprovesRole ?ORG ?APPROVER 
-- ?APPOINTED) means that in the Organization or GeopoliticalArea ?ORG, 
-- the agent holding the SocialRole ?APPROVER has the authority to 
-- approve (or disapprove) of an appointee for the role ?APPOINTED.
fun roleApprovesRole : El Agent -> El SocialRole -> El SocialRole -> Formula ;


-- (roleNominatesRole ?ORG ?NOMINATOR 
-- ?NOMINATED) means that in the Organization or GeopoliticalArea ?ORG, 
-- the agent holding the SocialRole ?NOMINATOR has the authority to 
-- nominate one or more persons to fill the role ?NOMINATED.
fun roleNominatesRole : El Agent -> El SocialRole -> El SocialRole -> Formula ;


-- (seatsHeldInOrganization ?GROUP ?PARTY 
-- ?NUMBER) means that in the Organization ?GROUP, the PoliticalParty or other
-- Agent ?AGENT, holds or controls this ?NUMBER of seats.
fun seatsHeldInOrganization : El Organization -> El Agent -> El NonnegativeInteger -> Formula ;


-- (seatsInOrganizationCount ?ORG 
-- ?NUMBER) means that there is a total ?NUMBER of seats in the 
-- Organization ?ORG.
fun seatsInOrganizationCount : El Organization -> El Integer -> Formula ;


-- (seatsWonInElection ?ELECTION ?AGENT 
-- ?NUMBER) means that in the Election ?ELECTION, the PoliticalParty 
-- ?AGENT won this ?NUMBER of seats.
fun seatsWonInElection : El Election -> El Agent -> El Integer -> Formula ;


-- (successorOrganization ?OLD ?NEW) 
-- means that the Organization ?OLD was transformed or merged into, or 
-- otherwise succeeded by, the Organization ?NEW.
fun successorOrganization : El Organization -> El Organization -> Formula ;


-- (suffrageAgeMaximum ?POLITY ?AGE) 
-- means that in the Organization or GeopoliticalArea ?POLITY, a person 
-- must be ?AGE or younger in order to vote in the elections of ?POLITY.
fun suffrageAgeMaximum : El Agent -> El TimeDuration -> Formula ;


-- (suffrageAgeMinimum ?POLITY ?AGE) 
-- means that in the Organization or GeopoliticalArea ?POLITY, a person 
-- must be ?AGE or older in order to vote in the elections of ?POLITY.
fun suffrageAgeMinimum : El Agent -> El TimeDuration -> Formula ;


-- (termLength ?ORG ?ROLE ?LENGTH) means 
-- that in the Organization or GeopoliticalArea ?ORG, the term of office 
-- for the position ?ROLE is the TimeDuration ?LENGTH.
fun termLength : El Agent -> El SocialRole -> El TimeDuration -> Formula ;


-- (voteFractionReceived ?ELECTION 
-- ?POSITION ?CONTENDER ?FRACTION) means that in the Election ?ELECTION for 
-- ?POSITION, the Agent ?CONTENDER received ?FRACTION of the votes cast. 
-- Contenders may be either persons or political parties.
fun voteFractionReceived : El Election -> El SocialRole -> El Agent -> El RealNumber -> Formula ;
}
