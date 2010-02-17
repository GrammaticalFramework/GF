abstract Geography = open Merge, Mid_level_ontology, Transportation in {




fun AcidRainIssue : Ind EnvironmentalIssue ;

--  AcidRainfall is the subclass of 
-- Raining in which the precipitate contains harmful amounts of 
-- sulfur dioxide or nitrogen oxide. The standard for acid rain 
-- is below 5.6 pH.
fun AcidRainfall : Class ;
fun AcidRainfall_Class : SubClass AcidRainfall WeatherProcess ;

-- Acidification is the process of 
-- lowering soil and water pH due to acid rain or other types of 
-- acid deposition. Potential harmful effects include killing 
-- freshwater fish and plants.
fun Acidification : Class ;
fun Acidification_Class : SubClass Acidification Combining ;

fun AcidificationIssue : Ind EnvironmentalIssue ;

-- AerosolParticulate is a 
-- Substance that includes aerosol_dispersed particles 
-- that are mixed with air, gas, or smoke. A form of Pollution.
fun AerosolParticulate : Class ;
fun AerosolParticulate_Class : SubClass AerosolParticulate Substance ;

fun AerosolParticulateIssue : Ind EnvironmentalIssue ;

-- Afforestation is the process of 
-- planting trees and plants on spaces that are either empty or in 
-- agricultural use.
fun Afforestation : Class ;
fun Afforestation_Class : SubClass Afforestation Planting ;

fun Africa : Ind Continent ;

-- Aftershock is the subclass of EarthTremors 
-- that occur after the main tremor(s) of an Earthquake.
fun Aftershock : Class ;
fun Aftershock_Class : SubClass Aftershock EarthTremor ;

-- Agreement is the class of 
-- Propositions that express the contents of agreements 
-- entered into by CognitiveAgents. Agreement includes 
-- treaties, contracts, purchase orders, pledges, marriage 
-- vows, etc. An Agreement may be written down in a document 
-- or other ContentBearingObject.
fun Agreement : Class ;
fun Agreement_Class : SubClass Agreement Proposition ;

-- (AgreementOrganizationFn ?AGR) 
-- denotes the official Organization established by the Agreement ?AGR 
-- to administer or enforce the terms of that agreement.
fun AgreementOrganizationFn : El Agreement -> Ind Organization ;


fun AgriculturalChemicalsIssue : Ind EnvironmentalIssue ;

fun AgriculturalExpansionIssue : Ind EnvironmentalIssue ;

-- Agriculture is a class of Processes 
-- in which land, plants, or animals are cultivated in order to produce 
-- food or other organic products.
fun Agriculture : Class ;
fun Agriculture_Class : SubClass Agriculture Maintaining ;

-- AirPollution is the subclass of 
-- Pollution processes in which air is contaminated.
fun AirPollution : Class ;
fun AirPollution_Class : SubClass AirPollution Pollution ;

fun AirPollutionConvention : Ind Agreement ;

fun AirPollutionIssue : Ind PollutionIssue ;

fun AirPollution_NitrogenOxidesProtocol : Ind Agreement ;

fun AirPollution_PeristentOrganicPollutantsProtocol : Ind Agreement ;

fun AirPollution_Sulphur85Protocol : Ind Agreement ;

fun AirPollution_Sulphur94Protocol : Ind Agreement ;

fun AirPollution_VolatileOrganicCompoundsProtocol : Ind Agreement ;

-- AirStream is the class of FlowRegions that consist of air.
fun AirStream : Class ;
fun AirStream_Class : SubClass AirStream (both Air FlowRegion) ;


-- The area below the AntarcticCircle, which is
-- 66 degrees 33 minutes and 38 seconds south latitude. It is dark
-- for at least 24 hours at some point during the year, with an
-- increasing period of yearly continuous darkness as one gets closer
-- to the South Pole.
fun AntarcticArea : Class ;
fun AntarcticArea_Class : SubClass AntarcticArea LandArea ;

fun AntarcticCircumpolarCurrent : Ind WaterMotion ;

fun AntarcticSealsConvention : Ind Agreement ;

fun AntarcticTreaty : Ind Agreement ;

fun Antarctic_EnvironmentalProtocol : Ind Agreement ;

fun Antarctic_MarineLivingResourcesConvention : Ind Agreement ;

fun ArabianSea : Ind Sea ;

-- ArableLand is the subclass of 
-- LandArea that represents land in cultivation with crops that 
-- are replanted after each harvest, e.g., wheat and rice.
fun ArableLand : Class ;
fun ArableLand_Class : SubClass ArableLand LandArea ;

fun AralSea : Ind SaltLake ;

-- ArcMinute represents a UnitOfMeasure 
-- equivalent to 1/60th of an AngularDegree.
fun ArcMinute : Ind UnitOfAngularMeasure ;


-- ArcSecond represents a UnitOfMeasure 
-- equivalent to 1/60th of an ArcMinute.
fun ArcSecond : Ind UnitOfAngularMeasure ;


-- An ArchipelagicArea is a GeographicArea 
-- including an Archipelago and the surrounding WaterArea.
fun ArchipelagicArea : Class ;
fun ArchipelagicArea_Class : SubClass ArchipelagicArea GeographicArea ;

-- An Archipelago is a group of islands.
fun Archipelago : Class ;
fun Archipelago_Class : SubClass Archipelago (both Collection LandForm) ;


-- ArcticOcean represents the Arctic Ocean.
fun ArcticOcean : Ind Ocean ;


-- The area above the Artic Circle, which is
-- 66 degrees 33 minutes and 38 seconds north latitude. It is dark
-- for at least 24 hours at some point during the year, with an
-- increasing period of yearly continuous darkness as one gets closer
-- to the North Pole.
fun ArcticRegion : Class ;


-- AreaOfConcern is a subclass of 
-- Attributes that represent and classify the kinds of interests that 
-- agents have.
fun AreaOfConcern : Class ;
fun AreaOfConcern_Class : SubClass AreaOfConcern RelationalAttribute ;

-- AridClimateZone is the 
-- class of regions in which the climate is characterized by 
-- a distinct dry season. Annual rate of moisture evaporation 
-- exceeds annual rate of precipitation. This is Class B in the 
-- Koeppen climate system.
fun AridClimateZone : Class ;
fun AridClimateZone_Class : SubClass AridClimateZone ClimateZone ;

-- Asbestos is a Mineral.
fun Asbestos : Class ;
fun Asbestos_Class : SubClass Asbestos Mineral ;

fun AsbestosDisposalIssue : Ind EnvironmentalIssue ;

fun Asia : Ind Continent ;

-- AtlanticOcean represents the Atlantic 
-- Ocean.
fun AtlanticOcean : Ind Ocean ;


-- Atmosphere is a mixture of gases 
-- surrounding any celestial object that has a gravitational field 
-- strong enough to prevent the gases from escaping.
fun Atmosphere : Class ;
fun Atmosphere_Class : SubClass Atmosphere Region ;

fun AtmosphericHazing : Class ;
fun AtmosphericHazing_Class : SubClass AtmosphericHazing WeatherProcess ;

-- Atoll is the class of CoralReefs which surround 
-- a lagoon.
fun Atoll : Class ;
fun Atoll_Class : SubClass Atoll CoralReef ;

-- AvalancheProcess is a subclass of 
-- Motion that represents events in which a loosened mass of snow, ice, 
-- rock, or earth rapidly descends a steep slope, with a destructive force.
fun AvalancheProcess : Class ;
fun AvalancheProcess_Class : SubClass AvalancheProcess Impelling ;

fun BalticSea : Ind Sea ;

-- Barite is Barium Sulfate occurring as a mineral.
fun Barite : Class ;
fun Barite_Class : SubClass Barite (both CompoundSubstance Mineral) ;


-- A Basin is an area of land enclosed or partially 
-- enclosed by higher land.
fun Basin : Class ;
fun Basin_Class : SubClass Basin LandForm ;

-- Bay is the class of extensions of a body of water 
-- (salt or fresh) that reach into the land, usually smaller than a 
-- Gulf.
fun Bay : Class ;
fun Bay_Class : SubClass Bay Inlet ;

-- BeaufortNumber is the
-- Attribute for indicating wind force, according to
-- classifications based on observable weather conditions and later
-- related to wind speed ranges.
fun BeaufortNumber : Class ;
fun BeaufortNumber_Class : SubClass BeaufortNumber RelationalAttribute ;

fun BeaufortNumberEight : Ind BeaufortNumber ;

fun BeaufortNumberEleven : Ind BeaufortNumber ;

fun BeaufortNumberFive : Ind BeaufortNumber ;

fun BeaufortNumberFour : Ind BeaufortNumber ;

fun BeaufortNumberNine : Ind BeaufortNumber ;

fun BeaufortNumberOne : Ind BeaufortNumber ;

fun BeaufortNumberSeven : Ind BeaufortNumber ;

fun BeaufortNumberSix : Ind BeaufortNumber ;

fun BeaufortNumberTen : Ind BeaufortNumber ;

fun BeaufortNumberThree : Ind BeaufortNumber ;

fun BeaufortNumberTwelve : Ind BeaufortNumber ;

fun BeaufortNumberTwo : Ind BeaufortNumber ;

fun BeringSea : Ind Sea ;

-- BiodiversityAttribute is the 
-- class of Attributes that describe the level of biodiversity present 
-- in a GeographicArea or Ecosystem.
fun BiodiversityAttribute : Class ;
fun BiodiversityAttribute_Class : SubClass BiodiversityAttribute InternalAttribute ;

fun BiodiversityConvention : Ind Agreement ;

fun BiodiversityIssue : Class ;
fun BiodiversityIssue_Class : SubClass BiodiversityIssue EnvironmentalIssue ;
-- Biome is the class of GeographicAreas 
-- representing major kinds of ecological communities, that is, areas in 
-- which certain kinds of plants, animals, weather, and terrain interact 
-- to produce and support a distinctive ecosystem.
fun Biome : Class ;
fun Biome_Class : SubClass Biome Ecosystem ;

fun BlackSea : Ind Sea ;

fun Blizzard : Class ;
fun Blizzard_Class : SubClass Blizzard WeatherProcess ;
fun BodyOfWater_WaterArea : SubClass BodyOfWater WaterArea ;

-- (BorderFn ?AREA1 ?AREA2) denotes the 
-- border area where the GeographicAreas ?AREA1 and ?AREA2 meet.
fun BorderFn : El GeographicArea -> El GeographicArea -> Ind GeographicArea ;


fun BorealForest : Class ;
fun BorealForest_Class : SubClass BorealForest (both Biome Forest) ;

-- BrownCoal is a soft Coal harder than 
-- peat and softer than bituminous coal. Also called lignite, it is 
-- brownish in color.
fun BrownCoal : Class ;
fun BrownCoal_Class : SubClass BrownCoal Coal ;

-- A Butte is an Upland raised sharply from the 
-- surrounding region. Smaller in area than a Mesa.
fun Butte : Class ;
fun Butte_Class : SubClass Butte (both LandForm UplandArea) ;


-- Canal is the subclass of navigable Waterways 
-- flowing through an artificial course. Typically, a canal is a 
-- Transitway connecting two bodies of water.
fun Canal : Class ;
fun Canal_Class : SubClass Canal (both StationaryArtifact Waterway) ;


-- A CanalStructure is the constructed 
-- framework, including Locks, that contains the waters of a Canal.
fun CanalStructure : Class ;
fun CanalStructure_Class : SubClass CanalStructure StationaryArtifact ;

-- CanopiedVegetation describes the 
-- density of vegetation in a RainForest or Jungle.
fun CanopiedVegetation : Ind Attribute ;


-- A Canyon is a narrow valley with steep sides, usually 
-- created by erosion.
fun Canyon : Class ;
fun Canyon_Class : SubClass Canyon LandForm ;

-- A Cape is a piece of land projecting into a body of water.
fun Cape : Class ;
fun Cape_Class : SubClass Cape LandForm ;

-- CarbonCycle is the class of 
-- GeologicalProcesses in which carbon in various forms is passed 
-- between air, water, earth, and the biosphere.
fun CarbonCycle : Class ;
fun CarbonCycle_Class : SubClass CarbonCycle GeologicalProcess ;

fun CarbonDioxideEmission : Class ;
fun CarbonDioxideEmission_Class : SubClass CarbonDioxideEmission Separating ;
fun CaribbeanRegion : Ind GeographicArea ;

fun CaribbeanSea : Ind Sea ;

fun CaspianSea : Ind SaltLake ;

-- A CaveMatrix is the framework of earth or 
-- rock in which a Cave is embedded.
fun CaveMatrix : Class ;
fun CaveMatrix_Class : SubClass CaveMatrix LandForm ;

fun Cave_Hole : SubClass Cave Hole ;

fun CentralAfrica : Ind GeographicArea ;

fun CentralAsia : Ind GeographicArea ;

fun CentralEurope : Ind GeographicArea ;

fun CentralSouthAmerica : Ind GeographicArea ;

fun Channel_BodyOfWater : SubClass Channel BodyOfWater ;

fun ChinookWind : Class ;
fun ChinookWind_Class : SubClass ChinookWind WindProcess ;
-- A mineral that consists of an oxide of
-- iron and chromium.
fun Chromite : Class ;
fun Chromite_Class : SubClass Chromite (both CompoundSubstance Mineral) ;


-- Fine_grained soil consisting of mineral particles, not 
-- necessarily clay minerals, that are less than 0.002 mm in their maximum dimension.
fun Clay : Class ;
fun Clay_Class : SubClass Clay Soil ;

-- ClearWeather represents a condition 
-- in which less than 30% of the sky is covered with clouds.
fun ClearWeather : Class ;
fun ClearWeather_Class : SubClass ClearWeather WeatherProcess ;

-- A Cliff is any high, very_steep_to_perpendicular 
-- or overhanging face of rock or earth, a precipice.
fun Cliff : Class ;
fun Cliff_Class : SubClass Cliff SlopedArea ;

fun ClimateChangeConvention : Ind Agreement ;

fun ClimateChangeIssue : Ind EnvironmentalIssue ;

fun ClimateChange_KyotoProtocol : Ind Agreement ;

-- &ClimateZone is a subclass of GeographicArea in which regions 
-- are classified according to their long_term weather conditions. 
-- The subclasses of ClimateZone are based on the Koeppen Climate 
-- Classification system. In the Koeppen system, climate zones are 
-- distinguished based on temperatures and rainfall.
fun ClimateZone : Class ;
fun ClimateZone_Class : SubClass ClimateZone GeographicArea ;

-- Coal is a black or brownish black solid combustible 
-- substance formed by the partial decomposition of vegetable matter without 
-- free access of air and under the influence of moisture and often increased 
-- pressure and temperature. Coal is a sedimentary rock containing a high 
-- proportion of carbon.
fun Coal : Class ;
fun Coal_Class : SubClass Coal (both FossilFuel (both Mineral Rock)) ;


fun CoastalDegradation : Ind EnvironmentalIssue ;

fun CoastalFlooding : Class ;
fun CoastalFlooding_Class : SubClass CoastalFlooding Flooding ;
fun CoastalMarinePollutionIssue : Ind EnvironmentalIssue ;

-- CoastalPlain is the class of broad plains 
-- areas adjacent to a Sea or Ocean. A coastal plain includes a narrower 
-- ShoreArea adjacent to a body of water.
fun CoastalPlain : Class ;
fun CoastalPlain_Class : SubClass CoastalPlain Plain ;

-- ColdClimateZone is the subclass 
-- of ClimateZone that is characterized by a warmest month with average 
-- temperature less than 10 degrees Celsius and a coldest month with 
-- average temperature less than _3 degrees Celsius. This is Koeppen climate 
-- system Type D.
fun ColdClimateZone : Class ;
fun ColdClimateZone_Class : SubClass ColdClimateZone ClimateZone ;

-- ColdDampClimateZone is the 
-- subclass of ColdClimateZone that is characterized by having more 
-- than 30 mm of precipitation in the driest month. This is subtype 
-- 'Df' in the Koeppen climate system.
fun ColdDampClimateZone : Class ;
fun ColdDampClimateZone_Class : SubClass ColdDampClimateZone ColdClimateZone ;

-- ColdFront is the class of transitional 
-- weather processes occurring between a cold air mass that is advancing 
-- upon a warm air mass.
fun ColdFront : Class ;
fun ColdFront_Class : SubClass ColdFront WeatherFront ;

-- ContinentalClimateZone is a subclass of TemperateClimateZone that is 
-- characterized by cold winters and hot summers.
fun ContinentalClimateZone : Class ;
fun ContinentalClimateZone_Class : SubClass ContinentalClimateZone TemperateClimateZone ;

-- ContinentalMargin is class of 
-- SubmergedLandAreas that are the extension of land underwater at 
-- the edge of a continent, before a drop to the sea floor. A 
-- ContinentalMargin includes the ContinentalShelf and the 
-- continental break, slope, or rise at the outer edge.
fun ContinentalMargin : Class ;
fun ContinentalMargin_Class : SubClass ContinentalMargin SubmergedLandArea ;

-- A ContinentalShelf is a natural 
-- undersea extension of land around a Continent. The shelf is a 
-- gently sloped (average less than one percent) plain that is an extension 
-- of the CoastalPlain found off the coast of most continents.
fun ContinentalShelf : Class ;
fun ContinentalShelf_Class : SubClass ContinentalShelf SubmergedLandArea ;

-- Corals are gastrovascular marine cnidarians (phylum 
-- Cnidaria, class Anthozoa) existing as small anemone_like polyps, typically 
-- forming colonies of many individuals. The group includes the important 
-- reef builders known as hermatypic corals, found in tropical oceans, and 
-- belonging to the subclass Zoantharia of order Scleractinia (formerly 
-- Madreporaria). The hermatypic corals obtain much of their nutrient 
-- requirement from symbiotic unicellular algae called zooxanthellae, and so 
-- are dependent upon growing in sunlight. As a result, these corals are 
-- usually found not far beneath the surface, although in clear waters corals 
-- can grow at depths of 60 m (200 ft). Corals breed by spawning, with all 
-- corals of the same species in a region releasing gametes simultaneously 
-- over a period of one to several nights around a full moon. (from Wikipedia)
fun Coral : Class ;
fun Coral_Class : SubClass Coral Invertebrate ;

-- CoralReef is the subclass of Reefs that are 
-- formed from living organisms that produce the limestone formations of the 
-- reef. Coral reefs include fringing reefs, barrier reefs, and Atolls.
fun CoralReef : Class ;
fun CoralReef_Class : SubClass CoralReef Reef ;

fun CoralReefDecayIssue : Ind EnvironmentalIssue ;

-- A Cove is a small part of a body of water that 
-- reaches into a coast.
fun Cove : Class ;
fun Cove_Class : SubClass Cove Inlet ;

-- Crosswind is the relative attribute of a 
-- Wind to an object when the force of the wind is applied to a lateral 
-- side of the object.
fun Crosswind : Ind Attribute ;


-- CyclonicStorm is the class of 
-- LowPressureWeatherSystems that involve a low pressure area 
-- surrounded by rapidly rotating winds, with the whole system 
-- typically moving forward at 20_30 mph.
fun CyclonicStorm : Class ;
fun CyclonicStorm_Class : SubClass CyclonicStorm (both LowPressureWeatherSystem Windstorm) ;


-- DDT (dichoro_diphenyl_trichloro_ethane) 
-- is a highly toxic insecticide also harmful to most other animal 
-- species. DDT was banned in the UnitedStates in 1972.
fun DDT : Class ;
fun DDT_Class : SubClass DDT CompoundSubstance ;

fun Dam_StationaryArtifact : SubClass Dam StationaryArtifact ;

-- (DatumFn ?place) denotes the point of MLLW (Mean Lower Low 
-- Water) used as the initial data point for a coastal or WaterArea given on a nautical 
-- chart. High and low tides are calculated with reference to this point.
fun DatumFn : El GeographicArea -> Ind LengthMeasure ;


fun DeadSea : Ind SaltLake ;

-- Defoliant is the class of substances 
-- that are used to make plants lose their leaves, typically used 
-- in agriculture or warfare. Defoliants may have detrimental 
-- environmental side effects.
fun Defoliant : Class ;
fun Defoliant_Class : SubClass Defoliant PureSubstance ;

fun Deforestation : Class ;
fun Deforestation_Class : SubClass Deforestation (both ForestDamage Removing) ;

fun DeforestationIssue : Ind EnvironmentalIssue ;

-- A Delta is a LandForm composed of silt or other 
-- alluvium, deposited at or near the mouth of a river or stream as it enters 
-- a body of relatively static water. Typically a delta is flat and fan_shaped.
fun Delta : Class ;
fun Delta_Class : SubClass Delta LandForm ;

-- DenseVegetation describes the 
-- density of vegetation in a Forest.
fun DenseVegetation : Ind Attribute ;


-- Desert is a subclass of LandAreas that are 
-- arid regions having sparse or no vegetation.
fun Desert : Class ;
fun Desert_Class : SubClass Desert LandArea ;

-- DesertClimateZone 
-- is the class of AridClimateZones characterized by 
-- sparse, desert vegetation. Koeppen system 'BW'.
fun DesertClimateZone : Class ;
fun DesertClimateZone_Class : SubClass DesertClimateZone AridClimateZone ;

-- Desertification represents the 
-- Process by which desert conditions are spread over an area.
fun Desertification : Class ;
fun Desertification_Class : SubClass Desertification WeatherProcess ;

fun DesertificationConvention : Ind Agreement ;

fun DesertificationIssue : Ind EnvironmentalIssue ;

fun DipSlipFault : Class ;
fun DipSlipFault_Class : SubClass DipSlipFault GeologicalFault ;
-- (DirectionalSubregionFn ?DIRECTION ?AREA) denotes the part 
-- of GeographicArea ?AREA that lies in ?DIRECTION from the 
-- geographic center of ?AREA. For example, 
-- (DirectionalSubregionFn Iraq North) denotes the Northern 
-- part of Iraq. Such subregions are defined purely by geographical 
-- points of reference, not by sociological ones. For example, 
-- (DirectionalSubregionFn UnitedStatesOfAmerica South) denotes 
-- the Southern half of the United States, it does not denote the 
-- American South as distinguished for historical, literary, or 
-- cultural purposes.
fun DirectionalSubregionFn : El DirectionalAttribute -> El GeographicArea -> Ind GeographicArea ;


fun DiseaseConditionsIssue : Class ;
fun DiseaseConditionsIssue_Class : SubClass DiseaseConditionsIssue EnvironmentalIssue ;
-- (DocumentFn ?PROP) denotes a class 
-- of Text objects that contain the information ?PROP.
fun DocumentFn: El Proposition -> Desc Text ;


-- Downhill is a PositionalAttribute that 
-- describes the relation between two things, one of which is located 
-- down a slope from the other.
fun Downhill : Ind PositionalAttribute ;


fun Downstream : Ind PositionalAttribute ;

-- Downwind is a PositionalAttribute that indicates relative position 
-- downwind (leeward) with respect to the direction that the Wind is 
-- blowing.
fun Downwind : Ind PositionalAttribute ;


fun Dredging : Class ;
fun Dredging_Class : SubClass Dredging Removing ;
fun DriftNetFishingIssue : Ind EnvironmentalIssue ;

fun DriftnetFishing : Class ;
fun DriftnetFishing_Class : SubClass DriftnetFishing Fishing ;
-- Drought is the subclass of WeatherProcess 
-- that represents long periods without precipitation, which is damaging 
-- to crops, livestock, and human life.
fun Drought : Class ;
fun Drought_Class : SubClass Drought WeatherProcess ;

fun DroughtIssue : Ind EnvironmentalIssue ;

-- DryWinterColdClimateZone 
-- is a subclass of ColdClimateZone that is characterized by having 
-- at least ten times as much precipitation in the wettest summer month 
-- as in the driest winter month. This is Koeppen climate system subtype 
-- 'Dw'.
fun DryWinterColdClimateZone : Class ;
fun DryWinterColdClimateZone_Class : SubClass DryWinterColdClimateZone ColdClimateZone ;

fun DustStorm : Class ;
fun DustStorm_Class : SubClass DustStorm WeatherProcess ;
-- An EarthTremor is an individual seismic 
-- event in which the earth shakes due to release of seismic pressures.
fun EarthTremor : Class ;
fun EarthTremor_Class : SubClass EarthTremor (both GeologicalProcess Tremor) ;


-- Earthquake is the class of events in 
-- which the earth shakes while its layers readjust due to tensional 
-- stresses in the surface of the earth. A single earthquake may consist 
-- of one or more EarthTremors.
fun Earthquake : Class ;
fun Earthquake_Class : SubClass Earthquake GeologicalProcess ;

-- EarthsAtmosphere is the layer of gases, 
-- a mixture of mainly oxygen and nitrogen, surrounding PlanetEarth. See 
-- also Air.
fun EarthsAtmosphere : Ind Atmosphere ;


-- EarthsMoon is the Moon of PlanetEarth.
fun EarthsMoon : Ind Moon ;


fun EasternAfrica : Ind GeographicArea ;

fun EasternAsia : Ind GeographicArea ;

fun EasternEurope : Ind GeographicArea ;

-- The half of the Earth that includes Europe, 
-- Asia, Africa, and Australia.
fun EasternHemisphere : Ind Hemisphere ;


fun EasternSouthAmerica : Ind GeographicArea ;

-- Ecosystem is a subclass of GeographicAreas 
-- considered together with their organisms and environment as a functioning 
-- whole.
fun Ecosystem : Class ;
fun Ecosystem_Class : SubClass Ecosystem GeographicArea ;

-- Effluent is a Substance 
-- that generically covers any waste matter that is released into 
-- the environment, including sewage and industrial pollutants.
fun Effluent : Class ;
fun Effluent_Class : SubClass Effluent Substance ;

fun ElNino : Class ;
fun ElNino_Class : SubClass ElNino WeatherSeason ;
-- (ElevationHighPointFn ?AREA) 
-- denotes the area within the GeographicArea ?AREA that has the 
-- highest elevation.
fun ElevationHighPointFn : El GeographicArea -> Ind GeographicArea ;


-- (ElevationLowPointFn ?AREA) 
-- denotes the area within the GeographicArea ?AREA that has the 
-- lowest elevation.
fun ElevationLowPointFn : El GeographicArea -> Ind GeographicArea ;


fun EndangeredMarineWildlifeIssue : Ind BiodiversityIssue ;

-- EndangeredSpecies is the 
-- subclass of Organism that includes plants and animals that 
-- are in danger of extinction from destruction of individuals 
-- or of habitat.
fun EndangeredSpecies : Class ;
fun EndangeredSpecies_Class : SubClass EndangeredSpecies Organism ;

fun EndangeredSpeciesConvention : Ind Agreement ;

fun EndangeredSpeciesIssue : Ind BiodiversityIssue ;

fun EnvironmentalIssue : Class ;
fun EnvironmentalIssue_Class : SubClass EnvironmentalIssue AreaOfConcern ;
fun EnvironmentalModificationConvention : Ind Agreement ;

fun EnvironmentalWaterIssue : Class ;
fun EnvironmentalWaterIssue_Class : SubClass EnvironmentalWaterIssue EnvironmentalIssue ;
-- Erosion is a wearing process on 
-- LandForms by wind, running water, ice, heat, and other processes, 
-- in which rock and soil material are removed from one area and 
-- deposited elsewhere.
fun Erosion : Class ;
fun Erosion_Class : SubClass Erosion (both GeologicalProcess Removing) ;


-- Estuary is the subclass of BodyOfWater that 
-- represents WaterAreas where a sea or ocean Tide meets a River 
-- current.
fun Estuary : Class ;
fun Estuary_Class : SubClass Estuary (both BodyOfWater (both Inlet SaltWaterArea)) ;


-- ExclusiveFishingZone is the 
-- subclass of MaritimeClaimArea including offshore areas over which a 
-- nation claims exclusive jurisdiction only for fishing purposes (cf. 
-- MaritimeExclusiveEconomicZone). Zone widths vary up to 200 miles 
-- (NM).
fun ExclusiveFishingZone : Class ;
fun ExclusiveFishingZone_Class : SubClass ExclusiveFishingZone (both MaritimeClaimArea SaltWaterArea) ;


-- (ExclusiveFishingZoneFn ?POLITY) denotes the 
-- ExclusiveFishingZone that is claimed by the 
-- GeopoliticalArea ?POLITY.
fun ExclusiveFishingZoneFn : El GeopoliticalArea -> Ind ExclusiveFishingZone ;


-- ExtendedFishingZone is the subclass of MaritimeClaimArea 
-- that includes offshore areas over which a nation claims fishing rights, 
-- beyond that nation's ExclusiveFishingZone. Zone widths vary, 
-- from as little as 12 miles (NM) up to a width of 200 miles (NM).
fun ExtendedFishingZone : Class ;
fun ExtendedFishingZone_Class : SubClass ExtendedFishingZone (both MaritimeClaimArea SaltWaterArea) ;


-- (ExtendedFishingZoneFn ?POLITY) denotes the 
-- ExtendedFishingZoneFn that is claimed by the 
-- GeopoliticalArea ?POLITY, beyond its ExclusiveFishingZone.
fun ExtendedFishingZoneFn : El GeopoliticalArea -> Ind ExtendedFishingZone ;


fun Famine : Class ;
fun Famine_Class : SubClass Famine SocialInteraction ;
fun FamineIssue : Ind EnvironmentalIssue ;

fun FarmingPracticesIssue : Ind EnvironmentalIssue ;

-- Fathom is a UnitOfMeasure used for measuring 
-- water depth. One fathom is equal to six feet.
fun Fathom : Ind UnitOfLength ;


-- FertileTerrain describes an area 
-- that has the type of soil and climate conditions needed to produce 
-- good quality crops.
fun FertileTerrain : Ind TerrainAttribute ;


-- Fire is the subclass of Combustion events in 
-- which flames are present. Fires are slower combustion processes than 
-- explosions, though some fires may include explosive episodes.
fun Fire : Class ;
fun Fire_Class : SubClass Fire Combustion ;

fun FishStockDepletionIssue : Ind EnvironmentalIssue ;

-- Fishing is the class of Processes in which 
-- Fish are hunted.
fun Fishing : Class ;
fun Fishing_Class : SubClass Fishing Hunting ;

fun FlashFlooding : Class ;
fun FlashFlooding_Class : SubClass FlashFlooding Flooding ;
-- FlatTerrain is a TerrainAttribute 
-- describing regions within which there is very little variation in 
-- altitude.
fun FlatTerrain : Ind TerrainAttribute ;


fun Flooding_WeatherProcess : SubClass Flooding WeatherProcess ;

-- (FlowFn ?FLUID) denotes the Motion process
-- associated with the constitutive pieces of the FlowRegion ?FLUID.
fun FlowFn : El FlowRegion -> Ind Motion ;


-- (FlowRegionFn ?FLOW) denotes the region 
-- in which the coherent LiquidMotion process ?FLOW is occurring.
fun FlowRegionFn : El LiquidMotion -> Ind Region ;


fun FlowRegion_Region : SubClass FlowRegion Region ;

fun Fogging : Class ;
fun Fogging_Class : SubClass Fogging WeatherProcess ;
-- Forest is the class of large LandAreas that 
-- are covered by trees and associated undergrowth, either growing wild or 
-- managed for the purpose of timber production.
fun Forest : Class ;
fun Forest_Class : SubClass Forest LandArea ;

fun ForestDamage : Class ;
fun ForestDamage_Class : SubClass ForestDamage Damaging ;
fun ForestDegradation : Ind EnvironmentalIssue ;

fun ForestFire : Class ;
fun ForestFire_Class : SubClass ForestFire (both Combustion ForestDamage) ;

fun FragileEcosystemIssue : Ind BiodiversityIssue ;

fun FreezingRain : Class ;
fun FreezingRain_Class : SubClass FreezingRain Precipitation ;
-- Freshwater is the subclass of Water 
-- that has low soluble mineral content. See also PotableWater.
fun Freshwater : Class ;
fun Freshwater_Class : SubClass Freshwater Water ;

fun FreshwaterOverutilization : Class ;
fun FreshwaterOverutilization_Class : SubClass FreshwaterOverutilization SocialInteraction ;
-- (GeographicCenterFn ?REGION) denotes the geographical center 
-- of the GeographicArea ?REGION.
fun GeographicCenterFn : El GeographicArea -> Ind GeographicArea ;


fun GeographicRegion : Class ;

-- GeologicalFault is the subclass of 
-- GeographicAreas in which there is a fracture in the Earth's crust 
-- and differential movement can occur on the two sides of the fault. 
-- Such movement results in EarthTremors and is the cause of 
-- Earthquakes.
fun GeologicalFault : Class ;
fun GeologicalFault_Class : SubClass GeologicalFault GeographicArea ;

-- GeologicallyStable is a 
-- TerrainAttribute of a GeographicArea in which the geological 
-- substructure is stable, i.e., there are no active Volcanoes, 
-- no major fault lines, no blasting or other destabilizing activity.
fun GeologicallyStable : Ind TerrainAttribute ;


fun Ghibli : Class ;
fun Ghibli_Class : SubClass Ghibli WindProcess ;
-- A Glacier is a large body of slow_moving ice. 
-- Glaciers displace soil and rock while moving over land surfaces and break 
-- apart, forming Icebergs, when they reach the sea.
fun Glacier : Class ;
fun Glacier_Class : SubClass Glacier LandForm ;

fun GrassFire : Class ;
fun GrassFire_Class : SubClass GrassFire Combustion ;
-- Grassland is the class of LandAreas 
-- where the predominant vegetation is some kind of grass.
fun Grassland : Class ;
fun Grassland_Class : SubClass Grassland (both Biome LandArea) ;


-- Gravel is small rounded stones, often mixed with sand.
fun Gravel : Class ;
fun Gravel_Class : SubClass Gravel Rock ;

fun GreatSaltLake : Ind SaltLake ;

-- GreenhouseGas is the subclass of 
-- substances that, when present in the atmosphere, trap infrared 
-- radiation and cause global warming. Greenhouse gases include 
-- carbon dioxide, hydrofluorocarbons, methane, nitrous oxide, ozone, 
-- and water vapor.
fun GreenhouseGas : Class ;
fun GreenhouseGas_Class : SubClass GreenhouseGas PureSubstance ;

fun GreenwichEnglandUK : Ind City ;

-- GroundCoverVegetation 
-- describes the density of uniform low vegetation in a field or meadow.
fun GroundCoverVegetation : Ind Attribute ;


-- Groundwater is the subclass of 
-- Water that is found in deposits in the earth.
fun Groundwater : Class ;
fun Groundwater_Class : SubClass Groundwater Water ;

fun GroundwaterPollutionIssue : Ind EnvironmentalWaterIssue ;

-- Gulf is the class of extensions of a Sea or 
-- Ocean that reach into a land mass or are partially enclosed by a 
-- LandArea. A Gulf is typically larger than a Bay.
fun Gulf : Class ;
fun Gulf_Class : SubClass Gulf (both BodyOfWater SaltWaterArea) ;


fun GulfOfAden : Ind (both Gulf SaltWaterArea) ;

fun GulfOfMexico : Ind (both Gulf SaltWaterArea) ;

fun GulfOfOman : Ind (both Gulf SaltWaterArea) ;

-- Hailing is a precipitation process 
-- in which Water falls in a Solid state with round, hard pellets.
fun Hailing : Class ;
fun Hailing_Class : SubClass Hailing Precipitation ;

fun HarmattanWind : Class ;
fun HarmattanWind_Class : SubClass HarmattanWind WindProcess ;
fun HazardousWastesConvention : Ind Agreement ;

-- Headwind is the relative attribute of a 
-- Wind to an object when the force of the wind is applied to the front 
-- of the object (FrontFn). A headwind can negatively affect the speed 
-- capability of a vehicle.
fun Headwind : Ind Attribute ;


fun HeavyRaining : Class ;
fun HeavyRaining_Class : SubClass HeavyRaining Raining ;
fun HeavySurf : Class ;
fun HeavySurf_Class : SubClass HeavySurf (both WaterMotion WeatherProcess) ;

-- Hemisphere is the class of GeographicAreas 
-- that are halves of the Earth, as traditionally divided into the Northern 
-- and Southern Hemispheres along the equator and into the Eastern and Western 
-- Hemispheres along a north_south line running 20°W and 160°E.
fun Hemisphere : Class ;
fun Hemisphere_Class : SubClass Hemisphere GeographicArea ;

fun HighBiodiversity : Ind BiodiversityAttribute ;

-- HighPressureWeatherSystem is 
-- the class of weather systems characterized by high barometricPressures. 
-- High pressure systems typically cause clear weather.
fun HighPressureWeatherSystem : Class ;
fun HighPressureWeatherSystem_Class : SubClass HighPressureWeatherSystem WeatherSystem ;

-- HighTide is the class of TidalProcesses that 
-- occur twice a day in marine waters, in which the water level rises above 
-- the mean sea level.
fun HighTide : Class ;
fun HighTide_Class : SubClass HighTide TidalProcess ;

-- HigherHighTide is the subclass of 
-- HighTide processes that occur in marine waters with a 
-- MixedTideProcess.
fun HigherHighTide : Class ;
fun HigherHighTide_Class : SubClass HigherHighTide HighTide ;

-- A Hill is a raised part of the earth's surface with 
-- sloping sides _ an old mountain which because of erosion has become shorter 
-- and more rounded.
fun Hill : Class ;
fun Hill_Class : SubClass Hill (both LandForm UplandArea) ;


-- Humus is decaying organic matter found in Soil 
-- and derived from dead animal and plant material.
fun Humus : Class ;
fun Humus_Class : SubClass Humus Mixture ;

fun Hurricane : Class ;
fun Hurricane_Class : SubClass Hurricane (both TropicalCyclone WeatherProcess) ;

fun HurricaneSeason : Class ;
fun HurricaneSeason_Class : SubClass HurricaneSeason WeatherSeason ;
-- HydropowerWaterArea 
-- is the class of WaterAreas with waterflow strength adequate 
-- for the production of hydropower.
fun HydropowerWaterArea : Class ;
fun HydropowerWaterArea_Class : SubClass HydropowerWaterArea WaterArea ;

-- An Iceberg is a large chunk of ice that has 
-- broken off from a glacier and fallen into the sea. The larger part of 
-- an Iceberg floats underwater.
fun Iceberg : Class ;
fun Iceberg_Class : SubClass Iceberg (both SelfConnectedObject Water) ;


fun Icing : Class ;
fun Icing_Class : SubClass Icing (both Freezing WeatherProcess) ;

fun IllegalWildlifeTradeIssue : Ind EnvironmentalIssue ;

fun InadequatePotableWaterIssue : Ind EnvironmentalWaterIssue ;

fun InadequateSanitationIssue : Ind EnvironmentalIssue ;

-- IndianOcean represents the Indian Ocean.
fun IndianOcean : Ind Ocean ;


fun IndigenousPeoplesPreservationIssue : Ind EnvironmentalIssue ;

-- IndustrialPollution is 
-- the subclass of Pollution characterized by pollutants that 
-- originate in industrial processes.
fun IndustrialPollution : Class ;
fun IndustrialPollution_Class : SubClass IndustrialPollution Pollution ;

fun IndustrialPollutionIssue : Ind PollutionIssue ;

-- An instance of InlandWaterSystem 
-- comprises two or more lakes or rivers, canals, or other waterways that 
-- are interconnected.
fun InlandWaterSystem : Class ;
fun InlandWaterSystem_Class : SubClass InlandWaterSystem (both Collection WaterArea) ;


-- Inlet is the class of bays or other recesses 
-- into the shore of a lake, sea, or river, includes InletPassages, which 
-- are passages leading from open water through some barrier to a bay or 
-- lagoon.
fun Inlet : Class ;
fun Inlet_Class : SubClass Inlet BodyOfWater ;

-- InletPassage is the class of water 
-- passages connecting an area of open water to a bay or lagoon, through 
-- some land barrier(s) close on either side.
fun InletPassage : Class ;
fun InletPassage_Class : SubClass InletPassage Inlet ;

-- (InnerBoundaryFn ?REGION) denotes the 
-- inner boundary of the Region ?REGION, where ?REGION has an inner and 
-- outer orientation with respect to another object.
fun InnerBoundaryFn : El Region -> Ind Region ;


-- InternationalAgreement is the 
-- subclass of Agreements which are made by and between Nations.
fun InternationalAgreement : Class ;
fun InternationalAgreement_Class : SubClass InternationalAgreement Agreement ;

-- InternationalBorder is the 
-- subclass of GeographicAreas where the areas of two Nations meet.
fun InternationalBorder : Class ;
fun InternationalBorder_Class : SubClass InternationalBorder GeographicArea ;

fun InvasiveSpeciesIssue : Ind EnvironmentalIssue ;

-- IrrigatedLand is the subclass of 
-- LandArea representing land whose water supply is artificially 
-- supplied or supplemented.
fun IrrigatedLand : Class ;
fun IrrigatedLand_Class : SubClass IrrigatedLand LandArea ;

-- Irrigating is the process of transporting 
-- and applying water to crops by artificial means.
fun Irrigating : Class ;
fun Irrigating_Class : SubClass Irrigating Motion ;

-- IrrigationChannel is the class of 
-- artificially created channels used for transporting water to agricultural 
-- fields for Irrigating crops.
fun IrrigationChannel : Class ;
fun IrrigationChannel_Class : SubClass IrrigationChannel Artifact ;

-- An Isthmus is a narrow strip of land that 
-- connects two larger land masses and is bordered on two sides by water.
fun Isthmus : Class ;
fun Isthmus_Class : SubClass Isthmus LandArea ;

-- JetStream is the class of high_velocity 
-- AirStreams that blow constantly in the upper atmosphere with constant 
-- speed and direction, though their location shifts somewhat. There are 
-- four JetStreams in EarthsAtmosphere.
fun JetStream : Class ;
fun JetStream_Class : SubClass JetStream AirStream ;

-- Jungle is a subclass of fertile LandAreas 
-- that are overgrown with tropical vegetation.
fun Jungle : Class ;
fun Jungle_Class : SubClass Jungle (both Biome LandArea) ;


fun Khamsin : Class ;
fun Khamsin_Class : SubClass Khamsin Windstorm ;
-- KnotUnitOfSpeed is a unit for measuring 
-- speed. One KnotUnitOfSpeed is equal to one NauticalMile per one 
-- HourDuration.
fun KnotUnitOfSpeed : Ind CompositeUnitOfMeasure ;


fun KokoNor : Ind SaltLake ;

-- Lake is the subclass of BodyOfWater whose 
-- instances are naturally occurring static bodies of water surrounded 
-- by land.
fun Lake : Class ;
fun Lake_Class : SubClass Lake StaticWaterArea ;

fun LakeBakhtegan : Ind SaltLake ;

fun LakeEyre : Ind SaltLake ;

fun LakeMareotis : Ind SaltLake ;

-- A LakeRegion is a GeographicArea 
-- including land surrounding one or more Lakes.
fun LakeRegion : Class ;
fun LakeRegion_Class : SubClass LakeRegion GeographicArea ;

fun LakeTorrens : Ind SaltLake ;

fun LakeWalker : Ind SaltLake ;

fun LandClearingIssue : Ind BiodiversityIssue ;

-- A LandForm is the class of geographically and/or geologically 
-- distinct areas that occur on Earth's surface, including mountains, hills, plains, valleys, 
-- deltas, and features of submerged land areas such as the ocean floor.
fun LandForm : Class ;
fun LandForm_Class : SubClass LandForm GeographicArea ;

fun LandSubsidence : Class ;
fun LandSubsidence_Class : SubClass LandSubsidence GeologicalProcess ;
-- LandlockedArea is the class of 
-- LandAreas that lack access to an Ocean or to a Waterway 
-- providing a link to the ocean.
fun LandlockedArea : Class ;
fun LandlockedArea_Class : SubClass LandlockedArea LandArea ;

-- LandlockedWater includes water 
-- areas that are surrounded by land, including salt lakes, fresh 
-- water lakes, ponds, reservoirs, and (more or less) wetlands.
fun LandlockedWater : Class ;
fun LandlockedWater_Class : SubClass LandlockedWater BodyOfWater ;

fun LandminesIssue : Ind EnvironmentalIssue ;

fun Landslide : Class ;
fun Landslide_Class : SubClass Landslide GeologicalProcess ;
-- LandslideProcess is a subclass 
-- of Motion that represents events in which a loosened mass of mud, 
-- dirt, or rock slides down a slope, by the force of gravity.
fun LandslideProcess : Class ;
fun LandslideProcess_Class : SubClass LandslideProcess Impelling ;

-- Latitude is the class of Regions, 
-- associated with areas on the Earth's surface, which are parallels 
-- measured in PlaneAngleDegrees from the Equator.
fun Latitude : Class ;
fun Latitude_Class : SubClass Latitude Region ;

-- LatitudeFn is a VariableArityRelation 
-- used to denote a parallel of latitude. Examples: 
-- (LatitudeFn North (MeasureFn 38 AngularDegree)), (LatitudeFn 
-- South (MeasureFn 23 AngularDegree) (MeasureFn 30 ArcMinute)), 
-- (LatitudeFn South (MeasureFn 60 AngularDegree) (MeasureFn 0 ArcMinute) 
-- (MeasureFn 0 ArcSecond)), (LatitudeFn North 
-- (MeasureFn 42 AngularDegree) (MeasureFn 7.89 ArcMinute)).
fun LatitudeFn : El DirectionalAttribute -> El AngleMeasure -> El AngleMeasure -> El AngleMeasure -> Ind Region ;


fun LawOfTheSeaConvention : Ind Agreement ;

-- Lichen is the class of complex thallyphytic 
-- plants made up of Alga and Fungus growing symbiotically.
fun Lichen : Class ;
fun Lichen_Class : SubClass Lichen NonFloweringPlant ;

fun LimitedFreshWaterIssue : Ind EnvironmentalWaterIssue ;

-- LittoralCurrent is the subclass of 
-- WaterCurrents that occur near a ShoreArea. Examples include 
-- TidalEbb, TidalFlow, and RipCurrents.
fun LittoralCurrent : Class ;
fun LittoralCurrent_Class : SubClass LittoralCurrent WaterCurrent ;

-- A LittoralZone is an area along the shore 
-- of a large body of water, especially an Ocean or Sea, including the area 
-- extending from the high tide mark out to a depth of 200 meters. The littoral 
-- zone is of interest for its land features, e.g., slope gradient and soil 
-- composition, including features of its SubmergedLandArea.
fun LittoralZone : Class ;
fun LittoralZone_Class : SubClass LittoralZone GeographicArea ;

-- Type of soil intermediate in texture between clay and sand, 
-- consisting of a mixture of clay, sand, gravel, silt, and organic matter.
fun Loam : Class ;
fun Loam_Class : SubClass Loam Soil ;

fun Locust : Class ;
fun Locust_Class : SubClass Locust Animal ;
-- Longitude is the class of Regions, 
-- associated with areas on the Earth's surface, which are meridians 
-- measured in PlaneAngleDegrees from the PrimeMeridian through 
-- GreenwichEnglandUK.
fun Longitude : Class ;
fun Longitude_Class : SubClass Longitude Region ;

-- (LongitudeFn ?DIRECTION @ROW) 
-- denotes a meridian of longitude. Note that LongitudeFn is 
-- a VariableArityRelation. Examples: 
-- (LongitudeFn East (MeasureFn 180 AngularDegree)), (LongitudeFn 
-- West (MeasureFn 122 AngularDegree) (MeasureFn 24 ArcMinute)), 
-- (LongitudeFn East (MeasureFn 121 AngularDegree) 
-- (MeasureFn 0 ArcMinute) (MeasureFn 15 ArcSecond)), 
-- (LongitudeFn West (MeasureFn 80 AngularDegree) 
-- (MeasureFn 6.78 ArcMinute)).
fun LongitudeFn : El DirectionalAttribute -> El AngleMeasure -> El AngleMeasure -> El AngleMeasure -> Ind GeographicArea ;


fun LossOfHabitatIssue : Ind EnvironmentalIssue ;

fun LowBiodiversity : Ind BiodiversityAttribute ;

-- LowPressureWeatherSystem is 
-- the class of weather systems characterized by low or unstable 
-- barometricPressures. Low pressure systems typically introduce 
-- unsettled weather, frequently including storms.
fun LowPressureWeatherSystem : Class ;
fun LowPressureWeatherSystem_Class : SubClass LowPressureWeatherSystem WeatherSystem ;

-- LowTerrain is terrain in which the slope 
-- is less than 3%.
fun LowTerrain : Ind TerrainAttribute ;


-- LowTide is the class of TidalProcesses that 
-- occur twice a day in marine waters, in which the water level falls below 
-- the mean sea level.
fun LowTide : Class ;
fun LowTide_Class : SubClass LowTide TidalProcess ;

-- LowerLowTide is the subclass of LowTide 
-- processes that occur in marine waters with a MixedTideProcess.
fun LowerLowTide : Class ;
fun LowerLowTide_Class : SubClass LowerLowTide LowTide ;

-- A LowlandArea is a land area lower than the surrounding region, 
-- and usually level land.
fun LowlandArea : Class ;
fun LowlandArea_Class : SubClass LowlandArea LandForm ;

fun MarineDumpingConvention : Ind Agreement ;

fun MarineLifeConservationConvention : Ind Agreement ;

-- A MaritimeClaimArea is a GeographicArea 
-- delimited by a geopolitical state's claim, under the LawOfTheSea, of rights 
-- to certain resources, activities, or jurisdiction in the claimed area. 
-- MaritimeClaimAreas can pertain to WaterAreas, SubmergedLandAreas, and Airspace.
fun MaritimeClaimArea : Class ;
fun MaritimeClaimArea_Class : SubClass MaritimeClaimArea GeographicArea ;

-- (MaritimeClaimsTerritorialSeaFn ?REGION) denotes a 
-- peripheral zones of maritime control extending outward from the Region 
-- ?REGION.
fun MaritimeClaimsTerritorialSeaFn : El Region -> Ind PerimeterArea ;


-- MaritimeContiguousZone 
-- is the subclass of MaritimeClaimArea that includes areas over 
-- which a geopolitical state may exercise some control of activities 
-- beyond the 12_mile zone of its TerritorialSea. In general, 
-- the authorized control is for preventing or punishing activities 
-- that would violate laws applying within the 12_mile zone (that is, 
-- authorization to chase and intercept). According to the LawOfTheSea, 
-- a MaritimeContiguousZone may extend up to 24 nautical miles from the coast.
fun MaritimeContiguousZone : Class ;
fun MaritimeContiguousZone_Class : SubClass MaritimeContiguousZone (both MaritimeClaimArea SaltWaterArea) ;


-- (MaritimeContiguousZoneFn ?POLITY) denotes the MaritimeContiguousZone 
-- that is claimed by the GeopoliticalArea ?POLITY.
fun MaritimeContiguousZoneFn : El GeopoliticalArea -> Ind MaritimeContiguousZone ;


-- MaritimeExclusiveEconomicZone is the subclass of MaritimeClaimArea 
-- that represents the offshore area that coastal nations can claim for 
-- fishing and other uses of the ocean water and seabed found there.
fun MaritimeExclusiveEconomicZone : Class ;
fun MaritimeExclusiveEconomicZone_Class : SubClass MaritimeExclusiveEconomicZone (both MaritimeClaimArea SaltWaterArea) ;


-- (MaritimeExclusiveEconomicZoneFn ?POLITY) denotes the 
-- MaritimeExclusiveEconomicZone that is claimed by the 
-- GeopoliticalArea ?POLITY.
fun MaritimeExclusiveEconomicZoneFn : El GeopoliticalArea -> Ind MaritimeExclusiveEconomicZone ;


fun MaritimeHazard : Class ;
fun MaritimeHazard_Class : SubClass MaritimeHazard LandForm ;
-- MaritimeShelfArea 
-- is a subclass of MaritimeClaimArea that covers SubmergedLandAreas 
-- claimed by an adjacent geopolitical area. The LawOfTheSea defines 
-- the continental shelf as extending up to 200 miles (NM) offshore and 
-- including the resources found therein. The defined claim area does not 
-- correspond exactly to a geological ContinentalShelf, but if there is one, 
-- the two areas will overlap spatially.
fun MaritimeShelfArea : Class ;
fun MaritimeShelfArea_Class : SubClass MaritimeShelfArea (both MaritimeClaimArea SubmergedLandArea) ;


-- (MaritimeShelfAreaFn ?POLITY) denotes the MaritimeShelfArea 
-- that is claimed by the GeopoliticalArea ?POLITY.
fun MaritimeShelfAreaFn : El GeopoliticalArea -> Ind MaritimeShelfArea ;


-- MediterraneanClimateZone 
-- is a subclass of TemperateClimateZone that is characterized by 
-- mild, cool, wet winters and warm dry summers. Mediterranean shores 
-- are the archetype, but the Mediterranean climate is also found elsewhere.
fun MediterraneanClimateZone : Class ;
fun MediterraneanClimateZone_Class : SubClass MediterraneanClimateZone TemperateClimateZone ;

fun MediterraneanSea : Ind Sea ;

fun MediumBiodiversity : Ind BiodiversityAttribute ;

-- A Mesa is a land formation having a relatively flat 
-- top and steep rock walls.
fun Mesa : Class ;
fun Mesa_Class : SubClass Mesa (both LandForm UplandArea) ;


-- MetallurgicalPlant is the 
-- subclass of Organization that includes metal refining and 
-- manufacturing plants. Such plants typically release extremely 
-- toxic waste which can pollute air and groundwater if not 
-- properly treated.
fun MetallurgicalPlant : Class ;
fun MetallurgicalPlant_Class : SubClass MetallurgicalPlant Organization ;

fun MiddleAmerica : Ind GeographicArea ;

-- MiddleEastRegion is a 
-- GeopoliticalArea that comprises countries of Southwestern Asia 
-- and (in some definitions) Northwestern Africa. Here this term is 
-- defined as in the CIA World Fact Book, in which the Middle East 
-- includes: Bahrain, Cyprus, the Gaza Strip, Iran, Iraq, Israel, 
-- Jordan, Kuwait, Lebanon, Oman, Qatar, Saudi Arabia, Syria, the United 
-- Arab Emirates, the West Bank, and Yemen.
fun MiddleEastRegion : Ind (both GeographicArea GeopoliticalArea) ;


-- MiddleLatitudeDesertClimateZone is the subclass of 
-- DesertClimateZone characterized by a cool dry climate 
-- typical of middle latitude deserts. This is subtype 'BWk' 
-- in the Keoppen climate system.
fun MiddleLatitudeDesertClimateZone : Class ;
fun MiddleLatitudeDesertClimateZone_Class : SubClass MiddleLatitudeDesertClimateZone DesertClimateZone ;

-- MidlatitudeContinentalClimateZone is a subclass of 
-- TemperateClimateZone that is characterized by cool winters 
-- and hot summers.
fun MidlatitudeContinentalClimateZone : Class ;
fun MidlatitudeContinentalClimateZone_Class : SubClass MidlatitudeContinentalClimateZone ClimateZone ;

fun MiningPollutionIssue : Ind EnvironmentalIssue ;

fun Mistral : Class ;
fun Mistral_Class : SubClass Mistral WindProcess ;
-- MixedTideProcess is the subclass of 
-- TidalProcesses consisting of daily cycles in which the two low and 
-- two high tides are of unequal height. In areas with this kind of 
-- pattern, the chart (based on average low water) is determined by the 
-- Mean Lower Low Water.
fun MixedTideProcess : Class ;
fun MixedTideProcess_Class : SubClass MixedTideProcess TidalProcess ;

fun Monsoon : Class ;
fun Monsoon_Class : SubClass Monsoon WeatherSeason ;
-- MonsoonClimateZone is the class 
-- of TropicalClimateZones in which there is a short dry season between 
-- rains heavy enough to keep the ground wet all through the year. This 
-- is Koeppen climate system subtype 'Aw'.
fun MonsoonClimateZone : Class ;
fun MonsoonClimateZone_Class : SubClass MonsoonClimateZone TropicalClimateZone ;

-- Moon is the class of NaturalSatellites that 
-- orbit planets or large asteroids.
fun Moon : Class ;
fun Moon_Class : SubClass Moon NaturalSatellite ;

-- A Mountain is a high, rocky LandForm, usually 
-- with steep sides and a pointed or rounded top, and higher than a Hill.
fun Mountain : Class ;
fun Mountain_Class : SubClass Mountain (both LandForm UplandArea) ;


-- A MountainRange is a row or chain of connected mountains.
fun MountainRange : Class ;
fun MountainRange_Class : SubClass MountainRange (both LandForm UplandArea) ;


-- An area of MountainousTerrain 
-- is an area of rugged terrain in which there are many mountains.
fun MountainousTerrain : Ind TerrainAttribute ;


fun Mudflow : Class ;
fun Mudflow_Class : SubClass Mudflow Landslide ;
fun Mudslide : Class ;
fun Mudslide_Class : SubClass Mudslide Landslide ;
-- NaturalGas is a combustible mixture 
-- of methane and higher hydrocarbons.
fun NaturalGas : Class ;
fun NaturalGas_Class : SubClass NaturalGas CompoundSubstance ;

-- NaturalSatellite is the class of 
-- large, naturally occurring astronomical bodies orbiting some other 
-- AstronomicalBody.
fun NaturalSatellite : Class ;
fun NaturalSatellite_Class : SubClass NaturalSatellite (both AstronomicalBody Satellite) ;


-- NauticalMile represents the international 
-- unit used for measuring distance in sea and air navigation. The unit is 
-- based on the length of a minute of arc of a great circle of 
-- PlanetEarth.
fun NauticalMile : Ind UnitOfLength ;


fun NormalFault : Class ;
fun NormalFault_Class : SubClass NormalFault DipSlipFault ;
fun NorthAmerica : Ind (both GeographicArea Continent) ;

-- NorthAtlanticOcean denotes the northern geographicSubregion 
-- of the AtlanticOcean.
fun NorthAtlanticOcean : Ind (both SaltWaterArea BodyOfWater) ;


-- NorthPacificOcean denotes the northern geographicSubregion 
-- of the PacificOcean.
fun NorthPacificOcean : Ind (both SaltWaterArea BodyOfWater) ;


fun NorthSea : Ind Sea ;

-- Northeast represents the compass direction of Northeast.
fun Northeast : Ind DirectionalAttribute ;


fun NorthernAfrica : Ind GeographicArea ;

fun NorthernAsia : Ind GeographicArea ;

fun NorthernEurope : Ind GeographicArea ;

-- The half of the Earth that lies above the 
-- equator.
fun NorthernHemisphere : Ind Hemisphere ;


fun NorthernNorthAmerica : Ind GeographicArea ;

fun NorthernSouthAmerica : Ind GeographicArea ;

-- Northwest represents the compass direction of Northwest.
fun Northwest : Ind DirectionalAttribute ;


-- NoxiousSubstance is 
-- the class of Substances that are harmful to Humans.
fun NoxiousSubstance : Class ;
fun NoxiousSubstance_Class : SubClass NoxiousSubstance Substance ;

fun NuclearEnvironmentalIssue : Ind PollutionIssue ;

fun NuclearPollutionIssue : Ind EnvironmentalIssue ;

fun NuclearTestBanTreaty : Ind Agreement ;

-- Oasis is a subclass of LandAreas that are 
-- fertile places within a desert, which have water and some vegetation.
fun Oasis : Class ;
fun Oasis_Class : SubClass Oasis (both Biome LandArea) ;


-- OccludedFront is the class of complex 
-- weather transition processes in which a cold air mass overtakes a warm 
-- air mass.
fun OccludedFront : Class ;
fun OccludedFront_Class : SubClass OccludedFront WeatherFront ;

-- Ocean is the class containing the oceans 
-- that are the major subdivisions of the WorldOcean. According to 
-- the International Hydrographic Association, there are five oceans: 
-- the AtlanticOcean, PacificOcean, IndianOcean, SouthernOcean, 
-- and ArcticOcean. Note: The largest oceans, the Atlantic and Pacific, 
-- are subdivided into Northern and Southern regions, but those regions 
-- are not separate Oceans.
fun Ocean : Class ;
fun Ocean_Class : SubClass Ocean (both BodyOfWater SaltWaterArea) ;


fun Oceania : Ind (both GeographicArea Continent) ;

fun OilPollutionIssue : Ind PollutionIssue ;

-- OpenSea is the Attribute of a WaterArea 
-- that is open ocean beyond five NauticalMiles of land, also known as 
-- 'blue water'.
fun OpenSea : Ind Attribute ;


-- (OuterBoundaryFn ?REGION) denotes the 
-- outer boundary of the Region ?REGION, where ?REGION has an inner and 
-- outer orientation with respect to another object.
fun OuterBoundaryFn : El Region -> Ind Region ;


-- OvercastWeather represents
--  a condition in which more than 70% of the sky is covered 
-- with clouds.
fun OvercastWeather : Class ;
fun OvercastWeather_Class : SubClass OvercastWeather WeatherProcess ;

-- Overgrazing is the class of processes 
-- in which grazing animals consume vegetation faster than it can regrow.
fun Overgrazing : Class ;
fun Overgrazing_Class : SubClass Overgrazing Eating ;

fun OvergrazingIssue : Ind EnvironmentalIssue ;

fun OverhuntingIssue : Ind EnvironmentalIssue ;

fun OverpopulationIssue : Ind EnvironmentalIssue ;

fun OzoneDepletionIssue : Ind EnvironmentalIssue ;

fun OzoneLayerProtectionProtocol : Ind Agreement ;

-- The OzoneShield is a layer in 
-- EarthsAtmosphere, located about 25 miles above Earth's surface, 
-- composed of ozone gas that absorbs ultraviolent radiation from 
-- the Sun that can be damaging to living things.
fun OzoneShield : Ind (both AtmosphericRegion CompoundSubstance) ;


-- PHValue ('pH') is a UnitOfMeasure 
-- used to measure the acidity or alkalinity of a solution. The pH 
-- scale ranges from 0 to 14. The pH of a neutral solution is 7. 
-- Acid solutions have a pH value less than seven. Alkaline solutions 
-- have a value greater than seven.
fun PHValue : Ind NonCompositeUnitOfMeasure ;


-- PacificOcean represents the Pacific 
-- Ocean.
fun PacificOcean : Ind Ocean ;


-- Pampa is a class of vast, level, typically grassy 
-- Plains of land in South America.
fun Pampa : Class ;
fun Pampa_Class : SubClass Pampa (both Grassland Plain) ;


fun Pampero : Class ;
fun Pampero_Class : SubClass Pampero Windstorm ;
-- PartlyCloudyWeather 
-- represents a condition in which between 30% and 70% of the 
-- sky is covered with clouds.
fun PartlyCloudyWeather : Class ;
fun PartlyCloudyWeather_Class : SubClass PartlyCloudyWeather WeatherProcess ;

-- A Peninsula is a piece of land that extends 
-- into a body of water and is surrounded on three sides by water. Typically 
-- connected by an Isthmus or neck of land that is narrower than its main 
-- portion (contrast with Cape).
fun Peninsula : Class ;
fun Peninsula_Class : SubClass Peninsula LandForm ;

-- A PerimeterArea is a region that 
-- extends outward from a boundary with another region, surrounding or 
-- partially surrounding it, but which is not part of that other region. 
-- See BorderFn and PerimeterAreaFn.
fun PerimeterArea : Class ;
fun PerimeterArea_Class : SubClass PerimeterArea Region ;

-- (PerimeterAreaFn ?REGION) denotes a 
-- class including any peripheral zones extending outward from the Region 
-- ?REGION.
fun PerimeterAreaFn: El Region -> Desc PerimeterArea ;


fun Permafrost : Ind CompoundSubstance ;

-- PermanentCropLand is the subclass 
-- of LandArea that represents land cultivated for crops that are produced 
-- without replanting after every harvest, such as fruit trees, coffee, rubber, 
-- nuts, and vineyards. Does not include timberland. Cf. arableLandArea.
fun PermanentCropLand : Class ;
fun PermanentCropLand_Class : SubClass PermanentCropLand LandArea ;

fun PersianGulf : Ind (both Gulf SaltWaterArea) ;

fun PesticideIssue : Ind EnvironmentalIssue ;

-- PesticidePollution is 
-- the subclass of Pollution in which the pollutant is a pesticide.
fun PesticidePollution : Class ;
fun PesticidePollution_Class : SubClass PesticidePollution Pollution ;

-- Phospate is a salt or ester of a 
-- phosphoric acid.
fun Phosphate : Class ;
fun Phosphate_Class : SubClass Phosphate CompoundSubstance ;

-- A Piedmont is a LandArea at the foot of mountains.
fun Piedmont : Class ;
fun Piedmont_Class : SubClass Piedmont LandArea ;

-- Pines are coniferous BotanicalTrees of the 
-- genus Pinus, in the family Pinaceae. They are evergreens, with needle_
-- shaped leaves and propagate by dropping pine cones, which contains
-- seeds. (from Wikipedia)
fun PineTree : Class ;
fun PineTree_Class : SubClass PineTree BotanicalTree ;

-- A Plain is a broad, flat or gently rolling area, 
-- usually low in elevation.
fun Plain : Class ;
fun Plain_Class : SubClass Plain LowlandArea ;

-- Planet is the class of large 
-- NaturalSatellites that revolve around a star.
fun Planet : Class ;
fun Planet_Class : SubClass Planet NaturalSatellite ;

fun PlanetEarth : Ind Planet ;

fun PlanetJupiter : Ind Planet ;

fun PlanetMars : Ind Planet ;

fun PlanetMercury : Ind Planet ;

fun PlanetNeptune : Ind Planet ;

fun PlanetPluto : Ind Planet ;

fun PlanetSaturn : Ind Planet ;

fun PlanetUranus : Ind Planet ;

fun PlanetVenus : Ind Planet ;

-- Planting is the class of processes in 
-- which botanical Plants are planted or transplanted, whether as 
-- seeds, seedlings, or mature plants.
fun Planting : Class ;
fun Planting_Class : SubClass Planting Putting ;

-- A Plateau is a flat upland area with one steep 
-- face, elevated plain.
fun Plateau : Class ;
fun Plateau_Class : SubClass Plateau (both LandForm UplandArea) ;


-- Poaching is the illegal killing 
-- of non_human animals.
fun Poaching : Class ;
fun Poaching_Class : SubClass Poaching Killing ;

-- PolarClimateZone is a subclass of 
-- ClimateZone characterized by having an average temperature less than 
-- 10 degrees Celsius in the warmest month. This is Koeppen climate system 
-- Type E. No agriculture is supported in polar climates.
fun PolarClimateZone : Class ;
fun PolarClimateZone_Class : SubClass PolarClimateZone ClimateZone ;

-- PolarTypeFClimateZone is a 
-- subclass of PolarClimateZone characterized by having no month in 
-- which the temperature rises to 10 degrees Celsius or above.
fun PolarTypeFClimateZone : Class ;
fun PolarTypeFClimateZone_Class : SubClass PolarTypeFClimateZone PolarClimateZone ;

fun PollutedFishStocksIssue : Ind EnvironmentalIssue ;

-- Pollution is the contamination of an 
-- environment by man_made wastes.
fun Pollution : Class ;
fun Pollution_Class : SubClass Pollution SocialInteraction ;

fun PollutionIssue : Class ;
fun PollutionIssue_Class : SubClass PollutionIssue EnvironmentalIssue ;
fun PoopoLake : Ind SaltLake ;

fun PopulationMigrationIssue : Ind EnvironmentalIssue ;

-- PotableWater is the subclass 
-- of Water that represents safely drinkable water.
fun PotableWater : Class ;
fun PotableWater_Class : SubClass PotableWater Freshwater ;

-- Potash is a Potassium carbonate from 
-- wood ashes or a potassium compound.
fun Potash : Class ;
fun Potash_Class : SubClass Potash CompoundSubstance ;

fun PowerPlantEmissionsIssue : Ind PollutionIssue ;

-- Prairie is a class of large plains 
-- LandAreas with tall grass vegetation.
fun Prairie : Class ;
fun Prairie_Class : SubClass Prairie (both Grassland Plain) ;


-- RainForest is the subclass of LandAreas 
-- that are densely planted with trees.
fun RainForest : Class ;
fun RainForest_Class : SubClass RainForest (both Biome Forest) ;


-- Raining is a precipitation process 
-- in which water falls in a Liquid state.
fun Raining : Class ;
fun Raining_Class : SubClass Raining Precipitation ;

-- Rapids is the class of WaterAreas that are 
-- parts of a StreamWaterArea where the currents move swiftly over 
-- rocks.
fun Rapids : Class ;
fun Rapids_Class : SubClass Rapids StreamWaterArea ;

fun RawSewagePollutionIssue : Ind PollutionIssue ;

fun RedSea : Ind Sea ;

-- A Reef is a ridge of rock, coral, or sand at or near 
-- the surface of a WaterArea.
fun Reef : Class ;
fun Reef_Class : SubClass Reef (both LandForm MaritimeHazard) ;


-- Reforestation is the process of 
-- replanting trees on land where they were cut or burned.
fun Reforestation : Class ;
fun Reforestation_Class : SubClass Reforestation Planting ;

-- A Reservoir is an artifically made (or 
-- artifically enlarged) holding area where water is collected and stored 
-- for future use.
fun Reservoir : Class ;
fun Reservoir_Class : SubClass Reservoir (both Artifact FreshWaterArea) ;


-- A ReservoirLake is an artifically made 
-- (or artifically enlarged) lake used for water collection and storage.
fun ReservoirLake : Class ;
fun ReservoirLake_Class : SubClass ReservoirLake (both Lake Reservoir) ;


-- A RichterMagnitude is a measure 
-- of the severity of an EarthTremor. For example, 
-- (MeasureFn 6.5 RichterMagnitude) denotes the value of 6.5 on the 
-- Richter scale.
fun RichterMagnitude : Ind CompositeUnitOfMeasure ;


-- A RipCurrent is a fast narrow surface current 
-- that flows seaward from a ShoreArea.
fun RipCurrent : Class ;
fun RipCurrent_Class : SubClass RipCurrent LittoralCurrent ;

-- River is the class of large streams of fresh 
-- water flowing through land into a lake, ocean, or other body of water.
fun River : Class ;
fun River_Class : SubClass River (both BodyOfWater (both FreshWaterArea StreamWaterArea)) ;


-- A RiverBank is the ShoreArea adjacent to a river.
fun RiverBank : Class ;
fun RiverBank_Class : SubClass RiverBank (both LandForm ShoreArea) ;


-- RiverMouth is the subclass of WaterAreas 
-- that are the outfalls of a river or stream into another body of water.
fun RiverMouth : Class ;
fun RiverMouth_Class : SubClass RiverMouth (both StreamWaterArea WaterArea) ;


-- A RiverSystem comprises all the tributary 
-- streams and rivers (StreamWaterAreas) that drain along converging 
-- paths into the main river of the system, which discharges into a 
-- StaticWaterArea.
fun RiverSystem : Class ;
fun RiverSystem_Class : SubClass RiverSystem (both Collection WaterArea) ;


fun Rockslide : Class ;
fun Rockslide_Class : SubClass Rockslide Landslide ;
-- Salination is the class of processes 
-- in which either Freshwater or Topsoil becomes imbued with 
-- SodiumChloride from sea water or from the evaporation of irrigation water.
fun Salination : Class ;
fun Salination_Class : SubClass Salination Combining ;

-- A Salt is a chemical substance which is a combination 
-- of a metal or a base with an acid.
fun Salt : Class ;
fun Salt_Class : SubClass Salt CompoundSubstance ;

-- SaltLake is the class of landlocked 
-- bodies of salt water, including those referred to as 'Seas', e.g., 
-- the CaspianSea. But note that the MediterraneanSea is a Sea.
fun SaltLake : Class ;
fun SaltLake_Class : SubClass SaltLake (both LandlockedWater SaltWaterArea) ;


fun SaltonSea : Ind SaltLake ;

-- Sand is loose fragments of minerals or rocks. Smaller than 
-- gravel and larger than silt and clay, sand particles range from 8/10,000 to 8/100 
-- inch (0.02 to 2 millimeters) in diameter. Sand is formed by the Erosion of rocks 
-- through the action of water, ice, or air.
fun Sand : Class ;
fun Sand_Class : SubClass Sand Soil ;

fun Sandstorm : Class ;
fun Sandstorm_Class : SubClass Sandstorm WeatherProcess ;
-- Sanitation is the class of processes 
-- by which human waste and garbage are disposed of.
fun Sanitation : Class ;
fun Sanitation_Class : SubClass Sanitation Removing ;

-- Satellite is the collection of bodies that 
-- revolve around some astronomical body, e.g., planets around a star. 
-- This class includes both artificial and NaturalSatellites.
fun Satellite : Class ;
fun Satellite_Class : SubClass Satellite AstronomicalBody ;

-- Savanna is a class of tropical or subtropical 
-- Grasslands, typically treeless.
fun Savanna : Class ;
fun Savanna_Class : SubClass Savanna (both Grassland Plain) ;


-- ScatteredVegetation describes 
-- the pattern of vegetation in which plants appear at intervals.
fun ScatteredVegetation : Ind Attribute ;


-- Sea is the class of smaller subdivisions of 
-- the WorldOcean, typically partially surrounded by land. However, 
-- for inland salt water bodies that are sometimes called 'Sea', see 
-- SaltLake.
fun Sea : Class ;
fun Sea_Class : SubClass Sea (both BodyOfWater SaltWaterArea) ;


fun SeaIce : Class ;
fun SeaIce_Class : SubClass SeaIce Ice ;
-- SeaLevel designates the global Mean Sea Surface 
-- (MSS). Note that SeaLevel represents a GeographicArea that comprises all 
-- the local Mean Sea Level (MSL) areas used as references for measuring altitude. 
-- In fact, there are local variations in MSL, due to tides and long_ and short_
-- term weather conditions.
fun SeaLevel : Ind GeographicArea ;


-- SeabedArea is the class of SubmergedLandAreas that are part of 
-- the sea floor.
fun SeabedArea : Class ;
fun SeabedArea_Class : SubClass SeabedArea SubmergedLandArea ;

-- A Seacoast is the ShoreArea along the 
-- margin of an ocean, extending inland approximately 1_3 km from the low 
-- water mark.
fun Seacoast : Class ;
fun Seacoast_Class : SubClass Seacoast (both LandForm ShoreArea) ;


fun SemiaridClimateZone : Class ;
fun SemiaridClimateZone_Class : SubClass SemiaridClimateZone ClimateZone ;
fun SevereThunderstorm : Class ;
fun SevereThunderstorm_Class : SubClass SevereThunderstorm WeatherProcess ;
fun SewageDisposal : Class ;
fun SewageDisposal_Class : SubClass SewageDisposal Sanitation ;
fun ShipPollutionProtocol : Ind Agreement ;

fun Shoal : Class ;
fun Shoal_Class : SubClass Shoal MaritimeHazard ;
-- Shoreline is the class of LandAreas that 
-- are the edge of a larger land mass abutting a bordering WaterArea.
fun Shoreline : Class ;
fun Shoreline_Class : SubClass Shoreline LandArea ;

-- (ShorelineFn ?LAND ?WATER) denotes 
-- the Shoreline where the GeographicArea ?LAND borders the 
-- WaterArea ?WATER.
fun ShorelineFn : El GeographicArea -> El WaterArea -> Ind LandArea ;


-- (ShortageFn ?TYPE) means that there 
-- is a shortage of objects of ?TYPE, which are used as resources.
fun ShortageFn: Desc Object -> Ind Entity ;


-- Shrub is the class of low, perennial, 
-- typically multi_stemmed woody plants, called shrubs or bushes.
fun Shrub : Class ;
fun Shrub_Class : SubClass Shrub FloweringPlant ;

-- SigningADocument is the class of 
-- actions in which an agent affixes a signature, stamp, or other evidence 
-- of authorization or attestation to a document. The document and signature 
-- may be electronic. Signings count as SocialInteractions even if done in 
-- private, because their significance derives from a social context.
fun SigningADocument : Class ;
fun SigningADocument_Class : SubClass SigningADocument Committing ;

-- Silt is sand or earth which is carried along by flowing 
-- water and deposited at a bend in a river or at a river's opening.
fun Silt : Class ;
fun Silt_Class : SubClass Silt Soil ;

-- Siltation is the class of processes 
-- in which WaterAreas become filled in with silt or mud, due to 
-- soil Erosion.
fun Siltation : Class ;
fun Siltation_Class : SubClass Siltation Putting ;

fun SiltationIssue : Ind EnvironmentalIssue ;

fun Sirocco : Class ;
fun Sirocco_Class : SubClass Sirocco WindProcess ;
-- SlashAndBurnAgriculture 
-- is the subclass of Agriculture processes in which land is 
-- cleared by cutting and burning trees, and crops are farmed until 
-- the soil is depleted, at which point the plot is abandoned to 
-- regrowth. This rotational technique is viable only with low 
-- populations and infrequent re_use.
fun SlashAndBurnAgriculture : Class ;
fun SlashAndBurnAgriculture_Class : SubClass SlashAndBurnAgriculture Agriculture ;

fun Sleeting : Class ;
fun Sleeting_Class : SubClass Sleeting Precipitation ;
-- A SlopedArea is a land surface which lies at 
-- an angle to the horizontal so that some points on it are higher than 
-- others, a slope.
fun SlopedArea : Class ;
fun SlopedArea_Class : SubClass SlopedArea LandForm ;

-- Snowing is a precipitation process 
-- in which water falls in a Solid state.
fun Snowing : Class ;
fun Snowing_Class : SubClass Snowing Precipitation ;

fun SocialInteractions : Class ;

-- Soil is a substance composed of fine rock material 
-- disintegrated by geological processes, mixed with humus, the organic remains of decomposed vegetation.
fun Soil : Class ;
fun Soil_Class : SubClass Soil Mixture ;

-- SoilDegradation is a class of 
-- processes in which the productive capacity of soil is lowered by 
-- over_fertilization, overuse of pesticides, erosion, or soil 
-- compaction.
fun SoilDegradation : Class ;
fun SoilDegradation_Class : SubClass SoilDegradation SocialInteractions ;

fun SoilDegradationIssue : Ind SoilQualityIssue ;

-- SoilErosion is the subclass of 
-- Erosion in which the matter removed by wind or water is topsoil.
fun SoilErosion : Class ;
fun SoilErosion_Class : SubClass SoilErosion Erosion ;

fun SoilErosionIssue : Ind SoilQualityIssue ;

fun SoilExhaustionIssue : Ind SoilQualityIssue ;

fun SoilPollutionIssue : Ind (both PollutionIssue SoilQualityIssue) ;

fun SoilQualityIssue : Class ;
fun SoilQualityIssue_Class : SubClass SoilQualityIssue EnvironmentalIssue ;
fun SoilSalination : Class ;
fun SoilSalination_Class : SubClass SoilSalination Salination ;
fun SoilSalinityIssue : Ind SoilQualityIssue ;

-- SoilSolution is the liquid component of soils, 
-- which is largely water containing a number of mineral substances in solution, 
-- as well as comparatively large amounts of dissolved oxygen and carbon dioxide.
fun SoilSolution : Class ;
fun SoilSolution_Class : SubClass SoilSolution Solution ;

-- Sol is the nearest Star to PlanetEarth and 
-- the focus of its SolarSystem.
fun Sol : Ind Star ;


-- SolarSystem is the class of systems that 
-- consist of a star or stars and any encircling astronomical bodies.
fun SolarSystem : Class ;
fun SolarSystem_Class : SubClass SolarSystem Collection ;

fun SolidWasteDisposal : Class ;
fun SolidWasteDisposal_Class : SubClass SolidWasteDisposal Sanitation ;
fun SolidWasteDisposalIssue : Ind PollutionIssue ;

-- A Sound is a long, relatively narrow waterway 
-- lying along the shore of a land mass and protected from open water by 
-- another land area, an island or group of islands. Some sounds open at 
-- both ends into the same body of water (e.g., Long Island Sound), while 
-- others connect two different bodies of water (e.g., Melville Sound). 
-- A Sound may occur in salt or fresh water bodies. Generally wider than 
-- a Strait.
fun Sound : Class ;
fun Sound_Class : SubClass Sound BodyOfWater ;

fun SouthAmerica : Ind Continent ;

-- SouthAtlanticOcean denotes the southern geographicSubregion 
-- of the AtlanticOcean.
fun SouthAtlanticOcean : Ind (both SaltWaterArea BodyOfWater) ;


-- SouthPacificOcean denotes the southern geographicSubregion 
-- of the PacificOcean.
fun SouthPacificOcean : Ind (both SaltWaterArea BodyOfWater) ;


fun SouthSandwichTrench : Ind Hole ;

-- Southeast represents the compass direction of Southeast.
fun Southeast : Ind DirectionalAttribute ;


fun SoutheasternAsia : Ind GeographicArea ;

fun SoutheasternEurope : Ind GeographicArea ;

fun SouthernAfrica : Ind GeographicArea ;

fun SouthernAsia : Ind GeographicArea ;

fun SouthernEurope : Ind GeographicArea ;

-- The half of the Earth that lies below the 
-- equator.
fun SouthernHemisphere : Ind Hemisphere ;


-- SouthernOcean represents the Southern 
-- Ocean.
fun SouthernOcean : Ind (both Ocean PolarClimateZone) ;


fun SouthernSouthAmerica : Ind GeographicArea ;

-- Southwest represents the compass direction of Southwest.
fun Southwest : Ind DirectionalAttribute ;


fun SouthwesternAsia : Ind GeographicArea ;

fun SouthwesternEurope : Ind GeographicArea ;

-- SparseVegetation describes the 
-- pattern of vegetation in an area where there is very little vegetation.
fun SparseVegetation : Ind Attribute ;


fun Squall : Class ;
fun Squall_Class : SubClass Squall WeatherProcess ;
-- SquareKilometer represents a 
-- UnitOfMeasure equal to one square kilometer.
fun SquareKilometer : Ind UnitOfArea ;


-- SquareMeter represents a UnitOfMeasure 
-- equal to one square Meter.
fun SquareMeter : Ind UnitOfArea ;


-- (SquareUnitFn ?UNIT) denotes the 
-- UnitOfMeasure that is the square of the UnitOfMeasure ?UNIT. 
-- For example, (SquareUnitFn (KiloFn Meter)) denotes the unit 
-- of a square kilometer.
fun SquareUnitFn : El UnitOfMeasure -> Ind UnitOfMeasure ;


-- Star is the class of hot gaseous astronomical bodies.
fun Star : Class ;
fun Star_Class : SubClass Star AstronomicalBody ;

-- StationaryFront is the class of 
-- boundary areas between two air masses that are stationary, with neither 
-- mass presently replacing the other.
fun StationaryFront : Class ;
fun StationaryFront_Class : SubClass StationaryFront WeatherFront ;

-- A TerrainAttribute of a region in 
-- which there is a wide variation in elevation and slopeGradients 
-- of more than 10%.
fun SteepTerrain : Ind TerrainAttribute ;


-- Steppe is a subclass of Plain, representing 
-- vast, level, treeless areas of land in Asia or SE Europe.
fun Steppe : Class ;
fun Steppe_Class : SubClass Steppe Plain ;

-- SteppeClimateZone 
-- is the class of AridClimateZones where the dominant 
-- vegetation type is grasses, with no trees. Koeppen 
-- system 'BS'.
fun SteppeClimateZone : Class ;
fun SteppeClimateZone_Class : SubClass SteppeClimateZone AridClimateZone ;

-- A Stone is any small fragment of rock or mineral matter.
fun Stone : Class ;
fun Stone_Class : SubClass Stone Rock ;

fun StormSystem : Class ;
fun StormSystem_Class : SubClass StormSystem WeatherSystem ;
-- Strait is the subclass of BodyOfWater that 
-- consists of narrow water areas connecting two larger bodies of water. 
-- Straits are naturally occurring bodies of water.
fun Strait : Class ;
fun Strait_Class : SubClass Strait BodyOfWater ;

fun StraitOfHormuz : Ind (both Strait SaltWaterArea) ;

-- A StreamWaterConfluence is the 
-- place where a stream or other tributary joins a river.
fun StreamWaterConfluence : Class ;
fun StreamWaterConfluence_Class : SubClass StreamWaterConfluence WaterArea ;

fun StrikeSlipFault : Class ;
fun StrikeSlipFault_Class : SubClass StrikeSlipFault GeologicalFault ;
fun StrongWind : Class ;
fun StrongWind_Class : SubClass StrongWind WindProcess ;
-- SubmergedLandArea is the class of land 
-- regions that are located beneath bodies of water.
fun SubmergedLandArea : Class ;
fun SubmergedLandArea_Class : SubClass SubmergedLandArea GeographicArea ;

-- SubtropicalDesertClimateZone is a subclass of DesertClimateZone 
-- that is characterized by an average temperature greater than 18 
-- degrees Celsius, as well as very low rainfall. This is Koeppen 
-- system 'BWh'.
fun SubtropicalDesertClimateZone : Class ;
fun SubtropicalDesertClimateZone_Class : SubClass SubtropicalDesertClimateZone DesertClimateZone ;

-- SurfaceGroundArea is a subclass of 
-- GeographicArea that is restricted to regions whose surface is solid 
-- ground. A SurfaceGroundArea may be a discontinuous region overlapping 
-- a larger, continuous GeographicArea but excluding any WaterAreas 
-- enclosed therein. Rivers, lakes, reservoirs and other surface water areas 
-- are not part of any SurfaceGroundArea.
fun SurfaceGroundArea : Class ;
fun SurfaceGroundArea_Class : SubClass SurfaceGroundArea GeographicArea ;

fun Swarming : Class ;
fun Swarming_Class : SubClass Swarming Motion ;
-- Tailwind is the relative attribute of a 
-- Wind to an object when the force of the wind is applied to the back 
-- of the object (BackFn). A tailwind can positively affect the speed 
-- capability of a vehicle.
fun Tailwind : Ind Attribute ;


-- Talc is a very soft Mineral that is 
-- a basic silicate of magnesium.
fun Talc : Class ;
fun Talc_Class : SubClass Talc Mineral ;

-- TemperateClimateZone is the 
-- subclass of ClimateZone whose warmest month has an average 
-- temperature greater than 10 degrees Celsius and whose coolest month 
-- has an average temperature between 18 degrees and _3 degrees Celsius. 
-- This is Class C in the Koeppen climate system.
fun TemperateClimateZone : Class ;
fun TemperateClimateZone_Class : SubClass TemperateClimateZone ClimateZone ;

fun TemperateHardwoodForest : Class ;
fun TemperateHardwoodForest_Class : SubClass TemperateHardwoodForest (both Biome Forest) ;

fun TemperateRainForest : Class ;
fun TemperateRainForest_Class : SubClass TemperateRainForest (both RainForest TemperateHardwoodForest) ;

-- TemperateSummerDryClimateZone is the subclass of TemperateClimateZone 
-- that is characterized by dry summers, and in which the wettest winter month 
-- has at least three times the moisture of the driest summer month. The 
-- driest month has less than an average of 30 mm of precipitation. Koeppen 
-- climate system type 'Cs'.
fun TemperateSummerDryClimateZone : Class ;
fun TemperateSummerDryClimateZone_Class : SubClass TemperateSummerDryClimateZone TemperateClimateZone ;

-- TemperateWinterDryClimateZone is a subclass of TemperateClimateZone 
-- characterized by having at least 10 times as much precipitation in the 
-- wettest summer month as in the driest winter month. Koeppen climate 
-- system type 'Cw'.
fun TemperateWinterDryClimateZone : Class ;
fun TemperateWinterDryClimateZone_Class : SubClass TemperateWinterDryClimateZone TemperateClimateZone ;

-- TerrainAttribute is a class of 
-- Attributes that describe terrain.
fun TerrainAttribute : Class ;
fun TerrainAttribute_Class : SubClass TerrainAttribute InternalAttribute ;

-- TerritorialSea is the class 
-- of contiguous waters over which a GeopoliticalArea claims 
-- jurisdiction in accordance with the United Nations Convention 
-- on the LawOfTheSea (LOS), Part II. A territorial sea may be
-- up to 12 miles (NauticalMiles) in breadth. A subclass of 
-- MaritimeClaimArea.
fun TerritorialSea : Class ;
fun TerritorialSea_Class : SubClass TerritorialSea (both MaritimeClaimArea SaltWaterArea) ;


-- (TerritorialSeaFn ?POLITY) denotes 
-- the TerritorialSea that is claimed by the GeopoliticalArea ?POLITY.
fun TerritorialSeaFn : El GeopoliticalArea -> Ind TerritorialSea ;


fun ThrustFault : Class ;
fun ThrustFault_Class : SubClass ThrustFault DipSlipFault ;
fun Thunderstorm : Class ;
fun Thunderstorm_Class : SubClass Thunderstorm WeatherProcess ;
-- A TidalBore is an unusally high, fast tidal 
-- inflow from the sea, resulting from a high volume of water rushing from 
-- a wide_mouthed bay or Estuary into narrower landward areas.
fun TidalBore : Class ;
fun TidalBore_Class : SubClass TidalBore LittoralCurrent ;

-- TidalEbb is the subclass of WaterCurrents 
-- that are temporary and variable, but regular, currents of ocean water 
-- flowing seaward up to and during the time of low tide. Alternating with 
-- TidalFlow.
fun TidalEbb : Class ;
fun TidalEbb_Class : SubClass TidalEbb LittoralCurrent ;

-- TidalFlow is the subclass of WaterCurrents 
-- that are temporary and variable, but regular, currents of ocean water 
-- flowing landward up to and during the time of high tide. Alternating 
-- with TidalEbb.
fun TidalFlow : Class ;
fun TidalFlow_Class : SubClass TidalFlow LittoralCurrent ;

-- TidalProcess is the class of daily 
-- recurring events in which the water level in a BodyOfWater rises 
-- and falls with the changing position between Earth and the Moon.
fun TidalProcess : Class ;
fun TidalProcess_Class : SubClass TidalProcess InternalChange ;

-- A Tide is a vertical movement of the water level 
-- in a BodyOfWater due to the gravitational attraction between Earth and 
-- the moon. Tides are diurnally recurrent events. In most regions with 
-- tides, every day there are two high tides and two low tides. MixedTide 
-- represents a process in which the tides at either extreme are unequal.
fun Tide : Class ;
fun Tide_Class : SubClass Tide (both FlowRegion SaltWaterArea) ;


fun Tornado : Class ;
fun Tornado_Class : SubClass Tornado WeatherProcess ;
fun ToxicChemicalPollutionIssue : Ind PollutionIssue ;

fun ToxicWasteDisposalIssue : Ind PollutionIssue ;

-- TreatyDocument is the subclass of 
-- Texts that represent written agreements between Nations.
fun TreatyDocument : Class ;
fun TreatyDocument_Class : SubClass TreatyDocument Text ;

-- TropicalClimateZone is a 
-- subclass of ClimateZone in which the average temperature of the 
-- coldest month is greater than 18 degrees Celsius. This is Class 
-- 'A' in the Koeppen climate classification system.
fun TropicalClimateZone : Class ;
fun TropicalClimateZone_Class : SubClass TropicalClimateZone ClimateZone ;

-- TropicalCyclone is the class of 
-- CyclonicStorms that occur in the Tropics and typically have 
-- rotational winds of hurricane force (74 mph or higher).
fun TropicalCyclone : Class ;
fun TropicalCyclone_Class : SubClass TropicalCyclone CyclonicStorm ;

fun TropicalRainForest : Class ;
fun TropicalRainForest_Class : SubClass TropicalRainForest RainForest ;
fun TropicalTimber83Agreement : Ind Agreement ;

fun TropicalTimber94Agreement : Ind Agreement ;

-- The Tropics is the region of 
-- PlanetEarth that lies between approximately 23 and one half degrees 
-- North latitude and 23 and one half degrees South latitude, 
-- encircling the globe. 'The Tropics'. See also TropicArea.
fun Tropics : Ind GeographicArea ;


-- Tsunami is the class of highly destructive 
-- ocean waves caused by offshore seismic processes.
fun Tsunami : Class ;
fun Tsunami_Class : SubClass Tsunami WeatherProcess ;

-- Tundra is a subclass of flat, treeless Plains 
-- areas lying within the ArcticRegion. Subsoil in Tundra is permanently 
-- frozen.
fun Tundra : Class ;
fun Tundra_Class : SubClass Tundra (both ArcticRegion (both Biome Plain)) ;


-- TundraClimateZone is a subclass of 
-- PolarClimateZone characterized by having an average temperature 
-- above zero degrees Celsius (but below 10 degrees) in the warmest month. 
-- Koeppen subtype 'ET'.
fun TundraClimateZone : Class ;
fun TundraClimateZone_Class : SubClass TundraClimateZone PolarClimateZone ;

fun Typhoon : Class ;
fun Typhoon_Class : SubClass Typhoon TropicalCyclone ;
fun UVLevelsIssue : Ind EnvironmentalIssue ;

-- The class of regions located Below the surface of the earth.
fun UndergroundArea : Class ;
fun UndergroundArea_Class : SubClass UndergroundArea GeographicArea ;

fun UnexplodedOrdinanceIssue : Ind EnvironmentalIssue ;

-- A UniformPerimeterArea is one 
-- that has a defined uniform width.
fun UniformPerimeterArea : Class ;
fun UniformPerimeterArea_Class : SubClass UniformPerimeterArea PerimeterArea ;

-- Uphill is a PositionalAttribute that 
-- describes the relation between two things, one of which is located 
-- up a slope from the other.
fun Uphill : Ind PositionalAttribute ;


-- An UplandArea is a LandArea elevated above the surrounding 
-- terrain.
fun UplandArea : Class ;
fun UplandArea_Class : SubClass UplandArea LandForm ;

fun Upstream : Ind PositionalAttribute ;

-- Upwind is a PositionalAttribute that indicates relative position 
-- upwind (windward) with respect to the direction that the Wind is 
-- blowing.
fun Upwind : Ind PositionalAttribute ;


fun UrbanizationIssue : Ind EnvironmentalIssue ;

-- A Valley is an area of low_lying land flanked by 
-- higher ground. Valleys typically contain a stream or river flowing along the valley floor.
fun Valley : Class ;
fun Valley_Class : SubClass Valley (both LandForm LowlandArea) ;


fun VehicleEmissionsIssue : Ind PollutionIssue ;

-- VehicularPollution is the 
-- subclass of Pollution in which the pollutants are vehicle emissions.
fun VehicularPollution : Class ;
fun VehicularPollution_Class : SubClass VehicularPollution Pollution ;

-- Veldt is a subclass of Grasslands which have 
-- scattered shrubs or trees.
fun Veldt : Class ;
fun Veldt_Class : SubClass Veldt (both Grassland Plain) ;


-- A VolcanicCone is a hill of lava or 
-- pyroclastics surrounding a volcanic vent. Not as high as a 
-- VolcanicMountain.
fun VolcanicCone : Class ;
fun VolcanicCone_Class : SubClass VolcanicCone (both Hill Volcano) ;


-- VolcanicEruption is the subclass of 
-- GeologicalProcesses in which Volcanoes erupt.
fun VolcanicEruption : Class ;
fun VolcanicEruption_Class : SubClass VolcanicEruption GeologicalProcess ;

fun VolcanicGasRelease : Class ;
fun VolcanicGasRelease_Class : SubClass VolcanicGasRelease VolcanicEruption ;
-- A VolcanicMountain is a cone_shaped 
-- mountain formed out of rock or ash thrown up from inside the earth, 
-- frequently with an opening or depression at the top.
fun VolcanicMountain : Class ;
fun VolcanicMountain_Class : SubClass VolcanicMountain (both Mountain Volcano) ;


fun VolcanicallyActive : Ind VolcanoStatus ;

fun VolcanicallyDormant : Ind VolcanoStatus ;

fun VolcanicallyExtinct : Ind VolcanoStatus ;

-- A Volcano in the broadest sense, i.e., a region 
-- containing a vent through which magmous and/or pyroclastic materials are 
-- passed from the interior of the Earth to its surface (atmospheric or 
-- underwater).
fun Volcano : Class ;
fun Volcano_Class : SubClass Volcano LandForm ;

fun VolcanoStatus : Class ;
fun VolcanoStatus_Class : SubClass VolcanoStatus InternalAttribute ;
-- WarmFront is the class of transitional 
-- weather processes occurring between a warm air mass that is advancing 
-- upon a cool air mass.
fun WarmFront : Class ;
fun WarmFront_Class : SubClass WarmFront WeatherFront ;

fun WaterBorneDiseaseIssue : Ind EnvironmentalIssue ;

-- WaterCatchment is the subclass of 
-- Artifacts used to capture rainwater or runoff as a source 
-- of Freshwater.
fun WaterCatchment : Class ;
fun WaterCatchment_Class : SubClass WaterCatchment Artifact ;

-- WaterCurrent is a subclass of FlowRegions 
-- consisting of moving water, especially those currents found within a 
-- well_identified area and having an established pattern of movement, such 
-- as an OceanCurrent, a RipTide, or a River. WaterCurrent is 
-- disjoint with StaticWaterArea. As a consequence, Lakes for example 
-- cannot be FlowRegions, however, currents may be present in a lake.
fun WaterCurrent : Class ;
fun WaterCurrent_Class : SubClass WaterCurrent (both FlowRegion WaterArea) ;


fun WaterInfrastructureIssue : Ind EnvironmentalIssue ;

fun WaterManagementIssue : Ind EnvironmentalIssue ;

-- WaterOnlyArea is a subclass of 
-- GeographicArea that is restricted to regions whose surface is water. 
-- A WaterOnlyArea may be a discontinuous region overlapping a larger, 
-- continuous GeographicArea but excluding any LandAreas enclosed therein. 
-- Dry land areas, including islands, are not part of any WaterOnlyArea.
fun WaterOnlyArea : Class ;
fun WaterOnlyArea_Class : SubClass WaterOnlyArea GeographicArea ;

fun WaterOverutilization : Class ;
fun WaterOverutilization_Class : SubClass WaterOverutilization SocialInteraction ;
-- WaterPollution is the subclass 
-- of Pollution processes in which Water is the polluted substance.
fun WaterPollution : Class ;
fun WaterPollution_Class : SubClass WaterPollution Pollution ;

fun WaterPollutionIssue : Ind EnvironmentalWaterIssue ;

-- Waterfall is the subclass of StreamWaterAreas where running water 
-- falls steeply downhill.
fun Waterfall : Class ;
fun Waterfall_Class : SubClass Waterfall StreamWaterArea ;

-- A WatershedDivide is a summit area, or 
-- narrow tract of higher ground that constitutes the watershed boundary 
-- between two adjacent drainage basins, it divides the surface waters that 
-- flow naturally in one direction from those that flow in the opposite 
-- direction.
fun WatershedDivide : Class ;
fun WatershedDivide_Class : SubClass WatershedDivide (both LandArea UplandArea) ;


fun Waterspout : Class ;
fun Waterspout_Class : SubClass Waterspout WeatherProcess ;
-- WeatherFront is the class of weather 
-- processes that are involve relationships between two air masses, such 
-- as a high pressure weather system or a low pressure system.
fun WeatherFront : Class ;
fun WeatherFront_Class : SubClass WeatherFront WeatherProcess ;

-- WeatherSeason is the class of seasonal 
-- processes that are characterized by various weather patterns. 
-- WeatherSeasons may recur on a regular annual basis, on a different 
-- pattern, or irregularly.
fun WeatherSeason : Class ;
fun WeatherSeason_Class : SubClass WeatherSeason WeatherProcess ;

-- WeatherSystem is the class of 
-- large_scale atmospheric processes that influence weather in a region 
-- for 2_5 days.
fun WeatherSystem : Class ;
fun WeatherSystem_Class : SubClass WeatherSystem WeatherProcess ;

fun WesternAfrica : Ind GeographicArea ;

fun WesternEurope : Ind GeographicArea ;

-- The half of the Earth that includes North 
-- and South America.
fun WesternHemisphere : Ind Hemisphere ;


fun WesternSouthAmerica : Ind GeographicArea ;

-- WetTropicalClimateZone is 
-- the subclass of TropicalClimateZone that is characterized by having 
-- no dry months. At least 60 mm of rainfall occur in the driest month. 
-- This is subtype 'Af' in the Koeppen climate system.
fun WetTropicalClimateZone : Class ;
fun WetTropicalClimateZone_Class : SubClass WetTropicalClimateZone TropicalClimateZone ;

fun WetlandDegradationIssue : Ind EnvironmentalIssue ;

fun WetlandsConvention : Ind Agreement ;

fun WhalingConvention : Ind Agreement ;

fun WildlifePoachingIssue : Ind EnvironmentalIssue ;

-- WindFlow is the class of variable AirStreams 
-- that are in the EarthsAtmosphere.
fun WindFlow : Class ;
fun WindFlow_Class : SubClass WindFlow AirStream ;

fun WindProcess : Class ;
fun WindProcess_Class : SubClass WindProcess WeatherProcess ;
fun Windstorm : Class ;
fun Windstorm_Class : SubClass Windstorm WindProcess ;
-- The WorldOcean is the collective mass of 
-- sea water that covers 70% of the surface of PlanetEarth, surrounding 
-- all of its dry land areas. Earth's individual Oceans are parts of 
-- the WorldOcean.
fun WorldOcean : Ind (both SaltWaterArea BodyOfWater) ;


fun Zud : Class ;
fun Zud_Class : SubClass Zud WeatherProcess ;
-- (airTemperature ?AREA ?TEMP) means that the temperature of the 
-- air at ?AREA is ?TEMP. Temperature may be expressed in units of 
-- TemperatureMeasure, including CelsiusDegree and FahrenheitDegree, 
-- among others.
fun airTemperature : El Object -> El TemperatureMeasure -> Formula ;


-- (arableLandArea ?REGION ?AMOUNT) 
-- means that the GeographicArea ?REGION has ?AMOUNT of land under 
-- cultivation with crops that are replanted after each harvest. ?AMOUNT 
-- may be expressed in physical units or with a percent or fraction.
-- Cf. permanentCropLandArea.
fun arableLandArea : El GeographicArea -> El ConstantQuantity -> Formula ;


-- (averagePrecipitationForPeriod ?PLACE ?PERIOD ?AMOUNT) means 
-- that at the GeographicArea ?PLACE, and during the TimeDuration 
-- ?PERIOD, the average daily precipitation was ?AMOUNT.
fun averagePrecipitationForPeriod : El GeographicArea -> El TimeDuration -> El ConstantQuantity -> Formula ;


-- (averageRainfallForPeriod ?AREA ?MO ?AMOUNT)
-- means that ?AREA receives ?AMOUNT of rain in month ?MO in an average
-- year. Note that ?AMOUNT is a linear measure indicating the depth of water that
-- would accumulate over ?AREA if all water were captured.
fun averageRainfallForPeriod : El GeographicArea -> El Month -> El LengthMeasure -> Formula ;


-- (averageTemperatureForPeriod ?PLACE ?PERIOD ?AMOUNT) means that 
-- at the GeographicArea ?PLACE, and during the TimeDuration 
-- ?PERIOD, the average daily temperature was ?AMOUNT. Temperature 
-- may be expressed in some UnitOfTemperature, including 
-- CelsiusDegree and FahrenheitDegree, among others.
fun averageTemperatureForPeriod : El GeographicArea -> El TimeDuration -> El TemperatureMeasure -> Formula ;


-- (bioindicatorForHabitat ?AREA ?SPECIES) means that the health 
-- of the individuals in ?SPECIES indicates the condition of their 
-- habitat in the GeographicArea ?AREA.
fun bioindicatorForHabitat: El GeographicArea -> Desc OrganicObject -> Formula ;


-- (claimedTerritory ?AREA ?POLITY) 
-- means that some right over the GeographicArea ?AREA is claimed by 
-- the Agent or GeopoliticalArea ?POLITY. If two politically independent 
-- states or agents claim the same area, that area is a 'disputed 
-- territory'.
fun claimedTerritory : El GeographicArea -> El Agent -> Formula ;


-- (climateTypeInArea ?TYPE ?REGION) 
-- means that all or part of the GeographicArea ?REGION is of the 
-- ClimateZone ?TYPE.
fun climateTypeInArea: El GeographicArea -> Desc ClimateZone -> Formula ;


-- (cloudCoverFraction ?AREA ?AMOUNT) 
-- means that in the Region ?AREA, the fraction ?AMOUNT of the sky is 
-- covered with clouds.
fun cloudCoverFraction : El Region -> El NonnegativeRealNumber -> Formula ;


-- (coldSeasonInArea ?AREA ?INTERVAL) 
-- means that in the GeographicArea ?AREA, the cold season occurs 
-- during the TimeInterval ?INTERVAL.
fun coldSeasonInArea: El GeographicArea -> Desc TimeInterval -> Formula ;


-- (connectedDownstream ?OBJ1 ?OBJ2) 
-- means that ?OBJ1 is connected, remotely or immediately, with ?OBJ2 along 
-- a directed system such as a RiverSystem.
fun connectedDownstream : El Object -> El Object -> Formula ;


-- (coolSeasonInArea ?AREA ?INTERVAL) 
-- means that in the GeographicArea ?AREA, the cool season occurs 
-- during the TimeInterval ?INTERVAL. For example, (coolSeasonInArea 
-- Angola (RecurringTimeIntervalFn May October
fun coolSeasonInArea: El GeographicArea -> Desc TimeInterval -> Formula ;


-- (courseWRTCompassNorth ?OBJ1 ?OBJ2 ?HEADING) means that the course 
-- heading from ?OBJ1 to ?OBJ2 is ?HEADING in AngularDegrees, with 
-- the reference point of 000 degrees North as measured by compass on 
-- or at ?OBJ1.
fun courseWRTCompassNorth : El Physical -> El Physical -> El PlaneAngleMeasure -> Formula ;


-- (courseWRTMagneticNorth ?OBJ1 ?OBJ2 ?HEADING) means that the course 
-- heading from ?OBJ1 to ?OBJ2 is ?HEADING in AngularDegrees, with 
-- the reference point of 000 degrees being the magnetic North pole.
fun courseWRTMagneticNorth : El Physical -> El Physical -> El PlaneAngleMeasure -> Formula ;


-- (courseWRTTrueNorth ?OBJ1 ?OBJ2 ?HEADING) means that the course 
-- heading or track from ?OBJ1 to ?OBJ2 is ?HEADING, in AngularDegrees, 
-- with the reference point of 000 degrees being true North.
fun courseWRTTrueNorth : El Physical -> El Physical -> El PlaneAngleMeasure -> Formula ;


-- (dateOpenedForSignature ?PROP ?DATE) means that as of a date 
-- indicated by ?DATE, document(s) may officially be signed (by the 
-- appropriate agents) to effect commitments to the Agreement ?PROP.
fun dateOpenedForSignature: El Proposition -> Desc TimePosition -> Formula ;


-- (daylightHoursInterval ?PLACE ?DAY ?INTERVAL) means that in the 
-- Region ?PLACE, on the Day indicated by ?DAY, there is daylight 
-- during the TimeInterval ?INTERVAL.
fun daylightHoursInterval: El Region -> Desc Day -> El TimeInterval -> Formula ;


-- (daylightHoursTotal ?PLACE ?DAY ?TIME) means that in the Region 
-- ?PLACE, on the Day indicated by ?DAY, there is daylight for a 
-- total TimeDuration ?LENGTH.
fun daylightHoursTotal: El Region -> Desc Day -> El TimeDuration -> Formula ;


-- (dependentGeopoliticalArea 
-- ?AREA1 ?AREA2) means that ?AREA1 is a geopolitical possession of the 
-- GeopoliticalArea ?AREA2 and is not a geopoliticalSubdivision of 
-- ?AREA2. For example, (dependentGeopoliticalArea Guam UnitedStates), 
-- because Guam is a territory of the UnitedStates, not one of the fifty 
-- U.S. states. Contrast primaryGeopoliticalSubdivision.
fun dependentGeopoliticalArea : El GeographicArea -> El Agent -> Formula ;


-- (drySeasonInArea ?AREA ?INTERVAL) 
-- means that in the GeographicArea ?AREA, the dry season occurs 
-- during the TimeInterval ?INTERVAL. For example, (drySeasonInArea 
-- Angola (RecurringTimeIntervalFn May October)).
fun drySeasonInArea: El GeographicArea -> Desc TimeInterval -> Formula ;


-- The altitude of an object
-- above the sea level of PlanetEarth
fun earthAltitude : El Physical -> El Physical -> El LengthMeasure -> Formula ;


-- (elevation ?OBJECT ?HEIGHT) means that the 
-- physical Object ?OBJECT is located on the surface of PlanetEarth 
-- at the vertical distance ?HEIGHT above (or below, for a negative 
-- quantity) SeaLevel. ?OBJECT may be a superficialPart of Earth's 
-- surface, such as a GeographicArea. Elevation is measured from 
-- SeaLevel to the vertical top of the object.
fun elevation : El Object -> El LengthMeasure -> Formula ;


-- (environmentalProblemTypeInArea ?AREA ?PROBLEM) means that 
-- objects or processes of type ?PROBLEM is an environmental 
-- problem in the GeographicArea ?AREA.
fun environmentalProblemTypeInArea: El GeographicArea -> Desc Physical -> Formula ;


-- The relation between WaterMotion Processes
-- and the region in which they occur continuously over at least hours, but
-- typically months or years. A water balloon bursting and flowing downhill
-- would not use this relation, because there would be no StreamWaterArea
-- to relate to.
fun flowCurrent : El WaterMotion -> El WaterArea -> Formula ;


-- (groundSubsurfaceType ?area ?subsoil) 
-- means that the predominant Substance in the subsoil or subsurface layer of 
-- the LandArea ?area is of type ?subsoil.
fun groundSubsurfaceType: El LandArea -> Desc Substance -> Formula ;


-- (%&groundSurfaceType ?area ?substance) means 
-- that the predominant Substance at the ground surface of the LandArea ?area is ?substance.
fun groundSurfaceType: El LandArea -> Desc Substance -> Formula ;


-- (headingWRTCompassNorth ?OBJ ?DEGREE) 
-- means that the front_to_back axis of the Object ?OBJ points in 
-- the direction ?DEGREE, according to the compass carried by ?OBJ.
fun headingWRTCompassNorth : El Object -> El PlaneAngleMeasure -> Formula ;


-- (headingWRTMagneticNorth ?OBJ ?DEGREE) 
-- means that the front_to_back axis of the Object ?OBJ points in 
-- the direction ?DEGREE, with respect to magnetic North.
fun headingWRTMagneticNorth : El Object -> El PlaneAngleMeasure -> Formula ;


-- (headingWRTTrueNorth ?OBJ ?DEGREE) 
-- means that the front_to_back axis of the Object ?OBJ points in 
-- the direction ?DEGREE, with respect to true North.
fun headingWRTTrueNorth : El Object -> El PlaneAngleMeasure -> Formula ;


-- (highAltitudeWindSpeed ?PLACE ?RATE) means that the Wind 
-- blowing above 25,000 feet at ?PLACE has a speed of ?RATE.
fun highAltitudeWindSpeed : El Object -> El ConstantQuantity -> Formula ;


-- (highAltitudeWindVelocity ?PLACE ?SPEED ?TOWARD) means that the 
-- Wind blowing above 25,000 feet at ?PLACE has a speed of ?SPEED 
-- and is moving toward the DirectionalAttribute ?TOWARD.
fun highAltitudeWindVelocity : El Object -> El PhysicalQuantity -> El DirectionalAttribute -> Formula ;


-- (highTide ?PLACE ?TIME ?AMOUNT) means that 
-- there is a HighTide at the Region ?PLACE at the TimeInterval ?TIME 
-- with the relative height ?AMOUNT. The height is given in relation to 
-- the datum on a standard chart.
fun highTide : El Region -> El TimeInterval -> El LengthMeasure -> Formula ;


-- (highestTemperatureForPeriod ?PLACE ?PERIOD ?AMOUNT) means that 
-- at the GeographicArea ?PLACE, during the TimeDuration ?PERIOD, 
-- the highest temperature was ?AMOUNT. Temperature may be expressed 
-- in some UnitOfTemperature, including CelsiusDegree and 
-- FahrenheitDegree, among others.
fun highestTemperatureForPeriod : El GeographicArea -> El TimeDuration -> El TemperatureMeasure -> Formula ;


-- (hotSeasonInArea ?AREA ?INTERVAL) 
-- means that in the GeographicArea ?AREA, the hot season occurs 
-- during the TimeInterval ?INTERVAL. For example, (hotSeasonInArea 
-- Angola (RecurringTimeIntervalFn November April)).
fun hotSeasonInArea: El GeographicArea -> Desc TimeInterval -> Formula ;


-- (irrigatedLandArea ?REGION ?AMOUNT) 
-- means that the GeographicArea ?REGION has the ?AMOUNT of irrigated land. 
-- ?AMOUNT may be expressed in physical units or with a percent or fraction.
fun irrigatedLandArea : El GeographicArea -> El ConstantQuantity -> Formula ;


-- (landAreaOnly ?REGION ?MEASURE) means 
-- that the total area(s) of solid ground within the GeographicArea 
-- ?REGION has the AreaMeasure ?AMOUNT. The pieces of solid ground need 
-- not be continuous within the region.
fun landAreaOnly : El GeographicArea -> El AreaMeasure -> Formula ;


-- (lowAltitudeWindSpeed ?PLACE ?RATE) means that the Wind blowing 
-- between 500_10,000 feet at ?PLACE has a speed of ?RATE. Wind speed 
-- may be expressed in knots (KnotUnitOfSpeed) or as any distance per 
-- time unit (using (SpeedFn ?DISTANCE ?TIME)).
fun lowAltitudeWindSpeed : El Object -> El PhysicalQuantity -> Formula ;


-- (lowAltitudeWindVelocity ?PLACE ?SPEED ?DIRECTION) means that the 
-- low_altitude Wind blowing at ?PLACE has a speed of ?SPEED and comes 
-- from the compass point ?DIRECTION. Low_altitude wind is wind blowing 
-- between 500_10,000 feet.
fun lowAltitudeWindVelocity : El Object -> El PhysicalQuantity -> El DirectionalAttribute -> Formula ;


-- (lowTide ?PLACE ?TIME ?AMOUNT) means that 
-- there is a LowTide at the Region ?PLACE at the TimeInterval ?TIME 
-- with the relative height ?AMOUNT. The height is given in relation to 
-- the datum on a standard chart.
fun lowTide : El Region -> El TimeInterval -> El LengthMeasure -> Formula ;


-- (lowestTemperatureForPeriod ?PLACE ?PERIOD ?AMOUNT) means that 
-- at the GeographicArea ?PLACE, during the TimeDuration ?PERIOD, 
-- the highest temperature was ?AMOUNT. Temperature may be expressed 
-- in some UnitOfTemperature, including CelsiusDegree and 
-- FahrenheitDegree, among others.
fun lowestTemperatureForPeriod : El GeographicArea -> El TimeDuration -> El TemperatureMeasure -> Formula ;


-- (magneticVariation ?AREA ?DEGREE ?DIRECTION) means that in the 
-- GeographicArea ?AREA, the magnetic variation of a compass from 
-- 000 degrees true is ?DEGREE AngularDegrees in ?DIRECTION (East 
-- or West).
fun magneticVariation : El GeographicArea -> El PlaneAngleMeasure -> El DirectionalAttribute -> Formula ;


-- (mapOfArea ?AREA ?POINTER) means that a map 
-- of the Region ?AREA can be found at the location ?POINTER.
fun mapOfArea : El Region -> El SymbolicString -> Formula ;


-- (maritimeClaimType ?POLITY ?TYPE) 
-- means that the GeopoliticalArea ?POLITY claims rights over a 
-- MaritimeClaimArea of ?TYPE.
fun maritimeClaimType: El GeopoliticalArea -> Desc MaritimeClaimArea -> Formula ;


-- (meanSeaLevel ?place ?measure) means that the Mean Sea 
-- Level (MSL) at ?place is ?measure. ?measure is a distance representing the sea level 
-- at ?place measured against a benchmark (and averaged over a long time). MSL is measured 
-- by tide gauges for maritime purposes, while geodesists use the difference between the 
-- local sea surface and an ideal level ocean surface (the geoid).
fun meanSeaLevel : El GeographicArea -> El LengthMeasure -> Formula ;


-- (mediumAltitudeWindSpeed ?PLACE ?RATE) means that the Wind 
-- blowing between 10,000_25,000 feet at ?PLACE has a speed of ?RATE.
fun mediumAltitudeWindSpeed : El Object -> El ConstantQuantity -> Formula ;


-- (mediumAltitudeWindVelocity ?PLACE ?SPEED ?TOWARD) means that the 
-- Wind blowing between 10,000_25,000 feet at ?PLACE has a speed of 
-- ?SPEED and is moving toward the DirectionalAttribute ?TOWARD.
fun mediumAltitudeWindVelocity : El Object -> El PhysicalQuantity -> El DirectionalAttribute -> Formula ;


-- (naturalHazardTypeInArea ?AREA ?TYPE) means that in the 
-- GeographicArea ?AREA, Processes of ?TYPE occur with some 
-- frequency and may cause damage or danger to human lives and property.
fun naturalHazardTypeInArea: El GeographicArea -> Desc Physical -> Formula ;


-- (naturalResourceTypeInArea ?REGION ?TYPE) means that the 
-- GeographicArea ?REGION has resources of the kind ?TYPE.
fun naturalResourceTypeInArea: El GeographicArea -> Desc Object -> Formula ;


-- (objectGeographicCoordinates ?OBJECT ?LAT ?LONG) means that 
-- the Object ?OBJECT is found at the geographic coordinates 
-- ?LAT and ?LONG.
fun objectGeographicCoordinates : El Object -> El Latitude -> El Longitude -> Formula ;


-- (oppositeDirection ?DIR1 ?DIR2) 
-- means that the PositionalAttribute ?DIR1 points in the compass 
-- direction opposite to the DirectionalAttribute ?DIR2.
fun oppositeDirection : El PositionalAttribute -> El PositionalAttribute -> Formula ;


-- (orbits ?SATELLITE ?FOCUS) means that the Object 
-- ?SATELLITE revolves around the AstronomicalBody ?FOCUS.
fun orbits : El Object -> El AstronomicalBody -> Formula ;


-- This predicate is used to represent information from the CIA 
-- World Fact Book. (otherLandUseArea ?REGION ?AMOUNT) means that 
-- in the GeographicArea ?REGION, the ?AMOUNT of land has some 
-- use other than planting seasonal or permanent crops. ?AMOUNT may be 
-- expressed in physical units or with a percent or fraction. See also 
-- arableLandArea and permanentLandArea.
fun otherLandUseArea : El GeographicArea -> El ConstantQuantity -> Formula ;


-- (overcastDaysInPeriod ?AREA ?PERIOD ?NUMBER) means that during the 
-- time ?PERIOD, the GeographicArea ?AREA experienced ?NUMBER of 
-- OvercastWeather days.
fun overcastDaysInPeriod : El GeographicArea -> El TimeDuration -> El NonnegativeRealNumber -> Formula ;


-- (partyToAgreement ?AGENT ?PROP) 
-- means that the Agent ?AGENT has committed to the agreement ?PROP.
fun partyToAgreement : El Agent -> El Proposition -> Formula ;


-- (permanentCropLandArea ?REGION ?AMOUNT) means that the GeographicArea 
-- ?REGION has ?AMOUNT of land under cultivation with crops that are not 
-- replanted after each harvest. This includes orchards, vineyards, coffee 
-- and rubber plantations. Timberland is excluded. ?AMOUNT may be expressed 
-- in physical units or with a percent or fraction. Cf. permanentCropLandArea.
fun permanentCropLandArea : El GeographicArea -> El ConstantQuantity -> Formula ;


-- (precipitationAmount ?EVENT ?AMOUNT) means that in the 
-- Precipitation process ?EVENT, the quantity of precipitation 
-- that fell was ?AMOUNT.
fun precipitationAmount : El Precipitation -> El ConstantQuantity -> Formula ;


-- (precipitationRate ?EVENT ?RATE) means that in the 
-- Precipitation ?EVENT, the precipitation falls at a rate 
-- of ?RATE.
fun precipitationRate : El Precipitation -> El FunctionQuantity -> Formula ;


-- (precipitationState ?EVENT ?STATE) means that in the Precipitation 
-- ?EVENT, the stuff falling is in the PhysicalState ?STATE (e.g., 
-- Liquid or Solid ice).
fun precipitationState : El WeatherProcess -> El PhysicalState -> Formula ;


-- (rainySeasonInArea ?AREA ?INTERVAL) 
-- means that in the GeographicArea ?AREA, the rainy or wet season occurs 
-- during the TimeInterval ?INTERVAL. For example, (rainySeasonInArea 
-- Angola (RecurringTimeIntervalFn November April)).
fun rainySeasonInArea: El GeographicArea -> Desc TimeInterval -> Formula ;


-- (regionalIssue ?AREA ?ISSUE) means 
-- that the AreaOfConcern ?ISSUE is relevant to a problem in the 
-- GeographicArea ?AREA.
fun regionalIssue : El GeographicArea -> El AreaOfConcern -> Formula ;


-- (relativeBearing ?OBJ1?OBJ2 ?DEGREES) 
-- means that ?OBJ1 and ?OBJ2 are separated by the amount ?DEGREES of 
-- PlaneAngleMeasure.
fun relativeBearing : El Object -> El Object -> El PlaneAngleMeasure -> Formula ;


-- (relativeHumidity ?AREA ?AMOUNT) 
-- means that the amount of moisture in the air at ?AREA is ?AMOUNT. 
-- Relative humidity expresses the amount of moisture as a percentage, 
-- or ratio, between the actual moisture saturation of the air compared 
-- to the potential moisture saturation of the air. At full (potential) 
-- saturation, precipitation would occur.
fun relativeHumidity : El Object -> El NonnegativeRealNumber -> Formula ;


-- (seaSurfaceTemperature ?AREA ?TEMP) means that the 
-- temperature of the sea surface at ?AREA is ?TEMP. 
-- Temperature may be expressed in some UnitOfTemperature, 
-- including CelsiusDegree and FahrenheitDegree, among others.
fun seaSurfaceTemperature : El WaterArea -> El ConstantQuantity -> Formula ;


-- The length of the boundary 
-- between two GeographicRegions.
fun sharedBorderLength : El GeographicRegion -> El GeographicRegion -> El LengthMeasure -> Formula ;


-- (slopeGradient ?AREA ?SLOPE) means that 
-- in the LandArea ?AREA there is an incline of ?slope, where ?SLOPE is 
-- the percent of vertical rise over horizontal distance. slopeGradient 
-- gives an approximate value for nonzero slope over ?AREA, without regard 
-- to orientation. For example, (slopeGradient ?AREA 0.10) means that 
-- there is a 10% incline across the area, without specifying the 
-- orientation in which the land rises or falls. Also see 
-- slopeGradientTowardsOrientation.
fun slopeGradient : El LandArea -> El NonnegativeRealNumber -> Formula ;


-- (slopeGradientTowardsOrientation ?AREA ?DIRECTION ?SLOPE) means that 
-- in the LandArea ?AREA, there is an incline of ?SLOPE towards the 
-- DirectionalAttribute ?DIRECTION. ?SLOPE is a RationalNumber 
-- representing the percent of vertical rise over horizontal distance.
fun slopeGradientTowardsOrientation : El LandArea -> El DirectionalAttribute -> El RationalNumber -> Formula ;


-- (streamOutfall ?WATER ?RIVER) means that 
-- the WaterArea ?MOUTH is the outfall of the River ?RIVER.
fun streamOutfall : El WaterArea -> El River -> Formula ;


-- (surfaceWindDirection ?PLACE ?DIRECTION) means that at ?PLACE 
-- the wind is coming from the compass point ?DIRECTION. For example, 
-- (surfaceWindDirection SanFranciscoBay Northwest) means that the 
-- wind in San Francisco Bay is coming from the Northwest. The wind is 
-- within 500 feet of Earth's surface.
fun surfaceWindDirection : El Object -> El DirectionalAttribute -> Formula ;


-- (surfaceWindSpeed ?PLACE ?RATE) 
-- means that the speed of the surface Wind at the GeographicArea 
-- ?PLACE is ?RATE. Wind speed may be expressed in knots (KnotUnitOfSpeed) 
-- or as any distance per time unit (using (SpeedFn ?DISTANCE ?TIME)). 
-- Surface wind is found at the surface of the planet, everyday wind. 
-- Technically, Winds moving through the atmosphere up to an altitude 
-- of 500 feet.
fun surfaceWindSpeed : El Object -> El PhysicalQuantity -> Formula ;


-- (surfaceWindVelocity ?PLACE ?SPEED ?TOWARD) means that the 
-- surface Wind blowing at ?PLACE has a speed of ?SPEED and is moving 
-- toward the DirectionalAttribute ?TOWARD. Surface wind is found at the 
-- surface of the planet, everyday wind. Technically, Winds moving 
-- through the atmosphere up to an altitude of 500 feet.
fun surfaceWindVelocity : El Object -> El PhysicalQuantity -> El DirectionalAttribute -> Formula ;


-- (terrainInArea ?AREA ?ATTRIBUTE) 
-- means that the GeographicArea ?AREA is or includes a region with 
-- the features of TerrainArea ?ATTRIBUTE.
fun terrainInArea : El GeographicArea -> El TerrainAttribute -> Formula ;


-- (totalArea ?REGION ?AMOUNT) means that 
-- the total area of ?REGION is the AreaMeasure ?AMOUNT.
fun totalArea : El Region -> El AreaMeasure -> Formula ;


-- (totalBiomass ?PLACE ?MASS) means that the 
-- total amount (in weight or volume) of living matter in the Region 
-- ?PLACE is ?MASS.
fun totalBiomass : El GeographicArea -> El PhysicalQuantity -> Formula ;


-- (totalCoastline ?AREA ?COASTLENGTH) 
-- means that the total length of all boundaries between the GeographicArea 
-- ?AREA and the ocean is the LengthMeasure ?COASTLENGTH. The coastline 
-- counted may be discontinuous and may even be along different oceans (as 
-- in Columbia). A totalCoastline of zero indicates a LandlockedArea. 
-- Note that only Ocean coastlines are counted, not any shores with inland 
-- waters.
fun totalCoastline : El GeographicArea -> El LengthMeasure -> Formula ;


-- (totalLandBoundary ?REGION ?LENGTH) 
-- means that the GeographicArea ?REGION has a total LengthMeasure 
-- ?LENGTH of land boundaries between it and other countries. Note that 
-- the boundaries included in the total length may be discontinuous, as when 
-- interrupted by stretches of Seacoast.
fun totalLandBoundary : El GeographicArea -> El LengthMeasure -> Formula ;


-- (totalPrecipitationForPeriod ?PLACE ?PERIOD ?AMOUNT) means that 
-- at the GeographicArea ?PLACE, and during the TimeDuration ?PERIOD, 
-- the total amount of precipitation was ?AMOUNT.
fun totalPrecipitationForPeriod : El GeographicArea -> El TimeDuration -> El ConstantQuantity -> Formula ;


-- (unratifiedSignatoryToAgreement ?AGENT ?PROP) means that 
-- the Agent ?AGENT has signed a document to begin the process of 
-- committing to the Agreement ?PROP, but that a ratification 
-- process required to complete the commitment has not yet occurred.
fun unratifiedSignatoryToAgreement : El Agent -> El Proposition -> Formula ;


-- (vegetationType ?area ?type) associates 
-- a particular GeographicArea with a type of Plant that is found there.
fun vegetationType : El GeographicArea -> Desc Plant -> Formula ;


-- (vegetationTypePattern ?AREA ?TYPE ?DENSITY) means that in the 
-- GeographicArea ?AREA the Plant ?TYPE is found with ?DENSITY.
fun vegetationTypePattern: El GeographicArea -> Desc Plant -> El Attribute -> Formula ;


-- (warmSeasonInArea ?AREA ?INTERVAL) 
-- means that in the GeographicArea ?AREA, the warm season occurs 
-- during the TimeInterval ?INTERVAL.
fun warmSeasonInArea: El GeographicArea -> Desc TimeInterval -> Formula ;


-- (waterAreaOnly ?REGION ?MEASURE) means 
-- that the total area(s) of surface water within the GeographicArea 
-- ?REGION has the AreaMeasure ?AMOUNT. The pieces of water need not be 
-- continuous within the region.
fun waterAreaOnly : El GeographicArea -> El AreaMeasure -> Formula ;


-- (waterDepth ?AREA ?LENGTH) means that the 
-- depth of water at the Region ?AREA is ?LENGTH.
fun waterDepth : El WaterArea -> El LengthMeasure -> Formula ;


-- (windRelativePosition ?OBJECT ?POSITION) means that the Wind blows 
-- at ?OBJECT from the relative vector ?POSITION. E.g., Crosswind, 
-- Headwind, Tailwind.
fun windRelativePosition : El Object -> El Attribute -> Formula ;
}
