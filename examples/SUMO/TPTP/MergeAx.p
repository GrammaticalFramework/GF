fof(axMerge0, axiom, 
 ( ! [X] : 
 (hasType(type_AbnormalAnatomicalStructure, X) => hasType(type_AnatomicalStructure, X)))).

fof(axMerge1, axiom, 
 ( ! [X] : 
 (hasType(type_Abstract, X) => hasType(type_Entity, X)))).

fof(axMerge2, axiom, 
 ( ! [X] : 
 (hasType(type_Adjective, X) => hasType(type_Word, X)))).

fof(axMerge3, axiom, 
 ( ! [X] : 
 (hasType(type_Adverb, X) => hasType(type_Word, X)))).

fof(axMerge4, axiom, 
 ( ! [X] : 
 (hasType(type_Advertising, X) => hasType(type_Disseminating, X)))).

fof(axMerge5, axiom, 
 ( ! [X] : 
 (hasType(type_AgeGroup, X) => hasType(type_GroupOfPeople, X)))).

fof(axMerge6, axiom, 
 ( ! [X] : 
 (hasType(type_Agent, X) => hasType(type_Object, X)))).

fof(axMerge7, axiom, 
 ( ! [X] : 
 (hasType(type_Air, X) => hasType(type_GasMixture, X)))).

fof(axMerge8, axiom, 
 ( ! [X] : 
 (hasType(type_AlethicAttribute, X) => hasType(type_ObjectiveNorm, X)))).

fof(axMerge9, axiom, 
 ( ! [X] : 
 (hasType(type_Alga, X) => hasType(type_NonFloweringPlant, X)))).

fof(axMerge10, axiom, 
 ( ! [X] : 
 (hasType(type_Ambulating, X) => hasType(type_BodyMotion, X)))).

fof(axMerge11, axiom, 
 ( ! [X] : 
 (hasType(type_Ambulating, X) => hasType(type_Translocation, X)))).

fof(axMerge12, axiom, 
 ( ! [X] : 
 (hasType(type_Amphibian, X) => hasType(type_ColdBloodedVertebrate, X)))).

fof(axMerge13, axiom, 
 ( ! [X] : 
 (hasType(type_AnatomicalStructure, X) => hasType(type_OrganicObject, X)))).

fof(axMerge14, axiom, 
 ( ! [X] : 
 (hasType(type_AngleMeasure, X) => hasType(type_ConstantQuantity, X)))).

fof(axMerge15, axiom, 
 ( ! [X] : 
 (hasType(type_AnimacyAttribute, X) => hasType(type_BiologicalAttribute, X)))).

fof(axMerge16, axiom, 
 ( ! [X] : 
 (hasType(type_AnimalAnatomicalStructure, X) => hasType(type_AnatomicalStructure, X)))).

fof(axMerge17, axiom, 
 ( ! [X] : 
 (hasType(type_AnimalLanguage, X) => hasType(type_Language, X)))).

fof(axMerge18, axiom, 
 ( ! [X] : 
 (hasType(type_AnimalSubstance, X) => hasType(type_BodySubstance, X)))).

fof(axMerge19, axiom, 
 ( ! [X] : 
 (hasType(type_Animal, X) => hasType(type_Organism, X)))).
 
fof(axMerge19_1, axiom, 
 (! [Var_ANIMAL] : 
 (((hasType(type_Organism, Var_ANIMAL)) & ( ((( ? [Var_SUBSTANCE] : 
 (hasType(type_AnimalSubstance, Var_SUBSTANCE) &  
(f_part(Var_SUBSTANCE,Var_ANIMAL))))) & (( ? [Var_STRUCTURE] : 
 (hasType(type_AnimalAnatomicalStructure, Var_STRUCTURE) &  
(f_part(Var_STRUCTURE,Var_ANIMAL)))))))) => (hasType(type_Animal, Var_ANIMAL))))).

fof(axMerge20, axiom, 
 ( ! [X] : 
 (hasType(type_AntiSymmetricPositionalAttribute, X) => hasType(type_PositionalAttribute, X)))).

fof(axMerge21, axiom, 
 ( ! [X] : 
 (hasType(type_Ape, X) => hasType(type_Primate, X)))).

fof(axMerge22, axiom, 
 ( ! [X] : 
 (hasType(type_April, X) => hasType(type_Month, X)))).

fof(axMerge23, axiom, 
 ( ! [X] : 
 (hasType(type_AquaticMammal, X) => hasType(type_Mammal, X)))).

fof(axMerge24, axiom, 
 ( ! [X] : 
 (hasType(type_Arachnid, X) => hasType(type_Arthropod, X)))).

fof(axMerge25, axiom, 
 ( ! [X] : 
 (hasType(type_AreaMeasure, X) => hasType(type_FunctionQuantity, X)))).

fof(axMerge26, axiom, 
 ( ! [X] : 
 (hasType(type_Argument, X) => hasType(type_Proposition, X)))).

fof(axMerge27, axiom, 
 ( ! [X] : 
 (hasType(type_ArtWork, X) => hasType(type_Artifact, X)))).

fof(axMerge28, axiom, 
 ( ! [X] : 
 (hasType(type_Arthropod, X) => hasType(type_Invertebrate, X)))).

fof(axMerge29, axiom, 
 ( ! [X] : 
 (hasType(type_Article, X) => hasType(type_Text, X)))).

fof(axMerge30, axiom, 
 ( ! [X] : 
 (hasType(type_Artifact, X) => hasType(type_CorpuscularObject, X)))).

fof(axMerge31, axiom, 
 ( ! [X] : 
 (hasType(type_ArtificialLanguage, X) => hasType(type_Language, X)))).

fof(axMerge32, axiom, 
 ( ! [X] : 
 (hasType(type_AsexualReproduction, X) => hasType(type_Replication, X)))).

fof(axMerge33, axiom, 
 ( ! [X] : 
 (hasType(type_AstronomicalBody, X) => hasType(type_Region, X)))).

fof(axMerge34, axiom, 
 ( ! [X] : 
 (hasType(type_Atom, X) => hasType(type_ElementalSubstance, X)))).

fof(axMerge35, axiom, 
 ( ! [X] : 
 (hasType(type_AtomicNucleus, X) => hasType(type_SubatomicParticle, X)))).

fof(axMerge36, axiom, 
 ( ! [X] : 
 (hasType(type_AttachingDevice, X) => hasType(type_Device, X)))).

fof(axMerge37, axiom, 
 ( ! [X] : 
 (hasType(type_Attaching, X) => hasType(type_DualObjectProcess, X)))).

fof(axMerge38, axiom, 
 ( ! [X] : 
 (hasType(type_Attack, X) => hasType(type_Maneuver, X)))).

fof(axMerge39, axiom, 
 ( ! [X] : 
 (hasType(type_Attribute, X) => hasType(type_Abstract, X)))).

fof(axMerge40, axiom, 
 ( ! [X] : 
 (hasType(type_August, X) => hasType(type_Month, X)))).

fof(axMerge41, axiom, 
 ( ! [X] : 
 (hasType(type_AutonomicProcess, X) => hasType(type_PhysiologicProcess, X)))).

fof(axMerge42, axiom, 
 ( ! [X] : 
 (hasType(type_Bacterium, X) => hasType(type_Microorganism, X)))).

fof(axMerge43, axiom, 
 ( ! [X] : 
 (hasType(type_Battle, X) => hasType(type_ViolentContest, X)))).

fof(axMerge44, axiom, 
 ( ! [X] : 
 (hasType(type_BeliefGroup, X) => hasType(type_GroupOfPeople, X)))).

fof(axMerge45, axiom, 
 ( ! [X] : 
 (hasType(type_Betting, X) => hasType(type_FinancialTransaction, X)))).

fof(axMerge46, axiom, 
 ( ! [X] : 
 (hasType(type_Beverage, X) => hasType(type_Food, X)))).

fof(axMerge47, axiom, 
 ( ! [X] : 
 (hasType(type_BinaryNumber, X) => hasType(type_RealNumber, X)))).

fof(axMerge48, axiom, 
 ( ! [X] : 
 (hasType(type_BiologicalAttribute, X) => hasType(type_InternalAttribute, X)))).

fof(axMerge49, axiom, 
 ( ! [X] : 
 (hasType(type_BiologicalProcess, X) => hasType(type_InternalChange, X)))).

fof(axMerge50, axiom, 
 ( ! [X] : 
 (hasType(type_BiologicallyActiveSubstance, X) => hasType(type_Substance, X)))).

fof(axMerge51, axiom, 
 ( ! [X] : 
 (hasType(type_Bird, X) => hasType(type_WarmBloodedVertebrate, X)))).

fof(axMerge52, axiom, 
 ( ! [X] : 
 (hasType(type_Birth, X) => hasType(type_OrganismProcess, X)))).

fof(axMerge53, axiom, 
 ( ! [X] : 
 (hasType(type_Blood, X) => hasType(type_BodySubstance, X)))).

fof(axMerge54, axiom, 
 ( ! [X] : 
 (hasType(type_BodyCavity, X) => hasType(type_BodyPart, X)))).

fof(axMerge55, axiom, 
 ( ! [X] : 
 (hasType(type_BodyCovering, X) => hasType(type_BodyPart, X)))).

fof(axMerge56, axiom, 
 ( ! [X] : 
 (hasType(type_BodyJunction, X) => hasType(type_BodyPart, X)))).

fof(axMerge57, axiom, 
 ( ! [X] : 
 (hasType(type_BodyMotion, X) => hasType(type_Motion, X)))).

fof(axMerge58, axiom, 
 ( ! [X] : 
 (hasType(type_BodyPart, X) => hasType(type_AnatomicalStructure, X)))).

fof(axMerge59, axiom, 
 ( ! [X] : 
 (hasType(type_BodyPosition, X) => hasType(type_BiologicalAttribute, X)))).

fof(axMerge60, axiom, 
 ( ! [X] : 
 (hasType(type_BodySubstance, X) => hasType(type_Substance, X)))).

fof(axMerge61, axiom, 
 ( ! [X] : 
 (hasType(type_BodyVessel, X) => hasType(type_BodyCavity, X)))).

fof(axMerge62, axiom, 
 ( ! [X] : 
 (hasType(type_Boiling, X) => hasType(type_StateChange, X)))).

fof(axMerge63, axiom, 
 ( ! [X] : 
 (hasType(type_Bone, X) => hasType(type_AnimalSubstance, X)))).

fof(axMerge64, axiom, 
 ( ! [X] : 
 (hasType(type_Bone, X) => hasType(type_Tissue, X)))).

fof(axMerge65, axiom, 
 ( ! [X] : 
 (hasType(type_Book, X) => hasType(type_Text, X)))).

fof(axMerge66, axiom, 
 ( ! [X] : 
 (hasType(type_Borrowing, X) => hasType(type_Getting, X)))).

fof(axMerge67, axiom, 
 ( ! [X] : 
 (hasType(type_Breathing, X) => hasType(type_AutonomicProcess, X)))).

fof(axMerge68, axiom, 
 ( ! [X] : 
 (hasType(type_Breathing, X) => hasType(type_OrganismProcess, X)))).

fof(axMerge69, axiom, 
 ( ! [X] : 
 (hasType(type_Building, X) => hasType(type_StationaryArtifact, X)))).

fof(axMerge70, axiom, 
 ( ! [X] : 
 (hasType(type_Buying, X) => hasType(type_FinancialTransaction, X)))).

fof(axMerge71, axiom, 
 ( ! [X] : 
 (hasType(type_Calculating, X) => hasType(type_IntentionalPsychologicalProcess, X)))).

fof(axMerge72, axiom, 
 ( ! [X] : 
 (hasType(type_Canine, X) => hasType(type_Carnivore, X)))).

fof(axMerge73, axiom, 
 ( ! [X] : 
 (hasType(type_Carbohydrate, X) => hasType(type_Nutrient, X)))).

fof(axMerge74, axiom, 
 ( ! [X] : 
 (hasType(type_Carnivore, X) => hasType(type_Mammal, X)))).

fof(axMerge75, axiom, 
 ( ! [X] : 
 (hasType(type_Carrying, X) => hasType(type_Transfer, X)))).

fof(axMerge76, axiom, 
 ( ! [X] : 
 (hasType(type_Cell, X) => hasType(type_BodyPart, X)))).

fof(axMerge77, axiom, 
 ( ! [X] : 
 (hasType(type_Certificate, X) => hasType(type_Text, X)))).

fof(axMerge78, axiom, 
 ( ! [X] : 
 (hasType(type_ChangeOfPossession, X) => hasType(type_SocialInteraction, X)))).

fof(axMerge79, axiom, 
 ( ! [X] : 
 (hasType(type_Character, X) => hasType(type_SymbolicString, X)))).

fof(axMerge80, axiom, 
 ( ! [X] : 
 (hasType(type_ChemicalDecomposition, X) => hasType(type_ChemicalProcess, X)))).

fof(axMerge81, axiom, 
 ( ! [X] : 
 (hasType(type_ChemicalDecomposition, X) => hasType(type_Separating, X)))).

fof(axMerge82, axiom, 
 ( ! [X] : 
 (hasType(type_ChemicalProcess, X) => hasType(type_InternalChange, X)))).

fof(axMerge83, axiom, 
 ( ! [X] : 
 (hasType(type_ChemicalSynthesis, X) => hasType(type_ChemicalProcess, X)))).

fof(axMerge84, axiom, 
 ( ! [X] : 
 (hasType(type_ChemicalSynthesis, X) => hasType(type_Combining, X)))).

fof(axMerge85, axiom, 
 ( ! [X] : 
 (hasType(type_Circle, X) => hasType(type_Oval, X)))).

fof(axMerge86, axiom, 
 ( ! [X] : 
 (hasType(type_City, X) => hasType(type_GeopoliticalArea, X)))).

fof(axMerge87, axiom, 
 ( ! [X] : 
 (hasType(type_City, X) => hasType(type_LandArea, X)))).

fof(axMerge88, axiom, 
 ( ! [X] : 
 (hasType(type_Classifying, X) => hasType(type_IntentionalPsychologicalProcess, X)))).

fof(axMerge89, axiom, 
 ( ! [X] : 
 (hasType(type_ClosedTwoDimensionalFigure, X) => hasType(type_TwoDimensionalFigure, X)))).

fof(axMerge90, axiom, 
 ( ! [X] : 
 (hasType(type_Clothing, X) => hasType(type_WearableItem, X)))).

fof(axMerge91, axiom, 
 ( ! [X] : 
 (hasType(type_Cloud, X) => hasType(type_GasMixture, X)))).

fof(axMerge92, axiom, 
 ( ! [X] : 
 (hasType(type_CognitiveAgent, X) => hasType(type_SentientAgent, X)))).

fof(axMerge93, axiom, 
 ( ! [X] : 
 (hasType(type_ColdBloodedVertebrate, X) => hasType(type_Vertebrate, X)))).

fof(axMerge94, axiom, 
 ( ! [X] : 
 (hasType(type_Collection, X) => hasType(type_Object, X)))).

fof(axMerge95, axiom, 
 ( ! [X] : 
 (hasType(type_ColorAttribute, X) => hasType(type_InternalAttribute, X)))).

fof(axMerge96, axiom, 
 ( ! [X] : 
 (hasType(type_Coloring, X) => hasType(type_SurfaceChange, X)))).

fof(axMerge97, axiom, 
 ( ! [X] : 
 (hasType(type_Combining, X) => hasType(type_DualObjectProcess, X)))).

fof(axMerge98, axiom, 
 ( ! [X] : 
 (hasType(type_Combustion, X) => hasType(type_ChemicalDecomposition, X)))).

fof(axMerge99, axiom, 
 ( ! [X] : 
 (hasType(type_CommercialAgent, X) => hasType(type_Agent, X)))).

fof(axMerge100, axiom, 
 ( ! [X] : 
 (hasType(type_CommercialService, X) => hasType(type_FinancialTransaction, X)))).

fof(axMerge101, axiom, 
 ( ! [X] : 
 (hasType(type_CommercialService, X) => hasType(type_ServiceProcess, X)))).

fof(axMerge102, axiom, 
 ( ! [X] : 
 (hasType(type_Committing, X) => hasType(type_LinguisticCommunication, X)))).

fof(axMerge103, axiom, 
 ( ! [X] : 
 (hasType(type_Communication, X) => hasType(type_ContentBearingProcess, X)))).

fof(axMerge104, axiom, 
 ( ! [X] : 
 (hasType(type_Communication, X) => hasType(type_SocialInteraction, X)))).

fof(axMerge105, axiom, 
 ( ! [X] : 
 (hasType(type_Comparing, X) => hasType(type_DualObjectProcess, X)))).

fof(axMerge106, axiom, 
 ( ! [X] : 
 (hasType(type_Comparing, X) => hasType(type_IntentionalPsychologicalProcess, X)))).

fof(axMerge107, axiom, 
 ( ! [X] : 
 (hasType(type_ComplexNumber, X) => hasType(type_Number, X)))).

fof(axMerge108, axiom, 
 ( ! [X] : 
 (hasType(type_CompositeUnitOfMeasure, X) => hasType(type_UnitOfMeasure, X)))).

fof(axMerge109, axiom, 
 ( ! [X] : 
 (hasType(type_CompoundSubstance, X) => hasType(type_PureSubstance, X)))).

fof(axMerge110, axiom, 
 ( ! [X] : 
 (hasType(type_ComputerLanguage, X) => hasType(type_ArtificialLanguage, X)))).

fof(axMerge111, axiom, 
 ( ! [X] : 
 (hasType(type_ComputerProgram, X) => hasType(type_Procedure, X)))).

fof(axMerge112, axiom, 
 ( ! [X] : 
 (hasType(type_ComputerProgramming, X) => hasType(type_ContentDevelopment, X)))).

fof(axMerge113, axiom, 
 ( ! [X] : 
 (hasType(type_Condensing, X) => hasType(type_StateChange, X)))).

fof(axMerge114, axiom, 
 ( ! [X] : 
 (hasType(type_Confining, X) => hasType(type_Keeping, X)))).

fof(axMerge115, axiom, 
 ( ! [X] : 
 (hasType(type_ConsciousnessAttribute, X) => hasType(type_StateOfMind, X)))).

fof(axMerge116, axiom, 
 ( ! [X] : 
 (hasType(type_ConstantQuantity, X) => hasType(type_PhysicalQuantity, X)))).

fof(axMerge117, axiom, 
 ( ! [X] : 
 (hasType(type_ConstructedLanguage, X) => hasType(type_ArtificialLanguage, X)))).

fof(axMerge118, axiom, 
 ( ! [X] : 
 (hasType(type_ConstructedLanguage, X) => hasType(type_HumanLanguage, X)))).

fof(axMerge119, axiom, 
 ( ! [X] : 
 (hasType(type_Constructing, X) => hasType(type_Making, X)))).

fof(axMerge120, axiom, 
 ( ! [X] : 
 (hasType(type_ContentBearingObject, X) => hasType(type_ContentBearingPhysical, X)))).

fof(axMerge121, axiom, 
 ( ! [X] : 
 (hasType(type_ContentBearingObject, X) => hasType(type_CorpuscularObject, X)))).

fof(axMerge122, axiom, 
 ( ! [X] : 
 (hasType(type_ContentBearingPhysical, X) => hasType(type_Physical, X)))).

fof(axMerge123, axiom, 
 ( ! [X] : 
 (hasType(type_ContentBearingProcess, X) => hasType(type_ContentBearingPhysical, X)))).

fof(axMerge124, axiom, 
 ( ! [X] : 
 (hasType(type_ContentDevelopment, X) => hasType(type_IntentionalProcess, X)))).

fof(axMerge125, axiom, 
 ( ! [X] : 
 (hasType(type_ContestAttribute, X) => hasType(type_ObjectiveNorm, X)))).

fof(axMerge126, axiom, 
 ( ! [X] : 
 (hasType(type_Contest, X) => hasType(type_SocialInteraction, X)))).

fof(axMerge127, axiom, 
 ( ! [X] : 
 (hasType(type_Continent, X) => hasType(type_LandArea, X)))).

fof(axMerge128, axiom, 
 ( ! [X] : 
 (hasType(type_Cooking, X) => hasType(type_Making, X)))).

fof(axMerge129, axiom, 
 ( ! [X] : 
 (hasType(type_Cooling, X) => hasType(type_Decreasing, X)))).

fof(axMerge130, axiom, 
 ( ! [X] : 
 (hasType(type_Cooperation, X) => hasType(type_SocialInteraction, X)))).

fof(axMerge131, axiom, 
 ( ! [X] : 
 (hasType(type_Corporation, X) => hasType(type_CommercialAgent, X)))).

fof(axMerge132, axiom, 
 ( ! [X] : 
 (hasType(type_Corporation, X) => hasType(type_Organization, X)))).

fof(axMerge133, axiom, 
 ( ! [X] : 
 (hasType(type_CorpuscularObject, X) => hasType(type_SelfConnectedObject, X)))).

fof(axMerge134, axiom, 
 ( ! [X] : 
 (hasType(type_Counting, X) => hasType(type_Calculating, X)))).

fof(axMerge135, axiom, 
 ( ! [X] : 
 (hasType(type_County, X) => hasType(type_GeopoliticalArea, X)))).

fof(axMerge136, axiom, 
 ( ! [X] : 
 (hasType(type_County, X) => hasType(type_LandArea, X)))).

fof(axMerge137, axiom, 
 ( ! [X] : 
 (hasType(type_Covering, X) => hasType(type_Putting, X)))).

fof(axMerge138, axiom, 
 ( ! [X] : 
 (hasType(type_Creation, X) => hasType(type_InternalChange, X)))).

fof(axMerge139, axiom, 
 ( ! [X] : 
 (hasType(type_Crustacean, X) => hasType(type_Arthropod, X)))).

fof(axMerge140, axiom, 
 ( ! [X] : 
 (hasType(type_CurrencyMeasure, X) => hasType(type_ConstantQuantity, X)))).

fof(axMerge141, axiom, 
 ( ! [X] : 
 (hasType(type_Currency, X) => hasType(type_FinancialInstrument, X)))).

fof(axMerge142, axiom, 
 ( ! [X] : 
 (hasType(type_Cutting, X) => hasType(type_Poking, X)))).

fof(axMerge143, axiom, 
 ( ! [X] : 
 (hasType(type_Damaging, X) => hasType(type_InternalChange, X)))).

fof(axMerge144, axiom, 
 ( ! [X] : 
 (hasType(type_Dancing, X) => hasType(type_BodyMotion, X)))).

fof(axMerge145, axiom, 
 ( ! [X] : 
 (hasType(type_Day, X) => hasType(type_TimeInterval, X)))).

fof(axMerge146, axiom, 
 ( ! [X] : 
 (hasType(type_Death, X) => hasType(type_OrganismProcess, X)))).

fof(axMerge147, axiom, 
 ( ! [X] : 
 (hasType(type_December, X) => hasType(type_Month, X)))).

fof(axMerge148, axiom, 
 ( ! [X] : 
 (hasType(type_Deciding, X) => hasType(type_Selecting, X)))).

fof(axMerge149, axiom, 
 ( ! [X] : 
 (hasType(type_Declaring, X) => hasType(type_LinguisticCommunication, X)))).

fof(axMerge150, axiom, 
 ( ! [X] : 
 (hasType(type_Decoding, X) => hasType(type_Writing, X)))).

fof(axMerge151, axiom, 
 ( ! [X] : 
 (hasType(type_Decreasing, X) => hasType(type_QuantityChange, X)))).

fof(axMerge152, axiom, 
 ( ! [X] : 
 (hasType(type_DeductiveArgument, X) => hasType(type_Argument, X)))).

fof(axMerge153, axiom, 
 ( ! [X] : 
 (hasType(type_DefensiveManeuver, X) => hasType(type_Maneuver, X)))).

fof(axMerge154, axiom, 
 ( ! [X] : 
 (hasType(type_Demonstrating, X) => hasType(type_Disseminating, X)))).

fof(axMerge155, axiom, 
 ( ! [X] : 
 (hasType(type_DeonticAttribute, X) => hasType(type_ObjectiveNorm, X)))).

fof(axMerge156, axiom, 
 ( ! [X] : 
 (hasType(type_Designing, X) => hasType(type_IntentionalPsychologicalProcess, X)))).

fof(axMerge157, axiom, 
 ( ! [X] : 
 (hasType(type_Destruction, X) => hasType(type_Damaging, X)))).

fof(axMerge158, axiom, 
 ( ! [X] : 
 (hasType(type_Detaching, X) => hasType(type_DualObjectProcess, X)))).

fof(axMerge159, axiom, 
 ( ! [X] : 
 (hasType(type_DevelopmentalAttribute, X) => hasType(type_BiologicalAttribute, X)))).

fof(axMerge160, axiom, 
 ( ! [X] : 
 (hasType(type_Device, X) => hasType(type_Artifact, X)))).

fof(axMerge161, axiom, 
 ( ! [X] : 
 (hasType(type_DiagnosticProcess, X) => hasType(type_Investigating, X)))).

fof(axMerge162, axiom, 
 ( ! [X] : 
 (hasType(type_Digesting, X) => hasType(type_AutonomicProcess, X)))).

fof(axMerge163, axiom, 
 ( ! [X] : 
 (hasType(type_Digesting, X) => hasType(type_OrganismProcess, X)))).

fof(axMerge164, axiom, 
 ( ! [X] : 
 (hasType(type_DirectedGraph, X) => hasType(type_Graph, X)))).

fof(axMerge165, axiom, 
 ( ! [X] : 
 (hasType(type_Directing, X) => hasType(type_LinguisticCommunication, X)))).

fof(axMerge166, axiom, 
 ( ! [X] : 
 (hasType(type_DirectionChange, X) => hasType(type_Motion, X)))).

fof(axMerge167, axiom, 
 ( ! [X] : 
 (hasType(type_DirectionalAttribute, X) => hasType(type_PositionalAttribute, X)))).

fof(axMerge168, axiom, 
 ( ! [X] : 
 (hasType(type_Disagreeing, X) => hasType(type_Stating, X)))).

fof(axMerge169, axiom, 
 ( ! [X] : 
 (hasType(type_Discovering, X) => hasType(type_IntentionalPsychologicalProcess, X)))).

fof(axMerge170, axiom, 
 ( ! [X] : 
 (hasType(type_DiseaseOrSyndrome, X) => hasType(type_BiologicalAttribute, X)))).

fof(axMerge171, axiom, 
 ( ! [X] : 
 (hasType(type_Disseminating, X) => hasType(type_Communication, X)))).

fof(axMerge172, axiom, 
 ( ! [X] : 
 (hasType(type_Drinking, X) => hasType(type_Ingesting, X)))).

fof(axMerge173, axiom, 
 ( ! [X] : 
 (hasType(type_Driving, X) => hasType(type_Guiding, X)))).

fof(axMerge174, axiom, 
 ( ! [X] : 
 (hasType(type_Drying, X) => hasType(type_Removing, X)))).

fof(axMerge175, axiom, 
 ( ! [X] : 
 (hasType(type_DualObjectProcess, X) => hasType(type_Process, X)))).

fof(axMerge176, axiom, 
 ( ! [X] : 
 (hasType(type_Eating, X) => hasType(type_Ingesting, X)))).

fof(axMerge177, axiom, 
 ( ! [X] : 
 (hasType(type_EducationalOrganization, X) => hasType(type_Organization, X)))).

fof(axMerge178, axiom, 
 ( ! [X] : 
 (hasType(type_EducationalProcess, X) => hasType(type_Guiding, X)))).

fof(axMerge179, axiom, 
 ( ! [X] : 
 (hasType(type_Egg, X) => hasType(type_AnimalAnatomicalStructure, X)))).

fof(axMerge180, axiom, 
 ( ! [X] : 
 (hasType(type_Egg, X) => hasType(type_ReproductiveBody, X)))).

fof(axMerge181, axiom, 
 ( ! [X] : 
 (hasType(type_Election, X) => hasType(type_OrganizationalProcess, X)))).

fof(axMerge182, axiom, 
 ( ! [X] : 
 (hasType(type_Electron, X) => hasType(type_SubatomicParticle, X)))).

fof(axMerge183, axiom, 
 ( ! [X] : 
 (hasType(type_ElementalSubstance, X) => hasType(type_PureSubstance, X)))).

fof(axMerge184, axiom, 
 ( ! [X] : 
 (hasType(type_EmotionalState, X) => hasType(type_StateOfMind, X)))).

fof(axMerge185, axiom, 
 ( ! [X] : 
 (hasType(type_Encoding, X) => hasType(type_Writing, X)))).

fof(axMerge186, axiom, 
 ( ! [X] : 
 (hasType(type_EngineeringComponent, X) => hasType(type_Device, X)))).

fof(axMerge187, axiom, 
 ( ! [X] : 
 (hasType(type_EngineeringConnection, X) => hasType(type_EngineeringComponent, X)))).

fof(axMerge188, axiom, 
 ( ! [X] : 
 (hasType(type_Enzyme, X) => hasType(type_Protein, X)))).

fof(axMerge189, axiom, 
 ( ! [X] : 
 (hasType(type_EthnicGroup, X) => hasType(type_GroupOfPeople, X)))).

fof(axMerge190, axiom, 
 ( ! [X] : 
 (hasType(type_Evaporating, X) => hasType(type_StateChange, X)))).

fof(axMerge191, axiom, 
 ( ! [X] : 
 (hasType(type_EvenInteger, X) => hasType(type_Integer, X)))).

fof(axMerge192, axiom, 
 ( ! [X] : 
 (hasType(type_Experimenting, X) => hasType(type_Investigating, X)))).

fof(axMerge193, axiom, 
 ( ! [X] : 
 (hasType(type_Explanation, X) => hasType(type_DeductiveArgument, X)))).

fof(axMerge194, axiom, 
 ( ! [X] : 
 (hasType(type_Expressing, X) => hasType(type_Communication, X)))).

fof(axMerge195, axiom, 
 ( ! [X] : 
 (hasType(type_Fabric, X) => hasType(type_Artifact, X)))).

fof(axMerge196, axiom, 
 ( ! [X] : 
 (hasType(type_FactualText, X) => hasType(type_Text, X)))).

fof(axMerge197, axiom, 
 ( ! [X] : 
 (hasType(type_Falling, X) => hasType(type_MotionDownward, X)))).

fof(axMerge198, axiom, 
 ( ! [X] : 
 (hasType(type_Falling, X) => hasType(type_Translocation, X)))).

fof(axMerge199, axiom, 
 ( ! [X] : 
 (hasType(type_FamilyGroup, X) => hasType(type_GroupOfPeople, X)))).

fof(axMerge200, axiom, 
 ( ! [X] : 
 (hasType(type_FatTissue, X) => hasType(type_Tissue, X)))).

fof(axMerge201, axiom, 
 ( ! [X] : 
 (hasType(type_February, X) => hasType(type_Month, X)))).

fof(axMerge202, axiom, 
 ( ! [X] : 
 (hasType(type_Feline, X) => hasType(type_Carnivore, X)))).

fof(axMerge203, axiom, 
 ( ! [X] : 
 (hasType(type_Fern, X) => hasType(type_NonFloweringPlant, X)))).

fof(axMerge204, axiom, 
 ( ! [X] : 
 (hasType(type_FictionalText, X) => hasType(type_Text, X)))).

fof(axMerge205, axiom, 
 ( ! [X] : 
 (hasType(type_FieldOfStudy, X) => hasType(type_Proposition, X)))).

fof(axMerge206, axiom, 
 ( ! [X] : 
 (hasType(type_FinancialInstrument, X) => hasType(type_Certificate, X)))).

fof(axMerge207, axiom, 
 ( ! [X] : 
 (hasType(type_FinancialTransaction, X) => hasType(type_Transaction, X)))).

fof(axMerge208, axiom, 
 ( ! [X] : 
 (hasType(type_FiniteSet, X) => hasType(type_Set, X)))).

fof(axMerge209, axiom, 
 ( ! [X] : 
 (hasType(type_Fish, X) => hasType(type_ColdBloodedVertebrate, X)))).

fof(axMerge210, axiom, 
 ( ! [X] : 
 (hasType(type_FloweringPlant, X) => hasType(type_Plant, X)))).

fof(axMerge211, axiom, 
 ( ! [X] : 
 (hasType(type_Food, X) => hasType(type_SelfConnectedObject, X)))).

fof(axMerge212, axiom, 
 ( ! [X] : 
 (hasType(type_Freezing, X) => hasType(type_StateChange, X)))).

fof(axMerge213, axiom, 
 ( ! [X] : 
 (hasType(type_FrequencyMeasure, X) => hasType(type_TimeDependentQuantity, X)))).

fof(axMerge214, axiom, 
 ( ! [X] : 
 (hasType(type_FreshWaterArea, X) => hasType(type_WaterArea, X)))).

fof(axMerge215, axiom, 
 ( ! [X] : 
 (hasType(type_Friday, X) => hasType(type_Day, X)))).

fof(axMerge216, axiom, 
 ( ! [X] : 
 (hasType(type_FruitOrVegetable, X) => hasType(type_PlantAnatomicalStructure, X)))).

fof(axMerge217, axiom, 
 ( ! [X] : 
 (hasType(type_FruitOrVegetable, X) => hasType(type_ReproductiveBody, X)))).

fof(axMerge218, axiom, 
 ( ! [X] : 
 (hasType(type_FunctionQuantity, X) => hasType(type_PhysicalQuantity, X)))).

fof(axMerge219, axiom, 
 ( ! [X] : 
 (hasType(type_Funding, X) => hasType(type_Giving, X)))).

fof(axMerge220, axiom, 
 ( ! [X] : 
 (hasType(type_Fungus, X) => hasType(type_Organism, X)))).

fof(axMerge221, axiom, 
 ( ! [X] : 
 (hasType(type_Game, X) => hasType(type_Contest, X)))).

fof(axMerge222, axiom, 
 ( ! [X] : 
 (hasType(type_Game, X) => hasType(type_RecreationOrExercise, X)))).

fof(axMerge223, axiom, 
 ( ! [X] : 
 (hasType(type_GasMixture, X) => hasType(type_Mixture, X)))).

fof(axMerge224, axiom, 
 ( ! [X] : 
 (hasType(type_GasMotion, X) => hasType(type_Motion, X)))).

fof(axMerge225, axiom, 
 ( ! [X] : 
 (hasType(type_GeographicArea, X) => hasType(type_Region, X)))).

fof(axMerge226, axiom, 
 ( ! [X] : 
 (hasType(type_GeologicalProcess, X) => hasType(type_InternalChange, X)))).

fof(axMerge227, axiom, 
 ( ! [X] : 
 (hasType(type_GeologicalProcess, X) => hasType(type_Motion, X)))).

fof(axMerge228, axiom, 
 ( ! [X] : 
 (hasType(type_GeometricFigure, X) => hasType(type_ShapeAttribute, X)))).

fof(axMerge229, axiom, 
 ( ! [X] : 
 (hasType(type_GeometricPoint, X) => hasType(type_GeometricFigure, X)))).

fof(axMerge230, axiom, 
 ( ! [X] : 
 (hasType(type_GeopoliticalArea, X) => hasType(type_Agent, X)))).

fof(axMerge231, axiom, 
 ( ! [X] : 
 (hasType(type_GeopoliticalArea, X) => hasType(type_GeographicArea, X)))).

fof(axMerge232, axiom, 
 ( ! [X] : 
 (hasType(type_Gesture, X) => hasType(type_BodyMotion, X)))).

fof(axMerge233, axiom, 
 ( ! [X] : 
 (hasType(type_Gesture, X) => hasType(type_Communication, X)))).

fof(axMerge234, axiom, 
 ( ! [X] : 
 (hasType(type_Getting, X) => hasType(type_ChangeOfPossession, X)))).

fof(axMerge235, axiom, 
 ( ! [X] : 
 (hasType(type_GivingBack, X) => hasType(type_Giving, X)))).

fof(axMerge236, axiom, 
 ( ! [X] : 
 (hasType(type_Giving, X) => hasType(type_ChangeOfPossession, X)))).

fof(axMerge237, axiom, 
 ( ! [X] : 
 (hasType(type_Gland, X) => hasType(type_Organ, X)))).

fof(axMerge238, axiom, 
 ( ! [X] : 
 (hasType(type_GovernmentOrganization, X) => hasType(type_Organization, X)))).

fof(axMerge239, axiom, 
 ( ! [X] : 
 (hasType(type_Government, X) => hasType(type_GovernmentOrganization, X)))).

fof(axMerge240, axiom, 
 ( ! [X] : 
 (hasType(type_Grabbing, X) => hasType(type_Attaching, X)))).

fof(axMerge241, axiom, 
 ( ! [X] : 
 (hasType(type_Grabbing, X) => hasType(type_Touching, X)))).

fof(axMerge242, axiom, 
 ( ! [X] : 
 (hasType(type_Graduation, X) => hasType(type_LeavingAnOrganization, X)))).

fof(axMerge243, axiom, 
 ( ! [X] : 
 (hasType(type_GraphArc, X) => hasType(type_GraphElement, X)))).

fof(axMerge244, axiom, 
 ( ! [X] : 
 (hasType(type_GraphCircuit, X) => hasType(type_GraphPath, X)))).

fof(axMerge245, axiom, 
 ( ! [X] : 
 (hasType(type_GraphElement, X) => hasType(type_Abstract, X)))).

fof(axMerge246, axiom, 
 ( ! [X] : 
 (hasType(type_GraphLoop, X) => hasType(type_GraphArc, X)))).

fof(axMerge247, axiom, 
 ( ! [X] : 
 (hasType(type_GraphNode, X) => hasType(type_GraphElement, X)))).

fof(axMerge248, axiom, 
 ( ! [X] : 
 (hasType(type_GraphPath, X) => hasType(type_DirectedGraph, X)))).

fof(axMerge249, axiom, 
 ( ! [X] : 
 (hasType(type_Graph, X) => hasType(type_Abstract, X)))).

fof(axMerge250, axiom, 
 ( ! [X] : 
 (hasType(type_GroupOfPeople, X) => hasType(type_Group, X)))).

fof(axMerge251, axiom, 
 ( ! [X] : 
 (hasType(type_Group, X) => hasType(type_Agent, X)))).

fof(axMerge252, axiom, 
 ( ! [X] : 
 (hasType(type_Group, X) => hasType(type_Collection, X)))).

fof(axMerge253, axiom, 
 ( ! [X] : 
 (hasType(type_Growth, X) => hasType(type_AutonomicProcess, X)))).

fof(axMerge254, axiom, 
 ( ! [X] : 
 (hasType(type_Guiding, X) => hasType(type_IntentionalProcess, X)))).

fof(axMerge255, axiom, 
 ( ! [X] : 
 (hasType(type_Hearing, X) => hasType(type_Perception, X)))).

fof(axMerge256, axiom, 
 ( ! [X] : 
 (hasType(type_Heating, X) => hasType(type_Increasing, X)))).

fof(axMerge257, axiom, 
 ( ! [X] : 
 (hasType(type_Hiring, X) => hasType(type_JoiningAnOrganization, X)))).

fof(axMerge258, axiom, 
 ( ! [X] : 
 (hasType(type_Hole, X) => hasType(type_Region, X)))).

fof(axMerge259, axiom, 
 ( ! [X] : 
 (hasType(type_Hominid, X) => hasType(type_Primate, X)))).

fof(axMerge260, axiom, 
 ( ! [X] : 
 (hasType(type_HoofedMammal, X) => hasType(type_Mammal, X)))).

fof(axMerge261, axiom, 
 ( ! [X] : 
 (hasType(type_Hormone, X) => hasType(type_BiologicallyActiveSubstance, X)))).

fof(axMerge262, axiom, 
 ( ! [X] : 
 (hasType(type_Hormone, X) => hasType(type_BodySubstance, X)))).

fof(axMerge263, axiom, 
 ( ! [X] : 
 (hasType(type_Hour, X) => hasType(type_TimeInterval, X)))).

fof(axMerge264, axiom, 
 ( ! [X] : 
 (hasType(type_House, X) => hasType(type_ResidentialBuilding, X)))).

fof(axMerge265, axiom, 
 ( ! [X] : 
 (hasType(type_House, X) => hasType(type_SingleFamilyResidence, X)))).

fof(axMerge266, axiom, 
 ( ! [X] : 
 (hasType(type_HumanLanguage, X) => hasType(type_Language, X)))).

fof(axMerge267, axiom, 
 ( ! [X] : 
 (hasType(type_Human, X) => hasType(type_CognitiveAgent, X)))).

fof(axMerge268, axiom, 
 ( ! [X] : 
 (hasType(type_Human, X) => hasType(type_Hominid, X)))).

fof(axMerge269, axiom, 
 ( ! [X] : 
 (hasType(type_Hunting, X) => hasType(type_Pursuing, X)))).

fof(axMerge270, axiom, 
 ( ! [X] : 
 (hasType(type_Icon, X) => hasType(type_ContentBearingPhysical, X)))).

fof(axMerge271, axiom, 
 ( ! [X] : 
 (hasType(type_ImaginaryNumber, X) => hasType(type_Number, X)))).

fof(axMerge272, axiom, 
 ( ! [X] : 
 (hasType(type_Impacting, X) => hasType(type_Touching, X)))).

fof(axMerge273, axiom, 
 ( ! [X] : 
 (hasType(type_Impelling, X) => hasType(type_Transfer, X)))).

fof(axMerge274, axiom, 
 ( ! [X] : 
 (hasType(type_Increasing, X) => hasType(type_QuantityChange, X)))).

fof(axMerge275, axiom, 
 ( ! [X] : 
 (hasType(type_InductiveArgument, X) => hasType(type_Argument, X)))).

fof(axMerge276, axiom, 
 ( ! [X] : 
 (hasType(type_InformationMeasure, X) => hasType(type_ConstantQuantity, X)))).

fof(axMerge277, axiom, 
 ( ! [X] : 
 (hasType(type_Ingesting, X) => hasType(type_OrganismProcess, X)))).

fof(axMerge278, axiom, 
 ( ! [X] : 
 (hasType(type_Injecting, X) => hasType(type_Inserting, X)))).

fof(axMerge279, axiom, 
 ( ! [X] : 
 (hasType(type_Injuring, X) => hasType(type_Damaging, X)))).
fof(axMerge279_1, axiom, 
 (! [Var_INJ] : 
 (((hasType(type_Damaging, Var_INJ)) & ( ( ? [Var_ORGANISM] : 
 (hasType(type_Organism, Var_ORGANISM) &  
(f_patient(Var_INJ,Var_ORGANISM)))))) => (hasType(type_Injuring, Var_INJ))))).

fof(axMerge280, axiom, 
 ( ! [X] : 
 (hasType(type_Injuring, X) => hasType(type_PathologicProcess, X)))).

fof(axMerge281, axiom, 
 ( ! [X] : 
 (hasType(type_Insect, X) => hasType(type_Arthropod, X)))).

fof(axMerge282, axiom, 
 ( ! [X] : 
 (hasType(type_Inserting, X) => hasType(type_Putting, X)))).

fof(axMerge283, axiom, 
 ( ! [X] : 
 (hasType(type_Integer, X) => hasType(type_RationalNumber, X)))).

fof(axMerge284, axiom, 
 ( ! [X] : 
 (hasType(type_IntentionalProcess, X) => hasType(type_Process, X)))).

fof(axMerge285, axiom, 
 ( ! [X] : 
 (hasType(type_IntentionalPsychologicalProcess, X) => hasType(type_IntentionalProcess, X)))).

fof(axMerge286, axiom, 
 ( ! [X] : 
 (hasType(type_IntentionalPsychologicalProcess, X) => hasType(type_PsychologicalProcess, X)))).

fof(axMerge287, axiom, 
 ( ! [X] : 
 (hasType(type_InternalAttribute, X) => hasType(type_Attribute, X)))).

fof(axMerge288, axiom, 
 ( ! [X] : 
 (hasType(type_InternalChange, X) => hasType(type_Process, X)))).

fof(axMerge289, axiom, 
 ( ! [X] : 
 (hasType(type_Interpreting, X) => hasType(type_IntentionalPsychologicalProcess, X)))).

fof(axMerge290, axiom, 
 ( ! [X] : 
 (hasType(type_InvalidDeductiveArgument, X) => hasType(type_DeductiveArgument, X)))).

fof(axMerge291, axiom, 
 ( ! [X] : 
 (hasType(type_Invertebrate, X) => hasType(type_Animal, X)))).

fof(axMerge292, axiom, 
 ( ! [X] : 
 (hasType(type_Investigating, X) => hasType(type_IntentionalPsychologicalProcess, X)))).

fof(axMerge293, axiom, 
 ( ! [X] : 
 (hasType(type_IrrationalNumber, X) => hasType(type_RealNumber, X)))).

fof(axMerge294, axiom, 
 ( ! [X] : 
 (hasType(type_Island, X) => hasType(type_LandArea, X)))).

fof(axMerge295, axiom, 
 ( ! [X] : 
 (hasType(type_January, X) => hasType(type_Month, X)))).

fof(axMerge296, axiom, 
 ( ! [X] : 
 (hasType(type_JoiningAnOrganization, X) => hasType(type_OrganizationalProcess, X)))).

fof(axMerge297, axiom, 
 ( ! [X] : 
 (hasType(type_Judging, X) => hasType(type_Selecting, X)))).

fof(axMerge298, axiom, 
 ( ! [X] : 
 (hasType(type_JudicialOrganization, X) => hasType(type_Organization, X)))).

fof(axMerge299, axiom, 
 ( ! [X] : 
 (hasType(type_JudicialProcess, X) => hasType(type_PoliticalProcess, X)))).
fof(axMerge299_1, axiom, 
 (! [Var_PROCESS] : 
 (((hasType(type_PoliticalProcess, Var_PROCESS)) & ( ( ? [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) &  
(f_agent(Var_PROCESS,Var_ORG)))))) => (hasType(type_JudicialProcess, Var_PROCESS))))).

fof(axMerge300, axiom, 
 ( ! [X] : 
 (hasType(type_July, X) => hasType(type_Month, X)))).

fof(axMerge301, axiom, 
 ( ! [X] : 
 (hasType(type_June, X) => hasType(type_Month, X)))).

fof(axMerge302, axiom, 
 ( ! [X] : 
 (hasType(type_Keeping, X) => hasType(type_IntentionalProcess, X)))).

fof(axMerge303, axiom, 
 ( ! [X] : 
 (hasType(type_Killing, X) => hasType(type_Destruction, X)))).

fof(axMerge304, axiom, 
 ( ! [X] : 
 (hasType(type_LandArea, X) => hasType(type_GeographicArea, X)))).

fof(axMerge305, axiom, 
 ( ! [X] : 
 (hasType(type_LandTransitway, X) => hasType(type_LandArea, X)))).

fof(axMerge306, axiom, 
 ( ! [X] : 
 (hasType(type_LandTransitway, X) => hasType(type_Transitway, X)))).

fof(axMerge307, axiom, 
 ( ! [X] : 
 (hasType(type_Language, X) => hasType(type_LinguisticExpression, X)))).

fof(axMerge308, axiom, 
 ( ! [X] : 
 (hasType(type_LeapYear, X) => hasType(type_Year, X)))).

fof(axMerge309, axiom, 
 ( ! [X] : 
 (hasType(type_Learning, X) => hasType(type_IntentionalPsychologicalProcess, X)))).

fof(axMerge310, axiom, 
 ( ! [X] : 
 (hasType(type_LeavingAnOrganization, X) => hasType(type_OrganizationalProcess, X)))).

fof(axMerge311, axiom, 
 ( ! [X] : 
 (hasType(type_LegalAction, X) => hasType(type_Contest, X)))).

fof(axMerge312, axiom, 
 ( ! [X] : 
 (hasType(type_LegalDecision, X) => hasType(type_Declaring, X)))).

fof(axMerge313, axiom, 
 ( ! [X] : 
 (hasType(type_LegalDecision, X) => hasType(type_JudicialProcess, X)))).

fof(axMerge314, axiom, 
 ( ! [X] : 
 (hasType(type_Lending, X) => hasType(type_Giving, X)))).

fof(axMerge315, axiom, 
 ( ! [X] : 
 (hasType(type_LengthMeasure, X) => hasType(type_ConstantQuantity, X)))).

fof(axMerge316, axiom, 
 ( ! [X] : 
 (hasType(type_LinguisticCommunication, X) => hasType(type_Communication, X)))).

fof(axMerge317, axiom, 
 ( ! [X] : 
 (hasType(type_LinguisticExpression, X) => hasType(type_ContentBearingPhysical, X)))).

fof(axMerge318, axiom, 
 ( ! [X] : 
 (hasType(type_LiquidMixture, X) => hasType(type_Mixture, X)))).

fof(axMerge319, axiom, 
 ( ! [X] : 
 (hasType(type_LiquidMotion, X) => hasType(type_Motion, X)))).

fof(axMerge320, axiom, 
 ( ! [X] : 
 (hasType(type_Listening, X) => hasType(type_Hearing, X)))).

fof(axMerge321, axiom, 
 ( ! [X] : 
 (hasType(type_Listening, X) => hasType(type_IntentionalProcess, X)))).

fof(axMerge322, axiom, 
 ( ! [X] : 
 (hasType(type_Looking, X) => hasType(type_IntentionalProcess, X)))).

fof(axMerge323, axiom, 
 ( ! [X] : 
 (hasType(type_Looking, X) => hasType(type_Seeing, X)))).

fof(axMerge324, axiom, 
 ( ! [X] : 
 (hasType(type_Machine, X) => hasType(type_Device, X)))).

fof(axMerge325, axiom, 
 ( ! [X] : 
 (hasType(type_Maintaining, X) => hasType(type_IntentionalProcess, X)))).

fof(axMerge326, axiom, 
 ( ! [X] : 
 (hasType(type_Making, X) => hasType(type_Creation, X)))).

fof(axMerge327, axiom, 
 ( ! [X] : 
 (hasType(type_Making, X) => hasType(type_IntentionalProcess, X)))).

fof(axMerge328, axiom, 
 ( ! [X] : 
 (hasType(type_Mammal, X) => hasType(type_WarmBloodedVertebrate, X)))).

fof(axMerge329, axiom, 
 ( ! [X] : 
 (hasType(type_Man, X) => hasType(type_Human, X)))).

fof(axMerge330, axiom, 
 ( ! [X] : 
 (hasType(type_Managing, X) => hasType(type_Guiding, X)))).

fof(axMerge331, axiom, 
 ( ! [X] : 
 (hasType(type_Managing, X) => hasType(type_OrganizationalProcess, X)))).

fof(axMerge332, axiom, 
 ( ! [X] : 
 (hasType(type_Maneuver, X) => hasType(type_IntentionalProcess, X)))).

fof(axMerge333, axiom, 
 ( ! [X] : 
 (hasType(type_ManualHumanLanguage, X) => hasType(type_HumanLanguage, X)))).

fof(axMerge334, axiom, 
 ( ! [X] : 
 (hasType(type_Manufacture, X) => hasType(type_Making, X)))).

fof(axMerge335, axiom, 
 ( ! [X] : 
 (hasType(type_Manufacturer, X) => hasType(type_Corporation, X)))).

fof(axMerge336, axiom, 
 ( ! [X] : 
 (hasType(type_March, X) => hasType(type_Month, X)))).

fof(axMerge337, axiom, 
 ( ! [X] : 
 (hasType(type_Marsupial, X) => hasType(type_Mammal, X)))).

fof(axMerge338, axiom, 
 ( ! [X] : 
 (hasType(type_MassMeasure, X) => hasType(type_ConstantQuantity, X)))).

fof(axMerge339, axiom, 
 ( ! [X] : 
 (hasType(type_Matriculation, X) => hasType(type_JoiningAnOrganization, X)))).

fof(axMerge340, axiom, 
 ( ! [X] : 
 (hasType(type_May, X) => hasType(type_Month, X)))).

fof(axMerge341, axiom, 
 ( ! [X] : 
 (hasType(type_MeasuringDevice, X) => hasType(type_Device, X)))).

fof(axMerge342, axiom, 
 ( ! [X] : 
 (hasType(type_Measuring, X) => hasType(type_Calculating, X)))).

fof(axMerge343, axiom, 
 ( ! [X] : 
 (hasType(type_Meat, X) => hasType(type_Food, X)))).

fof(axMerge344, axiom, 
 ( ! [X] : 
 (hasType(type_Meeting, X) => hasType(type_SocialInteraction, X)))).

fof(axMerge345, axiom, 
 ( ! [X] : 
 (hasType(type_Melting, X) => hasType(type_StateChange, X)))).

fof(axMerge346, axiom, 
 ( ! [X] : 
 (hasType(type_MercantileOrganization, X) => hasType(type_Corporation, X)))).

fof(axMerge347, axiom, 
 ( ! [X] : 
 (hasType(type_Metal, X) => hasType(type_ElementalSubstance, X)))).

fof(axMerge348, axiom, 
 ( ! [X] : 
 (hasType(type_Microorganism, X) => hasType(type_Organism, X)))).

fof(axMerge349, axiom, 
 ( ! [X] : 
 (hasType(type_MilitaryForce, X) => hasType(type_PoliticalOrganization, X)))).

fof(axMerge350, axiom, 
 ( ! [X] : 
 (hasType(type_MilitaryOrganization, X) => hasType(type_GovernmentOrganization, X)))).

fof(axMerge351, axiom, 
 ( ! [X] : 
 (hasType(type_MilitaryOrganization, X) => hasType(type_MilitaryForce, X)))).

fof(axMerge352, axiom, 
 ( ! [X] : 
 (hasType(type_MilitaryProcess, X) => hasType(type_PoliticalProcess, X)))).

fof(axMerge353, axiom, 
 ( ! [X] : 
 (hasType(type_Mineral, X) => hasType(type_Substance, X)))).

fof(axMerge354, axiom, 
 ( ! [X] : 
 (hasType(type_Minute, X) => hasType(type_TimeInterval, X)))).

fof(axMerge355, axiom, 
 ( ! [X] : 
 (hasType(type_Mixture, X) => hasType(type_Substance, X)))).

fof(axMerge356, axiom, 
 ( ! [X] : 
 (hasType(type_Molecule, X) => hasType(type_CompoundSubstance, X)))).

fof(axMerge357, axiom, 
 ( ! [X] : 
 (hasType(type_Mollusk, X) => hasType(type_Invertebrate, X)))).

fof(axMerge358, axiom, 
 ( ! [X] : 
 (hasType(type_Monday, X) => hasType(type_Day, X)))).

fof(axMerge359, axiom, 
 ( ! [X] : 
 (hasType(type_Monkey, X) => hasType(type_Primate, X)))).

fof(axMerge360, axiom, 
 ( ! [X] : 
 (hasType(type_Month, X) => hasType(type_TimeInterval, X)))).

fof(axMerge361, axiom, 
 ( ! [X] : 
 (hasType(type_Morpheme, X) => hasType(type_LinguisticExpression, X)))).

fof(axMerge362, axiom, 
 ( ! [X] : 
 (hasType(type_Moss, X) => hasType(type_NonFloweringPlant, X)))).

fof(axMerge363, axiom, 
 ( ! [X] : 
 (hasType(type_MotionDownward, X) => hasType(type_Motion, X)))).

fof(axMerge364, axiom, 
 ( ! [X] : 
 (hasType(type_MotionPicture, X) => hasType(type_Text, X)))).

fof(axMerge365, axiom, 
 ( ! [X] : 
 (hasType(type_MotionUpward, X) => hasType(type_Motion, X)))).

fof(axMerge366, axiom, 
 ( ! [X] : 
 (hasType(type_Motion, X) => hasType(type_Process, X)))).

fof(axMerge367, axiom, 
 ( ! [X] : 
 (hasType(type_MultiGraph, X) => hasType(type_Graph, X)))).

fof(axMerge368, axiom, 
 ( ! [X] : 
 (hasType(type_Muscle, X) => hasType(type_AnimalSubstance, X)))).

fof(axMerge369, axiom, 
 ( ! [X] : 
 (hasType(type_Muscle, X) => hasType(type_Tissue, X)))).

fof(axMerge370, axiom, 
 ( ! [X] : 
 (hasType(type_Music, X) => hasType(type_RadiatingSound, X)))).

fof(axMerge371, axiom, 
 ( ! [X] : 
 (hasType(type_MusicalInstrument, X) => hasType(type_Device, X)))).

fof(axMerge372, axiom, 
 ( ! [X] : 
 (hasType(type_MutuallyDisjointClass, X) => hasType(type_SetOrClass, X)))).

fof(axMerge373, axiom, 
 ( ! [X] : 
 (hasType(type_Myriapod, X) => hasType(type_Arthropod, X)))).

fof(axMerge374, axiom, 
 ( ! [X] : 
 (hasType(type_Naming, X) => hasType(type_Declaring, X)))).

fof(axMerge375, axiom, 
 ( ! [X] : 
 (hasType(type_Nation, X) => hasType(type_GeopoliticalArea, X)))).

fof(axMerge376, axiom, 
 ( ! [X] : 
 (hasType(type_Nation, X) => hasType(type_LandArea, X)))).

fof(axMerge377, axiom, 
 ( ! [X] : 
 (hasType(type_NaturalLanguage, X) => hasType(type_HumanLanguage, X)))).

fof(axMerge378, axiom, 
 ( ! [X] : 
 (hasType(type_NaturalProcess, X) => hasType(type_Process, X)))).

fof(axMerge379, axiom, 
 ( ! [X] : 
 (hasType(type_NaturalSubstance, X) => hasType(type_Substance, X)))).

fof(axMerge380, axiom, 
 ( ! [X] : 
 (hasType(type_NegativeInteger, X) => hasType(type_Integer, X)))).

fof(axMerge381, axiom, 
 ( ! [X] : 
 (hasType(type_NegativeInteger, X) => hasType(type_NegativeRealNumber, X)))).

fof(axMerge382, axiom, 
 ( ! [X] : 
 (hasType(type_NegativeRealNumber, X) => hasType(type_RealNumber, X)))).
fof(axMerge382_1, axiom, 
 (! [Var_NUMBER] : 
 (((hasType(type_RealNumber, Var_NUMBER)) & ( f_lessThan(Var_NUMBER,0))) => (hasType(type_NegativeRealNumber, Var_NUMBER))))).

fof(axMerge383, axiom, 
 ( ! [X] : 
 (hasType(type_Neutron, X) => hasType(type_SubatomicParticle, X)))).

fof(axMerge384, axiom, 
 ( ! [X] : 
 (hasType(type_NonCompositeUnitOfMeasure, X) => hasType(type_UnitOfMeasure, X)))).

fof(axMerge385, axiom, 
 ( ! [X] : 
 (hasType(type_NonFloweringPlant, X) => hasType(type_Plant, X)))).

fof(axMerge386, axiom, 
 ( ! [X] : 
 (hasType(type_NonNullSet, X) => hasType(type_SetOrClass, X)))).

fof(axMerge387, axiom, 
 ( ! [X] : 
 (hasType(type_NonnegativeInteger, X) => hasType(type_Integer, X)))).

fof(axMerge388, axiom, 
 ( ! [X] : 
 (hasType(type_NonnegativeInteger, X) => hasType(type_NonnegativeRealNumber, X)))).

fof(axMerge389, axiom, 
 ( ! [X] : 
 (hasType(type_NonnegativeRealNumber, X) => hasType(type_RealNumber, X)))).
fof(axMerge389_1, axiom, 
 (! [Var_NUMBER] : 
 (((hasType(type_RealNumber, Var_NUMBER)) & ( f_greaterThanOrEqualTo(Var_NUMBER,0))) => (hasType(type_NonnegativeRealNumber, Var_NUMBER))))).

fof(axMerge390, axiom, 
 ( ! [X] : 
 (hasType(type_NormativeAttribute, X) => hasType(type_RelationalAttribute, X)))).

fof(axMerge391, axiom, 
 ( ! [X] : 
 (hasType(type_NounPhrase, X) => hasType(type_Phrase, X)))).

fof(axMerge392, axiom, 
 ( ! [X] : 
 (hasType(type_Noun, X) => hasType(type_Word, X)))).

fof(axMerge393, axiom, 
 ( ! [X] : 
 (hasType(type_November, X) => hasType(type_Month, X)))).

fof(axMerge394, axiom, 
 ( ! [X] : 
 (hasType(type_NullSet, X) => hasType(type_SetOrClass, X)))).

fof(axMerge395, axiom, 
 ( ! [X] : 
 (hasType(type_Number, X) => hasType(type_Quantity, X)))).

fof(axMerge396, axiom, 
 ( ! [X] : 
 (hasType(type_Nutrient, X) => hasType(type_BiologicallyActiveSubstance, X)))).

fof(axMerge397, axiom, 
 ( ! [X] : 
 (hasType(type_Object, X) => hasType(type_Physical, X)))).

fof(axMerge398, axiom, 
 ( ! [X] : 
 (hasType(type_ObjectiveNorm, X) => hasType(type_NormativeAttribute, X)))).

fof(axMerge399, axiom, 
 ( ! [X] : 
 (hasType(type_October, X) => hasType(type_Month, X)))).

fof(axMerge400, axiom, 
 ( ! [X] : 
 (hasType(type_OddInteger, X) => hasType(type_Integer, X)))).

fof(axMerge401, axiom, 
 ( ! [X] : 
 (hasType(type_Offering, X) => hasType(type_Committing, X)))).

fof(axMerge402, axiom, 
 ( ! [X] : 
 (hasType(type_OlfactoryAttribute, X) => hasType(type_PerceptualAttribute, X)))).

fof(axMerge403, axiom, 
 ( ! [X] : 
 (hasType(type_OneDimensionalFigure, X) => hasType(type_GeometricFigure, X)))).

fof(axMerge404, axiom, 
 ( ! [X] : 
 (hasType(type_OpenTwoDimensionalFigure, X) => hasType(type_TwoDimensionalFigure, X)))).

fof(axMerge405, axiom, 
 ( ! [X] : 
 (hasType(type_Ordering, X) => hasType(type_Directing, X)))).

fof(axMerge406, axiom, 
 ( ! [X] : 
 (hasType(type_OrganOrTissueProcess, X) => hasType(type_AutonomicProcess, X)))).

fof(axMerge407, axiom, 
 ( ! [X] : 
 (hasType(type_Organ, X) => hasType(type_BodyPart, X)))).

fof(axMerge408, axiom, 
 ( ! [X] : 
 (hasType(type_OrganicObject, X) => hasType(type_CorpuscularObject, X)))).

fof(axMerge409, axiom, 
 ( ! [X] : 
 (hasType(type_OrganismProcess, X) => hasType(type_PhysiologicProcess, X)))).

fof(axMerge410, axiom, 
 ( ! [X] : 
 (hasType(type_Organism, X) => hasType(type_Agent, X)))).

fof(axMerge411, axiom, 
 ( ! [X] : 
 (hasType(type_Organism, X) => hasType(type_OrganicObject, X)))).

fof(axMerge412, axiom, 
 ( ! [X] : 
 (hasType(type_Organization, X) => hasType(type_CognitiveAgent, X)))).

fof(axMerge413, axiom, 
 ( ! [X] : 
 (hasType(type_Organization, X) => hasType(type_Group, X)))).

fof(axMerge414, axiom, 
 ( ! [X] : 
 (hasType(type_OrganizationalProcess, X) => hasType(type_IntentionalProcess, X)))).

fof(axMerge415, axiom, 
 ( ! [X] : 
 (hasType(type_Oval, X) => hasType(type_ClosedTwoDimensionalFigure, X)))).

fof(axMerge416, axiom, 
 ( ! [X] : 
 (hasType(type_PairwiseDisjointClass, X) => hasType(type_SetOrClass, X)))).

fof(axMerge417, axiom, 
 ( ! [X] : 
 (hasType(type_ParamilitaryOrganization, X) => hasType(type_MilitaryForce, X)))).

fof(axMerge418, axiom, 
 ( ! [X] : 
 (hasType(type_ParticleWord, X) => hasType(type_Word, X)))).

fof(axMerge419, axiom, 
 ( ! [X] : 
 (hasType(type_Patent, X) => hasType(type_Certificate, X)))).

fof(axMerge420, axiom, 
 ( ! [X] : 
 (hasType(type_PathologicProcess, X) => hasType(type_BiologicalProcess, X)))).

fof(axMerge421, axiom, 
 ( ! [X] : 
 (hasType(type_Perception, X) => hasType(type_PsychologicalProcess, X)))).

fof(axMerge422, axiom, 
 ( ! [X] : 
 (hasType(type_PerceptualAttribute, X) => hasType(type_InternalAttribute, X)))).

fof(axMerge423, axiom, 
 ( ! [X] : 
 (hasType(type_Periodical, X) => hasType(type_Series, X)))).

fof(axMerge424, axiom, 
 ( ! [X] : 
 (hasType(type_PermanentResidence, X) => hasType(type_Residence, X)))).

fof(axMerge425, axiom, 
 ( ! [X] : 
 (hasType(type_Phrase, X) => hasType(type_LinguisticExpression, X)))).

fof(axMerge426, axiom, 
 ( ! [X] : 
 (hasType(type_PhysicalAttribute, X) => hasType(type_InternalAttribute, X)))).

fof(axMerge427, axiom, 
 ( ! [X] : 
 (hasType(type_PhysicalQuantity, X) => hasType(type_Quantity, X)))).

fof(axMerge428, axiom, 
 ( ! [X] : 
 (hasType(type_PhysicalState, X) => hasType(type_InternalAttribute, X)))).

fof(axMerge429, axiom, 
 ( ! [X] : 
 (hasType(type_PhysicalSystem, X) => hasType(type_Physical, X)))).

fof(axMerge430, axiom, 
 ( ! [X] : 
 (hasType(type_Physical, X) => hasType(type_Entity, X)))).

fof(axMerge431, axiom, 
 ( ! [X] : 
 (hasType(type_PhysiologicProcess, X) => hasType(type_BiologicalProcess, X)))).

fof(axMerge432, axiom, 
 ( ! [X] : 
 (hasType(type_Plan, X) => hasType(type_Procedure, X)))).

fof(axMerge433, axiom, 
 ( ! [X] : 
 (hasType(type_PlaneAngleMeasure, X) => hasType(type_AngleMeasure, X)))).

fof(axMerge434, axiom, 
 ( ! [X] : 
 (hasType(type_Planning, X) => hasType(type_IntentionalPsychologicalProcess, X)))).

fof(axMerge435, axiom, 
 ( ! [X] : 
 (hasType(type_PlantAnatomicalStructure, X) => hasType(type_AnatomicalStructure, X)))).

fof(axMerge436, axiom, 
 ( ! [X] : 
 (hasType(type_PlantSubstance, X) => hasType(type_BodySubstance, X)))).

fof(axMerge437, axiom, 
 ( ! [X] : 
 (hasType(type_Plant, X) => hasType(type_Organism, X)))).
fof(axMerge437_1, axiom, 
 (! [Var_PLANT] : 
 (((hasType(type_Organism, Var_PLANT)) & ( ((( ? [Var_SUBSTANCE] : 
 (hasType(type_PlantSubstance, Var_SUBSTANCE) &  
(f_part(Var_SUBSTANCE,Var_PLANT))))) & (( ? [Var_STRUCTURE] : 
 (hasType(type_PlantAnatomicalStructure, Var_STRUCTURE) &  
(f_part(Var_STRUCTURE,Var_PLANT)))))))) => (hasType(type_Plant, Var_PLANT))))).

fof(axMerge438, axiom, 
 ( ! [X] : 
 (hasType(type_Poisoning, X) => hasType(type_Injuring, X)))).

fof(axMerge439, axiom, 
 ( ! [X] : 
 (hasType(type_Poking, X) => hasType(type_IntentionalProcess, X)))).

fof(axMerge440, axiom, 
 ( ! [X] : 
 (hasType(type_PoliceOrganization, X) => hasType(type_GovernmentOrganization, X)))).

fof(axMerge441, axiom, 
 ( ! [X] : 
 (hasType(type_PoliticalOrganization, X) => hasType(type_Organization, X)))).

fof(axMerge442, axiom, 
 ( ! [X] : 
 (hasType(type_PoliticalProcess, X) => hasType(type_OrganizationalProcess, X)))).

fof(axMerge443, axiom, 
 ( ! [X] : 
 (hasType(type_Pollen, X) => hasType(type_PlantAnatomicalStructure, X)))).

fof(axMerge444, axiom, 
 ( ! [X] : 
 (hasType(type_Pollen, X) => hasType(type_ReproductiveBody, X)))).

fof(axMerge445, axiom, 
 ( ! [X] : 
 (hasType(type_Position, X) => hasType(type_SocialRole, X)))).

fof(axMerge446, axiom, 
 ( ! [X] : 
 (hasType(type_PositionalAttribute, X) => hasType(type_RelationalAttribute, X)))).

fof(axMerge447, axiom, 
 ( ! [X] : 
 (hasType(type_PositiveInteger, X) => hasType(type_NonnegativeInteger, X)))).

fof(axMerge448, axiom, 
 ( ! [X] : 
 (hasType(type_PositiveInteger, X) => hasType(type_PositiveRealNumber, X)))).

fof(axMerge449, axiom, 
 ( ! [X] : 
 (hasType(type_PositiveRealNumber, X) => hasType(type_NonnegativeRealNumber, X)))).
fof(axMerge449_1, axiom, 
 (! [Var_NUMBER] : 
 (((hasType(type_NonnegativeRealNumber, Var_NUMBER)) & ( f_greaterThan(Var_NUMBER,0))) => (hasType(type_PositiveRealNumber, Var_NUMBER))))).

fof(axMerge450, axiom, 
 ( ! [X] : 
 (hasType(type_Precipitation, X) => hasType(type_Falling, X)))).

fof(axMerge451, axiom, 
 ( ! [X] : 
 (hasType(type_Precipitation, X) => hasType(type_WaterMotion, X)))).

fof(axMerge452, axiom, 
 ( ! [X] : 
 (hasType(type_Precipitation, X) => hasType(type_WeatherProcess, X)))).

fof(axMerge453, axiom, 
 ( ! [X] : 
 (hasType(type_Predicting, X) => hasType(type_IntentionalPsychologicalProcess, X)))).

fof(axMerge454, axiom, 
 ( ! [X] : 
 (hasType(type_PrepositionalPhrase, X) => hasType(type_Phrase, X)))).

fof(axMerge455, axiom, 
 ( ! [X] : 
 (hasType(type_Pretending, X) => hasType(type_SocialInteraction, X)))).

fof(axMerge456, axiom, 
 ( ! [X] : 
 (hasType(type_PrimaryColor, X) => hasType(type_ColorAttribute, X)))).

fof(axMerge457, axiom, 
 ( ! [X] : 
 (hasType(type_Primate, X) => hasType(type_Mammal, X)))).

fof(axMerge458, axiom, 
 ( ! [X] : 
 (hasType(type_PrimeNumber, X) => hasType(type_Integer, X)))).

fof(axMerge459, axiom, 
 ( ! [X] : 
 (hasType(type_ProbabilityAttribute, X) => hasType(type_ObjectiveNorm, X)))).

fof(axMerge460, axiom, 
 ( ! [X] : 
 (hasType(type_Procedure, X) => hasType(type_Proposition, X)))).

fof(axMerge461, axiom, 
 ( ! [X] : 
 (hasType(type_Process, X) => hasType(type_Physical, X)))).

fof(axMerge462, axiom, 
 ( ! [X] : 
 (hasType(type_Product, X) => hasType(type_Artifact, X)))).

fof(axMerge463, axiom, 
 ( ! [X] : 
 (hasType(type_Proposition, X) => hasType(type_Abstract, X)))).

fof(axMerge464, axiom, 
 ( ! [X] : 
 (hasType(type_Protein, X) => hasType(type_Nutrient, X)))).

fof(axMerge465, axiom, 
 ( ! [X] : 
 (hasType(type_Proton, X) => hasType(type_SubatomicParticle, X)))).

fof(axMerge466, axiom, 
 ( ! [X] : 
 (hasType(type_PseudoGraph, X) => hasType(type_Graph, X)))).

fof(axMerge467, axiom, 
 ( ! [X] : 
 (hasType(type_PsychologicalAttribute, X) => hasType(type_BiologicalAttribute, X)))).

fof(axMerge468, axiom, 
 ( ! [X] : 
 (hasType(type_PsychologicalDysfunction, X) => hasType(type_DiseaseOrSyndrome, X)))).

fof(axMerge469, axiom, 
 ( ! [X] : 
 (hasType(type_PsychologicalDysfunction, X) => hasType(type_PsychologicalAttribute, X)))).

fof(axMerge470, axiom, 
 ( ! [X] : 
 (hasType(type_PsychologicalProcess, X) => hasType(type_BiologicalProcess, X)))).

fof(axMerge471, axiom, 
 ( ! [X] : 
 (hasType(type_Publication, X) => hasType(type_ContentDevelopment, X)))).

fof(axMerge472, axiom, 
 ( ! [X] : 
 (hasType(type_Publication, X) => hasType(type_Manufacture, X)))).

fof(axMerge473, axiom, 
 ( ! [X] : 
 (hasType(type_PureSubstance, X) => hasType(type_Substance, X)))).

fof(axMerge474, axiom, 
 ( ! [X] : 
 (hasType(type_Pursuing, X) => hasType(type_IntentionalProcess, X)))).

fof(axMerge475, axiom, 
 ( ! [X] : 
 (hasType(type_Putting, X) => hasType(type_Transfer, X)))).

fof(axMerge476, axiom, 
 ( ! [X] : 
 (hasType(type_QuantityChange, X) => hasType(type_InternalChange, X)))).

fof(axMerge477, axiom, 
 ( ! [X] : 
 (hasType(type_Quantity, X) => hasType(type_Abstract, X)))).

fof(axMerge478, axiom, 
 ( ! [X] : 
 (hasType(type_Questioning, X) => hasType(type_Directing, X)))).

fof(axMerge479, axiom, 
 ( ! [X] : 
 (hasType(type_RadiatingElectromagnetic, X) => hasType(type_Radiating, X)))).

fof(axMerge480, axiom, 
 ( ! [X] : 
 (hasType(type_RadiatingInfrared, X) => hasType(type_RadiatingElectromagnetic, X)))).

fof(axMerge481, axiom, 
 ( ! [X] : 
 (hasType(type_RadiatingLight, X) => hasType(type_RadiatingElectromagnetic, X)))).

fof(axMerge482, axiom, 
 ( ! [X] : 
 (hasType(type_RadiatingNuclear, X) => hasType(type_Radiating, X)))).

fof(axMerge483, axiom, 
 ( ! [X] : 
 (hasType(type_RadiatingSound, X) => hasType(type_Radiating, X)))).

fof(axMerge484, axiom, 
 ( ! [X] : 
 (hasType(type_RadiatingXRay, X) => hasType(type_RadiatingElectromagnetic, X)))).

fof(axMerge485, axiom, 
 ( ! [X] : 
 (hasType(type_Radiating, X) => hasType(type_Motion, X)))).

fof(axMerge486, axiom, 
 ( ! [X] : 
 (hasType(type_RationalNumber, X) => hasType(type_RealNumber, X)))).

fof(axMerge487, axiom, 
 ( ! [X] : 
 (hasType(type_Reading, X) => hasType(type_ContentDevelopment, X)))).

fof(axMerge488, axiom, 
 ( ! [X] : 
 (hasType(type_RealNumber, X) => hasType(type_Number, X)))).

fof(axMerge489, axiom, 
 ( ! [X] : 
 (hasType(type_Reasoning, X) => hasType(type_IntentionalPsychologicalProcess, X)))).

fof(axMerge490, axiom, 
 ( ! [X] : 
 (hasType(type_RecreationOrExercise, X) => hasType(type_IntentionalProcess, X)))).

fof(axMerge491, axiom, 
 ( ! [X] : 
 (hasType(type_Region, X) => hasType(type_Object, X)))).

fof(axMerge492, axiom, 
 ( ! [X] : 
 (hasType(type_RegulatoryProcess, X) => hasType(type_Guiding, X)))).

fof(axMerge493, axiom, 
 ( ! [X] : 
 (hasType(type_RelationalAttribute, X) => hasType(type_Attribute, X)))).

fof(axMerge494, axiom, 
 ( ! [X] : 
 (hasType(type_Releasing, X) => hasType(type_Transfer, X)))).

fof(axMerge495, axiom, 
 ( ! [X] : 
 (hasType(type_ReligiousOrganization, X) => hasType(type_BeliefGroup, X)))).

fof(axMerge496, axiom, 
 ( ! [X] : 
 (hasType(type_ReligiousOrganization, X) => hasType(type_Organization, X)))).

fof(axMerge497, axiom, 
 ( ! [X] : 
 (hasType(type_ReligiousProcess, X) => hasType(type_OrganizationalProcess, X)))).

fof(axMerge498, axiom, 
 ( ! [X] : 
 (hasType(type_Remembering, X) => hasType(type_PsychologicalProcess, X)))).

fof(axMerge499, axiom, 
 ( ! [X] : 
 (hasType(type_Removing, X) => hasType(type_Transfer, X)))).

fof(axMerge500, axiom, 
 ( ! [X] : 
 (hasType(type_Repairing, X) => hasType(type_IntentionalProcess, X)))).

fof(axMerge501, axiom, 
 ( ! [X] : 
 (hasType(type_Replication, X) => hasType(type_OrganismProcess, X)))).

fof(axMerge502, axiom, 
 ( ! [X] : 
 (hasType(type_RepresentationalArtWork, X) => hasType(type_ArtWork, X)))).

fof(axMerge503, axiom, 
 ( ! [X] : 
 (hasType(type_RepresentationalArtWork, X) => hasType(type_Icon, X)))).

fof(axMerge504, axiom, 
 ( ! [X] : 
 (hasType(type_ReproductiveBody, X) => hasType(type_BodyPart, X)))).

fof(axMerge505, axiom, 
 ( ! [X] : 
 (hasType(type_Reptile, X) => hasType(type_ColdBloodedVertebrate, X)))).

fof(axMerge506, axiom, 
 ( ! [X] : 
 (hasType(type_Requesting, X) => hasType(type_Directing, X)))).

fof(axMerge507, axiom, 
 ( ! [X] : 
 (hasType(type_Residence, X) => hasType(type_StationaryArtifact, X)))).

fof(axMerge508, axiom, 
 ( ! [X] : 
 (hasType(type_ResidentialBuilding, X) => hasType(type_Building, X)))).

fof(axMerge509, axiom, 
 ( ! [X] : 
 (hasType(type_ResidentialBuilding, X) => hasType(type_Residence, X)))).

fof(axMerge510, axiom, 
 ( ! [X] : 
 (hasType(type_Roadway, X) => hasType(type_LandTransitway, X)))).

fof(axMerge511, axiom, 
 ( ! [X] : 
 (hasType(type_Rodent, X) => hasType(type_Mammal, X)))).

fof(axMerge512, axiom, 
 ( ! [X] : 
 (hasType(type_Room, X) => hasType(type_StationaryArtifact, X)))).

fof(axMerge513, axiom, 
 ( ! [X] : 
 (hasType(type_Running, X) => hasType(type_Ambulating, X)))).

fof(axMerge514, axiom, 
 ( ! [X] : 
 (hasType(type_SaltWaterArea, X) => hasType(type_WaterArea, X)))).

fof(axMerge515, axiom, 
 ( ! [X] : 
 (hasType(type_SaturationAttribute, X) => hasType(type_InternalAttribute, X)))).

fof(axMerge516, axiom, 
 ( ! [X] : 
 (hasType(type_Saturday, X) => hasType(type_Day, X)))).

fof(axMerge517, axiom, 
 ( ! [X] : 
 (hasType(type_Second, X) => hasType(type_TimeInterval, X)))).

fof(axMerge518, axiom, 
 ( ! [X] : 
 (hasType(type_Seed, X) => hasType(type_PlantAnatomicalStructure, X)))).

fof(axMerge519, axiom, 
 ( ! [X] : 
 (hasType(type_Seed, X) => hasType(type_ReproductiveBody, X)))).

fof(axMerge520, axiom, 
 ( ! [X] : 
 (hasType(type_Seeing, X) => hasType(type_Perception, X)))).

fof(axMerge521, axiom, 
 ( ! [X] : 
 (hasType(type_Selecting, X) => hasType(type_IntentionalPsychologicalProcess, X)))).

fof(axMerge522, axiom, 
 ( ! [X] : 
 (hasType(type_SelfConnectedObject, X) => hasType(type_Object, X)))).

fof(axMerge523, axiom, 
 ( ! [X] : 
 (hasType(type_Selling, X) => hasType(type_FinancialTransaction, X)))).

fof(axMerge524, axiom, 
 ( ! [X] : 
 (hasType(type_Sentence, X) => hasType(type_LinguisticExpression, X)))).

fof(axMerge525, axiom, 
 ( ! [X] : 
 (hasType(type_SentientAgent, X) => hasType(type_Agent, X)))).

fof(axMerge526, axiom, 
 ( ! [X] : 
 (hasType(type_Separating, X) => hasType(type_DualObjectProcess, X)))).

fof(axMerge527, axiom, 
 ( ! [X] : 
 (hasType(type_September, X) => hasType(type_Month, X)))).

fof(axMerge528, axiom, 
 ( ! [X] : 
 (hasType(type_Series, X) => hasType(type_Text, X)))).

fof(axMerge529, axiom, 
 ( ! [X] : 
 (hasType(type_ServiceProcess, X) => hasType(type_SocialInteraction, X)))).

fof(axMerge530, axiom, 
 ( ! [X] : 
 (hasType(type_SetOrClass, X) => hasType(type_Abstract, X)))).

fof(axMerge531, axiom, 
 ( ! [X] : 
 (hasType(type_Set, X) => hasType(type_SetOrClass, X)))).

fof(axMerge532, axiom, 
 ( ! [X] : 
 (hasType(type_SexAttribute, X) => hasType(type_BiologicalAttribute, X)))).

fof(axMerge533, axiom, 
 ( ! [X] : 
 (hasType(type_SexualReproduction, X) => hasType(type_Replication, X)))).

fof(axMerge534, axiom, 
 ( ! [X] : 
 (hasType(type_ShapeAttribute, X) => hasType(type_InternalAttribute, X)))).

fof(axMerge535, axiom, 
 ( ! [X] : 
 (hasType(type_ShapeChange, X) => hasType(type_InternalChange, X)))).

fof(axMerge536, axiom, 
 ( ! [X] : 
 (hasType(type_Shooting, X) => hasType(type_Impelling, X)))).

fof(axMerge537, axiom, 
 ( ! [X] : 
 (hasType(type_ShoreArea, X) => hasType(type_LandArea, X)))).

fof(axMerge538, axiom, 
 ( ! [X] : 
 (hasType(type_Singing, X) => hasType(type_Music, X)))).

fof(axMerge539, axiom, 
 ( ! [X] : 
 (hasType(type_Singing, X) => hasType(type_Speaking, X)))).

fof(axMerge540, axiom, 
 ( ! [X] : 
 (hasType(type_SingleAgentProcess, X) => hasType(type_Process, X)))).

fof(axMerge541, axiom, 
 ( ! [X] : 
 (hasType(type_SingleFamilyResidence, X) => hasType(type_PermanentResidence, X)))).

fof(axMerge542, axiom, 
 ( ! [X] : 
 (hasType(type_Smelling, X) => hasType(type_Perception, X)))).

fof(axMerge543, axiom, 
 ( ! [X] : 
 (hasType(type_Smoke, X) => hasType(type_Cloud, X)))).

fof(axMerge544, axiom, 
 ( ! [X] : 
 (hasType(type_SocialInteraction, X) => hasType(type_IntentionalProcess, X)))).

fof(axMerge545, axiom, 
 ( ! [X] : 
 (hasType(type_SocialRole, X) => hasType(type_RelationalAttribute, X)))).

fof(axMerge546, axiom, 
 ( ! [X] : 
 (hasType(type_SocialUnit, X) => hasType(type_GroupOfPeople, X)))).

fof(axMerge547, axiom, 
 ( ! [X] : 
 (hasType(type_SolidAngleMeasure, X) => hasType(type_AngleMeasure, X)))).

fof(axMerge548, axiom, 
 ( ! [X] : 
 (hasType(type_Solution, X) => hasType(type_LiquidMixture, X)))).

fof(axMerge549, axiom, 
 ( ! [X] : 
 (hasType(type_SoundAttribute, X) => hasType(type_RelationalAttribute, X)))).

fof(axMerge550, axiom, 
 ( ! [X] : 
 (hasType(type_Speaking, X) => hasType(type_LinguisticCommunication, X)))).

fof(axMerge551, axiom, 
 ( ! [X] : 
 (hasType(type_Speaking, X) => hasType(type_Vocalizing, X)))).

fof(axMerge552, axiom, 
 ( ! [X] : 
 (hasType(type_SpokenHumanLanguage, X) => hasType(type_HumanLanguage, X)))).

fof(axMerge553, axiom, 
 ( ! [X] : 
 (hasType(type_Spore, X) => hasType(type_PlantAnatomicalStructure, X)))).

fof(axMerge554, axiom, 
 ( ! [X] : 
 (hasType(type_Spore, X) => hasType(type_ReproductiveBody, X)))).

fof(axMerge555, axiom, 
 ( ! [X] : 
 (hasType(type_Sport, X) => hasType(type_Game, X)))).

fof(axMerge556, axiom, 
 ( ! [X] : 
 (hasType(type_StateChange, X) => hasType(type_InternalChange, X)))).

fof(axMerge557, axiom, 
 ( ! [X] : 
 (hasType(type_StateOfMind, X) => hasType(type_PsychologicalAttribute, X)))).

fof(axMerge558, axiom, 
 ( ! [X] : 
 (hasType(type_StateOrProvince, X) => hasType(type_GeopoliticalArea, X)))).

fof(axMerge559, axiom, 
 ( ! [X] : 
 (hasType(type_StateOrProvince, X) => hasType(type_LandArea, X)))).

fof(axMerge560, axiom, 
 ( ! [X] : 
 (hasType(type_StaticWaterArea, X) => hasType(type_WaterArea, X)))).

fof(axMerge561, axiom, 
 ( ! [X] : 
 (hasType(type_Stating, X) => hasType(type_LinguisticCommunication, X)))).

fof(axMerge562, axiom, 
 ( ! [X] : 
 (hasType(type_StationaryArtifact, X) => hasType(type_Artifact, X)))).

fof(axMerge563, axiom, 
 ( ! [X] : 
 (hasType(type_StreamWaterArea, X) => hasType(type_FlowRegion, X)))).

fof(axMerge564, axiom, 
 ( ! [X] : 
 (hasType(type_StreamWaterArea, X) => hasType(type_WaterArea, X)))).

fof(axMerge565, axiom, 
 ( ! [X] : 
 (hasType(type_SubatomicParticle, X) => hasType(type_ElementalSubstance, X)))).

fof(axMerge566, axiom, 
 ( ! [X] : 
 (hasType(type_SubjectiveAssessmentAttribute, X) => hasType(type_NormativeAttribute, X)))).

fof(axMerge567, axiom, 
 ( ! [X] : 
 (hasType(type_Substance, X) => hasType(type_SelfConnectedObject, X)))).

fof(axMerge568, axiom, 
 ( ! [X] : 
 (hasType(type_Substituting, X) => hasType(type_DualObjectProcess, X)))).

fof(axMerge569, axiom, 
 ( ! [X] : 
 (hasType(type_Substituting, X) => hasType(type_Transfer, X)))).

fof(axMerge570, axiom, 
 ( ! [X] : 
 (hasType(type_Summary, X) => hasType(type_Text, X)))).

fof(axMerge571, axiom, 
 ( ! [X] : 
 (hasType(type_Sunday, X) => hasType(type_Day, X)))).

fof(axMerge572, axiom, 
 ( ! [X] : 
 (hasType(type_Supposing, X) => hasType(type_LinguisticCommunication, X)))).

fof(axMerge573, axiom, 
 ( ! [X] : 
 (hasType(type_SurfaceChange, X) => hasType(type_InternalChange, X)))).

fof(axMerge574, axiom, 
 ( ! [X] : 
 (hasType(type_Surgery, X) => hasType(type_TherapeuticProcess, X)))).

fof(axMerge575, axiom, 
 ( ! [X] : 
 (hasType(type_Suspension, X) => hasType(type_LiquidMixture, X)))).

fof(axMerge576, axiom, 
 ( ! [X] : 
 (hasType(type_Swimming, X) => hasType(type_BodyMotion, X)))).

fof(axMerge577, axiom, 
 ( ! [X] : 
 (hasType(type_SymbolicString, X) => hasType(type_ContentBearingObject, X)))).

fof(axMerge578, axiom, 
 ( ! [X] : 
 (hasType(type_SymmetricPositionalAttribute, X) => hasType(type_PositionalAttribute, X)))).

fof(axMerge579, axiom, 
 ( ! [X] : 
 (hasType(type_SyntheticSubstance, X) => hasType(type_Substance, X)))).
fof(axMerge579_1, axiom, 
 (! [Var_SUBSTANCE] : 
 (((hasType(type_Substance, Var_SUBSTANCE)) & ( ( ? [Var_PROCESS] : 
 (hasType(type_IntentionalProcess, Var_PROCESS) &  
(f_result(Var_PROCESS,Var_SUBSTANCE)))))) => (hasType(type_SyntheticSubstance, Var_SUBSTANCE))))).

fof(axMerge580, axiom, 
 ( ! [X] : 
 (hasType(type_SystemeInternationalUnit, X) => hasType(type_UnitOfMeasure, X)))).

fof(axMerge581, axiom, 
 ( ! [X] : 
 (hasType(type_TactilePerception, X) => hasType(type_Perception, X)))).

fof(axMerge582, axiom, 
 ( ! [X] : 
 (hasType(type_TasteAttribute, X) => hasType(type_PerceptualAttribute, X)))).

fof(axMerge583, axiom, 
 ( ! [X] : 
 (hasType(type_Tasting, X) => hasType(type_Perception, X)))).

fof(axMerge584, axiom, 
 ( ! [X] : 
 (hasType(type_TemperatureMeasure, X) => hasType(type_ConstantQuantity, X)))).

fof(axMerge585, axiom, 
 ( ! [X] : 
 (hasType(type_TemporaryResidence, X) => hasType(type_Residence, X)))).

fof(axMerge586, axiom, 
 ( ! [X] : 
 (hasType(type_TerminatingEmployment, X) => hasType(type_LeavingAnOrganization, X)))).

fof(axMerge587, axiom, 
 ( ! [X] : 
 (hasType(type_Text, X) => hasType(type_Artifact, X)))).

fof(axMerge588, axiom, 
 ( ! [X] : 
 (hasType(type_Text, X) => hasType(type_ContentBearingObject, X)))).

fof(axMerge589, axiom, 
 ( ! [X] : 
 (hasType(type_Text, X) => hasType(type_LinguisticExpression, X)))).

fof(axMerge590, axiom, 
 ( ! [X] : 
 (hasType(type_TextureAttribute, X) => hasType(type_PerceptualAttribute, X)))).

fof(axMerge591, axiom, 
 ( ! [X] : 
 (hasType(type_TherapeuticProcess, X) => hasType(type_Repairing, X)))).

fof(axMerge592, axiom, 
 ( ! [X] : 
 (hasType(type_ThreeDimensionalFigure, X) => hasType(type_GeometricFigure, X)))).

fof(axMerge593, axiom, 
 ( ! [X] : 
 (hasType(type_Thursday, X) => hasType(type_Day, X)))).

fof(axMerge594, axiom, 
 ( ! [X] : 
 (hasType(type_TimeDependentQuantity, X) => hasType(type_UnaryConstantFunctionQuantity, X)))).

fof(axMerge595, axiom, 
 ( ! [X] : 
 (hasType(type_TimeDuration, X) => hasType(type_TimeMeasure, X)))).

fof(axMerge596, axiom, 
 ( ! [X] : 
 (hasType(type_TimeInterval, X) => hasType(type_TimePosition, X)))).

fof(axMerge597, axiom, 
 ( ! [X] : 
 (hasType(type_TimeMeasure, X) => hasType(type_ConstantQuantity, X)))).

fof(axMerge598, axiom, 
 ( ! [X] : 
 (hasType(type_TimePoint, X) => hasType(type_TimePosition, X)))).

fof(axMerge599, axiom, 
 ( ! [X] : 
 (hasType(type_TimePosition, X) => hasType(type_TimeMeasure, X)))).

fof(axMerge600, axiom, 
 ( ! [X] : 
 (hasType(type_TimeZone, X) => hasType(type_RelationalAttribute, X)))).

fof(axMerge601, axiom, 
 ( ! [X] : 
 (hasType(type_Tissue, X) => hasType(type_BodySubstance, X)))).

fof(axMerge602, axiom, 
 ( ! [X] : 
 (hasType(type_Touching, X) => hasType(type_Transfer, X)))).

fof(axMerge603, axiom, 
 ( ! [X] : 
 (hasType(type_TraitAttribute, X) => hasType(type_PsychologicalAttribute, X)))).

fof(axMerge604, axiom, 
 ( ! [X] : 
 (hasType(type_Transaction, X) => hasType(type_ChangeOfPossession, X)))).

fof(axMerge605, axiom, 
 ( ! [X] : 
 (hasType(type_Transaction, X) => hasType(type_DualObjectProcess, X)))).

fof(axMerge606, axiom, 
 ( ! [X] : 
 (hasType(type_Transfer, X) => hasType(type_Translocation, X)))).

fof(axMerge607, axiom, 
 ( ! [X] : 
 (hasType(type_Transitway, X) => hasType(type_Region, X)))).

fof(axMerge608, axiom, 
 ( ! [X] : 
 (hasType(type_Transitway, X) => hasType(type_SelfConnectedObject, X)))).

fof(axMerge609, axiom, 
 ( ! [X] : 
 (hasType(type_Translating, X) => hasType(type_ContentDevelopment, X)))).

fof(axMerge610, axiom, 
 ( ! [X] : 
 (hasType(type_Translating, X) => hasType(type_DualObjectProcess, X)))).

fof(axMerge611, axiom, 
 ( ! [X] : 
 (hasType(type_Translocation, X) => hasType(type_Motion, X)))).

fof(axMerge612, axiom, 
 ( ! [X] : 
 (hasType(type_TransportationDevice, X) => hasType(type_Device, X)))).

fof(axMerge613, axiom, 
 ( ! [X] : 
 (hasType(type_Transportation, X) => hasType(type_Translocation, X)))).

fof(axMerge614, axiom, 
 ( ! [X] : 
 (hasType(type_Tree, X) => hasType(type_Graph, X)))).

fof(axMerge615, axiom, 
 ( ! [X] : 
 (hasType(type_TruthValue, X) => hasType(type_RelationalAttribute, X)))).

fof(axMerge616, axiom, 
 ( ! [X] : 
 (hasType(type_Tuesday, X) => hasType(type_Day, X)))).

fof(axMerge617, axiom, 
 ( ! [X] : 
 (hasType(type_TwoDimensionalAngle, X) => hasType(type_OpenTwoDimensionalFigure, X)))).

fof(axMerge618, axiom, 
 ( ! [X] : 
 (hasType(type_TwoDimensionalFigure, X) => hasType(type_GeometricFigure, X)))).

fof(axMerge619, axiom, 
 ( ! [X] : 
 (hasType(type_UnaryConstantFunctionQuantity, X) => hasType(type_FunctionQuantity, X)))).

fof(axMerge620, axiom, 
 ( ! [X] : 
 (hasType(type_Uncovering, X) => hasType(type_Removing, X)))).

fof(axMerge621, axiom, 
 ( ! [X] : 
 (hasType(type_Ungrasping, X) => hasType(type_Detaching, X)))).

fof(axMerge622, axiom, 
 ( ! [X] : 
 (hasType(type_UnilateralGetting, X) => hasType(type_Getting, X)))).

fof(axMerge623, axiom, 
 ( ! [X] : 
 (hasType(type_UnilateralGiving, X) => hasType(type_Giving, X)))).

fof(axMerge624, axiom, 
 ( ! [X] : 
 (hasType(type_UniqueList, X) => hasType(type_List, X)))).

fof(axMerge625, axiom, 
 ( ! [X] : 
 (hasType(type_UnitOfAngularMeasure, X) => hasType(type_NonCompositeUnitOfMeasure, X)))).

fof(axMerge626, axiom, 
 ( ! [X] : 
 (hasType(type_UnitOfArea, X) => hasType(type_CompositeUnitOfMeasure, X)))).

fof(axMerge627, axiom, 
 ( ! [X] : 
 (hasType(type_UnitOfAtmosphericPressure, X) => hasType(type_CompositeUnitOfMeasure, X)))).

fof(axMerge628, axiom, 
 ( ! [X] : 
 (hasType(type_UnitOfCurrency, X) => hasType(type_NonCompositeUnitOfMeasure, X)))).

fof(axMerge629, axiom, 
 ( ! [X] : 
 (hasType(type_UnitOfDuration, X) => hasType(type_NonCompositeUnitOfMeasure, X)))).

fof(axMerge630, axiom, 
 ( ! [X] : 
 (hasType(type_UnitOfFrequency, X) => hasType(type_CompositeUnitOfMeasure, X)))).

fof(axMerge631, axiom, 
 ( ! [X] : 
 (hasType(type_UnitOfInformation, X) => hasType(type_NonCompositeUnitOfMeasure, X)))).

fof(axMerge632, axiom, 
 ( ! [X] : 
 (hasType(type_UnitOfLength, X) => hasType(type_NonCompositeUnitOfMeasure, X)))).

fof(axMerge633, axiom, 
 ( ! [X] : 
 (hasType(type_UnitOfMass, X) => hasType(type_NonCompositeUnitOfMeasure, X)))).

fof(axMerge634, axiom, 
 ( ! [X] : 
 (hasType(type_UnitOfMeasure, X) => hasType(type_PhysicalQuantity, X)))).

fof(axMerge635, axiom, 
 ( ! [X] : 
 (hasType(type_UnitOfTemperature, X) => hasType(type_NonCompositeUnitOfMeasure, X)))).

fof(axMerge636, axiom, 
 ( ! [X] : 
 (hasType(type_UnitOfVolume, X) => hasType(type_CompositeUnitOfMeasure, X)))).

fof(axMerge637, axiom, 
 ( ! [X] : 
 (hasType(type_ValidDeductiveArgument, X) => hasType(type_DeductiveArgument, X)))).

fof(axMerge638, axiom, 
 ( ! [X] : 
 (hasType(type_Vehicle, X) => hasType(type_TransportationDevice, X)))).

fof(axMerge639, axiom, 
 ( ! [X] : 
 (hasType(type_VerbPhrase, X) => hasType(type_Phrase, X)))).

fof(axMerge640, axiom, 
 ( ! [X] : 
 (hasType(type_Verb, X) => hasType(type_Word, X)))).

fof(axMerge641, axiom, 
 ( ! [X] : 
 (hasType(type_SpinalColumn, X) => hasType(type_AnimalAnatomicalStructure, X)))).

fof(axMerge642, axiom, 
 ( ! [X] : 
 (hasType(type_SpinalColumn, X) => hasType(type_Organ, X)))).

fof(axMerge643, axiom, 
 ( ! [X] : 
 (hasType(type_NervousSystem, X) => hasType(type_AnimalAnatomicalStructure, X)))).

fof(axMerge644, axiom, 
 ( ! [X] : 
 (hasType(type_NervousSystem, X) => hasType(type_Organ, X)))).

fof(axMerge645, axiom, 
 ( ! [X] : 
 (hasType(type_Skeleton, X) => hasType(type_AnimalAnatomicalStructure, X)))).

fof(axMerge646, axiom, 
 ( ! [X] : 
 (hasType(type_Skeleton, X) => hasType(type_BodyPart, X)))).

fof(axMerge647, axiom, 
 ( ! [X] : 
 (hasType(type_Exoskeleton, X) => hasType(type_AnimalAnatomicalStructure, X)))).

fof(axMerge648, axiom, 
 ( ! [X] : 
 (hasType(type_Exoskeleton, X) => hasType(type_BodyPart, X)))).

fof(axMerge649, axiom, 
 ( ! [X] : 
 (hasType(type_Vertebrate, X) => hasType(type_Animal, X)))).
fof(axMerge649_1, axiom, 
 (! [Var_VERT] : 
 (((hasType(type_Animal, Var_VERT)) & ( ((((((( ? [Var_SPINE] : 
 (hasType(type_SpinalColumn, Var_SPINE) &  
(f_component(Var_SPINE,Var_VERT))))) & (( ? [Var_S] : 
 (hasType(type_NervousSystem, Var_S) &  
(f_part(Var_S,Var_VERT))))))) & (( ? [Var_SKELETON] : 
 (hasType(type_Skeleton, Var_SKELETON) &  
(f_part(Var_SKELETON,Var_VERT))))))) & (( ? [Var_SKELETON] : 
 (hasType(type_Exoskeleton, Var_SKELETON) &  
(f_part(Var_SKELETON,Var_VERT)))))))) => (hasType(type_Vertebrate, Var_VERT))))).

fof(axMerge650, axiom, 
 ( ! [X] : 
 (hasType(type_ViolentContest, X) => hasType(type_Contest, X)))).

fof(axMerge651, axiom, 
 ( ! [X] : 
 (hasType(type_Virus, X) => hasType(type_Microorganism, X)))).

fof(axMerge652, axiom, 
 ( ! [X] : 
 (hasType(type_VisualAttribute, X) => hasType(type_PerceptualAttribute, X)))).

fof(axMerge653, axiom, 
 ( ! [X] : 
 (hasType(type_Vitamin, X) => hasType(type_Nutrient, X)))).

fof(axMerge654, axiom, 
 ( ! [X] : 
 (hasType(type_VocalCords, X) => hasType(type_Organ, X)))).

fof(axMerge655, axiom, 
 ( ! [X] : 
 (hasType(type_Vocalizing, X) => hasType(type_BodyMotion, X)))).

fof(axMerge656, axiom, 
 ( ! [X] : 
 (hasType(type_Vocalizing, X) => hasType(type_RadiatingSound, X)))).

fof(axMerge657, axiom, 
 ( ! [X] : 
 (hasType(type_VolumeMeasure, X) => hasType(type_FunctionQuantity, X)))).

fof(axMerge658, axiom, 
 ( ! [X] : 
 (hasType(type_Voting, X) => hasType(type_Deciding, X)))).

fof(axMerge659, axiom, 
 ( ! [X] : 
 (hasType(type_Walking, X) => hasType(type_Ambulating, X)))).

fof(axMerge660, axiom, 
 ( ! [X] : 
 (hasType(type_War, X) => hasType(type_ViolentContest, X)))).

fof(axMerge661, axiom, 
 ( ! [X] : 
 (hasType(type_WarmBloodedVertebrate, X) => hasType(type_Vertebrate, X)))).

fof(axMerge662, axiom, 
 ( ! [X] : 
 (hasType(type_WaterArea, X) => hasType(type_GeographicArea, X)))).

fof(axMerge663, axiom, 
 ( ! [X] : 
 (hasType(type_WaterCloud, X) => hasType(type_Cloud, X)))).

fof(axMerge664, axiom, 
 ( ! [X] : 
 (hasType(type_WaterMotion, X) => hasType(type_LiquidMotion, X)))).

fof(axMerge665, axiom, 
 ( ! [X] : 
 (hasType(type_Water, X) => hasType(type_CompoundSubstance, X)))).

fof(axMerge666, axiom, 
 ( ! [X] : 
 (hasType(type_Weapon, X) => hasType(type_Device, X)))).

fof(axMerge667, axiom, 
 ( ! [X] : 
 (hasType(type_WearableItem, X) => hasType(type_Artifact, X)))).

fof(axMerge668, axiom, 
 ( ! [X] : 
 (hasType(type_WeatherProcess, X) => hasType(type_Motion, X)))).

fof(axMerge669, axiom, 
 ( ! [X] : 
 (hasType(type_Wedding, X) => hasType(type_Declaring, X)))).

fof(axMerge670, axiom, 
 ( ! [X] : 
 (hasType(type_Wednesday, X) => hasType(type_Day, X)))).

fof(axMerge671, axiom, 
 ( ! [X] : 
 (hasType(type_Week, X) => hasType(type_TimeInterval, X)))).

fof(axMerge672, axiom, 
 ( ! [X] : 
 (hasType(type_Wetting, X) => hasType(type_Putting, X)))).

fof(axMerge673, axiom, 
 ( ! [X] : 
 (hasType(type_Wind, X) => hasType(type_GasMotion, X)))).

fof(axMerge674, axiom, 
 ( ! [X] : 
 (hasType(type_Woman, X) => hasType(type_Human, X)))).

fof(axMerge675, axiom, 
 ( ! [X] : 
 (hasType(type_Word, X) => hasType(type_LinguisticExpression, X)))).

fof(axMerge676, axiom, 
 ( ! [X] : 
 (hasType(type_Worm, X) => hasType(type_Invertebrate, X)))).

fof(axMerge677, axiom, 
 ( ! [X] : 
 (hasType(type_Writing, X) => hasType(type_ContentDevelopment, X)))).

fof(axMerge678, axiom, 
 ( ! [X] : 
 (hasType(type_Year, X) => hasType(type_TimeInterval, X)))).

fof(axMerge679, axiom, 
 (hasType(type_SymmetricPositionalAttribute, inst_Adjacent))).

fof(axMerge680, axiom, 
 (hasType(type_UnitOfMass, inst_Amu))).

fof(axMerge681, axiom, 
 (hasType(type_UnitOfLength, inst_Angstrom))).

fof(axMerge682, axiom, 
 (hasType(type_UnitOfAngularMeasure, inst_AngularDegree))).

fof(axMerge683, axiom, 
 (hasType(type_ConsciousnessAttribute, inst_Asleep))).

fof(axMerge684, axiom, 
 (hasType(type_UnitOfMass, inst_AtomGram))).

fof(axMerge685, axiom, 
 (hasType(type_SoundAttribute, inst_Audible))).

fof(axMerge686, axiom, 
 (hasType(type_ConsciousnessAttribute, inst_Awake))).

fof(axMerge687, axiom, 
 (hasType(type_UnitOfInformation, inst_Bit))).

fof(axMerge688, axiom, 
 (hasType(type_PrimaryColor, inst_Black))).

fof(axMerge689, axiom, 
 (hasType(type_PrimaryColor, inst_Blue))).

fof(axMerge690, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_BritishThermalUnit))).

fof(axMerge691, axiom, 
 (hasType(type_UnitOfInformation, inst_Byte))).

fof(axMerge692, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_Calorie))).

fof(axMerge693, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_Ampere))).

fof(axMerge694, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_Candela))).

fof(axMerge695, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_Newton))).

fof(axMerge696, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_Pascal))).

fof(axMerge697, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_Joule))).

fof(axMerge698, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_Watt))).

fof(axMerge699, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_Coulomb))).

fof(axMerge700, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_Volt))).

fof(axMerge701, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_Farad))).

fof(axMerge702, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_Ohm))).

fof(axMerge703, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_Siemens))).

fof(axMerge704, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_Weber))).

fof(axMerge705, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_Tesla))).

fof(axMerge706, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_Henry))).

fof(axMerge707, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_Lumen))).

fof(axMerge708, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_Lux))).

fof(axMerge709, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_Becquerel))).

fof(axMerge710, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_Gray))).

fof(axMerge711, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_Sievert))).

fof(axMerge712, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_ElectronVolt))).

fof(axMerge713, axiom, 
 (hasType(type_UnitOfMass, inst_Gram))).

fof(axMerge714, axiom, 
 (hasType(type_UnitOfFrequency, inst_Hertz))).

fof(axMerge715, axiom, 
 (hasType(type_UnitOfTemperature, inst_KelvinDegree))).

fof(axMerge716, axiom, 
 (hasType(type_UnitOfMass, inst_Kilogram))).

fof(axMerge717, axiom, 
 (hasType(type_UnitOfLength, inst_Meter))).

fof(axMerge718, axiom, 
 (hasType(type_UnitOfMass, inst_Mole))).

fof(axMerge719, axiom, 
 (hasType(type_UnitOfAngularMeasure, inst_Radian))).

fof(axMerge720, axiom, 
 (hasType(type_UnitOfDuration, inst_SecondDuration))).

fof(axMerge721, axiom, 
 (hasType(type_UnitOfAngularMeasure, inst_Steradian))).

fof(axMerge722, axiom, 
 (hasType(type_AntiSymmetricPositionalAttribute, inst_Below))).

fof(axMerge723, axiom, 
 (hasType(type_AntiSymmetricPositionalAttribute, inst_Above))).

fof(axMerge724, axiom, 
 (hasType(type_AntiSymmetricPositionalAttribute, inst_Left))).

fof(axMerge725, axiom, 
 (hasType(type_AntiSymmetricPositionalAttribute, inst_Right))).

fof(axMerge726, axiom, 
 (hasType(type_TemperatureMeasure, inst_CelsiusDegree) & hasType(type_UnitOfMeasure, inst_CelsiusDegree))).

fof(axMerge727, axiom, 
 (hasType(type_UnitOfLength, inst_Centimeter))).

fof(axMerge728, axiom, 
 (hasType(type_TimeZone, inst_CentralTimeZone))).

fof(axMerge729, axiom, 
 (hasType(type_TimeZone, inst_CoordinatedUniversalTimeZone))).

fof(axMerge730, axiom, 
 (hasType(type_UnitOfVolume, inst_Cup))).

fof(axMerge731, axiom, 
 (hasType(type_SaturationAttribute, inst_Damp))).

fof(axMerge732, axiom, 
 (hasType(type_UnitOfDuration, inst_DayDuration))).

fof(axMerge733, axiom, 
 (hasType(type_SaturationAttribute, inst_Dry))).

fof(axMerge734, axiom, 
 (hasType(type_DirectionalAttribute, inst_East))).

fof(axMerge735, axiom, 
 (hasType(type_TimeZone, inst_EasternTimeZone))).

fof(axMerge736, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_ElectronVolt))).

fof(axMerge737, axiom, 
 (hasType(type_UnitOfCurrency, inst_EuroCent))).

fof(axMerge738, axiom, 
 (hasType(type_UnitOfCurrency, inst_EuroDollar))).

fof(axMerge739, axiom, 
 (hasType(type_UnitOfTemperature, inst_FahrenheitDegree))).

fof(axMerge740, axiom, 
 (hasType(type_TruthValue, inst_False))).

fof(axMerge741, axiom, 
 (hasType(type_SexAttribute, inst_Female))).

fof(axMerge742, axiom, 
 (hasType(type_ShapeAttribute, inst_Fillable))).

fof(axMerge743, axiom, 
 (hasType(type_PhysicalAttribute, inst_Flammable))).

fof(axMerge744, axiom, 
 (hasType(type_PhysicalState, inst_Fluid))).

fof(axMerge745, axiom, 
 (hasType(type_UnitOfLength, inst_FootLength))).

fof(axMerge746, axiom, 
 (hasType(type_DevelopmentalAttribute, inst_FullyFormed))).

fof(axMerge747, axiom, 
 (hasType(type_PhysicalState, inst_Gas))).

fof(axMerge748, axiom, 
 (hasType(type_PositionalAttribute, inst_Horizontal))).

fof(axMerge749, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_Horsepower))).

fof(axMerge750, axiom, 
 (hasType(type_UnitOfDuration, inst_HourDuration))).

fof(axMerge751, axiom, 
 (hasType(type_VisualAttribute, inst_Illuminated))).

fof(axMerge752, axiom, 
 (hasType(type_UnitOfLength, inst_Inch))).

fof(axMerge753, axiom, 
 (hasType(type_UnitOfAtmosphericPressure, inst_InchMercury))).

fof(axMerge754, axiom, 
 (hasType(type_UnitOfInformation, inst_KiloByte))).

fof(axMerge755, axiom, 
 (hasType(type_UnitOfLength, inst_Kilometer))).

fof(axMerge756, axiom, 
 (hasType(type_ProbabilityAttribute, inst_Likely))).

fof(axMerge757, axiom, 
 (hasType(type_PhysicalState, inst_Liquid))).

fof(axMerge758, axiom, 
 (hasType(type_UnitOfVolume, inst_Liter))).

fof(axMerge759, axiom, 
 (hasType(type_AnimacyAttribute, inst_Living))).

fof(axMerge760, axiom, 
 (hasType(type_SexAttribute, inst_Male))).

fof(axMerge761, axiom, 
 (hasType(type_UnitOfInformation, inst_MegaByte))).

fof(axMerge762, axiom, 
 (hasType(type_UnitOfLength, inst_Mile))).

fof(axMerge763, axiom, 
 (hasType(type_UnitOfLength, inst_Millimeter))).

fof(axMerge764, axiom, 
 (hasType(type_UnitOfDuration, inst_MinuteDuration))).

fof(axMerge765, axiom, 
 (hasType(type_UnitOfAtmosphericPressure, inst_MmMercury))).

fof(axMerge766, axiom, 
 (hasType(type_ColorAttribute, inst_Monochromatic))).

fof(axMerge767, axiom, 
 (hasType(type_UnitOfDuration, inst_MonthDuration))).

fof(axMerge768, axiom, 
 (hasType(type_TimeZone, inst_MountainTimeZone))).

fof(axMerge769, axiom, 
 (hasType(type_SymmetricPositionalAttribute, inst_Near))).

fof(axMerge770, axiom, 
 (hasType(type_AlethicAttribute, inst_Necessity))).

fof(axMerge771, axiom, 
 (hasType(type_TimePoint, inst_NegativeInfinity))).

fof(axMerge772, axiom, 
 (hasType(type_DevelopmentalAttribute, inst_NonFullyFormed))).

fof(axMerge773, axiom, 
 (hasType(type_DirectionalAttribute, inst_North))).

fof(axMerge774, axiom, 
 (hasType(type_List, inst_NullList))).

fof(axMerge775, axiom, 
 (hasType(type_PositiveRealNumber, inst_NumberE))).

fof(axMerge776, axiom, 
 (hasType(type_DeonticAttribute, inst_Obligation))).

fof(axMerge777, axiom, 
 (hasType(type_AntiSymmetricPositionalAttribute, inst_On))).

fof(axMerge778, axiom, 
 (hasType(type_UnitOfVolume, inst_Ounce))).

fof(axMerge779, axiom, 
 (hasType(type_TimeZone, inst_PacificTimeZone))).

fof(axMerge780, axiom, 
 (hasType(type_DeonticAttribute, inst_Permission))).

fof(axMerge781, axiom, 
 (hasType(type_PositiveRealNumber, inst_Pi))).

fof(axMerge782, axiom, 
 (hasType(type_UnitOfVolume, inst_Pint))).

fof(axMerge783, axiom, 
 (hasType(type_PhysicalState, inst_Plasma))).

fof(axMerge784, axiom, 
 (hasType(type_InternalAttribute, inst_Pliable))).

fof(axMerge785, axiom, 
 (hasType(type_ColorAttribute, inst_Polychromatic))).

fof(axMerge786, axiom, 
 (hasType(type_TimePoint, inst_PositiveInfinity))).

fof(axMerge787, axiom, 
 (hasType(type_AlethicAttribute, inst_Possibility))).

fof(axMerge788, axiom, 
 (hasType(type_CompositeUnitOfMeasure, inst_PoundForce))).

fof(axMerge789, axiom, 
 (hasType(type_UnitOfMass, inst_PoundMass))).

fof(axMerge790, axiom, 
 (hasType(type_DeonticAttribute, inst_Prohibition))).

fof(axMerge791, axiom, 
 (hasType(type_BodyPosition, inst_Prostrate))).

fof(axMerge792, axiom, 
 (hasType(type_UnitOfVolume, inst_Quart))).

fof(axMerge793, axiom, 
 (hasType(type_UnitOfTemperature, inst_RankineDegree))).

fof(axMerge794, axiom, 
 (hasType(type_PrimaryColor, inst_Red))).

fof(axMerge795, axiom, 
 (hasType(type_InternalAttribute, inst_Rigid))).

fof(axMerge796, axiom, 
 (hasType(type_TextureAttribute, inst_Rough))).

fof(axMerge797, axiom, 
 (hasType(type_BodyPosition, inst_Sitting))).

fof(axMerge798, axiom, 
 (hasType(type_UnitOfMass, inst_Slug))).

fof(axMerge799, axiom, 
 (hasType(type_TextureAttribute, inst_Smooth))).

fof(axMerge800, axiom, 
 (hasType(type_PhysicalState, inst_Solid))).

fof(axMerge801, axiom, 
 (hasType(type_DirectionalAttribute, inst_South))).

fof(axMerge802, axiom, 
 (hasType(type_BodyPosition, inst_Standing))).

fof(axMerge803, axiom, 
 (hasType(type_TruthValue, inst_True))).

fof(axMerge804, axiom, 
 (hasType(type_ConsciousnessAttribute, inst_Unconscious))).

fof(axMerge805, axiom, 
 (hasType(type_SocialRole, inst_Unemployed))).

fof(axMerge806, axiom, 
 (hasType(type_VisualAttribute, inst_Unilluminated))).

fof(axMerge807, axiom, 
 (hasType(type_UnitOfVolume, inst_UnitedKingdomGallon))).

fof(axMerge808, axiom, 
 (hasType(type_UnitOfCurrency, inst_UnitedStatesCent))).

fof(axMerge809, axiom, 
 (hasType(type_UnitOfCurrency, inst_UnitedStatesDollar))).

fof(axMerge810, axiom, 
 (hasType(type_UnitOfVolume, inst_UnitedStatesGallon))).

fof(axMerge811, axiom, 
 (hasType(type_ProbabilityAttribute, inst_Unlikely))).

fof(axMerge812, axiom, 
 (hasType(type_PositionalAttribute, inst_Vertical))).

fof(axMerge813, axiom, 
 (hasType(type_UnitOfDuration, inst_WeekDuration))).

fof(axMerge814, axiom, 
 (hasType(type_DirectionalAttribute, inst_West))).

fof(axMerge815, axiom, 
 (hasType(type_SaturationAttribute, inst_Wet))).

fof(axMerge816, axiom, 
 (hasType(type_PrimaryColor, inst_White))).

fof(axMerge817, axiom, 
 (hasType(type_UnitOfDuration, inst_YearDuration))).

fof(axMerge818, axiom, 
 (hasType(type_PrimaryColor, inst_Yellow))).

fof(axMerge819, axiom, 
 (hasType(type_DeonticAttribute, inst_Law))).

fof(axMerge820, axiom, 
 (hasType(type_DeonticAttribute, inst_Promise))).

fof(axMerge821, axiom, 
 (hasType(type_DeonticAttribute, inst_PurchaseContract))).

fof(axMerge822, axiom, 
 (hasType(type_DeonticAttribute, inst_Warranty))).

fof(axMerge823, axiom, 
 (hasType(type_DeonticAttribute, inst_NakedPromise))).

fof(axMerge824, axiom, 
 (hasType(type_AnimacyAttribute, inst_Dead) & hasType(type_ConsciousnessAttribute, inst_Dead))).

fof(axMerge825, axiom, 
 (hasType(type_DevelopmentalAttribute, inst_Larval))).

fof(axMerge826, axiom, 
 (hasType(type_DevelopmentalAttribute, inst_Embryonic))).

