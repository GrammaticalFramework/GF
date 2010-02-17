abstract Transportation = open Merge, Mid_level_ontology in {




-- A Vehicle which is powered by
-- one or more of its passengers or driver, for example, a Bicycle.
fun AgentPoweredVehicle : Class ;
fun AgentPoweredVehicle_Class : SubClass AgentPoweredVehicle Vehicle ;

-- An AirRoute is a region of air space that 
-- can be travelled between points by an air TransportationDevice.
fun AirRoute : Class ;
fun AirRoute_Class : SubClass AirRoute TransitRoute ;

-- The subclass of Transitways that are through
-- the EarthsAtmosphere.
fun AirTransitway : Class ;
fun AirTransitway_Class : SubClass AirTransitway Transitway ;

-- A MilitaryShip on which MilitaryAircraft can land 
-- and take off.
fun AircraftCarrier : Class ;
fun AircraftCarrier_Class : SubClass AircraftCarrier MilitaryShip ;

-- Airplane is the subclass of Aircraft that 
-- are fixed_wing aircraft which carry their own power sources. Airplane 
-- includes jet airplanes and propeller planes, but not gliders.
fun Airplane : Class ;
fun Airplane_Class : SubClass Airplane (both Aircraft PoweredVehicle) ;


-- Airport is the subclass of TransitTerminals 
-- for Airplanes (fixed_wing Aircraft).
fun Airport : Class ;
fun Airport_Class : SubClass Airport (both AirTransitway (both LandTransitway TransitTerminal)) ;


-- AirportByRunwaySurface is a 
-- subclass of AirportClassification attributes used to describe an 
-- airport according to the surface type of its longest runway.
fun AirportByRunwaySurface : Class ;
fun AirportByRunwaySurface_Class : SubClass AirportByRunwaySurface AirportClassification ;

-- AirportClassification 
-- is a class of Attributes for representing systems that categorize 
-- Airports according to some criteria. There are several such systems, 
-- including the International Civil Aviation Organization categories A to 
-- E, based on runway lengths, the Federal Aviation Administration system 
-- associated with airport functions, and the airport categorization by 
-- runway length used in the CIA World Fact Book.
fun AirportClassification : Class ;
fun AirportClassification_Class : SubClass AirportClassification RelationalAttribute ;

-- AirportWithPavedRunway is an 
-- AirportClassification attribute used to describe an airport whose 
-- longest runway is a PavedRunway.
fun AirportWithPavedRunway : Ind AirportByRunwaySurface ;


-- AirportWithUnpavedRunway is 
-- an AirportClassification attribute used to describe an airport whose 
-- longest runway is an UnpavedRunway.
fun AirportWithUnpavedRunway : Ind AirportByRunwaySurface ;


-- The class of Transitways used to transport Air 
-- to a location where it is absent or insufficient.
fun Airway : Class ;
fun Airway_Class : SubClass Airway Transitway ;

-- Ambulance is the subclass of 
-- EmergencyRoadVehicles that represents ambulances.
fun Ambulance : Class ;
fun Ambulance_Class : SubClass Ambulance EmergencyRoadVehicle ;

-- Anchorage is the subclass of WaterAreas 
-- where WaterVehicle may anchor with some shelter or safety. Anchorages 
-- may be inside a Harbor or offshore.
fun Anchorage : Class ;
fun Anchorage_Class : SubClass Anchorage WaterArea ;

fun Barge : Class ;
fun Barge_Class : SubClass Barge WaterVehicle ;
fun BargeCarrierShip : Class ;
fun BargeCarrierShip_Class : SubClass BargeCarrierShip CargoShip ;
-- Bicycle is a class of two_wheeled, 
-- UserPoweredVehicles.
fun Bicycle : Class ;
fun Bicycle_Class : SubClass Bicycle Cycle ;

-- Boxcar is the subclass of Railcars that are 
-- general_purpose closed cars for hauling freight.
fun Boxcar : Class ;
fun Boxcar_Class : SubClass Boxcar FreightCar ;

-- Bridge is the subclass of LandTransitways 
-- that are artifacts used for crossing water or air_filled gaps that 
-- could not be transited over a natural surface.
fun Bridge : Class ;
fun Bridge_Class : SubClass Bridge (both LandTransitway StationaryArtifact) ;


-- BroadGauge is the attribute of 
-- any Railway that has a TrackGauge wider than StandardGauge.
fun BroadGauge : Ind TrackGauge ;


fun BroadGaugeRail : Ind RailGauge ;

fun BroadGaugeRailway : Class ;
fun BroadGaugeRailway_Class : SubClass BroadGaugeRailway Railway ;
fun BulkCargoShip : Class ;
fun BulkCargoShip_Class : SubClass BulkCargoShip DryBulkCarrierShip ;
fun BusinessRailcar : Class ;
fun BusinessRailcar_Class : SubClass BusinessRailcar PassengerRailcar ;
-- CIAAirportLengthClassification is a class of Attributes used to 
-- characterize Airports according to the length of their longest 
-- usable runway.
fun CIAAirportLengthClassification : Class ;
fun CIAAirportLengthClassification_Class : SubClass CIAAirportLengthClassification AirportClassification ;

-- CabCar is the class of passenger railcars 
-- that have an operating cab in one end of the from which train motion 
-- can be controlled in 'push' mode. A CabCar is placed on the 
-- opposite end of the train from the locomotive.
fun CabCar : Class ;
fun CabCar_Class : SubClass CabCar RollingStock ;

fun CableShip : Class ;
fun CableShip_Class : SubClass CableShip Ship ;
fun CanalLock : Class ;
fun CanalLock_Class : SubClass CanalLock (both StationaryArtifact Waterway) ;

fun CanalLockGate : Class ;
fun CanalLockGate_Class : SubClass CanalLockGate (both Device TransitwayObstacle) ;

fun CanalSystem : Class ;
fun CanalSystem_Class : SubClass CanalSystem WaterTransportationSystem ;
fun Canoe : Class ;
fun Canoe_Class : SubClass Canoe (both AgentPoweredVehicle WaterVehicle) ;

-- CarDistributionSystem is the 
-- process of composing trains according to instructions or data.
fun CarDistributionSystem : Class ;
fun CarDistributionSystem_Class : SubClass CarDistributionSystem OrganizationalProcess ;

-- CargoShip is the subclass of Ships that 
-- transport goods in exchange for payment. CargoShip includes ships 
-- that carry all kinds of cargo, including oil and bulk products as well 
-- as packaged, palletized, or containerized goods.
fun CargoShip : Class ;
fun CargoShip_Class : SubClass CargoShip Ship ;

fun Catamaran : Class ;
fun Catamaran_Class : SubClass Catamaran MultihullWaterVehicle ;
fun CementCarrierShip : Class ;
fun CementCarrierShip_Class : SubClass CementCarrierShip DryBulkCarrierShip ;
-- A Channel is a narrow deep waterway connecting 
-- two larger bodies of water. May be natural or dredged, salt or fresh 
-- water.
fun Channel : Class ;
fun Channel_Class : SubClass Channel Waterway ;

-- ChemicalTankerShip is the 
-- subclass of ships that carry ChemicalProducts.
fun ChemicalTankerShip : Class ;
fun ChemicalTankerShip_Class : SubClass ChemicalTankerShip CargoShip ;

fun Chemical_OilTankerShip : Class ;
fun Chemical_OilTankerShip_Class : SubClass Chemical_OilTankerShip ChemicalTankerShip ;
fun ChiefSteward : Ind Position ;

-- ClassIIIRailroad is the 
-- subclass of RailroadCompany whose instances have an 
-- average annual gross revenue below 20.5 million 
-- UnitedStatesDollars.
fun ClassIIIRailroad : Class ;
fun ClassIIIRailroad_Class : SubClass ClassIIIRailroad RailroadCompany ;

-- ClassIIRailroad is the 
-- subclass of RailroadCompany whose instances have an 
-- average annual gross revenue between 20.5 and 256.4 million 
-- UnitedStatesDollars.
fun ClassIIRailroad : Class ;
fun ClassIIRailroad_Class : SubClass ClassIIRailroad RailroadCompany ;

-- ClassIRailroad is the 
-- subclass of RailroadCompany whose instances have an 
-- average annual gross revenue above 256.4 million 
-- UnitedStatesDollars.
fun ClassIRailroad : Class ;
fun ClassIRailroad_Class : SubClass ClassIRailroad RailroadCompany ;

fun CombinationBulkCarrierShip : Class ;
fun CombinationBulkCarrierShip_Class : SubClass CombinationBulkCarrierShip CargoShip ;
fun CombinationBulk_OilCarrierShip : Class ;
fun CombinationBulk_OilCarrierShip_Class : SubClass CombinationBulk_OilCarrierShip CombinationBulkCarrierShip ;
fun CombinationOre_OilCarrierShip : Class ;
fun CombinationOre_OilCarrierShip_Class : SubClass CombinationOre_OilCarrierShip CombinationBulkCarrierShip ;
-- CommonCarrier is the subclass of 
-- TransportationCompany whose instances must offer services to all 
-- customers. Contrast with ContractCarrier.
fun CommonCarrier : Class ;
fun CommonCarrier_Class : SubClass CommonCarrier TransportationCompany ;

fun ContainerPort : Class ;
fun ContainerPort_Class : SubClass ContainerPort PortCity ;
fun ContainerShip : Class ;
fun ContainerShip_Class : SubClass ContainerShip CargoShip ;
fun Container_RoRoCargoShip : Class ;
fun Container_RoRoCargoShip_Class : SubClass Container_RoRoCargoShip RollOnRollOffCargoShip ;
-- ContractCarrier is the subclass of 
-- TransportationCompany whose instances offer services to only one 
-- customer, under contract. Contrast with CommonCarrier.
fun ContractCarrier : Class ;
fun ContractCarrier_Class : SubClass ContractCarrier TransportationCompany ;

fun CraneShip : Class ;
fun CraneShip_Class : SubClass CraneShip Ship ;
-- CrewDormCars are Railcars used for 
-- housing the employee staff on long_distance trains.
fun CrewDormCar : Class ;
fun CrewDormCar_Class : SubClass CrewDormCar PassengerRailcar ;

-- CrudeOilPipeline is the subclass of 
-- Pipelines that are used to carry CrudeOil.
fun CrudeOilPipeline : Class ;
fun CrudeOilPipeline_Class : SubClass CrudeOilPipeline Pipeline ;

-- CruiseShip is the subclass of 
-- PassengerShips designed for the purpose of carrying passengers 
-- on extended trips.
fun CruiseShip : Class ;
fun CruiseShip_Class : SubClass CruiseShip PassengerShip ;

-- CubicFoot is a unit for measuring volume, 
-- equal to a volume of one foot length in each dimension of length, width, 
-- and height.
fun CubicFoot : Ind UnitOfVolume ;


-- Cycle is a class of wheeled, pedal_driven 
-- UserPoweredVehicles that are designed to be ridden on roads or trails.
fun Cycle : Class ;
fun Cycle_Class : SubClass Cycle (both AgentPoweredVehicle LandVehicle) ;


-- Dam is the subclass of StationaryArtifacts that 
-- are walls built across a stream or river to hold back water.
fun Dam : Class ;
fun Dam_Class : SubClass Dam TransitwayObstacle ;

fun DeckCargoShip : Class ;
fun DeckCargoShip_Class : SubClass DeckCargoShip GeneralCargoShip ;
-- DeepDraftHarbor is the subclass 
-- of Harbors that have a waterDepth sufficient to accommodate 
-- vessels of a ladenDraft of 45 feet (13.7 meters) or greater.
fun DeepDraftHarbor : Class ;
fun DeepDraftHarbor_Class : SubClass DeepDraftHarbor Harbor ;

fun DeepDraftPort : Class ;
fun DeepDraftPort_Class : SubClass DeepDraftPort PortCity ;
-- DeepwaterPort is the subclass of 
-- PortFacility whose instances meet the criteria defined under 33 U.S.C. section 1502(1) as 'any fixed or floating man_made structures other than 
-- a vessel, or any group of such structures, located beyond the territorial 
-- sea and off the coast of the United States and which are used or intended 
-- for use as a port or terminal for the loading or unloading and further 
-- handling of oil for transportation to any State.... The term includes all associated components and equipment including pipelines, pumping stations, service platforms, mooring buoys, and similar appurtenances to the extent 
-- they are located seaward of the high water mark.'
fun DeepwaterPort : Class ;
fun DeepwaterPort_Class : SubClass DeepwaterPort PortFacility ;

fun Door_Device : SubClass Door Device ;

fun Door_TransitwayObstacle : SubClass Door TransitwayObstacle ;

fun Drawbridge : Class ;
fun Drawbridge_Class : SubClass Drawbridge MovableBridge ;
fun Dredger : Class ;
fun Dredger_Class : SubClass Dredger Ship ;
fun DrillingShip : Class ;
fun DrillingShip_Class : SubClass DrillingShip Ship ;
fun DryBulkCarrierShip : Class ;
fun DryBulkCarrierShip_Class : SubClass DryBulkCarrierShip CargoShip ;
-- DualGauge is the attribute of 
-- any Railway that has three parallel rails, thus allowing 
-- two different gauges of rolling stock to travel over it.
fun DualGauge : Ind TrackGauge ;


fun DualGaugeRail : Ind RailGauge ;

fun DualGaugeRailway : Class ;
fun DualGaugeRailway_Class : SubClass DualGaugeRailway Railway ;
-- ElectrifiedRailway is the subclass 
-- of Railway representing electrified railways.
fun ElectrifiedRailway : Class ;
fun ElectrifiedRailway_Class : SubClass ElectrifiedRailway Railway ;

-- EmergencyRoadVehicle is the 
-- subclass of EmergencyVehicle that includes RoadVehicles designed 
-- for special use in emergencies, e.g., Ambulances, FireEngines.
fun EmergencyRoadVehicle : Class ;
fun EmergencyRoadVehicle_Class : SubClass EmergencyRoadVehicle (both EmergencyVehicle (both PoweredVehicle RoadVehicle)) ;


-- EmergencyVehicle is the subclass of 
-- Vehicles that are used for special_purpose emergency response.
fun EmergencyVehicle : Class ;
fun EmergencyVehicle_Class : SubClass EmergencyVehicle PoweredVehicle ;

-- Expressway is the subclass of 
-- SurfacedRoadways that are multiple_lane, limited_access highways 
-- designed for rapid travel by MotorVehicles.
fun Expressway : Class ;
fun Expressway_Class : SubClass Expressway SurfacedRoadway ;

fun FerryBoat : Class ;
fun FerryBoat_Class : SubClass FerryBoat WaterVehicle ;
fun FireBoat : Class ;
fun FireBoat_Class : SubClass FireBoat WaterVehicle ;
-- FireEngine is the subclass of 
-- EmergencyRoadVehicles that represents the various vehicles
-- used by a fire department in fighting fires.
fun FireEngine : Class ;
fun FireEngine_Class : SubClass FireEngine EmergencyRoadVehicle ;

fun FirstMate : Ind Position ;

fun FishCarrierShip : Class ;
fun FishCarrierShip_Class : SubClass FishCarrierShip FishingShip ;
fun FishFactoryShip : Class ;
fun FishFactoryShip_Class : SubClass FishFactoryShip FishingShip ;
fun FishingShip : Class ;
fun FishingShip_Class : SubClass FishingShip WaterVehicle ;
fun FishingVessel : Class ;
fun FishingVessel_Class : SubClass FishingVessel FishingShip ;
-- FiveWellStackCars are five_unit 
-- that carry double_stacked containers.
fun FiveWellStackCar : Class ;
fun FiveWellStackCar_Class : SubClass FiveWellStackCar FreightCar ;

fun FixedBridge : Class ;
fun FixedBridge_Class : SubClass FixedBridge (both Bridge StationaryArtifact) ;

-- FlagOfConvenienceRegister is the subclass of ShipRegisters 
-- in which most of the registered ships are owned outside of the 
-- GeopoliticalArea to which the registry belongs. 
-- InternalShipRegisters and OffshoreShipRegisters both may act as 
-- FlagOfConvenienceRegisters, if permitted by the maritime 
-- regulations of the registry owner.
fun FlagOfConvenienceRegister : Class ;
fun FlagOfConvenienceRegister_Class : SubClass FlagOfConvenienceRegister ShipRegister ;

-- Flatcars are Freightcars without sides 
-- or roofs.
fun Flatcar : Class ;
fun Flatcar_Class : SubClass Flatcar (both FreightCar OpenTopRailcar) ;


-- A train car that is designed to
-- carry freight, and not Humans.
fun FreightCar : Class ;
fun FreightCar_Class : SubClass FreightCar RollingStock ;

-- GalleryCars are double_decked passenger 
-- cars that have a viewing area on the second floor.
fun GalleryCar : Class ;
fun GalleryCar_Class : SubClass GalleryCar PassengerRailcar ;

fun GeneralCargoShip : Class ;
fun GeneralCargoShip_Class : SubClass GeneralCargoShip CargoShip ;
fun GliderPlane : Class ;
fun GliderPlane_Class : SubClass GliderPlane (both Aircraft UnpoweredVehicle) ;

-- Harbor is the subclass of WaterAreas that 
-- provide shelter and anchorage for WaterVehicle.
fun Harbor : Class ;
fun Harbor_Class : SubClass Harbor (both WaterArea Waterway) ;


-- HeadEndCars are Railcars that were 
-- typically placed at the front of the train, including mail and 
-- baggage cars.
fun HeadEndCar : Class ;
fun HeadEndCar_Class : SubClass HeadEndCar RollingStock ;

-- Heliport is a TransitTerminal designed 
-- for the takeoff and landing of Helicopters.
fun Heliport : Class ;
fun Heliport_Class : SubClass Heliport TransitTerminal ;

fun HomeGarage : Class ;
fun HomeGarage_Class : SubClass HomeGarage Building ;
fun HopperDredger : Class ;
fun HopperDredger_Class : SubClass HopperDredger Dredger ;
-- HydraCushionFreightCars 
-- are FreightCars with hydraulic underframes to cushion their loads.
fun HydraCushionFreightCar : Class ;
fun HydraCushionFreightCar_Class : SubClass HydraCushionFreightCar FreightCar ;

fun IceBreakerShip : Class ;
fun IceBreakerShip_Class : SubClass IceBreakerShip Ship ;
-- IntermodalTrip is the class of 
-- trips in which more than one mode (road, rail, sea, or air) of 
-- Transportation is used. That is, there are at least two 
-- subProcesses of the trip that use different modes of 
-- TransportationDevice.
fun IntermodalTrip : Class ;
fun IntermodalTrip_Class : SubClass IntermodalTrip Trip ;

-- InternalShipRegister is 
-- a subset of a NationalShipRegister. Ships on an internal 
-- register fly the same flag as on the national register but are 
-- subject to different taxation and crewing rules, which are 
-- typically more lenient. An internal register may function 
-- primarily as a FlagOfConvenienceRegister.
fun InternalShipRegister : Class ;
fun InternalShipRegister_Class : SubClass InternalShipRegister ShipRegister ;

fun JetAirplane : Class ;
fun JetAirplane_Class : SubClass JetAirplane Airplane ;
fun Kayak : Class ;
fun Kayak_Class : SubClass Kayak (both AgentPoweredVehicle WaterVehicle) ;

fun Lane : Class ;
fun Lane_Class : SubClass Lane Roadway ;
fun LightTruck : Class ;
fun LightTruck_Class : SubClass LightTruck Truck ;
fun LiquefiedGasTankerShip : Class ;
fun LiquefiedGasTankerShip_Class : SubClass LiquefiedGasTankerShip CargoShip ;
fun LiquefiedGas_ChemicalTankerShip : Class ;
fun LiquefiedGas_ChemicalTankerShip_Class : SubClass LiquefiedGas_ChemicalTankerShip LiquefiedGasTankerShip ;
fun LivestockCarrierShip : Class ;
fun LivestockCarrierShip_Class : SubClass LivestockCarrierShip CargoShip ;
-- An individual rail vehicle, i.e. a
-- RollingStock which is also a PoweredVehicle. Modern
-- locomotives are typically diesel or electric powered, while
-- older locomotives ran on Coal.
fun Locomotive : Class ;
fun Locomotive_Class : SubClass Locomotive (both PoweredVehicle RollingStock) ;


-- LocomotiveCoalCars are 
-- Railcars put directly behind the Locomotive and used for 
-- carrying fuel coal for the engine.
fun LocomotiveCoalCar : Class ;
fun LocomotiveCoalCar_Class : SubClass LocomotiveCoalCar RollingStock ;

-- LongRunwayAirport is a CIA 
-- category for Airports whose longest runway has a length between 
-- 2,438 meters and 3,047 meters, inclusive.
fun LongRunwayAirport : Ind CIAAirportLengthClassification ;


-- LongTon is the UnitOfMeasure, 
-- equal to 2,240 PoundMass, which is used to measure Dead Weight 
-- Tonnage capacity of Ships.
fun LongTon : Ind UnitOfMass ;


-- ManufacturedProduct is 
-- the subclass of Product that includes goods that are produced 
-- or assembled in factories or other manufacturing processes, 
-- in contrast to AgriculturalProducts.
fun ManufacturedProduct : Class ;
fun ManufacturedProduct_Class : SubClass ManufacturedProduct Product ;

-- MediumLengthRunwayAirport is a CIA 
-- category for Airports whose longest runway has a length between 
-- 1,524 meters and 2,437 meters, inclusive.
fun MediumLengthRunwayAirport : Ind CIAAirportLengthClassification ;


-- MerchantMarine is a class of 
-- Collections of Ships, each collection belonging to a particular 
-- Nation or GeopoliticalArea, in whose ShipRegister the member 
-- ships are enrolled. For example, the merchant marine of France.
fun MerchantMarine : Class ;
fun MerchantMarine_Class : SubClass MerchantMarine Collection ;

-- (MerchantMarineFn ?AREA) denotes 
-- the Collection of all commercial ships registered in the 
-- ShipRegister of the GeopoliticalArea ?AREA.
fun MerchantMarineFn : El GeopoliticalArea -> Ind MerchantMarine ;


-- MerchantMarineShip is the class 
-- of Ships that carry goods or passengers in exchange for payment. 
-- This excludes military ships, as well as working ships such as tugboats 
-- and fishing vessels. Merchant Marine ships belong to the 
-- MerchantMarine of some country and are registered in the related 
-- ShipRegister.
fun MerchantMarineShip : Class ;
fun MerchantMarineShip_Class : SubClass MerchantMarineShip Ship ;

fun MotorHopper : Class ;
fun MotorHopper_Class : SubClass MotorHopper Ship ;
-- MotorRailcars are PassengerRailcars 
-- that carry their own power source.
fun MotorRailcar : Class ;
fun MotorRailcar_Class : SubClass MotorRailcar (both PassengerRailcar PoweredVehicle) ;


fun MotorScooter : Class ;
fun MotorScooter_Class : SubClass MotorScooter RoadVehicle ;
fun Motorcycle_RoadVehicle : SubClass Motorcycle RoadVehicle ;

fun MovableBridge : Class ;
fun MovableBridge_Class : SubClass MovableBridge Bridge ;
-- MultiModalTransitSystem is 
-- the class of TransitSystems that accommodate more than one type of 
-- transportation device or method.
fun MultiModalTransitSystem : Class ;
fun MultiModalTransitSystem_Class : SubClass MultiModalTransitSystem TransitSystem ;

fun MultifunctionalLargeLoadCarrierShip : Class ;
fun MultifunctionalLargeLoadCarrierShip_Class : SubClass MultifunctionalLargeLoadCarrierShip CargoShip ;
fun MultihullWaterVehicle : Class ;
fun MultihullWaterVehicle_Class : SubClass MultihullWaterVehicle WaterVehicle ;
-- MultipleTrackRailway is the 
-- subclass of Railway whose instances consists of two or more sets of 
-- tracks running in parallel, allowing motion in both directions along 
-- a route without the need for sidings and delays.
fun MultipleTrackRailway : Class ;
fun MultipleTrackRailway_Class : SubClass MultipleTrackRailway Railway ;

-- NarrowGauge is the attribute 
-- of any Railway that has a TrackGauge narrower than 
-- StandardGauge. There are several common track widths 
-- among NarrowGauge railways.
fun NarrowGauge : Ind TrackGauge ;


fun NarrowGaugeRail : Ind RailGauge ;

fun NarrowGaugeRailway : Class ;
fun NarrowGaugeRailway_Class : SubClass NarrowGaugeRailway Railway ;
-- A NationalShipRegister 
-- is a record of the Ships that are officially registered with 
-- a particular Nation, including their tonnage and ownership.
fun NationalShipRegister : Class ;
fun NationalShipRegister_Class : SubClass NationalShipRegister ShipRegister ;

-- NaturalGasPipeline is the subclass 
-- of Pipelines that are used to carry NaturalGas.
fun NaturalGasPipeline : Class ;
fun NaturalGasPipeline_Class : SubClass NaturalGasPipeline Pipeline ;

-- NorthernSeaRoute represents the 
-- seasonal waterway in the ArcticOcean adjacent to Russia and 
-- Norway.
fun NorthernSeaRoute : Ind Waterway ;


-- NorthwestPassage represents the 
-- seasonal waterway in the ArcticOcean adjacent to Canada and the 
-- UnitedStates.
fun NorthwestPassage : Ind Waterway ;


-- OceanLiner is the subclass of Ships 
-- that make regularly scheduled voyages to transport people and goods 
-- from one place to another.
fun OceanLiner : Class ;
fun OceanLiner_Class : SubClass OceanLiner (both CargoShip PassengerShip) ;


-- OffshoreAnchorage is the subclass 
-- of Anchorages that are located offshore and not within a Harbor.
fun OffshoreAnchorage : Class ;
fun OffshoreAnchorage_Class : SubClass OffshoreAnchorage Anchorage ;

-- OffshoreShipRegister is 
-- the class of ShipRegisters maintained by a colony, territory, or 
-- possession (OffshoreArea) of a nation. Typically such a register has more lenient maritime 
-- regulations with respect to taxation and crewing of ships than does 
-- the national register associated with the country of which the 
-- offshore area is a dependency.
fun OffshoreShipRegister : Class ;
fun OffshoreShipRegister_Class : SubClass OffshoreShipRegister ShipRegister ;

fun OffshoreSupplyShip : Class ;
fun OffshoreSupplyShip_Class : SubClass OffshoreSupplyShip Ship ;
fun OffshoreSupportShip : Class ;
fun OffshoreSupportShip_Class : SubClass OffshoreSupportShip Ship ;
fun OffshoreWellProductionShip : Class ;
fun OffshoreWellProductionShip_Class : SubClass OffshoreWellProductionShip Ship ;
-- OpenTopRailcars are FreightCars 
-- that have no roof. They may have sides or not.
fun OpenTopRailcar : Class ;
fun OpenTopRailcar_Class : SubClass OpenTopRailcar FreightCar ;

-- (OperatingFn ?DEVICE) denotes the class 
-- of events in which a Device of type ?device is operated.
fun OperatingFn: El Device -> Desc Process ;


fun OreCarrierShip : Class ;
fun OreCarrierShip_Class : SubClass OreCarrierShip DryBulkCarrierShip ;
-- OutfitCars are Railcars used for housing 
-- railway construction or maintenance workers in the field. Also called 
-- 'Camp Cars'.
fun OutfitCar : Class ;
fun OutfitCar_Class : SubClass OutfitCar RollingStock ;

fun PCCCar : Class ;
fun PCCCar_Class : SubClass PCCCar Streetcar ;
fun PalletizedCargoShip : Class ;
fun PalletizedCargoShip_Class : SubClass PalletizedCargoShip GeneralCargoShip ;
fun ParkingGarage : Class ;
fun ParkingGarage_Class : SubClass ParkingGarage Building ;
fun PassengerAndCargoShip : Class ;
fun PassengerAndCargoShip_Class : SubClass PassengerAndCargoShip (both CargoShip PassengerShip) ;

-- A train car that is designed to
-- carry Humans.
fun PassengerRailcar : Class ;
fun PassengerRailcar_Class : SubClass PassengerRailcar (both PassengerVehicle RollingStock) ;


-- PassengerShip is the subclass of 
-- WaterVehicle designed for the purpose of carrying passengers.
fun PassengerShip : Class ;
fun PassengerShip_Class : SubClass PassengerShip Ship ;

fun PassengerVehicle_Vehicle : SubClass PassengerVehicle Vehicle ;

fun Passenger_LandingCraft : Class ;
fun Passenger_LandingCraft_Class : SubClass Passenger_LandingCraft (both PassengerAndCargoShip RollOnRollOffCargoShip) ;

fun Paved : Ind Attribute ;

-- PavedRunway is the subclass of Runways 
-- that are surfaced with concrete or asphalt.
fun PavedRunway : Class ;
fun PavedRunway_Class : SubClass PavedRunway Runway ;

-- PersonalWatercraft is the class 
-- of motor_driven WaterVehicle ridden by one or more passengers, e.g., 
-- a JetSki.
fun PersonalWatercraft : Class ;
fun PersonalWatercraft_Class : SubClass PersonalWatercraft WaterVehicle ;

-- PetroleumProductPipeline is the subclass of Pipelines that are 
-- used to carry PetroleumProducts.
fun PetroleumProductPipeline : Class ;
fun PetroleumProductPipeline_Class : SubClass PetroleumProductPipeline Pipeline ;

fun PetroleumTankerShip : Class ;
fun PetroleumTankerShip_Class : SubClass PetroleumTankerShip CargoShip ;
-- PlaningHullWaterVehicle is a subclass 
-- of WaterVehicle with hulls designed for a position partially on or above 
-- the water surface when they are in motion, in order to reduce drag. See 
-- also DisplacementHullWaterVehicle.
fun PlaningHullWaterVehicle : Class ;
fun PlaningHullWaterVehicle_Class : SubClass PlaningHullWaterVehicle WaterVehicle ;

fun PontoonBridge : Class ;
fun PontoonBridge_Class : SubClass PontoonBridge MovableBridge ;
-- PortCity is the subclass of City whose 
-- instances are cities or towns located adjacent to a Harbor, which is 
-- included in the administrative area of the city.
fun PortCity : Class ;
fun PortCity_Class : SubClass PortCity City ;

-- PortFacility is the class of port 
-- complexes, including piers and docking space, moorings, cargo_handling 
-- and other support facilities for marine traffic. Ships are loaded and 
-- unloaded at a PortFacility.
fun PortFacility : Class ;
fun PortFacility_Class : SubClass PortFacility GeopoliticalArea ;

-- (PortFacilityFn ?CITY) denotes the 
-- PortFacility, including mooring areas, docking space, and on_land 
-- support facilities for marine traffic, of the Port ?CITY, considered 
-- as a whole.
fun PortFacilityFn : El PortCity -> Ind PortFacility ;


fun PrivateRailcar : Class ;
fun PrivateRailcar_Class : SubClass PrivateRailcar RollingStock ;
fun PropellerJet : Class ;
fun PropellerJet_Class : SubClass PropellerJet Airplane ;
fun PropellerPlane : Class ;
fun PropellerPlane_Class : SubClass PropellerPlane Airplane ;
fun PusherTug : Class ;
fun PusherTug_Class : SubClass PusherTug TugBoat ;
fun RadioOperator : Ind Position ;

-- RailCarrierControl is the process of 
-- controlling the speed or direction of a train by sending high or 
-- low frequency currents on the rails.
fun RailCarrierControl : Class ;
fun RailCarrierControl_Class : SubClass RailCarrierControl Guiding ;

fun RailGauge : Class ;
fun RailGauge_Class : SubClass RailGauge InternalAttribute ;
-- RailJunction is the subclass of 
-- TransitwayJunctions where two or more Railway lines come together.
fun RailJunction : Class ;
fun RailJunction_Class : SubClass RailJunction (both Railway TransitwayJunction) ;


-- Railcar is the subclass of RollingStock that 
-- includes all non_locomotive, non_self_powered RailVehicles.
fun Railcar : Class ;
fun Railcar_Class : SubClass Railcar RollingStock ;

fun RailcarCarrierShip : Class ;
fun RailcarCarrierShip_Class : SubClass RailcarCarrierShip RollOnRollOffCargoShip ;
-- RailroadTrack is the class of 
-- StationaryArtifacts consisting of rails laid on supports to form 
-- a track for railway vehicles.
fun RailroadTrack : Class ;
fun RailroadTrack_Class : SubClass RailroadTrack StationaryArtifact ;

-- Railway is the subclass of 
-- LandTransitways that have rails along which Trains may travel. 
-- A railway consists of the rail bed, sleepers, tracks, electric 
-- rails, switches, sensors, lights, crossing grades, and any other 
-- integral machinery or parts of a section of railway.
fun Railway : Class ;
fun Railway_Class : SubClass Railway (both LandTransitway StationaryArtifact) ;


-- RailwayTerminal is the subclass of 
-- TransitTerminals designed for Trains. A RailwayTerminal includes 
-- all the RailroadTrack and any outbuildings or other related structure 
-- in the terminal, as well as the TrainStation (if there is one).
fun RailwayTerminal : Class ;
fun RailwayTerminal_Class : SubClass RailwayTerminal TransitTerminal ;

fun RefrigeratedCargoShip : Class ;
fun RefrigeratedCargoShip_Class : SubClass RefrigeratedCargoShip CargoShip ;
fun RefrigeratorCar : Class ;
fun RefrigeratorCar_Class : SubClass RefrigeratorCar Boxcar ;
-- RegistryTon is a unit of
-- measure used to represent the Gross Registered Tonnage (GRT) capacity
-- of Ships. GRT is based on a volume measure, with one RegistryTon
-- equal to a volume of 100 cubic feet.
fun RegistryTon : Ind UnitOfVolume ;


fun ResearchShip : Class ;
fun ResearchShip_Class : SubClass ResearchShip Ship ;
-- RiverPort is the subclass of PortCity 
-- whose instances are port cities Adjacent to a navigable River.
fun RiverPort : Class ;
fun RiverPort_Class : SubClass RiverPort PortCity ;

-- RoadJunction is the subclass of 
-- TransitwayJunctions where two or more Roadways come together.
fun RoadJunction : Class ;
fun RoadJunction_Class : SubClass RoadJunction (both Roadway TransitwayJunction) ;


fun Road_Roadway : SubClass Road Roadway ;

fun Rocket_Aircraft : SubClass Rocket Aircraft ;

fun RollOnRollOffCargoShip : Class ;
fun RollOnRollOffCargoShip_Class : SubClass RollOnRollOffCargoShip CargoShip ;


fun RotaryDumpCar : Class ;
fun RotaryDumpCar_Class : SubClass RotaryDumpCar OpenTopRailcar ;

fun Runabout : Class ;
fun Runabout_Class : SubClass Runabout WaterVehicle ;
-- Runway is the class of Transitways that are 
-- used for the takeoff and landing of Airplanes. Runways are 
-- Transitways for an intermodal transit, which begins with a land transit 
-- and ends with air transit, or vice versa. The Airspace immediately 
-- above (and adjacent to) a Runway is an AirTransitway.
fun Runway : Class ;
fun Runway_Class : SubClass Runway LandTransitway ;

fun Sailboat : Class ;
fun Sailboat_Class : SubClass Sailboat WaterVehicle ;
-- ScaleTestCars are Railcars of 
-- known weight used to test or calibrate track scales used for 
-- weighing freight.
fun ScaleTestCar : Class ;
fun ScaleTestCar_Class : SubClass ScaleTestCar RollingStock ;

fun Scooter : Class ;
fun Scooter_Class : SubClass Scooter (both AgentPoweredVehicle LandVehicle) ;

fun SeaLane : Class ;
fun SeaLane_Class : SubClass SeaLane Waterway ;
-- SeaPort is the subclass of PortCity 
-- whose instances are port cities on or closely linked to a Sea or 
-- Ocean.
fun SeaPort : Class ;
fun SeaPort_Class : SubClass SeaPort PortCity ;

fun SecondaryHighway : Class ;
fun SecondaryHighway_Class : SubClass SecondaryHighway Roadway ;
fun SelfDischargingBulkCarrierShip : Class ;
fun SelfDischargingBulkCarrierShip_Class : SubClass SelfDischargingBulkCarrierShip DryBulkCarrierShip ;
-- ShipBerth is the class of areas where 
-- a Ship may be moored, whether at an Anchorage or dock.
fun ShipBerth : Class ;
fun ShipBerth_Class : SubClass ShipBerth WaterArea ;

-- ShipBerthing is the class of 
-- Translocation processes in which a vessel is brought to a 
-- mooring, at dockside or anchorage.
fun ShipBerthing : Class ;
fun ShipBerthing_Class : SubClass ShipBerthing Translocation ;

-- (ShipBerthingFn ?SHIP) denotes the 
-- class of ShipBerthings of an individual WaterVehicle ?SHIP.
fun ShipBerthingFn: El Ship -> Desc ShipBerthing ;


-- ShipCabin is the subclass of all 
-- ShipCompartments for accommodating Humans aboard a ship.
fun ShipCabin : Class ;
fun ShipCabin_Class : SubClass ShipCabin ShipCompartment ;

-- A ShipCompartment is any fully or 
-- partly bounded section of a Ship.
fun ShipCompartment : Class ;
fun ShipCompartment_Class : SubClass ShipCompartment Artifact ;

-- ShipContainer is the class of specialized 
-- large containers designed for shipping goods aboard ContainerShips.
fun ShipContainer : Class ;
fun ShipContainer_Class : SubClass ShipContainer SelfConnectedObject ;

-- A ShipCrew is an Organization of people 
-- who operate a Ship, Plane, Train, or other transportation vehicle.
fun ShipCrew : Class ;
fun ShipCrew_Class : SubClass ShipCrew Organization ;

-- (ShipCrewFn ?BOAT) denotes the 
-- Organization consisting of the people charged with operating 
-- the WaterVehicle ?BOAT.
fun ShipCrewFn : El WaterVehicle -> Ind Group ;


-- ShipDeck is the class of decks on a ship, 
-- considered as spaces or Regions in which passengers and crew work, 
-- live, or ride, and/or in which machinery and cargo are stored on a 
-- Ship.
fun ShipDeck : Class ;
fun ShipDeck_Class : SubClass ShipDeck Artifact ;

-- A ShipRegister is a record of each Ship 
-- and owner registered with the maritime authorities of a country or 
-- possession, colony, or territory of a country. Ships on the 
-- ShipRegister of a given region fly the flag of that region and are 
-- subject to its maritime regulations and rules of taxation.
fun ShipRegister : Class ;
fun ShipRegister_Class : SubClass ShipRegister ContentBearingObject ;

-- (ShipRegisterFn ?AREA) 
-- denotes the ShipRegister of the Ships that fly the flag of 
-- the GeopoliticalArea ?AREA.
fun ShipRegisterFn : El GeopoliticalArea -> Ind ShipRegister ;


-- ShipRegistration is the official 
-- document containing information about the ownership, size, and 
-- flag state (flag of registry) of an individual Ship, as registered 
-- in the ShipRegister maintained by the maritime authorities of a 
-- particular Nation or OverseasArea of a nation. A ship flies the 
-- flag of its registered nation or area, and the ship is subject to the 
-- maritime regulations and rules of taxation of its flagState.
fun ShipRegistration : Class ;
fun ShipRegistration_Class : SubClass ShipRegistration ContentBearingObject ;

fun ShippingChannel : Class ;
fun ShippingChannel_Class : SubClass ShippingChannel Waterway ;
fun ShippingLane : Class ;
fun ShippingLane_Class : SubClass ShippingLane Waterway ;
-- ShortRunwayAirport is a CIA 
-- category for Airports whose longest runway has a length between 914 
-- meters and 1523 meters, inclusive.
fun ShortRunwayAirport : Ind CIAAirportLengthClassification ;


fun ShortSeaPassengerShip : Class ;
fun ShortSeaPassengerShip_Class : SubClass ShortSeaPassengerShip PassengerShip ;
fun SludgeDisposalVessel : Class ;
fun SludgeDisposalVessel_Class : SubClass SludgeDisposalVessel Ship ;
fun SpecializedTankerShip : Class ;
fun SpecializedTankerShip_Class : SubClass SpecializedTankerShip CargoShip ;
-- SpineCars are articulated Flatcars 
-- used to carry trailers or containers.
fun SpineCar : Class ;
fun SpineCar_Class : SubClass SpineCar Flatcar ;

-- StandardGauge is the attribute 
-- of Railways having the standardized track width that is 
-- used in North America and most Western European countries. 
-- The standard is typically a distance of 4 ft., 8_1/2 inches 
-- (1.44 meters). There is some variation within which usage is 
-- compatible, e.g., 1.35 meters. Standard gauge originated in 
-- England and was mandated by the U.S. Federal government for the 
-- U.S. Transcontinental Railroad. It is also used in Canada, 
-- Great Britain, and most of Western Europe (but not in Ireland, 
-- or Spain and Portugal.
fun StandardGauge : Ind TrackGauge ;


fun StandardGaugeRail : Ind RailGauge ;

fun StandardGaugeRailway : Class ;
fun StandardGaugeRailway_Class : SubClass StandardGaugeRailway Railway ;
fun Street : Class ;
fun Street_Class : SubClass Street Roadway ;
fun Streetcar_RollingStock : SubClass Streetcar RollingStock ;

-- SurfacedRoadway is the subclass of 
-- Roadways that have been improved by covering them with a substance 
-- to increase the hardness and smoothness of the surface. Covering 
-- materials include pavement, concrete, asphalt, macadam, and gravel.
fun SurfacedRoadway : Class ;
fun SurfacedRoadway_Class : SubClass SurfacedRoadway Roadway ;

-- TankCars are enclosed FreightCars used 
-- to carry fluids.
fun TankCar : Class ;
fun TankCar_Class : SubClass TankCar FreightCar ;

-- A TerminalBuilding is a Building 
-- located at a TransitTerminal and used in connection with its 
-- functions.
fun TerminalBuilding : Class ;
fun TerminalBuilding_Class : SubClass TerminalBuilding Building ;

fun TollBooth : Class ;
fun TollBooth_Class : SubClass TollBooth Building ;
-- TrackGauge is the collection of 
-- attributes that characterize sections of railways, according 
-- to the set distances between the two tracks of the Railway. 
-- Precisely, the measurement of track gauge is the distance 
-- between the inner vertical surfaces of the heads of the rails. 
-- Track gauges include broad, dual, standard, and narrow gauges.
fun TrackGauge : Class ;
fun TrackGauge_Class : SubClass TrackGauge InternalAttribute ;

fun TrafficLight : Class ;
fun TrafficLight_Class : SubClass TrafficLight Device ;
fun Trail : Class ;
fun Trail_Class : SubClass Trail LandTransitway ;
-- Any RoadVehicle that is also an UnpoweredVehicle,
-- and intended to be towed by a PoweredVehicle.
fun Trailer : Class ;
fun Trailer_Class : SubClass Trailer (both RoadVehicle UnpoweredVehicle) ;


-- Train is the subclass of 
-- TransportationDevice whose instances are linked sequences 
-- of RollingStock.
fun Train : Class ;
fun Train_Class : SubClass Train (both Collection (both PoweredVehicle RailVehicle)) ;


-- TrainStation is the subclass of 
-- Buildings that are located at a RailwayTerminal and used in support 
-- of its functions, especially for the handling of passengers and freight.
fun TrainStation : Class ;
fun TrainStation_Class : SubClass TrainStation (both TerminalBuilding TransitTerminal) ;


-- (TransitFn ?WAY) denotes the class of 
-- Translocations that consist of travelling along the Transitway 
-- ?WAY.
fun TransitFn: El Transitway -> Desc Translocation ;


-- TransitRoute is the class of 
-- Regions that are paths for Motion from one place to another.
fun TransitRoute : Class ;
fun TransitRoute_Class : SubClass TransitRoute Region ;

-- TransitShelter is the class of 
-- structures that provide shelter for passengers waiting at a 
-- TransitStop.
fun TransitShelter : Class ;
fun TransitShelter_Class : SubClass TransitShelter Artifact ;

-- TransitStop is the subclass of places 
-- where a vehicle of a scheduled or common carrier makes a stop to 
-- discharge or take on passengers or goods.
fun TransitStop : Class ;
fun TransitStop_Class : SubClass TransitStop Region ;

-- A TransitTerminal is a place where 
-- travellers or transportation devices begin or end their journeys, or 
-- where passengers and/or goods may be transferred. At a terminal, 
-- TransportationDevices may be received, assigned, sent out, or 
-- stored.
fun TransitTerminal : Class ;
fun TransitTerminal_Class : SubClass TransitTerminal StationaryArtifact ;

-- TransitwayJunction is the class of 
-- regions where two or more Transitways meet and traffic may transfer 
-- from one transitway to another.
fun TransitwayJunction : Class ;
fun TransitwayJunction_Class : SubClass TransitwayJunction Transitway ;

-- TransitwayObstacle is the general 
-- class of Objects that can act as obstacles to Motion along a 
-- Transitway.
fun TransitwayObstacle : Class ;
fun TransitwayObstacle_Class : SubClass TransitwayObstacle Object ;

-- TransportationAuthority is the class of Organizations that are 
-- responsible for one or more systems of transportation, usually within 
-- a particular GeopoliticalArea.
fun TransportationAuthority : Class ;
fun TransportationAuthority_Class : SubClass TransportationAuthority Organization ;

fun TransportationDevice_TransportationEquipment : SubClass TransportationDevice TransportationEquipment ;

fun TransportationEquipment : Class ;
fun TransportationEquipment_Class : SubClass TransportationEquipment ManufacturedProduct ;
-- (TransportationFn ?TYPE) denotes the subclass of Transportation 
-- events in which a TransportationDevice of ?TYPE is the vehicle.
fun TransportationFn: Desc TransportationDevice -> Desc Transportation ;


fun Trawler : Class ;
fun Trawler_Class : SubClass Trawler FishingShip ;
-- Trip is the subclass of Motions along a 
-- TransitRoute or Transitway.
fun Trip : Class ;
fun Trip_Class : SubClass Trip Motion ;

-- (TripFn ?VEHICLE) denotes the subclass of Transportation 
-- events in which a particular TransportationDevice ?VEHICLE is the 
-- vehicle. Contrast this function with TransportationFn, which is 
-- used to denote transportation events by a specific kind of vehicle.
fun TripFn: El Vehicle -> Desc Transportation ;


fun TugBoat : Class ;
fun TugBoat_Class : SubClass TugBoat WaterVehicle ;
-- Tunnel is a subclass of Transitways that 
-- consist of a lengthwise enclosed Hole that allows for transit 
-- underground, as through mountains, below a body of water, or beneath a 
-- city.
fun Tunnel : Class ;
fun Tunnel_Class : SubClass Tunnel (both LandTransitway StationaryArtifact) ;


-- UniModalTransitSystem is 
-- the class of TransitSystems that accommodate a single type of 
-- transportation device or method.
fun UniModalTransitSystem : Class ;
fun UniModalTransitSystem_Class : SubClass UniModalTransitSystem TransitSystem ;

fun Unpaved : Ind Attribute ;

-- UnpavedRunways include Runways with 
-- grass, dirt, sand, or gravel surfaces. Contrast with PavedRunway.
fun UnpavedRunway : Class ;
fun UnpavedRunway_Class : SubClass UnpavedRunway Runway ;

-- A Vehicle that lacks a powerComponent.
-- It coasts like a glider or skateboard, thus deriving its power from the
-- potential energy of gravity, or by the power of its agent, as in a bicycle.
fun UnpoweredVehicle : Class ;
fun UnpoweredVehicle_Class : SubClass UnpoweredVehicle Vehicle ;

-- UnsurfacedRoadway is the subclass 
-- of Roadways that have natural, unimproved surfaces of dirt or sand.
fun UnsurfacedRoadway : Class ;
fun UnsurfacedRoadway_Class : SubClass UnsurfacedRoadway Roadway ;

fun UreaCarrierShip : Class ;
fun UreaCarrierShip_Class : SubClass UreaCarrierShip DryBulkCarrierShip ;
fun VehicleCarrierShip : Class ;
fun VehicleCarrierShip_Class : SubClass VehicleCarrierShip RollOnRollOffCargoShip ;
-- VehicleRegistration is the class 
-- of official documents containing information about a vehicle's ownership 
-- and identifying characteristics, as required by the appropriate authority 
-- for the type and location of individual vehicles.
fun VehicleRegistration : Class ;
fun VehicleRegistration_Class : SubClass VehicleRegistration ContentBearingObject ;

-- VeryLongRunwayAirport is a CIA 
-- category for Airports whose longest runway has a length greater 
-- than 3,047 meters.
fun VeryLongRunwayAirport : Ind CIAAirportLengthClassification ;


-- VeryShortRunwayAirport is a CIA 
-- category for Airports whose longest runway is less than 914 meters 
-- long.
fun VeryShortRunwayAirport : Ind CIAAirportLengthClassification ;


-- WaterJunction is the subclass of 
-- TransitwayJunctions where two or more Waterways come together.
fun WaterJunction : Class ;
fun WaterJunction_Class : SubClass WaterJunction (both TransitwayJunction Waterway) ;


fun WaterTransportationSystem : Class ;
fun WaterTransportationSystem_Class : SubClass WaterTransportationSystem TransitSystem ;
-- Waterway is the class of navigable waters, 
-- including Oceans, SeaLanes, Rivers, Canals, Lakes, and inland 
-- bodies of water.
fun Waterway : Class ;
fun Waterway_Class : SubClass Waterway (both Transitway WaterArea) ;


fun WoodChipsCarrierShip : Class ;
fun WoodChipsCarrierShip_Class : SubClass WoodChipsCarrierShip DryBulkCarrierShip ;
-- (cargoType ?DEVICE ?TYPE) means that the 
-- TransportationDevice ?DEVICE typically carries cargo of the kind 
-- ?TYPE.
fun cargoType: El TransportationDevice -> Desc Object -> Formula ;


-- (fOCShipsByOrigin ?MM ?AREA ?COUNT) means that the 
-- MerchantMarine ?MM has ?COUNT number of ships from the 
-- GeopoliticalArea ?AREA in its ShipRegister, using it as 
-- a FlagOfConvenience, although the owner of the ships is in 
-- ?AREA.
fun fOCShipsByOrigin : El MerchantMarine -> El GeopoliticalArea -> El NonnegativeInteger -> Formula ;


-- (flagState ?SHIP ?AREA) means that 
-- the Ship ?SHIP is enrolled in the ShipRegister of the 
-- GeopoliticalArea ?AREA and is subject to its maritime laws, 
-- regulations for operation of the ship, and rules of taxation.
fun flagState : El WaterVehicle -> El GeopoliticalArea -> Formula ;


-- (fleetDeadWeightTonnage ?FLEET ?AMOUNT) means that the Collection 
-- of Ships ?FLEET has a total carrying capacity of ?AMOUNT in LongTons. 
-- This is the total vesselDeadWeightTonnage of all the vessels combined. 
-- Dead Weight Tonnage, or DWT, is the weight of cargo plus stores that a 
-- vessel can carry when immersed to the proper load line.
fun fleetDeadWeightTonnage : El Collection -> El MassMeasure -> Formula ;


-- (fleetGrossRegisteredTonnage ?FLEET ?AMOUNT) means that the 
-- Collection of Ships ?FLEET has a total carrying capacity of ?AMOUNT 
-- in RegistryTons. This is the total vesselGrossRegisteredTonnage of 
-- all the vessels combined. Gross Registered Tonnage, or GRT, is the 
-- capacity of a vessel calculated on an equivalence of 100 cubic feet of 
-- sheltered area per ton.
fun fleetGrossRegisteredTonnage : El Collection -> El PhysicalQuantity -> Formula ;


-- (ladenDraft ?SHIP ?AMOUNT) means that 
-- the WaterVehicle ?SHIP requires a waterDepth of at least ?AMOUNT 
-- to sail without running aground, when she is loaded at capacity.
fun ladenDraft : El WaterVehicle -> El LengthMeasure -> Formula ;


-- (lengthOfBroadGaugeRailway ?AREA ?LENGTH) means that the sum length 
-- of broad gauge railway routes in the GeographicArea ?AREA is the 
-- LengthMeasure ?LENGTH.
fun lengthOfBroadGaugeRailway : El GeographicArea -> El LengthMeasure -> Formula ;


-- (lengthOfCrudeOilPipeline ?AREA ?AMOUNT) means that in the 
-- GeograpicArea ?AREA there is the LengthMeasure ?AMOUNT of 
-- CrudeOilPipeline.
fun lengthOfCrudeOilPipeline : El GeographicArea -> El LengthMeasure -> Formula ;


-- (lengthOfDualGaugeRailway ?AREA ?LENGTH) means that the sum length 
-- of dual gauge railway routes in the GeographicArea ?AREA is the 
-- LengthMeasure ?LENGTH.
fun lengthOfDualGaugeRailway : El GeographicArea -> El LengthMeasure -> Formula ;


-- (lengthOfElectrifiedRailway ?AREA ?LENGTH) means that the sum 
-- length of all ElectrifiedRailway routes in the GeographicArea 
-- ?AREA is the LengthMeasure ?LENGTH.
fun lengthOfElectrifiedRailway : El GeographicArea -> El LengthMeasure -> Formula ;


-- (lengthOfExpresswaySystem ?AREA ?LENGTH) means that the total length 
-- of Expressway in the GeographicArea ?AREA is ?LENGTH.
fun lengthOfExpresswaySystem : El GeographicArea -> El LengthMeasure -> Formula ;


-- (lengthOfMultipleTrackRailway ?AREA ?LENGTH) means that the sum 
-- length of all MultipleTrackRailway routes in the GeographicArea 
-- ?AREA is the LengthMeasure ?LENGTH.
fun lengthOfMultipleTrackRailway : El GeographicArea -> El LengthMeasure -> Formula ;


-- (lengthOfNarrowGaugeRailway ?AREA ?LENGTH) means that the sum length 
-- of narrow gauge railway routes in the GeographicArea ?AREA is the 
-- LengthMeasure ?LENGTH.
fun lengthOfNarrowGaugeRailway : El GeographicArea -> El LengthMeasure -> Formula ;


-- (lengthOfNaturalGasPipeline ?AREA ?AMOUNT) means that in the 
-- GeograpicArea ?AREA there is the LengthMeasure ?AMOUNT of 
-- NaturalGasPipeline.
fun lengthOfNaturalGasPipeline : El GeographicArea -> El LengthMeasure -> Formula ;


-- (lengthOfPavedHighway ?AREA ?LENGTH) means that the total length 
-- of SurfacedRoadway in the GeographicArea ?AREA is ?LENGTH.
fun lengthOfPavedHighway : El GeographicArea -> El LengthMeasure -> Formula ;


-- (lengthOfPetroleumProductPipeline ?AREA ?AMOUNT) means that in the 
-- GeograpicArea ?AREA there is the LengthMeasure ?AMOUNT of 
-- PetroleumProductPipeline.
fun lengthOfPetroleumProductPipeline : El GeographicArea -> El LengthMeasure -> Formula ;


-- (lengthOfStandardGaugeRailway ?AREA ?LENGTH) means that the sum length 
-- of standard gauge railway routes in the GeographicArea ?AREA is the 
-- LengthMeasure ?LENGTH.
fun lengthOfStandardGaugeRailway : El GeographicArea -> El LengthMeasure -> Formula ;


-- (lengthOfUnclassifiedGaugeRailway ?AREA ?LENGTH) means that the sum length 
-- of railway routes in the GeographicArea ?AREA classified as something 
-- other than broad, dual, narrow, or standard gauge is the LengthMeasure 
-- ?LENGTH.
fun lengthOfUnclassifiedGaugeRailway : El GeographicArea -> El LengthMeasure -> Formula ;


-- (lengthOfUnpavedHighway ?AREA ?LENGTH) means that the total length 
-- of UnsurfacedRoadway in the GeographicArea ?AREA is ?LENGTH.
fun lengthOfUnpavedHighway : El GeographicArea -> El LengthMeasure -> Formula ;


-- A relation between a MerchantMarine
-- and a ShipRegister which is a member of that MerchantMarine
fun marineInventory : El MerchantMarine -> El ShipRegister -> Formula ;


-- (navigableForDraft ?WATERWAY ?DRAFT) means that the Waterway 
-- ?WATERWAY can be transited by vessels up to the draft ?DRAFT.
fun navigableForDraft : El WaterArea -> El LengthMeasure -> Formula ;


-- (navigableForShippingTonnage ?WATERWAY ?TONNAGE) means that the 
-- Waterway ?WATERWAY can be transited by vessels up to the tonnage 
-- ?TONNAGE (in Dead Weight Tonnage).
fun navigableForShippingTonnage : El WaterArea -> El PhysicalQuantity -> Formula ;


-- (passengerCapacityMaxNumber ?TRANSPORT ?NUMBER) means that the 
-- TransportationDevice ?TRANSPORT has a safe carrying capacity for ?NUMBER 
-- of passengers.
fun passengerCapacityMaxNumber : El TransportationDevice -> El Number -> Formula ;


-- (powerComponent ?GENERATOR ?THING) 
-- means that the Device ?THING is the power source for the Artifact 
-- ?THING.
fun powerComponent: El Device -> Desc Artifact -> Formula ;


-- (routeBetween ?ROUTE ?FROM ?TO) means 
-- that the Transitway ?ROUTE is a route between the place ?FROM and 
-- the place ?TO.
fun routeBetween : El Transitway -> El Region -> El Region -> Formula ;


-- (routeEnd ?REGION ?SYSTEM) means
-- that within the given ?SYSTEM the given ?REGION is connected to
-- only one other Region.
fun routeEnd : El Region -> El TransitSystem -> Formula ;


fun routeStart : El Region -> El TransitSystem -> Formula ;

-- The maximum speed under normal conditions
-- for a vehicle. For a RoadVehicle this would be on level ground, no headwind or
-- tailwind, 70 degrees F, standard recommended fuel etc. For an Aircraft this would
-- mean level flight out of ground effect. Because of the number of external factors
-- on top speed, all that can be said formally is that higher speeds are unlikely.
fun topSpeed : El Vehicle -> El FunctionQuantity -> Formula ;


-- (totalFacilityTypeInArea ?AREA ?TYPE ?COUNT) means that in the 
-- GeographicArea ?AREA there a total of ?COUNT number of facilities 
-- of type ?TYPE.
fun totalFacilityTypeInArea : El GeographicArea -> Class -> El NonnegativeInteger -> Formula ;


-- (totalLengthOfHighwaySystem ?AREA ?LENGTH) means that the total 
-- length of the highway system in the GeographicArea ?AREA is ?LENGTH. 
-- The figure includes both paved and unpaved roads.
fun totalLengthOfHighwaySystem : El GeographicArea -> El LengthMeasure -> Formula ;


-- (totalLengthOfRailwaySystem ?AREA ?LENGTH) means that the sum 
-- length of all railway routes in the GeographicArea ?AREA 
-- is the LengthMeasure ?LENGTH.
fun totalLengthOfRailwaySystem : El GeographicArea -> El LengthMeasure -> Formula ;


-- (totalLengthOfWaterways ?AREA ?LENGTH) means that the 
-- total length of navigable Waterways in the GeographicArea ?AREA 
-- is the LengthMeasure ?LENGTH.
fun totalLengthOfWaterways : El GeographicArea -> El LengthMeasure -> Formula ;


-- (totalPipelineInArea ?AREA ?LENGTH) means that the GeopoliticalArea 
-- ?AREA has ?LENGTH of Pipelines.
fun totalPipelineInArea : El GeographicArea -> El LengthMeasure -> Formula ;


-- The distance between the two rails
-- of a Railway.
fun trackWidth : El Railway -> El LengthMeasure -> Formula ;


-- (trafficableForTrafficType ?WAY ?TYPE) means that Objects of ?TYPE 
-- can move along the Transitway ?WAY.
fun trafficableForTrafficType: El Object -> Desc SelfConnectedObject -> Formula ;


-- (transitwayCapacityCount ?WAY ?TYPE ?NUMBER) means that the 
-- Transitway ?WAY can accommodate a maximum of ?NUMBER items of ?TYPE 
-- at any one time.
fun transitwayCapacityCount: El Transitway -> Desc SelfConnectedObject -> El NonnegativeInteger -> Formula ;


-- (transitwayCapacityRate ?WAY ?TYPE ?RATE) means that the 
-- Transitway WAY can transit items of ?TYPE at the maximum 
-- FunctionQuantity ?RATE. For example, 
-- (transitwayCapacityRate SFBayBridgeWestbound Automobile 500).
fun transitwayCapacityRate: El Transitway -> Desc SelfConnectedObject -> El FunctionQuantity -> Formula ;


-- (vesselDeadWeightTonnage ?VESSEL ?AMOUNT) means that the 
-- WaterVehicle ?VESSEL has a carrying capacity when fully loaded of 
-- ?AMOUNT in LongTons. This is the Dead Weight Tonnage, or DWT, 
-- of the vessel, which is the total weight of cargo plus stores 
-- that the vessel can carry when immersed to the proper load line.
fun vesselDeadWeightTonnage : El WaterVehicle -> El MassMeasure -> Formula ;


-- (vesselDisplacement ?VESSEL ?AMOUNT) means that the displacement 
-- of WaterVehicle ?VESSEL is the PhysicalQuantity ?AMOUNT. The 
-- displacement of a vessel may be measured in LongTons (Dead Weight 
-- Tonnage, or DWT) or by volume (Gross Registered Tonnage, or GRT).
fun vesselDisplacement : El WaterVehicle -> El PhysicalQuantity -> Formula ;


-- (vesselGrossRegisteredTonnage ?VESSEL ?AMOUNT) means that the 
-- WaterVehicle ?VESSEL has a carrying capacity when fully loaded of 
-- ?AMOUNT, where ?AMOUNT is the Gross Registered Tonnage (GRT) of the 
-- vessel, which is based on the total sheltered volume of the vessel 
-- measured in hundreds of cubic feet, and converted to gross tons 
-- at an equivalence of 100 cubic feet per ton.
fun vesselGrossRegisteredTonnage : El WaterVehicle -> El PhysicalQuantity -> Formula ;
}
