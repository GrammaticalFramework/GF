abstract Communications = open Merge, Geography, Mid_level_ontology in{




--  An AMRadioStation is an 
-- engineeringSubcomponent of an AMRadioSystem.
fun AMRadioStation : Class ;
fun AMRadioStation_Class : SubClass AMRadioStation RadioStation ;

-- An AMRadioSystem consists of Radios, 
-- AMRadioStations, and other components that work together to make 
-- AM radio broadcasting possible in a given area.
fun AMRadioSystem : Class ;
fun AMRadioSystem_Class : SubClass AMRadioSystem RadioSystem ;

-- An ArtificialSatellite is a Device
-- that orbits the earth in space and performs various functions such as
-- aiding in communication, photographing the earth's surface, and others.
fun ArtificialSatellite : Class ;
fun ArtificialSatellite_Class : SubClass ArtificialSatellite (both EngineeringComponent Satellite) ;


-- A BroadcastingStation is
-- an engineeringSubcomponent of either a TelevisionSystem or
-- a RadioStation.
fun BroadcastingStation : Class ;
fun BroadcastingStation_Class : SubClass BroadcastingStation (both CommunicationDevice (both EngineeringComponent StationaryArtifact)) ;


-- A CableTelevisionSystem
-- is a CommunicationSystem for cable television.
fun CableTelevisionSystem : Class ;
fun CableTelevisionSystem_Class : SubClass CableTelevisionSystem CommunicationSystem ;

fun CommunicationDevice_EngineeringComponent : SubClass CommunicationDevice EngineeringComponent ;

-- Relatively low power broadcasting
-- devices designed for voice communication among specialized groups
-- in which each receiver also has the power to transmit, unlike
-- broadcast radio where most components transmitting or receiving on
-- a given frequency or set of frequencies are receivers only. This 
-- includes unlicensed walkie_talkies, public safety radios, military
-- communication systems and CB radios.
fun CommunicationRadio : Class ;
fun CommunicationRadio_Class : SubClass CommunicationRadio CommunicationDevice ;

-- A CommunicationSatellite is an
-- ArtificialSatellite that serves as one engineeringSubcomponent of a 
-- CommunicationSystem.
fun CommunicationSatellite : Class ;
fun CommunicationSatellite_Class : SubClass CommunicationSatellite (both ArtificialSatellite CommunicationDevice) ;


-- An Eutelsat is one type of 
-- CommunicationSatellite.
fun Eutelsat : Class ;
fun Eutelsat_Class : SubClass Eutelsat CommunicationSatellite ;

-- A FMRadioStation is an 
-- engineeringSubcomponent of an FMRadioSystem.
fun FMRadioStation : Class ;
fun FMRadioStation_Class : SubClass FMRadioStation RadioStation ;

-- A FMRadioSystem consists of Radios, 
-- FMRadioStations, and other components that work together to make 
-- FM radio broadcasting possible in a given area.
fun FMRadioSystem : Class ;
fun FMRadioSystem_Class : SubClass FMRadioSystem RadioSystem ;

-- An Inmarsat is one type of 
-- CommunicationSatellite.
fun Inmarsat : Class ;
fun Inmarsat_Class : SubClass Inmarsat CommunicationSatellite ;

-- An Intelsat is one type of 
-- CommunicationSatellite.
fun Intelsat : Class ;
fun Intelsat_Class : SubClass Intelsat CommunicationSatellite ;

-- The Internet is a CommunicationSystem
-- for the rapid delivery of information between computers.
fun Internet : Ind CommunicationSystem ;


-- An InternetServiceProvider
-- serves as an engineeringSubcomponent of the Internet for a given
-- area.
fun InternetServiceProvider : Class ;
fun InternetServiceProvider_Class : SubClass InternetServiceProvider CommunicationSystem ;

-- An InternetUser is an individual who
-- uses the Internet.
fun InternetUser : Ind SocialRole ;


-- An Intersputnik is one type of 
-- CommunicationSatellite.
fun Intersputnik : Class ;
fun Intersputnik_Class : SubClass Intersputnik CommunicationSatellite ;

-- A MainTelephoneLine is one 
-- engineeringSubcomponent of a TelephoneSystem used for voice communication 
-- or computer data transfer.
fun MainTelephoneLine : Class ;
fun MainTelephoneLine_Class : SubClass MainTelephoneLine CommunicationDevice ;

-- A Telephone that can be used without
-- connection to a MainTelephoneLine.
fun MobileCellPhone : Class ;
fun MobileCellPhone_Class : SubClass MobileCellPhone Telephone ;

-- An Orbita is one type of 
-- CommunicationSatellite.
fun Orbita : Class ;
fun Orbita_Class : SubClass Orbita CommunicationSatellite ;

-- A RadioStation is an 
-- engineeringSubcomponent of a RadioSystem.
fun RadioStation : Class ;
fun RadioStation_Class : SubClass RadioStation BroadcastingStation ;

-- A RadioSystem consists of Radios, 
-- RadioStations, and other components that work together to make 
-- radio broadcasting possible in a given area.
fun RadioSystem : Class ;
fun RadioSystem_Class : SubClass RadioSystem CommunicationSystem ;

-- A ShortwaveRadioStation 
-- is an engineeringSubcomponent of a ShortwaveRadioSystem.
fun ShortwaveRadioStation : Class ;
fun ShortwaveRadioStation_Class : SubClass ShortwaveRadioStation RadioStation ;

-- A ShortwaveRadioSystem consists 
-- of Radios, ShortwaveRadioStations, and other components that work 
-- together to make shortwave radio broadcasting possible in a given area.
fun ShortwaveRadioSystem : Class ;
fun ShortwaveRadioSystem_Class : SubClass ShortwaveRadioSystem RadioSystem ;

-- A TelephoneSystem consists of a complete
-- interconnection of Telephones, MainTelephoneLines, and other components
-- that work together to make telephonic communication possible from point to
-- point in a given area.
fun TelephoneSystem : Class ;
fun TelephoneSystem_Class : SubClass TelephoneSystem CommunicationSystem ;

fun TelevisionReceiver_EngineeringComponent : SubClass TelevisionReceiver EngineeringComponent ;

-- A TelevisionStation is an 
-- engineeringSubcomponent of a TelevisionSystem.
fun TelevisionStation : Class ;
fun TelevisionStation_Class : SubClass TelevisionStation BroadcastingStation ;

-- A system for Broadcasting and 
-- receiving television signals.
fun TelevisionSystem : Class ;
fun TelevisionSystem_Class : SubClass TelevisionSystem CommunicationSystem ;

-- The expression
-- (communicationSatelliteForArea ?AREA ?SATELLITE ?INTEGER) means that 
-- ?INTEGER number of CommunicationSatellites of the type ?SATELLITE serve
-- as an engineeringSubcomponent of a TelephoneSystem of the GeopoliticalArea
-- ?AREA.
fun communicationSatelliteForArea: El GeopoliticalArea -> Desc Satellite -> El Integer -> Formula ;-- replaced-- 


-- (internetCountryCode ?AREA ?CODE)
-- relates a GeopoliticalArea to the SymbolicString ?CODE used to
-- identify the ?AREA on internet websites.
fun internetCountryCode : El GeopoliticalArea -> El SymbolicString -> Formula ;
}
