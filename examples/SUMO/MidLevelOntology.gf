abstract MidLevelOntology = Merge, Elements ** {

  -- Removing a human fetus from a Pregnant woman 
  -- in such a way that the fetus cannot survive.
  fun Aborting : Class ;
  fun Aborting_Class : SubClass Aborting Removing ;

  -- A Certificate that demonstrates that the holder 
  -- of the Certificate has successfully completed an EducationalProgram.
  fun AcademicDegree : Class ;
  fun AcademicDegree_Class : SubClass AcademicDegree Certificate ;

  -- Increasing the speed with which someone 
  -- or something is moving.
  fun Accelerating : Class ;
  fun Accelerating_Class : SubClass Accelerating (both Increasing Translocation) ;

  -- The Profession of being an Accountant.
  fun Accountant : Ind Profession ;

  -- Any process of certifying an EducationalOrganization.
  fun Accrediting : Class ;
  fun Accrediting_Class : SubClass Accrediting Declaring ;

  -- AchievingControl is the
  -- class of all events in which an Agent gains physical
  -- control over some object.
  fun AchievingControl : Class ;
  fun AchievingControl_Class : SubClass AchievingControl Guiding ;

  -- A UnitOfMeasure equal to 4840 square yards.
  fun Acre : Ind UnitOfArea ;

  -- Any TwoDimensionalAngle that has an 
  -- angularMeasure that is less than 90 AngularDegrees.
  fun AcuteAngle : Class ;
  fun AcuteAngle_Class : SubClass AcuteAngle TwoDimensionalAngle ;

  -- A RelationalAttribute that indicates an address 
  -- where an Agent can regularly be contacted.
  fun Address : Class ;
  fun Address_Class : SubClass Address RelationalAttribute ;

  -- Combining a substance with Air.
  fun Aerating : Class ;
  fun Aerating_Class : SubClass Aerating Combining ;

  -- A Device whose purpose is to mix Substances with 
  -- Air.
  fun Aerator : Class ;
  fun Aerator_Class : SubClass Aerator Device ;

  -- An RecreationOrExerciseDevice whose purpose is 
  -- to develop the cardiovascular system.
  fun AerobicExerciseDevice : Class ;
  fun AerobicExerciseDevice_Class : SubClass AerobicExerciseDevice RecreationOrExerciseDevice ;

  -- The class of TimeIntervals that begin at noon and 
  -- end at Sunset.
  fun Afternoon : Class ;
  fun Afternoon_Class : SubClass Afternoon DayTime ;

  -- A CommercialAgent whose customers are all other 
  -- CommercialAgents, e.g. staffing agencies, food_service providers, etc.
  fun Agency : Class ;
  fun Agency_Class : SubClass Agency CommercialAgent ;

  -- AgriculturalProduct is the subclass of Product that comprises
  -- the products of agricultural activity.
  fun AgriculturalProduct : Class ;
  fun AgriculturalProduct_Class : SubClass AgriculturalProduct Product ;

  -- AirForce is the subclass of MilitaryService 
  -- that comprises military air forces.
  fun AirForce : Class ;
  fun AirForce_Class : SubClass AirForce MilitaryService ;

  -- Any instance of Transportation where the 
  -- instrument is an Aircraft and which is through an AtmosphericRegion.
  fun AirTransportation : Class ;
  fun AirTransportation_Class : SubClass AirTransportation Transportation ;

  -- Any Vehicle which is capable of 
  -- AirTransportation. Note that this class covers both fixed_wing aircraft
  -- and helicopters.
  fun Aircraft : Class ;
  fun Aircraft_Class : SubClass Aircraft Vehicle ;

  -- OrganicCompounds that are produced from hydrocarbons 
  -- by distillation.
  fun Alcohol : Class ;
  fun Alcohol_Class : SubClass Alcohol OrganicCompound ;

  -- Any Beverage that contains Alcohol.
  fun AlcoholicBeverage : Class ;
  fun AlcoholicBeverage_Class : SubClass AlcoholicBeverage (both Beverage Depressant) ;

  -- A ChemicalBase found in some Plants that has 
  -- physiological and psychological effects.
  fun Alkaloid : Class ;
  fun Alkaloid_Class : SubClass Alkaloid (both BiologicallyActiveSubstance ChemicalBase) ;

  -- Any Character that is comprised of a single 
  -- alphabetical character, e.g. A, B, C, D, ...
  fun AlphabeticCharacter : Class ;
  fun AlphabeticCharacter_Class : SubClass AlphabeticCharacter Character ;

  -- Tiny sacs in the Lung which absorb Oxygen 
  -- which is delivered to them by the BronchialDucts.
  fun Alveolus : Class ;
  fun Alveolus_Class : SubClass Alveolus (both AnimalAnatomicalStructure BodyVessel) ;

  -- Any Maneuver in a ViolentContest where one 
  -- contestParticipant attempts to conceal himself from another 
  -- contestParticipant so that he can Attack the other 
  -- contestParticipant.
  fun Ambush : Class ;
  fun Ambush_Class : SubClass Ambush Maneuver ;

  -- Organic acids that are the building blocks of 
  -- Proteins.
  fun AminoAcid : Class ;
  fun AminoAcid_Class : SubClass AminoAcid (both ChemicalAcid OrganicCompound) ;

  -- A very large Boa that is found in South America.
  fun Anaconda : Class ;
  fun Anaconda_Class : SubClass Anaconda ConstrictorSnake ;

  -- An RecreationOrExerciseDevice whose purpose 
  -- is to develop Muscles without also developing the cardiovascular system.
  fun AnaerobicExerciseDevice : Class ;
  fun AnaerobicExerciseDevice_Class : SubClass AnaerobicExerciseDevice RecreationOrExerciseDevice ;

  -- An AttachingDevice which is large hook or set of hooks 
  -- that are used to secure a Ship on the open water.
  fun Anchor : Class ;
  fun Anchor_Class : SubClass Anchor AttachingDevice ;

  -- The state of being wrathful, irate or indignant.
  fun Anger : Ind EmotionalState ;

  -- AnimalAgriculturalProduct is the class of AgriculturalProducts 
  -- that are animal in nature, including meat, fish, dairy products, 
  -- hides, furs, animal fats and oils, etc.
  fun AnimalAgriculturalProduct : Class ;
  fun AnimalAgriculturalProduct_Class : SubClass AnimalAgriculturalProduct AgriculturalProduct ;

  -- Any Device which is used to control the 
  -- movements of an Animal or Human, e.g. leashes, reins, harnesses, muzzles, 
  -- bridles, shackles, handcuffs, etc.
  fun AnimalController : Class ;
  fun AnimalController_Class : SubClass AnimalController Device ;

  -- AnimalPoweredDevice is the subclass 
  -- of Devices that function with power supplied by animals. Examples: 
  -- oxcarts, horse_drawn plows, mule_driven mills.
  fun AnimalPoweredDevice : Class ;
  fun AnimalPoweredDevice_Class : SubClass AnimalPoweredDevice Device ;

  -- An Artifact which is intended to house 
  -- Animals and not Humans. Note that an AnimalResidence may or may not 
  -- be a StationaryArtifact, e.g. a horse stall is stationary while a doghouse 
  -- generally is not.
  fun AnimalResidence : Class ;
  fun AnimalResidence_Class : SubClass AnimalResidence Artifact ;

  -- A hard shell of calcium that serves as a 
  -- supporting structure for some Invertebrates.
  fun AnimalShell : Class ;
  fun AnimalShell_Class : SubClass AnimalShell (both AnimalAnatomicalStructure BodyPart) ;

  -- A GroupOfAnimals which are Pulling something.
  fun AnimalTeam : Class ;
  fun AnimalTeam_Class : SubClass AnimalTeam GroupOfAnimals ;

  -- The joint in the Leg that connects the tibia and the 
  -- fibula to the talus.
  fun Ankle : Class ;
  fun Ankle_Class : SubClass Ankle BodyJoint ;

  -- Any Text which contains information about 
  -- an event in the future.
  fun Announcement : Class ;
  fun Announcement_Class : SubClass Announcement FactualText ;

  -- Responding to a Questioning, i.e. trying to answer 
  -- someone's question.
  fun Answering : Class ;
  fun Answering_Class : SubClass Answering Stating ;

  -- A colony Insect of three types: males, 
  -- QueenInsect, and worker ants.
  fun AntInsect : Class ;
  fun AntInsect_Class : SubClass AntInsect Insect ;

  -- The class of TimeIntervals that begin at midnight 
  -- and end at noon.
  fun AnteMeridiem : Class ;
  fun AnteMeridiem_Class : SubClass AnteMeridiem TimeInterval ;

  -- A HoofedMammal with long legs and backward_facing horns. 
  -- This class includes gazelles, addax, blackbucks, etc.
  fun Antelope : Class ;
  fun Antelope_Class : SubClass Antelope HoofedMammal ;

  -- A CommunicationDevice which enables or improves 
  -- the reception of RadioEmissions by another CommunicationDevice (the 
  -- radio or television receiver).
  fun Antenna : Class ;
  fun Antenna_Class : SubClass Antenna CommunicationDevice ;

  -- The field of anthropology.
  fun Anthropology : Ind SocialScience ;

  -- A BiologicallyActiveSubstance than can kill 
  -- instances of Bacterium.
  fun Antibiotic : Class ;
  fun Antibiotic_Class : SubClass Antibiotic BiologicallyActiveSubstance ;

  -- An immunoglobulin which is produced by the body 
  -- and which has the ability to neutralize Antigens.
  fun Antibody : Class ;
  fun Antibody_Class : SubClass Antibody Protein ;

  -- Any BiologicallyActiveSubstance that has the 
  -- capacity to stimulate the production of Antibodies.
  fun Antigen : Class ;
  fun Antigen_Class : SubClass Antigen BiologicallyActiveSubstance ;

  -- An Antigen that is carried in the red blood 
  -- cells of those with BloodTypeA.
  fun AntigenA : Class ;
  fun AntigenA_Class : SubClass AntigenA Antigen ;

  -- An Antigen that is carried in the red blood 
  -- cells of those with BloodTypeB.
  fun AntigenB : Class ;
  fun AntigenB_Class : SubClass AntigenB Antigen ;

  -- The BeliefGroup that is characterized by a 
  -- dislike for Judaism.
  fun Antisemitism : Ind BeliefGroup ;

  -- The state of being worried, troubled or uneasy.
  fun Anxiety : Ind EmotionalState ;

  -- A ResidentialBuilding containing 
  -- ApartmentUnits.
  fun ApartmentBuilding : Class ;
  fun ApartmentBuilding_Class : SubClass ApartmentBuilding ResidentialBuilding ;

  -- A SingleFamilyResidence that is not owned 
  -- by any member of the SocialUnit that lives there.
  fun ApartmentUnit : Class ;
  fun ApartmentUnit_Class : SubClass ApartmentUnit SingleFamilyResidence ;

  -- A FormText whose purpose is to obtain admission 
  -- to an Organization or to receive assistance from an Organization.
  fun Application : Class ;
  fun Application_Class : SubClass Application FormText ;

  -- Any instance of Declaring by which the 
  -- patient is assigned to a Position within an Organization where 
  -- the patient previously had no position. For example, the appointments 
  -- of people to non_elective offices in a government.
  fun Appointing : Class ;
  fun Appointing_Class : SubClass Appointing Declaring ;

  -- An item of Clothing that protects the front and 
  -- middle part of the body while one is Cooking or doing other work.
  fun Apron : Class ;
  fun Apron_Class : SubClass Apron Clothing ;

  -- The FieldOfStudy of designing Buildings, i.e. 
  -- creating Blueprints for Buildings.
  fun Architecture : Ind FieldOfStudy ;

  -- Any Stating which has the form of an Argument.
  fun Arguing : Class ;
  fun Arguing_Class : SubClass Arguing Stating ;

  -- The upper Limbs of a Primate.
  fun Arm : Class ;
  fun Arm_Class : SubClass Arm Limb ;

  -- MilitaryServices that are land forces.
  fun Army : Class ;
  fun Army_Class : SubClass Army MilitaryService ;

  -- The final part of any instance of Translocation.
  fun Arriving : Class ;
  fun Arriving_Class : SubClass Arriving Translocation ;

  -- An Icon which has the shape of an arrow and 
  -- which is used to indicate direction or a relationship betwee two things.
  fun ArrowFigure : Class ;
  fun ArrowFigure_Class : SubClass ArrowFigure Icon ;

  -- An Icon which has the shape of an arrow and which 
  -- is used to indicate direction or a relationship betwee two things.
  fun ArrowIcon : Class ;
  fun ArrowIcon_Class : SubClass ArrowIcon Icon ;

  -- A long, thin Projectile with a pointed tip is 
  -- fired from a bow.
  fun ArrowProjectile : Class ;
  fun ArrowProjectile_Class : SubClass ArrowProjectile Projectile ;

  -- An act where an agent sets something which it does not possess 
  -- on fire in order to destroy it or its contents.
  fun Arson : Class ;
  fun Arson_Class : SubClass Arson (both Combustion Destruction) ;

  -- The Profession of reporting and critiquing current 
  -- ArtWorks.
  fun ArtCritic : Ind Journalist ;

  -- Any ContentDevelopment that results in a 
  -- PaintedPicture.
  fun ArtPainting : Class ;
  fun ArtPainting_Class : SubClass ArtPainting (both ContentDevelopment Painting) ;

  -- Any School whose aim is to teach students 
  -- how to create ArtWorks.
  fun ArtSchool : Class ;
  fun ArtSchool_Class : SubClass ArtSchool School ;

  -- A Workshop, which is 
  -- devoted to the creation of ArtWorks.
  fun ArtStudio : Class ;
  fun ArtStudio_Class : SubClass ArtStudio Workshop ;

  -- Any BloodVessel which transfers Blood from 
  -- the Heart to the extremities of the body.
  fun Artery : Class ;
  fun Artery_Class : SubClass Artery BloodVessel ;

  -- A Gun that is too large to be carried and fired 
  -- by a single Human. Typically, ArtilleryGuns are on wheels.
  fun ArtilleryGun : Class ;
  fun ArtilleryGun_Class : SubClass ArtilleryGun Gun ;

  -- AtmosphericRegion is the class of 
  -- all subregions of EarthsAtmosphere.
  fun AtmosphericRegion : Class ;
  fun AtmosphericRegion_Class : SubClass AtmosphericRegion SpaceRegion ;

  -- Two or more Atoms that are bound together and 
  -- comprise part of a Molecule.
  fun AtomicGroup : Class ;
  fun AtomicGroup_Class : SubClass AtomicGroup CompoundSubstance ;

  -- Any decrease in the size of a BodyPart which is due to 
  -- disease or lack of use.
  fun Atrophy : Class ;
  fun Atrophy_Class : SubClass Atrophy (both Decreasing PathologicProcess) ;

  -- The Profession of practicing law, whether as a 
  -- judge or as a legal advocate.
  fun Attorney : Class ;

  -- The head law officer of a GeopoliticalArea, 
  -- usually a Nation or StateOrProvince.
  fun AttorneyGeneral : Ind (both Profession GovernmentOfficer) ;

  -- A representation of sound on some medium such
  -- as wax cylinder, vinyl record, magnetic tape, CD or flash memory, that is 
  -- intended to be used in some machine to reproduce that sound.
  fun AudioRecording : Class ;
  fun AudioRecording_Class : SubClass AudioRecording (both ContentBearingObject Text) ;

  -- Any Building whose purpose is to hold concerts, 
  -- sports events, plays, etc. before an audience. This class includes theaters, 
  -- sports stadiums, university auditoriums, etc.
  fun Auditorium : Class ;
  fun Auditorium_Class : SubClass Auditorium Building ;

  -- A Seat within an Auditorium from which one 
  -- can observe the PerformanceStage.
  fun AuditoriumSeat : Class ;
  fun AuditoriumSeat_Class : SubClass AuditoriumSeat Seat ;

  -- A Gun that fires a burst of Projectiles 
  -- with each pull of the trigger. Also known as a machine gun.
  fun AutomaticGun : Class ;
  fun AutomaticGun_Class : SubClass AutomaticGun Gun ;

  -- Automobile is a subclass of 
  -- SelfPoweredRoadVehicles including passenger cars, family vans, light 
  -- trucks, and sport utility vehicles. In general, this class covers 
  -- four_wheeled passenger road vehicles.
  fun Automobile : Class ;
  fun Automobile_Class : SubClass Automobile (both PassengerVehicle SelfPoweredRoadVehicle) ;

  -- Axle is a class of Devices each of which can 
  -- be paired with two VehicleWheels to rotate and move a RoadVehicle.
  fun Axle : Class ;
  fun Axle_Class : SubClass Axle Device ;

  -- A disease that is caused by instances of 
  -- Bacterium.
  fun BacterialDisease : Class ;
  fun BacterialDisease_Class : SubClass BacterialDisease InfectiousDisease ;

  -- Any Container which is made of Fabric.
  fun Bag : Class ;
  fun Bag_Class : SubClass Bag Container ;

  -- Any instance of Cooking where the instrument 
  -- is an Oven.
  fun Baking : Class ;
  fun Baking_Class : SubClass Baking (both Cooking Heating) ;

  -- Any GamePiece which has the shape of a sphere.
  fun Ball : Class ;
  fun Ball_Class : SubClass Ball GamePiece ;

  -- A Missile which is guided for the first stage 
  -- of its flight but then falls to its target for the second stage.
  fun BallisticMissile : Class ;
  fun BallisticMissile_Class : SubClass BallisticMissile Missile ;

  -- A FormText which is used in Voting. A list of 
  -- candidates is printed on the form, and the voter selects the candidate he/she 
  -- wants to vote for.
  fun Ballot : Class ;
  fun Ballot_Class : SubClass Ballot FormText ;

  -- A piece of Fabric that is used in Covering an 
  -- open wound.
  fun Bandage : Class ;
  fun Bandage_Class : SubClass Bandage Fabric ;

  -- Any SkilledOccupation which involves working in a 
  -- FinancialBank.
  fun Banker : Ind SkilledOccupation ;

  -- A ReligiousProcess which marks the acceptance of 
  -- the person being baptized into the ReligiousOrganization.
  fun Baptizing : Class ;
  fun Baptizing_Class : SubClass Baptizing (both JoiningAnOrganization ReligiousProcess) ;

  -- Offering to sell something to someone at a 
  -- reduced price.
  fun BargainSale : Class ;
  fun BargainSale_Class : SubClass BargainSale Offering ;

  -- Any instance of RadiatingSound which is produced 
  -- by a Canine.
  fun Barking : Class ;
  fun Barking_Class : SubClass Barking RadiatingSound ;

  -- A Building on a Farm that is used for keeping 
  -- DomesticAnimals, Fodder or harvested crops.
  fun Barn : Class ;
  fun Barn_Class : SubClass Barn Building ;

  fun BaseballBase : Class ;

  -- A BuildingLevel which satisfies two conditions, viz. it is 
  -- lower than all of the other BuildingLevels in the same Building and it is below 
  -- ground level.
  fun Basement : Class ;
  fun Basement_Class : SubClass Basement BuildingLevel ;

  -- Washing the entire body of a Human or Animal.
  fun Bathing : Class ;
  fun Bathing_Class : SubClass Bathing Washing ;

  -- A WashingDevice which is intended to be used by 
  -- Humans for washing their bodies. Note that this class covers bathtubs, showers, 
  -- etc.
  fun BathingDevice : Class ;
  fun BathingDevice_Class : SubClass BathingDevice WashingDevice ;

  -- A Room that contains a WashBasin and 
  -- possibly a Toilet.
  fun Bathroom : Class ;
  fun Bathroom_Room : SubClassC Bathroom Room (\R -> exists Toilet (\T -> located(var Toilet Physical ? T)(var Room Object ? R)));

  -- A thin stick which is used for OrchestralConducting.
  fun Baton : Class ;
  fun Baton_Class : SubClass Baton Device ;

  -- The process of transitioning from a state of 
  -- being Sober to a state of being Drunk.
  fun BecomingDrunk : Class ;
  fun BecomingDrunk_Class : SubClass BecomingDrunk PsychologicalProcess ;

  -- A piece of Furniture which is primarily for sleeping.
  fun Bed : Class ;
  fun Bed_Class : SubClass Bed Furniture ;

  -- A Room intended primarily for sleeping.
  fun Bedroom : Class ;
  fun Bedroom_Class : SubClass Bedroom Room ;

  -- A hairy Insect, some species of which produce honey 
  -- and/or sting.
  fun Bee : Class ;
  fun Bee_Class : SubClass Bee Insect ;

  -- Meat that was originally part of a Cow.
  fun Beef : Class ;
  fun Beef_Class : SubClass Beef Meat ;

  -- An AlcoholicBeverage that is prepared by fermenting 
  -- malt and hops.
  fun Beer : Class ;
  fun Beer_Class : SubClass Beer AlcoholicBeverage ;

  -- The TimeInterval that runs from 
  -- NegativeInfinity to the time of the birth of Christ.
  fun BeforeCommonEra : Ind TimeInterval ;

  -- The process of an Organization 
  -- commencing operations. In the case of a Corporation, this would be 
  -- the process of going into business.
  fun BeginningOperations : Class ;
  fun BeginningOperations_Class : SubClass BeginningOperations OrganizationalProcess ;

  -- A PercussionInstrument that produces a single tone 
  -- when it is struck.
  fun Bell : Class ;
  fun Bell_Class : SubClass Bell PercussionInstrument ;

  -- A piece of Clothing that is worn around the waist 
  -- to restrain another piece of clothing.
  fun Belt : Class ;
  fun Belt_Class : SubClass Belt Clothing ;

  -- Any UnilateralGiving where the agent 
  -- wills some part of his/her property to someone else upon his/her death.
  fun Bequeathing : Class ;
  fun Bequeathing_Class : SubClass Bequeathing UnilateralGiving ;

  -- A HistoricalAccount which is concerned 
  -- with the life of a single Human.
  fun Biography : Class ;
  fun Biography_Class : SubClass Biography HistoricalAccount ;

  -- The production of a zygote from the fusion 
  -- of a male and female gamete.
  fun BiologicalConception : Class ;
  fun BiologicalConception_Class : SubClass BiologicalConception OrganOrTissueProcess ;

  -- The Class of all biological species, i.e. 
  -- the class of all classes of Organism whose instances can interbreed.
  fun BiologicalSpecies : Class ;

  -- The study of the classification, development, and 
  -- functioning of Organisms.
  fun Biology : Ind Science ;

  -- Any DiagnosticProcess which involves the examination of 
  -- BodySubstances taken from a living Organism.
  fun Biopsy : Class ;
  fun Biopsy_Class : SubClass Biopsy (both DiagnosticProcess Removing) ;

  -- Any Egg that is produced by a Bird.
  fun BirdEgg : Class ;
  fun BirdEgg_Class : SubClass BirdEgg Egg ;

  -- Any instance of Grabbing where the instrument is 
  -- the Mouth of the agent.
  fun Biting : Class ;
  fun Biting_Class : SubClass Biting Grabbing ;

  -- A piece of Fabric whose purpose is to keep a 
  -- person who is in bed warm.
  fun Blanket : Class ;
  fun Blanket_Class : SubClass Blanket Fabric ;

  -- The release of Blood from an Animal in response 
  -- to an Injuring of some sort.
  fun Bleeding : Class ;
  fun Bleeding_Class : SubClass Bleeding AutonomicProcess ;

  -- The Attribute that applies to Animals and Humans 
  -- that are unable to see.
  fun Blind : Ind BiologicalAttribute ;

  -- Any Process where the stomach or instestines of a 
  -- Human or Animal become distended from excessive gas.
  fun Bloating : Class ;
  fun Bloating_Class : SubClass Bloating (both Increasing PathologicProcess) ;

  -- Any Maneuver in a Contest where one 
  -- contestParticipant attempts to deny access to something that is wanted 
  -- by another contestParticipant.
  fun Blockade : Class ;
  fun Blockade_Class : SubClass Blockade Maneuver ;

  -- A Cell that is normally present in Blood.
  fun BloodCell : Class ;
  fun BloodCell_Class : SubClass BloodCell (both AnimalAnatomicalStructure Cell) ;

  -- The subclass of Blood that contains AntigenA 
  -- and does not contain AntigenB.
  fun BloodTypeA : Class ;
  fun BloodTypeA_Class : SubClass BloodTypeA Blood ;

  -- The subclass of Blood that contains both 
  -- AntigenA and AntigenB.
  fun BloodTypeAB : Class ;
  fun BloodTypeAB_Class : SubClass BloodTypeAB Blood ;

  -- The subclass of Blood that contains AntigenB 
  -- and does not contain AntigenA.
  fun BloodTypeB : Class ;
  fun BloodTypeB_Class : SubClass BloodTypeB Blood ;

  -- The subclass of Blood that contains neither 
  -- AntigenA nor AntigenB.
  fun BloodTypeO : Class ;
  fun BloodTypeO_Class : SubClass BloodTypeO Blood ;

  -- Any BodyVessel which is used to circulate 
  -- Blood from one part of the body to another.
  fun BloodVessel : Class ;
  fun BloodVessel_Class : SubClass BloodVessel (both AnimalAnatomicalStructure BodyVessel) ;

  -- An Icon which is a scale model of an Artifact, 
  -- whether the Artifact actually exists or not.
  fun Blueprint : Class ;
  fun Blueprint_Class : SubClass Blueprint Icon ;

  -- The process of turning red in response to a 
  -- stimulus which has a deep emotional effect.
  fun Blushing : Class ;
  fun Blushing_Class : SubClass Blushing AutonomicProcess ;

  -- A piece of material with flat, rectangular sides. 
  -- Note that boards and blocks are lumped into a single concept, because the 
  -- difference between these notions cannot be precisely defined.
  fun BoardOrBlock : Class ;
  fun BoardOrBlock_Class : SubClass BoardOrBlock Artifact ;

  -- Getting on a Vehicle, e.g. getting into an 
  -- Automobile, boarding an Aircraft, etc.
  fun Boarding : Class ;
  fun Boarding_Class : SubClass Boarding Translocation ;

  -- One of the levels of a WaterVehicle, e.g. the 
  -- upper deck and lower deck of small boats with a cabin.
  fun BoatDeck : Class ;
  fun BoatDeck_Class : SubClass BoatDeck Artifact ;

  -- BodyJunctions where different parts of the same 
  -- Skeleton come together.
  fun BodyJoint : Class ;
  fun BodyJoint_Class : SubClass BodyJoint BodyJunction ;

  -- A BodyOfWater is a connected body of 
  -- water with established boundaries marked by either geographical features 
  -- or conventional borders.
  fun BodyOfWater : Class ;
  fun BodyOfWater_Class : SubClass BodyOfWater (both SelfConnectedObject WaterArea) ;

  -- A weapon that explodes in order to cause damage.
  fun Bomb : Class ;
  fun Bomb_Class : SubClass Bomb (both ExplosiveDevice Weapon) ;

  -- Any MilitaryAircraft whose purpose is to deliver 
  -- ExplosiveDevices.
  fun Bomber : Class ;
  fun Bomber_Class : SubClass Bomber MilitaryAircraft ;

  -- An act of Destruction where the thing destroyed
  -- is destroyed by means of an explosive device.
  fun Bombing : Class ;
  fun Bombing_Class : SubClass Bombing Destruction ;

  -- BotanicalTree is an imprecise term 
  -- for a perennial woody plant that is larger than a bush or shrub, 
  -- generally understood to describe a large growth having one main trunk 
  -- with few or no branches projecting from its base, a well_developed crown 
  -- of foliage, and a height at maturity of at least 12 feet.
  fun BotanicalTree : Class ;
  fun BotanicalTree_Class : SubClass BotanicalTree FloweringPlant ;

  -- A Container whose top is narrower than its bottom, which 
  -- has no handle, and which is intended to store Liquids.
  fun Bottle : Class ;
  fun Bottle_Class : SubClass Bottle FluidContainer ;

  -- Any downward motion of the body that indicates respect 
  -- for or submission to another Agent.
  fun Bowing : Class ;
  fun Bowing_Class : SubClass Bowing (both Gesture (both Inclining MotionDownward)) ;

  -- Any six_sided Container whose sides are 
  -- rectangular in shape.
  fun Box : Class ;
  fun Box_Class : SubClass Box Container ;

  -- A HumanChild who is Male.
  fun Boy : Class ;
  fun Boy_Class : SubClass Boy (both HumanChild Man) ;

  -- The seat of the central nervous system.
  fun Brain : Class ;
  fun Brain_Class : SubClass Brain (both AnimalAnatomicalStructure Organ) ;

  -- A DistilledAlcoholicBeverage that is prepared by 
  -- distilling Wine.
  fun Brandy : Class ;
  fun Brandy_Class : SubClass Brandy DistilledAlcoholicBeverage ;

  -- A MetallicAlloy made from Copper and Zinc.
  fun Brass : Class ;
  fun Brass_Class : SubClass Brass MetallicAlloy ;

  -- Food that consists largely of grain flour 
  -- and water. Note that this class covers crackers, cookies, as well as any 
  -- self_connected instance of bread, whether it is a loaf, a slice, a chunk 
  -- of bread, etc.
  fun BreadOrBiscuit : Class ;
  fun BreadOrBiscuit_Class : SubClass BreadOrBiscuit PreparedFood ;

  -- A subclass of Attributes for 
  -- characterizing the breakability of CorpuscularObjects.
  fun BreakabilityAttribute : Class ;
  fun BreakabilityAttribute_Class : SubClass BreakabilityAttribute InternalAttribute ;

  -- The paired Organs which are part of the chests 
  -- of Primates.
  fun Breast : Class ;
  fun Breast_Class : SubClass Breast (both AnimalAnatomicalStructure Organ) ;

  -- A block of fired Clay that is used in Constructing.
  fun Brick : Class ;
  fun Brick_Class : SubClass Brick BoardOrBlock ;

  -- A MilitaryGeneral that ranks below 
  -- a MajorGeneral.
  fun BrigadierGeneral : Class ;
  fun BrigadierGeneral_Class : SubClass BrigadierGeneral MilitaryGeneral ;

  -- BroadcastNetwork is the subclass of 
  -- CommunicationSystems consisting of BroadcastingStations that are linked 
  -- electronically and managed or owned by one organization.
  fun BroadcastNetwork : Class ;
  fun BroadcastNetwork_Class : SubClass BroadcastNetwork CommunicationSystem ;

  -- A Series of episodes that are broadcast 
  -- on television or radio.
  fun BroadcastProgram : Class ;
  fun BroadcastProgram_Class : SubClass BroadcastProgram Series ;

  -- Disseminating information by using a 
  -- CommunicationDevice that radiates RadioEmissions.
  fun Broadcasting : Class ;
  fun Broadcasting_Class : SubClass Broadcasting (both Disseminating RadioEmission) ;

  -- Any BodyVessel which is located in a 
  -- Lung and which carries oxygen from the trachea to the alveoli.
  fun BronchialDuct : Class ;
  fun BronchialDuct_Class : SubClass BronchialDuct (both AnimalAnatomicalStructure BodyVessel) ;

  -- A GroupOfAnimals that are all born at the same time 
  -- and to the same parents.
  fun Brood : Class ;
  fun Brood_Class : SubClass Brood GroupOfAnimals ;

  -- A BrushOrComb whose purpose is to remove dirt and other 
  -- small particles from floors.
  fun Broom : Class ;
  fun Broom_Class : SubClass Broom BrushOrComb ;

  -- A SecondaryColor that resembles the color of wood or 
  -- of soil.
  fun Brown : Ind SecondaryColor ;

  -- A Device which consists of a handle and bristles and 
  -- whose purpose is to remove particles from something or to smooth something out.
  fun BrushOrComb : Class ;
  fun BrushOrComb_Class : SubClass BrushOrComb Device ;

  -- A globe which has a Liquid surface and which contains 
  -- a Gas.
  fun Bubble : Class ;
  fun Bubble_Class : SubClass Bubble CorpuscularObject ;

  -- A HoofedMammal with long hair whose habitat is the 
  -- plains of NorthAmerica.
  fun Buffalo : Class ;
  fun Buffalo_Class : SubClass Buffalo HoofedMammal ;

  -- A HornInstrument that has no valves.
  fun Bugle : Class ;
  fun Bugle_Class : SubClass Bugle HornInstrument ;

  -- The story or level of a building, e.g. the Basement, 
  -- the Attic, the ground level, the fourteenth floor, etc.
  fun BuildingLevel : Class ;
  fun BuildingLevel_Class : SubClass BuildingLevel StationaryArtifact ;

  -- A Cow that is Male.
  fun Bull : Class ;
  fun Bull_Cow : SubClassC Bull Cow (\B -> attribute(var Cow Object ? B)(el SexAttribute Attribute ? Male));

  -- A Projectile that is designed to be fired by a Gun.
  fun Bullet : Class ;
  fun Bullet_Class : SubClass Bullet Projectile ;

  -- A large Bee which lacks a stinger.
  fun BumbleBee : Class ;
  fun BumbleBee_Class : SubClass BumbleBee Bee ;

  -- A small Cave created by an Animal for the purpose 
  -- of inhabiting it.
  fun Burrow : Class ;
  fun Burrow_Class : SubClass Burrow Cave ;

  -- Putting something in the ground and then covering 
  -- it with Soil.
  fun Burying : Class ;
  fun Burying_Class : SubClass Burying (both Digging Putting) ;

  -- Bus is the subclass of SelfPoweredRoadVehicles 
  -- that can transport large numbers of passengers (i.e., dozens) at one 
  -- time. It can be distinguished from a van which is
  -- designed to carry less than a dozen people.
  fun Bus : Class ;
  fun Bus_Class : SubClass Bus SelfPoweredRoadVehicle ;

  -- An area, often, though not necessarily with
  -- seats or some kind of minimal shelter, where people gather to meet and
  -- board a bus. It must border a road.
  fun BusStop : Class ;
  fun BusStop_Class : SubClass BusStop GeographicArea ;

  -- Any Contest where the contestParticipants 
  -- are Corporations and the aim is to win as many customers as possible.
  fun BusinessCompetition : Class ;
  fun BusinessCompetition_Class : SubClass BusinessCompetition Contest ;

  -- Any of a class of people in a professional 
  -- occupation such as banking, finance, management, or engineering. This is 
  -- distinguished from blue collar jobs that primarily involve manual labor 
  -- rather than thought as the effort expended to derive remuneration. It is 
  -- also distinguished from professions that may be outwardly similar but are 
  -- done in a non_profit organization.
  fun BusinessPerson : Ind OccupationalRole ;

  -- An emulsion of fat which is produced by churning Milk.
  fun Butter : Class ;
  fun Butter_Class : SubClass Butter (both DairyProduct PreparedFood) ;

  -- An AttachingDevice that is used on Clothing.
  fun Button : Class ;
  fun Button_Class : SubClass Button AttachingDevice ;

  -- Any Restaurant which does not offer table service. 
  -- Food is selected and purchased at a central counter.
  fun Cafeteria : Class ;
  fun Cafeteria_Class : SubClass Cafeteria Restaurant ;

  -- A young Cow, i.e. a Cow that is NonFullyFormed.
  fun Calf : Class ;
  fun Calf_Cow : SubClassC Calf Cow (\C -> attribute(var Cow Object ? C)(el DevelopmentalAttribute Attribute ? NonFullyFormed));

  -- A Device which is capable of Photographing.
  fun Camera : Class ;
  fun Camera_Class : SubClass Camera Device ;

  -- A MobileResidence consisting of tents and other temporary 
  -- living quarters that is constructed on an undeveloped LandArea.
  fun Camp : Class ;
  fun Camp_Class : SubClass Camp MobileResidence ;

  -- A LandArea whose purpose is to have MobileResidences 
  -- (e.g. recreational vehicles, mobile homes, Tents, etc.) located there.
  fun Campground : Class ;
  fun Campground_Class : SubClass Campground LandArea ;

  -- A DiseaseOrSyndrome characterized by pathologic and 
  -- uncontrolled cell division that results in a Tumor.
  fun Cancer : Ind DiseaseOrSyndrome ;

  -- An LightFixture that consists of Wax and a wick, 
  -- which is lit with a flame.
  fun Candle : Class ;
  fun Candle_Class : SubClass Candle LightFixture ;

  -- A very small BloodVessel that connects arterioles 
  -- (very small Arteries) with venules (very small Veins).
  fun Capillary : Class ;
  fun Capillary_Class : SubClass Capillary BloodVessel ;

  -- A commissioned MilitaryOfficer who ranks 
  -- above a Lieutenant but below a MajorOfficer.
  fun CaptainOfficer : Class ;
  fun CaptainOfficer_Class : SubClass CaptainOfficer MilitaryOfficer ;

  -- A Capturing is a ChangeOfControl event in which an Agent
  -- gains physical control over another Agent.
  fun Capturing : Class ;
  fun Capturing_Class : SubClass Capturing ChangeOfControl ;

  -- A car bombing is an attack in which a car is
  -- used as the delivery mechanism for a bomb. The car is usually destroyed
  -- in the blast if the bomb detonates successfully.
  fun CarBombing : Class ;
  fun CarBombing_Class : SubClass CarBombing Bombing ;

  -- Any Organization whose purpose is to 
  -- provide medical care for for Humans who reside there, either permanently 
  -- or temporarily.
  fun CareOrganization : Class ;
  fun CareOrganization_Class : SubClass CareOrganization Organization ;

  -- A Vehicle that is designed to
  -- carry Objects. Note that Vehicles that are primarily designed to carry
  -- people rather than cargo may still carry cargo. For example, a passenger sedan
  -- might be capable of carrying lumber strapped to the roof. For this
  -- reason, PassengerVehicle and CargoVehicle are not disjoint.
  fun CargoVehicle : Class ;
  fun CargoVehicle_Class : SubClass CargoVehicle Vehicle ;

  -- Any occupation that involves creating and repairing 
  -- structural and decorative portions of Buildings that are made chiefly of Wood.
  -- This does not include plumbing, roofing, electrical, foundation and site work.
  fun Carpenter : Ind OccupationalTrade ;

  -- Making Buildings out of Wood.
  fun Carpentry : Class ;
  fun Carpentry_Class : SubClass Carpentry Making ;

  -- Any Maneuver in a Game which results in a 
  -- situation where the agent grasps the Ball.
  fun Catching : Class ;
  fun Catching_Class : SubClass Catching (both Maneuver Touching) ;

  -- Any Process whose result is that the 
  -- patient of the process is happy.
  fun CausingHappiness : Class ;
  fun CausingHappiness_Class : SubClass CausingHappiness Process ;

  -- Any Process whose result is that the 
  -- patient of the process is in Pain.
  fun CausingPain : Class ;
  fun CausingPain_Class : SubClass CausingPain CausingUnhappiness ;

  -- Any Process whose result is that the 
  -- patient of the process is unhappy.
  fun CausingUnhappiness : Class ;
  fun CausingUnhappiness_Class : SubClass CausingUnhappiness Process ;

  -- MilitaryUnits composed primarily of Soldiers 
  -- who are mounted, i.e. who perform their combat missions from a Horse or 
  -- Vehicle.
  fun CavalryUnit : Class ;
  fun CavalryUnit_Class : SubClass CavalryUnit MilitaryUnit ;

  -- A Cave is a naturally formed opening beneath 
  -- the surface of the Earth, generally formed by dissolution of carbonate 
  -- bedrock. Caves may also form by erosion of coastal bedrock, partial 
  -- melting of glaciers, or solidification of lava into hollow tubes.
  fun Cave : Class ;
  fun Cave_Class : SubClass Cave Hole ;

  -- The process of an Organization 
  -- ceasing operations, i.e. its folding or going out of business in 
  -- some other fashion.
  fun CeasingOperations : Class ;
  fun CeasingOperations_Class : SubClass CeasingOperations OrganizationalProcess ;

  -- A StationaryArtifact that is the top surface 
  -- of a Room.
  fun Ceiling : Class ;
  fun Ceiling_Class : SubClass Ceiling StationaryArtifact ;

  -- Anyone who is known by a large number of people,
  -- either explicitly by name, or by action.
  fun Celebrity : Class ;

  -- The part of the Cell that contains DNA and 
  -- RNA.
  fun CellNucleus : Class ;
  fun CellNucleus_Class : SubClass CellNucleus OrganicObject ;

  -- The main component of Plant Tissue.
  fun Cellulose : Class ;
  fun Cellulose_Class : SubClass Cellulose (both Carbohydrate PlantSubstance) ;

  -- A LandArea which is used for burying the dead.
  fun Cemetery : Class ;
  fun Cemetery_Class : SubClass Cemetery LandArea ;

  -- Any instance of Rotating where there is 
  -- Motion away from the center of the Rotating.
  fun CentrifugalMotion : Class ;
  fun CentrifugalMotion_Class : SubClass CentrifugalMotion Rotating ;

  -- Any instance of Rotating where there is 
  -- Motion towards the center of the Rotating.
  fun CentripetalMotion : Class ;
  fun CentripetalMotion_Class : SubClass CentripetalMotion Rotating ;

  -- The TimeDuration of 100 years.
  fun CenturyDuration : Ind UnitOfDuration ;

  -- Any Seed which is produced by the cereal grasses, 
  -- e.g. rice, corn, wheat, etc.
  fun CerealGrain : Class ;
  fun CerealGrain_Class : SubClass CerealGrain (both (both Food Seed) PlantAgriculturalProduct) ;

  -- A Seat that is designed to accommodate a single 
  -- Human.
  fun Chair : Class ;
  fun Chair_Class : SubClass Chair Seat ;

  -- A ChangeOfControl is an event in which an agent gains
  -- physical control over some object that was previously controlled
  -- by a different agent.
  fun ChangeOfControl : Class ;
  fun ChangeOfControl_Class : SubClass ChangeOfControl AchievingControl ;

  -- Any instance of a process of 
  -- RemovingClothing and Dressing.
  fun ChangingClothing : Class ;
  fun ChangingClothing_Class : SubClass ChangingClothing Transfer ;

  -- A numbered and/or titled
  -- section of a Book, which is typically indicated in a table of
  -- contents for the Book.
  fun Chapter : Class ;
  fun Chapter_Class : SubClass Chapter Article ;

  -- An activity of a fee being charged
  fun ChargingAFee : Class ;
  fun ChargingAFee_Class : SubClass ChargingAFee FinancialTransaction ;

  -- An Icon which depicts one or more quantities.
  fun Chart : Class ;
  fun Chart_Class : SubClass Chart Icon ;

  -- An area on or very near a border, usually along 
  -- a road connecting two regions, where MilitaryPersons or Police 
  -- restrict the flow of traffic in order to extract tarrifs, deny movement to 
  -- certain kinds of people or goods, or other enforement actions. Because of 
  -- the power relationship involved, such areas are often the site of illegal 
  -- activities conducted by the officials in order to extract favors or 
  -- bribes.
  fun Checkpoint : Class ;
  fun Checkpoint_Class : SubClass Checkpoint GeographicArea ;

  -- A bitter CompoundSubstance that is capable of 
  -- reacting with a ChemicalBase and forming a ChemicalSalt.
  fun ChemicalAcid : Class ;
  fun ChemicalAcid_Class : SubClass ChemicalAcid CompoundSubstance ;

  -- An attack against people or property in which
  -- a chemical agent is used as the active ingredient of the attack.
  fun ChemicalAttack : Class ;
  fun ChemicalAttack_Class : SubClass ChemicalAttack ViolentContest ;

  -- A CompoundSubstance that is capable of 
  -- reacting with a ChemicalAcid and forming a ChemicalSalt.
  fun ChemicalBase : Class ;
  fun ChemicalBase_Class : SubClass ChemicalBase CompoundSubstance ;

  -- The Attribute of being in a chemically 
  -- stable state, i.e. the relative proportions of resources and results will 
  -- not longer change.
  fun ChemicalEquilibrium : Ind InternalAttribute ;

  -- Any ChemicalProcess where Electrons 
  -- are added to the substance undergoing the ChemicalProcess.
  fun ChemicalReduction : Class ;
  fun ChemicalReduction_Class : SubClass ChemicalReduction ChemicalSynthesis ;

  -- A bitter CompoundSubstance that is formed in a 
  -- chemical reaction of a ChemicalBase with a ChemicalAcid.
  fun ChemicalSalt : Class ;
  fun ChemicalSalt_Class : SubClass ChemicalSalt CompoundSubstance ;

  -- The study of the compositions, properties, and 
  -- reactions of Substances.
  fun Chemistry : Ind Science ;

  -- Any piece of Furniture which is also a 
  -- Container, e.g. a chest of drawers, a memory chest, an armoire, etc.
  fun ChestOrCabinet : Class ;
  fun ChestOrCabinet_Class : SubClass ChestOrCabinet (both Container Furniture) ;

  -- Breaking up or mashing Food with one's teeth.
  fun Chewing : Class ;
  fun Chewing_Class : SubClass Chewing BodyMotion ;

  -- A subclass of Bird that is raised for its meat 
  -- and for its eggs.
  fun Chicken : Class ;
  fun Chicken_Class : SubClass Chicken Poultry ;

  -- Meat that was originally part of a Chicken.
  fun ChickenMeat : Class ;
  fun ChickenMeat_Class : SubClass ChickenMeat Meat ;

  -- A thin passageway through which Smoke from a controlled 
  -- fire is conducted Outside of a Building or Room.
  fun Chimney : Class ;
  fun Chimney_Class : SubClass Chimney (both Device StationaryArtifact) ;

  -- A part of the Face which protrudes slightly and which 
  -- is lower than all other parts of the Face.
  fun Chin : Class ;
  fun Chin_Class : SubClass Chin (both AnimalAnatomicalStructure BodyPart) ;

  -- A Steroid that is produced by the Liver and that 
  -- is believed to be closely associated with various cardiological disorders.
  fun Cholesterol : Class ;
  fun Cholesterol_Class : SubClass Cholesterol (both AnimalSubstance Steroid) ;

  -- Planning that results in a sequence of dance 
  -- steps that are executed as part of a Performance.
  fun Choreographing : Class ;
  fun Choreographing_Class : SubClass Choreographing Planning ;

  -- Any instance of the collection of writings which 
  -- is regarded as scripture by those who embrace Christianity.
  fun ChristianBible : Class ;
  fun ChristianBible_Class : SubClass ChristianBible Book ;

  -- Four books in the New Testament of the 
  -- ChristianBible that describe the life and teachings of Jesus Christ 
  -- and that are referred to, respectively, as Matthew, Mark, Luke, and John.
  fun ChristianGospel : Class ;
  fun ChristianGospel_Class : SubClass ChristianGospel Text ;

  -- Any ReligiousService that is conducted by 
  -- members of Christianity.
  fun ChristianService : Class ;
  fun ChristianService_Class : SubClass ChristianService ReligiousService ;

  -- Processes of Separating a LiquidMixture or 
  -- a GasMixture into some or all of the PureSubstances that comprise it.
  fun Chromatography : Class ;
  fun Chromatography_Class : SubClass Chromatography Separating ;

  -- A tube of thin paper containing finely ground 
  -- tobacco that is smoked.
  fun CigarOrCigarette : Class ;
  fun CigarOrCigarette_Class : SubClass CigarOrCigarette SmokingDevice ;

  -- A slice of a Circle, i.e. any 
  -- ClosedTwoDimensionalFigure which consists of two Radii and the arc of 
  -- the Circle that they bound.
  fun CircleSector : Class ;
  fun CircleSector_Class : SubClass CircleSector ClosedTwoDimensionalFigure ;

  -- Removing the foreskin of the penis. This is
  -- usually performed on infants, but is occasionally performed on adolescents
  -- and adults, either for medical reasons, or after religious conversion. It is
  -- often conducted as a religious rite, since it is prescribed by both the
  -- Jewish and Muslim religions, although it is prevalent also as a social
  -- norm in the UnitedStates and other Nations.
  fun Circumision : Class ;
  fun Circumision_Class : SubClass Circumision (both Removing Surgery) ;

  -- (CitizenryFn ?AREA) denotes the 
  -- GroupOfPeople who are legal and permanent residents of the 
  -- GeopoliticalArea ?AREA.
  fun CitizenryFn : El GeopoliticalArea -> Ind GroupOfPeople ;

  -- A square_shaped area surrounded by Roadways 
  -- which is part of a City and typically contains Buildings.
  fun CityBlock : Class ;
  fun CityBlock_Class : SubClass CityBlock LandArea ;

  -- Any geopoliticalSubdivision of a City.
  fun CityDistrict : Class ;
  fun CityDistrict_Class : SubClass CityDistrict GeopoliticalArea ;

  -- CityGovernment is the class of 
  -- governments of Cities.
  fun CityGovernment : Class ;
  fun CityGovernment_Class : SubClass CityGovernment Government ;

  -- A War in which the fighting GeopoliticalAreas 
  -- are both part of the same Nation.
  fun CivilWar : Class ;
  fun CivilWar_Class : SubClass CivilWar War ;

  -- Someone who is not a member of an active
  -- MilitaryOrganization.
  fun Civilian : Class ;
  fun Civilian_Class : SubClass Civilian SocialRole ;

  -- An AttachingDevice which is designed to attach 
  -- two things together by means of a movable part which can be tightened 
  -- or loosened.
  fun Clamp : Class ;
  fun Clamp_Class : SubClass Clamp AttachingDevice ;

  -- Bringing the Hands together repeatedly to make 
  -- a loud noise.
  fun Clapping : Class ;
  fun Clapping_Class : SubClass Clapping (both HandGesture (both Impacting RadiatingSound)) ;

  -- A ClassificationScheme is a conceptual structure, 
  -- an abstract arrangement of concepts and the relations that link them.
  fun ClassificationScheme : Class ;
  fun ClassificationScheme_Class : SubClass ClassificationScheme Proposition ;

  -- Any Room in a School where education 
  -- takes place.
  fun Classroom : Class ;
  fun Classroom_Class : SubClass Classroom Room ;

  -- The Profession of being in charge of or ministering 
  -- to a ReligousOrganization.
  fun Cleric : Class ;
  fun Cleric_Class : SubClass Cleric ReligiousPosition ;

  -- The class of Positions where the position 
  -- holder is responsible for clerical duties, e.g. typing documents, answering 
  -- phones, keeping schedules, etc.
  fun ClericalSecretary : Ind SkilledOccupation ;

  -- A piece of Clothing that covers the whole body 
  -- except the face (and possibly entire head), hands, and feet.
  fun Cloak : Class ;
  fun Cloak_Class : SubClass Cloak Clothing ;

  -- Any Device that measures and represents TimeDuration 
  -- or TimePosition.
  fun Clock : Class ;
  fun Clock_Class : SubClass Clock MeasuringDevice ;

  -- A relatively small Room used for storage.
  fun Closet : Class ;
  fun Closet_Class : SubClass Closet Room ;

  -- The Class of Processes where an aperture is 
  -- closed in an Object.
  fun Closing : Class ;
  fun Closing_Class : SubClass Closing Motion ;

  -- Completing a Contract of some sort, 
  -- e.g. the purchase of a house, closing a business deal, etc.
  fun ClosingContract : Class ;
  fun ClosingContract_Class : SubClass ClosingContract Committing ;

  -- The EyeMotion of tensing the eye lids so that 
  -- the corneas are not exposed to light.
  fun ClosingEyes : Class ;
  fun ClosingEyes_Class : SubClass ClosingEyes (both Closing EyeMotion) ;

  -- A Collection of instances of Clothing that 
  -- are designed to be worn together.
  fun ClothingSuit : Class ;
  fun ClothingSuit_Class : SubClass ClothingSuit Collection ;

  -- Any occupation that involves training an athlete or a 
  -- sports team.
  fun Coach : Ind SkilledOccupation ;

  -- CoastGuard is the subclass of GovernmentOrganizations 
  -- that enforce the maritime laws of a Nation and guard its Seacoast. This may be 
  -- a military or quasi_military organization.
  fun CoastGuard : Class ;
  fun CoastGuard_Class : SubClass CoastGuard GovernmentOrganization ;

  -- Clothing that has sleeves and covers from the neck 
  -- down. Coats are intended to be worn outdoors.
  fun Coat : Class ;
  fun Coat_Class : SubClass Coat OutdoorClothing ;

  -- A Beverage which is prepared by infusing ground, 
  -- roasted coffee beans into hot water.
  fun Coffee : Class ;
  fun Coffee_Class : SubClass Coffee (both Beverage PreparedFood) ;

  -- A Container for a HumanCorpse.
  fun Coffin : Class ;
  fun Coffin_Class : SubClass Coffin Container ;

  -- Any abstract ArtWork that is produced by arranging 
  -- bits of paper or photographs.
  fun Collage : Class ;
  fun Collage_Class : SubClass Collage ArtWork ;

  -- A piece of Clothing that fits around the Neck. 
  -- A Collar is always part of a Coat or a Shirt.
  fun Collar : Class ;
  fun Collar_Class : SubClass Collar Clothing ;

  -- A School which admits students who have 
  -- graduated from high school and which confers a bachelor's degree, 
  -- normally requiring four years of study. Note that a College does 
  -- not confer any graduate degrees. For institutions that confer both 
  -- bachelor's and graduate degrees, the concept University should be 
  -- used.
  fun College : Class ;
  fun College_Class : SubClass College PostSecondarySchool ;

  -- The Positions of a student at a PostSecondarySchool 
  -- who has completed less than one year at the school.
  fun CollegeFreshman : Ind CollegeStudentPosition ;

  -- The Positions of a student at a PostSecondarySchool 
  -- who has completed at least two years and less than three years at the school.
  fun CollegeJunior : Ind CollegeStudentPosition ;

  -- The Positions of a student at a PostSecondarySchool 
  -- who has completed at least three years and less than four years at the school.
  fun CollegeSenior : Ind CollegeStudentPosition ;

  -- The Positions of a student at a PostSecondarySchool 
  -- who has completed at least one year and less than two years at the school.
  fun CollegeSophomore : Ind CollegeStudentPosition ;

  -- Any Position at a PostSecondarySchool 
  -- which is occupied exclusively by students.
  fun CollegeStudentPosition : Class ;
  fun CollegeStudentPosition_Class : SubClass CollegeStudentPosition Position ;

  -- A commissioned MilitaryOfficer who ranks above 
  -- a lieutenant colonel and below a brigadier general.
  fun Colonel : Class ;
  fun Colonel_Class : SubClass Colonel MilitaryOfficer ;

  -- Positions which involve performing stand_up comedy, which 
  -- is recorded and/or performed in front of live audiences.
  fun Comedian : Ind EntertainmentProfession ;

  -- A Building which is intended for 
  -- organizational activities, e.g. retail or wholesale selling, manufacturing, 
  -- office work, etc.
  fun CommercialBuilding : Class ;
  fun CommercialBuilding_Class : SubClass CommercialBuilding (both Building PlaceOfCommerce) ;

  -- CommercialShipping is the subclass of 
  -- Transportation events in which a commercial agent provides transportation 
  -- of goods for remuneration.
  fun CommercialShipping : Class ;
  fun CommercialShipping_Class : SubClass CommercialShipping (both CommercialService Shipping) ;

  -- A Room or suite of Rooms intended for 
  -- clerical and/or professional work of a single Organization.
  fun CommercialUnit : Class ;
  fun CommercialUnit_Class : SubClass CommercialUnit PlaceOfCommerce ;

  -- A small, temporary Organization whose purpose 
  -- is to investigate some issue.
  fun Commission : Class ;
  fun Commission_Class : SubClass Commission Organization ;

  -- The TimeInterval that runs from the supposed 
  -- time of the death of Christ to PositiveInfinity.
  fun CommonEra : Ind TimeInterval ;

  -- A CommunicationDevice is a Device
  -- which serves at the instrument in a Communication Process by allowing
  -- the communicated message to be conveyed between the participants.
  fun CommunicationDevice : Class ;
  fun CommunicationDevice_Class : SubClass CommunicationDevice EngineeringComponent ;

  -- CommunicationOrganization is 
  -- the subclass of Organizations that manage Communications over physical 
  -- infrastructure owned or leased by the organization. Such organizations 
  -- may also produce and disseminate information, entertainment, or other 
  -- content. Also see MediaOrganization.
  fun CommunicationOrganization : Class ;
  fun CommunicationOrganization_Class : SubClass CommunicationOrganization Organization ;

  -- CommunicationSystem is a complex 
  -- system with various components, enabling communication (in some 
  -- medium) between points in a specific area, whether local or worldwide.
  fun CommunicationSystem : Class ;
  fun CommunicationSystem_Class : SubClass CommunicationSystem Collection ;

  -- Any PoliticalParty that advocates for a 
  -- CommunistState.
  fun CommunistParty : Class ;
  fun CommunistParty_Class : SubClass CommunistParty PoliticalParty ;

  -- A Container which is part of another Container, 
  -- e.g. a drawer, a zippered pouch in a piece of luggage, a compartment in a TV 
  -- dinner, etc.
  fun Compartment : Class ;
  fun Compartment_Class : SubClass Compartment Container ;

  -- A Device that indicates the direction of the
  -- various DirectionalAttributes with respect to the device.
  fun Compass : Class ;
  fun Compass_Class : SubClass Compass (both ContentBearingObject Device) ;

  -- ContentDevelopment which results in a 
  -- MusicalComposition.
  fun Composing : Class ;
  fun Composing_Class : SubClass Composing ContentDevelopment ;

  -- ContentDevelopment which results in a 
  -- MusicalComposition.
  fun ComposingMusic : Class ;
  fun ComposingMusic_Class : SubClass ComposingMusic ContentDevelopment ;

  -- Locating something in such a way that it cannot 
  -- be seen.
  fun Concealing : Class ;
  fun Concealing_Class : SubClass Concealing Putting ;

  -- A ResidentialBuilding containing 
  -- CondominiumUnits.
  fun CondominiumBuilding : Class ;
  fun CondominiumBuilding_Class : SubClass CondominiumBuilding ResidentialBuilding ;

  -- A SingleFamilyResidence that may be owned 
  -- by a member of the SocialUnit that lives there.
  fun CondominiumUnit : Class ;
  fun CondominiumUnit_SingleFamilyResidence : SubClassC CondominiumUnit SingleFamilyResidence (\UNIT -> exists Human (\PERSON -> and ( home (var Human Human ? PERSON)(var SingleFamilyResidence PermanentResidence ? UNIT))( possesses(var Human Agent ? PERSON)(var SingleFamilyResidence Object ? UNIT))));

  -- The class of ThreeDimensionalFigures which are 
  -- produced by rotating a RightTriangle around its RightAngle.
  fun Cone : Class ;
  fun Cone_Class : SubClass Cone ThreeDimensionalFigure ;

  -- Any Soldier that served on the confederate side 
  -- during the American Civil War. ConfederateSoldier Any Soldier that served on the
  -- confederate side during the American Civil War.
  fun ConfederateSoldier : Class ;
  fun ConfederateSoldier_Class : SubClass ConfederateSoldier Soldier ;

  -- The eleven states of the UnitedStates 
  -- that tried to secede from the UnitedStates.
  fun ConfederateStatesOfAmerica : Ind GeopoliticalArea ;

  -- Any ExpressingApproval to a person for 
  -- something that the person did in the past and that is regarded as being 
  -- to the benefit of the person congratulated.
  fun Congratulating : Class ;
  fun Congratulating_Class : SubClass Congratulating ExpressingApproval ;

  -- A CompoundSubstance that results from 
  -- the ChemicalSynthesis of two or more CompoundSubstances.
  fun ConjugatedSubstance : Class ;
  fun ConjugatedSubstance_Class : SubClass ConjugatedSubstance CompoundSubstance ;

  -- An AlphabeticCharacter that denotes a speech sound 
  -- that results in audible friction when it is pronounced.
  fun Consonant : Class ;
  fun Consonant_Class : SubClass Consonant AlphabeticCharacter ;

  -- A Snake that lacks venom and kills its 
  -- prey by crushing it to death.
  fun ConstrictorSnake : Class ;
  fun ConstrictorSnake_Class : SubClass ConstrictorSnake Snake ;

  -- Any Holder whose purpose is to contain 
  -- something else. Note that Container is more specific in meaning 
  -- than Holder, because a Container must have a Hole that is at 
  -- least partially filled by the thing contained.
  fun Container : Class ;
  fun Container_Class : SubClass Container Holder ;

  -- ContainerEmpty is the Attribute of a 
  -- Container that is empty.
  fun ContainerEmpty : Ind RelationalAttribute ;

  -- ContainerFull is the Attribute of a 
  -- Container that is full to capacity.
  fun ContainerFull : Ind RelationalAttribute ;

  -- Devices which permit sexual intercourse but 
  -- which reduce the likelihood of conception.
  fun ContraceptiveDevice : Class ;
  fun ContraceptiveDevice_Class : SubClass ContraceptiveDevice Device ;

  -- A group of vehicles that all are being driven
  -- in formation (e.g., lines, rows, columns) to the same destination.
  -- That destination may be an intermediate destination on the way to a
  -- final destination for some of the vehicles however. This is
  -- distinguished from vehicles that have no common purpose, such as
  -- traffic on a freeway. This includes cases where some of the agents
  -- driving the vehicles intend to reach a point but fail to do so.
  fun Convoy : Class ;
  fun Convoy_Class : SubClass Convoy Collection ;

  -- A Device whose purpose is Cooling something, 
  -- e.g. air conditioners, refrigerators, freezers, etc.
  fun CoolingDevice : Class ;
  fun CoolingDevice_Class : SubClass CoolingDevice Device ;

  -- Making a copy of something.
  fun Copying : Class ;
  fun Copying_Class : SubClass Copying Making ;

  -- A GovernmentOfficer who investigates deaths that are 
  -- suspected of being due to something other than natural causes.
  fun Coroner : Ind GovernmentOfficer ;

  -- A noncomissioned MilitaryOfficer.
  fun Corporal : Class ;
  fun Corporal_Class : SubClass Corporal MilitaryOfficer ;

  -- Instances of LinguisticCommunication which 
  -- are achieved by means of Texts that are mailed between the persons 
  -- communicating with one another.
  fun Corresponding : Class ;
  fun Corresponding_Class : SubClass Corresponding LinguisticCommunication ;

  -- Fibers from the cotton plant that are used in 
  -- Making CottonFabric.
  fun Cotton : Class ;
  fun Cotton_Class : SubClass Cotton PlantAnatomicalStructure ;

  -- Any Fabric that is made entirely out of Cotton.
  fun CottonFabric : Class ;
  fun CottonFabric_Class : SubClass CottonFabric Fabric ;

  -- Any Room whose purpose is to realize 
  -- JudicialProcesses.
  fun CourtRoom : Class ;
  fun CourtRoom_Class : SubClass CourtRoom Room ;

  -- A domesticated HoofedMammal that is raised for milk 
  -- and beef, and is also used for work.
  fun Cow : Class ;
  fun Cow_Class : SubClass Cow (both DomesticAnimal HoofedMammal) ;

  -- Crane is a subclass of mechanical Devices 
  -- that consist of a HoistingDevice on a moveable boom, designed to 
  -- assist in moving heavy loads.
  fun Crane : Class ;
  fun Crane_Class : SubClass Crane MaterialHandlingEquipment ;

  -- Creek is the class of small streams of fresh 
  -- water flowing through land, usually into a River.
  fun Creek : Class ;
  fun Creek_Class : SubClass Creek (both BodyOfWater (both FreshWaterArea StreamWaterArea)) ;

  -- Any IntentionalProcess that violates a Law.
  fun CriminalAction : Class ;
  fun CriminalAction_Class : SubClass CriminalAction IntentionalProcess ;

  -- A GroupOfPeople which exists (partially or 
  -- wholly) for the purpose of CriminalAction.
  fun CriminalGang : Class ;
  fun CriminalGang_Class : SubClass CriminalGang GroupOfPeople ;

  -- A LandArea which is dedicated to 
  -- Agriculture, e.g. Lawns, gardens, and fields for growing crops.
  fun CultivatedLandArea : Class ;
  fun CultivatedLandArea_Class : SubClass CultivatedLandArea LandArea ;

  -- A raised concrete or asphalt structure that connects a 
  -- Sidewalk with a Roadway.
  fun Curb : Class ;
  fun Curb_Class : SubClass Curb StationaryArtifact ;

  -- Any instance of Currency that is made 
  -- of paper.
  fun CurrencyBill : Class ;
  fun CurrencyBill_Class : SubClass CurrencyBill Currency ;

  -- Any instance of Currency that is made 
  -- of Metal.
  fun CurrencyCoin : Class ;
  fun CurrencyCoin_Class : SubClass CurrencyCoin Currency ;

  -- A piece of Fabric whose purpose is Covering a 
  -- Window so as to keep out the light or prevent people from seeing inside.
  fun Curtain : Class ;
  fun Curtain_Class : SubClass Curtain (both Fabric WindowCovering) ;

  -- Any Device whose purpose is Cutting something 
  -- else. This class covers knives of all times, axes, saws, razors, chisels etc.
  fun CuttingDevice : Class ;
  fun CuttingDevice_Class : SubClass CuttingDevice Device ;

  -- The class of ThreeDimensionalFigures such that 
  -- all GeometricPoints that make up the Cylinder are equidistant from a 
  -- OneDimensionalFigure, known as the axis of the Cylinder.
  fun Cylinder : Class ;
  fun Cylinder_Class : SubClass Cylinder ThreeDimensionalFigure ;

  fun DairyProduct : Class ;
  fun DairyProduct_Class : SubClass DairyProduct AnimalAgriculturalProduct ;

  -- A School that does not board its students, i.e. 
  -- students attend classes during the day and then return to a private residence 
  -- for the night.
  fun DaySchool : Class ;
  fun DaySchool_Class : SubClass DaySchool School ;

  -- The class of TimeIntervals that begin at Sunrise 
  -- and end at Sunset.
  fun DayTime : Class ;
  fun DayTime_Class : SubClass DayTime TimeInterval ;

  -- Any Position within a ReligiousOrganization that is held 
  -- by a layman, which is part_time, and which involves assisting a Cleric.
  fun Deacon : Class ;
  fun Deacon_Class : SubClass Deacon PartTimePosition ;

  -- The Attribute that applies to Animals and Humans 
  -- that are unable to hear.
  fun Deaf : Ind BiologicalAttribute ;

  -- A Contest where each participant holds a different 
  -- view regarding some issue, and each participant attempts to prove, by 
  -- rhetoric or evidence, that his/her own views about a particular matter are 
  -- correct and/or that the views of the other participants are incorrect.
  fun Debating : Class ;
  fun Debating_Class : SubClass Debating (both Contest LinguisticCommunication) ;

  -- Getting off a Vehicle, e.g. getting out of an 
  -- Automobile, deplaning, getting off a WaterVehicle, etc.
  fun Deboarding : Class ;
  fun Deboarding_Class : SubClass Deboarding Translocation ;

  -- The TimeDuration of 10 years.
  fun DecadeDuration : Ind UnitOfDuration ;

  -- Decreasing the speed with which someone 
  -- or something is moving.
  fun Decelerating : Class ;
  fun Decelerating_Class : SubClass Decelerating (both Decreasing Translocation) ;

  -- One of the two major political parties in 
  -- the UnitedStates. The DemocraticParty represents liberal values.
  fun DemocraticParty : Ind PoliticalParty ;

  -- The Profession of being a dentist, i.e. diagnosing 
  -- and treating problems related to the teeth.
  fun Dentist : Ind Profession ;

  -- Any BiologicallyActiveSubstance which has 
  -- the effect of depressing the central nervous system, i.e. decreasing 
  -- function or activity in the Brain or SpinalCord.
  fun Depressant : Class ;
  fun Depressant_Class : SubClass Depressant BiologicallyActiveSubstance ;

  -- A Position which authorizes the holder of the position 
  -- to act as the sheriff when the sheriff is not available.
  fun Deputy : Ind PoliceOfficer ;

  -- (DescendantsFn ?PERSON) denotes all and only 
  -- the descendants of ?PERSON, i.e. the Group consisting of ?OFFSPRING who 
  -- satisfy the following formula: (ancestor ?OFFSPRING ?PERSON).
  fun DescendantsFn : El Human -> Ind FamilyGroup ;

  -- A Table for a single person which is intended to be 
  -- used for paperwork.
  fun Desk : Class ;
  fun Desk_Class : SubClass Desk Table ;

  -- A detergent is a compound, or a mixture of 
  -- compounds, whose molecules have two distinct regions: one that is 
  -- hydrophilic, and dissolves easily in water, and another region that is 
  -- hydrophobic, with little (if any) affinity for water. As a consequence, 
  -- these compounds can aid in the solubilization of hydrophobic compounds in 
  -- water, and usually are optimized for this property. Though Soap also has 
  -- these properties, soaps in general are not considered detergents. Soap is 
  -- a particular type of surfactant that is derived from oils and fats. They 
  -- are created through the saponification process whereby the ester linkage 
  -- in a vegetable oil or fat is hydrolytically cleaved, creating a sodium or 
  -- potassium salt of a fatty acid (i.e. soap). Both detergents and soaps 
  -- are considered to be surfactants. Surfactants that are not soaps are 
  -- considered to be detergents. Detergents are also commonly known as any 
  -- cleaning mixture containing surfactants. (from Wikipedia)
  fun Detergent : Class ;
  fun Detergent_Class : SubClass Detergent (both Mixture Surfactant) ;

  -- This class contains two Attributes to 
  -- indicate whether a Device is or is not behaving as it is intended to 
  -- behave, Functioning and Malfunctioning.
  fun DeviceAttribute : Class ;
  fun DeviceAttribute_Class : SubClass DeviceAttribute ObjectiveNorm ;

  fun DeviceClosed : Ind (both DeviceStateAttribute RelationalAttribute) ;

  fun DeviceOff : Ind (both DeviceStateAttribute InternalAttribute) ;

  fun DeviceOn : Ind (both DeviceStateAttribute InternalAttribute) ;

  fun DeviceOpen : Ind (both DeviceStateAttribute RelationalAttribute) ;

  -- DeviceStateAttribute is the class 
  -- of attributes that represent different states that a Device may be in. 
  -- Examples: DeviceOff, DeviceOn, DeviceOpen, and DeviceClosed.
  fun DeviceStateAttribute : Class ;
  fun DeviceStateAttribute_Class : SubClass DeviceStateAttribute DeviceAttribute ;

  -- Any process of Separating a Solution into two or more 
  -- constituent PureSubstances by means of their unequal diffusion through membranes 
  -- that are partially permeable.
  fun Dialysis : Class ;
  fun Dialysis_Class : SubClass Dialysis Separating ;

  -- (DiameterFn ?CIRCLE) denotes the length of the 
  -- diameter of the Circle ?CIRCLE.
  fun DiameterFn : El Circle -> Ind LengthMeasure ;

  -- Crystalline Carbon that is valued as a gem and 
  -- used in industrial applications.
  fun Diamond : Class ;
  fun Diamond_Class : SubClass Diamond (both Carbon Mineral) ;

  -- A DiseaseOrSyndrome of frequent, watery bowel 
  -- movements. Severe cases can be fatal for the young or weak. It is
  -- a common cause of death for the very young in poor developing countries.
  fun Diarrhea : Ind DiseaseOrSyndrome ;

  -- A ReferenceBook which specifies the meanings 
  -- of the Words of a Language.
  fun Dictionary : Class ;
  fun Dictionary_Class : SubClass Dictionary ReferenceBook ;

  -- DieselEngine is the subclass of 
  -- InternalCombustionEngines that use DieselFuel as their resource.
  fun DieselEngine : Class ;
  fun DieselEngine_Class : SubClass DieselEngine InternalCombustionEngine ;

  -- A Plan regarding what one is allowed to eat.
  fun Diet : Class ;
  fun Diet_Class : SubClass Diet Plan ;

  -- Any Process of removing or turning over the Soil.
  fun Digging : Class ;
  fun Digging_Class : SubClass Digging (both IntentionalProcess SurfaceChange) ;

  -- Any of the extremities of Limbs that are 
  -- found in the higer Vertebrates and the Amphibians.
  fun DigitAppendage : Class ;
  fun DigitAppendage_Class : SubClass DigitAppendage (both AnimalAnatomicalStructure BodyPart) ;

  -- Any Character that is comprised of a single digit, 
  -- i.e. one of the numerals 0, 1, 2, 3, 4, 5, 6, 7, 8, 9.
  fun DigitCharacter : Class ;
  fun DigitCharacter_Class : SubClass DigitCharacter Character ;

  -- Adding a Liquid to a Solution to decrease 
  -- the concentration of the Solution.
  fun Diluting : Class ;
  fun Diluting_Class : SubClass Diluting Putting ;

  -- A Room intended primarily for Eating.
  fun DiningRoom : Class ;
  fun DiningRoom_Class : SubClass DiningRoom Room ;

  -- A person who works as a facilitator for communication
  -- between countries, in the official employ of one of the countries.
  fun Diplomat : Ind OccupationalRole ;

  -- A Holder for Food while the Food is being eaten.
  fun Dish : Class ;
  fun Dish_Class : SubClass Dish Holder ;

  -- Any BodyMotion which results in not being On 
  -- something else.
  fun Dismounting : Class ;
  fun Dismounting_Class : SubClass Dismounting BodyMotion ;

  -- DisplacementHullWaterVehicle is 
  -- a subclass of WaterVehicle with hulls designed to move water aside as they 
  -- move through the water. Contrast with PlaningHullWaterVehicle.
  fun DisplacementHullWaterVehicle : Class ;
  fun DisplacementHullWaterVehicle_Class : SubClass DisplacementHullWaterVehicle WaterVehicle ;

  -- Something for posting content so 
  -- that it can be disseminated to the public.
  fun DisplayArtifact : Class ;
  fun DisplayArtifact_Class : SubClass DisplayArtifact Artifact ;

  -- Someone who is opposed to the leadership
  -- of a particular country. Typically, a dissident suffers punishment
  -- at the hands of the country whose leadership he is opposing.
  fun Dissident : Ind (both Civilian SocialRole) ; 

  -- An AlcoholicBeverage that has 
  -- had some part of its Water content removed by distillation. This class 
  -- covers drinks of unmixed, hard liquor.
  fun DistilledAlcoholicBeverage : Class ;
  fun DistilledAlcoholicBeverage_Class : SubClass DistilledAlcoholicBeverage AlcoholicBeverage ;

  -- A legal act whereby a marriage is dissolved. This 
  -- includes annulments.
  fun Divorcing : Class ;
  fun Divorcing_Class : SubClass Divorcing Declaring ;

  -- A MotionPicture which purports to represent the 
  -- facts about a person, event, etc.
  fun Documentary : Class ;
  fun Documentary_Class : SubClass Documentary (both FactualText MotionPicture) ;

  -- Purposely moving one's body in such a way as 
  -- to avoid being hit by something.
  fun Dodging : Class ;
  fun Dodging_Class : SubClass Dodging (both BodyMotion IntentionalProcess) ;

  -- Any Animal that is kept by a Human, as 
  -- a pet, as livestock, for exhibition, etc.
  fun DomesticAnimal : Class ;
  fun DomesticAnimal_Class : SubClass DomesticAnimal Animal ;

  -- A variety of Feline which has been domesticated 
  -- by selective breeding.
  fun DomesticCat : Class ;
  fun DomesticCat_Class : SubClass DomesticCat (both DomesticAnimal Feline) ;

  -- Canines which have evolved from the common 
  -- wolf by selective breeding.
  fun DomesticDog : Class ;
  fun DomesticDog_Class : SubClass DomesticDog (both Canine DomesticAnimal) ;

  -- A domesticated HoofedMammal that is used for work.
  fun Donkey : Class ;
  fun Donkey_Class : SubClass Donkey (both HoofedMammal Livestock) ;

  -- An Artifact that restricts and permits access to a 
  -- StationaryArtifact (e.g. Building or Room) depending on whether the 
  -- Door is open or locked. Note that the class Door also covers gates, 
  -- because it is not possible to define objective criteria that reliably 
  -- distinguish doors from gates.
  fun Door : Class ;
  fun Door_Class : SubClass Door (both Artifact Device) ;

  -- A StationaryArtifact consisting of a frame that 
  -- holds a Door.
  fun Doorway : Class ;
  fun Doorway_Class : SubClass Doorway StationaryArtifact ;

  -- A TemporaryResidence which is owned by a School 
  -- and which is used to house students while they take classes at the School.
  fun Dormitory : Class ;
  fun Dormitory_Class : SubClass Dormitory (both ResidentialBuilding TemporaryResidence) ;

  -- A Mixture of Flour, Water, and possibly 
  -- other ingredients (such as Butter and Salt), which is used in 
  -- making BreadOrBiscuits.
  fun Dough : Class ;
  fun Dough_Class : SubClass Dough (both Mixture PreparedFood) ;

  -- A PositionalAttribute to indicate that one thing is 
  -- one or more floors below a second thing in the same building.
  fun Downstairs : Ind PositionalAttribute ;

  -- The commercial center of a City. The part of the 
  -- City that contains more shops and offices than any other part.
  fun Downtown : Class ;
  fun Downtown_Class : SubClass Downtown CityDistrict ;

  -- Playing a character in a Performance, 
  -- MotionPicture, etc.
  fun DramaticActing : Class ;
  fun DramaticActing_Class : SubClass DramaticActing Pretending ;

  -- The GroupOfPeople who engage in DramaticActing 
  -- as part of the realization of a single FictionalText.
  fun DramaticCast : Class ;
  fun DramaticCast_Class : SubClass DramaticCast GroupOfPeople ;

  -- The process of directing a DramaticActing 
  -- in a MotionPicture or the Performance of a DramaticPlay.
  fun DramaticDirecting : Class ;
  fun DramaticDirecting_Class : SubClass DramaticDirecting Guiding ;

  -- A Performance that consists exclusively of 
  -- DramaticActing, e.g. a live performance of Death_of_a_Salesman in front 
  -- of an audience.
  fun DramaticPerformance : Class ;
  fun DramaticPerformance_Class : SubClass DramaticPerformance Performance ;

  -- A FictionalText that is intended to be realized 
  -- as DramaticActing.
  fun DramaticPlay : Class ;
  fun DramaticPlay_Class : SubClass DramaticPlay FictionalText ;

  -- Any ContentDevelopment that results in a Sketch.
  fun Drawing : Class ;
  fun Drawing_Class : SubClass Drawing (both ContentDevelopment SurfaceChange) ;

  -- A Process of producing metal images which occurs 
  -- while one is Asleep.
  fun Dreaming : Class ;
  fun Dreaming_Class : SubClass Dreaming Imagining ;

  -- An item of Clothing which covers the lower body of a Woman.
  fun Dress : Class ;
  fun Dress_Class : SubClass Dress Clothing ;

  -- The Process of putting on Clothing.
  fun Dressing : Class ;
  fun Dressing_Class : SubClass Dressing Putting ;

  -- Any Room which is intended for ChangingClothing.
  fun DressingRoom : Class ;
  fun DressingRoom_Class : SubClass DressingRoom Room ;

  -- A Device that has the purpose of creating a Hole. 
  -- This covers manual drills as well as electric or pneumatic drills.
  fun Drill : Class ;
  fun Drill_Class : SubClass Drill CuttingDevice ;

  -- Any Process of producing a hole in a 
  -- SelfConnectedObject which involves rotating a long, thin bit.
  fun Drilling : Class ;
  fun Drilling_Class : SubClass Drilling (both IntentionalProcess SurfaceChange) ;

  -- An open FluidContainer that is intended to serve a Beverage 
  -- to a single person. Note that this class includes both cups with handles and 
  -- drinking glasses.
  fun DrinkingCup : Class ;
  fun DrinkingCup_Class : SubClass DrinkingCup FluidContainer ;

  -- Any LiquidMotion where the Liquid is moved drop by drop.
  fun Dripping : Class ;
  fun Dripping_Class : SubClass Dripping LiquidMotion ;

  -- An EngineeringComponent whose purpose is to 
  -- transfer force from one part of a Device to another part.
  fun DriveComponent : Class ;
  fun DriveComponent_Class : SubClass DriveComponent EngineeringComponent ;

  -- A License which identifies the holder and 
  -- indicates that he has the right to drive a certain class of RoadVehicle.
  fun DriversLicense : Class ;
  fun DriversLicense_Class : SubClass DriversLicense License ;

  -- A small, private Roadway that is used for parking 
  -- Automobiles or for connecting a Garage to a public Roadway.
  fun Driveway : Class ;
  fun Driveway_Class : SubClass Driveway Roadway ;

  -- A RetailStore that sells Medicine, and 
  -- perhaps other items as well.
  fun DrugStore : Class ;
  fun DrugStore_Class : SubClass DrugStore RetailStore ;

  -- The ConsciousnessAttribute of someone whose motor and/or 
  -- cognitive faculties are significantly impaired by a BiologicallyActiveSubstance.
  fun Drugged : Ind ConsciousnessAttribute ;

  -- An atonal PercussionInstrument which consists of a hollow cylinder
  -- and a fabric stretched across at least one end of the cylinder.
  fun Drum : Class ;
  fun Drum_Class : SubClass Drum PercussionInstrument ;

  -- Playing a Drum. Note that this includes both
  -- musical performance, as well as signalling and cerimonial applications.
  fun Drumming : Class ;
  fun Drumming_Class : SubClass Drumming (both Demonstrating RadiatingSound) ;

  -- The ConsciousnessAttribute of someone whose motor and 
  -- cognitive faculties are significantly impaired by Alcohol.
  fun Drunk : Ind ConsciousnessAttribute ;

  -- A subclass of Bird with webbed feet and a large bill. 
  -- Some ducks live in the wild, and some are raised for meat and/or eggs.
  fun Duck : Class ;
  fun Duck_Class : SubClass Duck Poultry ;

  -- Purposely moving one's body downward in such a way as 
  -- to avoid being hit by something.
  fun Ducking : Class ;
  fun Ducking_Class : SubClass Ducking (both BodyMotion (both IntentionalProcess MotionDownward)) ;

  -- A Tax that is levied on imports and/or exports.
  fun DutyTax : Class ;
  fun DutyTax_Class : SubClass DutyTax Tax ;

  -- The Organ of hearing.
  fun Ear : Class ;
  fun Ear_Class : SubClass Ear (both AnimalAnatomicalStructure Organ) ;

  -- Instances of RadiatingSound where the instrument 
  -- is a surface which bounces sound waves back to their origin, where they can 
  -- be heard again.
  fun Echoing : Class ;
  fun Echoing_Class : SubClass Echoing RadiatingSound ;

  -- A class of Relations which are used 
  -- to specify various economic measures, e.g. the GDP, the consumer price 
  -- index, and the trade deficit.
  fun EconomicRelation : El GeopoliticalArea -> El Entity -> Formula;

  -- The field of economics.
  fun Economics : Ind SocialScience ;

  -- A schedule of class meetings offered by an 
  -- EducationalOrganization.
  fun EducationalCourse : Class ;
  fun EducationalCourse_Class : SubClass EducationalCourse EducationalProgram ;

  -- A building or campus, owned by an
  -- EducationalOrganization, which is intended as the location for
  -- EducationalProcesses.
  fun EducationalFacility : Class ;
  fun EducationalFacility_Class : SubClass EducationalFacility StationaryArtifact ;

  -- A series of EducationalCourses that must 
  -- be completed to receive an AcademicDegree or other Certificate. Note that 
  -- an EducationalProgram, unlike an EducationalCourse, may be realized at more 
  -- than one EducationalOrganization.
  fun EducationalProgram : Class ;
  fun EducationalProgram_Class : SubClass EducationalProgram Plan ;

  -- The joint in the Arm connecting the forearm and the 
  -- upper arm.
  fun Elbow : Class ;
  fun Elbow_Class : SubClass Elbow BodyJoint ;

  -- ElectoralCollegeElection is 
  -- the class of Elections in which the outcome is decided by the votes of 
  -- electors who have been chosen by popular vote, rather than directly by 
  -- results of the popular vote. ElectoralCollegeElection is an indirect 
  -- method of election, in contrast to PopularElection.
  fun ElectoralCollegeElection : Class ;
  fun ElectoralCollegeElection_Class : SubClass ElectoralCollegeElection GeneralElection ;

  -- A Device that uses Electricity as its
  -- primary power source.
  fun ElectricDevice : Class ;
  fun ElectricDevice_Class : SubClass ElectricDevice Device ;

  -- ElectricMotor is the subclass of Engines 
  -- that produce mechanical power from electricity.
  fun ElectricMotor : Class ;
  fun ElectricMotor_Class : SubClass ElectricMotor (both ElectricDevice Engine) ;

  -- ElectricalSignalling is the subclass of Signalling processes
  -- that involve control of an electrical current. Cf. ElectronicSignalling.
  fun ElectricalSignalling : Class ;
  fun ElectricalSignalling_Class : SubClass ElectricalSignalling Signalling ;

  -- ElectrifiedRailwayCar is the 
  -- subclass of railway cars that are powered by electricity, which is 
  -- provided to the car through an overhead link or electrified third rail.
  fun ElectrifiedRailwayCar : Class ;
  fun ElectrifiedRailwayCar_Class : SubClass ElectrifiedRailwayCar (both ElectricDevice (both PoweredVehicle RollingStock)) ;

  -- ElectronicSignalling is the 
  -- subclass of Signalling processes that involve a signal generated by 
  -- a computer.
  fun ElectronicSignalling : Class ;
  fun ElectronicSignalling_Class : SubClass ElectronicSignalling Signalling ;

  -- The branch of Physics that deals with the theory 
  -- and applications of electron emissions.
  fun Electronics : Ind FieldOfStudy ;

  -- A very large, almost hairless Herbivore with a long trunk.
  fun Elephant : Class ;
  fun Elephant_Class : SubClass Elephant Herbivore ;

  -- A TransportationDevice consisting of a car that moves 
  -- up and down in a vertical shaft so that people or objects can move from one floor to another 
  -- in a building.
  fun Elevator : Class ;
  fun Elevator_Class : SubClass Elevator TransportationDevice ;

  -- An embassy is a Building that is owned by a Government to house
  -- its diplomatic and consular staff that is in another country.
  fun EmbassyBuilding : Class ;
  fun EmbassyBuilding_Class : SubClass EmbassyBuilding GovernmentBuilding ;

  -- The class of Touching processes where one Human hugs another one.
  fun Embracing : Class ;
  fun Embracing_Class : SubClass Embracing Touching ;

  -- A DiseaseOrSyndrome that affects the Lungs and 
  -- which results in a decrease of breathing ability.
  fun Emphysema : Ind DiseaseOrSyndrome ;

  -- Involuntarily ending one's employment. 
  -- Note that this covers termination due to inadequate performance, as 
  -- well as layoffs.
  fun EmploymentFiring : Class ;
  fun EmploymentFiring_Class : SubClass EmploymentFiring TerminatingEmployment ;

  -- Engine is a subclass of Transducer. Engines are devices for converting
  -- some form of energy resource into mechanical power.
  fun Engine : Class ;
  fun Engine_Class : SubClass Engine Transducer ;

  -- The application of instances of Science to the solution 
  -- of practical problems, i.e. the creation of various forms of technology.
  fun Engineering : Ind Science ;

  -- A building that has the primary 
  -- purpose of entertaining people.
  fun EntertainmentBuilding : Class ;
  fun EntertainmentBuilding_Class : SubClass EntertainmentBuilding Building ;

  -- Any business whose services include 
  -- Performances. This class covers nightclubs, commercial live theaters, 
  -- and comedy clubs.
  fun EntertainmentCompany : Class ;
  fun EntertainmentCompany_Class : SubClass EntertainmentCompany CommercialAgent ;

  -- Positions which involve creating 
  -- content or performances that are intended to entertain. This class covers 
  -- the TheaterProfession, FilmMakingProfession, being a comedian, etc.
  fun EntertainmentProfession : Class ;
  fun EntertainmentProfession_Class : SubClass EntertainmentProfession SkilledOccupation ;

  -- More commonly known as burying, this is the class 
  -- of processes of putting a HumanCorpse into a Tomb. Note that this class 
  -- is not a subclass of Burying, since some Tombs are not covered with Soil, 
  -- e.g. those in a mausoleum.
  fun Entombing : Class ;
  fun Entombing_Class : SubClass Entombing Putting ;

  -- A sealable Container for one or more pieces of 
  -- paper which is designed to protect the papers while they are transferred to 
  -- someone.
  fun Envelope : Class ;
  fun Envelope_Class : SubClass Envelope Container ;

  -- Any instance of Translocation where the agent brings 
  -- it about that he/she is no longer confined without having the right to do 
  -- so.
  fun Escaping : Class ;
  fun Escaping_Class : SubClass Escaping Translocation ;

  -- Any Investigating by one Government of another 
  -- Government where the second Government does not know that it is being 
  -- spied upon.
  fun Espionage : Class ;
  fun Espionage_Class : SubClass Espionage (both Investigating PoliticalProcess) ;

  -- The class of nations that are in Europe.
  fun EuropeanNation : Class ;
  fun EuropeanNation_Class : SubClass EuropeanNation Nation ;

  -- The state of being happy about a state of 
  -- affairs that might occur in the future.
  fun Excitement : Ind EmotionalState ;

  -- Killing of a Human by a Government for 
  -- the commission of a CriminalAction.
  fun Execution : Class ;
  fun Execution_Class : SubClass Execution Killing ;

  -- A Residence of a chiefOfState, e.g. 
  -- the White House, a state governor's mansion, Buckingham Palace, etc.
  fun ExecutiveResidence : Class ;
  fun ExecutiveResidence_Class : SubClass ExecutiveResidence PermanentResidence ;

  -- Any instance of Breathing where the breath is 
  -- expelled from the Lungs.
  fun Exhaling : Class ;
  fun Exhaling_Class : SubClass Exhaling Breathing ;

  -- Any sudden and massive release of energy that is 
  -- the product of a chemical reaction.
  fun Explosion : Class ;
  fun Explosion_Class : SubClass Explosion Radiating ;

  -- A Device whose purpose is to explode. Note 
  -- that ExplosiveDevice is not a subclass of Weapon, since explosives can be 
  -- used in demolition work and in fireworks displays, for example.
  fun ExplosiveDevice : Class ;
  fun ExplosiveDevice_Class : SubClass ExplosiveDevice Device ;

  -- An ExplosiveDevice which is designed to 
  -- explode when there is movement over it, e.g. by a person on foot, by a 
  -- RoadVehicle, etc.
  fun ExplosiveMine : Class ;
  fun ExplosiveMine_Class : SubClass ExplosiveMine (both ExplosiveDevice Weapon) ;

  -- Any Substance which is capable of exploding.
  fun ExplosiveSubstance : Class ;
  fun ExplosiveSubstance_Class : SubClass ExplosiveSubstance Substance ;

  -- Expressing favor about a physical thing 
  -- or a state of affairs.
  fun ExpressingApproval : Class ;
  fun ExpressingApproval_Class : SubClass ExpressingApproval Expressing ;

  -- Expressing disfavor about a physical 
  -- thing or a state of affairs.
  fun ExpressingDisapproval : Class ;
  fun ExpressingDisapproval_Class : SubClass ExpressingDisapproval Expressing ;

  -- Any instance of Expressing an acknowledgment 
  -- of a person's departure. Note that this class is not a subclass of 
  -- LinguisticCommunication, because it covers gestures of departure, e.g. Waving 
  -- and Nodding in certain circumstances.
  fun ExpressingFarewell : Class ;
  fun ExpressingFarewell_Class : SubClass ExpressingFarewell Expressing ;

  -- Any instance of Expressing that is also an 
  -- instance of LinguisticCommunication, e.g. thanking someone, expressing condolence, 
  -- expressing disapproval with an utterance rather than a Gesture, etc.
  fun ExpressingInLanguage : Class ;
  fun ExpressingInLanguage_Class : SubClass ExpressingInLanguage (both Expressing LinguisticCommunication) ;

  -- The Organ of sight.
  fun Eye : Class ;
  fun Eye_Class : SubClass Eye (both AnimalAnatomicalStructure Organ) ;

  -- A lens or pair of lenses with or without frames whose 
  -- purpose is to to correct a defect in vision. This class covers ordinary eye 
  -- glasses, reading glasses, contact lenses, monocles, etc.
  fun EyeGlass : Class ;
  fun EyeGlass_Class : SubClass EyeGlass OpticalDevice ;

  -- Any Motion where a patient is the agent's 
  -- own Eyelid or Eyelids.
  fun EyeMotion : Class ;
  fun EyeMotion_Class : SubClass EyeMotion BodyMotion ;

  -- Folds of Skin that can be manipulated to 
  -- cover or uncover Eyes.
  fun Eyelid : Class ;
  fun Eyelid_Class : SubClass Eyelid Skin ;

  -- The part of the Head from forehead to chin and 
  -- from ear to ear.
  fun Face : Class ;
  fun Face_Class : SubClass Face (both AnimalAnatomicalStructure BodyPart) ;

  -- Any Gesture whose instrument is the Face.
  fun FacialExpression : Class ;
  fun FacialExpression_Class : SubClass FacialExpression Gesture ;

  -- Hair that grows on the Face. This 
  -- class covers beards, mustaches, sideburns, midnight shadow, etc.
  fun FacialHair : Class ;
  fun FacialHair_Class : SubClass FacialHair Hair ;

  -- The class of Statements that are True.
  fun Fact : Class ;
  fun Fact_Class : SubClass Fact Statement ;

  -- A Building intended to house a process that 
  -- produces goods of some value.
  fun Factory : Class ;
  fun Factory_Class : SubClass Factory Building ;

  -- The SeasonOfYear that begins at the autumnal 
  -- equinox and ends at the winter solstice.
  fun FallSeason : Class ;
  fun FallSeason_Class : SubClass FallSeason SeasonOfYear ;

  -- The process of transitioning from a state of 
  -- being Awake to a state of being Asleep.
  fun FallingAsleep : Class ;
  fun FallingAsleep_Class : SubClass FallingAsleep PsychologicalProcess ;

  -- Radioactive powder that is typically dispersed by 
  -- the explosion of a nuclear weapon.
  fun Fallout : Class ;
  fun Fallout_Class : SubClass Fallout Powder ;

  -- A Partnership that is owned by a single 
  -- family.
  fun FamilyBusiness : Class ;
  fun FamilyBusiness_Class : SubClass FamilyBusiness Partnership ;

  -- A CoolingDevice which consists simply of one or more 
  -- blades that circulate the air. Note that this class covers both electrical fans 
  -- and fans that are manually operated.
  fun FanDevice : Class ;
  fun FanDevice_Class : SubClass FanDevice CoolingDevice ;

  -- A StationaryArtifact consisting of a cultivated 
  -- LandArea and Buildings for maintaining the land and/or the Animals 
  -- on the land.
  fun Farm : Class ;
  fun Farm_Class : SubClass Farm StationaryArtifact ;

  -- A Building on a Farm that is used for keeping 
  -- DomesticAnimals, Fodder or harvested crops.
  fun FarmBuilding : Class ;
  fun FarmBuilding_Class : SubClass FarmBuilding Building ;

  -- OccupationalTrades which involve Agriculture.
  fun FarmHand : Ind OccupationalTrade ;

  -- Operating a farm, e.g. planting and harvesting crops, 
  -- tending livestock, etc.
  fun Farming : Class ;
  fun Farming_Class : SubClass Farming Working ;

  -- Each instance of this class is one of the structures 
  -- that make up the external covering of Birds.
  fun Feather : Class ;
  fun Feather_Class : SubClass Feather (both AnimalAnatomicalStructure BodyPart) ;

  -- Giving Food to a Human or Animal.
  fun Feeding : Class ;
  fun Feeding_Class : SubClass Feeding Giving ;

  -- A Cow that is Female.
  fun FemaleCow : Class ;
  fun FemaleCow_Cow : SubClassC FemaleCow Cow (\COW -> attribute (var Cow Object ? COW)(el SexAttribute Attribute ? Female));

  -- A StationaryArtifact that serves to demarcate or
  -- to prevent access to or from the area that the Fence surrounds.
  fun Fence : Class ;
  fun Fence_Class : SubClass Fence StationaryArtifact ;

  -- Having a body temperature which is (significantly) greater 
  -- than 98.6 degrees Fahrenheit. This syndrome is often associated with dehydration 
  -- and chills.
  fun Fever : Ind DiseaseOrSyndrome ;

  -- A LandArea that has been cleared of BotanicalTrees. 
  -- Note that a Field is not necessarily used for the cultivation of crops and 
  -- that a Field may be very small, e.g. Lawn is a subclass of Field.
  fun Field : Class ;
  fun Field_Class : SubClass Field LandArea ;

  -- The study of legal principles and the framework of national 
  -- and/or international laws.
  fun FieldOfLaw : Ind FieldOfStudy ;

  -- Any high_speed MilitaryAircraft whose purpose is 
  -- to destroy enemy MilitaryAircraft.
  fun Fighter : Class ;
  fun Fighter_Class : SubClass Fighter MilitaryAircraft ;

  -- A Device whose purpose is to make something 
  -- smoother. For example, a nail file is used to even out the tips of one's 
  -- finger nails.
  fun FileDevice : Class ;
  fun FileDevice_Class : SubClass FileDevice Device ;

  -- Positions which involve directing MotionPictures.
  fun FilmDirector : Class ;
  fun FilmDirector_Class : SubClass FilmDirector FilmMakingProfession ;

  -- ContentDevelopment where the result is a 
  -- MotionPicture.
  fun FilmMaking : Class ;
  fun FilmMaking_Class : SubClass FilmMaking ContentDevelopment ;

  -- Positions which involve FilmMaking, 
  -- i.e. acting in films, directing films, producing films, etc.
  fun FilmMakingProfession : Class ;
  fun FilmMakingProfession_Class : SubClass FilmMakingProfession EntertainmentProfession ;

  -- Positions which involve producing MotionPictures, 
  -- i.e arranging the financing for the MotionPicture and supervising its production.
  fun FilmProducer : Class ;
  fun FilmProducer_Class : SubClass FilmProducer FilmMakingProfession ;

  -- A Device whose purpose is to remove part of a 
  -- Solution that is passed through the Filter.
  fun Filter : Class ;
  fun Filter_Class : SubClass Filter Device ;

  -- A formal banking, brokerage, or business relationship 
  -- established to provide for regular services, dealings, and other financial 
  -- transactions.
  fun FinancialAccount : Class ;

  -- Any item of economic value owned by an individual or 
  -- corporation, especially that which could be converted to cash. Examples are cash, 
  -- securities, accounts receivable, inventory, office equipment, a house, a car, and 
  -- other property.
  fun FinancialAsset : Class ;

  -- A brief statement that the stated amount 
  -- of money is owed by the person to whom the bill is delivered.
  fun FinancialBill : Class ;
  fun FinancialBill_Class : SubClass FinancialBill FinancialText ;

  -- The class FinancialCompany 
  -- includes, as subclasses, FinancialBank, CreditUnion and SavingsAndLoan.
  fun FinancialCompany : Class ;
  fun FinancialCompany_Class : SubClass FinancialCompany CommercialAgent ;

  -- Services performed by a
  -- FinancialCompany.
  fun FinancialService : Class ;
  fun FinancialService_Class : SubClass FinancialService CommercialService ;

  -- A Report about monetary figures. This 
  -- class covers FinancialBills, balance sheets, account statements, etc.
  fun FinancialText : Class ;
  fun FinancialText_Class : SubClass FinancialText Report ;

  -- Any Funding which is provided by a FinancialCompany 
  -- with the aim of making a profit on the money invested.
  fun Financing : Class ;
  fun Financing_Class : SubClass Financing (both FinancialService Funding) ;

  -- The five extremities of Hands.
  fun Finger : Class ;
  fun Finger_Class : SubClass Finger DigitAppendage ;

  -- That pattern of arches, loops, and whorls that mark 
  -- the imprint of a Finger.
  fun Fingerprint : Class ;
  fun Fingerprint_Class : SubClass Fingerprint (both BiologicalAttribute ShapeAttribute) ;

  -- Any Quantity that is limited or bounded in 
  -- magnitude.
  fun FiniteQuantity : Class ;
  fun FiniteQuantity_Class : SubClass FiniteQuantity Quantity ;

  -- A Gun that is small enough to be carried and fired by 
  -- a single Human.
  fun Firearm : Class ;
  fun Firearm_Class : SubClass Firearm Gun ;

  -- A Device in a Building which is used for burning wood, 
  -- coal, etc for heat.
  fun Fireplace : Class ;
  fun Fireplace_Class : SubClass Fireplace (both Device StationaryArtifact) ;

  -- (FirstFn ?LIST) returns the first item in 
  -- the List ?LIST. For example, (FirstFn (ListFn Monday Tuesday 
  -- Wednesday)) would return the value of Monday.
  fun FirstFn : El List -> Ind Entity ;

  -- Meat that was originally part of a Fish.
  fun FishMeat : Class ;
  fun FishMeat_Class : SubClass FishMeat Meat ;

  -- The BodyPosition of having the fingers drawn into 
  -- the palm so that the hand can be used for striking something.
  fun Fist : Ind BodyPosition ;

  -- An Icon made of Fabric that refers to a particular 
  -- GeopoliticalArea.
  fun Flag : Class ;
  fun Flag_Class : SubClass Flag Icon ;

  -- A three dimensional object for which
  -- two dimensions are markedly larger than the third the
  -- two larger dimensions are also not of markedly different length.
  fun Flat : Ind ShapeAttribute ;

  -- Flooding is the subclass of LiquidMotion 
  -- processes in which the water level of a Waterway rises or water spreads 
  -- over a flood plain along a Waterway.
  fun Flooding : Class ;
  fun Flooding_Class : SubClass Flooding LiquidMotion ;

  -- A StationaryArtifact that is the bottom surface 
  -- of a Room.
  fun Floor : Class ;
  fun Floor_Class : SubClass Floor StationaryArtifact ;

  -- A Powder that is prepared from CerealGrain, e.g. 
  -- wheat flour, rice flour, etc. Flour is most often used in the making 
  -- of BreadOrBiscuits.
  fun Flour : Class ;
  fun Flour_Class : SubClass Flour (both Powder PreparedFood) ;

  -- The reproductive organ of FloweringPlants.
  fun Flower : Class ;
  fun Flower_Class : SubClass Flower (both Organ PlantAnatomicalStructure) ;

  -- A Container which is used to store Fluids, 
  -- i.e. Liquids and Gases.
  fun FluidContainer : Class ;
  fun FluidContainer_Class : SubClass FluidContainer Container ;

  -- Insects with Wings and two Limbs.
  fun FlyInsect : Class ;
  fun FlyInsect_Class : SubClass FlyInsect Insect ;

  -- Any instance of Translocation which is through an 
  -- AtmosphericRegion and which is powered by the wings of an Animal.
  fun Flying : Class ;
  fun Flying_Class : SubClass Flying Translocation ;

  -- Altering the relative distance of a Lens 
  -- so that a visual image is sharper.
  fun Focusing : Class ;
  fun Focusing_Class : SubClass Focusing QuantityChange ;

  -- Any WaterCloud that is in contact with the ground.
  fun Fog : Class ;
  fun Fog_Class : SubClass Fog WaterCloud ;

  -- Bending something in such a way that one part of 
  -- it covers another part.
  fun Folding : Class ;
  fun Folding_Class : SubClass Folding ShapeChange ;

  -- The lower part of a Limb, the part which makes contact 
  -- with the ground in locomotion of the Animal.
  fun Foot : Class ;
  fun Foot_Class : SubClass Foot (both AnimalAnatomicalStructure BodyPart) ;

  -- FormOfGovernment is a class of 
  -- Attributes used to describe the characteristics of a government, 
  -- especially a NationalGovernment. The concept FormOfGovernment is 
  -- interpreted broadly enough to include Anarchy and Factionalism.
  fun FormOfGovernment : Class ;
  fun FormOfGovernment_Class : SubClass FormOfGovernment PoliticoEconomicAttribute ;

  -- A page or set of pages containing spaces where 
  -- information is to be entered by an Agent.
  fun FormText : Class ;
  fun FormText_Class : SubClass FormText Text ;

  -- Any Meeting which is the result of Planning 
  -- and whose purpose is not socializing.
  fun FormalMeeting : Class ;
  fun FormalMeeting_Class : SubClass FormalMeeting Meeting ;

  -- FossilFuel is the subclass of Fuel whose 
  -- instances are derived from fossilized organic deposits, such as Coal 
  -- and LiquefiedPetroleumGas.
  fun FossilFuel : Class ;
  fun FossilFuel_Class : SubClass FossilFuel (both Fuel PetroleumProduct) ;

  -- A SportsAttribute that indicates that the GamePiece of 
  -- a Sport is no longer in play because it has gone beyond the limits of the 
  -- sports field.
  fun Foul : Ind SportsAttribute ;

  -- Setting up an Organization.
  fun Founding : Class ;
  fun Founding_Class : SubClass Founding (both Declaring OrganizationalProcess) ;

  -- Canines with a bushy tail and pointed ears and nose. 
  -- Foxes tend to be much smaller than most DomesticDogs.
  fun Fox : Class ;
  fun Fox_Class : SubClass Fox Canine ;

  -- An Attribute which indicates that the associated Object is very breakable.
  fun Fragile : Ind BreakabilityAttribute ;

  -- Any Atom which is not part of a Molecule.
  fun FreeAtom : Class ;
  fun FreeAtom_Class : SubClass FreeAtom Atom ;

  -- A Romance language that is the official language 
  -- of France and Belgium, and is widely spoken in Africa.
  fun FrenchLanguage : Ind (both SpokenHumanLanguage NaturalLanguage) ; 

  -- Any PsychologicalProcess where the patient comes to feel Anxiety.
  fun Frightening : Class ;
  fun Frightening_Class : SubClass Frightening PsychologicalProcess ;

  -- Furrowing the forehead in such a way as to convey unhappiness.
  fun Frowning : Class ;
  fun Frowning_Class : SubClass Frowning FacialExpression ;

  -- Fuel is the class of Substances that can be 
  -- used as resources in Combustion processes in order to produce heat. 
  -- Mechanical energy can be produced by burning fuel in an Engine.
  fun Fuel : Class ;
  fun Fuel_Class : SubClass Fuel Substance ;

  -- Any Position where the employee is either 
  -- salaried or paid for at least 40 hour of work per week.
  fun FullTimePosition : Class ;
  fun FullTimePosition_Class : SubClass FullTimePosition Position ;

  -- Indicates that a Device is performing its 
  -- intended function.
  fun Functioning : Ind DeviceAttribute ;

  -- A FormalMeeting whose purpose is to commemorate the Death of someone.
  fun Funeral : Class ;
  fun Funeral_Class : SubClass Funeral FormalMeeting ;

  -- Any free_standing and movable Artifacts which are not which are
  -- used in day_to_day living and designed to rest on the Floor of a Room.
  fun Furniture : Class ;
  fun Furniture_Class : SubClass Furniture Artifact ;

  -- The process of transitioning from a state of being Unconscious to
  -- a state of being Awake.
  fun GainingConsciousness : Class ;
  fun GainingConsciousness_Class : SubClass GainingConsciousness PsychologicalProcess ;

  -- An Artifact that is designed to be used as an instrument in a Game.
  fun GameArtifact : Class ;
  fun GameArtifact_Class : SubClass GameArtifact Artifact ;

  -- Any ContestAttribute that is specific to a Game.
  fun GameAttribute : Class ;
  fun GameAttribute_Class : SubClass GameAttribute ContestAttribute ;

  -- A GameArtifact which is intended to be used as the 
  -- game area for playing a particular game.
  fun GameBoard : Class ;
  fun GameBoard_Class : SubClass GameBoard GameArtifact ;

  -- A decision issued by an official referee in a 
  -- Game. Note that GameCall is a subclass of Declaring, because these 
  -- decisions have binding, normative force.
  fun GameCall : Class ;
  fun GameCall_Class : SubClass GameCall (both Deciding Declaring) ;

  -- A small cube with 1 to 6 dots on each face that is 
  -- used to generate numbers at random in a Game.
  fun GameDie : Class ;
  fun GameDie_Class : SubClass GameDie GamePiece ;

  -- The location where a GameShot must end up if it 
  -- is to constitute a Score.
  fun GameGoal : Class ;
  fun GameGoal_Class : SubClass GameGoal GameArtifact ;

  -- A GameArtifact that is moved around in a game 
  -- area.
  fun GamePiece : Class ;
  fun GamePiece_Class : SubClass GamePiece GameArtifact ;

  -- A position which involves adjudicating contested 
  -- Maneuvers in a Game, i.e. deciding whether or not the Maneuvers are 
  -- permitted by the rules of the Game.
  fun GameReferee : Class ;
  fun GameReferee_Class : SubClass GameReferee SkilledOccupation ;

  -- Impelling a GamePiece for the purpose of 
  -- scoring a point or preventing the opposing player or team from scoring 
  -- a point. Note that this class does not cover shots which are disallowed 
  -- by the rules of the game.
  fun GameShot : Class ;
  fun GameShot_Class : SubClass GameShot (both Impelling Maneuver) ;

  -- A Building or part of a Building which is intended to house 
  -- one or more Automobiles when they are not in use or are under
  -- repair.
  fun Garage : Class ;
  fun Garage_Class : SubClass Garage StationaryArtifact ;

  -- GasolineEngine is the subclass of 
  -- InternalCombustionEngines that use Gasoline as their resource.
  fun GasolineEngine : Class ;
  fun GasolineEngine_Class : SubClass GasolineEngine InternalCombustionEngine ;

  -- A Mollusk with a distinct head that has no 
  -- shell (e.g. slugs) or a univalve shell (e.g. snails).
  fun Gastropod : Class ;
  fun Gastropod_Class : SubClass Gastropod Mollusk ;

  -- GeneralElection is the subclass of 
  -- Elections that are held at regular intervals and in which all or most 
  -- constituencies of a GeopoliticalArea participate.
  fun GeneralElection : Class ;
  fun GeneralElection_Class : SubClass GeneralElection Election ;

  -- A Germanic language that is spoken primarily in 
  -- Germany and Austria.
  fun GermanLanguage : Ind (both SpokenHumanLanguage NaturalLanguage) ;

  -- A HumanChild who is Female.
  fun Girl : Class ;
  fun Girl_Class : SubClass Girl (both HumanChild Woman) ;

  -- A transparent or translucent Mixture of silicates.
  fun Glass : Class ;
  fun Glass_Class : SubClass Glass Mixture ;

  -- Clothing that is intended to be worn on the Hand. 
  -- Note that this class covers both gloves which have individual compartments 
  -- for each of the Fingers and mittens.
  fun Glove : Class ;
  fun Glove_Class : SubClass Glove Clothing ;

  -- Any Mixture whose purpose is to be used as the instrument 
  -- of Attaching one thing to another.
  fun Glue : Class ;
  fun Glue_Class : SubClass Glue Mixture ;

  -- A DiseaseOrSyndrome which is due to an Iodine deficiency 
  -- and which results in an enlarged ThyroidGland.
  fun Goiter : Ind DiseaseOrSyndrome ;

  -- A subclass of Bird with webbed feet and a long neck 
  -- and a large body. These Birds are often raised for their Meat.
  fun Goose : Class ;
  fun Goose_Class : SubClass Goose Poultry ;

  -- A building belonging to a Government
  fun GovernmentBuilding : Class ;
  fun GovernmentBuilding_Class : SubClass GovernmentBuilding Building ;

  -- Any Profession where the position occupied 
  -- is within a GovernmentOrganization.
  fun GovernmentOfficer : Class ;
  fun GovernmentOfficer_Class : SubClass GovernmentOfficer Profession ;

  -- A person who works for a Government.
  fun GovernmentPerson : Ind OccupationalRole ;

  -- The class of Positions where the position holder 
  -- is head of an adminstrative department of Government.
  fun GovernmentSecretary : Class ;
  fun GovernmentSecretary_Class : SubClass GovernmentSecretary SkilledOccupation ;

  -- The head of the Government of an AmericanState.
  fun Governor : Ind Position ;

  -- A School which is devoted to a specific 
  -- subject area, which admits students that have a bachelor's degree, which 
  -- grants masters and/or doctorate degrees, and which is part of a University.
  fun GraduateSchool : Class ;
  fun GraduateSchool_Class : SubClass GraduateSchool PostSecondarySchool ;

  -- An Icon which depicts one or more quantities.
  fun GraphDiagram : Class ;
  fun GraphDiagram_Class : SubClass GraphDiagram Icon ;

  -- FloweringPlants with green, narrow leaves that are 
  -- used for lawns and Fields. Grass includes any plant of the family 
  -- Gramineae, a widely distributed group of mostly annual and perennial 
  -- herbs.
  fun Grass : Class ;
  fun Grass_Class : SubClass Grass FloweringPlant ;

  -- Insects with enormous legs that are used for 
  -- jumping.
  fun Grasshopper : Class ;
  fun Grasshopper_Class : SubClass Grasshopper Insect ;

  -- A SecondaryColor that results from mixing Black and 
  -- White.
  fun GrayColor : Ind SecondaryColor ;

  -- An Indo_European language that is spoken in Greece.
  fun GreekLanguage : Ind (both SpokenHumanLanguage NaturalLanguage) ;

  -- A SecondaryColor that resembles the color of fresh 
  -- grass.
  fun Green : Ind SecondaryColor ;

  -- Any instance of Expressing an acknowledgment of a 
  -- person's arrival. Note that this class is not a subclass of ExpressingInLanguage, 
  -- because it covers gestures of greeting, e.g. Waving and Nodding in certain 
  -- circumstances.
  fun Greeting : Class ;
  fun Greeting_Class : SubClass Greeting Expressing ;

  fun GroceryProduce : Class ;
  fun GroceryProduce_Class : SubClass GroceryProduce (both FruitOrVegetable PlantAgriculturalProduct) ;

  -- A RetailStore that sells Food, and perhaps 
  -- other items as well.
  fun GroceryStore : Class ;
  fun GroceryStore_Class : SubClass GroceryStore RetailStore ;

  -- Any Group which contains exclusively 
  -- non_human members.
  fun GroupOfAnimals : Class ;
  fun GroupOfAnimals_Class : SubClass GroupOfAnimals Group ;

  -- A StringInstrument that has six to twelve strings and 
  -- is played by strumming with one hand while grasping frets with the other hand.
  fun Guitar : Class ;
  fun Guitar_Class : SubClass Guitar StringInstrument ;

  -- A Weapon that shoots a Projectile.
  fun Gun : Class ;
  fun Gun_Class : SubClass Gun (both ProjectileLauncher Weapon) ;

  -- The part of a Gun through which a Projectile travels 
  -- when it is fired.
  fun GunBarrel : Class ;
  fun GunBarrel_Class : SubClass GunBarrel EngineeringComponent ;

  -- A Mixture of potassium nitrate, sulfur, and 
  -- charcoal that is used in ExplosiveDevices and to propell Projectiles 
  -- in ProjectileWeapons.
  fun GunPowder : Class ;
  fun GunPowder_Class : SubClass GunPowder Mixture ;

  -- The part of a Gun that is placed against the 
  -- shoulder to absorb some of the recoil action when it is fired.
  fun GunStock : Class ;
  fun GunStock_Class : SubClass GunStock EngineeringComponent ;

  -- The part of the Gun which is pulled in Shooting 
  -- the Gun.
  fun GunTrigger : Class ;
  fun GunTrigger_Class : SubClass GunTrigger EngineeringComponent ;

  -- A filament that covers part of the body of many 
  -- Mammals.
  fun Hair : Class ;
  fun Hair_Class : SubClass Hair AnimalAnatomicalStructure ;

  -- Removing (some or all) the Hair from the 
  -- body of an Animal. Note that this covers shaving hair, cutting hair, 
  -- pulling hair out by the roots, etc.
  fun HairRemoval : Class ;
  fun HairRemoval_Class : SubClass HairRemoval Removing ;

  -- A Device that is used to pound Nails into a 
  -- surface, where they become firmly attached.
  fun Hammer : Class ;
  fun Hammer_Class : SubClass Hammer Device ;

  -- The grasping, fingered part of an upper limb of a 
  -- Primate.
  fun Hand : Class ;
  fun Hand_Class : SubClass Hand (both AnimalAnatomicalStructure BodyPart) ;

  -- Any Gesture which involves the Hands.
  fun HandGesture : Class ;
  fun HandGesture_Class : SubClass HandGesture Gesture ;

  -- A hand grenade is a small explosive device
  -- with a simple trigger mechanism, usually lasting a few seconds, designed
  -- to be propelled by a human to its target.
  fun HandGrenade : Class ;
  fun HandGrenade_Class : SubClass HandGrenade Bomb ;

  -- An attack in which a HandGrenade is 
  -- employed as an explosive device for the purpose of Destruction.
  -- A case in which a hand grenade is used as a blunt striking object in
  -- an attack would not be in this class.
  fun HandgrenadeAttack : Class ;
  fun HandgrenadeAttack_Class : SubClass HandgrenadeAttack Bombing ;

  -- The part or parts of an Artifact that are designed to be 
  -- held with the Hands when the Artifact is used or carried.
  fun Handle : Class ;
  fun Handle_Class : SubClass Handle EngineeringComponent ;

  -- The BodyPosition where one rests on one's hands 
  -- and extends one's feet in the air.
  fun Handstand : Ind BodyPosition ;

  -- Suffocating someone by suspending him/her from 
  -- a rope wound around the neck until asphyxiation occurs.
  fun Hanging : Class ;
  fun Hanging_Class : SubClass Hanging Suffocating ;

  -- The state of being happy, experiencing pleasure, 
  -- joy or contentment. Note that this Attribute covers both active enjoyment, 
  -- as well as the emotional state of simply being free from anxiety or fear.
  fun Happiness : Ind EmotionalState ;

  -- Gathering the plant results of Agriculture.
  fun Harvesting : Class ;
  fun Harvesting_Class : SubClass Harvesting Removing ;

  -- A type of Clothing that is worn on the Head. Note 
  -- that this class covers caps, bonnets, berets, etc.
  fun Hat : Class ;
  fun Hat_Class : SubClass Hat Clothing ;

  -- The part of the body containing the sense organs and 
  -- the brain.
  fun Head : Class ;
  fun Head_Class : SubClass Head (both AnimalAnatomicalStructure BodyPart) ;

  -- Pain that that is restricted to the Head.
  fun Headache : Ind EmotionalState ;

  -- Any VehicleLight which is attached to the front of a Vehicle.
  fun Headlight : Class ;
  fun Headlight_Class : SubClass Headlight VehicleLight ;

  -- The Organ that pumps Blood throughout the body.
  fun Heart : Class ;
  fun Heart_Class : SubClass Heart (both AnimalAnatomicalStructure Organ) ;

  -- A Device whose purpose is Heating something, 
  -- e.g. electric heaters, heat lamps, ovens, stoves, etc.
  fun HeatingDevice : Class ;
  fun HeatingDevice_Class : SubClass HeatingDevice Device ;

  -- Any Aircraft with rapidly rotating wings.
  fun Helicopter : Class ;
  fun Helicopter_Class : SubClass Helicopter Aircraft ;

  -- A Female Chicken.
  fun Hen : Class ;
  fun Hen_Chicken : SubClassC Hen Chicken (\H -> attribute(var Chicken Object ? H)(el SexAttribute Attribute ? Female));

  -- A plant_eating Mammal.
  fun Herbivore : Class ;
  fun Herbivore_Class : SubClass Herbivore Mammal ;

  -- A School which admits students who have 
  -- graduated from a middle school and which normally covers the ninth through 
  -- twelfth grades. A HighSchool confers a high school diploma.
  fun HighSchool : Class ;
  fun HighSchool_Class : SubClass HighSchool School ;

  -- Robbing a Vehicle and then driving
  -- or piloting it away.
  fun Hijacking : Class ;
  fun Hijacking_Class : SubClass Hijacking Robbing ;

  -- An EngineeringComponent that connects one thing to 
  -- another in such a way that they can move relative to one another.
  fun Hinge : Class ;
  fun Hinge_Class : SubClass Hinge EngineeringComponent ;

  -- A FactualAccount that describes 
  -- significant events that occurred in the past.
  fun HistoricalAccount : Class ;
  fun HistoricalAccount_Class : SubClass HistoricalAccount (both FactualText NarrativeText) ;

  -- The recording and interpretation of past events involving 
  -- Humans, including political events and cultural practices.
  fun History : Ind FieldOfStudy ;

  -- HoistingDevice is a subclass of 
  -- mechanical Devices that provide a mechanical advantage in lifting 
  -- and lowering, e.g., by use of a block and tackle.
  fun HoistingDevice : Class ;
  fun HoistingDevice_Class : SubClass HoistingDevice MaterialHandlingEquipment ;

  -- A large class of Devices whose purpose is to hold 
  -- something else, i.e. be the instrument of a Keeping.
  fun Holder : Class ;
  fun Holder_Class : SubClass Holder Device ;

  -- A stiff piece of Paper, usually folded over, which 
  -- is sent to others in celebration of a Holiday.
  fun HolidayCard : Class ;
  fun HolidayCard_Class : SubClass HolidayCard ContentBearingObject ;

  -- A Container for a Pistol. It is generally made of 
  -- Leather and worn on either the shoulder or the waist.
  fun Holster : Class ;
  fun Holster_Class : SubClass Holster Container ;

  -- The final BaseballBase which must be touched 
  -- by the batter in order to achieve a BaseballRun.
  fun HomeBase : Class ;
  fun HomeBase_Class : SubClass HomeBase BaseballBase ;

  -- An edible, sweet Substance produced by some species of 
  -- Bees.
  fun Honey : Class ;
  fun Honey_Class : SubClass Honey (both AnimalSubstance Food) ;

  -- The hard end of the Foot of a HoofedMammal.
  fun Hoof : Class ;
  fun Hoof_Class : SubClass Hoof (both AnimalAnatomicalStructure BodyPart) ;

  -- A Hormone secreted by the ThyroidGland.
  fun HormoneTSH : Class ;
  fun HormoneTSH_Class : SubClass HormoneTSH Hormone ;

  -- An outgrowth of Bone that is found on some 
  -- HoofedMammals.
  fun Horn : Class ;
  fun Horn_Class : SubClass Horn Bone ;

  -- A MusicalInstrument which is played by 
  -- blowing it. It uses lip vibration to generates sound and control part 
  -- of the pitch generation process as well.
  fun HornInstrument : Class ;
  fun HornInstrument_Class : SubClass HornInstrument MusicalInstrument ;

  -- A domesticated HoofedMammal that is used for 
  -- transportation and work.
  fun Horse : Class ;
  fun Horse_Class : SubClass Horse (both HoofedMammal Livestock) ;

  -- Any instance of Carrying where the Animal is 
  -- a Horse.
  fun HorseRiding : Class ;
  fun HorseRiding_Class : SubClass HorseRiding Carrying ;

  -- A Building that serves at the place of business for
  -- a HospitalOrganization.
  fun HospitalBuilding : Class ;
  fun HospitalBuilding_Class : SubClass HospitalBuilding TemporaryResidence ;

  -- A CareOrganization where patients reside for a 
  -- short period of time while they undergo treatment for a disease or disorder.
  fun HospitalOrganization : Class ;
  fun HospitalOrganization_Class : SubClass HospitalOrganization CareOrganization ;

  -- An event in which one agent keeps another
  -- against his or her will, in order to force it or a third agent to 
  -- accede to some demand. The hostages are typically kept in the place
  -- where they are first taken hostage, in contrast to a Kidnapping.
  -- Hostage taking often involves a number of people (although it may be
  -- just one), again, in contrast to a Kidnapping.
  fun HostageTaking : Class ;
  fun HostageTaking_Class : SubClass HostageTaking UnilateralGetting ;

  -- A building which servers the purpose of a temporary
  -- home for people, either for people who are travelling, or occasionally for
  -- those who do not have another more permanent residence. A hotel is 
  -- distinguished from a homeless shelter, or a residence loaned to a friend
  -- in that the primary purpose of the building is to generate revenue in
  -- return for the priviledge of staying there. Many hotels contains other 
  -- facilities such as Restaurants or health clubs or even miscellaneous stores
  -- although that is not their primary business or purpose.
  fun Hotel : Class ;
  fun Hotel_Class : SubClass Hotel (both Building TemporaryResidence) ;

  -- A role occupied by a wife who manages the home 
  -- while her husband earns income for the family.
  fun Housewife : Ind SocialRole ;

  -- The class of Humans that are 18 years of 
  -- age or older.
  fun HumanAdult : Class ;
  fun HumanAdult_Class : SubClass HumanAdult Human ;

  -- A Human between birth and the first year of age.
  fun HumanBaby : Class ;
  fun HumanBaby_Class : SubClass HumanBaby HumanChild ;

  -- A HumanYouth between birth and puberty, i.e a 
  -- Human who is NonFullyFormed.
  fun HumanChild : Class ;
  fun HumanChild_Class : SubClass HumanChild HumanYouth ;

  -- A Dead thing which was formerly a Human.
  fun HumanCorpse : Class ;
  fun HumanCorpse_Class : SubClass HumanCorpse OrganicObject ;

  -- A Human who is owned by someone else.
  fun HumanSlave : Ind SocialRole ;

  -- The class of Humans that are younger than 
  -- 18 years of age.
  fun HumanYouth : Class ;
  fun HumanYouth_Class : SubClass HumanYouth Human ;

  -- The Attribute that applies to Animals and Humans 
  -- when they want Food.
  fun Hungry : Ind BiologicalAttribute ;

  -- Any OrganicCompound that contains only Carbon 
  -- and Hydrogen.
  fun Hydrocarbon : Class ;
  fun Hydrocarbon_Class : SubClass Hydrocarbon OrganicCompound ;

  -- The part of the Brain lying below the 
  -- thalamus that serves to regulate AutonomicProcesses.
  fun Hypothalamus : Class ;
  fun Hypothalamus_Class : SubClass Hypothalamus (both AnimalAnatomicalStructure BodyPart) ;

  -- Water that has the PhysicalState of Solid.
  fun Ice : Class ;
  fun Ice_Water : SubClassC Ice Water (\ICE -> attribute(var Water Object ? ICE)(el PhysicalState Attribute ? Solid));

  -- A proposition is Illegal just in case it is inconsistent 
  -- with any proposition that is a Law.
  fun Illegal : Ind DeonticAttribute ;

  -- Forming a mental picture of something which 
  -- is not present.
  fun Imagining : Class ;
  fun Imagining_Class : SubClass Imagining PsychologicalProcess ;

  -- Any Translocation by a Human from one Nation 
  -- to another Nation where the person is not a citizen for the purpose of taking 
  -- up residence.
  fun Immigrating : Class ;
  fun Immigrating_Class : SubClass Immigrating Translocation ;

  -- The class of Confining processes where the detainee 
  -- is put in Prison.
  fun Imprisoning : Class ;
  fun Imprisoning_Class : SubClass Imprisoning Confining ;

  -- An attack in which an agent
  -- uses a device which causes fire in order to destroy life or property.
  fun IncendiaryDeviceAttack : Class ;
  fun IncendiaryDeviceAttack_Class : SubClass IncendiaryDeviceAttack (both Combustion ViolentContest) ;

  -- Moving one's body downward from a vertical position. 
  -- Note that this class covers cases of leaning forward, as well as those of 
  -- reclining backwards.
  fun Inclining : Class ;
  fun Inclining_Class : SubClass Inclining (both BodyMotion MotionDownward) ;

  -- A Tax on annual income.
  fun IncomeTax : Class ;
  fun IncomeTax_Class : SubClass IncomeTax Tax ;

  -- Pointing out a person, place or thing with 
  -- one's hand or with an Artifact.
  fun Indicating : Class ;
  fun Indicating_Class : SubClass Indicating (both BodyMotion Communication) ;

  -- Any Region which is enclosed by a Building.
  fun Indoors : Ind Region ;

  -- A Building or part of a Building or group 
  -- of Buildings whose purpose is to Manufacture something.
  fun IndustrialPlant : Class ;
  fun IndustrialPlant_Class : SubClass IndustrialPlant StationaryArtifact ;

  -- The class of Collections of Corporations 
  -- which are in the same line of business.
  fun Industry : Class ;
  fun Industry_Class : SubClass Industry Collection ;

  -- Any DiseaseOrSyndrome that is caused by a 
  -- Microorganism.
  fun InfectiousDisease : Class ;
  fun InfectiousDisease_Class : SubClass InfectiousDisease DiseaseOrSyndrome ;

  -- An event in which an agent joins an
  -- organization under false pretenses. The objective of such an act
  -- is often to gather information helpful to a rival organization.
  fun Infiltration : Class ;
  fun Infiltration_Class : SubClass Infiltration JoiningAnOrganization ;

  -- Any Quantity that is not limited or bounded 
  -- in magnitude.
  fun InfiniteQuantity : Class ;
  fun InfiniteQuantity_Class : SubClass InfiniteQuantity Quantity ;

  -- Any instance of Breathing where the breath is 
  -- taken into the Lungs.
  fun Inhaling : Class ;
  fun Inhaling_Class : SubClass Inhaling Breathing ;

  -- Any UnilateralGetting where the agent 
  -- receives some part of the property of a person upon the death of the 
  -- person.
  fun Inheriting : Class ;
  fun Inheriting_Class : SubClass Inheriting UnilateralGetting ;

  -- Inside is a PositionalAttribute used to 
  -- describe the relative location of one object or region to another 
  -- region. For example, (orientation Virginia UnitedStates Inside).
  fun Inside : Ind PositionalAttribute ;

  -- Putting a Device in a location and configuring 
  -- the Device so that it can be used as intended after the installation.
  fun Installing : Class ;
  fun Installing_Class : SubClass Installing Putting ;

  -- Music which is produced (at least in part) 
  -- by a MusicalInstrument.
  fun InstrumentalMusic : Class ;
  fun InstrumentalMusic_Class : SubClass InstrumentalMusic Music ;

  -- A Hormone secreted by the Pancreas that is used 
  -- to regulate the metabolism of Carbohydrates.
  fun Insulin : Class ;
  fun Insulin_Class : SubClass Insulin Hormone ;

  -- A CommercialAgent that insures Agents 
  -- for the payment of a premium or premiums.
  fun InsuranceCompany : Class ;
  fun InsuranceCompany_Class : SubClass InsuranceCompany CommercialAgent ;

  -- A Certificate that states the terms of an 
  -- insurance contract.
  fun InsurancePolicy : Class ;
  fun InsurancePolicy_Class : SubClass InsurancePolicy Certificate ;

  -- The FieldOfStudy of designing the interiors of Buildings.
  fun InteriorDesign : Ind FieldOfStudy ;

  -- InternalCombustionEngine is 
  -- the subclass of Engines in which a heat reaction that occurs inside 
  -- the engine is transformed into mechanical energy.
  fun InternalCombustionEngine : Class ;
  fun InternalCombustionEngine_Class : SubClass InternalCombustionEngine Engine ;

  -- An Attribute that applies to Propositions 
  -- that express Laws concerning the relations between Nations.
  fun InternationalLaw : Ind DeonticAttribute ;

  -- A FormalMeeting whose purpose is to acquire 
  -- information from the interviewee that can be used in a media report.
  fun Interviewing : Class ;
  fun Interviewing_Class : SubClass Interviewing FormalMeeting ;

  -- A BodyVessel which connects the Stomach to 
  -- the anus and which is used in digesting Food.
  fun Intestine : Class ;
  fun Intestine_Class : SubClass Intestine (both AnimalAnatomicalStructure BodyVessel) ;

  -- An item of value purchased for income or capital appreciation.
  fun Investment : Class ;
  fun Investment_Class : SubClass Investment FinancialAsset ;

  -- An electronically charged Atom or Molecule. In 
  -- other words, a PureSubstance that has lost one of its Electrons.
  fun Ion : Class ;
  fun Ion_Class : SubClass Ion PureSubstance ;

  -- A very hard substance that makes up the tusks of 
  -- elephants and walruses.
  fun Ivory : Class ;
  fun Ivory_Class : SubClass Ivory Bone ;

  -- Any Position which involves cleaning a Building 
  -- or some of the Rooms within a Building.
  fun Janitor : Class ;
  fun Janitor_Class : SubClass Janitor UnskilledOccupation ;

  -- The Profession of being a news reporter, i.e. 
  -- investigating and reporting, in a publication or broadcast program, current 
  -- events.
  fun Journalist : Class ;
  fun Journalist_Class : SubClass Journalist Profession ;

  -- An Attorney who has the power of deciding legal cases.
  fun Judge : Class ;
  fun Judge_Class : SubClass Judge (both Attorney GovernmentOfficer) ;

  -- Any MotionUpward which is done by one's body 
  -- and which results in a situation where one's feet are unsupported.
  fun Jumping : Class ;
  fun Jumping_Class : SubClass Jumping (both BodyMotion MotionUpward) ;

  -- The class of PostSecondarySchools that 
  -- offer an associate's degree and do not offer a bachelor's degree.
  fun JuniorCollege : Class ;
  fun JuniorCollege_Class : SubClass JuniorCollege PostSecondarySchool ;

  -- A GroupOfPeople who are given the duty of rendering a 
  -- verdict with respect to a LegalAction.
  fun Jury : Class ;
  fun Jury_Class : SubClass Jury GroupOfPeople ;

  -- A Device which opens and closes a Lock.
  fun Key : Class ;
  fun Key_Class : SubClass Key SecurityDevice ;

  -- Any instance of Impelling where the instrument 
  -- is a Foot of the agent.
  fun Kicking : Class ;
  fun Kicking_Class : SubClass Kicking Impelling ;

  -- An event in which one agent keeps another
  -- against his or her will, in order to force it or a third agent to 
  -- accede to some demand. The kidnapped party is normally removed from
  -- the location where first attacked. In contrast to a HotageTaking,
  -- a kidnapping normally involves an attack on one, or a very small 
  -- number of people, such as a couple.
  fun Kidnapping : Class ;
  fun Kidnapping_Class : SubClass Kidnapping Robbing ;

  -- An Organ that separates urine from other 
  -- BodySubstances and passes it to the bladder.
  fun Kidney : Class ;
  fun Kidney_Class : SubClass Kidney (both AnimalAnatomicalStructure Organ) ;

  -- The class of Touching processes where the lips 
  -- of two persons are brought into contact with each other.
  fun Kissing : Class ;
  fun Kissing_Class : SubClass Kissing Touching ;

  -- A Room intended for Cooking.
  fun Kitchen : Class ;
  fun Kitchen_Class : SubClass Kitchen Room ;

  -- The joint in the Leg connecting the tibia and fibula 
  -- with the femur.
  fun Knee : Class ;
  fun Knee_Class : SubClass Knee BodyJoint ;

  -- The BodyPosition of resting one's weight on one's Knees.
  fun Kneeling : Ind BodyPosition ;

  -- A sharp object used for cutting. The object must 
  -- have at least single blade or major protrusion which may be sharp at its 
  -- end as well. It may be sharp on both sides, or just one. Unlike an awl 
  -- it has a sharp edge rather than a point. Unlike scissors, it is a single 
  -- blade without additional articulated parts. Unlike an axe, a knife is 
  -- well_designed for slicing rather than chopping, although a heavy knife 
  -- such as a broadsword can also be used for chopping, whereas a non_knife is 
  -- not well designed for slicing meat for example. A knife can be small like 
  -- a pocket knife, or large like a two_handed broadsword. A knife may also 
  -- include other protrusions such as in the split swords and trident_like 
  -- objects (that also possess a long sharp edge) in Chinese weaponry.
  fun Knife : Class ;
  fun Knife_Class : SubClass Knife CuttingDevice ;

  -- An attack in which a knife is used.
  fun KnifeAttack : Class ;
  fun KnifeAttack_Class : SubClass KnifeAttack ViolentContest ;

  -- A SocialRole that is assigned by the 
  -- UnitedKingdom to persons for reasons of personal merit.
  fun Knight : Ind SocialRole ;

  -- Any joint in a Finger.
  fun Knuckle : Class ;
  fun Knuckle_Class : SubClass Knuckle BodyJoint ;

  -- A very brief Text that is attached to an Object 
  -- and that indicates very specific information about the Object, e.g. its 
  -- name, its monetaryValue, etc.
  fun Label : Class ;
  fun Label_Class : SubClass Label Text ;

  -- A Process in which some or all of the 
  -- employees of an Organization refuse to work until their pay is 
  -- increased or their working conditions are improved in some respect.
  fun LaborStriking : Class ;
  fun LaborStriking_Class : SubClass LaborStriking OrganizationalProcess ;

  -- A Building, Room or suite of Rooms where 
  -- scientific research, i.e. Experimenting, is conducted.
  fun Laboratory : Class ;
  fun Laboratory_Class : SubClass Laboratory StationaryArtifact ;

  -- An Artifact which consists of two parallel supports 
  -- connected by a series of rungs which can be used to ascend or descend.
  fun Ladder : Class ;
  fun Ladder_Class : SubClass Ladder Artifact ;

  -- A young Sheep, i.e. a Sheep that is NonFullyFormed.
  fun Lamb : Class ;
  fun Lamb_Sheep : SubClassC Lamb Sheep (\L -> attribute (var Sheep Object ? L)
                                                         (el DevelopmentalAttribute Attribute ? NonFullyFormed));

  -- Any instance of Transportation where the 
  -- instrument is a LandVehicle.
  fun LandTransportation : Class ;
  fun LandTransportation_Class : SubClass LandTransportation Transportation ;

  -- LandVehicle is the class of TransportationDevices that travel on 
  -- land. The two main types of LandVehicle are RoadVehicle and 
  -- RailVehicle. Note that this includes vehicles which travel on any solid
  -- surface, including a frozen body of water or snow.
  fun LandVehicle : Class ;
  fun LandVehicle_Class : SubClass LandVehicle Vehicle ;

  -- Any instance of Translocation which ends up on something other 
  -- than an AtmosphericRegion and which has an instance of Flying as a subProcess.
  fun Landing : Class ;
  fun Landing_Class : SubClass Landing Translocation ;

  -- (LastFn ?LIST) returns the last item in the 
  -- List ?LIST. For example, (LastFn (ListFn Monday Tuesday 
  -- Wednesday)) would return the value of Wednesday.
  fun LastFn : El List -> Ind Entity ;

  -- A Language that was spoken in ancient Rome and 
  -- is still the official language of the Vatican.
  fun LatinLanguage : Ind (both SpokenHumanLanguage NaturalLanguage) ;

  -- Expressing happiness by Vocalizing in a 
  -- certain way.
  fun Laughing : Class ;
  fun Laughing_Class : SubClass Laughing (both FacialExpression Vocalizing) ;

  -- Any RegulatoryProcess where the agent is either 
  -- a PoliceOrganization or a member of a PoliceOrganization. This covers 
  -- everything from issuing a traffic ticket to arresting someone on suspicion of having 
  -- committed a Murder.
  fun LawEnforcement : Class ;
  fun LawEnforcement_Class : SubClass LawEnforcement (both PoliticalProcess RegulatoryProcess) ;

  -- A CultivatedLandArea and Field 
  -- containing mowed Grass.
  fun Lawn : Class ;
  fun Lawn_Class : SubClass Lawn (both CultivatedLandArea Field) ;

  -- Any OrganismProcess where an Egg is expelled 
  -- from the body of a Animal, e.g. a Bird or Reptile laying eggs.
  fun LayingEggs : Class ;
  fun LayingEggs_Class : SubClass LayingEggs OrganismProcess ;

  -- A Fabric that is the result of tanning an Animal 
  -- Skin.
  fun Leather : Class ;
  fun Leather_Class : SubClass Leather Fabric ;

  -- The initial part of any instance of Translocation.
  fun Leaving : Class ;
  fun Leaving_Class : SubClass Leaving Translocation ;

  -- Any instance of Speaking which is done before an 
  -- assembled audience.
  fun Lecture : Class ;
  fun Lecture_Class : SubClass Lecture (both Demonstrating Speaking) ;

  -- The lower Limbs of Primates.
  fun Leg : Class ;
  fun Leg_Class : SubClass Leg Limb ;

  -- A proposition is Legal just in case it is not inconsistent 
  -- with any proposition that is a Law.
  fun Legal : Ind DeonticAttribute ;

  -- Asking that a higher court reconsider a LegalDecision 
  -- of a lower court.
  fun LegalAppeal : Class ;
  fun LegalAppeal_Class : SubClass LegalAppeal (both JudicialProcess Requesting) ;

  -- Any LegalDecision where the defendant is found 
  -- not to be guilty of the crime for which the corresponding trial was held.
  fun LegalAquittal : Class ;
  fun LegalAquittal_Class : SubClass LegalAquittal LegalDecision ;

  -- Any LegalDecision which gives to the plaintiff of 
  -- the corresponding LegalAction some amount of monetary compensation.
  fun LegalAward : Class ;
  fun LegalAward_Class : SubClass LegalAward LegalDecision ;

  -- Any LegalAction of which a Government is 
  -- the agent.
  fun LegalCharge : Class ;
  fun LegalCharge_Class : SubClass LegalCharge LegalAction ;

  -- Any LegalDecision where the defendant is found 
  -- guilty of the crime for which the corresponding trial was held.
  fun LegalConviction : Class ;
  fun LegalConviction_Class : SubClass LegalConviction LegalDecision ;

  -- Any LegalDecision where the LegalAction of 
  -- the plaintiff is dismissed by the court, e.g. for lack of merit.
  fun LegalDismissal : Class ;
  fun LegalDismissal_Class : SubClass LegalDismissal LegalDecision ;

  -- An Argument that explains the reasoning behind a 
  -- LegalDecision.
  fun LegalOpinion : Class ;
  fun LegalOpinion_Class : SubClass LegalOpinion Argument ;

  -- An official order that a person appear at a 
  -- CourtRoom at a specified time.
  fun LegalSummons : Class ;
  fun LegalSummons_Class : SubClass LegalSummons (both JudicialProcess Ordering) ;

  -- The Attribute of being a proposed law, 
  -- i.e. being under consideration by a legislative body of Government.
  fun LegislativeBill : Ind DeonticAttribute ;

  -- LegislativeOrganization is the 
  -- class of Organizations that have as their main purpose the passing of 
  -- laws or regulations.
  fun LegislativeOrganization : Class ;
  fun LegislativeOrganization_Class : SubClass LegislativeOrganization Organization ;

  -- A citrus FruitOrVegetable that has a Yellow skin 
  -- and a tart, acidic flavor.
  fun LemonFruit : Class ;
  fun LemonFruit_Class : SubClass LemonFruit (both Food FruitOrVegetable) ;

  -- Increasing the length of something.
  fun Lengthening : Class ;
  fun Lengthening_Class : SubClass Lengthening Increasing ;

  -- An OpticalDevice which consists of a polished, 
  -- transparent piece of glass or plastic. Lenses are often part of 
  -- other OpticalDevices.
  fun Lens : Class ;
  fun Lens_Class : SubClass Lens OpticalDevice ;

  -- Any AbnormalAnatomicalStructure which is the result of 
  -- an Injuring and which is found on the surface of an Organ.
  fun Lesion : Class ;
  fun Lesion_Class : SubClass Lesion AbnormalAnatomicalStructure ;

  -- A brief message which is intended to be mailed 
  -- to a person or Organization.
  fun Letter : Class ;
  fun Letter_Class : SubClass Letter FactualText ;

  -- An attack with a bomb that is
  -- concealed in a letter or package, which is typically designed to 
  -- explode upon opening.
  fun LetterBombAttack : Class ;
  fun LetterBombAttack_Class : SubClass LetterBombAttack Bombing ;

  -- The ShapeAttribute of Objects where no 
  -- part of the top of the Object is higher than any other part of the 
  -- top.
  fun LevelShape : Ind ShapeAttribute ;

  -- An EducationalOrganization which is a repository 
  -- of Texts which have been classified for efficient retrieval.
  fun Library : Class ;
  fun Library_Class : SubClass Library EducationalOrganization ;

  -- License is the subclass of Certificates that 
  -- are granted by a GovernmentOrganization and that authorize the performance 
  -- of a kind of action, e.g., driving, exporting, travelling to another 
  -- country, etc.
  fun License : Class ;
  fun License_Class : SubClass License Certificate ;

  -- The class of Touching processes where the Tongue 
  -- is brought into contact with something else.
  fun Licking : Class ;
  fun Licking_Class : SubClass Licking Touching ;

  -- A commissioned MilitaryOfficer.
  fun Lieutenant : Class ;
  fun Lieutenant_Class : SubClass Lieutenant MilitaryOfficer ;

  -- The second_in_command of some Governments 
  -- of AmericanStates.
  fun LieutenantGovernor : Ind Position ;

  -- Any Device whose purpose is to be a source of 
  -- visible light.
  fun LightFixture : Class ;
  fun LightFixture_Class : SubClass LightFixture Device ;

  -- A WeatherProcess which involves a significant 
  -- release of electricity from a Cloud.
  fun Lightning : Class ;
  fun Lightning_Class : SubClass Lightning (both Radiating WeatherProcess) ;

  -- A FloweringPlant that has large clusters of 
  -- aromatic flowers.
  fun Lilac : Class ;
  fun Lilac_Class : SubClass Lilac FloweringPlant ;

  -- Any of the limbs of a Vertebrate.
  -- Animal Appendages with joints that are used for movement 
  -- and grasping.
  fun Limb : Class ;
  fun Limb_Class : SubClass Limb (both AnimalAnatomicalStructure BodyPart) ;

  -- A ShapeAttribute that applies to 
  -- Collections and indicates that all of the members of the Collection 
  -- are arrayed in a line, i.e. each member (except possibly the first) is 
  -- behind or to the side of exactly one other member.
  fun LineFormation : Ind ShapeAttribute ;

  -- Any Attribute that is 
  -- expressed by a Language or class of Languages.
  fun LinguisticAttribute : Class ;
  fun LinguisticAttribute_Class : SubClass LinguisticAttribute InternalAttribute ;

  -- The field of linguistics.
  fun Linguistics : Ind SocialScience ;

  -- Folds of Tissue surrounding the mouths of some 
  -- Vertebrates.
  fun Lip : Class ;
  fun Lip_Class : SubClass Lip (both AnimalAnatomicalStructure BodyPart) ;

  -- LiquefiedPetroleumGas is a 
  -- compressed hydrocarbon gas.
  fun LiquefiedPetroleumGas : Class ;
  fun LiquefiedPetroleumGas_Class : SubClass LiquefiedPetroleumGas (both FossilFuel RefinedPetroleumProduct) ;

  -- Any BodySubstance which is Liquid 
  -- under normal circumstances.
  fun LiquidBodySubstance : Class ;
  fun LiquidBodySubstance_Class : SubClass LiquidBodySubstance BodySubstance ;

  -- A UnitOfMeasure used in preparing AlcoholicBeverages.
  fun LiquorShot : Ind UnitOfVolume ;

  -- The ability to read and write. Someone who 
  -- has this Attribute is able to read and write.
  fun LiteracyAttribute : Ind TraitAttribute ;

  -- The study of literature, i.e. instances of FictionalText 
  -- that are regarded as having special merit.
  fun Literature : Ind FieldOfStudy ;

  -- An Organ that secretes bile and serves metabolic 
  -- functions.
  fun Liver : Class ;
  fun Liver_Class : SubClass Liver (both AnimalAnatomicalStructure Organ) ;

  -- Livestock is the class of live animals 
  -- raised as AgriculturalProducts.
  fun Livestock : Class ;
  fun Livestock_Class : SubClass Livestock (both AnimalAgriculturalProduct DomesticAnimal) ;

  -- Inserting ammunition into a ProjectileWeapon 
  -- in such a way that the ammunition can be fired by the weapon.
  fun LoadingWeapon : Class ;
  fun LoadingWeapon_Class : SubClass LoadingWeapon Inserting ;

  -- A Device, which, through a Key or a combination prevents 
  -- access to a Container or StationaryArtifact.
  fun Lock : Class ;
  fun Lock_Class : SubClass Lock SecurityDevice ;

  -- A three dimensional object that
  -- has two thin dimensions and one markedly larger one.
  fun LongAndThin : Ind ShapeAttribute ;

  -- The process of transitioning from a state 
  -- of being Awake to a state of being Unconscious.
  fun LosingConsciousness : Class ;
  fun LosingConsciousness_Class : SubClass LosingConsciousness PsychologicalProcess ;

  -- The ContestAttribute that applies to a Contest 
  -- participant who has lost the Contest.
  fun Lost : Ind ContestAttribute ;

  -- A respiratory organ of Vertebrates. Its function is 
  -- to furnish the blood with oxygen and to remove carbon dioxide.
  fun Lung : Class ;
  fun Lung_Class : SubClass Lung (both AnimalAnatomicalStructure Organ) ;

  -- The BodyMotion of moving from a Sitting 
  -- to a Prostrate position.
  fun LyingDown : Class ;
  fun LyingDown_Class : SubClass LyingDown (both BodyMotion MotionDownward) ;

  -- A lynching is a form of Killing conducted under 
  -- a thin guise of legitimacy by a vigilante group. It may be a purge of an 
  -- individual from the group who is perceived to have gone astray, or it may 
  -- be the summary execution of an individual outside the group that the group 
  -- has determined has violated some law or code, either of the group, or the 
  -- larger society. A lynching is distinguished from a legal execution in 
  -- that the laws of a government are not followed in carrying out the 
  -- killing. A lynching is distinguished from a murder in that there is the 
  -- pretense of some process carried out by a group in the name of their own 
  -- group or a higher power.
  fun Lynching : Class ;
  fun Lynching_Class : SubClass Lynching Killing ;

  -- Any Text which is intended to be sung.
  fun Lyrics : Class ;
  fun Lyrics_Class : SubClass Lyrics Text ;

  -- A Periodical that is softbound and printed on 
  -- glossy paper.
  fun Magazine : Class ;
  fun Magazine_Class : SubClass Magazine Periodical ;

  -- Any instance of RadiatingElectromagnetic which 
  -- involves the attraction of Iron.
  fun Magnetism : Class ;
  fun Magnetism_Class : SubClass Magnetism RadiatingElectromagnetic ;

  -- Any ServicePosition where various needs of a person 
  -- or family are served over a long period of time. Note that these Positions 
  -- are, by definition, filled only by Women.
  fun Maid : Class ;
  fun Maid_Class : SubClass Maid ServicePosition ;

  -- A Container whose purpose is to receive items 
  -- that are mailed to the address associated with the Mailbox.
  fun Mailbox : Class ;
  fun Mailbox_Class : SubClass Mailbox Container ;

  -- Any instance of Transfer where a postal system is 
  -- used to move the patient, either a letter or a package.
  fun Mailing : Class ;
  fun Mailing_Class : SubClass Mailing Transfer ;

  -- A CerealGrain which is found on long ears of a Plant 
  -- native to the Americas.
  fun MaizeGrain : Class ;
  fun MaizeGrain_Class : SubClass MaizeGrain (both CerealGrain GroceryProduce) ;

  -- A MilitaryGeneral that ranks above a BrigadierGeneral.
  fun MajorGeneral : Class ;
  fun MajorGeneral_Class : SubClass MajorGeneral MilitaryGeneral ;

  -- Indicates that a Device is not performing 
  -- its intended function.
  fun Malfunctioning : Ind DeviceAttribute ;

  -- A pipe which has several outlets for other pipes that flow 
  -- into or out of it.
  fun Manifold : Class ;
  fun Manifold_Class : SubClass Manifold EngineeringComponent ;

  -- Any Position which involves manual 
  -- work.
  fun ManualLabor : Class ;
  fun ManualLabor_Class : SubClass ManualLabor Position ;

  -- An Icon which represents one or more GeographicAreas 
  -- (or even the entire Earth).
  fun Map : Class ;
  fun Map_Class : SubClass Map Icon ;

  -- A metamorphic Rock that is used in Constructing 
  -- and in creating Sculptures.
  fun Marble : Class ;
  fun Marble_Class : SubClass Marble Rock ;

  -- An area, building, or set of buildings
  -- where FinancialTransactions are intended to take place. There should
  -- be more than one owner or renter of space or buildings within the
  -- marketplace.
  fun Marketplace : Class ;
  fun Marketplace_Class : SubClass Marketplace GeographicArea ;

  -- A Contract between a married couple 
  -- about how assets owned by the couple will be distributed in the event 
  -- that the couple is divorced.
  fun MarriageContract : Ind DeonticAttribute ;

  -- A PoliceOfficer whose responsibility is to enforce 
  -- the decisions of a law court.
  fun Marshal : Class ;
  fun Marshal_Class : SubClass Marshal PoliceOfficer ;

  -- A subclass of TherapeuticProcess which involves 
  -- kneading Muscles in such a way that tension is relieved, blood circulation 
  -- is increased, etc.
  fun Massaging : Class ;
  fun Massaging_Class : SubClass Massaging (both TherapeuticProcess Touching) ;

  -- A large pole in the center of a WaterVehicle which is 
  -- used to support a sail.
  fun Mast : Class ;
  fun Mast_Class : SubClass Mast Artifact ;

  -- A small stick of carboard or wood that is treated 
  -- with chemicals that can be easily ignited with friction. MatchDevices are 
  -- used for starting fires.
  fun MatchDevice : Class ;
  fun MatchDevice_Class : SubClass MatchDevice Device ;

  -- MaterialHandlingEquipment is a class of Devices that are equipment used for handling goods and 
  -- supplies more efficiently or safely. Examples are cranes, hoists, forklifts, conveyors, racks, etc.
  fun MaterialHandlingEquipment : Class ;
  fun MaterialHandlingEquipment_Class : SubClass MaterialHandlingEquipment Device ;

  -- The FieldOfStudy dealing with quantities and their 
  -- relations to one another.
  fun Mathematics : Ind FieldOfStudy ;

  -- Any process of sexual intercourse between two Humans 
  -- or Animals.
  fun Mating : Class ;
  fun Mating_Class : SubClass Mating OrganismProcess ;

  -- The head of the Government of a City.
  fun Mayor : Ind Position ;

  -- MediaOrganization is the subclass 
  -- of Organization for groups whose primary purpose is the production or 
  -- dissemination of media content. For organizations that physically enable 
  -- Communication, see CommunicationOrganization.
  fun MediaOrganization : Class ;
  fun MediaOrganization_Class : SubClass MediaOrganization Organization ;

  -- A CareOrganization which provides medical care 
  -- on an out_patient basis only, i.e. there are no rooms where patients may take 
  -- up residence for a period of time while they receive care.
  fun MedicalClinic : Class ;
  fun MedicalClinic_Class : SubClass MedicalClinic CareOrganization ;

  fun MedicalClinicBuilding : Class ;
  fun MedicalClinicBuilding_Class : SubClass MedicalClinicBuilding Building ;

  -- The Profession of being a medical doctor, 
  -- i.e. having attended medical school and being licensed to practice medicine.
  fun MedicalDoctor : Class ;

  -- A GraduateSchool that is devoted to 
  -- MedicalScience and that grants the degree of doctor of medicine.
  fun MedicalSchool : Class ;
  fun MedicalSchool_Class : SubClass MedicalSchool GraduateSchool ;

  -- The field of medicine.
  fun MedicalScience : Ind Science ;

  -- Any BiologicallyActiveSubstance which has a 
  -- therapeutic effect under certain conditions.
  fun Medicine : Class ;
  fun Medicine_Class : SubClass Medicine BiologicallyActiveSubstance ;

  -- The process of committing a Text to memory.
  fun Memorizing : Class ;
  fun Memorizing_Class : SubClass Memorizing Learning ;

  -- A periodic discharge of Blood and other 
  -- BiologicalSubstances by Females that is part of a readjustment of 
  -- the uterus.
  fun Menstruation : Class ;
  fun Menstruation_Class : SubClass Menstruation OrganOrTissueProcess ;

  -- A FactualText which is intended to be delivered to 
  -- and read by a Human, GroupOfPeople or Organization.
  fun Message : Class ;
  fun Message_Class : SubClass Message FactualText ;

  -- Any instance of Transfer where a Message is the 
  -- patient.
  fun Messaging : Class ;
  fun Messaging_Class : SubClass Messaging Transfer ;

  -- A Mixture of two or more Metals, and possibly 
  -- nonmetallic elements as well. For example, steel is an alloy containing iron 
  -- and manganese.
  fun MetallicAlloy : Class ;
  fun MetallicAlloy_Class : SubClass MetallicAlloy Mixture ;

  -- Any Meteoroid that leaves traces on the surface 
  -- of Earth.
  fun Meteorite : Class ;
  fun Meteorite_Class : SubClass Meteorite Meteoroid ;

  -- Any AstronomicalBody that breaks through the 
  -- Atmosphere of Earth.
  fun Meteoroid : Class ;
  fun Meteoroid_Class : SubClass Meteoroid AstronomicalBody ;

  -- MetricTon is a UnitOfMeasure that represents 
  -- a weight of 2,205 PoundMass.
  fun MetricTon : Ind UnitOfMass ;

  -- A CommunicationDevice that converts sound 
  -- into electrical energy.
  fun Microphone : Class ;
  fun Microphone_Class : SubClass Microphone (both CommunicationDevice ElectricDevice) ;

  -- An OpticalDevice with a stand and a focus, which is 
  -- used for magnifying the images of things that are placed in the stand.
  fun Microscope : Class ;
  fun Microscope_Class : SubClass Microscope OpticalDevice ;

  -- A militant is someone who is not 
  -- officially authorized by a government to engage in combat, but who
  -- does so on behalf of a PoliticalOrganization.
  fun Militant : Ind SocialRole ;

  -- Any Aircraft which is made for a 
  -- MilitaryOrganization. This includes fighters, Bombers, attack 
  -- helicopters, etc.
  fun MilitaryAircraft : Class ;
  fun MilitaryAircraft_Class : SubClass MilitaryAircraft (both Aircraft MilitaryVehicle) ;

  -- Any Artifact which is made for a 
  -- MilitaryOrganization.
  fun MilitaryArtifact : Class ;
  fun MilitaryArtifact_Class : SubClass MilitaryArtifact Artifact ;

  -- Any MilitaryUnit with the rank of 
  -- corps.
  fun MilitaryCorps : Class ;
  fun MilitaryCorps_Class : SubClass MilitaryCorps MilitaryUnit ;

  -- A GeographicArea along which opposing military 
  -- forces confront one another in a Battle.
  fun MilitaryFront : Class ;
  fun MilitaryFront_Class : SubClass MilitaryFront GeographicArea ;

  -- MilitaryGeneral is a generic Position 
  -- that indicates holding (or having held) the rank of General in some 
  -- military force. An indicator that someone uses the title, without 
  -- committing to his or her exact rank or military affiliation.
  fun MilitaryGeneral : Class ;
  fun MilitaryGeneral_Class : SubClass MilitaryGeneral MilitaryOfficer ;

  -- Any Process by a MilitaryOrganization 
  -- which involves moving through enemy positions without detection by the enemy.
  fun MilitaryInfiltration : Class ;
  fun MilitaryInfiltration_Class : SubClass MilitaryInfiltration (both MilitaryProcess Translocation) ;

  -- A StationaryArtifact consisting of grounds 
  -- and Buildings that is intended to be used by a MilitaryOrganization.
  fun MilitaryInstallation : Class ;
  fun MilitaryInstallation_Class : SubClass MilitaryInstallation (both MilitaryArtifact StationaryArtifact) ;

  -- Any Maneuver which takes place in a Battle 
  -- and which is intended to secure a tactical advantage for one of the agents of 
  -- the Battle.
  fun MilitaryManeuver : Class ;
  fun MilitaryManeuver_Class : SubClass MilitaryManeuver Maneuver ;

  -- The class of Soldiers who have authority or command.
  fun MilitaryOfficer : Class ;
  fun MilitaryOfficer_Class : SubClass MilitaryOfficer Soldier ;

  -- Someone who is a member of a
  -- ModernMilitaryOrganization.
  fun MilitaryPerson : Ind OccupationalRole ;

  -- An enlisted Soldier of the lowest rank.
  fun MilitaryPrivate : Class ;
  fun MilitaryPrivate_Class : SubClass MilitaryPrivate Soldier ;

  -- MilitaryReserveForce is the subclass 
  -- of MilitaryOrganizations that consist of forces trained in military 
  -- procedures and activities, which are subject to being called to active duty 
  -- if needed.
  fun MilitaryReserveForce : Class ;
  fun MilitaryReserveForce_Class : SubClass MilitaryReserveForce MilitaryOrganization ;

  -- The study of the principles of war.
  fun MilitaryScience : Ind FieldOfStudy ;

  -- A branch of the armed forces of a Nation. 
  -- For example, there are five military services in the United States, the army, 
  -- the navy, the air force, the marines, and the coast guard.
  fun MilitaryService : Class ;
  fun MilitaryService_Class : SubClass MilitaryService MilitaryOrganization ;

  -- Any Ship which is made for a MilitaryOrganization. 
  -- This includes aircraft carriers, destroyers, etc.
  fun MilitaryShip : Class ;
  fun MilitaryShip_Class : SubClass MilitaryShip (both MilitaryWaterVehicle Ship) ;

  -- Any MilitaryUnit with the rank of squad.
  fun MilitarySquad : Class ;
  fun MilitarySquad_Class : SubClass MilitarySquad MilitaryUnit ;

  -- Any MilitaryArtifact which is sold to a 
  -- non_military customer.
  fun MilitarySurplus : Class ;
  fun MilitarySurplus_Class : SubClass MilitarySurplus MilitaryArtifact ;

  -- A MilitaryVehicle that moves along the ground 
  -- on treaded wheels and that contains a large cannon.
  fun MilitaryTank : Class ;
  fun MilitaryTank_Class : SubClass MilitaryTank (both ArtilleryGun (both MilitaryVehicle RoadVehicle)) ;

  -- Any MilitaryOrganization that can be dispatched 
  -- to an area of operations.
  fun MilitaryUnit : Class ;
  fun MilitaryUnit_Class : SubClass MilitaryUnit MilitaryOrganization ;

  -- Any Vehicle which is intended to be 
  -- used by a MilitaryOrganization. MilitaryVehicle Military platforms which are also vehicles. 
  -- This would include things like airplanes and tanks, but exclude things like 
  -- towed platforms.
  fun MilitaryVehicle : Class ;
  fun MilitaryVehicle_Class : SubClass MilitaryVehicle Vehicle ;

  -- MilitaryWaterVehicle is the class of 
  -- all WaterVehicle owned or leased for use by some MilitaryOrganization.
  fun MilitaryWaterVehicle : Class ;
  fun MilitaryWaterVehicle_Class : SubClass MilitaryWaterVehicle WaterVehicle ;

  -- A nutritious BodySubstance produced by Mammals
  -- that has evolved to provide nourishment for their offspring during
  -- their initial period of life.
  fun Milk : Class ;
  fun Milk_Class : SubClass Milk (both Beverage LiquidBodySubstance) ;

  -- The UnitOfDuration of 1000 years.
  fun MillenniumDuration : Ind UnitOfDuration ;

  -- An construction in the earth from which Minerals are removed, 
  -- either in pure form or as part of ores.
  fun Mine : Class ;
  fun Mine_Class : SubClass Mine StationaryArtifact ;

  -- MiningProduct is the class of things 
  -- that are produced from the earth for human use by mining or another form 
  -- of extraction. This includes metal ores, petroleum, and other products.
  fun MiningProduct : Class ;
  fun MiningProduct_Class : SubClass MiningProduct Product ;

  -- An Artifact with a surface that is capable of 
  -- displaying an image by reflecting light.
  fun Mirror : Class ;
  fun Mirror_Class : SubClass Mirror Artifact ;

  -- A Projectile which is propelled by a rocket and 
  -- contains a Bomb.
  fun Missile : Class ;
  fun Missile_Class : SubClass Missile (both Projectile SelfPoweredDevice) ;

  -- The class of ReligiousOrganizations 
  -- that send members to foreign countries with the aim of coverting citizens 
  -- of those countries to the beliefs of the ReligiousOrganization.
  fun MissionOrganization : Class ;
  fun MissionOrganization_Class : SubClass MissionOrganization ReligiousOrganization ;

  -- Anything which serves to house people but 
  -- which changes its location from time to time, e.g. a motorhome, a mobile 
  -- home, a camp, etc. Note that MobileResidence is disjoint from Residence, 
  -- because the latter is a subclass of StationaryArtifact.
  fun MobileResidence : Class ;
  fun MobileResidence_Class : SubClass MobileResidence Artifact ;

  -- Any Position which involves posing for an 
  -- artist or photographer.
  fun ModellingPosition : Class ;
  fun ModellingPosition_Class : SubClass ModellingPosition Position ;

  -- Music which has a single part, i.e. Music 
  -- which cannot be divided into two or more contemporaneous subProcesses which 
  -- are also instances of Music.
  fun MonophonicMusic : Class ;
  fun MonophonicMusic_Class : SubClass MonophonicMusic Music ;

  -- A StationaryArtifact whose purpose is to commemorate 
  -- a person, animal or event.
  fun Monument : Class ;
  fun Monument_Class : SubClass Monument StationaryArtifact ;

  -- The class of TimeIntervals that begin at Sunrise 
  -- and end at noon.
  fun Morning : Class ;
  fun Morning_Class : SubClass Morning DayTime ;

  -- A mortar is a bomb that is shot at a location. A 
  -- howitzer is a weapon that fires mortars. The mortar may not include the 
  -- propelling charge that provides the motive force for delivering it to its 
  -- target, which distinguishes it from a rocket. A mortar is distinguished 
  -- from other bombs in that it is propelled rather than exploded in place, or 
  -- dropped, or propelled by human power.
  fun Mortar : Class ;
  fun Mortar_Class : SubClass Mortar Weapon ;

  -- An attack in which a Mortar weapon is
  -- used.
  fun MortarAttack : Class ;
  fun MortarAttack_Class : SubClass MortarAttack Bombing ;

  -- A short_range Gun that is positioned on the ground 
  -- at a high angle and fires explosive shells.
  fun MortarGun : Class ;
  fun MortarGun_Class : SubClass MortarGun ArtilleryGun ;

  -- Nocturnal Insect with a large body and antennae.
  fun Moth : Class ;
  fun Moth_Class : SubClass Moth Insect ;

  -- A discrete part of a MotionPicture which is set in 
  -- the same time period and the same location.
  fun MotionPictureScene : Class ;
  fun MotionPictureScene_Class : SubClass MotionPictureScene MotionPicture ;

  -- A unit of action in a MotionPicture, a 
  -- MotionPictureShot is a sequence of images which are captured by a single 
  -- camera without interruption.
  fun MotionPictureShot : Class ;
  fun MotionPictureShot_Class : SubClass MotionPictureShot MotionPicture ;

  -- Motorcycle is the subclass of RoadVehicles 
  -- that have two wheels one behind the other in the frame, upon which the rider 
  -- sits on a seat above the engine.
  fun Motorcycle : Class ;
  fun Motorcycle_Class : SubClass Motorcycle (both SelfPoweredRoadVehicle RoadVehicle) ;

  -- MotorizedRailwayCar is the subclass 
  -- of railway cars that carry their own power source.
  fun MotorizedRailwayCar : Class ;
  fun MotorizedRailwayCar_Class : SubClass MotorizedRailwayCar (both PoweredVehicle RollingStock) ;

  -- Any BodyMotion which results in being On 
  -- something else.
  fun Mounting : Class ;
  fun Mounting_Class : SubClass Mounting BodyMotion ;

  -- A Rodent that has a hairless tail like a rat but that 
  -- is smaller than a Rat.
  fun Mouse : Class ;
  fun Mouse_Class : SubClass Mouse Rodent ;

  -- Part of the Face, used for Ingesting Food 
  -- and Vocalizing.
  fun Mouth : Class ;
  fun Mouth_Class : SubClass Mouth (both AnimalAnatomicalStructure BodyPart) ;

  -- The process of changing one's residence, i.e. 
  -- moving one's belongs to a new home.
  fun MovingResidence : Class ;
  fun MovingResidence_Class : SubClass MovingResidence Transfer ;

  -- The product of a Male Donkey and a Female 
  -- Horse. Mules are always sterile.
  fun Mule : Class ;
  fun Mule_Class : SubClass Mule (both DomesticAnimal HoofedMammal) ;

  -- Impermissible Killing of a Human.
  fun Murder : Class ;
  fun Murder_Class : SubClass Murder (both CriminalAction Killing) ;

  -- An EducationalOrganization where Artifacts of historic, 
  -- scientific or aesthetic value are collected and exhibited.
  fun Museum : Class ;
  fun Museum_Class : SubClass Museum EducationalOrganization ;

  -- An AudioRecording of Music. Note that
  -- many AudioRecordings contain music, so only an audio recording without
  -- any music would be an instance of AudioRecording rather than of 
  -- MusicRecording.
  fun MusicRecording : Class ;
  fun MusicRecording_Class : SubClass MusicRecording AudioRecording ;

  -- A Text in a Language that represents a form of music.
  fun MusicText : Class ;
  fun MusicText_Class : SubClass MusicText Text ;

  -- A Text that expresses the notes, 
  -- words, etc. of a song or other sort of Music.
  fun MusicalComposition : Class ;
  fun MusicalComposition_Class : SubClass MusicalComposition Text ;

  -- A GroupOfPeople that create Music 
  -- together.
  fun MusicalGroup : Class ;
  fun MusicalGroup_Class : SubClass MusicalGroup GroupOfPeople ;

  -- A Performance that consists exclusively of 
  -- Music, e.g. an orchestra playing a symphony to an assembled audience.
  fun MusicalPerformance : Class ;
  fun MusicalPerformance_Class : SubClass MusicalPerformance Performance ;

  -- A Process of RadiatingSound where the
  -- sound has a fundamental frequency and 0 or more partial frequencies
  -- or unrelated transients or noise components that have a lesser
  -- amplitude than the fundamental.
  fun MusicalTone : Class ;
  fun MusicalTone_Class : SubClass MusicalTone RadiatingSound ;

  -- A Musician is someone who is capable of giving a MusicalPerformance.
  -- This includes amateurs and others who don't formally make a living at the activity
  -- or choose it as a profession.
  fun Musician : Ind SocialRole ;

  -- A FictionalText whose central plot element is a 
  -- crime of some sort, usually a murder.
  fun MysteryStory : Class ;
  fun MysteryStory_Class : SubClass MysteryStory FictionalText ;

  -- An AttachingDevice which is a thin piece of metal, with 
  -- or without a head, that is fastened with a Hammer.
  fun Nail : Class ;
  fun Nail_Class : SubClass Nail AttachingDevice ;

  -- Any of the horny structures which are found 
  -- on the DigitAppendages of Primates and other Animals. This includes
  -- fingernails and toenails.
  fun NailDigit : Class ;
  fun NailDigit_Class : SubClass NailDigit AnimalAnatomicalStructure ;

  -- Any Text that tells a story, whether true 
  -- or false.
  fun NarrativeText : Class ;
  fun NarrativeText_Class : SubClass NarrativeText Text ;

  -- A Flag that is the official flag of a Nation, 
  -- e.g. the stars and stripes is the NationalFlag of the UnitedStates.
  fun NationalFlag : Class ;
  fun NationalFlag_Class : SubClass NationalFlag Flag ;

  -- The German PoliticalParty headed by Adolf Hitler.
  fun NaziParty : Ind PoliticalParty ;

  -- The part of the body that connects the Head to the 
  -- rest of the body.
  fun Neck : Class ;
  fun Neck_Class : SubClass Neck (both AnimalAnatomicalStructure BodyPart) ;

  -- A sweet, sticky liquid that is produced by Plants 
  -- and that attracts Insects.
  fun Nectar : Class ;
  fun Nectar_Class : SubClass Nectar PlantSubstance ;

  -- A Contest where each participant attempts to 
  -- maximize his self_interest in a Promise that marks the end of the Contest.
  fun Negotiating : Class ;
  fun Negotiating_Class : SubClass Negotiating (both Contest LinguisticCommunication) ;

  -- The Cells that make up a NervousSystem.
  fun NerveCell : Class ;
  fun NerveCell_Class : SubClass NerveCell (both AnimalAnatomicalStructure Cell) ;

  -- Any structure which is created by nonhuman Animals for 
  -- the purpose of giving birth to their offspring.
  fun Nest : Class ;
  fun Nest_Class : SubClass Nest CorpuscularObject ;

  -- Any PsychologicalDysfunction which is not due 
  -- to an organic impairment of the NervousSystem.
  fun Neurosis : Class ;
  fun Neurosis_Class : SubClass Neurosis PsychologicalDysfunction ;

  -- The second and final part of the ChristianBible,
  -- describing the life and teachings of Jesus Christ and the activities of his 
  -- apostles.
  fun NewTestament : Class ;
  fun NewTestament_Class : SubClass NewTestament Book ;

  -- A BroadcastProgram that is devoted to 
  -- reporting the latest events in a city, region, nation or the world at 
  -- large.
  fun NewsProgram : Class ;
  fun NewsProgram_Class : SubClass NewsProgram BroadcastProgram ;

  -- The Profession of being a news reporter, i.e. 
  -- investigating and reporting, in a publication or broadcast program, current 
  -- events.
  fun NewsReporter : Ind Profession ;

  -- A Periodical that is published on a daily or 
  -- weekly basis, that contains Reports, and whose issues are printed on 
  -- newsprint paper.
  fun Newspaper : Class ;
  fun Newspaper_Class : SubClass Newspaper Periodical ;

  -- The class of TimeIntervals that begin at Sunset
  -- and end at Sunrise.
  fun NightTime : Class ;
  fun NightTime_Class : SubClass NightTime TimeInterval ;

  -- Moving the Head up and down or side to side 
  -- to indicate approval or disapproval.
  fun Nodding : Class ;
  fun Nodding_Class : SubClass Nodding Gesture ;

  -- Any Organization whose purpose is something 
  -- other than making a profit.
  fun NonprofitOrganization : Class ;
  fun NonprofitOrganization_Class : SubClass NonprofitOrganization Organization ;

  -- The class of DiseaseOrSyndromes that are not 
  -- caused by a single type of Microorganism.
  fun NonspecificDisease : Class ;
  fun NonspecificDisease_Class : SubClass NonspecificDisease DiseaseOrSyndrome ;

  -- The Organ of Smelling.
  fun Nose : Class ;
  fun Nose_Class : SubClass Nose (both AnimalAnatomicalStructure Organ) ;

  -- Either of two BodyVessels that run through the Nose 
  -- and connect it to the Throat.
  fun Nostril : Class ;
  fun Nostril_Class : SubClass Nostril (both AnimalAnatomicalStructure BodyVessel) ;

  -- A FictionalText that is larger than a ShortStory 
  -- and that is bound independently (i.e. it is a Book).
  fun Novel : Class ;
  fun Novel_Class : SubClass Novel (both Book FictionalText) ;

  -- A NuclearFamily is a SocialUnit composed
  -- of at least two and not more than three generations of familyRelations:
  -- parents, their children, and possibly the parents' parents (children's
  -- grandparents).
  fun NuclearFamily : Class ;
  fun NuclearFamily_Class : SubClass NuclearFamily (both FamilyGroup SocialUnit) ;

  -- An ExplosiveDevice and RadioactiveWeapon
  -- which achieves its effect by means of a critical mass of a radioactive substance.
  fun NuclearWeapon : Class ;
  fun NuclearWeapon_Class : SubClass NuclearWeapon (both ExplosiveDevice (both RadioactiveWeapon Weapon)) ;

  -- Any WoodArtifact that is made from the Wood of an oak tree.
  fun OakWood : Class ;
  fun OakWood_Class : SubClass OakWood WoodArtifact ;

  -- A Device consisting of a flat, broad surface attached to a 
  -- handle that is used as an instrument in Rowing.
  fun Oar : Class ;
  fun Oar_Class : SubClass Oar TransportationDevice ;

  -- Any TwoDimensionalAngle that has an 
  -- angularMeasure that is greater than 90 AngularDegrees.
  fun ObliqueAngle : Class ;
  fun ObliqueAngle_Class : SubClass ObliqueAngle TwoDimensionalAngle ;

  -- (OccupationFn ?PROCESS) denotes the 
  -- subclass of ?PROCESS where instances of ?PROCESS are performed as 
  -- one's occupation, i.e. as part of a FinancialTransaction where one 
  -- earns money for the performance of ?PROCESS.
  fun OccupationFn : El IntentionalProcess -> Desc FinancialTransaction ;

  -- A Role of a Human in a OrganizationalProcess.
  fun OccupationalRole : Class ;
  fun OccupationalRole_Class : SubClass OccupationalRole Position ;

  -- Any Position that involves skilled manual work.
  fun OccupationalTrade : Class ;
  fun OccupationalTrade_Class : SubClass OccupationalTrade (both ManualLabor SkilledOccupation) ;

  -- Offering to sell something to someone.
  fun OfferingForSale : Class ;
  fun OfferingForSale_Class : SubClass OfferingForSale Offering ;

  -- Offering to buy something from someone.
  fun OfferingToPurchase : Class ;
  fun OfferingToPurchase_Class : SubClass OfferingToPurchase Offering ;

  -- A building in which work activities take
  -- place which is not primarily designed for manufacturing or retail sales.
  fun OfficeBuilding : Class ;
  fun OfficeBuilding_Class : SubClass OfficeBuilding Building ;

  -- A greasy, viscous Solution that cannot be mixed with Water. 
  -- Note that this general class covers petroleum oil, vegetable oil, animal fat, etc.
  fun Oil : Class ;
  fun Oil_Class : SubClass Oil Solution ;

  -- Any Paint which is an oil_based Solution.
  fun OilPaint : Class ;
  fun OilPaint_Class : SubClass OilPaint Paint ;

  -- Any OilPicture which is created 
  -- with oil_based paints.
  fun OilPicture : Class ;
  fun OilPicture_Class : SubClass OilPicture PaintedPicture ;

  -- The first part of the ChristianBible, describing 
  -- the history of the Hebrew people.
  fun OldTestament : Class ;
  fun OldTestament_Class : SubClass OldTestament Book ;

  -- An Ontology is a
  -- ClassificationScheme that links concepts via many different
  -- relations. Ontologies typically are not restricted to binary
  -- relations and are structured by several kinds of conceptual
  -- hierarchies, including set_ or class_based subsumption, spatial
  -- containment, mereology
  -- (theory of parts and wholes), and logical contexts. Thus,
  -- an ontology typically includes multiple taxonomies.
  fun Ontology : Class ;
  fun Ontology_Class : SubClass Ontology ClassificationScheme ;

  -- The Class of Processes where an aperture is 
  -- created in an Object. Note that the aperture may be created intentionally, 
  -- as when one opens a door, or unintentionally, as when the ground ruptures 
  -- in a seismic event.
  fun Opening : Class ;
  fun Opening_Class : SubClass Opening Motion ;

  -- The BodyMotion of relaxing the eye lids so that 
  -- the corneas are exposed to light.
  fun OpeningEyes : Class ;
  fun OpeningEyes_Class : SubClass OpeningEyes (both EyeMotion Opening) ;

  -- A DramaticPlay that is set to Music.
  fun Opera : Class ;
  fun Opera_Class : SubClass Opera DramaticPlay ;

  -- A Device which enables someone to see something 
  -- more clearly or with greater magnification.
  fun OpticalDevice : Class ;
  fun OpticalDevice_Class : SubClass OpticalDevice Device ;

  -- A SecondaryColor that results from mixing Red 
  -- and Yellow and resembles the color of a ripe orange fruit.
  fun OrangeColor : Ind SecondaryColor ;

  -- A citrus FruitOrVegetable that has an OrangeColor skin and a sweet, acidic flavor.
  fun OrangeFruit : Class ;
  fun OrangeFruit_Class : SubClass OrangeFruit (both Food FruitOrVegetable) ;

  -- A GroupOfPeople that create InstrumentalMusic together.
  fun Orchestra : Class ;
  fun Orchestra_Class : SubClass Orchestra MusicalGroup ;

  -- The Process of directing an orchestra.
  fun OrchestralConducting : Class ;
  fun OrchestralConducting_Class : SubClass OrchestralConducting Guiding ;

  -- A Sentence that expresses an order for something or that something be done.
  fun Order : Class ;
  fun Order_Sentence : SubClassC Order Sentence (\SENTENCE -> exists Ordering (\ORDER -> result(var Ordering Process ? ORDER)(var Sentence Entity ? SENTENCE)));

  -- Any CompoundSubstance that has a Carbon base.
  fun OrganicCompound : Class ;
  fun OrganicCompound_Class : SubClass OrganicCompound CompoundSubstance ;

  -- Any BiologicalProcess that results in the formation of an Organ.
  fun Organification : Class ;
  fun Organification_Class : SubClass Organification OrganOrTissueProcess ;

  -- Part of an Organization that 
  -- is responsible for managing the Organization.
  fun OrganizationalBoard : Class ;
  fun OrganizationalBoard_Class : SubClass OrganizationalBoard Organization ;

  -- The process of two or more 
  -- Organizations merging into a single Organization.
  fun OrganizationalMerging : Class ;
  fun OrganizationalMerging_Class : SubClass OrganizationalMerging OrganizationalProcess ;

  -- A method for representing the sounds of a Language 
  -- with written Characters.
  fun Orthography : Class ;
  fun Orthography_Class : SubClass Orthography Procedure ;

  -- Any BiologicalProcess that results in the 
  -- formation of Bones.
  fun Ossification : Class ;
  fun Ossification_Class : SubClass Ossification OrganOrTissueProcess ;

  -- Clothing that is intended to be worn outdoors.
  fun OutdoorClothing : Class ;
  fun OutdoorClothing_Class : SubClass OutdoorClothing Clothing ;

  -- Any Region which is not enclosed by a Building 
  -- or part of a Building.
  fun Outdoors : Ind Region ;

  -- The class of all Regions which are 
  -- neither GeographicAreas nor AtmosphericRegions.
  fun OuterSpaceRegion : Class ;
  fun OuterSpaceRegion_Class : SubClass OuterSpaceRegion SpaceRegion ;

  -- Outside is a PositionalAttribute used to 
  -- describe the relative location of one object or region to another 
  -- region. For example, (orientation Cuba UnitedStates Outside).
  fun Outside : Ind PositionalAttribute ;

  -- A HeatingDevice with a door for inserting and removing 
  -- Food that is to undergo Baking.
  fun Oven : Class ;
  fun Oven_Class : SubClass Oven (both Container HeatingDevice) ;

  -- A nocturnal bird of prey with a large head and 
  -- forward_facing eyes.
  fun Owl : Class ;
  fun Owl_Class : SubClass Owl Bird ;

  -- Any ChemicalProcess where Electrons 
  -- are removed from the substance undergoing the ChemicalProcess.
  fun Oxidation : Class ;
  fun Oxidation_Class : SubClass Oxidation ChemicalDecomposition ;

  -- A single page of Text.
  fun Page : Ind UnitOfInformation ;

  -- A physical sensation of discomfort which can vary widely 
  -- in intensity.
  fun Pain : Ind EmotionalState ;

  -- Any Solution which is capable of Coloring something.
  fun Paint : Class ;
  fun Paint_Class : SubClass Paint Solution ;

  -- Any ArtWork which is produced by Painting.
  fun PaintedPicture : Class ;
  fun PaintedPicture_Class : SubClass PaintedPicture ArtWork ;

  -- The application of Paint to a surface. Note that 
  -- this class covers both ArtPainting (the creation of PaintedPictures), as 
  -- well as painting one's kitchen, for example.
  fun Painting : Class ;
  fun Painting_Class : SubClass Painting (both Coloring Covering) ;

  -- A large Gland that secretes Insulin and other 
  -- substances.
  fun Pancreas : Class ;
  fun Pancreas_Class : SubClass Pancreas Gland ;

  -- Paper is a flat sheet of fibers, usually produced by 
  -- spreading a wet solution of wood particles on a flat surface and drying 
  -- through heat and pressure. The fibers can also be cotton or a synthetic, 
  -- although typically the bulk of the substance is wood fibers. This 
  -- includes all manner of paper products that may have varying thicknesses, 
  -- colors or texture. This is distinguished from flat wood products such as 
  -- plywood and particle board which have a structural function in building 
  -- construction. Sheathing materials such as the paper affixed to sheetrock 
  -- however, is paper.
  fun Paper : Class ;
  fun Paper_Class : SubClass Paper Artifact ;

  -- A Text which consists of one or more sentences, 
  -- begins with an indented line, and expresses a single topic.
  fun Paragraph : Class ;
  fun Paragraph_Class : SubClass Paragraph Text ;

  -- A publicly owned LandArea which is intended to be used 
  -- for recreation and/or exercise.
  fun Park : Class ;
  fun Park_Class : SubClass Park LandArea ;

  -- A LandArea which has been levelled, paved, and 
  -- marked off for parking Automobiles.
  fun ParkingLot : Class ;
  fun ParkingLot_Class : SubClass ParkingLot StationaryArtifact ;

  -- Any Position where the employee is not 
  -- salaried and is paid for less than 40 hours of work per week.
  fun PartTimePosition : Class ;
  fun PartTimePosition_Class : SubClass PartTimePosition Position ;

  -- A CommercialAgent that is owned by more 
  -- than one person.
  fun Partnership : Class ;
  fun Partnership_Class : SubClass Partnership CommercialAgent ;

  -- A Text which is authored by a PoliticalParty 
  -- and which contains the core goals and principles of the PoliticalParty for a 
  -- particular year or election cycle.
  fun PartyPlatform : Class ;
  fun PartyPlatform_Class : SubClass PartyPlatform FactualText ;

  -- A Certificate that allows the holder to 
  -- be at or away from a specified location, e.g. a pass for a leave of 
  -- absence, a hall pass, a pass to enter a cleared facility, etc.
  fun PassCertificate : Class ;
  fun PassCertificate_Class : SubClass PassCertificate Certificate ;

  -- A Vehicle that is designed to
  -- carry Humans. Note that Vehicles that are not designed to
  -- carry people may still do so. For example, a boxcar might still
  -- transport homeless people, but was not built to do so.
  fun PassengerVehicle : Class ;
  fun PassengerVehicle_Class : SubClass PassengerVehicle Vehicle ;

  -- The Process of converting a LegislativeBill 
  -- into Law by a duly authorized legislative body of Government.
  fun PassingABill : Class ;
  fun PassingABill_Class : SubClass PassingABill (both Declaring PoliticalProcess) ;

  -- A License which identifies the holder and permits 
  -- travel between different countries.
  fun Passport : Class ;
  fun Passport_Class : SubClass Passport License ;

  -- A military deployment which is intended
  -- to prevent hostilities between two other entities located in the same rough
  -- geographic area.
  fun PeaceKeepingMission : Class ;
  fun PeaceKeepingMission_Class : SubClass PeaceKeepingMission MilitaryOrganization ;

  -- A FruitOrVegetable that has a thick skin and the 
  -- shape of a tear drop.
  fun PearFruit : Class ;
  fun PearFruit_Class : SubClass PearFruit (both Food FruitOrVegetable) ;

  -- Removing the Skin (or part of the Skin) from 
  -- an Organism. Note that this class covers a large range of cases, including 
  -- peeling an orange, pelting an Animal, etc.
  fun Peeling : Class ;
  fun Peeling_Class : SubClass Peeling Removing ;

  -- A WritingDevice that consists of an encased piece of 
  -- graphite.
  fun Pencil : Class ;
  fun Pencil_Class : SubClass Pencil WritingDevice ;

  -- A qualified retirement plan set up by a 
  -- corporation, labor union, government, or other organization for its 
  -- employees. Examples include profit_sharing plans, stock bonus and 
  -- employee stock ownership plans, thrift plans, target benefit plans, 
  -- money purchase plans, and defined benefit plans.
  fun PensionPlan : Class ;
  fun PensionPlan_Class : SubClass PensionPlan FinancialAccount ;

  -- A MusicalInstrument which does not 
  -- have strings and which is played by striking it.
  fun PercussionInstrument : Class ;
  fun PercussionInstrument_Class : SubClass PercussionInstrument MusicalInstrument ;

  -- A Demonstrating which includes DramaticActing 
  -- and/or Music and which is intended to entertain the audience.
  fun Performance : Class ;
  fun Performance_Class : SubClass Performance Demonstrating ;

  -- A discrete subProcess of a Performance, 
  -- e.g. an act of a play, a movement of a performance of a symphony, etc.
  fun PerformanceAct : Class ;
  fun PerformanceAct_Class : SubClass PerformanceAct Performance ;

  -- A Text that describes the events 
  -- and/or participants in a Performance.
  fun PerformanceProgram : Class ;
  fun PerformanceProgram_Class : SubClass PerformanceProgram FactualText ;

  -- A large platform for theatrical plays, 
  -- lectures, dances, music recitals, etc, which can be observed by an audience.
  fun PerformanceStage : Class ;
  fun PerformanceStage_Class : SubClass PerformanceStage StationaryArtifact ;

  -- A part of the PerformanceStage that is not 
  -- visible to members of the audience.
  fun PerformanceStageWing : Class ;
  fun PerformanceStageWing_Class : SubClass PerformanceStageWing StationaryArtifact ;

  -- Any Publisher that publishes 
  -- Periodicals, e.g. newspaper and magazine publishing houses.
  fun PeriodicalPublisher : Class ;
  fun PeriodicalPublisher_Class : SubClass PeriodicalPublisher Publisher ;

  -- PetroleumProduct is a broad class that 
  -- includes both crude oil (Petroleum) and RefinedPetroleumProducts.
  fun PetroleumProduct : Class ;
  fun PetroleumProduct_Class : SubClass PetroleumProduct (both MiningProduct Oil) ;

  -- The Profession of being a pharmacist, i.e. 
  -- preparing and dispensing BiologicallyActiveSubstances.
  fun Pharmacist : Class ;
  fun Pharmacist_Class : SubClass Pharmacist Profession ;

  -- The study of first principles, including epistemology, 
  -- metaphysics, and ethics.
  fun Philosophy : Ind FieldOfStudy ;

  -- An Icon that is the result of a process of Photographing.
  fun Photograph : Class ;
  fun Photograph_Class : SubClass Photograph Icon ;

  -- Celluloid covered with an emulsion which can 
  -- be converted into photographic negatives by a Camera.
  fun PhotographicFilm : Class ;
  fun PhotographicFilm_Class : SubClass PhotographicFilm Artifact ;

  -- ContentDevelopment where the instrument 
  -- is a camera and the result is a Photograph.
  fun Photographing : Class ;
  fun Photographing_Class : SubClass Photographing ContentDevelopment ;

  -- The study of matter and energy and their relations.
  fun Physics : Ind Science ;

  -- The part of Biology dealing with the functioning of 
  -- Organisms.
  fun Physiology : Ind Science ;

  -- A StringInstrument with keys that, when pressed down, 
  -- activate hammers that, in turn, strike strings.
  fun Piano : Class ;
  fun Piano_Class : SubClass Piano StringInstrument ;

  -- A frame which surrounds a PaintedPicture or 
  -- Photograph and has the function of protecting and accenting the picture.
  fun PictureFrame : Class ;
  fun PictureFrame_Class : SubClass PictureFrame Artifact ;

  -- A domesticated HoofedMammal that is raised for pork.
  fun Pig : Class ;
  fun Pig_Class : SubClass Pig (both HoofedMammal Livestock) ;

  -- A subclass of Bird with a stout body and short legs.
  fun Pigeon : Class ;
  fun Pigeon_Class : SubClass Pigeon Bird ;

  -- A soft, stuffed Artifact to support the Head or 
  -- the body as a whole while one is sleeping or relaxing.
  fun Pillow : Class ;
  fun Pillow_Class : SubClass Pillow Artifact ;

  -- A SecondaryColor that results from mixing Red and 
  -- White.
  fun Pink : Ind SecondaryColor ;

  -- Pipeline is the class of pipelines used 
  -- to transport various kinds of fluids.
  fun Pipeline : Class ;
  fun Pipeline_Class : SubClass Pipeline Transitway ;

  -- A Firearm that is intended to be aimed and fired with a 
  -- single hand.
  fun Pistol : Class ;
  fun Pistol_Class : SubClass Pistol Firearm ;

  -- The place where the pitcher in Baseball 
  -- stands when he is throwing balls to the batter.
  fun PitchersMound : Class ;
  fun PitchersMound_Class : SubClass PitchersMound GameArtifact ;

  -- Throwing a Ball to the batter in a game of 
  -- Baseball or softball.
  fun Pitching : Class ;
  fun Pitching_Class : SubClass Pitching (both GameShot Throwing) ;

  -- The main Gland of the endocrine system.
  fun PituitaryGland : Class ;
  fun PituitaryGland_Class : SubClass PituitaryGland Gland ;

  -- A Building or part of a Building which is 
  -- intended for organizational activities, e.g. retail or wholesale selling, 
  -- manufacturing, office work, etc.
  fun PlaceOfCommerce : Class ;
  fun PlaceOfCommerce_Class : SubClass PlaceOfCommerce StationaryArtifact ;

  -- Any place designed for ReligiousProcesses.
  fun PlaceOfWorship : Class ;
  fun PlaceOfWorship_Class : SubClass PlaceOfWorship Building ;

  -- PlacingUnderArrest is the class of events in which a
  -- CognitiveAgent, typically a law enforcement professional,
  -- legally takes into custody a human or group of humans.
  fun PlacingUnderArrest : Class ;
  fun PlacingUnderArrest_Class : SubClass PlacingUnderArrest (both Capturing (both LawEnforcement (both LegalAction SocialInteraction))) ;

  -- PlantAgriculturalProduct 
  -- is the class of AgriculturalProducts that are vegetable in nature, 
  -- in the widest sense, e.g., fruits, grains, green vegetables, cotton, 
  -- linen, flowers, wine grapes, hops.
  fun PlantAgriculturalProduct : Class ;
  fun PlantAgriculturalProduct_Class : SubClass PlantAgriculturalProduct AgriculturalProduct ;

  -- The stem of a Plant or any shoot arising from 
  -- the stem of a Plant.
  fun PlantBranch : Class ;
  fun PlantBranch_Class : SubClass PlantBranch (both BodyPart PlantAnatomicalStructure) ;

  -- An Organ of Plants whose main purpose is 
  -- photosynthesis.
  fun PlantLeaf : Class ;
  fun PlantLeaf_Class : SubClass PlantLeaf (both Organ PlantAnatomicalStructure) ;

  -- An Organ of Plants whose main purpose is twofold, viz. to absorb
  -- nutrients from the ground and to anchor the Plant in place.
  fun PlantRoot : Class ;
  fun PlantRoot_Class : SubClass PlantRoot (both Organ PlantAnatomicalStructure) ;

  -- A small piece of stiff paper with markings 
  -- which is intended to be used for playing card games.
  fun PlayingCard : Class ;
  fun PlayingCard_Class : SubClass PlayingCard (both ContentBearingObject GameArtifact) ;

  -- Stating in a court of law a claim about whether or 
  -- not one is guilty of the crime of which one has been accused.
  fun Pleading : Class ;
  fun Pleading_Class : SubClass Pleading Stating ;

  -- An Artifact which is designed to fit snugly within a Hole.
  fun Plug : Class ;
  fun Plug_Class : SubClass Plug Artifact ;

  -- Any occupation that involves installing, repairing, and 
  -- replacing pipes and pipe fixtures.
  fun Plumber : Ind OccupationalTrade ;

  -- A pouch of Fabric in an instance of Clothing where something can be kept.
  fun Pocket : Class ;
  fun Pocket_Class : SubClass Pocket Fabric ;

  -- A PoliceOfficer who is in charge of a precinct.
  fun PoliceCaptain : Class ;
  fun PoliceCaptain_Class : SubClass PoliceCaptain PoliceOfficer ;

  -- The Profession of being a police 
  -- detective, i.e. being a PoliceOfficer whose duties include the 
  -- investigation of crimes.
  fun PoliceDetective : Ind PoliceOfficer ; 

  -- A building designed to house PolicePersons.
  fun PoliceFacility : Class ;
  fun PoliceFacility_Class : SubClass PoliceFacility Building ;

  -- The Profession of being a police officer, i.e. 
  -- working for a law enforcement agency that is part of a Government.
  fun PoliceOfficer : Class ;
  fun PoliceOfficer_Class : SubClass PoliceOfficer (both GovernmentOfficer Profession) ;

  -- A member of a government whose occupation
  -- has the primary purpose of preventing crime and arresting criminals.
  fun PolicePerson : Ind OccupationalRole ;

  -- A PoliceOfficer with the rank of sergeant.
  fun PoliceSergeant : Class ;
  fun PoliceSergeant_Class : SubClass PoliceSergeant PoliceOfficer ;

  -- A CriminalAction that is committed by or 
  -- against Governments.
  fun PoliticalCrime : Class ;
  fun PoliticalCrime_Class : SubClass PoliticalCrime (both CriminalAction PoliticalProcess) ;

  -- A well known person who participates
  -- in a PoliticalProcess. This must either be the person's principal
  -- occupation, or what is intended to become his principal occupation
  -- (for example, after an election).
  fun PoliticalFigure : Class ;
  fun PoliticalFigure_Class : SubClass PoliticalFigure Celebrity ;

  -- PoliticalParty is the class of 
  -- PoliticalOrganizations that may sponsor candidates for Elections.
  fun PoliticalParty : Class ;
  fun PoliticalParty_Class : SubClass PoliticalParty PoliticalOrganization ;

  -- The violent overthrow of one Government 
  -- and its replacement by another. This covers grass_roots revolutions, as well 
  -- as coups d'etat.
  fun PoliticalRevolution : Class ;
  fun PoliticalRevolution_Class : SubClass PoliticalRevolution (both PoliticalProcess ViolentContest) ;

  -- The field of political science.
  fun PoliticalScience : Ind SocialScience ;

  -- Any Attribute of a Government which specifies some aspect of the political or
  -- economic system of the Government.
  fun PoliticoEconomicAttribute : Class ;
  fun PoliticoEconomicAttribute_Class : SubClass PoliticoEconomicAttribute RelationalAttribute ;

  -- Investigating what people believe (and in what proportions) 
  -- by asking a set of structured questions to a random sample of people.
  fun Polling : Class ;
  fun Polling_Class : SubClass Polling Investigating ;

  -- A ClosedTwoDimensionalFigure that is composed 
  -- exclusively of straight lines, i.e. OneDimensionalFigures.
  fun Polygon : Class ;
  fun Polygon_Class : SubClass Polygon ClosedTwoDimensionalFigure ;

  -- Music which has two or more parts, i.e. Music 
  -- which can be divided into two or more contemporaneous subProcesses which are 
  -- also instances of Music.
  fun PolyphonicMusic : Class ;
  fun PolyphonicMusic_Music : SubClassC PolyphonicMusic Music
                                        (\MUSIC -> exists Music (\PART1 -> 
                                                   exists Music (\PART2 -> and (and (and (and (subProcess (var Music Process ? PART1)
                                                                                                          (var Music Process ? MUSIC))
                                                                                              (subProcess (var Music Process ? PART2)
                                                                                                          (var Music Process ? MUSIC)))
                                                                                         (not (equal (var Music Entity ? PART1)
                                                                                                     (var Music Entity ? PART2))))
                                                                                    (cooccur (var Music Physical ? PART1)
                                                                                             (var Music Physical ? MUSIC)))
                                                                               (cooccur (var Music Physical ? PART2)
                                                                                        (var Music Physical ? MUSIC)))));

  -- The Position of head of the RomanCatholicChurch.
  fun Pope : Ind Position ;

  -- PopularElection is the class of 
  -- Elections in which office_holders and issues are determined directly by 
  -- the outcome of the votes cast by the enfranchised. For example, U.S. 
  -- Senators and Representatives are elected by PopularElection. By 
  -- contrast, U.S. Presidents are elected by indirect elections, in which the 
  -- Electoral College determines the actual outcome. See electionWinner.
  fun PopularElection : Class ;
  fun PopularElection_Class : SubClass PopularElection GeneralElection ;

  -- A StationaryArtifact which is connected to a 
  -- Building and which provides some shelter in entering or leaving the 
  -- Building or in sitting outside.
  fun Porch : Class ;
  fun Porch_Class : SubClass Porch StationaryArtifact ;

  -- Meat that was originally part of a Pig.
  fun Pork : Class ;
  fun Pork_Class : SubClass Pork Meat ;

  -- A PaintedPicture that represents someone's Face.
  fun Portrait : Class ;
  fun Portrait_Class : SubClass Portrait PaintedPicture ;

  -- The class of TimeIntervals that begin at noon and 
  -- end at midnight.
  fun PostMeridiem : Class ;
  fun PostMeridiem_Class : SubClass PostMeridiem TimeInterval ;

  -- The class of Schools that offer 
  -- an associate's degree or a bachelor's degree.
  fun PostSecondarySchool : Class ;
  fun PostSecondarySchool_Class : SubClass PostSecondarySchool School ;

  -- A Container which has a handle and is used for 
  -- Cooking.
  fun PotOrPan : Class ;
  fun PotOrPan_Class : SubClass PotOrPan Container ;

  -- Any occupation that involves the creation of Pottery.
  fun Potter : Ind OccupationalTrade ;

  -- Household Artifacts that are made out of baked Clay.
  fun Pottery : Class ;
  fun Pottery_Class : SubClass Pottery Artifact ;

  fun Poultry : Class ;
  fun Poultry_Class : SubClass Poultry (both Bird Livestock) ;

  -- Any instance of Transfer from one Container to 
  -- another, where the thing transferred is a Liquid.
  fun Pouring : Class ;
  fun Pouring_Class : SubClass Pouring (both LiquidMotion Transfer) ;

  -- Any Solid Substance which consists of loose, 
  -- identical, and very small particles.
  fun Powder : Class ;
  fun Powder_Class : SubClass Powder Substance ;

  -- A source of electrical power.
  fun PowerSource : Class ;
  fun PowerSource_Class : SubClass PowerSource Device ;

  -- A Vehicle that has a powerComponent.
  -- Note that PoweredVehicles include those vehicles that have a powerComponent
  -- where the user can and does often choose not to use it, such as a moped with pedals.
  fun PoweredVehicle : Class ;
  fun PoweredVehicle_Class : SubClass PoweredVehicle Vehicle ;

  -- A formal or informal process of private worship which 
  -- may or may not be carried out in a ReligiousBuilding.
  fun Praying : Class ;
  fun Praying_Class : SubClass Praying (both ReligiousProcess Requesting) ;

  -- The Attribute that applies to Female Animals and 
  -- Humans that have an embryo or fetus growing inside of them as the result of 
  -- having one of the Female's Eggs fertilized.
  fun Pregnant : Ind BiologicalAttribute ;

  -- Food that is the result of Cooking.
  fun PreparedFood : Class ;
  fun PreparedFood_Class : SubClass PreparedFood Food ;

  -- The position of being head of the 
  -- UnitedStates.
  fun PresidentOfTheUnitedStates : Ind Position ;

  -- Any Device that measures and represents PressureMeasure.
  fun PressureMeasuringDevice : Class ;
  fun PressureMeasuringDevice_Class : SubClass PressureMeasuringDevice MeasuringDevice ;

  -- An installation which is owned and maintained by 
  -- a Government for the purpose of Confining people. This class covers 
  -- jails, federal prisons, concentration camps, gulags, etc.
  fun Prison : Class ;
  fun Prison_Class : SubClass Prison StationaryArtifact ;

  -- The Profession of being a private detective, 
  -- i.e. a detective who can be hired for a fee to investigate something.
  fun PrivateDetective : Ind Profession ;

  -- A School which is not publicly owned.
  fun PrivateSchool : Class ;
  fun PrivateSchool_Class : SubClass PrivateSchool School ;

  -- Any instance of Speaking before an assembled 
  -- audience that effects an institutional change, e.g. a change in the laws of 
  -- the government.
  fun Proclaiming : Class ;
  fun Proclaiming_Class : SubClass Proclaiming (both Declaring Lecture) ;

  -- Any occupation that requires at least a bachelor's degree.
  fun Profession : Class ;
  fun Profession_Class : SubClass Profession SkilledOccupation ;

  -- The Profession of being a teacher at a PostSecondarySchool.
  fun Professor : Ind Profession ;

  -- An arrangement in which an employer 
  -- shares its profits with its employees. The compensation can be stocks, 
  -- bonds or cash, and can be immediate or deferred until retirement.
  fun ProfitSharingPlan : Class ;
  fun ProfitSharingPlan_Class : SubClass ProfitSharingPlan PensionPlan ;

  -- A missile, bullet, etc. that is fired from a Weapon.
  fun Projectile : Class ;
  fun Projectile_Class : SubClass Projectile Weapon ;

  -- A Weapon that shoots a Projectile.
  fun ProjectileLauncher : Class ;
  fun ProjectileLauncher_Class : SubClass ProjectileLauncher Weapon ;

  -- The outer casing of a Projectile.
  fun ProjectileShell : Class ;
  fun ProjectileShell_Class : SubClass ProjectileShell Container ;

  -- A CommunicationDevice upon which images 
  -- are projected so that they can be viewed.
  fun ProjectionScreen : Class ;
  fun ProjectionScreen_Class : SubClass ProjectionScreen CommunicationDevice ;

  -- A CommercialAgent that is owned by a 
  -- single person.
  fun Proprietorship : Class ;
  fun Proprietorship_Class : SubClass Proprietorship CommercialAgent ;

  -- Unicellular Organisms that are capable of movement 
  -- and that are found in almost every part of the world. This class includes 
  -- amoebas, sporozoans, and paramecia.
  fun Protozoa : Class ;
  fun Protozoa_Class : SubClass Protozoa Microorganism ;

  -- The field of psychology.
  fun Psychology : Ind SocialScience ;

  -- Any PsychologicalDysfunction which is the 
  -- result of an organic impairment of the NervousSystem.
  fun Psychosis : Class ;
  fun Psychosis_Class : SubClass Psychosis PsychologicalDysfunction ;

  -- The DevelopmentalAttribute of having functional sex 
  -- glands which are not fully mature.
  fun Puberty : Ind DevelopmentalAttribute ;

  -- An Attorney who defends criminal cases for a 
  -- GovernmentOrganization.
  fun PublicDefender : Class ;
  fun PublicDefender_Class : SubClass PublicDefender (both Attorney GovernmentOfficer) ;

  -- A Library which is financed by taxes and which 
  -- is open to everyone.
  fun PublicLibrary : Class ;
  fun PublicLibrary_Class : SubClass PublicLibrary (both GovernmentOrganization Library) ;

  -- A Park that is publicly owned, i.e. owned by a Government.
  fun PublicPark : Class ;
  fun PublicPark_Class : SubClass PublicPark Park ;

  -- An Attorney who prosecutes criminal cases for 
  -- a GovernmentOrganization.
  fun PublicProsecutor : Class ;
  fun PublicProsecutor_Class : SubClass PublicProsecutor (both Attorney GovernmentOfficer) ;

  -- A School which is financed primarily by taxes.
  fun PublicSchool : Class ;
  fun PublicSchool_Class : SubClass PublicSchool (both GovernmentOrganization School) ;

  -- Any business whose services include the 
  -- Publication of Texts.
  fun Publisher : Class ;
  fun Publisher_Class : SubClass Publisher CommercialAgent ;

  -- Any instance of LandTransportation, where a 
  -- TransportationDevice is dragged by something else, whether the something 
  -- else is an Animal or a self_powered TransportationDevice.
  fun Pulling : Class ;
  fun Pulling_Class : SubClass Pulling LandTransportation ;

  -- An Artery that carries Blood from 
  -- the Heart to a Lung.
  fun PulmonaryArtery : Class ;
  fun PulmonaryArtery_Class : SubClass PulmonaryArtery Artery ;

  -- A Vein that carries Blood from the 
  -- Lungs to the Heart.
  fun PulmonaryVein : Class ;
  fun PulmonaryVein_Class : SubClass PulmonaryVein Vein ;

  -- A Device that moves Fluids by means of pressure or suction.
  fun Pump : Class ;
  fun Pump_Class : SubClass Pump TransportationDevice ;

  -- Any instance of Impelling where the instrument 
  -- is a Fist of the agent.
  fun Punching : Class ;
  fun Punching_Class : SubClass Punching Impelling ;

  -- A RegulatoryProcess where the agent does 
  -- something to the destination that the agent knows is undesirable 
  -- for the destination.
  fun Punishing : Class ;
  fun Punishing_Class : SubClass Punishing RegulatoryProcess ;

  -- A SecondaryColor that results from mixing Red and Blue.
  fun Purple : Ind SecondaryColor ;

  -- Any four_sided Polygon.
  fun Quadrilateral : Class ;
  fun Quadrilateral_Class : SubClass Quadrilateral Polygon ;

  -- A Female Insect which is the sole member of 
  -- her colony with the capability to reproduce.
  fun QueenInsect : Class ;
  fun QueenInsect_Class : SubClass QueenInsect Insect ;

  -- An interrogative Sentence, a Sentence that 
  -- poses a question.
  fun Question : Class ;
  fun Question_Sentence : SubClassC Question Sentence (\SENTENCE -> exists Questioning (\QUESTION -> result(var Questioning Process ? QUESTION)(var Sentence Entity ? SENTENCE)));

  -- A burrowing Rodent with a short tail and long ears.
  fun Rabbit : Class ;
  fun Rabbit_Class : SubClass Rabbit Rodent ;

  -- A sport which involves a contest of speed between the 
  -- participants. Note that this covers a variety of things, including auto 
  -- racing, running competitions, etc.
  fun Racing : Class ;
  fun Racing_Class : SubClass Racing Sport ;

  -- An ElectricDevice that emits and receives microwave 
  -- radiation for the purpose of locating and tracking distant objects.
  fun Radar : Class ;
  fun Radar_Class : SubClass Radar ElectricDevice ;

  fun RadiatingInfrared_Radiating : SubClass RadiatingInfrared Radiating ;

  -- All sound waves that have frequencies 
  -- above those that normal Human ears can detect.
  fun RadiatingSoundUltrasonic : Class ;
  fun RadiatingSoundUltrasonic_Class : SubClass RadiatingSoundUltrasonic RadiatingSound ;

  -- Any case of RadiatingElectromagnetic where the 
  -- wavelengths are shorter than those of visible light and longer than those 
  -- of X_Rays.
  fun RadiatingUltraviolet : Class ;
  fun RadiatingUltraviolet_Class : SubClass RadiatingUltraviolet RadiatingElectromagnetic ;

  -- Any instance of RadiatingLight that can 
  -- be detected by normal human visual perception.
  fun RadiatingVisibleLight : Class ;
  fun RadiatingVisibleLight_RadiatingLight : SubClassC RadiatingVisibleLight RadiatingLight 
                                                       (\R -> exists Human (\H -> 
                                                              exists Seeing (\S -> and (agent (var Seeing Process ? S)
                                                                                              (var Human Agent ? H))
                                                                                       (patient (var Seeing Process ? S)
                                                                                                (var RadiatingLight Entity ? R)))));

  -- Any instance of Broadcasting which is 
  -- intended to be received by a RadioReceiver.
  fun RadioBroadcasting : Class ;
  fun RadioBroadcasting_Class : SubClass RadioBroadcasting Broadcasting ;

  -- Any instance of RadiatingElectromagnetic 
  -- where the waves have a wavelength between 5 milimeters and 30,000 meters.
  fun RadioEmission : Class ;
  fun RadioEmission_Class : SubClass RadioEmission RadiatingElectromagnetic ;

  -- A RadioReceiver is a Device for receiving 
  -- radio broadcast signals from a RadioStation.
  fun RadioReceiver : Class ;
  fun RadioReceiver_Class : SubClass RadioReceiver ReceiverDevice ;

  -- A WeaponOfMassDestruction which 
  -- achieves its effect through radioactivity, either by an explosion resulting 
  -- from nuclear fission or by a conventional explosive device that scatters 
  -- radioactive debris.
  fun RadioactiveWeapon : Class ;
  fun RadioactiveWeapon_Class : SubClass RadioactiveWeapon WeaponOfMassDestruction ;

  -- Weapons which are designed to spread 
  -- radioactive particles over a large area by means of a conventional 
  -- explosive device rather than a nuclear reaction. These weapons are often 
  -- referred to as 'dirty bombs'.
  fun RadiologicalWeapon : Class ;
  fun RadiologicalWeapon_Class : SubClass RadiologicalWeapon RadioactiveWeapon ;

  -- A PlantRoot that is often used in salads.
  fun Radish : Class ;
  fun Radish_Class : SubClass Radish (both Food PlantRoot) ;

  -- (RadiusFn ?CIRCLE) denotes the length of the radius 
  -- of the Circle ?CIRCLE.
  fun RadiusFn : El Circle -> Ind LengthMeasure ;

  -- RailTransportationSystem 
  -- is the subclass of TransitSystems whose routes are Railways.
  fun RailTransportationSystem : Class ;
  fun RailTransportationSystem_Class : SubClass RailTransportationSystem TransitSystem ;

  -- A Vehicle designed to move on Railways.
  fun RailVehicle : Class ;
  fun RailVehicle_Class : SubClass RailVehicle LandVehicle ;

  -- Any TransportationCompany whose services 
  -- include Transportation by Train.
  fun RailroadCompany : Class ;
  fun RailroadCompany_Class : SubClass RailroadCompany TransportationCompany ;

  -- Ramp is the class of SelfConnectedObjects that are 
  -- inclined planes used for moving objects from one level to another, 
  -- especially used for wheeled vehicles and people who cannot climb stairs.
  fun Ramp : Class ;
  fun Ramp_Class : SubClass Ramp SelfConnectedObject ;

  -- Any instance of Mating where one participant does not 
  -- consent. This is limited to acts between Humans.
  fun Raping : Class ;
  fun Raping_Class : SubClass Raping (both CriminalAction Mating) ;

  -- A Rodent that has a hairless tail like a Mouse 
  -- but that is larger than a Mouse.
  fun Rat : Class ;
  fun Rat_Class : SubClass Rat Rodent ;

  -- A subclass of Snake which derives its name 
  -- from the fact that it can manipulate its tail in such a way as to produce 
  -- a sound like that of a rattle.
  fun Rattlesnake : Class ;
  fun Rattlesnake_Class : SubClass Rattlesnake Snake ;

  -- Food that is not the result of Cooking.
  fun RawFood : Class ;
  fun RawFood_Class : SubClass RawFood Food ;

  -- Any VehicleWindow which is located at the back 
  -- of an Automobile.
  fun RearWindow : Class ;
  fun RearWindow_Class : SubClass RearWindow VehicleWindow ;

  -- An ElectricDevice that is capable of 
  -- receiving and decoding RadioEmissions, e.g. Radios and Televisions.
  fun ReceiverDevice : Class ;
  fun ReceiverDevice_Class : SubClass ReceiverDevice (both CommunicationDevice ElectricDevice) ;

  -- Any instance of Speaking where what is 
  -- uttered is contained within a Text.
  fun Reciting : Class ;
  fun Reciting_Class : SubClass Reciting Speaking ;

  -- Any Process where the experiencer recovers 
  -- from a DiseaseOrSyndrome.
  fun RecoveringFromIllness : Class ;
  fun RecoveringFromIllness_Class : SubClass RecoveringFromIllness OrganismProcess ;

  -- A Device whose purpose is RecreationOrExercise.
  fun RecreationOrExerciseDevice : Class ;
  fun RecreationOrExerciseDevice_Class : SubClass RecreationOrExerciseDevice Device ;

  -- Any Quadrilateral whose angles are all 
  -- RightAngles.
  fun Rectangle : Class ;
  fun Rectangle_Class : SubClass Rectangle Quadrilateral ;

  -- BloodCells that contain hemoglobin, lack a 
  -- CellNucleus, and carry Oxygen to the tissues of the body.
  fun RedBloodCell : Class ;
  fun RedBloodCell_Class : SubClass RedBloodCell BloodCell ;

  -- Any Soldier that served on the British side during 
  -- the American revolutionary war. RedcoatSoldier Any Soldier that served on the
  -- British side during the American revolutionary war.
  fun RedcoatSoldier : Class ;
  fun RedcoatSoldier_Class : SubClass RedcoatSoldier Soldier ;

  -- A Book which is not intended to be read 
  -- from cover to cover, but which is meant to be consulted to answer specific 
  -- factual questions, e.g. about the meaning of a word, the location of a 
  -- country, etc.
  fun ReferenceBook : Class ;
  fun ReferenceBook_Class : SubClass ReferenceBook (both Book FactualText) ;

  -- A Text which is not intended to be read 
  -- from beginning to end, but which is meant to be consulted to answer specific 
  -- factual questions, e.g. about the meaning of a word, the location of a 
  -- country, etc.
  fun ReferenceText : Class ;
  fun ReferenceText_Class : SubClass ReferenceText FactualText ;

  -- A Substance that is the result
  -- of the Distilling of Petroleum.
  fun RefinedPetroleumProduct : Class ;
  fun RefinedPetroleumProduct_Class : SubClass RefinedPetroleumProduct PetroleumProduct ;

  -- Any instance of Radiating where the radiated 
  -- waves rebound from a surface, e.g. an echo of sound or a reflection of 
  -- light.
  fun Reflecting : Class ;
  fun Reflecting_Class : SubClass Reflecting Radiating ;

  -- Those instances of RadiatingLight where the 
  -- instrument is not a light source, but is simply a surface which bends light 
  -- waves that come in contact with it.
  fun ReflectingLight : Class ;
  fun ReflectingLight_Class : SubClass ReflectingLight (both RadiatingLight Reflecting) ;

  -- Any Muscle reaction which is a response 
  -- to a specific stimulus and which does not reach the level of consciousness.
  fun ReflexiveProcess : Class ;
  fun ReflexiveProcess_Class : SubClass ReflexiveProcess AutonomicProcess ;

  -- The intersection of Containers and ElectricDevices 
  -- in which the temperature is reduced from that of the outside air by a Cooling 
  -- process.
  fun Refrigerator : Class ;
  fun Refrigerator_Class : SubClass Refrigerator (both Container (both CoolingDevice ElectricDevice)) ;

  -- Submitting official paperwork in a government 
  -- agency, e.g. filing for divorce, making a legal claim against someone.
  fun Registering : Class ;
  fun Registering_Class : SubClass Registering (both PoliticalProcess Stating) ;

  -- ExpressingDisapproval about a state of affairs 
  -- that has already occurred.
  fun Regretting : Class ;
  fun Regretting_Class : SubClass Regretting ExpressingDisapproval ;

  -- Any TherapeuticProcess that removes Pain from 
  -- the patient of the process.
  fun RelievingPain : Class ;
  fun RelievingPain_Class : SubClass RelievingPain TherapeuticProcess ;

  -- A Building which is intended to be 
  -- used for religious worship. This class covers churches, temples, 
  -- religious shrines, etc.
  fun ReligiousBuilding : Class ;
  fun ReligiousBuilding_Class : SubClass ReligiousBuilding Building ;

  -- A well_known leader of a religious group.
  fun ReligiousFigure : Class ;
  fun ReligiousFigure_Class : SubClass ReligiousFigure Celebrity ;

  -- Any Position within a ReligousOrganization.
  fun ReligiousPosition : Class ;
  fun ReligiousPosition_Class : SubClass ReligiousPosition Position ;

  -- A formal process of public worship which is 
  -- typically carried out in a church, temple or other sanctified building and 
  -- which typically accords with a prescribed set of rules.
  fun ReligiousService : Class ;
  fun ReligiousService_Class : SubClass ReligiousService (both Demonstrating ReligiousProcess) ;

  -- Any Requesting that is intended to cause a 
  -- Remembering of something.
  fun Reminding : Class ;
  fun Reminding_Class : SubClass Reminding Requesting ;

  -- Removing Clothing from a Human or 
  -- Animal in such a way that the Human or Animal no longer wears the 
  -- Clothing.
  fun RemovingClothing : Class ;
  fun RemovingClothing_Class : SubClass RemovingClothing Uncovering ;

  -- Giving money to the owner of an Object in 
  -- exchange for the right to use the Object for a fixed time period.
  fun Renting : Class ;
  fun Renting_Class : SubClass Renting (both Borrowing FinancialTransaction) ;

  -- A relatively brief FactualText, often it 
  -- describes the findings of a study or experiment, or a series of 
  -- observations.
  fun Report : Class ;
  fun Report_Class : SubClass Report (both Article FactualText) ;

  -- One of the two major political parties in 
  -- the UnitedStates. The RepublicanParty represents traditional, 
  -- conservative values.
  fun RepublicanParty : Ind PoliticalParty ;

  -- A Sentence that expresses a request for something or 
  -- that something be done.
  fun Request : Class ;
  fun Request_Sentence : SubClassC Request Sentence (\SENTENCE -> exists Requesting (\REQUEST -> result (var Requesting Process ? REQUEST)(var Sentence Entity ? SENTENCE)));

  -- The Profession of being a scientific 
  -- researcher.
  fun Researcher : Class ;
  fun Researcher_Class : SubClass Researcher Profession ;

  -- (ResidentFn ?AREA) denotes the 
  -- GroupOfPeople who have their home in ?AREA.
  fun ResidentFn : El GeopoliticalArea -> Ind GroupOfPeople ;

  -- Voluntarily ending one's employment.
  fun Resigning : Class ;
  fun Resigning_Class : SubClass Resigning TerminatingEmployment ;

  -- Any instance of Deciding which is conducted at a 
  -- FormalMeeting and where the agent is an Organization.
  fun Resolution : Class ;
  fun Resolution_Class : SubClass Resolution Deciding ;

  -- Any CommercialAgent whose services include selling 
  -- Food to customers which is intended to be eaten on the premises.
  fun Restaurant : Class ;
  fun Restaurant_Class : SubClass Restaurant CommercialAgent ;

  -- A Building where people pay to be served food
  -- and eat. Some restaurants may also offer entertainment.
  fun RestaurantBuilding : Class ;
  fun RestaurantBuilding_Class : SubClass RestaurantBuilding Building ;

  -- A Store where individuals who are not
  -- representing an Organization purchase items. This distinguishes
  -- retail stores from wholesale establishments, where the purchasers
  -- are businesses or their representatives, as well as mail order or
  -- office buildings where transactions are facillitated but the consumer
  -- does not take possession of the item on the premises. More succinctly,
  -- the complement of WholesaleStore, i.e. 
  -- MercantileOrganizations that sell their goods to the general public.
  fun RetailStore : Class ;
  fun RetailStore_Class : SubClass RetailStore MercantileOrganization ;

  -- A membrane that covers the Eye and converts 
  -- the image formed by the lens of the Eye into neurochemical impulses 
  -- which can be processed by the Brain.
  fun Retina : Class ;
  fun Retina_Class : SubClass Retina (both AnimalAnatomicalStructure Organ) ;

  -- Voluntary unemployment toward the end of one's life.
  fun Retired : Ind SocialRole ;

  -- Voluntarily leaving employment at the end of one's 
  -- career in order to take time off in the later years of one's life.
  fun Retiring : Class ;
  fun Retiring_Class : SubClass Retiring Resigning ;

  -- Any instance of Translocation where the agent 
  -- goes to a location where he/she had been before the Translocation took place.
  fun Returning : Class ;
  fun Returning_Class : SubClass Returning Translocation ;

  -- Moving something in such a way that its top 
  -- becomes its bottom and vice versa.
  fun Reversing : Class ;
  fun Reversing_Class : SubClass Reversing Motion ;

  -- A Pistol whose magazine is a revolving cylinder with 
  -- six chambers for Bullets.
  fun RevolverGun : Class ;
  fun RevolverGun_Class : SubClass RevolverGun Pistol ;

  -- A CerealGrain which has short and long grain varieties 
  -- and which is usually prepared for eating by steaming.
  fun RiceGrain : Class ;
  fun RiceGrain_Class : SubClass RiceGrain CerealGrain ;

  -- A Firearm with a long barrel that is intended to be fired 
  -- from the shoulder.
  fun Rifle : Class ;
  fun Rifle_Class : SubClass Rifle Firearm ;

  -- Any TwoDimensionalAngle that has the 
  -- angularMeasure of 90 AngularDegrees.
  fun RightAngle : Class ;
  fun RightAngle_Class : SubClass RightAngle TwoDimensionalAngle ;

  -- Any Triangle that contains a RightAngle.
  fun RightTriangle : Class ;
  fun RightTriangle_Class : SubClass RightTriangle Triangle ;

  -- Any instance of RadiatingSound which is produced by 
  -- a Bell.
  fun Ringing : Class ;
  fun Ringing_Class : SubClass Ringing RadiatingSound ;

  -- A path along which vehicles travel. It is typically,
  -- although not necessarily, paved and intended for cars.
  fun Road : Class ;
  fun Road_Class : SubClass Road (both Region Roadway) ;

  -- RoadTransportationSystem 
  -- is the subclass of TransportationSystems whose routes are Roadways.
  fun RoadTransportationSystem : Class ;
  fun RoadTransportationSystem_Class : SubClass RoadTransportationSystem TransitSystem ;

  -- The class of LandVehicles that are not 
  -- RollingStock.
  fun RoadVehicle : Class ;
  fun RoadVehicle_Class : SubClass RoadVehicle LandVehicle ;

  -- Any instance of Stealing which involves the threat 
  -- of the use of force.
  fun Robbing : Class ;
  fun Robbing_Class : SubClass Robbing Stealing ;

  -- Rock is any naturally formed aggregate of one or more 
  -- minerals, consolidated or not, with some degree of mineralogic and chemical 
  -- constancy, in popular use the term is usually restricted to those aggregates 
  -- that are hard, compact, and coherent.
  fun Rock : Class ;
  fun Rock_Class : SubClass Rock Substance ;

  -- A Spacecraft which has the shape of a cylinder 
  -- with a cone on top and which is powered by a jet engine.
  fun Rocket : Class ;
  fun Rocket_Class : SubClass Rocket (both (both Projectile Spacecraft) Aircraft) ;

  -- An attack in which a rocket or
  -- missile is used.
  fun RocketMissileAttack : Class ;
  fun RocketMissileAttack_Class : SubClass RocketMissileAttack Bombing ;

  -- A single rail car. Any RailVehicle that is 
  -- not composed of other RailVehicles.
  fun RollingStock : Class ;
  fun RollingStock_Class : SubClass RollingStock RailVehicle ;

  -- The top of a Building.
  fun Roof : Class ;
  fun Roof_Class : SubClass Roof StationaryArtifact ;

  -- A Male Chicken.
  fun Rooster : Class ;
  fun Rooster_Chicken : SubClassC Rooster Chicken (\R -> attribute(var Chicken Object ? R)(el SexAttribute Attribute ? Male));

  -- Motion that begins and ends at the same point, 
  -- because the trajectory of the Motion is circular.
  fun Rotating : Class ;
  fun Rotating_Class : SubClass Rotating Motion ;

  -- Any ThreeDimensionalFigure that has a single
  -- tangent at every point on its surface.
  fun RoundShape : Ind ThreeDimensionalFigure ;

  -- Any instance of WaterTransportation where the 
  -- instrument is an Oar that is manually powered.
  fun Rowing : Class ;
  fun Rowing_Class : SubClass Rowing WaterTransportation ;

  -- A latex that is produced by certain species of 
  -- BotanticalTrees.
  fun Rubber : Class ;
  fun Rubber_Class : SubClass Rubber PlantSubstance ;

  -- A piece of Fabric whose purpose is to cover a Floor.
  fun Rug : Class ;
  fun Rug_Class : SubClass Rug Fabric ;

  -- A Slavic language that is spoken in Russia.
  fun RussianLanguage : Ind (both SpokenHumanLanguage NaturalLanguage) ;

  -- A Device which allows a Human to ride on a 
  -- Horse.
  fun Saddle : Class ;
  fun Saddle_Class : SubClass Saddle Holder ;

  -- A Container with a Lock which is intended 
  -- to secure items from theft. Note that this covers safes, lockers, and locked 
  -- storage compartments.
  fun SafeContainer : Class ;
  fun SafeContainer_Class : SubClass SafeContainer (both Container SecurityDevice) ;

  -- The class of Positions which involve working on a 
  -- ship, whether a merchant ship or a navy ship.
  fun Sailor : Class ;
  fun Sailor_Class : SubClass Sailor SkilledOccupation ;

  -- Any instance of Working that involves Selling or 
  -- trying to sell items.
  fun Sales : Class ;
  fun Sales_Class : SubClass Sales Working ;

  -- Any Position which involves Selling 
  -- or trying to sell items.
  fun SalesPosition : Class ;
  fun SalesPosition_Class : SubClass SalesPosition SkilledOccupation ;

  -- A Solution consisting of SodiumChloride and 
  -- Water.
  fun SalineSolution : Class ;
  fun SalineSolution_Class : SubClass SalineSolution Solution ;

  -- Any kind of open shoe lacking a markedly
  -- thicker heel. The toe may be enclosed, but there must be some opening in the upper
  -- other than the Hole through which the foot is inserted.
  fun Sandal : Class ;
  fun Sandal_Class : SubClass Sandal Shoe ;

  -- Any Food which consists of two or more pieces 
  -- of bread and some sort of filling between the two pieces of bread.
  fun Sandwich : Class ;
  fun Sandwich_Class : SubClass Sandwich PreparedFood ;

  -- The state of being happy about a state of
  -- affairs that occurred in the past. In cases where that state of affairs 
  -- is the product of one's own doing, this is known as pride.
  fun Satisfaction : Ind EmotionalState ;

  -- Any instance of Increasing where the PhysicalQuantity 
  -- involved is a CurrencyMeasure. This includes saving in a financial account
  -- as well as stuffing gold bars under the matress, or a squirrel saving nuts
  -- for winter.
  fun Saving : Class ;
  fun Saving_Class : SubClass Saving Increasing ;

  -- A federally or state chartered 
  -- FinancialCompany that takes Deposits from individuals, funds 
  -- Mortgages, and pays Dividends.
  fun SavingsAndLoan : Class ;
  fun SavingsAndLoan_Class : SubClass SavingsAndLoan FinancialCompany ;

  -- Any AbnormalAnatomicalStructure which results from the 
  -- healing of a Lesion.
  fun Scar : Class ;
  fun Scar_Class : SubClass Scar AbnormalAnatomicalStructure ;

  -- Any Funding which is made on the basis of merit 
  -- and whose purpose is to allow the destination to realize an 
  -- EducationalProgram.
  fun Scholarship : Class ;
  fun Scholarship_Class : SubClass Scholarship Funding ;

  -- An EducationalOrganization with a curriculum, 
  -- teachers, and students. Most Schools are housed in a Building 
  -- dedicated to the EducationalOrganization.
  fun School : Class ;
  fun School_Class : SubClass School EducationalOrganization ;

  -- Any FieldOfStudy which tests theories on the basis of 
  -- careful observations and/or experiments and which has a cumulative body of results.
  fun Science : Class ;
  fun Science_Class : SubClass Science FieldOfStudy ;

  -- A successful attempt to score a point in a Game.
  fun Score : Class ;
  fun Score_Class : SubClass Score GameShot ;

  -- An AttachingDevice which contains a spiral of grooves to 
  -- hold it in place and which is fastened with a Screwdriver.
  fun Screw : Class ;
  fun Screw_Class : SubClass Screw AttachingDevice ;

  -- A Device that is used to rotate
  -- a Screw, which by the action of its helical threads is driven into a 
  -- medium that is softer than the material of the screw itself.
  fun Screwdriver : Class ;
  fun Screwdriver_Class : SubClass Screwdriver Device ;

  -- The collection of Characters in a particular 
  -- written language. Every WrittenCommunication consists of Characters 
  -- written in a particular script. Scripts include different typefaces, as 
  -- well as entirely different characters. 'Times Roman' is a very specific 
  -- script. While the 'latin' character set is a general one, that has 
  -- specific subclasses like Times Roman. Other scripts include Devanagri 
  -- (which may be expressed in many different more specific typefaces), or 
  -- Simplified Chinese.
  fun Script : Class ;
  fun Script_Class : SubClass Script Collection ;

  -- Any ArtWork which is not constructed on the 
  -- two_dimensional surface of a canvas, piece of paper, etc.
  fun Sculpture : Class ;
  fun Sculpture_Class : SubClass Sculpture ArtWork ;

  -- SeasonOfYear is the class of four 
  -- seasons correlated with the calendar Year and associated with 
  -- changes in the length of daylight and with overall temperature 
  -- changes. Depending upon the GeographicArea, a SeasonOfYear 
  -- may also be associated with weather patterns (e.g., rainy, dry, 
  -- windy). The characteristics of seasons (cold vs. hot temperatures, 
  -- long vs. short days) are reversed from the NorthernHemisphere 
  -- to the SouthernHemisphere.
  fun SeasonOfYear : Class ;
  fun SeasonOfYear_Class : SubClass SeasonOfYear TimeInterval ;

  -- Any instance of Furniture which is designed to 
  -- accommodate Humans who are Sitting.
  fun Seat : Class ;
  fun Seat_Class : SubClass Seat Furniture ;

  -- Guiding someone to a Seat, e.g. as when an usher 
  -- shows someone to a Seat in an Auditorium.
  fun Seating : Class ;
  fun Seating_Class : SubClass Seating Guiding ;

  -- A color that is the product of mixing together 
  -- two or more PrimaryColors.
  fun SecondaryColor : Class ;
  fun SecondaryColor_Class : SubClass SecondaryColor ColorAttribute ;

  -- A School which admits students who have 
  -- graduated from a middle school and which normally covers the ninth through 
  -- twelfth grades. A SecondarySchool confers a high school diploma.
  fun SecondarySchool : Class ;
  fun SecondarySchool_Class : SubClass SecondarySchool School ;

  -- The head of the UnitedStatesDepartmentOfInterior.
  fun SecretaryOfTheInterior : Ind GovernmentSecretary ;

  -- The head of the United States Treasury Department.
  fun SecretaryOfTheTreasury : Ind GovernmentSecretary ;

  -- A SecurityDevice that detects intrusions to 
  -- a StationaryArtifact and issues a warning of some sort.
  fun SecurityAlarm : Class ;
  fun SecurityAlarm_Class : SubClass SecurityAlarm (both ElectricDevice SecurityDevice) ;

  -- A Device whose purpose is to protect people or 
  -- property from kidnappers and/or thieves.
  fun SecurityDevice : Class ;
  fun SecurityDevice_Class : SubClass SecurityDevice Device ;

  -- The Organization that is charged with 
  -- ensuring the security of members of the overall Organization and the 
  -- property of the Organization.
  fun SecurityUnit : Class ;
  fun SecurityUnit_Class : SubClass SecurityUnit Organization ;

  -- Any instance of UnilateralGetting which is done by 
  -- a Government and which is not permitted by the origin of the UnilateralGetting.
  fun SeizingProperty : Class ;
  fun SeizingProperty_Class : SubClass SeizingProperty UnilateralGetting ;

  -- SelfPoweredDevice is 
  -- the subclass of Devices whose action is powered by some kind of on_board 
  -- component or power source (not the user, which would be a 
  -- UserPoweredVehicle).
  fun SelfPoweredDevice : Class ;
  fun SelfPoweredDevice_Device : SubClassC SelfPoweredDevice Device (\O -> exists Artifact (\G -> powerPlant(var Device Device ? O) (var Artifact Artifact ? G)));

  -- SelfPoweredRoadVehicle is the 
  -- class of RoadVehicles that are also PoweredVehicles. 
  -- SelfPoweredRoadVehicle covers motorcycles, semi_trailers, RVs, etc., 
  -- as well as Automobiles. This class includes vehicles powered by 
  -- electricity, gasoline, diesel, and other fuels.
  fun SelfPoweredRoadVehicle : Class ;
  fun SelfPoweredRoadVehicle_Class : SubClass SelfPoweredRoadVehicle (both PoweredVehicle RoadVehicle) ;

  -- Any LegalDecision where the defendant is assigned 
  -- a punishment for a CriminalAction which was the subject of an earlier 
  -- LegalConviction.
  fun Sentencing : Class ;
  fun Sentencing_Class : SubClass Sentencing LegalDecision ;

  -- A noncomissioned MilitaryOfficer.
  fun Sergeant : Class ;
  fun Sergeant_Class : SubClass Sergeant MilitaryOfficer ;

  -- A Lecture that is part of a ReligiousService.
  fun Sermon : Class ;
  fun Sermon_Class : SubClass Sermon Lecture ;

  -- Any LiquidBodySubstance other than Blood.
  fun Serum : Class ;
  fun Serum_Class : SubClass Serum LiquidBodySubstance ;

  -- An Organization that performs 
  -- a public service and is regulated by the Government.
  fun ServiceOrganization : Class ;
  fun ServiceOrganization_Class : SubClass ServiceOrganization Organization ;

  -- Any Position which involves working 
  -- as a waiter or servant, either for an Organization (e.g. a restaurant) 
  -- or for a person or family.
  fun ServicePosition : Class ;
  fun ServicePosition_Class : SubClass ServicePosition SkilledOccupation ;

  -- Working as a waiter or servant, either for an 
  -- Organization (e.g. a Restaurant) or for a person or family.
  fun Serving : Class ;
  fun Serving_Class : SubClass Serving Working ;

  -- A Pipline which is used to transport human 
  -- waste to an area where it can be treated and/or disposed of.
  fun SewageSystem : Class ;
  fun SewageSystem_Class : SubClass SewageSystem Pipeline ;

  -- Attaching two pieces of Fabric or one part of a 
  -- piece of Fabric to another part by means of needle and thread.
  fun Sewing : Class ;
  fun Sewing_Class : SubClass Sewing Attaching ;

  -- The subclass of ChangeOfPossession where a 
  -- properPart of the patient is given by the agent or the destination.
  fun Sharing : Class ;
  fun Sharing_Class : SubClass Sharing ChangeOfPossession ;

  -- A domesticated HoofedMammal that is bred for its 
  -- wool and for its meat (known as mutton).
  fun Sheep : Class ;
  fun Sheep_Class : SubClass Sheep (both DomesticAnimal HoofedMammal) ;

  -- An piece of Furniture or part of a piece of Furniture 
  -- that is used for keeping or displaying things.
  fun Shelf : Class ;
  fun Shelf_Class : SubClass Shelf Artifact ;

  -- A PoliceOfficer whose jurisdiction is a County.
  fun Sheriff : Class ;
  fun Sheriff_Class : SubClass Sheriff PoliceOfficer ;

  -- An Artifact that is held by the hand or whole arm and 
  -- is used to prevent injuries from Weapons.
  fun Shield : Class ;
  fun Shield_Class : SubClass Shield Artifact ;

  -- Ship is the class of large WaterVehicle used 
  -- for travel on oceans, seas, or large lakes.
  fun Ship : Class ;
  fun Ship_Class : SubClass Ship DisplacementHullWaterVehicle ;

  -- The class of Positions which involve the command of a ship.
  fun ShipCaptain : Class ;
  fun ShipCaptain_Class : SubClass ShipCaptain Sailor ;

  -- The class of Positions that involve some responsibility 
  -- on a ship and are lower in rank than ShipCaptain.
  fun ShipMate : Class ;
  fun ShipMate_Class : SubClass ShipMate Sailor ;

  -- The class of Sailors which have a position of 
  -- responsibility on a Ship.
  fun ShipOfficer : Class ;
  fun ShipOfficer_Class : SubClass ShipOfficer Sailor ;

  -- Shipping is the subclass of Transportation 
  -- events in which goods are transported from one place to another by an 
  -- agent who is entrusted with the goods temporarily just in order to move 
  -- them. Shipping may be done within an organization or it may be done 
  -- by an outside commercial agent. See CommercialShipping.
  fun Shipping : Class ;
  fun Shipping_Class : SubClass Shipping Transportation ;

  -- An item of Clothing which covers the upper body of a Human.
  fun Shirt : Class ;
  fun Shirt_Class : SubClass Shirt Clothing ;

  -- Clothing that is intended to be worn on the Foot. 
  -- It consists of an upper, a sole, and a heel.
  fun Shoe : Class ;
  fun Shoe_Class : SubClass Shoe Clothing ;

  -- The bottom part of a Shoe that is
  -- intended to be the point of contact with the ground while the
  -- shoe is being worn.
  fun ShoeSole : Class ;
  fun ShoeSole_Class : SubClass ShoeSole Artifact ;

  -- A MercantileOrganization which is a collection 
  -- of various shops gathered together in a single, modern development.
  fun ShoppingMall : Class ;
  fun ShoppingMall_Class : SubClass ShoppingMall MercantileOrganization ;

  -- A brief work of fiction, often bound with other 
  -- short stories in a Book or Periodical.
  fun ShortStory : Class ;
  fun ShortStory_Class : SubClass ShortStory (both Article FictionalText) ;

  -- Decreasing the length of something.
  fun Shortening : Class ;
  fun Shortening_Class : SubClass Shortening Decreasing ;

  -- A solid metal Ball that is used in the sport of shotput.
  fun ShotBall : Class ;
  fun ShotBall_Class : SubClass ShotBall Ball ;

  -- The part of a Primate between the Arm and the neck.
  fun Shoulder : Class ;
  fun Shoulder_Class : SubClass Shoulder (both AnimalAnatomicalStructure BodyPart) ;

  -- Moving the Shoulders in such a way that the motion 
  -- is intended to express something to someone else.
  fun Shrugging : Class ;
  fun Shrugging_Class : SubClass Shrugging (both BodyMotion Gesture) ;

  -- A prepared path for pedestrians alongside a Roadway.
  fun Sidewalk : Class ;
  fun Sidewalk_Class : SubClass Sidewalk StationaryArtifact ;

  -- Signalling is the subclass of Guiding 
  -- processes in which an agent, animate or inanimate, sends a signal to 
  -- another Object. In many cases, this signal will be an electrical or 
  -- electronic one. Some signals may directly control the behavior of 
  -- the object signalled, while others may merely cause information to be 
  -- presented. Instances of electrical Signalling are typically more 
  -- complex than simply than operation of a DeviceSwitch, though in some 
  -- cases, Signalling involves remote activation of such a switch by another 
  -- device.
  fun Signalling : Class ;
  fun Signalling_Class : SubClass Signalling Guiding ;

  -- Fabric that is woven from the strands produced by 
  -- certain Larval Insects.
  fun Silk : Class ;
  fun Silk_Class : SubClass Silk Fabric ;

  -- The class of Falling processes that occur in a BodyOfWater.
  fun Sinking : Class ;
  fun Sinking_Class : SubClass Sinking Falling ;

  -- The BodyMotion of moving from a Standing 
  -- to a Sitting position.
  fun SittingDown : Class ;
  fun SittingDown_Class : SubClass SittingDown (both BodyMotion MotionDownward) ;

  -- Any ArtWork which is produced by a pencil or 
  -- piece of charcoal.
  fun Sketch : Class ;
  fun Sketch_Class : SubClass Sketch ArtWork ;

  -- Any Position which requires 
  -- learning a set of skills.
  fun SkilledOccupation : Class ;
  fun SkilledOccupation_Class : SubClass SkilledOccupation Position ;

  -- A BodyCovering that comprises part of the surface of Animals.
  fun Skin : Class ;
  fun Skin_Class : SubClass Skin (both AnimalAnatomicalStructure BodyCovering) ;

  -- The Bone that is found in the Heads of Vertebrates.
  fun Skull : Class ;
  fun Skull_Class : SubClass Skull Bone ;

  -- A Window that is part of the Ceiling of 
  -- a Room.
  fun Skylight : Class ;
  fun Skylight_Class : SubClass Skylight Window ;

  -- A piece of Clothing that covers the Arm. A 
  -- Sleeve is always part of a Coat or a Shirt.
  fun Sleeve : Class ;
  fun Sleeve_Class : SubClass Sleeve Clothing ;

  -- Spreading the lips in such a way as to convey 
  -- happiness.
  fun Smiling : Class ;
  fun Smiling_Class : SubClass Smiling FacialExpression ;

  -- Inhaling and exhaling Smoke produced by a CigarOrCigarette.
  fun Smoking : Class ;
  fun Smoking_Class : SubClass Smoking RecreationOrExercise ;

  -- Any Device whose purpose is Smoking.
  fun SmokingDevice : Class ;
  fun SmokingDevice_Class : SubClass SmokingDevice Device ;

  -- A SmokingDevice consisting of a tube and a small bowl.
  fun SmokingPipe : Class ;
  fun SmokingPipe_Class : SubClass SmokingPipe SmokingDevice ;

  -- Any instance Transportation which is also a CriminalAction.
  fun Smuggling : Class ;
  fun Smuggling_Class : SubClass Smuggling (both CriminalAction Transportation) ;

  -- A long and narrow Reptile which lacks Limbs.
  fun Snake : Class ;
  fun Snake_Class : SubClass Snake Reptile ;

  -- The ConsciousnessAttribute of someone whose motor and
  -- cognitive faculties are not significantly impaired by a BiologicallyActiveSubstance.
  fun Sober : Ind ConsciousnessAttribute ;

  -- The process of transitioning from a state of 
  -- being Drunk to a state of being Sober.
  fun SoberingUp : Class ;
  fun SoberingUp_Class : SubClass SoberingUp PsychologicalProcess ;

  -- Any Meeting where the intent is primarily 
  -- to socialize and be entertained.
  fun SocialParty : Class ;
  fun SocialParty_Class : SubClass SocialParty (both Meeting RecreationOrExercise) ;

  -- Any Science which studies human behavior, either in 
  -- the aggregate, as do, for example, Economics and Linguistics, or with respect to 
  -- the individual, as does Psychology.
  fun SocialScience : Class ;
  fun SocialScience_Class : SubClass SocialScience Science ;

  -- A piece of Clothing that is made of a soft Fabric 
  -- like Cotton and that is intended to be worn on the Foot.
  fun Sock : Class ;
  fun Sock_Class : SubClass Sock Clothing ;

  -- SodiumChloride is the compound of Sodium and Chloride,
  -- which may appear in crystalline form or in solution with water or other substances.
  -- It is a compound found in solution in significant quantities in sea water.
  fun SodiumChloride : Class ;
  fun SodiumChloride_Class : SubClass SodiumChloride ChemicalSalt ;

  -- A padded Seat that is designed to accommodate more than one Human.
  fun Sofa : Class ;
  fun Sofa_Class : SubClass Sofa Seat ;

  -- Attaching two things by means of a MetallicAlloy.
  fun Soldering : Class ;
  fun Soldering_Class : SubClass Soldering Attaching ;

  -- The class of SkilledOccupations which involve serving in 
  -- the armed forces of a Nation.
  fun Soldier : Class ;
  fun Soldier_Class : SubClass Soldier SkilledOccupation ;

  -- Any BodyMotion which begins and ends in 
  -- a Sitting position and where the feet roll over the head and return to 
  -- their original position.
  fun Somersaulting : Class ;
  fun Somersaulting_Class : SubClass Somersaulting BodyMotion ;

  -- Something that emits and receives sound 
  -- for the purpose of locating and tracking distant objects. Note that
  -- this covers both manmade devices and BodyParts such as the sonar
  -- of bats and dolphins.
  fun Sonar : Class ;
  fun Sonar_Class : SubClass Sonar CorpuscularObject ;

  -- Any MusicalComposition which contains Lyrics.
  fun Song : Class ;
  fun Song_Class : SubClass Song MusicalComposition ;

  -- Food which is prepared by reducing Meat 
  -- and/or FruitOrVegetables to a translucent broth which can be used as 
  -- a base for soups or sauces.
  fun SoupStock : Class ;
  fun SoupStock_Class : SubClass SoupStock PreparedFood ;

  -- The class of all Regions which are not GeographicAreas.
  fun SpaceRegion : Class ;
  fun SpaceRegion_Class : SubClass SpaceRegion Region ;

  -- Any instance of Transportation where the 
  -- instrument is a Spacecraft and which is through a SpaceRegion.
  fun SpaceTransportation : Class ;
  fun SpaceTransportation_Class : SubClass SpaceTransportation Transportation ;

  -- Any Vehicle which is capable of SpaceTransportation.
  fun Spacecraft : Class ;
  fun Spacecraft_Class : SubClass Spacecraft Vehicle ;

  -- A Romance language that is the official language 
  -- of Spain, Mexico, and many Central and South American countries.
  fun SpanishLanguage : Ind (both SpokenHumanLanguage NaturalLanguage) ;

  -- A Weapon with a long handle and a short blade.
  fun Spear : Class ;
  fun Spear_Class : SubClass Spear Weapon ;

  -- The class of ThreeDimensionalFigures such that 
  -- all GeometricPoints that make up the Sphere are equidistant from a 
  -- single GeometricPoint, known as the center of the Sphere.
  fun Sphere : Class ;
  fun Sphere_Class : SubClass Sphere ThreeDimensionalFigure ;

  -- A cord of nerves that carries impulses to 
  -- and from the Brain. It is contained within the SpinalColumn.
  fun SpinalCord : Class ;
  fun SpinalCord_Class : SubClass SpinalCord Organ ;

  -- Any instance of Impelling where the origin is 
  -- the Mouth of the agent.
  fun Spitting : Class ;
  fun Spitting_Class : SubClass Spitting Impelling ;

  -- An Organ on the left side of the body that produces 
  -- Cells that play a crucial role in immune response.
  fun Spleen : Class ;
  fun Spleen_Class : SubClass Spleen (both AnimalAnatomicalStructure Organ) ;

  -- The BodyPosition of extending one's Legs at 
  -- right angles to one's Torso.
  fun Splitting : Ind BodyPosition ;

  -- A GameShot which is part of a Sport and 
  -- which serves to start the Sport, e.g. the beginning shot in Tennis, 
  -- Badminton or Squash.
  fun SportServe : Class ;
  fun SportServe_Class : SubClass SportServe GameShot ;

  -- Any GameAttribute that is specific to 
  -- a Sport.
  fun SportsAttribute : Class ;
  fun SportsAttribute_Class : SubClass SportsAttribute GameAttribute ;

  -- A specially designated and maintained facility 
  -- where Sports are played. Note that this covers sports fields, stadiums, 
  -- and gymnasiums.
  fun SportsFacility : Class ;
  fun SportsFacility_Class : SubClass SportsFacility StationaryArtifact ;

  -- A specially designated and maintained area 
  -- where Sports are played.
  fun SportsGround : Class ;
  fun SportsGround_Class : SubClass SportsGround StationaryArtifact ;

  -- An Organization whose members are SportsTeams 
  -- and whose purpose is to set up games between its members.
  fun SportsLeague : Class ;
  fun SportsLeague_Class : SubClass SportsLeague Organization ;

  -- A SportsAttribute that indicates that a player in 
  -- a Sport can no longer compete because he has been tagged with the GamePiece.
  fun SportsOut : Ind SportsAttribute ;

  -- A Plan for a Maneuver within a TeamSport.
  fun SportsPlay : Class ;
  fun SportsPlay_Class : SubClass SportsPlay Plan ;

  -- A Position which is filled by someone on a 
  -- SportsTeam and which represents the role played by the person on the team.
  fun SportsPosition : Class ;
  fun SportsPosition_Class : SubClass SportsPosition SkilledOccupation ;

  -- A GroupOfPeople who habitually play a Sport 
  -- together, either as an occupation or as a leisure activity.
  fun SportsTeam : Class ;
  fun SportsTeam_Class : SubClass SportsTeam GroupOfPeople ;

  -- Any instance of Transfer of a Liquid which is 
  -- accomplished by converting the Liquid into a mist.
  fun Spraying : Class ;
  fun Spraying_Class : SubClass Spraying (both LiquidMotion Transfer) ;

  -- The SeasonOfYear that begins at the spring 
  -- equinox and ends at the summer solstice. SpringSeason is the class of 
  -- TimeIntervals associated with the calendar months of March 
  -- through May.
  fun SpringSeason : Class ;
  fun SpringSeason_Class : SubClass SpringSeason SeasonOfYear ;

  -- Any Rectangle whose sides are all equal.
  fun Square : Class ;
  fun Square_Class : SubClass Square Rectangle ;

  -- SquareMile represents a UnitOfMeasure equal to one square Mile.
  fun SquareMile : Ind UnitOfArea ;

  -- SquareYard represents a UnitOfMeasure equal to one square YardLength.
  fun SquareYard : Ind UnitOfArea ;

  -- Sitting on one's heels.
  fun Squatting : Ind BodyPosition ;

  -- A tree_dwelling Rodent with a bushy tail.
  fun Squirrel : Class ;
  fun Squirrel_Class : SubClass Squirrel Rodent ;

  -- A Wagon that is pulled by Horses and whose purpose 
  -- was to transport Humans and their luggage from one City to the next, especially 
  -- in areas which did not have an established transportation system, e.g. the old west.
  fun StageCoach : Class ;
  fun StageCoach_Class : SubClass StageCoach Wagon ;

  -- A StationaryArtifact which allows one to climb, step 
  -- by step, from one level to another.
  fun Stairway : Class ;
  fun Stairway_Class : SubClass Stairway StationaryArtifact ;

  -- The BodyMotion of moving from a Sitting 
  -- to a Standing position.
  fun StandingUp : Class ;
  fun StandingUp_Class : SubClass StandingUp (both BodyMotion MotionUpward) ;

  -- A complex Carbohydrate that is the main form in 
  -- which Carbohydrates are stored.
  fun Starch : Class ;
  fun Starch_Class : SubClass Starch Carbohydrate ;

  -- (StartFn ?PROCESS) denotes IntentionalProcesses 
  -- of bringing it about that Processes of type ?PROCESS begin, e.g. start 
  -- working, begin running, etc.
  fun StartFn : El Process -> Desc IntentionalProcess ;

  -- Killing someone by depriving them of Food.
  fun Starving : Class ;
  fun Starving_Class : SubClass Starving Killing ;

  -- The class of Governments whose 
  -- jurisdictions are StateOrProvinces.
  fun StateGovernment : Class ;
  fun StateGovernment_Class : SubClass StateGovernment Government ;

  -- A Sentence that is stated to be true.
  fun Statement : Class ;
  fun Statement_Sentence : SubClassC Statement Sentence
                                     (\SENTENCE -> exists Stating (\STATE -> result (var Stating Process ? STATE)
                                                                                    (var Sentence Entity ? SENTENCE)));

  -- Any UnilateralGetting which is not permitted by the 
  -- origin of the UnilateralGetting. These cases of UnilateralGetting are 
  -- distinguished from ones where the destination is the subject of charity or 
  -- other forms of benefaction.
  fun Stealing : Class ;
  fun Stealing_Class : SubClass Stealing (both CriminalAction UnilateralGetting) ;

  -- SteamEngine is the subclass of Engines 
  -- that produce mechanical power from heat and steam pressure.
  fun SteamEngine : Class ;
  fun SteamEngine_Class : SubClass SteamEngine Engine ;

  -- A MetallicAlloy made from Iron and other elements.
  fun Steel : Class ;
  fun Steel_Class : SubClass Steel MetallicAlloy ;

  -- A component of a ReligiousBuilding that is tall 
  -- and narrow and symbolizes the connection between humanity and a deity.
  fun Steeple : Class ;
  fun Steeple_Class : SubClass Steeple StationaryArtifact ;

  -- A VehicleController which enables one to steer 
  -- a Vehicle.
  fun SteeringWheel : Class ;
  fun SteeringWheel_Class : SubClass SteeringWheel VehicleController ;

  -- The BodyMotion of extending one foot forward 
  -- and then bringing the other foot to the same lateral position as the 
  -- first leg.
  fun Stepping : Class ;
  fun Stepping_Class : SubClass Stepping BodyMotion ;

  -- A StationaryArtifact which allows one to climb, step 
  -- by step, from one level to another.
  fun Steps : Class ;
  fun Steps_Class : SubClass Steps StationaryArtifact ;

  -- A class of OrganicCompounds having the same basic 
  -- chemical structure and having significant physiological effects.
  fun Steroid : Class ;
  fun Steroid_Class : SubClass Steroid (both BiologicallyActiveSubstance OrganicCompound) ;

  -- Any BiologicallyActiveSubstance which has 
  -- the effect of stimulating the central nervous system, i.e. increasing 
  -- function or activity in the Brain or SpinalCord.
  fun Stimulant : Class ;
  fun Stimulant_Class : SubClass Stimulant BiologicallyActiveSubstance ;

  -- Any instance of LiquidMotion which is also an 
  -- instance of Combining two or more Liquids.
  fun Stirring : Class ;
  fun Stirring_Class : SubClass Stirring (both Combining LiquidMotion) ;

  -- An instrument that signifies an ownership position, 
  -- or equity, in a Corporation, and represents a claim on its proportionate 
  -- share in the corporation's assets and profits.
  fun Stock : Class ;
  fun Stock_Class : SubClass Stock (both FinancialInstrument Investment) ;

  -- A muscular sac that is the principal organ of 
  -- digestion.
  fun Stomach : Class ;
  fun Stomach_Class : SubClass Stomach (both AnimalAnatomicalStructure Organ) ;

  -- An act where a victim or victims is attacked
  -- with stones. The stones may either be placed on top of a victim in
  -- order to cause death by pressure and suffocation, in which case the act
  -- is typically part of a ritualized legal sentence, or where the victim
  -- is pelted with stones causing injury or death by trauma. The intent
  -- of such an act is usually the death of the victim.
  fun Stoning : Class ;
  fun Stoning_Class : SubClass Stoning ViolentContest ;

  -- (StopFn ?PROCESS) denotes IntentionalProcesses of bringing it
  -- about that Processes of type ?PROCESS end, e.g. stop walking, quit working, etc.
  fun StopFn : El Process -> Desc IntentionalProcess ;

  -- A Building that has the purpose of housing
  -- FinancialTransactions.
  fun Store : Class ;
  fun Store_Class : SubClass Store Building ;

  -- Someone who operates a store which he
  -- either owns or rents.
  fun StoreOwner : Ind OccupationalRole ;

  -- The Region where two or more unstable air 
  -- masses meet.
  fun StormFront : Class ;
  fun StormFront_Class : SubClass StormFront AtmosphericRegion ;

  -- A HeatingDevice which consists one or more burners for 
  -- heating pots and pans of Food.
  fun Stove : Class ;
  fun Stove_Class : SubClass Stove HeatingDevice ;

  -- Any instance of Grabbing where the patient is 
  -- someone else's throat and the intention is to make it impossible for the other 
  -- person to breathe.
  fun Strangling : Class ;
  fun Strangling_Class : SubClass Strangling Grabbing ;

  -- (StreetAddressFn ?BUILDING ?ROAD ?CITY 
  -- ?COUNTRY) returns the Agent, e.g. a family, an organization, a person, 
  -- etc. that resides or conducts business at the corresponding address.
  fun StreetAddressFn : El StationaryArtifact -> El Roadway -> El City -> El Nation -> Ind Agent ;

  -- Streetcar is the subclass of 
  -- ElectrifiedRailwayCars that run on tracks laid into, along, or 
  -- beside city Streets.
  fun Streetcar : Class ;
  fun Streetcar_Class : SubClass Streetcar ElectrifiedRailwayCar ;

  -- A SoundAttribute of Syllables. It denotes the quality of
  -- being emphasized over the other Syllables in the same Word.
  fun Stressed : Ind SoundAttribute ;

  -- Moving two sides of an object in opposite 
  -- directions so that the object becomes both longer and thinner.
  fun Stretching : Class ;
  fun Stretching_Class : SubClass Stretching (both Lengthening Motion) ;

  -- A long, thin strand of Fabric that is used for Tying 
  -- things together, etc. Note that this class covers a cord of any width, including 
  -- rope, twine, and thread, for example.
  fun String : Class ;
  fun String_Class : SubClass String Artifact ;

  -- A MusicalInstrument which is played by 
  -- striking strings, either directly as with a guitar or indirectly via keys 
  -- as with Pianos.
  fun StringInstrument : Class ;
  fun StringInstrument_Class : SubClass StringInstrument MusicalInstrument ;

  -- A person who participates in an
  -- EducationalProcess in order to learn something.
  fun Student : Ind SocialRole ;

  -- A WaterVehicle which is capable of travelling 
  -- under the water level by filling tanks with water.
  fun Submarine : Class ;
  fun Submarine_Class : SubClass Submarine WaterVehicle ;

  -- A subway is a hollow area of the earth, typically
  -- under large cities, designed for running trains that move people. It is
  -- distinguished from other kinds of tunnels in that trains run through
  -- them, primarily for the purpose of carrying people rather than ore, for
  -- example.
  fun Subway : Class ;
  fun Subway_Class : SubClass Subway Hole ;

  -- Any RailTransportationSystem that runs 
  -- exclusively through Tunnels.
  fun SubwaySystem : Class ;
  fun SubwaySystem_Class : SubClass SubwaySystem RailTransportationSystem ;

  -- Killing someone by asphyxiation, i.e. by 
  -- depriving them of Oxygen.
  fun Suffocating : Class ;
  fun Suffocating_Class : SubClass Suffocating Killing ;

  -- A simple Carbohydrate that has a sweet taste and 
  -- consists mostly or entirely of sucrose.
  fun Sugar : Class ;
  fun Sugar_Class : SubClass Sugar (both Carbohydrate PlantAgriculturalProduct) ;

  -- Any instance of Killing where the agent and 
  -- the experiencer are identical.
  fun Suicide : Class ;
  fun Suicide_Class : SubClass Suicide Killing ;

  -- A bomb attack in which the bomber
  -- intends to blow himself up during the course of the attack. The bomber
  -- is the delivery mechanism for the explosive and the bomb is typically
  -- in close contact with the bomber, such as being strapped around his
  -- torso. This action is distinguished from actions in which the bomber
  -- merely happens to be blown up by his own bomb in that the bomber
  -- knows that he is committing suicide.
  fun SuicideBombing : Class ;
  fun SuicideBombing_Class : SubClass SuicideBombing (both Bombing Killing) ;

  -- The SeasonOfYear that begins at the summer 
  -- solstice and ends at the autumnal equinox.
  fun SummerSeason : Class ;
  fun SummerSeason_Class : SubClass SummerSeason SeasonOfYear ;

  -- Any instance of RadiatingLight where the 
  -- Sun (Sol) is the origin.
  fun Sunlight : Class ;
  fun Sunlight_Class : SubClass Sunlight RadiatingLight ;

  -- The TimeInterval of each Day when the sun is rising 
  -- and is partially overlapped by the horizon line.
  fun Sunrise : Class ;
  fun Sunrise_Class : SubClass Sunrise TimeInterval ;

  -- The TimeInterval of each Day when the sun is setting 
  -- and is partially overlapped by the horizon line.
  fun Sunset : Class ;
  fun Sunset_Class : SubClass Sunset TimeInterval ;

  -- A Sentence that is assumed to be true, possibly 
  -- just for the sake of argument.
  fun Supposition : Class ;
  fun Supposition_Sentence : SubClassC Supposition Sentence
                                       (\SENTENCE -> exists Supposing (\SUPPOSE -> result (var Supposing Process ? SUPPOSE)
                                                                                          (var Sentence Entity ? SENTENCE)));

  -- Surfactants, also known as Wetting agents, 
  -- lower the surface tension of a Liquid, allowing easier spreading. The 
  -- term surfactant is a compression of 'Surface active agent'. Surfactants 
  -- are usually organic compounds that contain both hydrophobic and 
  -- hydrophilic groups, and are thus semi_soluble in both organic and aqueous 
  -- solvents.
  fun Surfactant : Class ;
  fun Surfactant_Class : SubClass Surfactant Substance ;

  -- The Profession of being a surgeon, i.e. being a 
  -- medical doctor who specializes in performing surgical operations.
  fun Surgeon : Class ;
  fun Surgeon_Class : SubClass Surgeon MedicalDoctor ;

  -- The EmotionalState that one experiences when something 
  -- unexpected and of significance occurs.
  fun Surprise : Ind EmotionalState ;

  -- An AnimalSubstance that contains SodiumChloride 
  -- and is produced by the sweat glands.
  fun Sweat : Class ;
  fun Sweat_Class : SubClass Sweat AnimalSubstance ;

  -- Removing small particles from the floor by means of 
  -- a Broom.
  fun Sweeping : Class ;
  fun Sweeping_Class : SubClass Sweeping Removing ;

  -- A FluidContainer that is filled with Water 
  -- and that is used for Swimming.
  fun SwimmingPool : Class ;
  fun SwimmingPool_Class : SubClass SwimmingPool (both FluidContainer StationaryArtifact) ;

  -- An EngineeringComponent which is capable of turning 
  -- an ElectricDevice on and off.
  fun SwitchDevice : Class ;
  fun SwitchDevice_Class : SubClass SwitchDevice EngineeringComponent ;

  -- A Weapon with a long blade and covered 
  -- handle.
  fun Sword : Class ;
  fun Sword_Class : SubClass Sword Weapon ;

  -- A sequence of Characters from the same Word 
  -- that denote a single sound.
  fun Syllable : Class ;
  fun Syllable_Class : SubClass Syllable SymbolicString ;

  -- A ShapeAttribute that applies to a 
  -- SelfConnectedObject that can be divided into two copies of each other.
  fun SymmetricShape : Ind ShapeAttribute ;

  -- A piece of Furniture with four legs and a flat top. 
  -- It is used either for eating, paperwork or meetings.
  fun Table : Class ;
  fun Table_Class : SubClass Table Furniture ;

  -- Devices that are used in Ingesting (Eating 
  -- and/or Drinking) a meal. This coves dishware, flatware, and glassware.
  fun Tableware : Class ;
  fun Tableware_Class : SubClass Tableware Device ;

  -- A BodyPart which extends from the rear of the 
  -- main body of some Vertebrates.
  fun Tail : Class ;
  fun Tail_Class : SubClass Tail AnimalAnatomicalStructure ;

  -- Any VehicleLight which is attached to the back 
  -- of a Vehicle.
  fun Taillight : Class ;
  fun Taillight_Class : SubClass Taillight VehicleLight ;

  -- Any Process where the experiencer contracts a 
  -- DiseaseOrSyndrome.
  fun TakingIll : Class ;
  fun TakingIll_Class : SubClass TakingIll PathologicProcess ;

  -- Any instance of Translocation which starts on something other 
  -- than an AtmosphericRegion and which has an instance of Flying as a subProcess.
  fun TakingOff : Class ;
  fun TakingOff_Class : SubClass TakingOff Translocation ;

  -- A thin strip of Fabric or Paper that is used to attach 
  -- two things.
  fun Tape : Class ;
  fun Tape_Class : SubClass Tape AttachingDevice ;

  -- A Restaurant whose primary service is selling 
  -- AlcoholicBeverages to customers.
  fun Tavern : Class ;
  fun Tavern_Class : SubClass Tavern Restaurant ;

  -- A fee charged by a government on a product, income, or activity.
  fun Tax : Class ;
  fun Tax_Class : SubClass Tax ChargingAFee ;

  -- A FormText that is used for calculating the amount 
  -- of income tax owed in a given year.
  fun TaxReturn : Class ;
  fun TaxReturn_Class : SubClass TaxReturn FormText ;

  -- An Automobile which is used to transport people 
  -- on short trips in exchange for a fare.
  fun Taxicab : Class ;
  fun Taxicab_Class : SubClass Taxicab Automobile ;

  -- A Taxonomy is a ClassificationScheme
  -- that typically includes the salient concepts of a domain of
  -- interest, plus, minimally, a binary `broader than'/`narrower
  -- than' relation by which the concepts are linked. The `broader
  -- than'/`narrower than' relation is usually conceived as set_ or
  -- class_based subsumption, but taxonomies are notorious for
  -- conflating the set membership and set subsumption (i.e.,
  -- subset/superset) relations into a single `IS_A' relation. Some
  -- taxonomies include additional binary relations, such as
  -- `subpart'/`superpart'.
  fun Taxonomy : Class ;
  fun Taxonomy_Class : SubClass Taxonomy ClassificationScheme ;

  -- A Beverage which is prepared by infusing tea leaves 
  -- into hot water.
  fun Tea : Class ;
  fun Tea_Class : SubClass Tea (both Beverage PreparedFood) ;

  -- The Profession of being a teacher.
  fun Teacher : Ind Profession ;

  -- Any Sport which is played by SportsTeams, e.g. 
  -- Baseball and Football.
  fun TeamSport : Class ;
  fun TeamSport_Class : SubClass TeamSport Sport ;

  -- The class of SalineSolutions produced by 
  -- the lacrimal glands of the Eyes.
  fun TearSubstance : Class ;
  fun TearSubstance_Class : SubClass TearSubstance (both LiquidBodySubstance SalineSolution) ;

  -- A HumanYouth between puberty and the age of 20.
  fun Teenager : Class ;
  fun Teenager_Class : SubClass Teenager HumanYouth ;

  -- A Device that permits LinguisticCommunication 
  -- between remote points by means of a code of aural dots and dashes that can 
  -- be converted into letters of an alphabet.
  fun Telegraph : Class ;
  fun Telegraph_Class : SubClass Telegraph (both CommunicationDevice ElectricDevice) ;

  -- A Device that permits LinguisticCommunication 
  -- between remote points by converting sound into electrical signals that are 
  -- then transmitted. When the signals are received, they are converted back 
  -- into sound.
  fun Telephone : Class ;
  fun Telephone_Class : SubClass Telephone (both CommunicationDevice ElectricDevice) ;

  -- A WireLine that carries telephone signals and 
  -- allows users of Telephones or Telegraphs to communicate with one another.
  fun TelephoneLine : Class ;
  fun TelephoneLine_Class : SubClass TelephoneLine WireLine ;

  -- Any instance of Speaking where the 
  -- instrument of Communication is a Telephone.
  fun Telephoning : Class ;
  fun Telephoning_Class : SubClass Telephoning Speaking ;

  -- Any instance of Broadcasting which 
  -- is intended to be received by a Television.
  fun TelevisionBroadcasting : Class ;
  fun TelevisionBroadcasting_Class : SubClass TelevisionBroadcasting Broadcasting ;

  -- A TelevisionReceiver is a Device for 
  -- receiving television broadcast signals from a TelevisionStation. TelevisionReceiver A TelevisionReceiver is a Device for receiving 
  -- television broadcast signals from a TelevisionStation or signals
  -- transmitted through a cable from a CableTelevisionSystem.
  fun TelevisionReceiver : Class ;
  fun TelevisionReceiver_Class : SubClass TelevisionReceiver (both ReceiverDevice EngineeringComponent) ;

  -- Any Stating which is both False and believed 
  -- to be False by the agent of the Stating.
  fun TellingALie : Class ;
  fun TellingALie_Class : SubClass TellingALie Stating ;

  -- Tissue that connects Muscle to Bone.
  fun Tendon : Class ;
  fun Tendon_Class : SubClass Tendon (both AnimalSubstance Tissue) ;

  -- A MobileResidence that is made of Fabric and poles and 
  -- can be easily assembled and disassembled.
  fun Tent : Class ;
  fun Tent_Class : SubClass Tent MobileResidence ;

  -- A group that uses violent means in an
  --  attempt to bring about their political aims. Those violent means are
  --  distinguished from a war between nations, or a civil war in that the group
  --  is at least partially clandestine and a significant proportion of its acts
  --  are against non_military targets.
  fun TerroristOrganization : Class ;
  fun TerroristOrganization_Class : SubClass TerroristOrganization PoliticalOrganization ;

  -- A FormText which is intended to measure some aspect 
  -- of the cognitive capabilities, e.g. intelligence or knowledge of a domain, 
  -- of the person taking the test.
  fun TestForm : Class ;
  fun TestForm_Class : SubClass TestForm (both FormText MeasuringDevice) ;

  -- A Certificate that describes how a person's 
  -- property is to be distributed after the death of the person.
  fun Testament : Class ;
  fun Testament_Class : SubClass Testament Certificate ;

  -- Giving testimony as part of a JudicialProcess.
  fun Testifying : Class ;
  fun Testifying_Class : SubClass Testifying Stating ;

  -- Any ExpressingApproval to a person for something 
  -- that the person did in the past and that is regarded as being to the thanker's 
  -- benefit.
  fun Thanking : Class ;
  fun Thanking_Class : SubClass Thanking ExpressingApproval ;

  -- Often know as the stage, the 
  -- Position of performing live plays.
  fun TheaterProfession : Class ;
  fun TheaterProfession_Class : SubClass TheaterProfession EntertainmentProfession ;

  -- The systematic study of religious practice and religious truth.
  fun Theology : Ind FieldOfStudy ;

  -- Any Device that measures and represents 
  -- TemperatureMeasure.
  fun Thermometer : Class ;
  fun Thermometer_Class : SubClass Thermometer MeasuringDevice ;

  -- Any Committing where the thing promised 
  -- is something that is deemed undesirable by the destination of the 
  -- Committing.
  fun Threatening : Class ;
  fun Threatening_Class : SubClass Threatening Committing ;

  -- A BodyVessel which connects the Mouth to the 
  -- lungs and stomach.
  fun Throat : Class ;
  fun Throat_Class : SubClass Throat (both AnimalAnatomicalStructure BodyVessel) ;

  -- Any instance of Impelling where the instrument is 
  -- an Arm.
  fun Throwing : Class ;
  fun Throwing_Class : SubClass Throwing (both BodyMotion Impelling) ;

  -- The thick, short Finger of each Hand.
  fun Thumb : Class ;
  fun Thumb_Class : SubClass Thumb Finger ;

  -- Any instance of RadiatingSound which is caused by 
  -- an instance of Lightning.
  fun Thunder : Class ;
  fun Thunder_Class : SubClass Thunder (both RadiatingSound WeatherProcess) ;

  -- A Gland in the neck that produces HormoneTSH, 
  -- which regulates body weight, metabolic rate, etc.
  fun ThyroidGland : Class ;
  fun ThyroidGland_Class : SubClass ThyroidGland Gland ;

  -- A Hormone secreted by the ThyroidGland.
  fun ThyroidHormone : Class ;
  fun ThyroidHormone_Class : SubClass ThyroidHormone Hormone ;

  -- A Certificate that allows the holder to perform 
  -- a specified act once, e.g. ride a bus, attend a concert, obtain a prize, 
  -- etc.
  fun Ticket : Class ;
  fun Ticket_Class : SubClass Ticket Certificate ;

  -- Clothing that is intended to be worn around the 
  -- Neck and knotted at the front.
  fun TieClothing : Class ;
  fun TieClothing_Class : SubClass TieClothing Clothing ;

  -- The ContestAttribute that applies to all contestParticipants 
  -- in a Contest when none of them have Won or Lost the Contest.
  fun TieScore : Ind ContestAttribute ;

  -- Any Process of Digging, e.g. breaking and 
  -- turning over Soil that facilitates Agriculture.
  fun Tilling : Class ;
  fun Tilling_Class : SubClass Tilling (both Digging (both IntentionalProcess SurfaceChange)) ;

  -- An Amphibian that lacks a Tail and lives at least 
  -- partially outside of water.
  fun Toad : Class ;
  fun Toad_Class : SubClass Toad Amphibian ;

  -- A FloweringPlant containing nicotine whose leaves 
  -- are dried and then smoked or ingested.
  fun Tobacco : Class ;
  fun Tobacco_Class : SubClass Tobacco (both FloweringPlant PlantAgriculturalProduct) ;

  -- The five extremities of a Foot.
  fun Toe : Class ;
  fun Toe_Class : SubClass Toe (both AnimalAnatomicalStructure (both BodyPart DigitAppendage)) ;

  -- A Device for the disposal of wastes resulting from
  -- urination and defecation.
  fun Toilet : Class ;
  fun Toilet_Class : SubClass Toilet Device ;

  -- A StationaryArtifact which is meant to contain someone who is Dead.
  fun Tomb : Class ;
  fun Tomb_Class : SubClass Tomb StationaryArtifact ;

  -- English mass unit that is equal to 2000 pounds.
  fun TonMass : Ind UnitOfMass ;

  -- Any SpokenHumanLanguage that uses pitch to 
  -- differentiate otherwise identical words, e.g. Chinese.
  fun TonalLanguage : Class ;
  fun TonalLanguage_Class : SubClass TonalLanguage SpokenHumanLanguage ;

  -- Part of the Mouth, used for Tasting Food, 
  -- Vocalizing, and the initial stage of Digesting.
  fun Tongue : Class ;
  fun Tongue_Class : SubClass Tongue (both AnimalAnatomicalStructure BodyPart) ;

  -- Part of the Mouth, used for biting and chewing.
  fun Tooth : Class ;
  fun Tooth_Class : SubClass Tooth Bone ;

  -- A small BrushOrComb with relatively soft
  -- bristles and a long handle, used for brushing teeth (see Tooth). It is
  -- used help control bacteria living in the mouth. While most typically used
  -- by humans on themselves, it can be used by Dentists on their
  -- patients and by adults assisting children. They are occasionally used by
  -- humans caring for pets, zoo animals and valuable livestock.
  fun Toothbrush : Class ;
  fun Toothbrush_Class : SubClass Toothbrush BrushOrComb ;

  -- The body of a Primate excluding its Limbs.
  fun Torso : Class ;
  fun Torso_Class : SubClass Torso (both AnimalAnatomicalStructure BodyPart) ;

  -- A tourist is a person who is travelling to a 
  -- place primarily for reasons of entertainment or education, rather than
  -- business, although business transaction may take place during the trip.
  fun Tourist : Ind SocialRole ;

  -- A tourist site is a location that has some
  -- feature of interest to Tourists, which entertains or informs them.
  fun TouristSite : Class ;
  fun TouristSite_Class : SubClass TouristSite GeographicArea ;

  -- A piece of Fabric which is used for Drying.
  fun Towel : Class ;
  fun Towel_Class : SubClass Towel Fabric ;

  -- Any ContentDevelopment that results in a Blueprint.
  fun Tracing : Class ;
  fun Tracing_Class : SubClass Tracing (both ContentDevelopment SurfaceChange) ;

  -- TractorTrailer is the subclass of 
  -- RoadVehicles that are truck tractor_ truck trailer combinations.
  fun TractorTrailer : Class ;
  fun TractorTrailer_Class : SubClass TractorTrailer RoadVehicle ;

  -- The state of being free from Anxiety.
  fun Tranquility : Ind EmotionalState ;

  -- A Device which is capable of converting one 
  -- form of energy into another. Formally, a Twoport that neither stores 
  -- nor dissipates, but only transfers energy between its two ports.
  fun Transducer : Class ;
  fun Transducer_Class : SubClass Transducer Device ;

  -- Any process within an Organization 
  -- where a person is moved from one Position to another, e.g. the promotion 
  -- or demotion of an employee.
  fun TransferringPosition : Class ;
  fun TransferringPosition_Class : SubClass TransferringPosition OrganizationalProcess ;

  -- A TransitSystem is a system of 
  -- interconnected Transitways over which some type(s) of vehicles or 
  -- travellers may pass. In addition to Transitways, TransitSystems 
  -- may also include TransitJunctions and TransitTerminals. Transit 
  -- systems may be demarcated by where they are located (e.g., the rail 
  -- system of Afghanistan), who owns or manages them (e.g., American 
  -- Airlines TransitSystem of AirRoutes, or state highways managed by 
  -- TexDOT), or the type of vehicles or travellers accommodated (e.g., 
  -- the system of Santa Clara county bike trails.
  fun TransitSystem : Class ;
  fun TransitSystem_Class : SubClass TransitSystem PhysicalSystem ;

  -- A Transparent material is one through which
  -- it is possible to have Seeing.
  fun Transparent : Ind InternalAttribute ;

  -- TransportViaRoadVehicle is the class of Transportation
  -- events in which the instrument is an instance of
  -- RoadVehicle.
  fun TransportViaRoadVehicle : Class ;
  fun TransportViaRoadVehicle_Class : SubClass TransportViaRoadVehicle LandTransportation ;
  fun TransportViaRoadVehicle_Transportation : SubClassC TransportViaRoadVehicle Transportation (\TRANSPORT -> exists RoadVehicle (\VEHICLE -> instrument(var Transportation Process ? TRANSPORT)(var RoadVehicle Object ? VEHICLE)));

  -- A CommercialAgent whose services include Transportation, 
  -- e.g. a RailroadCompany, an airline, a cruise ship line, etc.
  fun TransportationCompany : Class ;
  fun TransportationCompany_Class : SubClass TransportationCompany CommercialAgent ;

  -- A Device whose purpose is to trap or cage Animals, 
  -- i.e. to be in instrument in an act of Confining.
  fun TrapOrCage : Class ;
  fun TrapOrCage_Class : SubClass TrapOrCage Holder ;

  -- Any Container which is intended to be 
  -- used for carrying clothing, toiletries, and other personal effects that 
  -- would be needed on a overnight trip.
  fun TravelContainer : Class ;
  fun TravelContainer_Class : SubClass TravelContainer Container ;

  -- A Holder that is designed for Food, dishes, and 
  -- flatware.
  fun Tray : Class ;
  fun Tray_Class : SubClass Tray Holder ;

  -- Any SkilledOccupation which involves receiving 
  -- and disbursing money.
  fun Treasurer : Class ;
  fun Treasurer_Class : SubClass Treasurer SkilledOccupation ;

  -- Any Contract which holds between two or more Nations.
  fun Treaty : Ind DeonticAttribute ;

  -- Any PlantBranch which is part of a BotanicalTree.
  fun TreeBranch : Class ;
  fun TreeBranch_Class : SubClass TreeBranch PlantBranch ;

  -- Any BodyMotion which is involuntary and which is 
  -- repeated many times over a short time frame, e.g. a tremor in the hands,
  -- shivering etc.
  fun Trembling : Class ;
  fun Trembling_Class : SubClass Trembling (both AutonomicProcess (both BodyMotion Tremor)) ;

  -- Motion that involves rapidly Rotating between two positions.
  fun Tremor : Class ;
  fun Tremor_Class : SubClass Tremor Rotating ;

  -- Entering property that does not belong to one and without 
  -- the permission of the owner of the property.
  fun Trespassing : Class ;
  fun Trespassing_Class : SubClass Trespassing (both CriminalAction Translocation) ;

  -- Any three_sided Polygon.
  fun Triangle : Class ;
  fun Triangle_Class : SubClass Triangle Polygon ;

  -- A piece of Clothing that covers each Leg of a person separately.
  fun Trousers : Class ;
  fun Trousers_Class : SubClass Trousers Clothing ;

  -- Any Vehicle that is intended to carry substantial
  -- amounts of cargo, in addition to passengers. This includes 18_wheelers,
  -- pickup trucks, tanker trucks etc. Consumer vehicles with trunks or enclosed
  -- rear areas that can carry cargo are not defined as trucks. Truck is the subclass of RoadVehicles that 
  -- are designed primarily for transporting various kinds of non_passenger 
  -- loads. Truck is the class of single_bodied trucks or TruckTractors. 
  -- Note: TractorTrailer combinations are a distinct class. Truck an automotive vehicle suitable for hauling
  fun Truck : Class ;
  fun Truck_Class : SubClass Truck (both CargoVehicle SelfPoweredRoadVehicle) ;

  -- TruckTractor is the subclass of Trucks that are used to tow truck trailers.
  -- Truck tractors are the cab portions of tractor_trailers. See also TruckTrailer.
  fun TruckTractor : Class ;
  fun TruckTractor_Class : SubClass TruckTractor Truck ;

  -- TruckTrailer is the subclass of Wagons 
  -- that are towed by TruckTractors. These are the trailers used in 
  -- tractor_trailer (semi_trailer) rigs.
  fun TruckTrailer : Class ;
  fun TruckTrailer_Class : SubClass TruckTrailer Wagon ;

  -- A long, narrow, and hollow Artifact that is designed for 
  -- moving Fluids from place to another.
  fun Tube : Class ;
  fun Tube_Class : SubClass Tube Artifact ;

  -- A BacterialDisease caused by the Tubercle Bacillus 
  -- that results in lesions on various body parts, especially the Lungs. Tuberculosis A disease that usually infects the lungs and causes severe 
  -- coughing. In some cases it will result in hemorrhage of the lungs.
  fun Tuberculosis : Ind BacterialDisease ;

  -- Any AbnormalAnatomicalStructure which consists of a 
  -- mass of Tissue. Note that this class covers both malignant (i.e. cancerous) 
  -- and benign tumors.
  fun Tumor : Class ;
  fun Tumor_Class : SubClass Tumor AbnormalAnatomicalStructure ;

  -- An Engine which converts the kinetic energy of a moving 
  -- Liquid (typically Water) into mechanical energy.
  fun Turbine : Class ;
  fun Turbine_Class : SubClass Turbine Engine ;

  -- Any Process whose result is that the patient 
  -- of the process is in the state of DeviceOff. In other words, this class covers 
  -- any process of turning off a device, e.g. turning off the lights, switching off a 
  -- television set, etc.
  fun TurningOffDevice : Class ;
  fun TurningOffDevice_Class : SubClass TurningOffDevice InternalChange ;

  -- Any Process whose result is that the patient 
  -- of the process is in the state of DeviceOn. In other words, this class covers 
  -- any process of turning on a device, e.g. turning on the lights, switching on a 
  -- television set, etc.
  fun TurningOnDevice : Class ;
  fun TurningOnDevice_Class : SubClass TurningOnDevice InternalChange ;

  -- A real_world physical object
  -- with a very flat aspect. This includes drawings on paper, cave
  -- paintings and other surface alterations.
  fun TwoDimensionalObject : Class ;
  fun TwoDimensionalObject_Class : SubClass TwoDimensionalObject Object ;

  -- The Process of tying two things, or two strands of 
  -- the same thing, together.
  fun Tying : Class ;
  fun Tying_Class : SubClass Tying Attaching ;

  -- An Attribute which indicates that the 
  -- associated Object cannot be broken under normal usage conditions.
  fun Unbreakable : Ind BreakabilityAttribute ;

  -- The state of being unhappy, experiencing pain, 
  -- sorrow or unease.
  fun Unhappiness : Ind EmotionalState ;

  -- An Organization comprised of workers from 
  -- the same Corporation or Industry. The purpose of the UnionOrganization 
  -- is to strengthen its representation in bargaining with the Corporation or 
  -- Industry.
  fun UnionOrganization : Class ;
  fun UnionOrganization_Class : SubClass UnionOrganization Organization ;

  -- Any Soldier that served on the union side during 
  -- the American Civil War. UnionSoldier Any Soldier that served on the union
  -- side during the American Civil War.
  fun UnionSoldier : Class ;
  fun UnionSoldier_Class : SubClass UnionSoldier Soldier ;

  -- The states of the UnitedStates that the 
  -- ConfederateStatesOfAmerica seceded from.
  fun UnionStatesOfAmerica : Ind GeopoliticalArea ;

  -- The legislative branch of the government 
  -- of the UnitedStates.
  fun UnitedStatesCongress : Ind LegislativeOrganization ;

  -- Manages and preserves public lands and natural resources in the UnitedStates.
  fun UnitedStatesDepartmentOfInterior : Ind GovernmentOrganization ;

  -- The subOrganization of the US government that sets and enforces foreign policy.
  fun UnitedStatesDepartmentOfState : Ind GovernmentOrganization ;

  -- A School which admits students that 
  -- have graduated from high school (known as undergraduate students) and 
  -- students who have received a bachelor's degree (known as graduate 
  -- students). A University confers both bachelor's and graduate 
  -- degrees.
  fun University : Class ;
  fun University_Class : SubClass University PostSecondarySchool ;

  -- Any Position which does not 
  -- require learning a set of skills.
  fun UnskilledOccupation : Class ;
  fun UnskilledOccupation_Class : SubClass UnskilledOccupation ManualLabor ;

  -- The Process of untying two things, or two strands 
  -- of the same thing.
  fun Untying : Class ;
  fun Untying_Class : SubClass Untying Detaching ;

  -- A PositionalAttribute to indicate that one thing is 
  -- one or more floors above a second thing in the same building.
  fun Upstairs : Ind PositionalAttribute ;

  -- Urea is a dry, soluble, nitrogenous substance 
  -- that is the major solid component of the urine of mammals, and which 
  -- may be synthesized from ammonia and carbon dioxide, it is useful in the 
  -- production of Plastic and in Fertilizers.
  fun Urea : Class ;
  fun Urea_Class : SubClass Urea OrganicCompound ;

  -- Taking time off from Working.
  fun Vacationing : Class ;
  fun Vacationing_Class : SubClass Vacationing RecreationOrExercise ;

  -- An event where the objective of the agent
  -- is to damage or destroy some property of another agent. This is
  -- distinguished from acts where the prime objective is damage or loss
  -- of life of another agent.
  fun Vandalism : Class ;
  fun Vandalism_Class : SubClass Vandalism Destruction ;

  -- An event in which a vehicle is used by an agent in order to inflict
  -- injury, death or damage to people or property.
  fun VehicleAttack : Class ;
  fun VehicleAttack_Class : SubClass VehicleAttack ViolentContest ;

  -- A VehicleController which is capable of stopping the motion of a Vehicle.
  fun VehicleBrake : Class ;
  fun VehicleBrake_Class : SubClass VehicleBrake VehicleController ;

  -- Any Device which is used to start, stop or 
  -- control the movements of a Vehicle. This class covers steering wheels, brakes, 
  -- acceleration pedals, airplane sticks, etc.
  fun VehicleController : Class ;
  fun VehicleController_Class : SubClass VehicleController Device ;

  -- Any LightFixture which is attached to the 
  -- surface of a Vehicle and whose purpose is to illuminate that area around 
  -- the Vehicle so that potential obstacles can be detected or alerted.
  fun VehicleLight : Class ;
  fun VehicleLight_Class : SubClass VehicleLight LightFixture ;

  -- A VehicleController which controls the amount 
  -- of Fuel which is supplied to the Engine.
  fun VehicleThrottle : Class ;
  fun VehicleThrottle_Class : SubClass VehicleThrottle VehicleController ;

  -- A covering, usually made of rubber, for a Wheel.
  fun VehicleTire : Class ;
  fun VehicleTire_Class : SubClass VehicleTire Artifact ;

  -- VehicleWheel is a class of cylindrical 
  -- Devices used to move a RoadVehicle along a road, running either 
  -- directly on the wheel rims or on tires attached to the wheel rims.
  fun VehicleWheel : Class ;
  fun VehicleWheel_Class : SubClass VehicleWheel Wheel ;

  -- Any Window which is part of a Vehicle, 
  -- e.g. the Windshield and RearWindow of an Automobile.
  fun VehicleWindow : Class ;
  fun VehicleWindow_Class : SubClass VehicleWindow Window ;

  -- A piece of Clothing intended to cover or
  -- obscure the face or hair of a Woman. This is commonly worn for
  -- religious reasons when in public in Muslim countries, but is also customary
  -- at Weddings and Funerals among some non_Muslim women.
  fun Veil : Class ;
  fun Veil_Class : SubClass Veil Clothing ;

  -- Any BloodVessel which transfers Blood from 
  -- the extremities of the body to the Heart.
  fun Vein : Class ;
  fun Vein_Class : SubClass Vein BloodVessel ;

  -- A Device which is capable of Selling a Product to a customer
  -- automatically when the customer inserts the appropriate amount of Currency.
  fun VendingDevice : Class ;
  fun VendingDevice_Class : SubClass VendingDevice Device ;

  -- The Attribute that applies to someone who was a 
  -- Soldier at one time, but is not currently a Soldier.
  fun Veteran : Ind SocialRole ;

  -- A representation of video on some medium such
  -- as film, videotape or DVD. Instances of this class are also commonly
  -- instances of AudioRecording.
  fun VideoRecording : Class ;
  fun VideoRecording_Class : SubClass VideoRecording ContentBearingObject ;

  -- A StringInstrument that has four strings, a hollow 
  -- body, and is played on the shoulder with a bow.
  fun Violin : Class ;
  fun Violin_Class : SubClass Violin StringInstrument ;

  -- A disease that is caused by instances of 
  -- Virus.
  fun ViralDisease : Class ;
  fun ViralDisease_Class : SubClass ViralDisease InfectiousDisease ;

  -- Music which is produced (at least in part)
  -- by Singing.
  fun VocalMusic : Class ;
  fun VocalMusic_Class : SubClass VocalMusic Music ;

  -- Any School whose aim is to teach 
  -- students an OccupationalTrade.
  fun VocationalSchool : Class ;
  fun VocationalSchool_Class : SubClass VocationalSchool School ;

  -- A structure where Voting for an Election 
  -- takes place.
  fun VotingPoll : Class ;
  fun VotingPoll_Class : SubClass VotingPoll StationaryArtifact ;

  -- An AlphabeticCharacter that denotes a speech sound that 
  -- does not result in audible friction when it is pronounced.
  fun Vowel : Class ;
  fun Vowel_Class : SubClass Vowel AlphabeticCharacter ;

  -- A diurnal bird of prey with a bald head that 
  -- feeds on carrion.
  fun Vulture : Class ;
  fun Vulture_Class : SubClass Vulture Bird ;

  -- Any instance of Walking which occurs through a 
  -- BodyOfWater.
  fun Wading : Class ;
  fun Wading_Class : SubClass Wading Walking ;

  -- A Landcraft that is not self_propelled, but must be 
  -- pulled by either an Animal or a self_propelled Vehicle to move along the 
  -- ground.
  fun Wagon : Class ;
  fun Wagon_Class : SubClass Wagon LandVehicle ;

  -- The process of transitioning from a state of being 
  -- Asleep to a state of being Awake.
  fun WakingUp : Class ;
  fun WakingUp_Class : SubClass WakingUp PsychologicalProcess ;

  -- A Device which has the form of a staff with 
  -- a handle and which enables some people to walk with greater assurance.
  fun WalkingCane : Class ;
  fun WalkingCane_Class : SubClass WalkingCane Device ;

  -- A StationaryArtifact that supports a Building or 
  -- partitions it into Rooms.
  fun Wall : Class ;
  fun Wall_Class : SubClass Wall StationaryArtifact ;

  -- Any decorative paper that is used to cover the 
  -- Walls of Rooms.
  fun Wallpaper : Class ;
  fun Wallpaper_Class : SubClass Wallpaper ArtWork ;

  -- A very large CommercialBuilding whose purpose is 
  -- to store commodities.
  fun Warehouse : Class ;
  fun Warehouse_Class : SubClass Warehouse CommercialBuilding ;

  -- A WashingDevice which is intended to be used by 
  -- Humans for washing their Hands.
  fun WashBasin : Class ;
  fun WashBasin_Class : SubClass WashBasin WashingDevice ;

  -- Removing small particles from something by means of 
  -- a Detergent and Water.
  fun Washing : Class ;
  fun Washing_Class : SubClass Washing Removing ;

  -- Any Device whose purpose is Washing 
  -- something, e.g. washing machines, dishwashers, bathtubs, etc.
  fun WashingDevice : Class ;
  fun WashingDevice_Class : SubClass WashingDevice Device ;

  -- A Container which is used for trash.
  fun Wastebasket : Class ;
  fun Wastebasket_Class : SubClass Wastebasket Container ;

  -- A Clock that can be worn on the Wrist.
  fun WatchClock : Class ;
  fun WatchClock_Clock : SubClassC WatchClock Clock 
                                   (\C -> exists Human (\P -> exists Wrist (\W -> and (wears (var Human Animal ? P)
                                                                                             (var Clock Clothing ? C))
                                                                                      (located (var Clock Physical ? C)
                                                                                               (var Wrist Object ? W)))));

  -- Any instance of Transportation where the instrument is a WaterVehicle.
  fun WaterTransportation : Class ;
  fun WaterTransportation_Class : SubClass WaterTransportation Transportation ;

  -- WaterVehicle is the class of all TransportationDevices used to travel on or in water.
  fun WaterVehicle : Class ;
  fun WaterVehicle_Class : SubClass WaterVehicle Vehicle ;

  -- A WaterWave is a raised ridge of water 
  -- moving along the surface of a body of water. The WaterWave moves 
  -- in a direction approximately transverse to the crest line of the wave. 
  -- The patient of the WaterWave is successive regions of water, which 
  -- do not travel in the direction of the wave or with it.
  fun WaterWave : Class ;
  fun WaterWave_Class : SubClass WaterWave LiquidMotion ;

  -- Any Paint which is a water_based Solution.
  fun WatercolorPaint : Class ;
  fun WatercolorPaint_Class : SubClass WatercolorPaint Paint ;

  -- Any PaintedPicture which is created 
  -- with water_based paints.
  fun WatercolorPicture : Class ;
  fun WatercolorPicture_Class : SubClass WatercolorPicture PaintedPicture ;

  -- Moving a Hand to indicate a greeting, farewell, 
  -- recognition, goodwill, etc.
  fun Waving : Class ;
  fun Waving_Class : SubClass Waving HandGesture ;

  -- Any Substance of high molecular weight that resembles 
  -- beeswax.
  fun Wax : Class ;
  fun Wax_Class : SubClass Wax Substance ;

  -- Nuclear, chemical and biological weapons. 
  -- What these weapons have in common is that they are designed to kill large numbers 
  -- of people indiscriminately.
  fun WeaponOfMassDestruction : Class ;
  fun WeaponOfMassDestruction_Class : SubClass WeaponOfMassDestruction Weapon ;

  -- Any Saturday and Sunday which are contiguous.
  fun Weekend : Class ;
  fun Weekend_Class : SubClass Weekend TimeInterval ;

  -- Expressing unhappiness by shedding tears.
  fun Weeping : Class ;
  fun Weeping_Class : SubClass Weeping FacialExpression ;

  -- Any Funding which is provided by a ServiceOrganization 
  -- to people in need.
  fun Welfare : Class ;
  fun Welfare_Class : SubClass Welfare Funding ;

  -- A long CerealGrain which is produced by certain grasses and 
  -- which is used to make BreadOrBiscuits.
  fun WheatGrain : Class ;
  fun WheatGrain_Class : SubClass WheatGrain CerealGrain ;

  -- A circular Artifact which is a component of 
  -- LandVehicles and of some Devices.
  fun Wheel : Class ;
  fun Wheel_Class : SubClass Wheel Artifact ;

  -- A Weapon that consists of a thin strand of 
  -- Fabric, usually Leather, and a handle by which the strand is 
  -- impelled at a high rate of speed.
  fun Whip : Class ;
  fun Whip_Class : SubClass Whip Weapon ;

  -- A DistilledAlcoholicBeverage that is prepared by 
  -- distilling fermented grain mash.
  fun Whiskey : Class ;
  fun Whiskey_Class : SubClass Whiskey DistilledAlcoholicBeverage ;

  -- BloodCells that lack hemoglobin, contain a 
  -- CellNucleus, and have no color.
  fun WhiteBloodCell : Class ;
  fun WhiteBloodCell_Class : SubClass WhiteBloodCell BloodCell ;

  -- A MercantileOrganization that sells its 
  -- goods exclusively to Corporations.
  fun WholesaleStore : Class ;
  fun WholesaleStore_Class : SubClass WholesaleStore (both Agency MercantileOrganization) ;

  -- The Attribute that applies to someone who was 
  -- married to someone who has died, and who has not remarried.
  fun Widowed : Ind SocialRole ;

  -- A BotanicalTree of the genus Salix.
  fun WillowTree : Class ;
  fun WillowTree_Class : SubClass WillowTree BotanicalTree ;

  -- A MusicalInstrument which is played by 
  -- blowing it and which uses a reed, or resonator hole as in the case of a flute.
  fun WindInstrument : Class ;
  fun WindInstrument_Class : SubClass WindInstrument MusicalInstrument ;

  -- Windmill is the subclass of Engines that 
  -- produce mechanical power from Wind energy.
  fun Windmill : Class ;
  fun Windmill_Class : SubClass Windmill Engine ;

  -- An Artifact composed of transparent material 
  -- that admits light (and possibly air) into a Room, Building 
  -- or Vehicle.
  fun Window : Class ;
  fun Window_Class : SubClass Window Artifact ;

  -- An Artifact that is used to cover 
  -- Windows. Note that this class includes blinds, drapes, shutters, 
  -- etc.
  fun WindowCovering : Class ;
  fun WindowCovering_Class : SubClass WindowCovering Artifact ;

  -- Any VehicleWindow which located at the front 
  -- of an Automobile.
  fun Windshield : Class ;
  fun Windshield_Class : SubClass Windshield VehicleWindow ;

  -- An AlcoholicBeverage that is prepared by fermenting 
  -- the juice of grapes.
  fun Wine : Class ;
  fun Wine_Class : SubClass Wine (both AlcoholicBeverage PlantAgriculturalProduct) ;

  -- Any Limb which is capable of being an 
  -- instrument in Flying.
  fun Wing : Class ;
  fun Wing_Class : SubClass Wing Limb ;

  -- The wings of Aircraft, i.e. the parts of Aircraft 
  -- that allow them to become and remain airborne.
  fun WingDevice : Class ;
  fun WingDevice_Class : SubClass WingDevice EngineeringComponent ;

  -- Any instance of ClosingEyes which is intended to 
  -- express something to someone else.
  fun Winking : Class ;
  fun Winking_Class : SubClass Winking (both ClosingEyes Gesture) ;

  -- The SeasonOfYear that begins at the winter 
  -- solstice and ends at the spring equinox.
  fun WinterSeason : Class ;
  fun WinterSeason_Class : SubClass WinterSeason SeasonOfYear ;

  -- A long, thin strand of Metal that is used in a wide 
  -- range of applications, including the wiring of electrical systems, creating 
  -- bundles and the construction of cages.
  fun Wire : Class ;
  fun Wire_Class : SubClass Wire Artifact ;

  -- A Wire that is designed for conducting electricity.
  fun WireLine : Class ;
  fun WireLine_Class : SubClass WireLine (both EngineeringComponent Wire) ;

  -- An EngineeringComponent consisting of a coil of 
  -- Wire that returns to its original shape when pulled apart or pressed together.
  fun WireSpring : Class ;
  fun WireSpring_Class : SubClass WireSpring (both EngineeringComponent Wire) ;

  -- The ContestAttribute that applies to a Contest 
  -- participant who has won the Contest.
  fun Won : Ind ContestAttribute ;

  -- Tissue that comprises the inner trunk of Trees. 
  -- It is often used in constructing Buildings and other Artifacts.
  -- Wood is the principal substance making up a tree, and is distinguished from the
  -- bark, roots, flowers, seeds, fruit and leaves.
  fun Wood : Class ;
  fun Wood_Class : SubClass Wood (both PlantSubstance Tissue) ;

  -- Wood that has been cut (and perhaps treated) for 
  -- some purpose, e.g. Constructing or Combustion. Note that this class covers 
  -- both lumber and firewood.
  fun WoodArtifact : Class ;
  fun WoodArtifact_Class : SubClass WoodArtifact Artifact ;

  -- Fabric that is made from the Hair of Sheep.
  fun Wool : Class ;
  fun Wool_Class : SubClass Wool Fabric ;

  -- Sterile members of an Insect colony which 
  -- are responsible for locating food and caring for eggs, larvae, etc.
  fun WorkerInsect : Class ;
  fun WorkerInsect_Class : SubClass WorkerInsect Insect ;

  -- Any FinancialTransaction where someone exchanges 
  -- his/her labor for an instance of CurrencyMeasure.
  fun Working : Class ;
  fun Working_Class : SubClass Working FinancialTransaction ;

  -- A Room, suite of Rooms or Building which is 
  -- devoted to hand_crafting Artifacts.
  fun Workshop : Class ;
  fun Workshop_Class : SubClass Workshop StationaryArtifact ;

  -- The joint in the Arm connecting the radius and carpal bones.
  fun Wrist : Class ;
  fun Wrist_Class : SubClass Wrist BodyJoint ;

  -- A Device whose purpose is to be an instrument 
  -- of Writing, e.g. pens, pencils, crayons, etc.
  fun WritingDevice : Class ;
  fun WritingDevice_Class : SubClass WritingDevice Device ;

  -- Any LinguisticCommunication where the 
  -- instrument is a Text, e.g. a letter, an email, a memo, etc.
  fun WrittenCommunication : Class ;
  fun WrittenCommunication_Class : SubClass WrittenCommunication LinguisticCommunication ;

  -- Electro_magnetic radiation of short wavelength, 
  -- often made use of by devices that scan the inside of objects.
  fun XRayRadiation : Class ;
  fun XRayRadiation_Class : SubClass XRayRadiation Radiating ;

  -- English unit of length, equal to 3 FeetLength.
  fun YardLength : Ind UnitOfLength ;

  -- (address ?AGENT ?ADDRESS) means that ?ADDRESS 
  -- is an address or part of an address for the Agent ?AGENT.
  fun address : El Agent -> El Address -> Formula ;

  fun affiliatedOrganization : El Organization -> El Organization -> Formula ;

  -- (alias ?STRING ?AGENT) means that ?STRING is an
  -- alternate identifier for ?AGENT, and is likely being used to hide or
  -- obscure ?AGENT's true identity.
  fun alias : El SymbolicString -> El Agent -> Formula ;

  -- (allegiance ?AGENT ?ENTITY) means that the CognitiveAgent 
  -- ?AGENT owes its allegiance to the political entity ?ENTITY.
  fun allegiance : El CognitiveAgent -> El CognitiveAgent -> Formula ;

  -- (ancestorOrganization ?ORG1 ?ORG2) means that 
  -- the Organization ?ORG1 descended from the Organization ?ORG2.
  fun ancestorOrganization : El Organization -> El Organization -> Formula ;

  -- (anniversary ?PHYSICAL ?TIME) means that 
  -- ?TIME is the class of TimeIntervals which mark the anniversary of 
  -- ?PHYSICAL. For example, (anniversary Christmas (DayFn 35 December)) 
  -- means that Christmas is celebrated each year on the 25th of December.
  fun anniversary : El Physical -> El TimeInterval -> Formula ;

  -- (areaOfResponsibility ?AGENT ?PROCESS_TYPE ?AREA) means that ?AGENT
  -- (typically an instance of Organization) is responsible or accountable for
  -- actions or undertakings of type ?PROCESS_TYPE in the
  -- GeographicArea denoted by ?AREA.
  fun areaOfResponsibility : El Agent -> Desc Process -> El GeographicArea -> Formula ;

  -- (arrested ?EVENT ?AGENT) means that during ?EVENT, ?AGENT is
  -- taken into custody, typically by a representative of a law
  -- enforcement organization.
  fun arrested : El PlacingUnderArrest -> El Agent -> Formula ;

  -- (aunt ?AUNT ?PERSON) means that ?AUNT is 
  -- the sister of a parent of ?PERSON.
  fun aunt : El Woman -> El Human -> Formula ;

  -- (axis ?A ?OBJ) means that a part ?A of an Object ?OBJ
  -- is the axis of rotation in a Rotating.
  fun axis : El Object -> El Object -> Formula ;

  -- (benefits ?PROCESS ?AGENT) means that
  -- ?AGENT somehow derives benefit as a result of ?PROCESS. This is
  -- a very general relation, and does not entail that ?AGENT is a
  -- participant in ?PROCESS.
  fun benefits : El Process -> El Agent -> Formula ;

  -- (birthdate ?PERSON ?DAY) means that ?DAY is the 
  -- Day on which the ?PERSON was born.
  fun birthdate : El Human -> El Day -> Formula ;

  -- (birthday ?PERSON ?DAY) means that ?DAY is the 
  -- anniversary each year of the birth of ?PERSON. For example, (birthday 
  -- WilliamJeffersonClinton (DayFn 19 August)) means that Bill Clinton's 
  -- birthday is August 19th.
  fun birthday : El Human -> El Day -> Formula ;

  -- (birthplace ?INDIV ?PLACE) means that the Animal ?INDIV was born 
  -- at the location ?PLACE. The location may be a geographic area or a building, such as a hospital.
  fun birthplace : El Animal -> El Object -> Formula ;

  -- (brandName ?NAME ?PRODUCT) means that ?NAME 
  -- is the brand name for the product class ?PRODUCT, e.g. Cheerios is the 
  -- brand name for a certain class of breakfast cereal.
  fun brandName : El SymbolicString -> El Product -> Formula ;

  -- (capacity ?OBJ ?QUANTITY) means that ?OBJ can contain 
  -- something that has the measure of ?QUANTITY. This predicate denotes maximal 
  -- capacity, i.e. ?OBJ can hold no more than ?QUANTITY. Note, however, that this 
  -- does not mean that capacity is a SingleValuedRelation, since an object may 
  -- have various maximal capacities across different dimensions, e.g. a particular 
  -- box may have a capacity of 3 pounds and a capacity of 1 liter.
  fun capacity : El SelfConnectedObject -> El ConstantQuantity -> Formula ;

  -- (cargo ?EVENT ?OBJ) means that ?OBJ is transported as cargo in 
  -- the Shipping event ?EVENT.
  fun cargo : El Shipping -> El Object -> Formula ;

  -- (changesLocation ?EVENT ?OBJECT) means that during the Translocation 
  -- event ?EVENT, ?OBJECT's location changes. ?OBJECT might also be the agent,
  -- patient, or experiencer of ?EVENT.
  fun changesLocation : El Translocation -> El Object -> Formula ;

  -- (cityAddress ?CITY ?ADDRESS) means that the 
  -- City ?CITY is part of the address ?ADDRESS.
  fun cityAddress : El City -> El Address -> Formula ;

  -- (holdsDuring ?T1 (cohabitant ?H1 ?H2))
  -- means that during the time ?T1, ?H1 and ?H2 have the same home.
  fun cohabitant : El Human -> El Human -> Formula ;

  -- (conjugate ?COMPOUND1 ?COMPOUND2) means that 
  -- ?COMPOUND1 and ?COMPOUND2 are identical CompoundSubstances except that 
  -- one has one more Proton than the other.
  fun conjugate : El CompoundSubstance -> El CompoundSubstance -> Formula ;

  -- (contestParticipant ?CONTEST ?AGENT) 
  -- means that ?AGENT is one of the sides in the Contest ?CONTEST. For 
  -- example, if the ?CONTEST is a football game, then ?AGENT would be one of 
  -- the opposing teams. For another example, if ?CONTEST is a Battle, then 
  -- ?AGENT would be one of the sides fighting each other.
  fun contestParticipant : El Contest -> El Agent -> Formula ;

  -- (controlled ?EVENT ?OBJECT) means that during the
  -- AchievingControl denoted by ?EVENT, ?OBJECT comes to be
  -- physically controlled by an Agent.
  fun controlled : El AchievingControl -> El Object -> Formula ;

  -- (conveyance ?EVENT ?OBJ) means that ?OBJ is the
  -- Vehicle or other transportation device used in ?EVENT.
  fun conveyance : El Transportation -> El TransportationDevice -> Formula ;

  -- (cousin ?PERSON1 ?PERSON2) means that ?PERSON1 
  -- and ?PERSON2 are cousins, i.e. ?PERSON1 and ?PERSON2 have grandparents 
  -- (but not parents) in common.
  fun cousin : El Human -> El Human -> Formula ;

  -- (holdsDuring ?T1 (coworker ?H1 ?H2)) means
  -- that during time ?T1, ?H1 and ?H2 are both employed by the same agent, are
  -- of roughly the same job status, and come into contact at least part of the
  -- time at the same work location.
  fun coworker : El Human -> El Human -> Formula ;

  -- (birthdate ?PERSON ?DAY) means that ?DAY is the 
  -- Day on which the ?PERSON died.
  fun deathdate : El Human -> El Day -> Formula ;

  -- (deathplace ?INDIV ?PLACE) means that the Animal ?INDIV died 
  -- at the location ?PLACE. The location may be a geographic area or a building, 
  -- such as a hospital.
  fun deathplace : El Animal -> El Object -> Formula ;

  -- (deceptiveIdentifier ?OBJ ?AGENT)
  -- means that ?AGENT presents ?OBJ as a representation of ?AGENT's `true'
  -- identity, when in fact it is not.
  fun deceptiveIdentifier : El ContentBearingObject -> El Agent -> Formula ;

  -- (defendant ?AGENT ?ACTION) means the LegalAction 
  -- ?ACTION makes a legal claim against ?AGENT.
  fun defendant : El CognitiveAgent -> El LegalAction -> Formula ;

  -- (detainee ?EVENT ?OBJECT) means that in the 
  -- Confining ?EVENT, the Object ?OBJECT is restrained by force, threat, or 
  -- other form of intimidation.
  fun detainee : El Confining -> El Animal -> Formula ;

  -- (deviceState ?DEVICE ?STATE) means that 
  -- the Object ?DEVICE is in the DeviceStateAttribute ?STATE.
  fun deviceState : El Object -> El DeviceStateAttribute -> Formula ;

  -- (disapproves ?AGENT ?FORMULA) means that 
  -- ?AGENT has a feeling of antipathy to the state of affairs represented by 
  -- ?FORMULA, i.e. ?AGENT believes that the realization of ?FORMULA will 
  -- thwart one of his/her goals. Note that there is no implication that what 
  -- is disapproved of by an agent is not already true.
  fun disapproves : El CognitiveAgent -> Formula -> Formula ;

  -- (dislikes ?AGENT ?OBJECT) means that ?AGENT has a 
  -- feeling of antipathy to ?OBJECT, i.e. ?AGENT believes that ?OBJECT will 
  -- thwart one of his/her goals. Note that there is no implication that what 
  -- is hated by an agent is not already possessed by the agent.
  fun dislikes : El CognitiveAgent -> El Object -> Formula ;

  -- (distanceOnPath ?DIST ?PATH) means that for a given path (which is a pathInSystem) that the 
  -- distance of the route is the measurement ?DIST. distanceOnPath (distanceOnPath ?DIST ?PATH) 
  -- means that for a given path (which is a pathInSystem) that the distance of the route is
  -- the measurement ?DIST.
  fun distanceOnPath : El ConstantQuantity -> El Transitway -> Formula ;

  -- (holdsDuring ?T1 (domesticPartner ?H1 ?H2)) means that during the time ?T1, ?H1
  -- and ?H2 live together and share a common domestic life but are
  -- not joined in a traditional marriage, a common_law marriage, or a
  -- civil union.
  fun domesticPartner : El Human -> El Human -> Formula ;

  -- (doubts ?AGENT ?FORMULA) means that ?AGENT is unsure 
  -- about the truth of ?FORMULA, in particular ?AGENT does not believe that 
  -- ?FORMULA is true.
  fun doubts : El CognitiveAgent -> Formula -> Formula ;

  -- Models the effective range of some
  -- device that is able to move by itself (like vehicles, rockets and so
  -- on) or move other things (like weapons).
  fun effectiveRange : El Device -> El LengthMeasure -> Formula ;

  -- (electronNumber ?SUBSTANCE ?NUMBER) means that 
  -- the PureSubstance ?SUBSTANCE has the number of Electrons ?NUMBER.
  fun electronNumber : El PureSubstance -> El PositiveInteger -> Formula ;

  -- (enjoys ?AGENT ?PROCESS) means that the 
  -- CognitiveAgent ?AGENT tends to enjoy actions of type ?PROCESS, 
  -- i.e. tends to enjoy being the agent or experiencer of such 
  -- actions.
  fun enjoys : El CognitiveAgent -> El IntentionalProcess -> Formula ;

  -- (equipmentCount ?OBJECT ?TYPE ?QUANTITY) means that ?OBJECT 
  -- is equipped with devices of the type ?TYPE, in the number ?QUANTITY. 
  -- Equipment associated with an ?OBJECT may be a component of ?OBJECT 
  -- (such as the emergency oxygen system built into passenger jets) or it may 
  -- be a device simply located on or with ?OBJECT (such as a first aid kit).
  fun equipmentCount : El Object -> Desc Device -> El Quantity -> Formula ;

  -- (equipmentType ?THING ?TYPE) means that 
  -- the Artifact ?THING has a component or attachment of Device ?TYPE. 
  -- See also equipmentTypeCount.
  fun equipmentType : El Artifact -> El Device -> Formula ;

  -- Any belief about the future. (expects ?AGENT ?BELIEF) means that 
  -- (believes ?AGENT ?BELIEF) and, if ?BELIEF happens, it will
  -- happen in the future, i.e. after the expectation.
  fun expects : El CognitiveAgent -> Formula -> Formula ;

  -- (experimentalControl ?EXPERIMENT ?OBJ) means that the Object ?OBJ
  -- serves as a control in the instance of Experimenting ?EXPERIMENT, 
  -- i.e. ?OBJ is the standard against which something else in 
  -- the experiment can be compared.
  fun experimentalControl : El Experimenting -> El Object -> Formula ;

  -- (familyName ?STRING ?HUMAN) means that the SymbolicString ?STRING denotes a non_optional
  -- name that ?HUMAN has inherited by virtue of being born into a
  -- particular family (kin group). surname is another word for this type
  -- of name. Cf. givenName.
  fun familyName : El SymbolicString -> El Human -> Formula ;

  -- (fears ?AGENT ?FORMULA) means that ?AGENT fears that 
  -- the proposition ?FORMULA will be true, i.e. he/she believes that it will 
  -- come to pass in the future and that it will be undesirable for ?AGENT.
  fun fears : El CognitiveAgent -> Formula -> Formula ;

  -- A formal banking, brokerage, or business 
  -- relationship established to provide for regular services, dealings, and 
  -- other financial transactions. (financialAccount ?ACCOUNT ?ORG) means that 
  -- ?ACCOUNT is a financial account opened at the FinancialCompany 
  -- ?ORG.
  fun financialAccount : El FinancialAccount -> El FinancialCompany -> Formula ;

  -- A predicate that relates an Agent to any 
  -- item of economic value owned by the Agent. Examples of financial assets 
  -- are cash, securities, accounts receivable, inventory, office equipment, a 
  -- house, a car, and other property.
  fun financialAsset : El Agent -> El Object -> Formula ;

  -- (formerName ?NAME ?THING) means that the 
  -- string ?NAME is a name formerly used for ?THING.
  fun formerName : El Entity -> El Entity -> Formula ;

  -- (holdsDuring ?T1 (friend ?H1 ?H2)) means that
  -- during time ?T1, ?H1 and ?H2 know each other, share a relationship of
  -- mutual care and concern, and probably also share some common interests.
  fun friend : El Human -> El Human -> Formula ;

  -- (gainsControl ?EVENT ?AGENT) means that during ?EVENT, ?AGENT
  -- gains control of the patient (object).
  fun gainsControl : El AchievingControl -> El Agent -> Formula ;

  -- (givenName ?STRING ?HUMAN)
  -- means that ?STRING is a name selected for ?HUMAN, usually from among
  -- many options, as opposed to a mandatory name (cf. familyName) that
  -- ?HUMAN has inherited by virtue of being born into a certain kin group,
  -- caste, or occupation.
  fun givenName : El SymbolicString -> El Human -> Formula ;

  -- (grammaticalRelation ?PHRASE ?SENTENCE) 
  -- means that the Phrase ?PHRASE has a grammatical relation to the Sentence 
  -- ?SENTENCE, i.e. it is a subject, object, main verb, etc. of the ?SENTENCE.
  fun grammaticalRelation : El Phrase -> El Sentence -> Formula ;

  -- (grandfather ?PERSON ?PARENT) means that 
  -- ?PARENT is the grandfather of ?PERSON.
  fun grandfather : El Human -> El Man -> Formula ;

  -- (grandmother ?PERSON ?PARENT) means that 
  -- ?PARENT is the grandmother of ?PERSON.
  fun grandmother : El Human -> El Woman -> Formula ;

  -- (grandparent ?YOUNGER ?OLDER) means that
  -- ?OLDER is a parent of ?YOUNGER's parent.
  fun grandparent : El Human -> El Human -> Formula ;

  -- A subrelation of member, groupMember 
  -- is used to relate a Human to a GroupOfPeople of which he/she is a 
  -- member.
  fun groupMember : El Human -> El GroupOfPeople -> Formula ;

  -- (half ?HALF ?WHOLE) means that ?HALF is one half 
  -- of ?WHOLE.
  fun half : El Object -> El Object -> Formula ;

  -- (hasExpertise ?PERSON ?FIELD) means that ?PERSON has 
  -- studied the FieldOfStudy ?FIELD and is regarded as an expert.
  fun hasExpertise : El Human -> El FieldOfStudy -> Formula ;

  -- (hasOccupation ?PERSON ?WORK) means that ?PERSON 
  -- engages in activities of the class ?WORK as a means of earning a living.
  fun hasOccupation : El Human -> Desc IntentionalProcess -> Formula ;

  -- (headquartersOfOrganization ?ORG ?AREA) 
  -- means that the Organization ?ORG is headquartered in ?AREA.
  fun headquartersOfOrganization : El Organization -> El GeopoliticalArea -> Formula ;

  -- (hopes ?AGENT ?FORMULA) means that ?AGENT hopes that 
  -- the proposition ?FORMULA will be true, i.e. he/she believes that it will 
  -- come to pass in the future and that it will be desirable for ?AGENT.
  fun hopes : El CognitiveAgent -> Formula -> Formula ;

  -- (hostileForces ?UNIT1 ?UNIT2) means that 
  -- the MilitaryUnits ?UNIT1 and ?UNIT2 are, respectively, allied with 
  -- GeopoliticalAreas that are at war with one another.
  fun hostileForces : El MilitaryUnit -> El MilitaryUnit -> Formula ;

  -- (humanCapacity ?CONSTRUCT ?NUMBER) means that the 
  -- StationaryArtifact ?CONSTRUCT, e.g. a Building or a Room, can hold a maximum 
  -- of ?NUMBER Humans without crowding.
  fun humanCapacity : El StationaryArtifact -> El PositiveInteger -> Formula ;

  -- (ideologicalAffiliationOfOrganization ?ORG ?GOV) means that one of the goals
  -- of ?ORG is to realize the FormOfGovernment ?GOV.
  fun ideologicalAffiliationOfOrganization : El Organization -> El FormOfGovernment -> Formula ;

  -- Every instance of the first argument is initially 
  -- found as part of an instance of the second argument, even though it 
  -- might lose that part later in its lifetime. While the part must initially 
  -- exist as part of a whole, this does not say that each whole necessarily initially 
  -- contains such a part. For example, a thumb must at some time have been 
  -- part of a hand, but every hand need not have a thumb, even at birth. This 
  -- is a class_level relation roughly corresponding to part.
  fun initialPart : Desc Object -> Desc Object -> Formula ;

  -- Every instance of the second argument initially 
  -- contains an instance of the first argument, even though it 
  -- might lose that part later in its lifetime. Every normal human starts life with an
  -- appendix for example. While the whole must initially 
  -- contain such a part, this does not say that each part necessarily initially 
  -- exists as part of such a whole. This is a class_level relation roughly 
  -- corresponding to part.
  fun initiallyContainsPart : Desc Object -> Desc Object -> Formula;

  -- (intelligenceQuotient ?PERSON ?NUMBER) means that ?NUMBER is the I.Q. of ?PERSON. 
  -- The I.Q. of a person is the ratio of their mental age (determined by a standardized test) 
  -- divided by their chronological age, multiplied by 100.
  fun intelligenceQuotient : El Human -> El RationalNumber -> Formula ;

  -- (inventory ?CBO ?COLLECTION) means that 
  -- the ContentBearingObject ?CBO contains a list or enumeration of the 
  -- members of the Collection ?COLLECTION.
  fun inventory : El ContentBearingObject -> El Collection -> Formula ;

  -- (lacks ?AGENT ?OBJECT) means that ?AGENT needs 
  -- ?OBJECT and it is not currently the case that ?AGENT possesses ?OBJECT.
  fun lacks : El CognitiveAgent -> El Physical -> Formula ;

  -- (landlord ?PERSON ?UNIT) means that ?PERSON is a 
  -- landlord of the Residence ?UNIT, i.e. he or she owns ?UNIT and is renting 
  -- the unit to someone else.
  fun landlord : El Agent -> El PermanentResidence -> Formula ;

  -- (holdsDuring ?T1 (legalGuardian ?H1 ?H2)) means that during the time ?T1,
  -- ?H2 has legal authority over ?H1, and is responsible for looking after ?H1's interests.
  fun legalGuardian : El Human -> El Human -> Formula ;

  -- (localLongName ?NAME ?THING) means that the string ?NAME is the long form of the name
  -- used for ?THING in its local area or language.
  fun localLongName : El SymbolicString -> El Entity -> Formula ;

  -- (localShortName ?NAME ?THING) means that the string ?NAME is the short form of the name
  -- used for ?THING in its local area or language.
  fun localShortName : El SymbolicString -> El Entity -> Formula ;

  -- (locatedAtTime ?OBJ ?TIME ?PLACE) means
  -- that during the time specified by ?TIME, ?OBJ was in the location
  -- specified by ?PLACE.
  fun locatedAtTime : El Object -> El TimePosition -> El Object -> Formula ;

  -- (losesControl ?EVENT ?AGENT) means that during ?EVENT, ?AGENT
  -- loses physical control of the controlled object.
  fun losesControl : El ChangeOfControl -> El Agent -> Formula ;

  -- The amount by which the cost of an investment or 
  -- business operation exceeds its return, i.e. the negative quantity left 
  -- after subtracting for all expenses.
  fun loss : El FinancialTransaction -> El CurrencyMeasure -> Formula;

  -- (measurementReading ?DEVICE ?QUANTITY) 
  -- means that ?QUANTITY is a reading of the MeasuringDevice ?DEVICE, e.g. if 
  -- ?THERMOMETER is a Thermometer, (measurementReading ?THERMOMETER 
  -- (MeasureFn 42 CelsiusDegree)) would mean that ?THERMOMETER registers 42 
  -- degrees Celsius.
  fun measurementReading : El MeasuringDevice -> El ConstantQuantity -> Formula ;

  -- (meatOfAnimal ?MEATCLASS ?ANIMALCLASS) states
  -- that ?MEATCLASS was once part of the class of Animal ?ANIMALCLASS)
  fun meatOfAnimal : Desc Meat -> Desc Animal -> Formula ;

  -- A relation between a Human and a 
  -- CareOrganization that treats the patient.
  fun medicalPatient : El Human -> El CareOrganization -> Formula ;

  -- (memberAtTime ?MEMBER ?COLLECTION
  -- ?TIME) means that during the time period denoted by ?TIME,
  -- ?MEMBER is a member of ?COLLECTION.
  fun memberAtTime : El SelfConnectedObject -> El Collection -> El TimePosition -> Formula ;

  -- (memberCount ?ORG ?NUMBER) means that there 
  -- is a total ?NUMBER of members in the Collection ?ORG.
  fun memberCount : El Collection -> El Integer -> Formula ;

  -- (memberType ?GROUP ?TYPE) means that all 
  -- the members of the Collection ?GROUP belong to the SetOrClass 
  -- ?TYPE.
  fun memberType : El Collection -> El SetOrClass -> Formula ;

  -- (memberTypeCount ?GROUP ?TYPE ?NUMBER) means that the 
  -- Collection ?GROUP has ?NUMBER members of the kind ?TYPE.
  fun memberTypeCount : El Collection -> El SetOrClass -> El NonnegativeInteger -> Formula ;

  -- (middleName ?CHAR ?INDIV) means that the 
  -- SymbolicString ?CHAR contains the middle name of the Human ?INDIV.
  fun middleName : El SymbolicString -> El Human -> Formula ;

  -- (monetaryWage ?ORG ?PERSON ?TIME ?MONEY) means 
  -- that the Organization employs ?PERSON and pays him/her the amount of money 
  -- ?MONEY per TimeDuration ?TIME.
  fun monetaryWage : El Organization -> El Human -> El TimeDuration -> El CurrencyMeasure -> Formula ;

  -- (most ?MOST ?WHOLE) means that ?MOST is a part 
  -- of ?WHOLE that is greater than half of ?WHOLE.
  fun most : El Object -> El Object -> Formula ;

  -- (moves ?MOTION ?OBJECT) means that during
  -- the Motion event ?MOTION, ?OBJECT moves. This does not
  -- necessarily imply that the location of ?OBJECT changes during
  -- ?MOTION. See also changesLocation and Translocation.
  fun moves : El Motion -> El Object -> Formula ;

  -- (mutualStranger ?H1 ?H2) means that ?H1
  -- and ?H2 have not met each other and do not know each other. Statements
  -- made with this predicate should be temporally specified with
  -- holdsDuring. See also the weaker, non_symmetric version of this
  -- predicate, stranger.
  fun mutualStranger : El Human -> El Human -> Formula ;

  -- (neighbor ?PERSON1 ?PERSON2) means that ?PERSON1 is 
  -- a neighbor of ?PERSON2, i.e. ?PERSON1 and ?PERSON2 have their homes Near 
  -- one another.
  fun neighbor : El Human -> El Human -> Formula ;

  -- (nephew ?NEPHEW ?PERSON) means that ?NEPHEW is 
  -- the son of a sibling of ?PERSON.
  fun nephew : El Man -> El Human -> Formula ;

  -- (niece ?NIECE ?PERSON) means that ?NIECE is 
  -- the daughter of a sibling of ?PERSON.
  fun niece : El Woman -> El Human -> Formula ;

  -- (occupation ?PERSON ?TYPE) means that the occupation 
  -- of ?PERSON is ?TYPE. This predicate is most often used in combination with the 
  -- function OccupationFn, e.g. (occupation PoliceOfficerWilkins (OccupationFn 
  -- LawEnforcement)).
  fun occupation : El Human -> El FinancialTransaction -> Formula ;

  -- (older ?OBJ1 ?OBJ2) means that ?OBJ1 is older than 
  -- ?OBJ2, i.e. the age of ?OBJ1 is greaterThan the age of ?OBJ2.
  fun older : El Object -> El Object -> Formula ;

  -- (onboard ?OBJ ?VEHICLE) means that the 
  -- SelfConnectedObject ?OBJ is inside the Vehicle ?VEHICLE.
  fun onboard : El SelfConnectedObject -> El Vehicle -> Formula ;

  -- (operator ?OBJECT ?AGENT) means that ?AGENT 
  -- determines how ?OBJECT is used, either by directly or indirectly operating 
  -- it.
  fun operator : El Object -> El Agent -> Formula ;

  -- (parasite ?ORGANISM1 ?ORGANISM2) means that there 
  -- is a parasitic relationship between ?ORGANISM1 and ?ORGANISM2, i.e. ?ORGANISM1 
  -- inhabits and obtains nourishment from ?ORGANISM2 in such a way that 
  -- ?ORGANISM2 is injured.
  fun parasite : El Organism -> El Organism -> Formula ;

  -- (pathInSystem ?PATH ?SYSTEM) means that 
  -- the Physical thing ?PATH consists of one or more connected routes in 
  -- the PhysicalSystem ?SYSTEM.
  fun pathInSystem : El Transitway -> El TransitSystem -> Formula ;

  -- The relation of receiving medical care 
  -- from a recognized medical practitioner. (patientMedical ?PATIENT 
  -- ?DOCTOR) means that ?PATIENT is the patient of ?DOCTOR. Note that 
  -- argument type restriction on the second argument is CognitiveAgent 
  -- to allow for cases where someone is the patient of an Organization, 
  -- viz. a CareOrganization.
  fun patientMedical : El Human -> El CognitiveAgent -> Formula ;

  -- (plaintiff ?ACTION ?AGENT) means that ?AGENT 
  -- is responsible for initiating the LegalAction ?ACTION.
  fun plaintiff : El LegalAction -> El CognitiveAgent -> Formula ;

  -- (postalBoxNumber ?NUMBER ?ADDRESS) means 
  -- that the post office box ?NUMBER is part of the address ?ADDRESS.
  fun postalBoxNumber : El PositiveInteger -> El Address -> Formula ;

  -- (postalCode ?NUMBER ?ADDRESS) means that the 
  -- the postal code, e.g. zip code, ?NUMBER is part of the address ?ADDRESS.
  fun postalCode : El PositiveInteger -> El Address -> Formula ;

  -- (potentialOfHydrogen ?SOLUTION ?NUMBER) 
  -- means that the Solution ?SOLUTION has a pH value of ?NUMBER. The ph varies 
  -- between 0 and 14, and it is a measure of the acidity or alkalinity of ?SOLUTION. 
  -- More precisely, and it is the logarithm of the reciprocal of the quantity of 
  -- AtomGrams of Hydrogen ions.
  fun potentialOfHydrogen : El Solution -> El RealNumber -> Formula ;

  -- (powerPlant ?GENERATOR ?THING) means that 
  -- the Device ?GENERATOR is the power_producing component of the Artifact 
  -- ?THING which provides the energy for its operation.
  fun powerPlant : El Device -> El Artifact -> Formula ;

  -- (protonNumber ?SUBSTANCE ?NUMBER) means that 
  -- the PureSubstance ?SUBSTANCE has the number of Protons ?NUMBER.
  fun protonNumber : El PureSubstance -> El PositiveInteger -> Formula ;

  -- (quarter ?QUART ?WHOLE) means that ?QUART is a 
  -- quarter of ?WHOLE.
  fun quarter : El Object -> El Object -> Formula ;

  -- (reactant ?PROCESS ?SUBSTANCE) means that ?SUBSTANCE 
  -- is a chemical reactant in the chemical reaction ?PROCESS, i.e. ?SUBSTANCE is 
  -- present at the beginning of the chemical reaction ?PROCESS.
  fun reactant : El ChemicalProcess -> El Substance -> Formula ;

  -- (reagent ?PROCESS ?SUBSTANCE) means that ?SUBSTANCE 
  -- is a chemical agent in the chemical reaction ?PROCESS.
  fun reagent : El ChemicalProcess -> El Substance -> Formula ;

  -- (registeredItem ?DOCUMENT ?ITEM) means 
  -- that the Text ?DOCUMENT contains an official record of the Physical 
  -- thing ?ITEM. The registered item could be an object or an event, e.g., 
  -- an automobile, a ship, a marriage, an adoption.
  fun registeredItem : El Text -> El Physical -> Formula ;

  -- (religiousAffiliationOfOrganization ?ORG ?BELIEF) means
  -- that one of the goals of ?ORG is to advance the religious teachings 
  -- of the BeliefGroup ?BELIEF.
  fun religiousAffiliationOfOrganization : El Organization -> El BeliefGroup -> Formula ;

  -- (routeInSystem ?PART ?SYSTEM) means that 
  -- the Transitway ?PART is an established route of the 
  -- TransportationSystem ?SYSTEM.
  fun routeInSystem : El Transitway -> El TransitSystem -> Formula ;

  -- (secretesSubstance ?OBJ ?STUFF) means 
  -- that the subclass of OrganicObject (either Organism or BodyPart) 
  -- ?OBJ produces the subclass of Substance ?STUFF.
  fun secretesSubstance : Desc OrganicObject -> Desc NaturalSubstance -> Formula ;

  -- (sententialObject ?OBJECT ?SENTENCE) means that the NounPhrase ?OBJECT is 
  -- the object of the Sentence ?SENTENCE.
  fun sententialObject : El NounPhrase -> El Sentence -> Formula ;

  -- (sententialSubject ?SUBJECT ?SENTENCE) means that the NounPhrase ?SUBJECT is
  -- the subject of the Sentence ?SENTENCE.
  fun sententialSubject : El NounPhrase -> El Sentence -> Formula ;

  -- (serviceProvider ?EVENT ?AGENT)
  -- means that ?AGENT is the supplier of the service provided in ?EVENT.
  fun serviceProvider : El ServiceProcess -> El CognitiveAgent -> Formula ;

  -- (serviceRecipient ?EVENT ?AGENT) means that ?AGENT is the
  -- receiver of the service provided in ?EVENT.
  fun serviceRecipient : El ServiceProcess -> El CognitiveAgent -> Formula ;

  -- (sideOfFigure ?SIDE ?FIGURE) means that the 
  -- OneDimensionalFigure ?POINT is a side of the GeometricFigure ?FIGURE.
  fun sideOfFigure : El OneDimensionalFigure -> El GeometricFigure -> Formula ;

  -- (sliceOfFigure ?SLICE ?FIGURE) indicates
  -- that ?SLICE is a 2_d section of the 3_d figure ?FIGURE. Or, more 
  -- formally, ?SLICE is 2_d figure formed by the intersection of a plane
  -- with the 3_d figure ?FIGURE.
  fun sliceOfFigure : El TwoDimensionalObject -> El CorpuscularObject -> Formula ;

  -- A relation between a Process of 
  -- MusicalTone and the fundamental frequency of that tone.
  fun soundFrequency : El MusicalTone -> El FunctionQuantity -> Formula ;

  -- (speaksLanguage ?AGENT ?LANGUAGE) means that the SentientAgent ?AGENT is
  -- capable of understanding and/or generating the Language ?LANGUAGE.
  fun speaksLanguage : El SentientAgent -> El Language -> Formula ;

  -- (stepfather ?PERSON ?FATHER) means that ?FATHER 
  -- is the stepfather of ?PERSON, i.e. ?FATHER is the spouse of the mother 
  -- of ?PERSON, without also being the father of ?PERSON.
  fun stepfather : El Human -> El Man -> Formula ;

  -- (stepmother ?PERSON ?MOTHER) means that ?MOTHER 
  -- is the stepmother of ?PERSON, i.e. ?MOTHER is the spouse of the father 
  -- of ?PERSON, without also being the mother of ?PERSON.
  fun stepmother : El Human -> El Woman -> Formula ;

  -- (stockHolder ?Stock ?Agent) means that 
  -- ?Agent possesses the Stock ?Stock.
  fun stockHolder : El Stock -> El CognitiveAgent -> Formula ;

  -- (stranger ?H1 ?H2) means that ?H1 has
  -- not met ?H2, or, in other words, (not (acquaintance ?H1 ?H2)). 
  -- Statements made with stranger should be temporally
  -- specified with holdsDuring. Note that stranger is not
  -- symmetric, meaning that ?H2 might know ?H1. For the symmetric
  -- version, see mutualStranger.
  fun stranger : El Human -> El Human -> Formula ;

  -- (streetAddress ?STREET ?ADDRESS) means 
  -- that the Roadway ?STREET is part of the address ?ADDRESS.
  fun streetAddress : El Roadway -> El Address -> Formula ;

  -- (streetNumber ?BUILDING ?ADDRESS) means 
  -- that the Building ?BUILDING is part of the address ?ADDRESS.
  fun streetNumber : El Building -> El Address -> Formula ;

  -- (student ?ORG ?AGENT) means that ?AGENT is enrolled 
  -- in the EducationalOrganization ?ORG.
  fun student : El EducationalOrganization -> El CognitiveAgent -> Formula ;

  -- (subField ?FIELD1 ?FIELD2) means that ?FIELD1 is a proper 
  -- part of the FieldOfStudy ?FIELD2. For example, Physiology is a subField of 
  -- Biology.
  fun subField : El FieldOfStudy -> El FieldOfStudy -> Formula ;

  -- (subordinateInOrganization ?ORG ?PERSON1 ?PERSON2) means that 
  -- in the Organization ?ORG, ?PERSON1 is subordinate to ?PERSON2.
  fun subordinateInOrganization : El Organization -> El Human -> El Human -> Formula ;

  -- (subordinatePosition ?ORG ?SUB ?SUPER) means that in 
  -- the Organization ?ORG, the holder of role ?SUB is subordinate to 
  -- the holder of role ?SUPER.
  fun subordinatePosition : El Organization -> El Position -> El Position -> Formula ;

  -- (tangent ?LINE ?CIRCLE) means that the straight line 
  -- ?LINE is tangent to the figure ?CIRCLE, i.e. ?LINE touches ?CIRCLE without 
  -- intersecting it.
  fun tangent : El OneDimensionalFigure -> El TwoDimensionalObject -> Formula ;

  -- This relation identifies the patient in the event that is the object of the attack.
  fun targetInAttack : El Process -> El Object -> Formula ;

  -- (teacher ?ORG ?AGENT) means that ?AGENT is a teacher at the EducationalOrganization ?ORG.
  fun teacher : El EducationalOrganization -> El CognitiveAgent -> Formula ;

  -- (telephoneNumber ?NUMBER ?AGENT) means 
  -- that ?NUMBER is a telephone number at which ?AGENT can be regularly contacted.
  fun telephoneNumber : El SymbolicString -> El Agent -> Formula ;

  -- (tenant ?PERSON ?UNIT) means that ?PERSON is a tenant of the Residence ?UNIT, 
  -- i.e. he or she is renting the unit.
  fun tenant : El Agent -> El Residence -> Formula ;

  -- (third ?THIRD ?WHOLE) means that ?THIRD is one third of ?WHOLE.
  fun third : El Object -> El Object -> Formula ;

  -- A binary predicate used to indicate the title of a ContentBearingPhysical. Note that the
  -- second argument type restriction is a subclass, rather than an
  -- instance, of ContentBearingPhysical. Thus, the title
  -- Murder_on_the_Orient_Express corresponds to a large class of Books,
  -- and not just to a single copy of the book.
  fun titles : El SymbolicString -> El ContentBearingPhysical -> Formula ;

  -- (transported ?EVENT ?OBJ) means that ?OBJ is transported
  -- (carried/moved to a different physical location) in the Transportation ?EVENT.
  fun transported : El Transportation -> El Object -> Formula ;

  -- An instance of the first argument is typically 
  -- found as part of an instance of the second argument. This is a 
  -- class_level relation roughly corresponding to part. Note that this does 
  -- not imply that such wholes typically have such parts.
  fun typicalPart : Desc Object -> Desc Object -> Formula ;

  -- An instance of the second argument typically 
  -- contains an instance of the first argument. This is a 
  -- class_level relation roughly corresponding to part. Note that this does 
  -- not imply that such parts typically have such wholes.
  fun typicallyContainsPart : Desc Object -> Desc Object -> Formula ;

  -- (uncle ?UNCLE ?PERSON) means that ?UNCLE is 
  -- the brother of a parent of ?PERSON.
  fun uncle : El Man -> El Human -> Formula ;

  -- (unitNumber ?UNIT ?ADDRESS) means that the 
  -- StationaryArtifact ?UNIT is part of the address ?ADDRESS.
  fun unitNumber : El StationaryArtifact -> El Address -> Formula ;

  -- (wavelength ?RADIATION ?MEASURE) means that the 
  -- instance of radiation, ?RADIATION, has an average wavelength of ?MEASURE.
  fun wavelength : El Radiating -> El LengthMeasure -> Formula ;

  -- (yearOfFounding ?ORG ?NUMBER) means that the Organization ?ORG
  -- was founded in the year expressed in ?NUMBER.
  fun yearOfFounding : El Organization -> El Integer -> Formula ;

}
