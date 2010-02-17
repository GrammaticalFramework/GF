fof(axGeographyLem0, axiom, 
 ( ! [Var_LAND] : 
 (hasType(type_Continent, Var_LAND) => 
(((Var_LAND != inst_Antarctica) => (f_orientation(inst_Antarctica,Var_LAND,inst_South))))))).

fof(axGeographyLem1, axiom, 
 ( ! [Var_REGION] : 
 (hasType(type_GeographicArea, Var_REGION) => 
(( ! [Var_LONG] : 
 (hasType(type_Longitude, Var_LONG) => 
(( ! [Var_LAT] : 
 (hasType(type_Latitude, Var_LAT) => 
(((f_objectGeographicCoordinates(f_GeographicCenterFn(Var_REGION),Var_LAT,Var_LONG)) => (f_objectGeographicCoordinates(Var_REGION,Var_LAT,Var_LONG))))))))))))).

fof(axGeographyLem2, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(( ! [Var_ANGLE] : 
 (hasType(type_Object, Var_ANGLE) => 
(((f_measure(Var_ANGLE,f_MeasureFn(Var_NUMBER,inst_AngularDegree))) => (f_greaterThanOrEqualTo(Var_NUMBER,0)))))))))).

fof(axGeographyLem3, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(( ! [Var_ANGLE] : 
 (hasType(type_Object, Var_ANGLE) => 
(((f_measure(Var_ANGLE,f_MeasureFn(Var_NUMBER,inst_AngularDegree))) => (f_lessThanOrEqualTo(Var_NUMBER,360)))))))))).

fof(axGeographyLem4, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(( ! [Var_ANGLE] : 
 (hasType(type_Object, Var_ANGLE) => 
(((f_measure(Var_ANGLE,f_MeasureFn(Var_NUMBER,inst_ArcMinute))) => (f_greaterThanOrEqualTo(Var_NUMBER,0)))))))))).

fof(axGeographyLem5, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(( ! [Var_ANGLE] : 
 (hasType(type_Object, Var_ANGLE) => 
(((f_measure(Var_ANGLE,f_MeasureFn(Var_NUMBER,inst_ArcMinute))) => (f_lessThanOrEqualTo(Var_NUMBER,60)))))))))).

fof(axGeographyLem6, axiom, 
 ( ! [Var_DEG] : 
 ((hasType(type_RealNumber, Var_DEG) & hasType(type_Quantity, Var_DEG)) => 
(( ! [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) => 
(((f_measure(Var_OBJ,f_MeasureFn(Var_DEG,inst_AngularDegree))) <=> (f_measure(Var_OBJ,f_MeasureFn(f_MultiplicationFn(60,Var_DEG),inst_ArcMinute))))))))))).

fof(axGeographyLem7, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(( ! [Var_ANGLE] : 
 (hasType(type_Object, Var_ANGLE) => 
(((f_measure(Var_ANGLE,f_MeasureFn(Var_NUMBER,inst_ArcSecond))) => (f_greaterThanOrEqualTo(Var_NUMBER,0)))))))))).

fof(axGeographyLem8, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(( ! [Var_ANGLE] : 
 (hasType(type_Object, Var_ANGLE) => 
(((f_measure(Var_ANGLE,f_MeasureFn(Var_NUMBER,inst_ArcSecond))) => (f_lessThanOrEqualTo(Var_NUMBER,60)))))))))).

fof(axGeographyLem9, axiom, 
 ( ! [Var_DEG] : 
 ((hasType(type_RealNumber, Var_DEG) & hasType(type_Quantity, Var_DEG)) => 
(( ! [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) => 
(((f_measure(Var_OBJ,f_MeasureFn(Var_DEG,inst_ArcMinute))) <=> (f_measure(Var_OBJ,f_MeasureFn(f_MultiplicationFn(60,Var_DEG),inst_ArcSecond))))))))))).

fof(axGeographyLem10, axiom, 
 ( ! [Var_DIRECTION] : 
 ((hasType(type_Entity, Var_DIRECTION) & hasType(type_DirectionalAttribute, Var_DIRECTION)) => 
(((((Var_DIRECTION = inst_North) | (Var_DIRECTION = inst_South))) => (f_length(f_LatitudeFn(Var_DIRECTION,f_MeasureFn(0,inst_AngularDegree),f_MeasureFn(1,inst_ArcMinute),f_MeasureFn(0,inst_ArcSecond)),f_MeasureFn(1,inst_NauticalMile)))))))).

fof(axGeographyLem11, axiom, 
 ( ! [Var_SUBAREA] : 
 (hasType(type_GeographicArea, Var_SUBAREA) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(( ! [Var_PLACE] : 
 (hasType(type_Physical, Var_PLACE) => 
(((((f_partlyLocated(Var_PLACE,Var_SUBAREA)) & (f_geographicSubregion(Var_SUBAREA,Var_AREA)))) => (f_partlyLocated(Var_PLACE,Var_AREA))))))))))))).

fof(axGeographyLem12, axiom, 
 ( ! [Var_Z] : 
 (hasType(type_Object, Var_Z) => 
(( ! [Var_Y] : 
 (hasType(type_Object, Var_Y) => 
(( ! [Var_X] : 
 (hasType(type_Object, Var_X) => 
(((((f_connected(Var_X,Var_Y)) & (f_part(Var_Y,Var_Z)))) => (f_connected(Var_X,Var_Z))))))))))))).

fof(axGeographyLem13, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfArea, Var_UNIT) => 
(( ! [Var_WATER] : 
 ((hasType(type_RealNumber, Var_WATER) & hasType(type_Quantity, Var_WATER)) => 
(( ! [Var_LAND] : 
 ((hasType(type_RealNumber, Var_LAND) & hasType(type_Quantity, Var_LAND)) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Region, Var_AREA)) => 
(((((f_landAreaOnly(Var_AREA,f_MeasureFn(Var_LAND,Var_UNIT))) & (f_waterAreaOnly(Var_AREA,f_MeasureFn(Var_WATER,Var_UNIT))))) => (f_totalArea(Var_AREA,f_MeasureFn(f_AdditionFn(Var_LAND,Var_WATER),Var_UNIT))))))))))))))))).

fof(axGeographyLem14, axiom, 
 ( ! [Var_EXCLUSIVELANDAREA] : 
 (hasType(type_SurfaceGroundArea, Var_EXCLUSIVELANDAREA) => 
(( ? [Var_WATERAREA] : 
 (hasType(type_WaterArea, Var_WATERAREA) &  
(f_part(Var_WATERAREA,Var_EXCLUSIVELANDAREA)))))))).

fof(axGeographyLem15, axiom, 
 ( ! [Var_MEASURE] : 
 (hasType(type_AreaMeasure, Var_MEASURE) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(((f_landAreaOnly(Var_AREA,Var_MEASURE)) => (( ? [Var_LAND] : 
 (hasType(type_SurfaceGroundArea, Var_LAND) &  
(((f_part(Var_LAND,Var_AREA)) & (f_totalArea(Var_LAND,Var_MEASURE))))))))))))))).

fof(axGeographyLem16, axiom, 
 ( ! [Var_EXCLUSIVEWATERAREA] : 
 (hasType(type_WaterOnlyArea, Var_EXCLUSIVEWATERAREA) => 
(( ? [Var_LANDAREA] : 
 (hasType(type_LandArea, Var_LANDAREA) &  
(f_part(Var_LANDAREA,Var_EXCLUSIVEWATERAREA)))))))).

fof(axGeographyLem17, axiom, 
 ( ! [Var_MEASURE] : 
 (hasType(type_AreaMeasure, Var_MEASURE) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(((f_waterAreaOnly(Var_AREA,Var_MEASURE)) => (( ? [Var_WATER] : 
 (hasType(type_WaterOnlyArea, Var_WATER) &  
(((f_part(Var_WATER,Var_AREA)) & (f_totalArea(Var_WATER,Var_MEASURE))))))))))))))).

fof(axGeographyLem18, axiom, 
 ( ! [Var_NUM] : 
 ((hasType(type_Entity, Var_NUM) & hasType(type_RealNumber, Var_NUM) & hasType(type_Quantity, Var_NUM)) => 
(((Var_NUM = f_MultiplicationFn(1,Var_NUM)) => (f_MeasureFn(Var_NUM,inst_SquareKilometer) = f_MeasureFn(f_MultiplicationFn(Var_NUM,1000000),inst_SquareMeter))))))).

fof(axGeographyLem19, axiom, 
 ( ! [Var_OBJ1] : 
 (hasType(type_GeographicArea, Var_OBJ1) => 
(( ! [Var_OBJ2] : 
 (hasType(type_GeographicArea, Var_OBJ2) => 
(f_BorderFn(Var_OBJ1,Var_OBJ2) = f_BorderFn(Var_OBJ2,Var_OBJ1)))))))).

fof(axGeographyLem20, axiom, 
 ( ! [Var_TWO] : 
 (hasType(type_Object, Var_TWO) => 
(( ! [Var_ONE] : 
 (hasType(type_Object, Var_ONE) => 
(((f_orientation(Var_ONE,Var_TWO,inst_Adjacent)) => (f_orientation(Var_TWO,Var_ONE,inst_Adjacent)))))))))).

fof(axGeographyLem21, axiom, 
 ( ! [Var_TWO] : 
 (hasType(type_Object, Var_TWO) => 
(( ! [Var_ONE] : 
 (hasType(type_Object, Var_ONE) => 
(((f_orientation(Var_ONE,Var_TWO,inst_Near)) => (f_orientation(Var_TWO,Var_ONE,inst_Near)))))))))).

fof(axGeographyLem22, axiom, 
 ( ! [Var_AREA2] : 
 (hasType(type_Object, Var_AREA2) => 
(( ! [Var_AREA1] : 
 (hasType(type_Object, Var_AREA1) => 
(((f_meetsSpatially(Var_AREA1,Var_AREA2)) => (( ~ (f_overlapsSpatially(Var_AREA1,Var_AREA2)))))))))))).

fof(axGeographyLem23, axiom, 
 ( ! [Var_M] : 
 ((hasType(type_LengthMeasure, Var_M) & hasType(type_PhysicalQuantity, Var_M)) => 
(( ! [Var_N2] : 
 ((hasType(type_GeographicRegion, Var_N2) & hasType(type_GeographicArea, Var_N2)) => 
(( ! [Var_N1] : 
 ((hasType(type_GeographicRegion, Var_N1) & hasType(type_GeographicArea, Var_N1)) => 
(((f_sharedBorderLength(Var_N1,Var_N2,Var_M)) => (f_length(f_BorderFn(Var_N1,Var_N2),Var_M))))))))))))).

fof(axGeographyLem24, axiom, 
 ( ! [Var_REGION] : 
 (hasType(type_Region, Var_REGION) => 
(f_superficialPart(f_InnerBoundaryFn(Var_REGION),Var_REGION))))).

fof(axGeographyLem25, axiom, 
 ( ! [Var_REGION] : 
 (hasType(type_Region, Var_REGION) => 
(f_superficialPart(f_OuterBoundaryFn(Var_REGION),Var_REGION))))).

fof(axGeographyLem26, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_UniformPerimeterArea, Var_AREA) => 
(( ? [Var_WIDTH] : 
 (hasType(type_LengthMeasure, Var_WIDTH) &  
(f_distance(f_InnerBoundaryFn(Var_AREA),f_OuterBoundaryFn(Var_AREA),Var_WIDTH)))))))).

fof(axGeographyLem27, axiom, 
 ( ! [Var_ZONE] : 
 (hasType(type_UniformPerimeterArea, Var_ZONE) => 
(( ? [Var_WIDTH] : 
 (hasType(type_LengthMeasure, Var_WIDTH) &  
(f_width(Var_ZONE,Var_WIDTH)))))))).

fof(axGeographyLem28, axiom, 
 ( ! [Var_ZONE] : 
 (hasType(type_UniformPerimeterArea, Var_ZONE) => 
(( ! [Var_WIDTH] : 
 (hasType(type_LengthMeasure, Var_WIDTH) => 
(( ! [Var_INNER] : 
 ((hasType(type_Object, Var_INNER) & hasType(type_Physical, Var_INNER)) => 
(((f_part(Var_INNER,f_InnerBoundaryFn(Var_ZONE))) => (( ? [Var_OUTER] : 
 ((hasType(type_Object, Var_OUTER) & hasType(type_Physical, Var_OUTER)) &  
(((f_part(Var_OUTER,f_OuterBoundaryFn(Var_ZONE))) & (f_distance(Var_INNER,Var_OUTER,Var_WIDTH)))))))))))))))))).

fof(axGeographyLem29, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_LandlockedArea, Var_AREA) => 
(( ? [Var_COAST] : 
 (hasType(type_Seacoast, Var_COAST) &  
(f_part(Var_COAST,Var_AREA)))))))).

fof(axGeographyLem30, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_LandlockedArea, Var_AREA) => 
(( ! [Var_UNIT] : 
 (hasType(type_UnitOfLength, Var_UNIT) => 
(f_totalCoastline(Var_AREA,f_MeasureFn(0,Var_UNIT))))))))).

fof(axGeographyLem31, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_LandlockedArea, Var_AREA) => 
(( ? [Var_WATER] : 
 (hasType(type_Ocean, Var_WATER) &  
(f_meetsSpatially(Var_AREA,Var_WATER)))))))).

fof(axGeographyLem32, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_LandlockedArea, Var_AREA) => 
(( ! [Var_SEA] : 
 (hasType(type_Ocean, Var_SEA) => 
(( ? [Var_WATER] : 
 (hasType(type_SaltWaterArea, Var_WATER) &  
(((f_part(Var_WATER,Var_SEA)) & (f_meetsSpatially(Var_AREA,Var_WATER))))))))))))).

fof(axGeographyLem33, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_LandlockedArea, Var_AREA) => 
(( ? [Var_LAND] : 
 (hasType(type_LandArea, Var_LAND) &  
(f_meetsSpatially(Var_AREA,Var_LAND)))))))).

fof(axGeographyLem34, axiom, 
 ( ! [Var_ZONE] : 
 (hasType(type_MaritimeShelfArea, Var_ZONE) => 
(( ! [Var_WIDTH] : 
 ((hasType(type_LengthMeasure, Var_WIDTH) & hasType(type_Quantity, Var_WIDTH)) => 
(((f_linearExtent(Var_ZONE,Var_WIDTH)) => (f_lessThanOrEqualTo(Var_WIDTH,f_MeasureFn(200,inst_NauticalMile))))))))))).

fof(axGeographyLem35, axiom, 
 ( ! [Var_ZONE] : 
 (hasType(type_MaritimeShelfArea, Var_ZONE) => 
(( ! [Var_SHELF] : 
 (hasType(type_ContinentalShelf, Var_SHELF) => 
(( ! [Var_COUNTRY] : 
 (hasType(type_Nation, Var_COUNTRY) => 
(( ! [Var_NATION] : 
 (hasType(type_Agent, Var_NATION) => 
(((((f_meetsSpatially(Var_SHELF,Var_COUNTRY)) & (f_claimedTerritory(Var_ZONE,Var_NATION)))) => (f_overlapsSpatially(Var_ZONE,Var_SHELF)))))))))))))))).

fof(axGeographyLem36, axiom, 
 ( ! [Var_ZONE] : 
 (hasType(type_MaritimeExclusiveEconomicZone, Var_ZONE) => 
(( ! [Var_WIDTH] : 
 ((hasType(type_LengthMeasure, Var_WIDTH) & hasType(type_Quantity, Var_WIDTH)) => 
(((f_linearExtent(Var_ZONE,Var_WIDTH)) => (f_lessThanOrEqualTo(Var_WIDTH,f_MeasureFn(200,inst_NauticalMile))))))))))).

fof(axGeographyLem37, axiom, 
 ( ! [Var_ZONE] : 
 (hasType(type_ExclusiveFishingZone, Var_ZONE) => 
(( ! [Var_WIDTH] : 
 ((hasType(type_LengthMeasure, Var_WIDTH) & hasType(type_Quantity, Var_WIDTH)) => 
(((f_linearExtent(Var_ZONE,Var_WIDTH)) => (f_lessThanOrEqualTo(Var_WIDTH,f_MeasureFn(200,inst_NauticalMile))))))))))).

fof(axGeographyLem38, axiom, 
 ( ! [Var_ZONE] : 
 (hasType(type_ExtendedFishingZone, Var_ZONE) => 
(( ! [Var_WIDTH] : 
 ((hasType(type_LengthMeasure, Var_WIDTH) & hasType(type_Quantity, Var_WIDTH)) => 
(((f_linearExtent(Var_ZONE,Var_WIDTH)) => (f_lessThanOrEqualTo(Var_WIDTH,f_MeasureFn(200,inst_NauticalMile))))))))))).

fof(axGeographyLem39, axiom, 
 ( ! [Var_ZONE] : 
 (hasType(type_MaritimeContiguousZone, Var_ZONE) => 
(( ! [Var_WATER] : 
 (hasType(type_TerritorialSea, Var_WATER) => 
(( ! [Var_AREA] : 
 ((hasType(type_Agent, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(((((f_claimedTerritory(Var_ZONE,Var_AREA)) & (f_claimedTerritory(Var_WATER,Var_AREA)))) => (f_between(Var_AREA,Var_WATER,Var_ZONE))))))))))))).

fof(axGeographyLem40, axiom, 
 ( ! [Var_ZONE] : 
 (hasType(type_TerritorialSea, Var_ZONE) => 
(( ! [Var_WIDTH] : 
 ((hasType(type_LengthMeasure, Var_WIDTH) & hasType(type_Quantity, Var_WIDTH)) => 
(((f_linearExtent(Var_ZONE,Var_WIDTH)) => (f_lessThanOrEqualTo(Var_WIDTH,f_MeasureFn(12,inst_NauticalMile))))))))))).

fof(axGeographyLem41, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_WetTropicalClimateZone, Var_AREA) => 
(( ! [Var_AMOUNT] : 
 ((hasType(type_LengthMeasure, Var_AMOUNT) & hasType(type_Quantity, Var_AMOUNT)) => 
(( ! [Var_MO] : 
 (hasType(type_Month, Var_MO) => 
(((f_averageRainfallForPeriod(Var_AREA,Var_MO,Var_AMOUNT)) => (f_greaterThanOrEqualTo(Var_AMOUNT,f_MeasureFn(60,f_MilliFn(inst_Meter))))))))))))))).

fof(axGeographyLem42, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_MediterraneanClimateZone, Var_AREA) => 
(f_coolSeasonInArea(Var_AREA,type_WinterSeason))))).

fof(axGeographyLem43, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_MediterraneanClimateZone, Var_AREA) => 
(f_warmSeasonInArea(Var_AREA,type_SummerSeason))))).

fof(axGeographyLem44, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_MediterraneanClimateZone, Var_AREA) => 
(f_rainySeasonInArea(Var_AREA,type_WinterSeason))))).

fof(axGeographyLem45, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_MediterraneanClimateZone, Var_AREA) => 
(f_drySeasonInArea(Var_AREA,type_SummerSeason))))).

fof(axGeographyLem46, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_ContinentalClimateZone, Var_AREA) => 
(f_coldSeasonInArea(Var_AREA,type_WinterSeason))))).

fof(axGeographyLem47, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_ContinentalClimateZone, Var_AREA) => 
(f_hotSeasonInArea(Var_AREA,type_SummerSeason))))).

fof(axGeographyLem48, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_MidlatitudeContinentalClimateZone, Var_AREA) => 
(f_coolSeasonInArea(Var_AREA,type_WinterSeason))))).

fof(axGeographyLem49, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_MidlatitudeContinentalClimateZone, Var_AREA) => 
(f_hotSeasonInArea(Var_AREA,type_SummerSeason))))).

fof(axGeographyLem50, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_PolarTypeFClimateZone, Var_AREA) => 
(( ! [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) => 
(( ! [Var_TEMP] : 
 ((hasType(type_TemperatureMeasure, Var_TEMP) & hasType(type_Quantity, Var_TEMP)) => 
(((f_holdsDuring(Var_TIME,airTemperature(Var_AREA,Var_TEMP))) => (f_holdsDuring(Var_TIME,greaterThan(f_MeasureFn(10,inst_CelsiusDegree),Var_TEMP)))))))))))))).

fof(axGeographyLem51, axiom, 
 ( ! [Var_ATTRIBUTE] : 
 ((hasType(type_TerrainAttribute, Var_ATTRIBUTE) & hasType(type_Attribute, Var_ATTRIBUTE)) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(((f_terrainInArea(Var_AREA,Var_ATTRIBUTE)) => (( ? [Var_REGION] : 
 (hasType(type_GeographicArea, Var_REGION) &  
(((f_attribute(Var_REGION,Var_ATTRIBUTE)) & (f_partlyLocated(Var_REGION,Var_AREA))))))))))))))).

fof(axGeographyLem52, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(( ! [Var_ATTRIBUTE] : 
 (hasType(type_TerrainAttribute, Var_ATTRIBUTE) => 
(( ! [Var_REGION] : 
 ((hasType(type_Object, Var_REGION) & hasType(type_Physical, Var_REGION)) => 
(((((f_attribute(Var_REGION,Var_ATTRIBUTE)) & (f_partlyLocated(Var_REGION,Var_AREA)))) => (f_terrainInArea(Var_AREA,Var_ATTRIBUTE))))))))))))).

fof(axGeographyLem53, axiom, 
 ( ! [Var_SLOPE] : 
 ((hasType(type_NonnegativeRealNumber, Var_SLOPE) & hasType(type_Quantity, Var_SLOPE)) => 
(( ! [Var_ZONE] : 
 ((hasType(type_Object, Var_ZONE) & hasType(type_LandArea, Var_ZONE)) => 
(( ! [Var_AREA] : 
 (hasType(type_Object, Var_AREA) => 
(((((f_attribute(Var_AREA,inst_FlatTerrain)) & (((f_part(Var_ZONE,Var_AREA)) & (f_slopeGradient(Var_ZONE,Var_SLOPE)))))) => (f_greaterThan(5.0e-3,Var_SLOPE))))))))))))).

fof(axGeographyLem54, axiom, 
 ( ! [Var_SLOPE] : 
 ((hasType(type_NonnegativeRealNumber, Var_SLOPE) & hasType(type_Quantity, Var_SLOPE)) => 
(( ! [Var_ZONE] : 
 ((hasType(type_Object, Var_ZONE) & hasType(type_LandArea, Var_ZONE)) => 
(( ! [Var_AREA] : 
 (hasType(type_Object, Var_AREA) => 
(((((f_attribute(Var_AREA,inst_LowTerrain)) & (((f_part(Var_ZONE,Var_AREA)) & (f_slopeGradient(Var_ZONE,Var_SLOPE)))))) => (f_greaterThan(3.0e-2,Var_SLOPE))))))))))))).

fof(axGeographyLem55, axiom, 
 ( ! [Var_SLOPE] : 
 ((hasType(type_NonnegativeRealNumber, Var_SLOPE) & hasType(type_Quantity, Var_SLOPE)) => 
(( ! [Var_AREA] : 
 (hasType(type_Object, Var_AREA) => 
(((f_attribute(Var_AREA,inst_SteepTerrain)) => (( ? [Var_ZONE] : 
 ((hasType(type_Object, Var_ZONE) & hasType(type_LandArea, Var_ZONE)) &  
(((f_part(Var_ZONE,Var_AREA)) & (((f_slopeGradient(Var_ZONE,Var_SLOPE)) & (f_greaterThan(Var_SLOPE,0.1))))))))))))))))).

fof(axGeographyLem56, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_Object, Var_AREA) => 
(((f_attribute(Var_AREA,inst_MountainousTerrain)) => (( ? [Var_MTN] : 
 (hasType(type_Mountain, Var_MTN) &  
(f_part(Var_MTN,Var_AREA)))))))))).

fof(axGeographyLem57, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_Object, Var_AREA) => 
(((f_attribute(Var_AREA,inst_MountainousTerrain)) => (( ? [Var_MTN] : 
 (hasType(type_Mountain, Var_MTN) &  
(f_located(Var_MTN,Var_AREA)))))))))).

fof(axGeographyLem58, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_MountainRange, Var_AREA) => 
(f_attribute(Var_AREA,inst_MountainousTerrain))))).

fof(axGeographyLem59, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_Object, Var_AREA) => 
(((f_attribute(Var_AREA,inst_FertileTerrain)) => (( ! [Var_AGRICULTURE] : 
 (hasType(type_Agriculture, Var_AGRICULTURE) => 
(f_located(Var_AGRICULTURE,Var_AREA)))))))))).

fof(axGeographyLem60, axiom, 
 ( ! [Var_SOIL] : 
 (hasType(type_Soil, Var_SOIL) => 
(( ! [Var_AREA] : 
 (hasType(type_LandArea, Var_AREA) => 
(((((f_attribute(Var_SOIL,inst_Red)) & (f_component(Var_SOIL,Var_AREA)))) => (f_attribute(Var_AREA,inst_FertileTerrain)))))))))).

fof(axGeographyLem61, axiom, 
 ( ! [Var_SOIL] : 
 (hasType(type_Soil, Var_SOIL) => 
(( ! [Var_AREA] : 
 (hasType(type_LandArea, Var_AREA) => 
(((((f_attribute(Var_SOIL,inst_Yellow)) & (f_component(Var_SOIL,Var_AREA)))) => (( ~ (f_attribute(Var_AREA,inst_FertileTerrain)))))))))))).

fof(axGeographyLem62, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(( ! [Var_CONE] : 
 (hasType(type_Volcano, Var_CONE) => 
(((f_attribute(Var_CONE,inst_VolcanicallyActive)) => (( ~ (f_attribute(Var_AREA,inst_GeologicallyStable)))))))))))).

fof(axGeographyLem63, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(( ! [Var_BLOW] : 
 (hasType(type_VolcanicEruption, Var_BLOW) => 
(((f_located(Var_BLOW,Var_AREA)) => (( ~ (f_attribute(Var_AREA,inst_GeologicallyStable)))))))))))).

fof(axGeographyLem64, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(( ! [Var_SHAKING] : 
 (hasType(type_EarthTremor, Var_SHAKING) => 
(((f_located(Var_SHAKING,Var_AREA)) => (( ~ (f_attribute(Var_AREA,inst_GeologicallyStable)))))))))))).

fof(axGeographyLem65, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(( ! [Var_FAULT] : 
 (hasType(type_GeologicalFault, Var_FAULT) => 
(((f_located(Var_FAULT,Var_AREA)) => (( ~ (f_attribute(Var_AREA,inst_GeologicallyStable)))))))))))).

fof(axGeographyLem66, axiom, 
 ( ! [Var_HEIGHT] : 
 (hasType(type_LengthMeasure, Var_HEIGHT) => 
(( ! [Var_OBJECT] : 
 ((hasType(type_Object, Var_OBJECT) & hasType(type_Physical, Var_OBJECT)) => 
(((f_elevation(Var_OBJECT,Var_HEIGHT)) => (( ? [Var_PLACE] : 
 (hasType(type_GeographicArea, Var_PLACE) &  
(f_located(Var_OBJECT,Var_PLACE))))))))))))).

fof(axGeographyLem67, axiom, 
 ( ! [Var_PLACE] : 
 (hasType(type_GeographicArea, Var_PLACE) => 
(( ! [Var_HEIGHT] : 
 (hasType(type_LengthMeasure, Var_HEIGHT) => 
(( ! [Var_OBJECT] : 
 ((hasType(type_Object, Var_OBJECT) & hasType(type_Physical, Var_OBJECT)) => 
(((((f_elevation(Var_OBJECT,Var_HEIGHT)) & (f_located(Var_OBJECT,Var_PLACE)))) => (f_superficialPart(Var_PLACE,inst_PlanetEarth))))))))))))).

fof(axGeographyLem68, axiom, 
 ( ! [Var_HEIGHT] : 
 (hasType(type_LengthMeasure, Var_HEIGHT) => 
(( ! [Var_OBJECT] : 
 ((hasType(type_Object, Var_OBJECT) & hasType(type_Physical, Var_OBJECT)) => 
(((f_elevation(Var_OBJECT,Var_HEIGHT)) => (( ? [Var_DATUM] : 
 ((hasType(type_Object, Var_DATUM) & hasType(type_Physical, Var_DATUM)) &  
(((f_properPart(Var_DATUM,inst_SeaLevel)) & (((f_orientation(Var_OBJECT,Var_DATUM,inst_Vertical)) & (f_distance(Var_OBJECT,Var_DATUM,Var_HEIGHT))))))))))))))))).

fof(axGeographyLem69, axiom, 
 ( ! [Var_OBJECT] : 
 (hasType(type_LandForm, Var_OBJECT) => 
(( ! [Var_UNIT] : 
 (hasType(type_UnitOfLength, Var_UNIT) => 
(( ! [Var_NUM] : 
 (hasType(type_RealNumber, Var_NUM) => 
(((f_elevation(Var_OBJECT,f_MeasureFn(Var_NUM,Var_UNIT))) => (( ? [Var_HIGHPOINT] : 
 ((hasType(type_SelfConnectedObject, Var_HIGHPOINT) & hasType(type_Physical, Var_HIGHPOINT)) &  
(((f_top(Var_HIGHPOINT,Var_OBJECT)) & (f_distance(Var_HIGHPOINT,inst_SeaLevel,f_MeasureFn(Var_NUM,Var_UNIT))))))))))))))))))).

fof(axGeographyLem70, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(( ! [Var_ELEV1] : 
 ((hasType(type_LengthMeasure, Var_ELEV1) & hasType(type_Quantity, Var_ELEV1)) => 
(((((f_geographicSubregion(f_ElevationLowPointFn(Var_AREA),Var_AREA)) & (f_elevation(f_ElevationLowPointFn(Var_AREA),Var_ELEV1)))) => (( ? [Var_ELEV2] : 
 ((hasType(type_LengthMeasure, Var_ELEV2) & hasType(type_Quantity, Var_ELEV2)) &  
(( ~ ( ? [Var_OTHER] : 
 ((hasType(type_GeographicArea, Var_OTHER) & hasType(type_Entity, Var_OTHER) & hasType(type_Object, Var_OTHER)) &  
(((f_geographicSubregion(Var_OTHER,Var_AREA)) & (((Var_OTHER != f_ElevationLowPointFn(Var_AREA)) & (((f_elevation(Var_OTHER,Var_ELEV2)) & (f_lessThan(Var_ELEV2,Var_ELEV1))))))))))))))))))))))).

fof(axGeographyLem71, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(( ! [Var_ELEV1] : 
 ((hasType(type_LengthMeasure, Var_ELEV1) & hasType(type_Quantity, Var_ELEV1)) => 
(((((f_geographicSubregion(f_ElevationHighPointFn(Var_AREA),Var_AREA)) & (f_elevation(f_ElevationHighPointFn(Var_AREA),Var_ELEV1)))) => (( ? [Var_ELEV2] : 
 ((hasType(type_LengthMeasure, Var_ELEV2) & hasType(type_Quantity, Var_ELEV2)) &  
(( ~ ( ? [Var_OTHER] : 
 ((hasType(type_GeographicArea, Var_OTHER) & hasType(type_Entity, Var_OTHER) & hasType(type_Object, Var_OTHER)) &  
(((f_geographicSubregion(Var_OTHER,Var_AREA)) & (((Var_OTHER != f_ElevationHighPointFn(Var_AREA)) & (((f_elevation(Var_OTHER,Var_ELEV2)) & (f_greaterThan(Var_ELEV2,Var_ELEV1))))))))))))))))))))))).

fof(axGeographyLem72, axiom, 
 ( ! [Var_GAS] : 
 (hasType(type_NaturalGas, Var_GAS) => 
(f_attribute(Var_GAS,inst_Gas))))).

fof(axGeographyLem73, axiom, 
 ( ! [Var_TOTAL] : 
 (hasType(type_AreaMeasure, Var_TOTAL) => 
(( ! [Var_AMOUNT] : 
 ((hasType(type_Entity, Var_AMOUNT) & hasType(type_ConstantQuantity, Var_AMOUNT)) => 
(( ! [Var_FRACTION] : 
 ((hasType(type_ConstantQuantity, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) => 
(( ! [Var_REGION] : 
 ((hasType(type_GeographicArea, Var_REGION) & hasType(type_Region, Var_REGION)) => 
(((((f_arableLandArea(Var_REGION,Var_FRACTION)) & (((f_greaterThanOrEqualTo(Var_FRACTION,0)) & (((f_totalArea(Var_REGION,Var_TOTAL)) & (Var_AMOUNT = f_MultiplicationFn(Var_FRACTION,Var_TOTAL)))))))) => (f_arableLandArea(Var_REGION,Var_AMOUNT)))))))))))))))).

fof(axGeographyLem74, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfArea, Var_UNIT) => 
(( ! [Var_AMOUNT] : 
 ((hasType(type_Entity, Var_AMOUNT) & hasType(type_ConstantQuantity, Var_AMOUNT)) => 
(( ! [Var_TOTAL] : 
 ((hasType(type_RealNumber, Var_TOTAL) & hasType(type_Quantity, Var_TOTAL)) => 
(( ! [Var_FRACTION] : 
 ((hasType(type_ConstantQuantity, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) => 
(( ! [Var_REGION] : 
 ((hasType(type_GeographicArea, Var_REGION) & hasType(type_Region, Var_REGION)) => 
(((((f_arableLandArea(Var_REGION,Var_FRACTION)) & (((f_greaterThanOrEqualTo(Var_FRACTION,0)) & (((f_totalArea(Var_REGION,f_MeasureFn(Var_TOTAL,Var_UNIT))) & (Var_AMOUNT = f_MeasureFn(f_MultiplicationFn(Var_FRACTION,Var_TOTAL),Var_UNIT)))))))) => (f_arableLandArea(Var_REGION,Var_AMOUNT))))))))))))))))))).

fof(axGeographyLem75, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfArea, Var_UNIT) => 
(( ! [Var_TOTAL] : 
 ((hasType(type_RealNumber, Var_TOTAL) & hasType(type_Quantity, Var_TOTAL)) => 
(( ! [Var_FRACTION] : 
 ((hasType(type_ConstantQuantity, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) => 
(( ! [Var_REGION] : 
 ((hasType(type_GeographicArea, Var_REGION) & hasType(type_Region, Var_REGION)) => 
(((((f_arableLandArea(Var_REGION,Var_FRACTION)) & (((f_greaterThanOrEqualTo(Var_FRACTION,0)) & (f_totalArea(Var_REGION,f_MeasureFn(Var_TOTAL,Var_UNIT))))))) => (( ? [Var_ARABLE] : 
 (hasType(type_ArableLand, Var_ARABLE) &  
(((f_geographicSubregion(Var_ARABLE,Var_REGION)) & (f_measure(Var_ARABLE,f_MeasureFn(f_MultiplicationFn(Var_FRACTION,Var_TOTAL),Var_UNIT)))))))))))))))))))))).

fof(axGeographyLem76, axiom, 
 ( ! [Var_TOTAL] : 
 (hasType(type_AreaMeasure, Var_TOTAL) => 
(( ! [Var_AMOUNT] : 
 ((hasType(type_Entity, Var_AMOUNT) & hasType(type_ConstantQuantity, Var_AMOUNT)) => 
(( ! [Var_FRACTION] : 
 ((hasType(type_ConstantQuantity, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) => 
(( ! [Var_REGION] : 
 ((hasType(type_GeographicArea, Var_REGION) & hasType(type_Region, Var_REGION)) => 
(((((f_permanentCropLandArea(Var_REGION,Var_FRACTION)) & (((f_greaterThanOrEqualTo(Var_FRACTION,0)) & (((f_totalArea(Var_REGION,Var_TOTAL)) & (Var_AMOUNT = f_MultiplicationFn(Var_FRACTION,Var_TOTAL)))))))) => (f_permanentCropLandArea(Var_REGION,Var_AMOUNT)))))))))))))))).

fof(axGeographyLem77, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfArea, Var_UNIT) => 
(( ! [Var_AMOUNT] : 
 ((hasType(type_Entity, Var_AMOUNT) & hasType(type_ConstantQuantity, Var_AMOUNT)) => 
(( ! [Var_TOTAL] : 
 ((hasType(type_RealNumber, Var_TOTAL) & hasType(type_Quantity, Var_TOTAL)) => 
(( ! [Var_FRACTION] : 
 ((hasType(type_ConstantQuantity, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) => 
(( ! [Var_REGION] : 
 ((hasType(type_GeographicArea, Var_REGION) & hasType(type_Region, Var_REGION)) => 
(((((f_permanentCropLandArea(Var_REGION,Var_FRACTION)) & (((f_greaterThanOrEqualTo(Var_FRACTION,0)) & (((f_totalArea(Var_REGION,f_MeasureFn(Var_TOTAL,Var_UNIT))) & (Var_AMOUNT = f_MeasureFn(f_MultiplicationFn(Var_FRACTION,Var_TOTAL),Var_UNIT)))))))) => (f_permanentCropLandArea(Var_REGION,Var_AMOUNT))))))))))))))))))).

fof(axGeographyLem78, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfArea, Var_UNIT) => 
(( ! [Var_TOTAL] : 
 ((hasType(type_RealNumber, Var_TOTAL) & hasType(type_Quantity, Var_TOTAL)) => 
(( ! [Var_FRACTION] : 
 ((hasType(type_ConstantQuantity, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) => 
(( ! [Var_REGION] : 
 ((hasType(type_GeographicArea, Var_REGION) & hasType(type_Region, Var_REGION)) => 
(((((f_permanentCropLandArea(Var_REGION,Var_FRACTION)) & (((f_greaterThanOrEqualTo(Var_FRACTION,0)) & (f_totalArea(Var_REGION,f_MeasureFn(Var_TOTAL,Var_UNIT))))))) => (( ? [Var_PERMCROP] : 
 (hasType(type_PermanentCropLand, Var_PERMCROP) &  
(((f_geographicSubregion(Var_PERMCROP,Var_REGION)) & (f_measure(Var_PERMCROP,f_MeasureFn(f_MultiplicationFn(Var_FRACTION,Var_TOTAL),Var_UNIT)))))))))))))))))))))).

fof(axGeographyLem79, axiom, 
 ( ! [Var_TOTAL] : 
 (hasType(type_AreaMeasure, Var_TOTAL) => 
(( ! [Var_AMOUNT] : 
 ((hasType(type_Entity, Var_AMOUNT) & hasType(type_ConstantQuantity, Var_AMOUNT)) => 
(( ! [Var_FRACTION] : 
 ((hasType(type_ConstantQuantity, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) => 
(( ! [Var_REGION] : 
 ((hasType(type_GeographicArea, Var_REGION) & hasType(type_Region, Var_REGION)) => 
(((((f_otherLandUseArea(Var_REGION,Var_FRACTION)) & (((f_greaterThanOrEqualTo(Var_FRACTION,0)) & (((f_totalArea(Var_REGION,Var_TOTAL)) & (Var_AMOUNT = f_MultiplicationFn(Var_FRACTION,Var_TOTAL)))))))) => (f_otherLandUseArea(Var_REGION,Var_AMOUNT)))))))))))))))).

fof(axGeographyLem80, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfArea, Var_UNIT) => 
(( ! [Var_AMOUNT] : 
 ((hasType(type_Entity, Var_AMOUNT) & hasType(type_ConstantQuantity, Var_AMOUNT)) => 
(( ! [Var_TOTAL] : 
 ((hasType(type_RealNumber, Var_TOTAL) & hasType(type_Quantity, Var_TOTAL)) => 
(( ! [Var_FRACTION] : 
 ((hasType(type_ConstantQuantity, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) => 
(( ! [Var_REGION] : 
 ((hasType(type_GeographicArea, Var_REGION) & hasType(type_Region, Var_REGION)) => 
(((((f_otherLandUseArea(Var_REGION,Var_FRACTION)) & (((f_greaterThanOrEqualTo(Var_FRACTION,0)) & (((f_totalArea(Var_REGION,f_MeasureFn(Var_TOTAL,Var_UNIT))) & (Var_AMOUNT = f_MeasureFn(f_MultiplicationFn(Var_FRACTION,Var_TOTAL),Var_UNIT)))))))) => (f_otherLandUseArea(Var_REGION,Var_AMOUNT))))))))))))))))))).

fof(axGeographyLem81, axiom, 
 ( ! [Var_AMOUNT] : 
 (hasType(type_AreaMeasure, Var_AMOUNT) => 
(( ! [Var_TOTAL] : 
 (hasType(type_AreaMeasure, Var_TOTAL) => 
(( ! [Var_FRACTION] : 
 ((hasType(type_Entity, Var_FRACTION) & hasType(type_ConstantQuantity, Var_FRACTION)) => 
(( ! [Var_REGION] : 
 ((hasType(type_GeographicArea, Var_REGION) & hasType(type_Region, Var_REGION)) => 
(((((f_irrigatedLandArea(Var_REGION,Var_AMOUNT)) & (((f_totalArea(Var_REGION,Var_TOTAL)) & (Var_FRACTION = f_DivisionFn(Var_AMOUNT,Var_TOTAL)))))) => (f_irrigatedLandArea(Var_REGION,Var_FRACTION)))))))))))))))).

fof(axGeographyLem82, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfArea, Var_UNIT) => 
(( ! [Var_FRACTION] : 
 ((hasType(type_Entity, Var_FRACTION) & hasType(type_ConstantQuantity, Var_FRACTION)) => 
(( ! [Var_TOTAL] : 
 ((hasType(type_RealNumber, Var_TOTAL) & hasType(type_Quantity, Var_TOTAL)) => 
(( ! [Var_AMOUNT] : 
 ((hasType(type_RealNumber, Var_AMOUNT) & hasType(type_Quantity, Var_AMOUNT)) => 
(( ! [Var_REGION] : 
 ((hasType(type_GeographicArea, Var_REGION) & hasType(type_Region, Var_REGION)) => 
(((((f_irrigatedLandArea(Var_REGION,f_MeasureFn(Var_AMOUNT,Var_UNIT))) & (((f_totalArea(Var_REGION,f_MeasureFn(Var_TOTAL,Var_UNIT))) & (Var_FRACTION = f_DivisionFn(Var_AMOUNT,Var_TOTAL)))))) => (f_irrigatedLandArea(Var_REGION,Var_FRACTION))))))))))))))))))).

fof(axGeographyLem83, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfArea, Var_UNIT) => 
(( ! [Var_PERMCROP] : 
 (hasType(type_Object, Var_PERMCROP) => 
(( ! [Var_AMOUNT] : 
 (hasType(type_RealNumber, Var_AMOUNT) => 
(( ! [Var_REGION] : 
 (hasType(type_GeographicArea, Var_REGION) => 
(((f_irrigatedLandArea(Var_REGION,f_MeasureFn(Var_AMOUNT,Var_UNIT))) => (( ? [Var_IRRLAND] : 
 (hasType(type_IrrigatedLand, Var_IRRLAND) &  
(((f_geographicSubregion(Var_IRRLAND,Var_REGION)) & (f_measure(Var_PERMCROP,f_MeasureFn(Var_AMOUNT,Var_UNIT)))))))))))))))))))))).

fof(axGeographyLem84, axiom, 
 ( ! [Var_DRYSPELL] : 
 (hasType(type_Drought, Var_DRYSPELL) => 
(( ! [Var_AREA] : 
 (hasType(type_Object, Var_AREA) => 
(((f_exactlyLocated(Var_DRYSPELL,Var_AREA)) => (( ? [Var_RAIN] : 
 (hasType(type_Raining, Var_RAIN) &  
(( ? [Var_PLACE] : 
 (hasType(type_Region, Var_PLACE) &  
(((f_located(Var_RAIN,Var_PLACE)) & (((f_overlapsSpatially(Var_PLACE,Var_AREA)) & (f_overlapsTemporally(Var_RAIN,Var_DRYSPELL)))))))))))))))))))).

fof(axGeographyLem85, axiom, 
 ( ! [Var_QUAKE] : 
 (hasType(type_Earthquake, Var_QUAKE) => 
(( ? [Var_TREMOR] : 
 (hasType(type_EarthTremor, Var_TREMOR) &  
(f_subProcess(Var_TREMOR,Var_QUAKE)))))))).

fof(axGeographyLem86, axiom, 
 ( ! [Var_SHOCK] : 
 (hasType(type_Aftershock, Var_SHOCK) => 
(( ! [Var_PLACE] : 
 (hasType(type_Object, Var_PLACE) => 
(((f_located(Var_SHOCK,Var_PLACE)) => (( ? [Var_TREMOR] : 
 (hasType(type_EarthTremor, Var_TREMOR) &  
(((f_located(Var_TREMOR,Var_PLACE)) & (f_before(f_WhenFn(Var_TREMOR),f_WhenFn(Var_SHOCK)))))))))))))))).

fof(axGeographyLem87, axiom, 
 ( ! [Var_QUAKE] : 
 (hasType(type_Earthquake, Var_QUAKE) => 
(( ! [Var_VALUE] : 
 (hasType(type_RealNumber, Var_VALUE) => 
(((f_measure(Var_QUAKE,f_MeasureFn(Var_VALUE,inst_RichterMagnitude))) => (( ? [Var_TREMOR] : 
 (hasType(type_EarthTremor, Var_TREMOR) &  
(((f_subProcess(Var_TREMOR,Var_QUAKE)) & (f_measure(Var_TREMOR,f_MeasureFn(Var_VALUE,inst_RichterMagnitude)))))))))))))))).

fof(axGeographyLem88, axiom, 
 ( ! [Var_QUAKE] : 
 (hasType(type_EarthTremor, Var_QUAKE) => 
(( ? [Var_FAULT] : 
 (hasType(type_GeologicalFault, Var_FAULT) &  
(f_origin(Var_QUAKE,Var_FAULT)))))))).

fof(axGeographyLem89, axiom, 
 ( ! [Var_QUAKE] : 
 (hasType(type_Earthquake, Var_QUAKE) => 
(( ? [Var_FAULT] : 
 (hasType(type_GeologicalFault, Var_FAULT) &  
(f_origin(Var_QUAKE,Var_FAULT)))))))).

fof(axGeographyLem90, axiom, 
 ( ! [Var_FIRE] : 
 (hasType(type_ForestFire, Var_FIRE) => 
(( ? [Var_FOREST] : 
 (hasType(type_Forest, Var_FOREST) &  
(((f_located(Var_FIRE,Var_FOREST)) & (f_patient(Var_FIRE,Var_FOREST)))))))))).

fof(axGeographyLem91, axiom, 
 ( ! [Var_FIRE] : 
 (hasType(type_GrassFire, Var_FIRE) => 
(( ? [Var_GRASS] : 
 (hasType(type_Grass, Var_GRASS) &  
(((f_located(Var_FIRE,Var_GRASS)) & (f_patient(Var_FIRE,Var_GRASS)))))))))).

fof(axGeographyLem92, axiom, 
 ( ! [Var_ERUPTING] : 
 (hasType(type_VolcanicEruption, Var_ERUPTING) => 
(( ? [Var_VOLCANO] : 
 (hasType(type_Volcano, Var_VOLCANO) &  
(f_located(Var_ERUPTING,Var_VOLCANO)))))))).

fof(axGeographyLem93, axiom, 
 ( ! [Var_ERUPTING] : 
 (hasType(type_VolcanicEruption, Var_ERUPTING) => 
(( ? [Var_HEATING] : 
 (hasType(type_Heating, Var_HEATING) &  
(f_subProcess(Var_HEATING,Var_ERUPTING)))))))).

fof(axGeographyLem94, axiom, 
 ( ! [Var_PH] : 
 ((hasType(type_RealNumber, Var_PH) & hasType(type_Quantity, Var_PH)) => 
(( ! [Var_SOLUTION] : 
 (hasType(type_Object, Var_SOLUTION) => 
(((f_measure(Var_SOLUTION,f_MeasureFn(Var_PH,inst_PHValue))) => (f_lessThanOrEqualTo(Var_PH,14)))))))))).

fof(axGeographyLem95, axiom, 
 ( ! [Var_PH] : 
 ((hasType(type_RealNumber, Var_PH) & hasType(type_Quantity, Var_PH)) => 
(( ! [Var_SOLUTION] : 
 (hasType(type_Object, Var_SOLUTION) => 
(((f_measure(Var_SOLUTION,f_MeasureFn(Var_PH,inst_PHValue))) => (f_greaterThanOrEqualTo(Var_PH,0)))))))))).

fof(axGeographyLem96, axiom, 
 ( ! [Var_RAINFALL] : 
 (hasType(type_Process, Var_RAINFALL) => 
(( ! [Var_RAIN] : 
 (hasType(type_Water, Var_RAIN) => 
(( ! [Var_PH] : 
 ((hasType(type_RealNumber, Var_PH) & hasType(type_Quantity, Var_PH)) => 
(((((f_patient(Var_RAINFALL,Var_RAIN)) & (f_measure(Var_RAIN,f_MeasureFn(Var_PH,inst_PHValue))))) => (f_lessThan(Var_PH,5.6))))))))))))).

fof(axGeographyLem97, axiom, 
 ( ! [Var_RESTORE] : 
 (hasType(type_Reforestation, Var_RESTORE) => 
(( ? [Var_TREE] : 
 (hasType(type_BotanicalTree, Var_TREE) &  
(((f_attribute(Var_TREE,inst_NonFullyFormed)) & (f_patient(Var_RESTORE,Var_TREE)))))))))).

fof(axGeographyLem98, axiom, 
 ( ! [Var_STUFF] : 
 (hasType(type_Effluent, Var_STUFF) => 
(f_attribute(Var_STUFF,inst_Fluid))))).

fof(axGeographyLem99, axiom, 
 ( ! [Var_WEARING] : 
 (hasType(type_Erosion, Var_WEARING) => 
(( ? [Var_LAND] : 
 (hasType(type_LandForm, Var_LAND) &  
(f_patient(Var_WEARING,Var_LAND)))))))).

fof(axGeographyLem100, axiom, 
 ( ! [Var_HARMING] : 
 (hasType(type_ForestDamage, Var_HARMING) => 
(( ? [Var_TREE] : 
 (hasType(type_BotanicalTree, Var_TREE) &  
(f_patient(Var_HARMING,Var_TREE)))))))).

fof(axGeographyLem101, axiom, 
 ( ! [Var_PROCESS] : 
 (hasType(type_Salination, Var_PROCESS) => 
(( ? [Var_SALT] : 
 (hasType(type_SodiumChloride, Var_SALT) &  
(f_resourceS(Var_PROCESS,Var_SALT)))))))).

fof(axGeographyLem102, axiom, 
 ( ! [Var_PROCESS] : 
 (hasType(type_SoilSalination, Var_PROCESS) => 
(( ? [Var_SOIL] : 
 (hasType(type_Soil, Var_SOIL) &  
(f_resourceS(Var_PROCESS,Var_SOIL)))))))).

fof(axGeographyLem103, axiom, 
 ( ! [Var_COMPACT] : 
 (hasType(type_Agreement, Var_COMPACT) => 
(( ? [Var_COMM] : 
 (hasType(type_Committing, Var_COMM) &  
(f_represents(Var_COMM,Var_COMPACT)))))))).

fof(axGeographyLem104, axiom, 
 ( ! [Var_AGREEMENT] : 
 (hasType(type_InternationalAgreement, Var_AGREEMENT) => 
(( ! [Var_COMMITTING] : 
 (hasType(type_Committing, Var_COMMITTING) => 
(((f_represents(Var_COMMITTING,Var_AGREEMENT)) => (( ? [Var_AGENT] : 
 (hasType(type_Nation, Var_AGENT) &  
(f_agent(Var_COMMITTING,Var_AGENT))))))))))))).

fof(axGeographyLem105, axiom, 
 ( ! [Var_PROP] : 
 (hasType(type_Proposition, Var_PROP) => 
(( ! [Var_CBO] : 
 (hasType(type_ContentBearingObject, Var_CBO) => 
(( ! [Var_COMM] : 
 (hasType(type_Communication, Var_COMM) => 
(((((f_containsInformation(Var_CBO,Var_PROP)) & (f_patient(Var_COMM,Var_CBO)))) => (f_represents(Var_COMM,Var_PROP))))))))))))).

fof(axGeographyLem106, axiom, 
 ( ! [Var_TREATY] : 
 (hasType(type_TreatyDocument, Var_TREATY) => 
(( ? [Var_COMM] : 
 (hasType(type_Committing, Var_COMM) &  
(( ? [Var_COUNTRY1] : 
 (hasType(type_GeopoliticalArea, Var_COUNTRY1) &  
(( ? [Var_COUNTRY2] : 
 (hasType(type_GeopoliticalArea, Var_COUNTRY2) &  
(((f_patient(Var_COMM,Var_TREATY)) & (((f_agent(Var_COMM,Var_COUNTRY1)) & (((f_agent(Var_COMM,Var_COUNTRY2)) & (Var_COUNTRY1 != Var_COUNTRY2))))))))))))))))))).

fof(axGeographyLem107, axiom, 
 ( ! [Var_CONTENT] : 
 (hasType(type_Proposition, Var_CONTENT) => 
(( ! [Var_AGENT] : 
 (hasType(type_Agent, Var_AGENT) => 
(((f_partyToAgreement(Var_AGENT,Var_CONTENT)) => (( ? [Var_COMMITTING] : 
 (hasType(type_Committing, Var_COMMITTING) &  
(( ? [Var_CBO] : 
 (hasType(type_ContentBearingObject, Var_CBO) &  
(((f_patient(Var_COMMITTING,Var_CBO)) & (((f_containsInformation(Var_CBO,Var_CONTENT)) & (f_agent(Var_COMMITTING,Var_AGENT)))))))))))))))))))).

fof(axGeographyLem108, axiom, 
 ( ! [Var_PROP] : 
 (hasType(type_Proposition, Var_PROP) => 
(( ! [Var_AGENT] : 
 (hasType(type_Agent, Var_AGENT) => 
(((f_unratifiedSignatoryToAgreement(Var_AGENT,Var_PROP)) => (( ~ (f_partyToAgreement(Var_AGENT,Var_PROP)))))))))))).

fof(axGeographyLem109, axiom, 
 ( ! [Var_SIGNING] : 
 (hasType(type_SigningADocument, Var_SIGNING) => 
(( ? [Var_DOC] : 
 (hasType(type_LinguisticExpression, Var_DOC) &  
(( ? [Var_TERMS] : 
 (hasType(type_Agreement, Var_TERMS) &  
(((f_containsInformation(Var_DOC,Var_TERMS)) & (f_patient(Var_SIGNING,Var_DOC))))))))))))).

fof(axGeographyLem110, axiom, 
 ( ! [Var_SAT] : 
 (hasType(type_Satellite, Var_SAT) => 
(( ! [Var_FOCUS] : 
 (hasType(type_AstronomicalBody, Var_FOCUS) => 
(( ? [Var_BODY] : 
 (hasType(type_AstronomicalBody, Var_BODY) &  
(f_orbits(Var_SAT,Var_FOCUS))))))))))).

fof(axGeographyLem111, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_Hemisphere, Var_AREA) => 
(f_geographicSubregion(Var_AREA,inst_PlanetEarth))))).

fof(axGeographyLem112, axiom, 
 ( ! [Var_HEMISPHERE] : 
 (hasType(type_Hemisphere, Var_HEMISPHERE) => 
(((Var_HEMISPHERE = inst_NorthernHemisphere) | (((Var_HEMISPHERE = inst_SouthernHemisphere) | (((Var_HEMISPHERE = inst_EasternHemisphere) | (Var_HEMISPHERE = inst_WesternHemisphere)))))))))).

fof(axGeographyLem113, axiom, 
 ( ! [Var_TWO] : 
 (hasType(type_Region, Var_TWO) => 
(( ! [Var_ONE] : 
 ((hasType(type_Object, Var_ONE) & hasType(type_Physical, Var_ONE)) => 
(((f_overlapsSpatially(Var_ONE,Var_TWO)) => (f_partlyLocated(Var_ONE,Var_TWO)))))))))).

fof(axGeographyLem114, axiom, 
 ( ! [Var_CONTINENT] : 
 (hasType(type_Continent, Var_CONTINENT) => 
(((inst_Africa = Var_CONTINENT) | (((inst_NorthAmerica = Var_CONTINENT) | (((inst_SouthAmerica = Var_CONTINENT) | (((inst_Antarctica = Var_CONTINENT) | (((inst_Europe = Var_CONTINENT) | (((inst_Asia = Var_CONTINENT) | (inst_Oceania = Var_CONTINENT)))))))))))))))).

fof(axGeographyLem115, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_Continent, Var_AREA) => 
(f_geographicSubregion(Var_AREA,inst_PlanetEarth))))).

fof(axGeographyLem116, axiom, 
 ( ! [Var_DIR] : 
 (hasType(type_PositionalAttribute, Var_DIR) => 
(( ! [Var_OPPDIR] : 
 (hasType(type_PositionalAttribute, Var_OPPDIR) => 
(( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((((f_orientation(Var_OBJ1,Var_OBJ2,Var_DIR)) & (f_oppositeDirection(Var_DIR,Var_OPPDIR)))) => (f_orientation(Var_OBJ2,Var_OBJ1,Var_OPPDIR)))))))))))))))).

fof(axGeographyLem117, axiom, 
 ( ! [Var_DIR2] : 
 (hasType(type_PositionalAttribute, Var_DIR2) => 
(( ! [Var_DIR1] : 
 (hasType(type_PositionalAttribute, Var_DIR1) => 
(((f_oppositeDirection(Var_DIR1,Var_DIR2)) => (f_contraryAttribute(lista)))))))))).

fof(axGeographyLem118, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_orientation(Var_OBJ1,Var_OBJ2,inst_Northeast)) <=> (((f_orientation(Var_OBJ1,Var_OBJ2,inst_North)) & (f_orientation(Var_OBJ1,Var_OBJ2,inst_East)))))))))))).

fof(axGeographyLem119, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_orientation(Var_OBJ1,Var_OBJ2,inst_Southeast)) <=> (((f_orientation(Var_OBJ1,Var_OBJ2,inst_South)) & (f_orientation(Var_OBJ1,Var_OBJ2,inst_East)))))))))))).

fof(axGeographyLem120, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_orientation(Var_OBJ1,Var_OBJ2,inst_Southwest)) <=> (((f_orientation(Var_OBJ1,Var_OBJ2,inst_South)) & (f_orientation(Var_OBJ1,Var_OBJ2,inst_West)))))))))))).

fof(axGeographyLem121, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_orientation(Var_OBJ1,Var_OBJ2,inst_Northwest)) <=> (((f_orientation(Var_OBJ1,Var_OBJ2,inst_North)) & (f_orientation(Var_OBJ1,Var_OBJ2,inst_West)))))))))))).

fof(axGeographyLem122, axiom, 
 ( ! [Var_OBJ2] : 
 ((hasType(type_Physical, Var_OBJ2) & hasType(type_Object, Var_OBJ2)) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_Physical, Var_OBJ1) & hasType(type_Object, Var_OBJ1)) => 
(((f_courseWRTTrueNorth(Var_OBJ1,Var_OBJ2,f_MeasureFn(180,inst_AngularDegree))) <=> (f_orientation(Var_OBJ1,Var_OBJ2,inst_South)))))))))).

fof(axGeographyLem123, axiom, 
 ( ! [Var_OBJ2] : 
 ((hasType(type_Physical, Var_OBJ2) & hasType(type_Object, Var_OBJ2)) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_Physical, Var_OBJ1) & hasType(type_Object, Var_OBJ1)) => 
(((f_courseWRTTrueNorth(Var_OBJ1,Var_OBJ2,f_MeasureFn(270,inst_AngularDegree))) <=> (f_orientation(Var_OBJ1,Var_OBJ2,inst_West)))))))))).

fof(axGeographyLem124, axiom, 
 ( ! [Var_OBJ2] : 
 ((hasType(type_Physical, Var_OBJ2) & hasType(type_Object, Var_OBJ2)) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_Physical, Var_OBJ1) & hasType(type_Object, Var_OBJ1)) => 
(((f_courseWRTTrueNorth(Var_OBJ1,Var_OBJ2,f_MeasureFn(360,inst_AngularDegree))) <=> (f_orientation(Var_OBJ1,Var_OBJ2,inst_North)))))))))).

fof(axGeographyLem125, axiom, 
 ( ! [Var_OBJ2] : 
 ((hasType(type_Physical, Var_OBJ2) & hasType(type_Object, Var_OBJ2)) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_Physical, Var_OBJ1) & hasType(type_Object, Var_OBJ1)) => 
(((f_courseWRTTrueNorth(Var_OBJ1,Var_OBJ2,f_MeasureFn(135,inst_AngularDegree))) <=> (f_orientation(Var_OBJ1,Var_OBJ2,inst_Southeast)))))))))).

fof(axGeographyLem126, axiom, 
 ( ! [Var_OBJ2] : 
 ((hasType(type_Physical, Var_OBJ2) & hasType(type_Object, Var_OBJ2)) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_Physical, Var_OBJ1) & hasType(type_Object, Var_OBJ1)) => 
(((f_courseWRTTrueNorth(Var_OBJ1,Var_OBJ2,f_MeasureFn(225,inst_AngularDegree))) <=> (f_orientation(Var_OBJ1,Var_OBJ2,inst_Southwest)))))))))).

fof(axGeographyLem127, axiom, 
 ( ! [Var_OBJ2] : 
 ((hasType(type_Physical, Var_OBJ2) & hasType(type_Object, Var_OBJ2)) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_Physical, Var_OBJ1) & hasType(type_Object, Var_OBJ1)) => 
(((f_courseWRTTrueNorth(Var_OBJ1,Var_OBJ2,f_MeasureFn(315,inst_AngularDegree))) <=> (f_orientation(Var_OBJ1,Var_OBJ2,inst_Northwest)))))))))).

fof(axGeographyLem128, axiom, 
 ( ! [Var_DIRECTION] : 
 ((hasType(type_DirectionalAttribute, Var_DIRECTION) & hasType(type_Entity, Var_DIRECTION)) => 
(( ! [Var_DEGREE] : 
 (hasType(type_PlaneAngleMeasure, Var_DEGREE) => 
(( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(((f_magneticVariation(Var_AREA,Var_DEGREE,Var_DIRECTION)) => (((Var_DIRECTION = inst_East) | (Var_DIRECTION = inst_West)))))))))))))).

fof(axGeographyLem129, axiom, 
 ( ! [Var_DIRECTION] : 
 ((hasType(type_DirectionalAttribute, Var_DIRECTION) & hasType(type_Entity, Var_DIRECTION)) => 
(( ! [Var_DEGREE] : 
 ((hasType(type_PlaneAngleMeasure, Var_DEGREE) & hasType(type_Quantity, Var_DEGREE)) => 
(( ! [Var_AREA] : 
 ((hasType(type_Object, Var_AREA) & hasType(type_GeographicArea, Var_AREA)) => 
(( ! [Var_MAGDEGREE] : 
 ((hasType(type_PlaneAngleMeasure, Var_MAGDEGREE) & hasType(type_Quantity, Var_MAGDEGREE)) => 
(( ! [Var_OBJ2] : 
 (hasType(type_Physical, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Physical, Var_OBJ1) => 
(((((f_courseWRTMagneticNorth(Var_OBJ1,Var_OBJ2,Var_MAGDEGREE)) & (((f_partlyLocated(Var_OBJ1,Var_AREA)) & (((f_partlyLocated(Var_OBJ2,Var_AREA)) & (f_magneticVariation(Var_AREA,Var_DEGREE,Var_DIRECTION)))))))) => (( ? [Var_TRUEDEGREE] : 
 (hasType(type_PlaneAngleMeasure, Var_TRUEDEGREE) &  
(( ? [Var_DIFFDEGREE] : 
 (hasType(type_Entity, Var_DIFFDEGREE) &  
(((((((Var_DIRECTION = inst_East) & (Var_DIFFDEGREE = f_AdditionFn(Var_MAGDEGREE,Var_DEGREE)))) => (f_courseWRTTrueNorth(Var_OBJ1,Var_OBJ2,Var_TRUEDEGREE)))) & (((((Var_DIRECTION = inst_West) & (Var_DIFFDEGREE = f_SubtractionFn(Var_MAGDEGREE,Var_DEGREE)))) => (f_courseWRTTrueNorth(Var_OBJ1,Var_OBJ2,Var_TRUEDEGREE)))))))))))))))))))))))))))))))).

fof(axGeographyLem130, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_Fathom) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,6),inst_FootLength))))))).

fof(axGeographyLem131, axiom, 
 ( ! [Var_NUM] : 
 ((hasType(type_RealNumber, Var_NUM) & hasType(type_Quantity, Var_NUM)) => 
(( ! [Var_AMOUNT] : 
 (hasType(type_Entity, Var_AMOUNT) => 
(((Var_AMOUNT = f_MeasureFn(Var_NUM,inst_NauticalMile)) => (Var_AMOUNT = f_MeasureFn(f_MultiplicationFn(Var_NUM,1.852),f_KiloFn(inst_Meter))))))))))).

fof(axGeographyLem132, axiom, 
 ( ! [Var_NUM] : 
 ((hasType(type_RealNumber, Var_NUM) & hasType(type_Quantity, Var_NUM)) => 
(( ! [Var_AMOUNT] : 
 (hasType(type_Entity, Var_AMOUNT) => 
(((Var_AMOUNT = f_MeasureFn(Var_NUM,inst_NauticalMile)) => (Var_AMOUNT = f_MeasureFn(f_MultiplicationFn(Var_NUM,1.151),inst_Mile)))))))))).

fof(axGeographyLem133, axiom, 
 ( ! [Var_NUM] : 
 ((hasType(type_Entity, Var_NUM) & hasType(type_RealNumber, Var_NUM) & hasType(type_Quantity, Var_NUM)) => 
(((Var_NUM = f_MultiplicationFn(1,Var_NUM)) => (f_MeasureFn(Var_NUM,inst_NauticalMile) = f_MeasureFn(f_MultiplicationFn(Var_NUM,1852),inst_Meter))))))).

fof(axGeographyLem134, axiom, 
 ( ! [Var_NUM] : 
 ((hasType(type_Entity, Var_NUM) & hasType(type_RealNumber, Var_NUM) & hasType(type_Quantity, Var_NUM)) => 
(((Var_NUM = f_MultiplicationFn(1,Var_NUM)) => (f_MeasureFn(Var_NUM,inst_NauticalMile) = f_MeasureFn(f_MultiplicationFn(Var_NUM,1.852),f_KiloFn(inst_Meter)))))))).

fof(axGeographyLem135, axiom, 
 ( ! [Var_NUM] : 
 ((hasType(type_Entity, Var_NUM) & hasType(type_RealNumber, Var_NUM) & hasType(type_Quantity, Var_NUM)) => 
(((Var_NUM = f_MultiplicationFn(1,Var_NUM)) => (f_MeasureFn(Var_NUM,inst_NauticalMile) = f_MeasureFn(f_MultiplicationFn(Var_NUM,6076.1),inst_FootLength))))))).

fof(axGeographyLem136, axiom, 
 ( ! [Var_NUM] : 
 ((hasType(type_Entity, Var_NUM) & hasType(type_RealNumber, Var_NUM) & hasType(type_Quantity, Var_NUM)) => 
(((Var_NUM = f_MultiplicationFn(1,Var_NUM)) => (f_MeasureFn(Var_NUM,inst_NauticalMile) = f_MeasureFn(f_MultiplicationFn(Var_NUM,1.151),inst_Mile))))))).

fof(axGeographyLem137, axiom, 
 ( ! [Var_TIME] : 
 ((hasType(type_RealNumber, Var_TIME) & hasType(type_Quantity, Var_TIME)) => 
(( ! [Var_DISTANCE] : 
 ((hasType(type_RealNumber, Var_DISTANCE) & hasType(type_Quantity, Var_DISTANCE)) => 
(( ! [Var_SPEED] : 
 (hasType(type_Entity, Var_SPEED) => 
(((Var_SPEED = f_SpeedFn(f_MeasureFn(Var_DISTANCE,inst_NauticalMile),f_MeasureFn(Var_TIME,inst_HourDuration))) => (Var_SPEED = f_MeasureFn(f_DivisionFn(Var_DISTANCE,Var_TIME),inst_KnotUnitOfSpeed))))))))))))).

fof(axGeographyLem138, axiom, 
 ( ! [Var_NUM] : 
 (hasType(type_RealNumber, Var_NUM) => 
(( ! [Var_SPEED] : 
 (hasType(type_Entity, Var_SPEED) => 
(((Var_SPEED = f_MeasureFn(Var_NUM,inst_KnotUnitOfSpeed)) => (Var_SPEED = f_SpeedFn(f_MeasureFn(Var_NUM,inst_NauticalMile),f_MeasureFn(1,inst_HourDuration))))))))))).

fof(axGeographyLem139, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfMeasure, Var_UNIT) => 
(( ! [Var_AMOUNT] : 
 (hasType(type_Entity, Var_AMOUNT) => 
(((Var_AMOUNT = f_MeasureFn(1,f_SquareUnitFn(Var_UNIT))) <=> (Var_AMOUNT = f_MultiplicationFn(f_MeasureFn(1,Var_UNIT),f_MeasureFn(1,Var_UNIT))))))))))).

fof(axGeographyLem140, axiom, 
 ( ! [Var_PLACE] : 
 (hasType(type_UndergroundArea, Var_PLACE) => 
(( ? [Var_GROUND] : 
 ((hasType(type_SelfConnectedObject, Var_GROUND) & hasType(type_Object, Var_GROUND)) &  
(( ? [Var_AREA] : 
 (hasType(type_Object, Var_AREA) &  
(((f_surface(Var_GROUND,inst_PlanetEarth)) & (((f_part(Var_AREA,Var_GROUND)) & (f_orientation(Var_PLACE,Var_AREA,inst_Below))))))))))))))).

fof(axGeographyLem141, axiom, 
 ( ! [Var_RANGE] : 
 (hasType(type_MountainRange, Var_RANGE) => 
(( ! [Var_MOUNTAIN1] : 
 (hasType(type_Object, Var_MOUNTAIN1) => 
(((f_part(Var_MOUNTAIN1,Var_RANGE)) => (( ? [Var_MOUNTAIN2] : 
 (hasType(type_Mountain, Var_MOUNTAIN2) &  
(((f_component(Var_MOUNTAIN2,Var_RANGE)) & (f_meetsSpatially(Var_MOUNTAIN1,Var_MOUNTAIN2))))))))))))))).

fof(axGeographyLem142, axiom, 
 ( ! [Var_MOUNTAIN] : 
 (hasType(type_Mountain, Var_MOUNTAIN) => 
(( ? [Var_INCLINE] : 
 (hasType(type_SlopedArea, Var_INCLINE) &  
(((f_attribute(Var_INCLINE,inst_SteepTerrain)) & (f_part(Var_INCLINE,Var_MOUNTAIN)))))))))).

fof(axGeographyLem143, axiom, 
 ( ! [Var_HILL] : 
 (hasType(type_Hill, Var_HILL) => 
(( ? [Var_INCLINE] : 
 (hasType(type_SlopedArea, Var_INCLINE) &  
(f_part(Var_INCLINE,Var_HILL)))))))).

fof(axGeographyLem144, axiom, 
 ( ! [Var_EVENT] : 
 (hasType(type_VolcanicEruption, Var_EVENT) => 
(( ? [Var_VOLCANO] : 
 (hasType(type_Volcano, Var_VOLCANO) &  
(f_agent(Var_EVENT,Var_VOLCANO)))))))).

fof(axGeographyLem145, axiom, 
 ( ! [Var_CLIFF] : 
 (hasType(type_Cliff, Var_CLIFF) => 
(( ? [Var_SLOPE] : 
 (hasType(type_RationalNumber, Var_SLOPE) &  
(((f_slopeGradient(Var_CLIFF,Var_SLOPE)) & (((f_greaterThan(Var_SLOPE,0.6)) & (f_greaterThan(1.2,Var_SLOPE)))))))))))).

fof(axGeographyLem146, axiom, 
 ( ! [Var_PLATEAU] : 
 (hasType(type_Plateau, Var_PLATEAU) => 
(( ! [Var_TOP] : 
 ((hasType(type_SelfConnectedObject, Var_TOP) & hasType(type_Object, Var_TOP)) => 
(((f_top(Var_TOP,Var_PLATEAU)) => (f_attribute(Var_TOP,inst_FlatTerrain)))))))))).

fof(axGeographyLem147, axiom, 
 ( ! [Var_PLATEAU] : 
 (hasType(type_Plateau, Var_PLATEAU) => 
(( ? [Var_SLOPE] : 
 (hasType(type_SlopedArea, Var_SLOPE) &  
(((f_attribute(Var_SLOPE,inst_SteepTerrain)) & (f_overlapsSpatially(Var_SLOPE,Var_PLATEAU)))))))))).

fof(axGeographyLem148, axiom, 
 ( ! [Var_MESA] : 
 (hasType(type_Mesa, Var_MESA) => 
(( ! [Var_TOP] : 
 ((hasType(type_SelfConnectedObject, Var_TOP) & hasType(type_Object, Var_TOP)) => 
(((f_top(Var_TOP,Var_MESA)) => (f_attribute(Var_TOP,inst_FlatTerrain)))))))))).

fof(axGeographyLem149, axiom, 
 ( ! [Var_MESA] : 
 (hasType(type_Mesa, Var_MESA) => 
(( ! [Var_SIDE] : 
 ((hasType(type_SelfConnectedObject, Var_SIDE) & hasType(type_Object, Var_SIDE)) => 
(((f_side(Var_SIDE,Var_MESA)) => (f_attribute(Var_SIDE,inst_SteepTerrain)))))))))).

fof(axGeographyLem150, axiom, 
 ( ! [Var_BUTTE] : 
 (hasType(type_Butte, Var_BUTTE) => 
(( ! [Var_SIDE] : 
 ((hasType(type_SelfConnectedObject, Var_SIDE) & hasType(type_Object, Var_SIDE)) => 
(((f_side(Var_SIDE,Var_BUTTE)) => (f_attribute(Var_SIDE,inst_SteepTerrain)))))))))).

fof(axGeographyLem151, axiom, 
 ( ! [Var_BUTTE] : 
 (hasType(type_Butte, Var_BUTTE) => 
(( ! [Var_TOP] : 
 ((hasType(type_SelfConnectedObject, Var_TOP) & hasType(type_Object, Var_TOP)) => 
(((f_top(Var_TOP,Var_BUTTE)) => (f_attribute(Var_TOP,inst_FlatTerrain)))))))))).

fof(axGeographyLem152, axiom, 
 ( ! [Var_BUTTE] : 
 (hasType(type_Butte, Var_BUTTE) => 
(( ! [Var_MESA] : 
 (hasType(type_Mesa, Var_MESA) => 
(( ! [Var_SIZE2] : 
 ((hasType(type_RealNumber, Var_SIZE2) & hasType(type_Quantity, Var_SIZE2)) => 
(( ! [Var_UNIT] : 
 (hasType(type_UnitOfMeasure, Var_UNIT) => 
(( ! [Var_SIZE1] : 
 ((hasType(type_RealNumber, Var_SIZE1) & hasType(type_Quantity, Var_SIZE1)) => 
(((((f_linearExtent(Var_BUTTE,f_MeasureFn(Var_SIZE1,Var_UNIT))) & (f_linearExtent(Var_MESA,f_MeasureFn(Var_SIZE2,Var_UNIT))))) => (f_greaterThan(Var_SIZE2,Var_SIZE1))))))))))))))))))).

fof(axGeographyLem153, axiom, 
 ( ! [Var_PIEDMONT] : 
 (hasType(type_Piedmont, Var_PIEDMONT) => 
(( ! [Var_HEIGHT2] : 
 ((hasType(type_LengthMeasure, Var_HEIGHT2) & hasType(type_Attribute, Var_HEIGHT2) & hasType(type_Quantity, Var_HEIGHT2)) => 
(( ! [Var_HEIGHT1] : 
 ((hasType(type_LengthMeasure, Var_HEIGHT1) & hasType(type_Attribute, Var_HEIGHT1) & hasType(type_Quantity, Var_HEIGHT1)) => 
(( ! [Var_MOUNTAINS] : 
 ((hasType(type_Object, Var_MOUNTAINS) & hasType(type_SelfConnectedObject, Var_MOUNTAINS)) => 
(((((f_attribute(Var_MOUNTAINS,inst_MountainousTerrain)) & (((f_orientation(Var_PIEDMONT,Var_MOUNTAINS,inst_Adjacent)) & (((f_height(Var_PIEDMONT,Var_HEIGHT1)) & (((f_height(Var_MOUNTAINS,Var_HEIGHT2)) & (f_successorAttributeClosure(Var_HEIGHT1,Var_HEIGHT2)))))))))) => (f_greaterThan(Var_HEIGHT2,Var_HEIGHT1)))))))))))))))).

fof(axGeographyLem154, axiom, 
 ( ! [Var_PLAIN] : 
 (hasType(type_Plain, Var_PLAIN) => 
(f_attribute(Var_PLAIN,inst_FlatTerrain))))).

fof(axGeographyLem155, axiom, 
 ( ! [Var_CANYON] : 
 (hasType(type_Canyon, Var_CANYON) => 
(( ? [Var_HOLE] : 
 (hasType(type_Hole, Var_HOLE) &  
(f_hole(Var_HOLE,Var_CANYON)))))))).

fof(axGeographyLem156, axiom, 
 ( ! [Var_CANYON] : 
 (hasType(type_Canyon, Var_CANYON) => 
(( ? [Var_EROSION] : 
 (hasType(type_Erosion, Var_EROSION) &  
(f_result(Var_EROSION,Var_CANYON)))))))).

fof(axGeographyLem157, axiom, 
 ( ! [Var_SOIL] : 
 (hasType(type_Soil, Var_SOIL) => 
(( ? [Var_HUMUS] : 
 (hasType(type_Humus, Var_HUMUS) &  
(( ? [Var_MINERAL] : 
 (hasType(type_Mineral, Var_MINERAL) &  
(((f_part(Var_HUMUS,Var_SOIL)) & (f_part(Var_MINERAL,Var_SOIL))))))))))))).

fof(axGeographyLem158, axiom, 
 ( ! [Var_HUMUS] : 
 (hasType(type_Humus, Var_HUMUS) => 
(( ? [Var_SOIL] : 
 (hasType(type_Soil, Var_SOIL) &  
(f_part(Var_HUMUS,Var_SOIL)))))))).

fof(axGeographyLem159, axiom, 
 ( ! [Var_SOLUTION] : 
 (hasType(type_SoilSolution, Var_SOLUTION) => 
(( ? [Var_SOIL] : 
 (hasType(type_Soil, Var_SOIL) &  
(f_part(Var_SOLUTION,Var_SOIL)))))))).

fof(axGeographyLem160, axiom, 
 ( ! [Var_SOIL] : 
 (hasType(type_Clay, Var_SOIL) => 
(( ! [Var_SIZE] : 
 ((hasType(type_RealNumber, Var_SIZE) & hasType(type_Quantity, Var_SIZE)) => 
(( ! [Var_PARTICLE] : 
 ((hasType(type_Object, Var_PARTICLE) & hasType(type_Circle, Var_PARTICLE)) => 
(((((f_part(Var_PARTICLE,Var_SOIL)) & (f_diameter(Var_PARTICLE,f_MeasureFn(Var_SIZE,inst_Centimeter))))) => (f_greaterThan(2.0e-4,Var_SIZE))))))))))))).

fof(axGeographyLem161, axiom, 
 ( ! [Var_LOAM] : 
 (hasType(type_Loam, Var_LOAM) => 
(( ? [Var_CLAY] : 
 (hasType(type_Clay, Var_CLAY) &  
(( ? [Var_SAND] : 
 (hasType(type_Sand, Var_SAND) &  
(( ? [Var_GRAVEL] : 
 (hasType(type_Gravel, Var_GRAVEL) &  
(( ? [Var_SILT] : 
 (hasType(type_Silt, Var_SILT) &  
(( ? [Var_ORGANIC] : 
 (hasType(type_BodySubstance, Var_ORGANIC) &  
(((f_piece(Var_CLAY,Var_LOAM)) & (((f_piece(Var_GRAVEL,Var_LOAM)) & (((f_piece(Var_SAND,Var_LOAM)) & (((f_piece(Var_SILT,Var_LOAM)) & (f_piece(Var_ORGANIC,Var_LOAM)))))))))))))))))))))))))))).

fof(axGeographyLem162, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(((f_groundSurfaceType(Var_AREA,type_Loam)) => (f_attribute(Var_AREA,inst_FertileTerrain))))))).

fof(axGeographyLem163, axiom, 
 ( ! [Var_SOIL] : 
 (hasType(type_Sand, Var_SOIL) => 
(( ! [Var_SIZE] : 
 ((hasType(type_RealNumber, Var_SIZE) & hasType(type_Quantity, Var_SIZE)) => 
(( ! [Var_PARTICLE] : 
 ((hasType(type_Object, Var_PARTICLE) & hasType(type_Circle, Var_PARTICLE)) => 
(((((f_part(Var_PARTICLE,Var_SOIL)) & (f_diameter(Var_PARTICLE,f_MeasureFn(Var_SIZE,inst_Centimeter))))) => (((f_greaterThan(Var_SIZE,2.0e-5)) & (f_greaterThan(5.0e-3,Var_SIZE))))))))))))))).

fof(axGeographyLem164, axiom, 
 ( ! [Var_ROCK] : 
 (hasType(type_Rock, Var_ROCK) => 
(f_attribute(Var_ROCK,inst_Solid))))).

fof(axGeographyLem165, axiom, 
 ( ! [Var_ROCK] : 
 (hasType(type_Rock, Var_ROCK) => 
(( ? [Var_MINERAL] : 
 (hasType(type_Mineral, Var_MINERAL) &  
(f_part(Var_MINERAL,Var_ROCK)))))))).

fof(axGeographyLem166, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(((f_groundSurfaceType(Var_AREA,type_Rock)) => (( ~ (f_attribute(Var_AREA,inst_FertileTerrain))))))))).

fof(axGeographyLem167, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_Continent, Var_AREA) => 
(f_meetsSpatially(Var_AREA,inst_WorldOcean))))).

fof(axGeographyLem168, axiom, 
 ( ! [Var_WATER] : 
 ((hasType(type_BodyOfWater, Var_WATER) & hasType(type_Ocean, Var_WATER)) => 
(( ! [Var_OCEAN] : 
 (hasType(type_Ocean, Var_OCEAN) => 
(f_larger(Var_OCEAN,Var_WATER)))))))).

fof(axGeographyLem169, axiom, 
 ( ! [Var_OCEAN] : 
 (hasType(type_Ocean, Var_OCEAN) => 
(f_properPart(Var_OCEAN,inst_WorldOcean))))).

fof(axGeographyLem170, axiom, 
 ( ! [Var_SEA] : 
 (hasType(type_Ocean, Var_SEA) => 
(((Var_SEA != inst_ArcticOcean) => (f_smaller(inst_ArcticOcean,Var_SEA))))))).

fof(axGeographyLem171, axiom, 
 ( ! [Var_FINISH] : 
 ((hasType(type_Entity, Var_FINISH) & hasType(type_Physical, Var_FINISH)) => 
(( ! [Var_START] : 
 ((hasType(type_Object, Var_START) & hasType(type_Physical, Var_START)) => 
(((((f_origin(inst_AntarcticCircumpolarCurrent,Var_START)) & (f_destination(inst_AntarcticCircumpolarCurrent,Var_FINISH)))) => (f_distance(Var_START,Var_FINISH,f_MeasureFn(21000,f_KiloFn(inst_Meter)))))))))))).

fof(axGeographyLem172, axiom, 
 ( ! [Var_SEA] : 
 (hasType(type_Sea, Var_SEA) => 
(f_properPart(Var_SEA,inst_WorldOcean))))).

fof(axGeographyLem173, axiom, 
 ( ! [Var_SEA] : 
 (hasType(type_Sea, Var_SEA) => 
(( ? [Var_OCEAN] : 
 (hasType(type_Ocean, Var_OCEAN) &  
(( ? [Var_PATH] : 
 (hasType(type_WaterArea, Var_PATH) &  
(f_connects(Var_PATH,Var_OCEAN,Var_SEA))))))))))).

fof(axGeographyLem174, axiom, 
 ( ! [Var_SEA] : 
 (hasType(type_Sea, Var_SEA) => 
(( ? [Var_LAND] : 
 (hasType(type_LandArea, Var_LAND) &  
(f_meetsSpatially(Var_LAND,Var_SEA)))))))).

fof(axGeographyLem175, axiom, 
 ( ! [Var_OCEAN] : 
 (hasType(type_Ocean, Var_OCEAN) => 
(( ! [Var_TOP] : 
 ((hasType(type_SelfConnectedObject, Var_TOP) & hasType(type_Object, Var_TOP)) => 
(((f_surface(Var_TOP,Var_OCEAN)) => (f_elevation(Var_TOP,f_MeasureFn(0,inst_Meter))))))))))).

fof(axGeographyLem176, axiom, 
 ( ! [Var_OCEAN] : 
 (hasType(type_Ocean, Var_OCEAN) => 
(( ! [Var_TOP] : 
 ((hasType(type_SelfConnectedObject, Var_TOP) & hasType(type_Object, Var_TOP)) => 
(((f_surface(Var_TOP,Var_OCEAN)) => (f_elevation(Var_TOP,f_MeasureFn(0,inst_FootLength))))))))))).

fof(axGeographyLem177, axiom, 
 ( ! [Var_FR] : 
 (hasType(type_FlowRegion, Var_FR) => 
(( ! [Var_FLUID] : 
 ((hasType(type_Physical, Var_FLUID) & hasType(type_Object, Var_FLUID)) => 
(((f_located(Var_FLUID,Var_FR)) => (f_attribute(Var_FLUID,inst_Fluid)))))))))).

fof(axGeographyLem178, axiom, 
 ( ! [Var_PART] : 
 (hasType(type_Substance, Var_PART) => 
(( ! [Var_TIME] : 
 (hasType(type_TimeDuration, Var_TIME) => 
(( ! [Var_LENGTH] : 
 (hasType(type_LengthMeasure, Var_LENGTH) => 
(( ! [Var_FLUID] : 
 ((hasType(type_FlowRegion, Var_FLUID) & hasType(type_Substance, Var_FLUID)) => 
(((((f_measure(f_FlowFn(Var_FLUID),f_SpeedFn(Var_LENGTH,Var_TIME))) & (f_piece(Var_PART,Var_FLUID)))) => (f_piece(Var_PART,f_SpeedFn(Var_LENGTH,Var_TIME))))))))))))))))).

fof(axGeographyLem179, axiom, 
 ( ! [Var_PART] : 
 (hasType(type_Substance, Var_PART) => 
(( ! [Var_NUM] : 
 (hasType(type_RealNumber, Var_NUM) => 
(( ! [Var_FLUID] : 
 ((hasType(type_FlowRegion, Var_FLUID) & hasType(type_Substance, Var_FLUID)) => 
(((((f_measure(f_FlowFn(Var_FLUID),f_MeasureFn(Var_NUM,inst_KnotUnitOfSpeed))) & (f_piece(Var_PART,Var_FLUID)))) => (f_piece(Var_PART,f_MeasureFn(Var_NUM,inst_KnotUnitOfSpeed)))))))))))))).

fof(axGeographyLem180, axiom, 
 ( ! [Var_PART] : 
 ((hasType(type_Substance, Var_PART) & hasType(type_Object, Var_PART)) => 
(( ! [Var_DIRECTION] : 
 (hasType(type_DirectionalAttribute, Var_DIRECTION) => 
(( ! [Var_REGION] : 
 (hasType(type_Region, Var_REGION) => 
(( ! [Var_TIME] : 
 (hasType(type_TimeDuration, Var_TIME) => 
(( ! [Var_LENGTH] : 
 (hasType(type_LengthMeasure, Var_LENGTH) => 
(( ! [Var_FLUID] : 
 ((hasType(type_FlowRegion, Var_FLUID) & hasType(type_Substance, Var_FLUID)) => 
(((((f_measure(f_FlowFn(Var_FLUID),f_VelocityFn(Var_LENGTH,Var_TIME,Var_REGION,Var_DIRECTION))) & (f_piece(Var_PART,Var_FLUID)))) => (f_measure(Var_PART,f_VelocityFn(Var_LENGTH,Var_TIME,Var_REGION,Var_DIRECTION))))))))))))))))))))))).

fof(axGeographyLem181, axiom, 
 ( ! [Var_LOW] : 
 (hasType(type_LowTide, Var_LOW) => 
(( ! [Var_HIGH] : 
 (hasType(type_HighTide, Var_HIGH) => 
(( ! [Var_DAY] : 
 (hasType(type_Day, Var_DAY) => 
(( ! [Var_PLACE] : 
 ((hasType(type_Object, Var_PLACE) & hasType(type_WaterArea, Var_PLACE)) => 
(((((f_exactlyLocated(Var_LOW,Var_PLACE)) & (((f_exactlyLocated(Var_HIGH,Var_PLACE)) & (((f_overlapsTemporally(Var_LOW,Var_DAY)) & (f_overlapsTemporally(Var_HIGH,Var_DAY)))))))) => (( ? [Var_AMOUNT2] : 
 ((hasType(type_LengthMeasure, Var_AMOUNT2) & hasType(type_Quantity, Var_AMOUNT2)) &  
(( ? [Var_AMOUNT1] : 
 ((hasType(type_LengthMeasure, Var_AMOUNT1) & hasType(type_Quantity, Var_AMOUNT1)) &  
(((f_holdsDuring(Var_LOW,waterDepth(Var_PLACE,Var_AMOUNT1))) & (((f_holdsDuring(Var_HIGH,waterDepth(Var_PLACE,Var_AMOUNT2))) & (f_greaterThan(Var_AMOUNT2,Var_AMOUNT1)))))))))))))))))))))))))).

fof(axGeographyLem182, axiom, 
 ( ! [Var_DAY] : 
 (hasType(type_Day, Var_DAY) => 
(( ! [Var_AMOUNT2] : 
 ((hasType(type_LengthMeasure, Var_AMOUNT2) & hasType(type_Quantity, Var_AMOUNT2)) => 
(( ! [Var_TIME2] : 
 (hasType(type_TimeInterval, Var_TIME2) => 
(( ! [Var_AMOUNT1] : 
 ((hasType(type_LengthMeasure, Var_AMOUNT1) & hasType(type_Quantity, Var_AMOUNT1)) => 
(( ! [Var_TIME1] : 
 (hasType(type_TimeInterval, Var_TIME1) => 
(( ! [Var_PLACE] : 
 (hasType(type_Region, Var_PLACE) => 
(((((f_lowTide(Var_PLACE,Var_TIME1,Var_AMOUNT1)) & (((f_highTide(Var_PLACE,Var_TIME2,Var_AMOUNT2)) & (((f_overlapsTemporally(Var_TIME1,Var_DAY)) & (f_overlapsTemporally(Var_TIME2,Var_DAY)))))))) => (f_greaterThan(Var_AMOUNT1,Var_AMOUNT2)))))))))))))))))))))).

fof(axGeographyLem183, axiom, 
 ( ! [Var_GULF] : 
 (hasType(type_Gulf, Var_GULF) => 
(( ? [Var_SEA] : 
 ((hasType(type_Sea, Var_SEA) & hasType(type_Ocean, Var_SEA)) &  
(f_connected(Var_GULF,Var_SEA)))))))).

fof(axGeographyLem184, axiom, 
 ( ! [Var_GULF] : 
 (hasType(type_Gulf, Var_GULF) => 
(( ? [Var_WATER] : 
 (hasType(type_SaltWaterArea, Var_WATER) &  
(f_properPart(Var_GULF,Var_WATER)))))))).

fof(axGeographyLem185, axiom, 
 ( ! [Var_GULF] : 
 (hasType(type_Gulf, Var_GULF) => 
(( ! [Var_BAY] : 
 (hasType(type_Bay, Var_BAY) => 
(f_larger(Var_GULF,Var_BAY)))))))).

fof(axGeographyLem186, axiom, 
 ( ! [Var_WATER] : 
 (hasType(type_Estuary, Var_WATER) => 
(( ? [Var_SEA] : 
 (hasType(type_SaltWaterArea, Var_SEA) &  
(((f_part(Var_SEA,inst_WorldOcean)) & (f_connected(Var_SEA,Var_WATER)))))))))).

fof(axGeographyLem187, axiom, 
 ( ! [Var_WATER] : 
 (hasType(type_Estuary, Var_WATER) => 
(( ! [Var_ESTUARY] : 
 (hasType(type_Object, Var_ESTUARY) => 
(( ? [Var_MOUTH] : 
 (hasType(type_RiverMouth, Var_MOUTH) &  
(f_overlapsSpatially(Var_MOUTH,Var_ESTUARY))))))))))).

fof(axGeographyLem188, axiom, 
 ( ! [Var_WATER] : 
 (hasType(type_Estuary, Var_WATER) => 
(( ? [Var_TIDES] : 
 (hasType(type_TidalProcess, Var_TIDES) &  
(f_located(Var_TIDES,Var_WATER)))))))).

fof(axGeographyLem189, axiom, 
 ( ! [Var_INLET] : 
 (hasType(type_Inlet, Var_INLET) => 
(( ? [Var_LAND] : 
 (hasType(type_LandArea, Var_LAND) &  
(f_penetrates(Var_INLET,Var_LAND)))))))).

fof(axGeographyLem190, axiom, 
 ( ! [Var_INLET] : 
 (hasType(type_Inlet, Var_INLET) => 
(( ? [Var_WATER] : 
 (hasType(type_WaterArea, Var_WATER) &  
(f_connected(Var_INLET,Var_WATER)))))))).

fof(axGeographyLem191, axiom, 
 ( ! [Var_COVE] : 
 (hasType(type_Cove, Var_COVE) => 
(( ! [Var_BAY] : 
 (hasType(type_Bay, Var_BAY) => 
(f_larger(Var_BAY,Var_COVE)))))))).

fof(axGeographyLem192, axiom, 
 ( ! [Var_END2] : 
 ((hasType(type_SelfConnectedObject, Var_END2) & hasType(type_Entity, Var_END2)) => 
(( ! [Var_END1] : 
 ((hasType(type_SelfConnectedObject, Var_END1) & hasType(type_Entity, Var_END1)) => 
(( ! [Var_BETWEEN] : 
 (hasType(type_SelfConnectedObject, Var_BETWEEN) => 
(((f_connects(Var_BETWEEN,Var_END1,Var_END2)) => (Var_END1 != Var_END2)))))))))))).

fof(axGeographyLem193, axiom, 
 ( ! [Var_STRAIT] : 
 (hasType(type_Strait, Var_STRAIT) => 
(( ? [Var_BODY1] : 
 (hasType(type_BodyOfWater, Var_BODY1) &  
(( ? [Var_BODY2] : 
 (hasType(type_BodyOfWater, Var_BODY2) &  
(f_connects(Var_STRAIT,Var_BODY1,Var_BODY2))))))))))).

fof(axGeographyLem194, axiom, 
 ( ! [Var_BODY1] : 
 (hasType(type_BodyOfWater, Var_BODY1) => 
(( ! [Var_BODY2] : 
 (hasType(type_BodyOfWater, Var_BODY2) => 
(( ! [Var_STRAIT] : 
 ((hasType(type_SelfConnectedObject, Var_STRAIT) & hasType(type_Object, Var_STRAIT)) => 
(((f_connects(Var_STRAIT,Var_BODY1,Var_BODY2)) => (f_larger(Var_BODY1,Var_STRAIT))))))))))))).

fof(axGeographyLem195, axiom, 
 ( ! [Var_CHANNEL] : 
 (hasType(type_Channel, Var_CHANNEL) => 
(( ? [Var_WATER1] : 
 (hasType(type_WaterArea, Var_WATER1) &  
(( ? [Var_WATER2] : 
 (hasType(type_WaterArea, Var_WATER2) &  
(f_connects(Var_CHANNEL,Var_WATER1,Var_WATER2))))))))))).

fof(axGeographyLem196, axiom, 
 ( ! [Var_CHANNEL] : 
 (hasType(type_Channel, Var_CHANNEL) => 
(( ! [Var_BODY] : 
 (hasType(type_BodyOfWater, Var_BODY) => 
(((f_connected(Var_CHANNEL,Var_BODY)) => (f_larger(Var_BODY,Var_CHANNEL)))))))))).

fof(axGeographyLem197, axiom, 
 ( ! [Var_SYSTEM] : 
 (hasType(type_InlandWaterSystem, Var_SYSTEM) => 
(( ? [Var_BODY1] : 
 (hasType(type_BodyOfWater, Var_BODY1) &  
(( ? [Var_BODY2] : 
 (hasType(type_BodyOfWater, Var_BODY2) &  
(((Var_BODY1 != Var_BODY2) & (((f_geographicSubregion(Var_BODY1,Var_SYSTEM)) & (f_geographicSubregion(Var_BODY2,Var_SYSTEM))))))))))))))).

fof(axGeographyLem198, axiom, 
 ( ! [Var_SYSTEM] : 
 (hasType(type_InlandWaterSystem, Var_SYSTEM) => 
(( ! [Var_WATER1] : 
 (hasType(type_WaterArea, Var_WATER1) => 
(( ! [Var_WATER2] : 
 (hasType(type_WaterArea, Var_WATER2) => 
(((((Var_WATER1 != Var_WATER2) & (((( ~ (f_connected(Var_WATER1,Var_WATER2)))) & (((f_geographicSubregion(Var_WATER1,Var_SYSTEM)) & (f_geographicSubregion(Var_WATER2,Var_SYSTEM)))))))) => (( ? [Var_WATER3] : 
 (hasType(type_WaterArea, Var_WATER3) &  
(((Var_WATER3 != Var_WATER1) & (((Var_WATER3 != Var_WATER1) & (((f_part(Var_WATER3,Var_SYSTEM)) & (f_connects(Var_WATER3,Var_WATER1,Var_WATER2)))))))))))))))))))))).

fof(axGeographyLem199, axiom, 
 ( ! [Var_REGION] : 
 (hasType(type_LakeRegion, Var_REGION) => 
(( ? [Var_LAKE] : 
 (hasType(type_Lake, Var_LAKE) &  
(f_located(Var_LAKE,Var_REGION)))))))).

fof(axGeographyLem200, axiom, 
 ( ! [Var_SYSTEM] : 
 (hasType(type_RiverSystem, Var_SYSTEM) => 
(( ? [Var_RIVER] : 
 (hasType(type_River, Var_RIVER) &  
(f_part(Var_RIVER,Var_SYSTEM)))))))).

fof(axGeographyLem201, axiom, 
 ( ! [Var_SYSTEM] : 
 (hasType(type_RiverSystem, Var_SYSTEM) => 
(( ? [Var_RIVER] : 
 (hasType(type_River, Var_RIVER) &  
(( ? [Var_STATIC] : 
 (hasType(type_StaticWaterArea, Var_STATIC) &  
(((f_part(Var_RIVER,Var_SYSTEM)) & (f_connected(Var_RIVER,Var_STATIC))))))))))))).

fof(axGeographyLem202, axiom, 
 ( ! [Var_FALL] : 
 (hasType(type_Waterfall, Var_FALL) => 
(( ! [Var_CURRENT] : 
 (hasType(type_WaterMotion, Var_CURRENT) => 
(( ! [Var_TOP] : 
 (hasType(type_WaterArea, Var_TOP) => 
(( ! [Var_BOTTOM] : 
 (hasType(type_WaterArea, Var_BOTTOM) => 
(((((f_flowCurrent(Var_CURRENT,Var_FALL)) & (((f_origin(Var_CURRENT,Var_TOP)) & (f_destination(Var_CURRENT,Var_BOTTOM)))))) => (f_orientation(Var_TOP,Var_BOTTOM,inst_Above)))))))))))))))).

fof(axGeographyLem203, axiom, 
 ( ! [Var_CHANNEL] : 
 (hasType(type_Canal, Var_CHANNEL) => 
(( ? [Var_WATER1] : 
 (hasType(type_WaterArea, Var_WATER1) &  
(( ? [Var_WATER2] : 
 (hasType(type_WaterArea, Var_WATER2) &  
(f_connects(Var_CHANNEL,Var_WATER1,Var_WATER2))))))))))).

fof(axGeographyLem204, axiom, 
 ( ! [Var_DAM] : 
 (hasType(type_Dam, Var_DAM) => 
(( ! [Var_RIVER] : 
 (hasType(type_Object, Var_RIVER) => 
(( ? [Var_RIVER] : 
 (hasType(type_WaterArea, Var_RIVER) &  
(f_traverses(Var_DAM,Var_RIVER))))))))))).

fof(axGeographyLem205, axiom, 
 ( ! [Var_RAPIDS] : 
 (hasType(type_Rapids, Var_RAPIDS) => 
(( ? [Var_RIVER] : 
 (hasType(type_River, Var_RIVER) &  
(f_part(Var_RAPIDS,Var_RIVER)))))))).

fof(axGeographyLem206, axiom, 
 ( ! [Var_RAPIDS] : 
 (hasType(type_Rapids, Var_RAPIDS) => 
(( ! [Var_RAPIDS] : 
 (hasType(type_SelfConnectedObject, Var_RAPIDS) => 
(( ! [Var_BOTTOM] : 
 ((hasType(type_SelfConnectedObject, Var_BOTTOM) & hasType(type_Object, Var_BOTTOM)) => 
(((f_bottom(Var_BOTTOM,Var_RAPIDS)) => (( ? [Var_ROCK] : 
 (hasType(type_Rock, Var_ROCK) &  
(f_part(Var_ROCK,Var_BOTTOM)))))))))))))))).

fof(axGeographyLem207, axiom, 
 ( ! [Var_IRRIGATION] : 
 (hasType(type_Irrigating, Var_IRRIGATION) => 
(( ! [Var_AREA] : 
 (hasType(type_LandArea, Var_AREA) => 
(( ! [Var_AREA] : 
 (hasType(type_Entity, Var_AREA) => 
(((f_patient(Var_IRRIGATION,Var_AREA)) => (((f_holdsDuring(f_ImmediatePastFn(f_WhenFn(Var_IRRIGATION)),attribute(Var_AREA,inst_Dry))) & (f_holdsDuring(f_ImmediateFutureFn(f_WhenFn(Var_IRRIGATION)),attribute(Var_AREA,inst_Damp)))))))))))))))).

fof(axGeographyLem208, axiom, 
 ( ! [Var_IRRIGATION] : 
 (hasType(type_Irrigating, Var_IRRIGATION) => 
(( ! [Var_AREA] : 
 (hasType(type_LandArea, Var_AREA) => 
(((f_patient(Var_IRRIGATION,Var_AREA)) => (f_hasPurpose(Var_IRRIGATION,attribute(Var_AREA,inst_FertileTerrain))))))))))).

fof(axGeographyLem209, axiom, 
 ( ! [Var_LAKE] : 
 (hasType(type_Lake, Var_LAKE) => 
(( ! [Var_OCEAN] : 
 (hasType(type_Ocean, Var_OCEAN) => 
(f_smaller(Var_LAKE,Var_OCEAN)))))))).

fof(axGeographyLem210, axiom, 
 ( ! [Var_PLAIN] : 
 (hasType(type_CoastalPlain, Var_PLAIN) => 
(( ? [Var_SHORE] : 
 (hasType(type_ShoreArea, Var_SHORE) &  
(f_part(Var_SHORE,Var_PLAIN)))))))).

fof(axGeographyLem211, axiom, 
 ( ! [Var_BANK] : 
 (hasType(type_RiverBank, Var_BANK) => 
(( ? [Var_RIVER] : 
 (hasType(type_River, Var_RIVER) &  
(f_meetsSpatially(Var_RIVER,Var_BANK)))))))).

fof(axGeographyLem212, axiom, 
 ( ! [Var_DELTA] : 
 (hasType(type_Delta, Var_DELTA) => 
(( ? [Var_MOUTH] : 
 (hasType(type_RiverMouth, Var_MOUTH) &  
(f_meetsSpatially(Var_MOUTH,Var_DELTA)))))))).

fof(axGeographyLem213, axiom, 
 ( ! [Var_DELTA] : 
 (hasType(type_Delta, Var_DELTA) => 
(f_attribute(Var_DELTA,inst_FlatTerrain))))).

fof(axGeographyLem214, axiom, 
 ( ! [Var_PENINSULA] : 
 (hasType(type_Peninsula, Var_PENINSULA) => 
(( ? [Var_WATER] : 
 (hasType(type_WaterArea, Var_WATER) &  
(f_penetrates(Var_PENINSULA,Var_WATER)))))))).

fof(axGeographyLem215, axiom, 
 ( ! [Var_CAPE] : 
 (hasType(type_Cape, Var_CAPE) => 
(( ? [Var_WATERREGION] : 
 (hasType(type_WaterArea, Var_WATERREGION) &  
(f_penetrates(Var_CAPE,Var_WATERREGION)))))))).

fof(axGeographyLem216, axiom, 
 ( ! [Var_ISTHMUS] : 
 (hasType(type_Isthmus, Var_ISTHMUS) => 
(( ! [Var_RIGHTSIDE] : 
 ((hasType(type_SelfConnectedObject, Var_RIGHTSIDE) & hasType(type_Entity, Var_RIGHTSIDE) & hasType(type_Object, Var_RIGHTSIDE)) => 
(( ! [Var_LEFTSIDE] : 
 ((hasType(type_SelfConnectedObject, Var_LEFTSIDE) & hasType(type_Entity, Var_LEFTSIDE) & hasType(type_Object, Var_LEFTSIDE)) => 
(((((f_side(Var_LEFTSIDE,Var_ISTHMUS)) & (((f_side(Var_RIGHTSIDE,Var_ISTHMUS)) & (Var_LEFTSIDE != Var_RIGHTSIDE))))) => (( ? [Var_REGION1] : 
 (hasType(type_LandArea, Var_REGION1) &  
(( ? [Var_REGION2] : 
 (hasType(type_LandArea, Var_REGION2) &  
(( ? [Var_WATER1] : 
 (hasType(type_WaterArea, Var_WATER1) &  
(( ? [Var_WATER2] : 
 (hasType(type_WaterArea, Var_WATER2) &  
(((f_between(Var_REGION1,Var_ISTHMUS,Var_REGION2)) & (((f_meetsSpatially(Var_LEFTSIDE,Var_WATER1)) & (f_meetsSpatially(Var_RIGHTSIDE,Var_WATER2))))))))))))))))))))))))))))).

fof(axGeographyLem217, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_ArchipelagicArea, Var_AREA) => 
(( ? [Var_ISLANDS] : 
 (hasType(type_Archipelago, Var_ISLANDS) &  
(f_located(Var_ISLANDS,Var_AREA)))))))).

fof(axGeographyLem218, axiom, 
 ( ! [Var_REEF] : 
 (hasType(type_Reef, Var_REEF) => 
(( ? [Var_WATER] : 
 (hasType(type_WaterArea, Var_WATER) &  
(f_orientation(Var_REEF,Var_WATER,inst_Near)))))))).

fof(axGeographyLem219, axiom, 
 ( ! [Var_REEF] : 
 (hasType(type_Reef, Var_REEF) => 
(( ? [Var_STUFF] : 
 ((hasType(type_Sand, Var_STUFF) & hasType(type_Rock, Var_STUFF) & hasType(type_Coral, Var_STUFF)) &  
(f_part(Var_STUFF,Var_REEF)))))))).

fof(axGeographyLem220, axiom, 
 ( ! [Var_REEF] : 
 (hasType(type_CoralReef, Var_REEF) => 
(( ? [Var_CORAL] : 
 (hasType(type_Coral, Var_CORAL) &  
(f_part(Var_CORAL,Var_REEF)))))))).

fof(axGeographyLem221, axiom, 
 ( ! [Var_GLACIER] : 
 (hasType(type_Glacier, Var_GLACIER) => 
(( ! [Var_ICE] : 
 (hasType(type_Object, Var_ICE) => 
(( ? [Var_WATER] : 
 (hasType(type_Water, Var_WATER) &  
(((f_attribute(Var_WATER,inst_Solid)) & (f_part(Var_ICE,Var_GLACIER))))))))))))).

fof(axGeographyLem222, axiom, 
 ( ! [Var_CAVE] : 
 (hasType(type_Cave, Var_CAVE) => 
(( ? [Var_EROSION] : 
 (hasType(type_Erosion, Var_EROSION) &  
(f_result(Var_EROSION,Var_CAVE)))))))).

fof(axGeographyLem223, axiom, 
 ( ! [Var_CAVE] : 
 (hasType(type_Cave, Var_CAVE) => 
(( ? [Var_LAND] : 
 (hasType(type_CaveMatrix, Var_LAND) &  
(f_hole(Var_CAVE,Var_LAND)))))))).

fof(axGeographyLem224, axiom, 
 ( ! [Var_LAND] : 
 (hasType(type_CaveMatrix, Var_LAND) => 
(( ! [Var_CAVE] : 
 (hasType(type_Cave, Var_CAVE) => 
(((f_hole(Var_CAVE,Var_LAND)) => (Var_LAND = f_HoleSkinFn(Var_CAVE)))))))))).

fof(axGeographyLem225, axiom, 
 ( ! [Var_LAND] : 
 (hasType(type_SubmergedLandArea, Var_LAND) => 
(( ? [Var_WATER] : 
 (hasType(type_WaterArea, Var_WATER) &  
(((f_orientation(Var_LAND,Var_WATER,inst_Below)) & (((f_orientation(Var_WATER,Var_LAND,inst_On)) & (f_meetsSpatially(Var_LAND,Var_WATER)))))))))))).

fof(axGeographyLem226, axiom, 
 ( ! [Var_SHELF] : 
 (hasType(type_ContinentalShelf, Var_SHELF) => 
(( ? [Var_MARGIN] : 
 (hasType(type_ContinentalMargin, Var_MARGIN) &  
(((f_properPart(Var_SHELF,Var_MARGIN)) & (f_overlapsSpatially(Var_SHELF,Var_MARGIN)))))))))).

fof(axGeographyLem227, axiom, 
 ( ! [Var_LINE] : 
 (hasType(type_Shoreline, Var_LINE) => 
(( ? [Var_WATER] : 
 (hasType(type_WaterArea, Var_WATER) &  
(f_meetsSpatially(Var_WATER,Var_LINE)))))))).

fof(axGeographyLem228, axiom, 
 ( ! [Var_SHORE] : 
 (hasType(type_ShoreArea, Var_SHORE) => 
(( ? [Var_LINE] : 
 (hasType(type_Shoreline, Var_LINE) &  
(f_part(Var_LINE,Var_SHORE)))))))).

fof(axGeographyLem229, axiom, 
 ( ! [Var_SHORE] : 
 (hasType(type_ShoreArea, Var_SHORE) => 
(( ! [Var_WATER] : 
 (hasType(type_WaterArea, Var_WATER) => 
(((f_orientation(Var_SHORE,Var_WATER,inst_Adjacent)) => (( ? [Var_LINE] : 
 (hasType(type_Shoreline, Var_LINE) &  
(((f_part(Var_LINE,Var_SHORE)) & (f_meetsSpatially(Var_LINE,Var_WATER))))))))))))))).

fof(axGeographyLem230, axiom, 
 ( ! [Var_Y] : 
 (hasType(type_Object, Var_Y) => 
(( ! [Var_X] : 
 (hasType(type_Object, Var_X) => 
(((f_meetsSpatially(Var_X,Var_Y)) => (f_orientation(Var_X,Var_Y,inst_Adjacent)))))))))).

fof(axGeographyLem231, axiom, 
 ( ! [Var_AIR] : 
 (hasType(type_Atmosphere, Var_AIR) => 
(( ? [Var_BODY] : 
 (hasType(type_AstronomicalBody, Var_BODY) &  
(f_meetsSpatially(Var_AIR,Var_BODY)))))))).

fof(axGeographyLem232, axiom, 
 ( ! [Var_AIRSPACE] : 
 (hasType(type_AtmosphericRegion, Var_AIRSPACE) => 
(f_part(Var_AIRSPACE,inst_EarthsAtmosphere))))).

fof(axGeographyLem233, axiom, 
 ( ! [Var_AIR] : 
 (hasType(type_Air, Var_AIR) => 
(f_piece(Var_AIR,inst_EarthsAtmosphere))))).

fof(axGeographyLem234, axiom, 
 ( ! [Var_AIRSPACE] : 
 (hasType(type_AtmosphericRegion, Var_AIRSPACE) => 
(( ? [Var_AIR] : 
 (hasType(type_Air, Var_AIR) &  
(f_part(Var_AIR,Var_AIRSPACE)))))))).

fof(axGeographyLem235, axiom, 
 ( ! [Var_AIR] : 
 (hasType(type_Air, Var_AIR) => 
(( ? [Var_PART] : 
 (hasType(type_Oxygen, Var_PART) &  
(f_part(Var_PART,Var_AIR)))))))).

fof(axGeographyLem236, axiom, 
 ( ! [Var_AIR] : 
 (hasType(type_Air, Var_AIR) => 
(( ? [Var_PART] : 
 (hasType(type_Nitrogen, Var_PART) &  
(f_part(Var_PART,Var_AIR)))))))).

fof(axGeographyLem237, axiom, 
 ( ! [Var_BLOW] : 
 (hasType(type_WindFlow, Var_BLOW) => 
(f_located(Var_BLOW,inst_EarthsAtmosphere))))).

fof(axGeographyLem238, axiom, 
 ( ! [Var_R] : 
 (hasType(type_WindFlow, Var_R) => 
(( ? [Var_WIND] : 
 (hasType(type_Wind, Var_WIND) &  
(f_located(Var_WIND,Var_R)))))))).

fof(axGeographyLem239, axiom, 
 ( ! [Var_PLACE] : 
 (hasType(type_WindFlow, Var_PLACE) => 
(( ! [Var_DIRECTION] : 
 (hasType(type_DirectionalAttribute, Var_DIRECTION) => 
(( ! [Var_TIME] : 
 (hasType(type_TimeDuration, Var_TIME) => 
(( ! [Var_DIST] : 
 (hasType(type_LengthMeasure, Var_DIST) => 
(((f_surfaceWindVelocity(Var_PLACE,f_SpeedFn(Var_DIST,Var_TIME),Var_DIRECTION)) => (( ? [Var_BLOW] : 
 (hasType(type_Wind, Var_BLOW) &  
(((f_partlyLocated(Var_BLOW,Var_PLACE)) & (f_measure(Var_BLOW,f_VelocityFn(Var_DIST,Var_TIME,Var_PLACE,Var_DIRECTION)))))))))))))))))))))).

fof(axGeographyLem240, axiom, 
 ( ! [Var_PLACE] : 
 (hasType(type_Object, Var_PLACE) => 
(( ! [Var_BLOW] : 
 (hasType(type_Wind, Var_BLOW) => 
(( ! [Var_DIRECTION] : 
 (hasType(type_DirectionalAttribute, Var_DIRECTION) => 
(( ! [Var_TIME] : 
 (hasType(type_TimeDuration, Var_TIME) => 
(( ! [Var_DIST] : 
 (hasType(type_LengthMeasure, Var_DIST) => 
(((f_measure(Var_BLOW,f_VelocityFn(Var_DIST,Var_TIME,Var_PLACE,Var_DIRECTION))) => (f_surfaceWindVelocity(Var_PLACE,f_SpeedFn(Var_DIST,Var_TIME),Var_DIRECTION))))))))))))))))))).

fof(axGeographyLem241, axiom, 
 ( ! [Var_DIRECTION] : 
 (hasType(type_DirectionalAttribute, Var_DIRECTION) => 
(( ! [Var_SPEED] : 
 (hasType(type_PhysicalQuantity, Var_SPEED) => 
(( ! [Var_PLACE] : 
 (hasType(type_Object, Var_PLACE) => 
(((f_surfaceWindVelocity(Var_PLACE,Var_SPEED,Var_DIRECTION)) => (f_surfaceWindSpeed(Var_PLACE,Var_SPEED))))))))))))).

fof(axGeographyLem242, axiom, 
 ( ! [Var_ZEPHYR] : 
 (hasType(type_WindFlow, Var_ZEPHYR) => 
(( ! [Var_PLACE] : 
 (hasType(type_Object, Var_PLACE) => 
(( ! [Var_TIME] : 
 (hasType(type_TimeDuration, Var_TIME) => 
(( ! [Var_DIST] : 
 (hasType(type_LengthMeasure, Var_DIST) => 
(((((f_partlyLocated(Var_ZEPHYR,Var_PLACE)) & (f_measure(Var_ZEPHYR,f_SpeedFn(Var_DIST,Var_TIME))))) => (f_surfaceWindSpeed(Var_PLACE,f_SpeedFn(Var_DIST,Var_TIME))))))))))))))))).

fof(axGeographyLem243, axiom, 
 ( ! [Var_ZEPHYR] : 
 (hasType(type_WindFlow, Var_ZEPHYR) => 
(( ! [Var_PLACE] : 
 (hasType(type_Object, Var_PLACE) => 
(( ! [Var_SPEED] : 
 (hasType(type_RealNumber, Var_SPEED) => 
(((((f_partlyLocated(Var_ZEPHYR,Var_PLACE)) & (f_measure(Var_ZEPHYR,f_MeasureFn(Var_SPEED,inst_KnotUnitOfSpeed))))) => (f_surfaceWindSpeed(Var_PLACE,f_MeasureFn(Var_SPEED,inst_KnotUnitOfSpeed)))))))))))))).

fof(axGeographyLem244, axiom, 
 ( ! [Var_DIR] : 
 ((hasType(type_DirectionalAttribute, Var_DIR) & hasType(type_PositionalAttribute, Var_DIR)) => 
(( ! [Var_PLACE] : 
 (hasType(type_Object, Var_PLACE) => 
(((f_surfaceWindDirection(Var_PLACE,Var_DIR)) => (( ? [Var_WIND] : 
 (hasType(type_Wind, Var_WIND) &  
(( ? [Var_FROM] : 
 (hasType(type_Region, Var_FROM) &  
(((f_partlyLocated(Var_WIND,Var_PLACE)) & (((f_origin(Var_WIND,Var_FROM)) & (f_orientation(Var_FROM,Var_PLACE,Var_DIR)))))))))))))))))))).

fof(axGeographyLem245, axiom, 
 ( ! [Var_DIR_FROM] : 
 ((hasType(type_PositionalAttribute, Var_DIR_FROM) & hasType(type_DirectionalAttribute, Var_DIR_FROM)) => 
(( ! [Var_DIR_TOWARD] : 
 ((hasType(type_DirectionalAttribute, Var_DIR_TOWARD) & hasType(type_PositionalAttribute, Var_DIR_TOWARD)) => 
(( ! [Var_SPEED] : 
 (hasType(type_PhysicalQuantity, Var_SPEED) => 
(( ! [Var_PLACE] : 
 (hasType(type_Object, Var_PLACE) => 
(((((f_surfaceWindVelocity(Var_PLACE,Var_SPEED,Var_DIR_TOWARD)) & (f_oppositeDirection(Var_DIR_TOWARD,Var_DIR_FROM)))) => (f_surfaceWindDirection(Var_PLACE,Var_DIR_FROM)))))))))))))))).

fof(axGeographyLem246, axiom, 
 ( ! [Var_ZEPHYR] : 
 (hasType(type_WindFlow, Var_ZEPHYR) => 
(( ! [Var_DIR_FROM] : 
 ((hasType(type_PositionalAttribute, Var_DIR_FROM) & hasType(type_DirectionalAttribute, Var_DIR_FROM)) => 
(( ! [Var_DIR_TOWARD] : 
 ((hasType(type_DirectionalAttribute, Var_DIR_TOWARD) & hasType(type_PositionalAttribute, Var_DIR_TOWARD)) => 
(( ! [Var_PLACE] : 
 ((hasType(type_Region, Var_PLACE) & hasType(type_Object, Var_PLACE)) => 
(( ! [Var_TIME] : 
 (hasType(type_TimeDuration, Var_TIME) => 
(( ! [Var_DIST] : 
 (hasType(type_LengthMeasure, Var_DIST) => 
(((((f_measure(Var_ZEPHYR,f_VelocityFn(Var_DIST,Var_TIME,Var_PLACE,Var_DIR_TOWARD))) & (f_oppositeDirection(Var_DIR_TOWARD,Var_DIR_FROM)))) => (f_surfaceWindDirection(Var_PLACE,Var_DIR_FROM)))))))))))))))))))))).

fof(axGeographyLem247, axiom, 
 ( ! [Var_DIRECTION] : 
 (hasType(type_DirectionalAttribute, Var_DIRECTION) => 
(( ! [Var_SPEED] : 
 (hasType(type_PhysicalQuantity, Var_SPEED) => 
(( ! [Var_PLACE] : 
 (hasType(type_Object, Var_PLACE) => 
(((f_lowAltitudeWindVelocity(Var_PLACE,Var_SPEED,Var_DIRECTION)) => (f_lowAltitudeWindSpeed(Var_PLACE,Var_SPEED))))))))))))).

fof(axGeographyLem248, axiom, 
 ( ! [Var_DIRECTION] : 
 (hasType(type_DirectionalAttribute, Var_DIRECTION) => 
(( ! [Var_SPEED] : 
 ((hasType(type_PhysicalQuantity, Var_SPEED) & hasType(type_ConstantQuantity, Var_SPEED)) => 
(( ! [Var_PLACE] : 
 (hasType(type_Object, Var_PLACE) => 
(((f_mediumAltitudeWindVelocity(Var_PLACE,Var_SPEED,Var_DIRECTION)) => (f_mediumAltitudeWindSpeed(Var_PLACE,Var_SPEED))))))))))))).

fof(axGeographyLem249, axiom, 
 ( ! [Var_DIRECTION] : 
 (hasType(type_DirectionalAttribute, Var_DIRECTION) => 
(( ! [Var_SPEED] : 
 ((hasType(type_PhysicalQuantity, Var_SPEED) & hasType(type_ConstantQuantity, Var_SPEED)) => 
(( ! [Var_PLACE] : 
 (hasType(type_Object, Var_PLACE) => 
(((f_highAltitudeWindVelocity(Var_PLACE,Var_SPEED,Var_DIRECTION)) => (f_highAltitudeWindSpeed(Var_PLACE,Var_SPEED))))))))))))).

fof(axGeographyLem250, axiom, 
 ( ! [Var_SYSTEM] : 
 (hasType(type_LowPressureWeatherSystem, Var_SYSTEM) => 
(( ! [Var_AMOUNT] : 
 ((hasType(type_RealNumber, Var_AMOUNT) & hasType(type_Quantity, Var_AMOUNT)) => 
(( ! [Var_AREA] : 
 (hasType(type_Object, Var_AREA) => 
(((f_located(Var_SYSTEM,Var_AREA)) => (((f_barometricPressure(Var_AREA,f_MeasureFn(Var_AMOUNT,inst_InchMercury))) & (f_lessThan(Var_AMOUNT,29.5))))))))))))))).

fof(axGeographyLem251, axiom, 
 ( ! [Var_STORM] : 
 (hasType(type_TropicalCyclone, Var_STORM) => 
(( ? [Var_PLACE] : 
 (hasType(type_GeographicArea, Var_PLACE) &  
(((f_geographicSubregion(Var_PLACE,inst_Tropics)) & (f_located(Var_STORM,Var_PLACE)))))))))).

fof(axGeographyLem252, axiom, 
 ( ! [Var_SYSTEM] : 
 (hasType(type_HighPressureWeatherSystem, Var_SYSTEM) => 
(( ! [Var_AMOUNT] : 
 ((hasType(type_RealNumber, Var_AMOUNT) & hasType(type_Quantity, Var_AMOUNT)) => 
(( ! [Var_AREA] : 
 (hasType(type_Object, Var_AREA) => 
(((f_located(Var_SYSTEM,Var_AREA)) => (((f_barometricPressure(Var_AREA,f_MeasureFn(Var_AMOUNT,inst_InchMercury))) & (f_greaterThan(Var_AMOUNT,30.2))))))))))))))).

fof(axGeographyLem253, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(( ! [Var_WEATHER] : 
 (hasType(type_ClearWeather, Var_WEATHER) => 
(((f_located(Var_WEATHER,Var_AREA)) => (( ? [Var_FRACTION] : 
 ((hasType(type_NonnegativeRealNumber, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) &  
(((f_cloudCoverFraction(Var_AREA,Var_FRACTION)) & (f_lessThan(Var_FRACTION,0.3))))))))))))))).

fof(axGeographyLem254, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(( ! [Var_WEATHER] : 
 (hasType(type_ClearWeather, Var_WEATHER) => 
(( ! [Var_FRACTION] : 
 ((hasType(type_NonnegativeRealNumber, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) => 
(((((f_located(Var_WEATHER,Var_AREA)) & (f_cloudCoverFraction(Var_AREA,Var_FRACTION)))) => (f_lessThan(Var_FRACTION,0.3))))))))))))).

fof(axGeographyLem255, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(( ! [Var_WEATHER] : 
 (hasType(type_PartlyCloudyWeather, Var_WEATHER) => 
(((f_located(Var_WEATHER,Var_AREA)) => (( ? [Var_FRACTION] : 
 ((hasType(type_NonnegativeRealNumber, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) &  
(((f_cloudCoverFraction(Var_AREA,Var_FRACTION)) & (((f_greaterThanOrEqualTo(Var_FRACTION,0.3)) & (f_lessThanOrEqualTo(Var_FRACTION,0.7))))))))))))))))).

fof(axGeographyLem256, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(( ! [Var_WEATHER] : 
 (hasType(type_PartlyCloudyWeather, Var_WEATHER) => 
(( ! [Var_FRACTION] : 
 ((hasType(type_NonnegativeRealNumber, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) => 
(((((f_located(Var_WEATHER,Var_AREA)) & (f_cloudCoverFraction(Var_AREA,Var_FRACTION)))) => (((f_greaterThanOrEqualTo(Var_FRACTION,0.3)) & (f_lessThanOrEqualTo(Var_FRACTION,0.7))))))))))))))).

fof(axGeographyLem257, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(( ! [Var_WEATHER] : 
 (hasType(type_OvercastWeather, Var_WEATHER) => 
(((f_located(Var_WEATHER,Var_AREA)) => (( ? [Var_FRACTION] : 
 ((hasType(type_NonnegativeRealNumber, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) &  
(((f_cloudCoverFraction(Var_AREA,Var_FRACTION)) & (f_greaterThan(Var_FRACTION,0.7))))))))))))))).

fof(axGeographyLem258, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(( ! [Var_WEATHER] : 
 (hasType(type_OvercastWeather, Var_WEATHER) => 
(( ! [Var_FRACTION] : 
 ((hasType(type_NonnegativeRealNumber, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) => 
(((((f_located(Var_WEATHER,Var_AREA)) & (f_cloudCoverFraction(Var_AREA,Var_FRACTION)))) => (f_greaterThan(Var_FRACTION,0.7))))))))))))).

fof(axGeographyLem259, axiom, 
 ( ! [Var_PLACE] : 
 (hasType(type_Object, Var_PLACE) => 
(((f_relativeHumidity(Var_PLACE,1)) => (( ? [Var_FALLING] : 
 (hasType(type_Precipitation, Var_FALLING) &  
(f_located(Var_FALLING,Var_PLACE)))))))))).

fof(axGeographyLem260, axiom, 
 ( ! [Var_PROCESS] : 
 (hasType(type_Raining, Var_PROCESS) => 
(f_precipitationState(Var_PROCESS,inst_Liquid))))).

fof(axGeographyLem261, axiom, 
 ( ! [Var_PROCESS] : 
 (hasType(type_FreezingRain, Var_PROCESS) => 
(f_precipitationState(Var_PROCESS,inst_Liquid))))).

fof(axGeographyLem262, axiom, 
 ( ! [Var_PROCESS] : 
 (hasType(type_FreezingRain, Var_PROCESS) => 
(( ! [Var_STUFF] : 
 (hasType(type_Water, Var_STUFF) => 
(((f_patient(Var_PROCESS,Var_STUFF)) => (f_holdsDuring(f_ImmediateFutureFn(f_WhenFn(Var_PROCESS)),attribute(Var_STUFF,inst_Solid))))))))))).

fof(axGeographyLem263, axiom, 
 ( ! [Var_PROCESS] : 
 (hasType(type_Snowing, Var_PROCESS) => 
(f_precipitationState(Var_PROCESS,inst_Solid))))).

fof(axGeographyLem264, axiom, 
 ( ! [Var_PROCESS] : 
 (hasType(type_Sleeting, Var_PROCESS) => 
(f_precipitationState(Var_PROCESS,inst_Solid))))).

fof(axGeographyLem265, axiom, 
 ( ! [Var_PROCESS] : 
 (hasType(type_Hailing, Var_PROCESS) => 
(f_precipitationState(Var_PROCESS,inst_Solid))))).

fof(axGeographyLem266, axiom, 
 ( ! [Var_STATE] : 
 ((hasType(type_PhysicalState, Var_STATE) & hasType(type_Attribute, Var_STATE)) => 
(( ! [Var_EVENT] : 
 ((hasType(type_WeatherProcess, Var_EVENT) & hasType(type_Process, Var_EVENT)) => 
(((f_precipitationState(Var_EVENT,Var_STATE)) => (( ? [Var_STUFF] : 
 (hasType(type_Water, Var_STUFF) &  
(((f_patient(Var_EVENT,Var_STUFF)) & (f_attribute(Var_STUFF,Var_STATE))))))))))))))).

fof(axGeographyLem267, axiom, 
 ( ! [Var_TREE] : 
 (hasType(type_BotanicalTree, Var_TREE) => 
(( ! [Var_BUSH] : 
 (hasType(type_Shrub, Var_BUSH) => 
(( ! [Var_SHORT] : 
 ((hasType(type_LengthMeasure, Var_SHORT) & hasType(type_Quantity, Var_SHORT)) => 
(( ! [Var_TALL] : 
 ((hasType(type_LengthMeasure, Var_TALL) & hasType(type_Quantity, Var_TALL)) => 
(((((f_height(Var_TREE,Var_TALL)) & (f_height(Var_BUSH,Var_SHORT)))) => (f_greaterThan(Var_TALL,Var_SHORT)))))))))))))))).

fof(axGeographyLem268, axiom, 
 ( ! [Var_LICH] : 
 (hasType(type_Lichen, Var_LICH) => 
(( ? [Var_ALGA] : 
 (hasType(type_Alga, Var_ALGA) &  
(f_part(Var_ALGA,Var_LICH)))))))).

fof(axGeographyLem269, axiom, 
 ( ! [Var_LICH] : 
 (hasType(type_Lichen, Var_LICH) => 
(( ? [Var_FUNG] : 
 (hasType(type_Fungus, Var_FUNG) &  
(f_part(Var_FUNG,Var_LICH)))))))).

fof(axGeographyLem270, axiom, 
 ( ! [Var_FOREST] : 
 (hasType(type_Forest, Var_FOREST) => 
(f_vegetationTypePattern(Var_FOREST,type_BotanicalTree,inst_DenseVegetation))))).

fof(axGeographyLem271, axiom, 
 ( ! [Var_FOREST] : 
 (hasType(type_RainForest, Var_FOREST) => 
(f_vegetationTypePattern(Var_FOREST,type_BotanicalTree,inst_CanopiedVegetation))))).

fof(axGeographyLem272, axiom, 
 ( ! [Var_FOREST] : 
 (hasType(type_BorealForest, Var_FOREST) => 
(f_vegetationType(Var_FOREST,type_PineTree))))).

fof(axGeographyLem273, axiom, 
 ( ! [Var_FOREST] : 
 (hasType(type_Jungle, Var_FOREST) => 
(f_vegetationTypePattern(Var_FOREST,type_Plant,inst_DenseVegetation))))).

fof(axGeographyLem274, axiom, 
 ( ! [Var_DESERT] : 
 (hasType(type_Desert, Var_DESERT) => 
(f_attribute(Var_DESERT,inst_Dry))))).

fof(axGeographyLem275, axiom, 
 ( ! [Var_DESERT] : 
 (hasType(type_Desert, Var_DESERT) => 
(((f_groundSurfaceType(Var_DESERT,type_Rock)) | (f_groundSurfaceType(Var_DESERT,type_Sand))))))).

fof(axGeographyLem276, axiom, 
 ( ! [Var_DESERT] : 
 (hasType(type_Desert, Var_DESERT) => 
(( ~ (f_vegetationType(Var_DESERT,type_BotanicalTree))))))).

fof(axGeographyLem277, axiom, 
 ( ! [Var_OASIS] : 
 (hasType(type_Oasis, Var_OASIS) => 
(( ? [Var_DESERT] : 
 (hasType(type_Desert, Var_DESERT) &  
(f_located(Var_OASIS,Var_DESERT)))))))).

fof(axGeographyLem278, axiom, 
 ( ! [Var_OASIS] : 
 (hasType(type_Oasis, Var_OASIS) => 
(( ? [Var_WATER] : 
 (hasType(type_FreshWaterArea, Var_WATER) &  
(f_located(Var_WATER,Var_OASIS)))))))).

fof(axGeographyLem279, axiom, 
 ( ! [Var_OASIS] : 
 (hasType(type_Oasis, Var_OASIS) => 
(f_attribute(Var_OASIS,inst_FertileTerrain))))).

fof(axGeographyLem280, axiom, 
 ( ! [Var_PLAIN] : 
 (hasType(type_Grassland, Var_PLAIN) => 
(f_vegetationTypePattern(Var_PLAIN,type_Grass,inst_GroundCoverVegetation))))).

fof(axGeographyLem281, axiom, 
 ( ! [Var_PLAIN] : 
 (hasType(type_Pampa, Var_PLAIN) => 
(f_located(Var_PLAIN,inst_SouthAmerica))))).

fof(axGeographyLem282, axiom, 
 ( ! [Var_PLAIN] : 
 (hasType(type_Savanna, Var_PLAIN) => 
(( ~ (f_vegetationType(Var_PLAIN,type_BotanicalTree))))))).

fof(axGeographyLem283, axiom, 
 ( ! [Var_PLAIN] : 
 (hasType(type_Steppe, Var_PLAIN) => 
(( ~ (f_vegetationType(Var_PLAIN,type_BotanicalTree))))))).

fof(axGeographyLem284, axiom, 
 ( ! [Var_PLAIN] : 
 (hasType(type_Steppe, Var_PLAIN) => 
(((f_located(Var_PLAIN,inst_Europe)) | (f_located(Var_PLAIN,inst_Asia))))))).

fof(axGeographyLem285, axiom, 
 ( ! [Var_PLAIN] : 
 (hasType(type_Veldt, Var_PLAIN) => 
(f_located(Var_PLAIN,inst_Africa))))).

fof(axGeographyLem286, axiom, 
 ( ! [Var_PLAIN] : 
 (hasType(type_Veldt, Var_PLAIN) => 
(f_vegetationTypePattern(Var_PLAIN,type_Shrub,inst_ScatteredVegetation))))).

fof(axGeographyLem287, axiom, 
 ( ! [Var_PLAIN] : 
 (hasType(type_Tundra, Var_PLAIN) => 
(f_vegetationType(Var_PLAIN,type_Lichen))))).

fof(axGeographyLem288, axiom, 
 ( ! [Var_PLAIN] : 
 (hasType(type_Tundra, Var_PLAIN) => 
(f_vegetationType(Var_PLAIN,type_Moss))))).

fof(axGeographyLem289, axiom, 
 ( ! [Var_AGRO] : 
 (hasType(type_Agriculture, Var_AGRO) => 
(( ? [Var_GROWTH] : 
 (hasType(type_Growth, Var_GROWTH) &  
(f_subProcess(Var_GROWTH,Var_AGRO)))))))).

fof(axGeographyLem290, axiom, 
 ( ! [Var_SINKING] : 
 (hasType(type_LandSubsidence, Var_SINKING) => 
(( ? [Var_LAND] : 
 (hasType(type_LandArea, Var_LAND) &  
(((f_exactlyLocated(Var_SINKING,Var_LAND)) & (f_patient(Var_SINKING,Var_LAND)))))))))).

