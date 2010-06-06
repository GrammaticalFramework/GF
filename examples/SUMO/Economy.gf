-- # -path=.:englishExtended
abstract Economy = MidLevelOntology, Transportation, Geography ** {

  --  AdvancedDevelopingCountry 
  -- is an Attribute used to describe a LessDevelopedCountry (LDC) 
  -- that is undergoing rapid industrial development. Also called 'newly 
  -- industrializing economy' (or 'country').
  fun AdvancedDevelopingCountry : Ind EconomicDevelopmentLevel ;

  -- AdvancedEconomy is an Attribute 
  -- used to represent the InternationalMonetaryFund's top category of 
  -- development levels (AdvancedEconomy,, countries in transition, and 
  -- developing countries. Generally (but not exactly) corresponds with 
  -- DevelopedCountry classification used by UnitedNations agencies.
  fun AdvancedEconomy : Ind IMFDevelopmentLevel ;

  fun AfghanAfghani : Ind UnitOfCurrency ;

  fun AfghanAfghaniCoin : Class ;
  fun AfghanAfghaniCoin_Class : SubClass AfghanAfghaniCoin CurrencyCoin ;

  fun AgriculturalSector : Ind IndustryAttribute ;

  fun AgricultureBasedEconomy : Ind FinancialSectorAttribute ;

  -- (AgricultureFn ?PRODUCT) denotes the 
  -- subclass of Agriculture processes in which the AgriculturalProduct 
  -- ?PRODUCT is cultivated.
  fun AgricultureFn: Desc AgriculturalProduct -> Desc Agriculture ;

  fun AgricultureForestryFishingAndHunting : Ind IndustryAttribute ;

  fun AlbanianLek : Ind UnitOfCurrency ;

  fun Alfalfa : Class ;
  fun Alfalfa_Class : SubClass Alfalfa (both Fodder (both Plant PlantAgriculturalProduct)) ;

  fun AlgerianDinar : Ind UnitOfCurrency ;

  fun AlmondNut : Class ;
  fun AlmondNut_Class : SubClass AlmondNut EdibleNut ;

  -- Aloes is the class of 
  -- PlantAgriculturalProducts that are dried juice of 
  -- the Aloe plant.
  fun Aloes : Class ;
  fun Aloes_Class : SubClass Aloes PlantAgriculturalProduct ;

  -- Alumina is the naturally occurring oxide 
  -- of aluminum which is found in corundum and bauxite.
  fun Alumina : Class ;
  fun Alumina_Class : SubClass Alumina CompoundSubstance ;

  fun AluminumMetal : Class ;
  fun AluminumMetal_Class : SubClass AluminumMetal MetalProduct ;

  fun AngolanKwanza : Ind UnitOfCurrency ;

  -- AnimalSkin is the subclass of BodyCovering that 
  -- includes the skins, or parts of skins, of animals.
  fun AnimalSkin : Class ;
  fun AnimalSkin_Class : SubClass AnimalSkin BodyCovering ;

  -- A FruitOrVegetable that has a tart to sweet taste and a spherical shape.
  fun Apple : Class ;
  fun Apple_Class : SubClass Apple (both (both Food Fruit) GroceryProduce) ;

  fun ArgentineAustral : Ind UnitOfCurrency ;

  fun ArmenianDram : Ind UnitOfCurrency ;

  -- Asphalt is a highly viscous liquid that occurs 
  -- naturally in most crude petroleums. Asphalt can be separated from the 
  -- other components in crude oil (such as naphtha, gasoline and diesel) by 
  -- the process of fractional distillation, usually under vacuum conditions. 
  -- Both tars and asphalts are classified as bitumens, a classification that 
  -- includes all materials entirely soluble in carbon disulphide. Asphalt is 
  -- commonly used in roofing shingles, and combined with mineral aggregate to 
  -- make asphalt concrete for making roads. (definition from Wikipedia)
  fun Asphalt : Class ;
  fun Asphalt_Class : SubClass Asphalt RefinedPetroleumProduct ;

  fun AsphaltPavingRoofingAndSaturatedMaterialsManufacturing : Ind IndustryAttribute ;

  fun AustralianDollar : Ind UnitOfCurrency ;

  fun AustrianSchilling : Ind UnitOfCurrency ;

  -- A TropicalFruit that is shaped like a pear and has a dark green skin and a rich meat.
  fun Avocado : Class ;
  fun Avocado_Class : SubClass Avocado (both Food TropicalFruit) ;

  fun AzerbaijaniManat : Ind UnitOfCurrency ;

  fun BahamianDollar : Ind UnitOfCurrency ;

  fun BahrainianDinar : Ind UnitOfCurrency ;

  fun BalsaWood : Class ;
  fun BalsaWood_Class : SubClass BalsaWood WoodProduct ;

  fun Banana : Class ;
  fun Banana_Class : SubClass Banana (both GroceryProduce TropicalFruit) ;

  fun BangladeshiTaka : Ind UnitOfCurrency ;

  fun BarbadosDollar : Ind UnitOfCurrency ;

  fun BarleyFarming : Ind IndustryAttribute ;

  fun BarleyGrain : Class ;
  fun BarleyGrain_Class : SubClass BarleyGrain CerealGrain ;

  -- Bauxite is an impure mixture of earthy 
  -- hydrous aluminum oxides and hydroxides that is the principal 
  -- source of aluminum.
  fun Bauxite : Class ;
  fun Bauxite_Class : SubClass Bauxite (both MiningProduct Mixture) ;

  fun Bean : Class ;
  fun Bean_Class : SubClass Bean Legume ;

  fun BelarusianRubel : Ind UnitOfCurrency ;

  fun BelgianFranc : Ind UnitOfCurrency ;

  fun BelizeDollar : Ind UnitOfCurrency ;

  fun BeninFranc : Ind UnitOfCurrency ;

  fun BermudaDollar : Ind UnitOfCurrency ;

  fun Berry : Class ;
  fun Berry_Class : SubClass Berry (both Fruit GroceryProduce) ;

  -- BeverageProduct is the class of products 
  -- that are Beverages, packaged or unpackaged.
  fun BeverageProduct : Class ;
  fun BeverageProduct_Class : SubClass BeverageProduct Product ;

  fun BhutaneseNgultrum : Ind UnitOfCurrency ;

  fun BlackPepper : Class ;
  fun BlackPepper_Class : SubClass BlackPepper Spice ;

  fun BolivianBoliviano : Ind UnitOfCurrency ;

  fun BotswanaPula : Ind UnitOfCurrency ;

  fun BrazilianReal : Ind UnitOfCurrency ;

  fun Breadfruit : Class ;
  fun Breadfruit_Class : SubClass Breadfruit (both GroceryProduce TropicalFruit) ;

  fun BritishPound : Ind UnitOfCurrency ;

  fun BritishPoundCoin : Class ;
  fun BritishPoundCoin_Class : SubClass BritishPoundCoin CurrencyCoin ;

  fun BruneiDollar : Ind UnitOfCurrency ;

  fun BulgarianLev : Ind UnitOfCurrency ;

  fun BurkinaFasoFranc : Ind UnitOfCurrency ;

  fun BurundiFranc : Ind UnitOfCurrency ;

  fun Cabbage : Class ;
  fun Cabbage_Class : SubClass Cabbage (both GroceryProduce Vegetable) ;

  fun CambodianRiel : Ind UnitOfCurrency ;

  fun Camel : Class ;
  fun Camel_Class : SubClass Camel (both Livestock Mammal) ;

  fun CameroonFranc : Ind UnitOfCurrency ;

  fun CanadianDollar : Ind UnitOfCurrency ;

  fun CanadianDollarCoin : Class ;
  fun CanadianDollarCoin_Class : SubClass CanadianDollarCoin CurrencyCoin ;

  fun Cannabis : Class ;
  fun Cannabis_Class : SubClass Cannabis PlantAgriculturalProduct ;

  fun CapeVerdeEscudo : Ind UnitOfCurrency ;

  -- CapitalGoods are those that are used 
  -- in the production of other Products. For example, raw materials 
  -- from which end products are manufactured, or machines and other 
  -- structures used in the production process.
  fun CapitalGood : Class ;
  fun CapitalGood_Class : SubClass CapitalGood Product ;

  -- CapitalistEconomy is the 
  -- Attribute used to characterize a country whose economy is based 
  -- on private ownership of the means of production and distribution, 
  -- and on private accumulation of capital.
  fun CapitalistEconomy : Ind EconomicSystemAttribute ;

  fun Cardamom : Class ;
  fun Cardamom_Class : SubClass Cardamom Spice ;

  fun Carrot : Class ;
  fun Carrot_Class : SubClass Carrot (both GroceryProduce RootVegetable) ;

  fun CashewNut : Class ;
  fun CashewNut_Class : SubClass CashewNut EdibleNut ;

  fun Cassava : Class ;
  fun Cassava_Class : SubClass Cassava (both GroceryProduce RootVegetable) ;

  fun Cattle : Class ;
  fun Cattle_Class : SubClass Cattle (both HoofedMammal Livestock) ;

  fun Cauliflower : Class ;
  fun Cauliflower_Class : SubClass Cauliflower (both GroceryProduce Vegetable) ;

  fun Caviar : Class ;
  fun Caviar_Class : SubClass Caviar FishRoe ;

  fun CaymanIslandsDollar : Ind UnitOfCurrency ;

  -- Cement is a subclass of CompoundSubstance 
  -- whose instances may contain various minerals or ores, prepared by 
  -- heating and pulverizing, and used in binding Concrete or in laying 
  -- brick or stone.
  fun Cement : Class ;
  fun Cement_Class : SubClass Cement (both CompoundSubstance ManufacturedProduct) ;

  fun CentralAfricanRepublicFranc : Ind UnitOfCurrency ;

  -- CentrallyPlannedEconomy 
  -- is a term used mainly to describe communist or formerly communist 
  -- states, many of which are now evolving away from command economies 
  -- towards market_oriented systems. Also known as a 'command economy'.
  fun CentrallyPlannedEconomy : Ind EconomicSystemAttribute ;

  fun CerealGrainFarming : Ind IndustryAttribute ;

  fun CerealGrain_Vegetable : SubClass CerealGrain Vegetable ;

  fun CerealGrass : Class ;
  fun CerealGrass_Class : SubClass CerealGrass Grass ;

  fun ChadianFranc : Ind UnitOfCurrency ;

  fun Cheese : Class ;
  fun Cheese_Class : SubClass Cheese (both DairyProduct PreparedFood) ;

  -- ChemicalProduct is the subclass 
  -- of Product comprising all chemical compounds that are end products 
  -- or industrial products used in the manufacture of end products.
  fun ChemicalProduct : Class ;
  fun ChemicalProduct_Class : SubClass ChemicalProduct (both CompoundSubstance ManufacturedProduct) ;

  fun ChileanPeso : Ind UnitOfCurrency ;

  fun ChineseYuan : Ind UnitOfCurrency ;

  fun Chrysanthemum : Class ;
  fun Chrysanthemum_Class : SubClass Chrysanthemum (both FloweringPlant PlantAgriculturalProduct) ;

  fun Cinnamon : Class ;
  fun Cinnamon_Class : SubClass Cinnamon Spice ;

  fun CitrusFruit : Class ;
  fun CitrusFruit_Class : SubClass CitrusFruit (both Fruit GroceryProduce) ;

  fun ClothesDryer : Class ;
  fun ClothesDryer_Class : SubClass ClothesDryer MajorAppliance ;

  fun ClothesWashingMachine : Class ;
  fun ClothesWashingMachine_Class : SubClass ClothesWashingMachine MajorAppliance ;

  fun Clove : Class ;
  fun Clove_Class : SubClass Clove Spice ;

  fun Clover : Class ;
  fun Clover_Class : SubClass Clover (both Fodder (both Plant PlantAgriculturalProduct)) ;

  fun CoalIndustry : Ind IndustryAttribute ;

  fun CoalMining : Ind IndustryAttribute ;

  fun CoalProductsManufacturing : Ind IndustryAttribute ;

  -- Coca is the class of PlantAgriculturalProducts consisting of the parts, 
  -- especially leaves, of the coca plant. Coca leaves are the source of Cocaine.
  fun Coca : Class ;
  fun Coca_Class : SubClass Coca PlantAgriculturalProduct ;

  fun Cocaine : Class ;
  fun Cocaine_Class : SubClass Cocaine (both Narcotic PlantAgriculturalProduct) ;

  -- Cocoa is the class of powdered 
  -- PlantAgriculturalProduct derived from cacao beans.
  fun Cocoa : Class ;
  fun Cocoa_Class : SubClass Cocoa (both FruitOrVegetable PlantAgriculturalProduct) ;

  fun CocoaBean : Class ;
  fun CocoaBean_Class : SubClass CocoaBean (both FruitOrVegetable PlantAgriculturalProduct) ;

  -- A FruitOrVegetable that is produced by a type of palm 
  -- and has an edible white meat.
  fun Coconut : Class ;
  fun Coconut_Class : SubClass Coconut (both Food TropicalFruit) ;

  fun CoffeeBean : Class ;
  fun CoffeeBean_Class : SubClass CoffeeBean (both FruitOrVegetable PlantAgriculturalProduct) ;

  fun ColombianPeso : Ind UnitOfCurrency ;

  fun CommercialAndIndustrialRefrigerationAndEquipmentManufacturing : Ind IndustryAttribute ;

  fun CommunalLandOwnershipEconomy : Ind EconomicSystemAttribute ;

  -- Concrete is a class of CompoundSubstances 
  -- used as building materials. Concrete is made up of Mineral pieces 
  -- (sand or gravel) and a Cement material used to bind them together.
  fun Concrete : Class ;
  fun Concrete_Class : SubClass Concrete (both ManufacturedProduct Mixture) ;

  fun CongoFranc : Ind UnitOfCurrency ;

  fun ConsumerGood : Class ;
  fun ConsumerGood_Class : SubClass ConsumerGood ManufacturedProduct ;

  fun ConsumerGoodsIndustry : Ind IndustryAttribute ;

  fun ControlledLaborMarketEconomy : Ind FinancialSectorAttribute ;

  -- ControlledSubstance is 
  -- the subclass of BiologicallyActiveSubstances whose distribution 
  -- and use is controlled by government regulation.
  fun ControlledSubstance : Class ;
  fun ControlledSubstance_Class : SubClass ControlledSubstance BiologicallyActiveSubstance ;

  fun CookingOven : Class ;
  fun CookingOven_Class : SubClass CookingOven MajorAppliance ;

  fun CookingRange : Class ;
  fun CookingRange_Class : SubClass CookingRange MajorAppliance ;

  fun CopperFoundriesExceptDieCasting : Ind IndustryAttribute ;

  fun CopperIndustry : Ind IndustryAttribute ;

  fun CopperOre : Class ;
  fun CopperOre_Class : SubClass CopperOre (both Mineral MiningProduct) ;

  fun CopperOreMining : Ind IndustryAttribute ;

  fun CopperRollingDrawingExtrudingAndAlloying : Ind IndustryAttribute ;

  -- Copra is the class of dried coconut 
  -- meat valued for the extracted coconut oil.
  fun Copra : Class ;
  fun Copra_Class : SubClass Copra PlantAgriculturalProduct ;

  fun CornFarming : Ind IndustryAttribute ;

  fun CostaRicanColon : Ind UnitOfCurrency ;

  fun CottonFiber : Class ;
  fun CottonFiber_Class : SubClass CottonFiber PlantAgriculturalProduct ;

  -- CountryInTransition is a term 
  -- used by the InternationalMonetaryFund (IMF) to describe the middle 
  -- group in its hierarchy of advanced countries, countries in transition, 
  -- and developing countries. Most of the countries with this attribute 
  -- are former USSR or Eastern European countries. Generally corresponds 
  -- with FormerSovietOrEasternEuropeanCountry classification used by 
  -- UnitedNations agencies.
  fun CountryInTransition : Ind IMFDevelopmentLevel ;

  fun CowPea : Class ;
  fun CowPea_Class : SubClass CowPea Legume ;

  fun Crayfish : Class ;
  fun Crayfish_Class : SubClass Crayfish Shellfish ;

  fun CrudePetroleumExtraction : Ind IndustryAttribute ;

  fun CubanPeso : Ind UnitOfCurrency ;

  fun Cucumber : Class ;
  fun Cucumber_Class : SubClass Cucumber (both GroceryProduce Vegetable) ;

  fun CutFlower : Class ;
  fun CutFlower_Class : SubClass CutFlower PlantAgriculturalProduct ;

  fun CypriotPound : Ind UnitOfCurrency ;

  fun CzechKoruna : Ind UnitOfCurrency ;

  fun DanishKrone : Ind UnitOfCurrency ;

  -- A FruitOrVegetable that is produced by the date palm.
  fun DateFruit : Class ;
  fun DateFruit_Class : SubClass DateFruit (both Food TropicalFruit) ;

  fun Deer : Class ;
  fun Deer_Class : SubClass Deer (both HoofedMammal Livestock) ;

  -- DemocraticSocialism is an 
  -- Attribute that describes a country in which socialism is promoted 
  -- by a political party or parties within a democratic government. 
  -- Under DemocraticSocialism, the government participates in central 
  -- planning of the economy and may also manage nationalized industries.
  fun DemocraticSocialism : Ind EconomicSystemAttribute ;

  -- DevelopedCountry (DC) is a term used to describe members of the top 
  -- group in the UNEconomicDevelopmentLevels. DevelopedCountry includes 
  -- market_oriented economies of mainly democratic nations, including members 
  -- of the OrganizationForEconomicCooperationAndDevelopment (OECD). DCs 
  -- are also known as First World countries, 'the North', and industrial 
  -- countries. Developed countries generally have high incomes (high per 
  -- capita GDP or GNI), but there are exceptions to DC membership both above 
  -- and below that standard. There is significant overlap, but not perfect 
  -- congruence, between the UN category DevelopedCountry and the IMF 
  -- category AdvancedEconomy.
  fun DevelopedCountry : Ind UNEconomicDevelopmentLevel ;

  -- DevelopingCountry is a term 
  -- used by the InternationalMonetaryFund (IMF) for the bottom group 
  -- in its hierarchy of advanced countries, countries in transition, 
  -- and developing countries. Generally corresponds to the attribute 
  -- LessDevelopedCountry used by UnitedNations agencies. Not to 
  -- be confused with DevelopedCountry.
  fun DevelopingCountry : Ind IMFDevelopmentLevel ;

  -- DieselFuel is the subclass of 
  -- RefinedPetroleumProducts that are fuels for diesel engines.
  fun DieselFuel : Class ;
  fun DieselFuel_Class : SubClass DieselFuel FossilFuel ;

  fun Dishwasher : Class ;
  fun Dishwasher_Class : SubClass Dishwasher MajorAppliance ;

  -- Distillation is a means of separating Liquids 
  -- through differences in their boilingPoints. The device used in 
  -- distillation is referred to as a still and consists at a minimum of a pot 
  -- in which the source material is heated, a condenser in which the heated 
  -- Gas is cooled back to the liquid state, and a receiver in which the 
  -- concentrated or purified liquid is collected. The equipment may effect 
  -- separation by one of two main methods. Firstly the vapours given off by 
  -- the heated mixture may consist of two liquids with significantly different 
  -- boiling points. Thus, the vapour that is given off is in the vast 
  -- majority of one or the other liquid, which after condensation and 
  -- collection effects the separation. The second method (fractional 
  -- distillation) relies upon a gradient of temperatures existing in the 
  -- condenser stage of the equipment. Often in this technique, a vertical 
  -- condenser, or column, is used. By extracting products that are liquid at 
  -- different heights up the column, it is possible to extract liquids that 
  -- have different boiling points. (from Wikipedia)
  fun Distilling : Class ;
  fun Distilling_Class : SubClass Distilling Separating ;

  fun DiversifiedEconomy : Ind FinancialSectorAttribute ;

  fun DjiboutiFranc : Ind UnitOfCurrency ;

  fun DominicanDollar : Ind UnitOfCurrency ;

  fun DominicanPeso : Ind UnitOfCurrency ;

  fun DrillingOilAndGasWells : Ind IndustryAttribute ;

  -- DurableGood is the subclass of 
  -- ManufacturedProducts which are designed to last for three years 
  -- or more.
  fun DurableGood : Class ;
  fun DurableGood_Class : SubClass DurableGood ManufacturedProduct ;

  fun DutchGuilder : Ind UnitOfCurrency ;

  -- EconomicAttribute is the class 
  -- of terms including all Attributes used to characterize the 
  -- economic systems or development levels of Nations or dependent 
  -- GeopoliticalAreas.
  fun EconomicAttribute : Class ;
  fun EconomicAttribute_Class : SubClass EconomicAttribute (both PoliticoEconomicAttribute RelationalAttribute) ;

  -- EconomicDevelopmentLevel is a subclass of EconomicAttribute 
  -- containing terms used to describe the economic development level of a 
  -- Nation or GeopoliticalArea. This class is further subdivided into 
  -- different scales devised or used by different agencies.
  fun EconomicDevelopmentLevel : Class ;
  fun EconomicDevelopmentLevel_Class : SubClass EconomicDevelopmentLevel EconomicAttribute ;

  -- EconomicSystemAttribute 
  -- is the class of Attributes that describe the type of economic 
  -- system that a country or area has. For example, CapitalistEconomy 
  -- or SocialistEconomy.
  fun EconomicSystemAttribute : Class ;
  fun EconomicSystemAttribute_Class : SubClass EconomicSystemAttribute EconomicAttribute ;

  fun EcuadoranSucre : Ind UnitOfCurrency ;

  fun EdibleNut : Class ;
  fun EdibleNut_Class : SubClass EdibleNut (both FruitOrVegetable GroceryProduce) ;

  fun EdibleTuber : Class ;
  fun EdibleTuber_Class : SubClass EdibleTuber (both PlantAgriculturalProduct RootVegetable) ;

  fun Eggplant : Class ;
  fun Eggplant_Class : SubClass Eggplant (both GroceryProduce Vegetable) ;

  fun EgyptianPound : Ind UnitOfCurrency ;

  fun ElSalvadoranColon : Ind UnitOfCurrency ;

  -- ElectricalPowerGeneration is 
  -- the subclass of PowerGeneration processes in which electricity is 
  -- generated.
  fun ElectricalPowerGeneration : Class ;
  fun ElectricalPowerGeneration_Class : SubClass ElectricalPowerGeneration PowerGeneration ;

  -- While electricity is typically thought of as just a difference
  -- in electrical potential, one way of modeling electricity is as a substance
  -- that can be moved from one point to another or consumed. One could make the claim
  -- that subatomic physics also supports the classification as a substance since electrons
  -- are objects.
  fun Electricity : Class ;
  fun Electricity_Class : SubClass Electricity Substance ;

  fun EstonianKroon : Ind UnitOfCurrency ;

  fun EthiopianBirr : Ind UnitOfCurrency ;

  fun EuroCentCoin : Class ;
  fun EuroCentCoin_Class : SubClass EuroCentCoin CurrencyCoin ;

  fun EuroDollarCoin : Class ;
  fun EuroDollarCoin_Class : SubClass EuroDollarCoin CurrencyCoin ;

  -- Exporting is the class of actions in 
  -- which there is a ChangeOfPossession of goods shipped from a 
  -- provider in one Nation to a destination in another Nation. 
  -- Typically, there are Selling and Buying events associated 
  -- with an Exporting. Either the seller or the exporting country 
  -- may be considered the origin of Exporting.
  fun Exporting : Class ;
  fun Exporting_Class : SubClass Exporting (both ChangeOfPossession FinancialTransaction) ;

  -- Any Mixture which is used to provide nutrients to 
  -- living Plants. Fertilizers can be made up of plant or animal material, e.g. 
  -- compost, or they can be entirely synthetic, e.g. ammonium nitrate.
  fun Fertilizer : Class ;
  fun Fertilizer_Class : SubClass Fertilizer Mixture ;

  fun FertilizerIndustry : Ind IndustryAttribute ;

  fun FertilizerManufacturing : Ind IndustryAttribute ;

  fun FertilizerMineralMining : Ind IndustryAttribute ;

  fun FijiDollar : Ind UnitOfCurrency ;

  -- FinancialSectorAttribute is 
  -- a class of Attributes that are used to indicate which financial sectors 
  -- are most important in the economy of a Nation or GeopoliticalArea.
  fun FinancialSectorAttribute : Class ;
  fun FinancialSectorAttribute_Class : SubClass FinancialSectorAttribute EconomicAttribute ;

  fun FinnishMarkka : Ind UnitOfCurrency ;

  -- (FiscalYearFn ?PLACE) denotes the subclass 
  -- of TimeIntervals that are fiscalYearPeriods of the Organization or 
  -- GeopoliticalArea ?PLACE.
  fun FiscalYearFn: El Agent -> Desc TimeInterval ;

  -- (FiscalYearStartingFn ?PLACE ?YEAR) 
  -- denotes the particular fiscal year that is observed in ?PLACE and begins 
  -- during the calendar Year indicated by ?YEAR.
  fun FiscalYearStartingFn: El Agent -> Desc Year -> Ind TimeInterval ;

  -- FishProduct is the subclass of 
  -- AnimalAgriculturalProduct that comprises products derived 
  -- from fish.
  fun FishProduct : Class ;
  fun FishProduct_Class : SubClass FishProduct AnimalAgriculturalProduct ;

  fun FishRoe : Class ;
  fun FishRoe_Class : SubClass FishRoe FishProduct ;

  fun FlaxFiber : Class ;
  fun FlaxFiber_Class : SubClass FlaxFiber PlantAgriculturalProduct ;

  -- Fodder is the class of OrganicObjects that are used as food for
  -- domesticated animals. Fodder Fodder is the subclass of Food that is 
  -- intended for instances of DomesticAnimal.
  fun Fodder : Class ;
  fun Fodder_Class : SubClass Fodder (both Food OrganicObject) ;

  fun FoodEgg : Class ;
  fun FoodEgg_Class : SubClass FoodEgg AnimalAgriculturalProduct ;

  fun FoodFish : Class ;
  fun FoodFish_Class : SubClass FoodFish Seafood ;

  -- FoodProduct is the class of food 
  -- products, packaged or unpackaged.
  fun FoodProduct : Class ;
  fun FoodProduct_Class : SubClass FoodProduct Product ;

  fun Footwear : Class ;
  fun Footwear_Class : SubClass Footwear Clothing ;

  fun ForageCrop : Class ;
  fun ForageCrop_Class : SubClass ForageCrop (both Fodder (both Plant PlantAgriculturalProduct)) ;

  fun ForestProduct : Class ;
  fun ForestProduct_Class : SubClass ForestProduct Product ;

  fun ForestryAndLogging : Ind IndustryAttribute ;

  -- FormerSovietOrEasternEuropeanCountry (former USSR_EE) is an 
  -- Attribute that characterizes countries that were part of the former 
  -- Soviet Union or its sphere of influence in Eastern Europe. This level 
  -- occupies a middle position between DevelopedCountry (DC) and 
  -- LessDevelopedCountry (LDC) in UNEconomicDevelopmentLevels. 
  -- Previously, former USSR_EE countries had a CentrallyPlannedEconomy and 
  -- were Marxist_Leninist states. Many are now evolving away from command 
  -- economies to market economic systems. During the 1980's, the group 
  -- included Albania, Bulgaria, Cambodia, China, Cuba, Czechoslovakia, the 
  -- German Democratic Republic (East Germany), Hungary, North Korea, Laos, 
  -- Mongolia, Poland, Romania, the USSR, Vietnam and Yugoslavia.
  fun FormerSovietOrEasternEuropeanCountry : Ind UNEconomicDevelopmentLevel ;

  fun FossilFuelPowerGeneration : Ind PowerGeneration ;

  -- FourDragonsEconomy describes four 
  -- small Asian countries that achieved rapid economic growth in the 1990s. 
  -- Some systems of EconomicDevelopmentLevel place them as a 
  -- LessDevelopedCountry, but the IMF includes them in AdvancedEconomy.
  fun FourDragonsEconomy : Ind EconomicDevelopmentLevel ;

  fun Freezer : Class ;
  fun Freezer_Class : SubClass Freezer MajorAppliance ;

  fun FrenchFranc : Ind UnitOfCurrency ;

  fun FrenchFrancCoin : Class ;
  fun FrenchFrancCoin_Class : SubClass FrenchFrancCoin CurrencyCoin ;

  fun Fruit : Class ;
  fun Fruit_Class : SubClass Fruit FruitOrVegetable ;

  fun FruitFarming : Ind IndustryAttribute ;

  fun FurnitureAndHomeFurnishingWholesalers : Ind IndustryAttribute ;

  fun FurnitureAndHomeFurnishingsStores : Ind IndustryAttribute ;

  fun FurnitureAndRelatedProductManufacturing : Ind IndustryAttribute ;

  fun FurnitureIndustry : Ind IndustryAttribute ;

  fun FurnitureManufacturing : Ind IndustryAttribute ;

  fun Furniture_DurableGood : SubClass Furniture DurableGood ;

  fun GabonFranc : Ind UnitOfCurrency ;

  fun GambianDalasi : Ind UnitOfCurrency ;

  -- Gasoline is the subclass of 
  -- RefinedPetroleumProducts that are fuels for internal combustion engines.
  fun Gasoline : Class ;
  fun Gasoline_Class : SubClass Gasoline FossilFuel ;

  -- Gemstone is the subclass of Mineral items 
  -- that are especially valued for use in jewelry and other decorative items, and also in some mechanical and industrial applications.
  fun Gemstone : Class ;
  fun Gemstone_Class : SubClass Gemstone Mixture ;

  fun GeorgianLari : Ind UnitOfCurrency ;

  fun GermanMark : Ind UnitOfCurrency ;

  fun GermanMarkCoin : Class ;
  fun GermanMarkCoin_Class : SubClass GermanMarkCoin CurrencyCoin ;

  fun GhanianCedi : Ind UnitOfCurrency ;

  fun Ginger : Class ;
  fun Ginger_Class : SubClass Ginger (both Spice Vegetable) ;

  -- A domesticated HoofedMammal that is raised primarily for Milk.
  fun Goat : Class ;
  fun Goat_Class : SubClass Goat (both HoofedMammal Livestock) ;

  -- GovernmentRegulatedEconomy 
  -- is an Attribute that describes the economy of a country in which the 
  -- government determines prices, production, wages, allocation of resources, 
  -- or other economic factors. An economy that is wholly government planned 
  -- is a CentrallyPlannedEconomy.
  fun GovernmentRegulatedEconomy : Ind EconomicSystemAttribute ;

  -- GovernmentSubsidizedEconomy 
  -- is an Attribute describing an economy in which the government provides 
  -- subsidies to various industries, workers, or other groups as part of its 
  -- economic policy.
  fun GovernmentSubsidizedEconomy : Ind EconomicSystemAttribute ;

  fun GrainAndOilseedMilling : Ind IndustryAttribute ;

  fun Grape : Class ;
  fun Grape_Class : SubClass Grape (both Fruit GroceryProduce) ;

  fun GreekDrachma : Ind UnitOfCurrency ;

  fun GreenPepper : Class ;
  fun GreenPepper_Class : SubClass GreenPepper (both GroceryProduce Vegetable) ;

  fun GrenadaDollar : Ind UnitOfCurrency ;

  fun Groundnut : Class ;
  fun Groundnut_Class : SubClass Groundnut (both EdibleTuber (both FruitOrVegetable GroceryProduce)) ;

  fun GuatemalanQuetzal : Ind UnitOfCurrency ;

  fun GuernseyCattle : Class ;
  fun GuernseyCattle_Class : SubClass GuernseyCattle Cattle ;

  fun GuineaBissauPeso : Ind UnitOfCurrency ;

  fun GuineanFranc : Ind UnitOfCurrency ;

  fun GumArabic : Class ;
  fun GumArabic_Class : SubClass GumArabic (both PlantAgriculturalProduct Substance) ;

  fun GuyanaDollar : Ind UnitOfCurrency ;

  fun HaitianGourde : Ind UnitOfCurrency ;

  fun HandicraftIndustry : Ind IndustryAttribute ;

  -- HandicraftProduct is the class of 
  -- Products that are manufactured by hand with a special skill.
  fun HandicraftProduct : Class ;
  fun HandicraftProduct_Class : SubClass HandicraftProduct Product ;

  fun HandwovenCarpet : Class ;
  fun HandwovenCarpet_Class : SubClass HandwovenCarpet (both HandicraftProduct TextileProduct) ;

  fun HandwovenCarpetManufacturing : Ind IndustryAttribute ;

  fun Hardwood : Class ;
  fun Hardwood_Class : SubClass Hardwood WoodProduct ;

  -- Grass that has been cut and cured for use as Fodder.
  fun Hay : Class ;
  fun Hay_Class : SubClass Hay Fodder ;

  fun HempFiber : Class ;
  fun HempFiber_Class : SubClass HempFiber PlantAgriculturalProduct ;

  -- HighIncomeCountry is an Attribute representing the World Bank 
  -- classification for any country where the per capita GNI is 
  -- equal to or greater than &9,266 in UnitedStatesDollars.
  fun HighIncomeCountry : Ind WorldBankGNIPerCapitaLevel ;

  -- HighTechIndustrialEconomy 
  -- is an Attribute used to describe industrialized countries whose 
  -- infrastructure uses the most advanced kinds of technology.
  fun HighTechIndustrialEconomy : Ind EconomicDevelopmentLevel ;

  fun HonduranLempira : Ind UnitOfCurrency ;

  fun Honey_AnimalAgriculturalProduct : SubClass Honey AnimalAgriculturalProduct ;

  fun HongKongDollar : Ind UnitOfCurrency ;

  fun HotWaterHeater : Class ;
  fun HotWaterHeater_Class : SubClass HotWaterHeater MajorAppliance ;

  fun HouseholdRefrigeratorAndHomeFreezerManufacturing : Ind IndustryAttribute ;

  fun HungarianForint : Ind UnitOfCurrency ;

  fun HydroElectricPowerGeneration : Ind ElectricalPowerGeneration ;

  -- IMFDevelopmentLevel is a 
  -- collection of Attributes representing economic development levels 
  -- used by the InternationalMonetaryFund (IMF) to characterize national 
  -- economies. The hierarchy of IMF levels includes: AdvancedEconomy, 
  -- CountryInTransition, and DevelopingCountry. There is some, but not 
  -- complete, overlap with concepts used by UnitedNations agencies. 
  -- See
  fun IMFDevelopmentLevel : Class ;
  fun IMFDevelopmentLevel_Class : SubClass IMFDevelopmentLevel EconomicDevelopmentLevel ;

  fun IcelandicKrona : Ind UnitOfCurrency ;

  fun IndianRupee : Ind UnitOfCurrency ;

  fun IndonesianRupiah : Ind UnitOfCurrency ;

  fun IndustrialRawMaterial : Class ;
  fun IndustrialRawMaterial_Class : SubClass IndustrialRawMaterial CapitalGood ;

  fun IndustrialSector : Ind IndustryAttribute ;

  -- IndustrialSupply is the class of 
  -- products that are used in industry but which are not raw materials 
  -- for products being manufactured. IndustrialSupply includes maintenance, 
  -- repair, and operation (MRO) supplies, including janitorial, electrical, 
  -- bearings, tools, machinery, accessories, fire and safety equipment, and 
  -- other industrial items.
  fun IndustrialSupply : Class ;
  fun IndustrialSupply_Class : SubClass IndustrialSupply (both CapitalGood ManufacturedProduct) ;

  fun IndustryAttribute : Class ;

  fun IranianRial : Ind UnitOfCurrency ;

  fun IraqiDinar : Ind UnitOfCurrency ;

  fun IrishPound : Ind UnitOfCurrency ;

  fun IronMetal : Class ;
  fun IronMetal_Class : SubClass IronMetal MetalProduct ;

  -- IronOre is a subclass of CompoundSubstance 
  -- that contains compounds of iron, of which the most common are 
  -- hematite and limonite. Iron is obtained from smelting iron ores.
  fun IronOre : Class ;
  fun IronOre_Class : SubClass IronOre (both CompoundSubstance (both Mineral MiningProduct)) ;

  fun IsraeliShekel : Ind UnitOfCurrency ;

  fun ItalianLire : Ind UnitOfCurrency ;

  fun ItalianLireCoin : Class ;
  fun ItalianLireCoin_Class : SubClass ItalianLireCoin CurrencyCoin ;

  fun IvoryCoastFranc : Ind UnitOfCurrency ;

  fun JamaicanDollar : Ind UnitOfCurrency ;

  fun JapaneseYen : Ind UnitOfCurrency ;

  fun JapaneseYenCoin : Class ;
  fun JapaneseYenCoin_Class : SubClass JapaneseYenCoin CurrencyCoin ;

  -- Jewelry is the subclass of PersonalAdornment 
  -- items that are typically made of metals (especially precious metals), 
  -- gems, and other non_cloth materials.
  fun Jewelry : Class ;
  fun Jewelry_Class : SubClass Jewelry (both PersonalAdornment WearableItem) ;

  fun JordanianDinar : Ind UnitOfCurrency ;

  fun JuteFiber : Class ;
  fun JuteFiber_Class : SubClass JuteFiber PlantAgriculturalProduct ;

  fun KazakhstaniTenge : Ind UnitOfCurrency ;

  fun KentiaPalmSeed : Class ;
  fun KentiaPalmSeed_Class : SubClass KentiaPalmSeed (both PlantAgriculturalProduct Seed) ;

  fun KenyanShilling : Ind UnitOfCurrency ;

  -- Khat is the class of PlantAgriculturalProducts 
  -- made from the leaves and buds of the staff tree, which 
  -- are chewed or brewed as a stimulating tea.
  fun Khat : Class ;
  fun Khat_Class : SubClass Khat PlantAgriculturalProduct ;

  -- KilowattHour is a UnitOfMeasure for 
  -- energy that represents 1000 Watts (1 kW) of power expended over one 
  -- hour (1 h) of time. This is the unit commonly used in commercial 
  -- power contexts. It is equivalent to 3,600,000 Joules.
  fun KilowattHour : Ind CompositeUnitOfMeasure ;

  fun KiribatiDollar : Ind UnitOfCurrency ;

  fun KuwaitiDinar : Ind UnitOfCurrency ;

  fun KyrgyzstaniSom : Ind UnitOfCurrency ;

  fun LambMeat : Class ;
  fun LambMeat_Class : SubClass LambMeat Meat ;

  fun Lambskin : Class ;
  fun Lambskin_Class : SubClass Lambskin Pelt ;

  fun LaotianKip : Ind UnitOfCurrency ;

  fun LatvianLats : Ind UnitOfCurrency ;

  fun LeadIndustry : Ind IndustryAttribute ;

  fun LeadManufacturing : Ind IndustryAttribute ;

  fun LeadMetal : Class ;
  fun LeadMetal_Class : SubClass LeadMetal MetalProduct ;

  fun LeadOre : Class ;
  fun LeadOre_Class : SubClass LeadOre (both Mineral MiningProduct) ;

  fun LeadOreMining : Ind IndustryAttribute ;

  fun LeadProduct : Class ;
  fun LeadProduct_Class : SubClass LeadProduct (both LeadMetal ManufacturedProduct) ;

  fun Leaf : Class ;
  fun Leaf_Class : SubClass Leaf AnatomicalStructure ;

  fun LeafyGreenVegetable : Class ;
  fun LeafyGreenVegetable_Class : SubClass LeafyGreenVegetable (both GroceryProduce Vegetable) ;

  -- LeastDevelopedCountry 
  -- is a sub_classification of LessDevelopedCountry characterizing
  -- those countries that have no significant economic growth, a per 
  -- capita GDP of less than 1,000 UnitedStatesDollars, and low 
  -- literacy. Also known as 'undeveloped countries'.
  fun LeastDevelopedCountry : Ind EconomicDevelopmentLevel ;

  fun LebanesePound : Ind UnitOfCurrency ;

  fun Legume : Class ;
  fun Legume_Class : SubClass Legume (both PlantAgriculturalProduct Vegetable) ;

  fun Lemon : Class ;
  fun Lemon_Class : SubClass Lemon CitrusFruit ;

  fun Lentil : Class ;
  fun Lentil_Class : SubClass Lentil Pulse ;

  fun LesothoLoti : Ind UnitOfCurrency ;

  -- LessDevelopedCountry (LDC) is 
  -- the Attribute used to describe the bottom group in the hierarchy 
  -- of UNEconomicDevelopmentLevels. Less developed countries are countries 
  -- or dependent areas with low levels of production, living standards, 
  -- and technology. Per capita GDP (perCapitaGDPInPeriod), or GDI 
  -- (Gross Domestic Income), is generally less than 5,000 and often 
  -- below 1,500. Subgroups of LDC, however, include countries that have 
  -- higher per capita incomes, as well as advanced technology, and rapid rates 
  -- of growth. Subgroups of LDC include: advanced developing countries, 
  -- the Four Dragons (also known as Four Tigers), LeastDevelopedCountry 
  -- (LLDCs), low_income countries, middle_income countries, newly 
  -- industrializing economies (NIEs), the South (from the location of 
  -- most LDC countries, relative to Northern developed countries), Third 
  -- World (obsolete), UnderdevelopedCountry, UndevelopedCountry.
  fun LessDevelopedCountry : Ind UNEconomicDevelopmentLevel ;

  fun LiberianDollar : Ind UnitOfCurrency ;

  fun LibyanDinar : Ind UnitOfCurrency ;

  fun Lime : Class ;
  fun Lime_Class : SubClass Lime CitrusFruit ;

  fun LithuanianLitas : Ind UnitOfCurrency ;

  -- LowIncomeCountry is an 
  -- Attribute representing the World Bank classification for any country 
  -- where the per capita GNI is 755 or below in UnitedStatesDollars.
  fun LowIncomeCountry : Ind WorldBankGNIPerCapitaLevel ;

  -- LowerMiddleIncomeCountry is an Attribute representing the World 
  -- Bank classification for any country where the per capita GNI is 
  -- between 756 and 2,995 (inclusive) in UnitedStatesDollars.
  fun LowerMiddleIncomeCountry : Ind WorldBankGNIPerCapitaLevel ;

  -- A ManufacturedProduct derived from Timber.
  fun Lumber : Class ;
  fun Lumber_Class : SubClass Lumber (both DurableGood ForestProduct) ;

  fun LumberIndustry : Ind IndustryAttribute ;

  fun LumberPlywoodMillworkAndWoodPanelWholesalers : Ind IndustryAttribute ;

  fun LuxembourgFranc : Ind UnitOfCurrency ;

  fun MacademiaNut : Class ;
  fun MacademiaNut_Class : SubClass MacademiaNut EdibleNut ;

  fun MacaoPataca : Ind UnitOfCurrency ;

  fun Mace : Class ;
  fun Mace_Class : SubClass Mace Spice ;

  fun MachineTool : Class ;
  fun MachineTool_Class : SubClass MachineTool Machinery ;

  fun Machine_Machinery : SubClass Machine Machinery ;

  -- Machinery is the class of products 
  -- that includes Machines, tools, and machine parts used in industrial 
  -- or other commercial processes.
  fun Machinery : Class ;
  fun Machinery_Class : SubClass Machinery (both Device (both DurableGood IndustrialSupply)) ;

  fun MadagascarFranc : Ind UnitOfCurrency ;

  fun MajorAppliance : Class ;
  fun MajorAppliance_Class : SubClass MajorAppliance (both Device DurableGood) ;

  -- MajorIndustrialEconomy is an 
  -- Attribute used to describe countries with the largest, industrialized, 
  -- non_communist economies in the world.
  fun MajorIndustrialEconomy : Ind EconomicDevelopmentLevel ;

  fun MalawianKwacha : Ind UnitOfCurrency ;

  fun MalaysianRinggit : Ind UnitOfCurrency ;

  fun MaliFranc : Ind UnitOfCurrency ;

  fun MalteseLira : Ind UnitOfCurrency ;

  fun Mango : Class ;
  fun Mango_Class : SubClass Mango (both GroceryProduce TropicalFruit) ;

  fun ManufacturingBasedEconomy : Ind FinancialSectorAttribute ;

  -- MarketEconomy is an Attribute that 
  -- describes an economy in which market forces, specifically supply and 
  -- demand, provide input for privately managed decisions about pricing 
  -- and production of goods.
  fun MarketEconomy : Ind EconomicSystemAttribute ;

  fun MarketSocialism : Ind EconomicSystemAttribute ;

  fun MauritanianOuguiya : Ind UnitOfCurrency ;

  fun MauritianRupee : Ind UnitOfCurrency ;

  fun Meat_AnimalAgriculturalProduct : SubClass Meat AnimalAgriculturalProduct ;

  fun Melon : Class ;
  fun Melon_Class : SubClass Melon (both Fruit GroceryProduce) ;

  fun MetalProduct : Class ;
  fun MetalProduct_Class : SubClass MetalProduct DurableGood ;

  fun MetallurgyIndustry : Ind IndustryAttribute ;

  fun MexicanPeso : Ind UnitOfCurrency ;

  fun Milk_DairyProduct : SubClass Milk DairyProduct ;

  fun MilletFarming : Ind IndustryAttribute ;

  fun MilletGrain : Class ;
  fun MilletGrain_Class : SubClass MilletGrain CerealGrain ;

  fun Millwork : Ind IndustryAttribute ;

  fun MiningExceptOilAndGas : Ind IndustryAttribute ;

  fun MiningIndustry : Ind IndustryAttribute ;

  -- MixedEconomy is the Attribute 
  -- of a country whose economy has elements of more than one pure 
  -- economic system, e.g., a market economy with government welfare 
  -- for unemployed workers. A mixed_economy country may be a 
  -- CountryInTransition, as from a prior communist economy to 
  -- capitalism, but a mixed economy may also be a stable combination 
  -- of different economic approaches in different areas of a national 
  -- economy, e.g., nationally managed health care and education systems 
  -- in an otherwise private_enterprise economy.
  fun MixedEconomy : Ind EconomicSystemAttribute ;

  fun MoldovanLeu : Ind UnitOfCurrency ;

  fun MongolianTugrik : Ind UnitOfCurrency ;

  fun MoroccanDirham : Ind UnitOfCurrency ;

  -- MotorOil is the subclass of PetroleumLubricants 
  -- that are used to lubricate motors.
  fun MotorOil : Class ;
  fun MotorOil_Class : SubClass MotorOil PetroleumLubricant ;

  fun MotorVehicleAndMotorVehiclePartsAndSuppliesWholesalers : Ind IndustryAttribute ;

  fun MotorVehicleAndPartsDealers : Ind IndustryAttribute ;

  fun MotorVehicleBodyAndTrailerManufacturing : Ind IndustryAttribute ;

  fun MotorVehicleIndustry : Ind IndustryAttribute ;

  fun MotorVehicleManufacturing : Ind IndustryAttribute ;

  fun MotorVehiclePartsManufacturing : Ind IndustryAttribute ;

  fun MozambiqueMetical : Ind UnitOfCurrency ;

  fun MulberryLeaf : Class ;
  fun MulberryLeaf_Class : SubClass MulberryLeaf (both Fodder (both Leaf PlantAgriculturalProduct)) ;

  fun Mutton : Class ;
  fun Mutton_Class : SubClass Mutton Meat ;

  fun MyanmarKyat : Ind UnitOfCurrency ;

  -- Narcotic is a subclass of addictive 
  -- BiologicallyActiveSubstances that have damping effects on the 
  -- nervous system and may be fatal in large doses.
  fun Narcotic : Class ;
  fun Narcotic_Class : SubClass Narcotic ControlledSubstance ;

  -- NationalizedIndustryEconomy 
  -- is an Attribute describing an economy in which the major industries, 
  -- such as energy and transportation, are owned by the national government.
  fun NationalizedIndustryEconomy : Ind EconomicSystemAttribute ;

  fun NaturalGasDistribution : Ind IndustryAttribute ;

  fun NaturalGasIndustry : Ind IndustryAttribute ;

  fun NaturalGasLiquidExtraction : Ind IndustryAttribute ;

  -- NaturalRubber is the subclass of 
  -- PlantAgriculturalProducts made from the sap of plant species 
  -- which produce natural polymers.
  fun NaturalRubber : Class ;
  fun NaturalRubber_Class : SubClass NaturalRubber PlantAgriculturalProduct ;

  fun NepaleseRupee : Ind UnitOfCurrency ;

  fun NewZealandDollar : Ind UnitOfCurrency ;

  -- NewlyIndustrializingEconomy is an Attribute used to describe a 
  -- LessDevelopedCountry (LDC) that is undergoing rapid industrial 
  -- development. Also called 'newly industrializing economy' (or 
  -- 'country').
  fun NewlyIndustrializingEconomy : Ind EconomicDevelopmentLevel ;

  fun NicaraguanCordoba : Ind UnitOfCurrency ;

  fun NickelOre : Class ;
  fun NickelOre_Class : SubClass NickelOre (both Mineral MiningProduct) ;

  fun NigerFranc : Ind UnitOfCurrency ;

  fun NigerianNaira : Ind UnitOfCurrency ;

  fun NorfolkIslandPineSeed : Class ;
  fun NorfolkIslandPineSeed_Class : SubClass NorfolkIslandPineSeed (both PlantAgriculturalProduct Seed) ;

  fun NorthKoreanWon : Ind UnitOfCurrency ;

  fun NorwegianKrone : Ind UnitOfCurrency ;

  fun NuclearPowerGeneration : Ind PowerGeneration ;

  fun Nut : Class ;
  fun Nut_Class : SubClass Nut (both PlantAgriculturalProduct ReproductiveBody) ;

  fun Nutmeg : Class ;
  fun Nutmeg_Class : SubClass Nutmeg Spice ;

  fun OatFarming : Ind IndustryAttribute ;

  fun OatGrain : Class ;
  fun OatGrain_Class : SubClass OatGrain CerealGrain ;

  fun OffshoreBankingSectorEconomy : Ind FinancialSectorAttribute ;

  fun OffshoreFinancialSectorEconomy : Ind FinancialSectorAttribute ;

  fun Oilseed : Class ;
  fun Oilseed_Class : SubClass Oilseed (both PlantAgriculturalProduct Seed) ;

  -- Okoume (Aucoumea klaineana), also called 
  -- 'gaboon', is a wood of West African origin.
  fun Okoume : Class ;
  fun Okoume_Class : SubClass Okoume Hardwood ;

  fun Olive : Class ;
  fun Olive_Class : SubClass Olive (both Fruit GroceryProduce) ;

  fun OliveOil : Class ;
  fun OliveOil_Class : SubClass OliveOil VegetableOil ;

  fun OmaniRiyal : Ind UnitOfCurrency ;

  fun OpiumPoppy : Class ;
  fun OpiumPoppy_Class : SubClass OpiumPoppy (both PlantAgriculturalProduct Poppy) ;

  fun OpiumPoppyFarming : Class ;
  fun OpiumPoppyFarming_Class : SubClass OpiumPoppyFarming Farming ;

  -- A substance harvested from the seed capsules of the 
  -- opium poppy that contains various powerful alkaloids.
  fun Opium : Class ;
  fun Opium_Class : SubClass Opium (both (both Depressant Narcotic) (both PlantSubstance PlantAgriculturalProduct)) ;

  fun Orchid : Class ;
  fun Orchid_Class : SubClass Orchid (both FloweringPlant PlantAgriculturalProduct) ;

  fun OrnamentalFish : Class ;
  fun OrnamentalFish_Class : SubClass OrnamentalFish (both AnimalAgriculturalProduct Fish) ;

  -- OtherSourcePowerGeneration 
  -- represents all non_fossil fuel, non_hydroelectric, and non_nuclear power 
  -- generation processes, e.g., wind power generation.
  fun OtherSourcePowerGeneration : Ind PowerGeneration ;

  -- PPPBasedEconomicValuation 
  -- is a class of relations used to state international economic information 
  -- in U.S. dollar amounts. The U.S. dollar amounts are derived from Purchasing 
  -- Power Parity conversions of economic totals (e.g., GDP) given in local 
  -- currency. This contrasts with a method of conversion based on currency 
  -- exchange rates. The PPP method is used by the CIA World Fact Book for 
  -- the purpose of presenting economic data for all countries covered. Their 
  -- basis for PPP dollar price weights is the UN International Comparison Program 
  -- (UNICP) and the work of Professors Robert Summers and Alan Heston of the 
  -- University of Pennsylvania.
  fun PPPBasedEconomicValuation : Class ;

  -- PackagedBeverageProduct is the 
  -- class of Products that consist of a BeverageProduct in some kind of 
  -- packaging, including cups and bottles.
  fun PackagedBeverageProduct : Class ;
  fun PackagedBeverageProduct_Class : SubClass PackagedBeverageProduct Product ;

  -- PackagedFoodProduct is the 
  -- class of Products that consist of a FoodProduct in a package.
  fun PackagedFoodProduct : Class ;
  fun PackagedFoodProduct_Class : SubClass PackagedFoodProduct Product ;

  fun PaddyRice : Class ;
  fun PaddyRice_Class : SubClass PaddyRice CerealGrass ;

  fun PakistaniRupee : Ind UnitOfCurrency ;

  fun PalmKernel : Class ;
  fun PalmKernel_Class : SubClass PalmKernel PlantAgriculturalProduct ;

  fun PalmOil : Class ;
  fun PalmOil_Class : SubClass PalmOil VegetableOil ;

  fun PalmOilNut : Class ;
  fun PalmOilNut_Class : SubClass PalmOilNut (both Nut PlantAgriculturalProduct) ;

  fun PanamanianBalboa : Ind UnitOfCurrency ;

  fun Papaw : Class ;
  fun Papaw_Class : SubClass Papaw (both GroceryProduce TropicalFruit) ;

  fun Papaya : Class ;
  fun Papaya_Class : SubClass Papaya (both GroceryProduce TropicalFruit) ;

  fun PapuanKina : Ind UnitOfCurrency ;

  fun ParaguayanGuarani : Ind UnitOfCurrency ;

  fun PartialMarketEconomy : Ind EconomicSystemAttribute ;

  fun PassionFruit : Class ;
  fun PassionFruit_Class : SubClass PassionFruit (both GroceryProduce TropicalFruit) ;

  -- The edible Seed of a pea plant.
  fun Pea : Class ;
  fun Pea_Class : SubClass Pea (both (both Food Seed) Legume) ;

  fun Peanut : Class ;
  fun Peanut_Class : SubClass Peanut (both EdibleNut GroceryProduce) ;

  fun Pearl : Class ;
  fun Pearl_Class : SubClass Pearl Jewelry ;

  fun PecanNut : Class ;
  fun PecanNut_Class : SubClass PecanNut EdibleNut ;

  -- Pelt is the subclass of AnimalSkin 
  -- that comprises the pelts or hides of animals that are used in 
  -- the manufacture of wearable or household items.
  fun Pelt : Class ;
  fun Pelt_Class : SubClass Pelt (both AnimalAgriculturalProduct AnimalSkin) ;

  fun PerfumeEssence : Class ;
  fun PerfumeEssence_Class : SubClass PerfumeEssence PlantAgriculturalProduct ;

  -- PersonalAdornment is the subclass 
  -- of WearableItems that are worn primarily for decorative purposes.
  fun PersonalAdornment : Class ;
  fun PersonalAdornment_Class : SubClass PersonalAdornment WearableItem ;

  fun PeruvianInti : Ind UnitOfCurrency ;

  -- Petroleum is commonly known as crude 
  -- oil. It is a thick, dark brown or greenish flammable liquid, which exists 
  -- in the upper strata of some areas of the Earth's crust. It consists of a 
  -- complex mixture of various hydrocarbons, largely of the methane series, 
  -- but may vary much in appearance, composition, and purity. (from Wikipedia)
  -- Crude oil has not be subject to the distillation that will yield a
  -- RefinedPetroleumProduct.
  fun Petroleum : Class ;
  fun Petroleum_Class : SubClass Petroleum PetroleumProduct ;

  fun PetroleumBasedEconomy : Ind FinancialSectorAttribute ;

  fun PetroleumIndustry : Ind IndustryAttribute ;

  -- PetroleumLubricant is the subclass of 
  -- RefinedPetroleumProducts that are lubricants.
  fun PetroleumLubricant : Class ;
  fun PetroleumLubricant_Class : SubClass PetroleumLubricant RefinedPetroleumProduct ;

  fun PetroleumProductsManufacturing : Ind IndustryAttribute ;

  fun PetroleumRefineries : Ind IndustryAttribute ;

  fun PharmaceuticalProduct : Class ;
  fun PharmaceuticalProduct_Class : SubClass PharmaceuticalProduct ManufacturedProduct ;

  fun PhilippinePeso : Ind UnitOfCurrency ;

  fun PhosphoricAcid : Class ;
  fun PhosphoricAcid_Class : SubClass PhosphoricAcid CompoundSubstance ;

  fun Pineapple : Class ;
  fun Pineapple_Class : SubClass Pineapple (both GroceryProduce TropicalFruit) ;

  fun PipelineTransportationOfNaturalGas : Ind IndustryAttribute ;

  fun Plantain : Class ;
  fun Plantain_Class : SubClass Plantain (both GroceryProduce TropicalFruit) ;

  fun Plastic : Class ;
  fun Plastic_Class : SubClass Plastic ManufacturedProduct ;

  fun PolishZloty : Ind UnitOfCurrency ;

  fun Poppy : Class ;
  fun Poppy_Class : SubClass Poppy FloweringPlant ;

  fun PortugueseEscudo : Ind UnitOfCurrency ;

  fun PotatoTuber : Class ;
  fun PotatoTuber_Class : SubClass PotatoTuber (both EdibleTuber GroceryProduce) ;

  -- PowerGeneration is the class of 
  -- Processes in which some kind of power is generated either for immediate 
  -- use in a Device or to be stored for future use.
  fun PowerGeneration : Class ;
  fun PowerGeneration_Class : SubClass PowerGeneration Process ;

  -- PreciousGemstone is the class of 
  -- Minerals and fossilized substances that have great monetary value.
  fun PreciousGemstone : Class ;
  fun PreciousGemstone_Class : SubClass PreciousGemstone (both Gemstone MiningProduct) ;

  fun PrimarySmeltingAndRefiningOfCopper : Ind IndustryAttribute ;

  -- PrivateEnterpriseEconomy is 
  -- the Attribute used to characterize a country in which private 
  -- enterprise is the main source of economic wealth.
  fun PrivateEnterpriseEconomy : Ind EconomicSystemAttribute ;

  -- PrivatizingEconomy is an 
  -- Attribute that describes a country in which formerly government_
  -- owned industries are being transferred into private holdings.
  fun PrivatizingEconomy : Ind EconomicSystemAttribute ;

  -- ProductPackage is the class of objects 
  -- designed to contain Products for shipping and sale.
  fun ProductPackage : Class ;
  fun ProductPackage_Class : SubClass ProductPackage Container ;

  fun Pulse : Class ;
  fun Pulse_Class : SubClass Pulse Legume ;

  -- PureCapitalistEconomy is an 
  -- Attribute representing a capitalist economy that has no admixture of 
  -- socialism.
  fun PureCapitalistEconomy : Ind EconomicSystemAttribute ;

  -- PureSocialistEconomy is an Attribute representing a 
  -- socialist economy that has no admixture of capitalism.
  fun PureSocialistEconomy : Ind EconomicSystemAttribute ;

  -- Pyrethrum is the subclass of 
  -- BiologicallyActiveSubstance consisting of insecticidal 
  -- derivations from the flower heads of Chrysanthemums.
  fun Pyrethrum : Class ;
  fun Pyrethrum_Class : SubClass Pyrethrum (both BiologicallyActiveSubstance PlantAgriculturalProduct) ;

  fun QatariRiyal : Ind UnitOfCurrency ;

  fun Quinine : Class ;
  fun Quinine_Class : SubClass Quinine PlantAgriculturalProduct ;

  fun ReadyMixConcrete : Class ;
  fun ReadyMixConcrete_Class : SubClass ReadyMixConcrete Concrete ;

  fun RefrigeratedWarehousingAndStorage : Ind IndustryAttribute ;

  fun RefrigerationEquipmentAndSuppliesWholesalers : Ind IndustryAttribute ;

  fun RefrigerationEquipmentManufacturing : Ind IndustryAttribute ;

  fun RefrigeratorAndFreezerIndustry : Ind IndustryAttribute ;

  fun Refrigerator_MajorAppliance : SubClass Refrigerator MajorAppliance ;

  fun Reindeer : Class ;
  fun Reindeer_Class : SubClass Reindeer (both HoofedMammal Livestock) ;

  fun RiceFarming : Ind IndustryAttribute ;

  fun RomanianLeu : Ind UnitOfCurrency ;

  fun RootStarch : Class ;
  fun RootStarch_Class : SubClass RootStarch (both FruitOrVegetable PlantAgriculturalProduct) ;

  fun RootVegetable : Class ;
  fun RootVegetable_Class : SubClass RootVegetable (both FruitOrVegetable PlantAgriculturalProduct) ;

  fun RussianRuble : Ind UnitOfCurrency ;

  fun RwandaFranc : Ind UnitOfCurrency ;

  fun RyeFarming : Ind IndustryAttribute ;

  fun RyeGrain : Class ;
  fun RyeGrain_Class : SubClass RyeGrain CerealGrain ;

  fun Salmon : Class ;
  fun Salmon_Class : SubClass Salmon FoodFish ;

  fun SaoThomeEPrincipeDobra : Ind UnitOfCurrency ;

  fun SaudiArabianRiyal : Ind UnitOfCurrency ;

  fun Seafood : Class ;
  fun Seafood_Class : SubClass Seafood Meat ;

  fun Seed_FruitOrVegetable : SubClass Seed FruitOrVegetable ;

  -- SemipreciousGemstone is the class of Minerals and 
  -- other substances that have significant monetary value, 
  -- but less than those of the class PreciousGemstone.
  fun SemipreciousGemstone : Class ;
  fun SemipreciousGemstone_Class : SubClass SemipreciousGemstone (both Gemstone MiningProduct) ;

  fun SenegaleseFranc : Ind UnitOfCurrency ;

  fun SenepolCattle : Class ;
  fun SenepolCattle_Class : SubClass SenepolCattle Cattle ;

  fun ServiceBasedEconomy : Ind FinancialSectorAttribute ;

  fun ServiceSector : Ind IndustryAttribute ;

  fun Sesame : Class ;
  fun Sesame_Class : SubClass Sesame PlantAgriculturalProduct ;

  fun SeychellesRupee : Ind UnitOfCurrency ;

  fun SheaNut : Class ;
  fun SheaNut_Class : SubClass SheaNut EdibleNut ;

  fun Sheep_Livestock : SubClass Sheep Livestock ;

  fun Sheepskin : Class ;
  fun Sheepskin_Class : SubClass Sheepskin Pelt ;

  fun Shellfish : Class ;
  fun Shellfish_Class : SubClass Shellfish Seafood ;

  fun Shrimp : Class ;
  fun Shrimp_Class : SubClass Shrimp Shellfish ;

  fun SierraLeoneLeone : Ind UnitOfCurrency ;

  fun SingaporeDollar : Ind UnitOfCurrency ;

  fun SisalFiber : Class ;
  fun SisalFiber_Class : SubClass SisalFiber PlantAgriculturalProduct ;

  fun SlovakianKoruna : Ind UnitOfCurrency ;

  -- Soap is a Surfactant Cleaning mixture used for 
  -- personal or minor cleaning. It usually comes in solid moulded form. In 
  -- the developed world, synthetic detergents have superseded soap as a 
  -- laundry aid. Many soaps are mixtures of sodium or potassium salts of 
  -- fatty acids which can be derived from oils or fats by reacting them with 
  -- an alkali (such as sodium or potassium hydroxide) at 80_100 degrees Celsius in a 
  -- process known as saponification. (from Wikipedia)
  fun Soap : Class ;
  fun Soap_Class : SubClass Soap Surfactant ;

  -- SocialistEconomy is the Attribute 
  -- used to characterize a country in which there is government ownership 
  -- or direction of the means of production and distribution.
  fun SocialistEconomy : Ind EconomicSystemAttribute ;

  fun SomalianShilling : Ind UnitOfCurrency ;

  fun Sorghum : Class ;
  fun Sorghum_Class : SubClass Sorghum CerealGrass ;

  fun SorghumFarming : Ind IndustryAttribute ;

  fun SorghumGrain : Class ;
  fun SorghumGrain_Class : SubClass SorghumGrain CerealGrain ;

  fun SouthAfricanRand : Ind UnitOfCurrency ;

  fun SouthKoreanWon : Ind UnitOfCurrency ;

  fun Soya : Class ;
  fun Soya_Class : SubClass Soya PlantAgriculturalProduct ;

  fun Soybean : Class ;
  fun Soybean_Class : SubClass Soybean Bean ;

  fun SpanishPeseta : Ind UnitOfCurrency ;

  fun Spice : Class ;
  fun Spice_Class : SubClass Spice (both FruitOrVegetable PlantAgriculturalProduct) ;

  fun SpicePepper : Class ;
  fun SpicePepper_Class : SubClass SpicePepper Spice ;

  fun Squash : Class ;
  fun Squash_Class : SubClass Squash (both GroceryProduce Vegetable) ;

  fun SriLankanRupee : Ind UnitOfCurrency ;

  fun SteelForging : Ind IndustryAttribute ;

  fun SteelFoundriesExceptInvestment : Ind IndustryAttribute ;

  fun SteelIndustry : Ind IndustryAttribute ;

  fun SteelInvestmentFoundries : Ind IndustryAttribute ;

  fun SteelMills : Ind IndustryAttribute ;

  fun SteelProductManufacturingFromPurchasedSteel : Ind IndustryAttribute ;

  fun Steel_MetalProduct : SubClass Steel MetalProduct ;

  fun SubsistenceAgricultureEconomy : Ind FinancialSectorAttribute ;

  fun SudanesePound : Ind UnitOfCurrency ;

  fun SugarBeet : Class ;
  fun SugarBeet_Class : SubClass SugarBeet Vegetable ;

  fun SugarCane : Class ;
  fun SugarCane_Class : SubClass SugarCane (both GroceryProduce Vegetable) ;

  fun Sunflower : Class ;
  fun Sunflower_Class : SubClass Sunflower (both FloweringPlant PlantAgriculturalProduct) ;

  fun SunflowerSeed : Class ;
  fun SunflowerSeed_Class : SubClass SunflowerSeed (both PlantAgriculturalProduct Seed) ;

  fun SupportActivitiesForMetalMining : Ind IndustryAttribute ;

  fun SupportActivitiesForNonmetallicMineralsExceptFuels : Ind IndustryAttribute ;

  fun SupportActivitiesForOilOperations : Ind IndustryAttribute ;

  fun SurinameseGuilder : Ind UnitOfCurrency ;

  fun SwazilandLilangeni : Ind UnitOfCurrency ;

  fun SwedishKrona : Ind UnitOfCurrency ;

  fun SweetPepper : Class ;
  fun SweetPepper_Class : SubClass SweetPepper (both GroceryProduce Vegetable) ;

  fun SweetPotatoTuber : Class ;
  fun SweetPotatoTuber_Class : SubClass SweetPotatoTuber (both EdibleTuber GroceryProduce) ;

  fun SwissFranc : Ind UnitOfCurrency ;

  fun SyrianPound : Ind UnitOfCurrency ;

  fun TaiwanDollar : Ind UnitOfCurrency ;

  fun TajikSomoni : Ind UnitOfCurrency ;

  fun TajikSomoniCoin : Class ;
  fun TajikSomoniCoin_Class : SubClass TajikSomoniCoin CurrencyCoin ;

  fun TajikistaniRuble : Ind UnitOfCurrency ;

  fun TanzanianShilling : Ind UnitOfCurrency ;

  fun TaroTuber : Class ;
  fun TaroTuber_Class : SubClass TaroTuber (both EdibleTuber GroceryProduce) ;

  fun TaxHavenEconomy : Ind FinancialSectorAttribute ;

  fun TeaLeaf : Class ;
  fun TeaLeaf_Class : SubClass TeaLeaf TeaPlantAerialPart ;

  -- TeaPlantAerialPart is the 
  -- class of all parts of the tea plant from which tea may be made, 
  -- including leaves, stems, and twigs.
  fun TeaPlantAerialPart : Class ;
  fun TeaPlantAerialPart_Class : SubClass TeaPlantAerialPart FruitOrVegetable ;

  fun TextileIndustry : Ind IndustryAttribute ;

  fun TextileMills : Ind IndustryAttribute ;

  fun TextileProduct : Class ;
  fun TextileProduct_Class : SubClass TextileProduct (both Artifact ManufacturedProduct) ;

  fun TextileProductMills : Ind IndustryAttribute ;

  fun ThaiBaht : Ind UnitOfCurrency ;

  -- Timber is wood from trees that is 
  -- suitable for use for building or other human purposes.
  fun Timber : Class ;
  fun Timber_Class : SubClass Timber (both CompoundSubstance ForestProduct) ;

  fun TogoFranc : Ind UnitOfCurrency ;

  fun Tomato : Class ;
  fun Tomato_Class : SubClass Tomato (both Fruit GroceryProduce) ;

  fun TonganPaanga : Ind UnitOfCurrency ;

  fun TourismBasedEconomy : Ind FinancialSectorAttribute ;

  -- TourismIndustry is an Attribute that 
  -- describes organizations that provide services or products for travellers 
  -- who stay temporarily in a region to experience local attractions. There 
  -- is an overlap between TourismIndustry and each of the following 
  -- industries: TravelArrangementAndReservationServices, 
  -- TravelerAccommodation, MuseumsHistoricalSitesAndSimilarInstitutions, 
  -- AmusementGamblingAndRecreationIndustries, and
  -- ArtsEntertainmentAndRecreation.
  fun TourismIndustry : Ind IndustryAttribute ;

  fun TradeBasedEconomy : Ind FinancialSectorAttribute ;

  fun TrinidadAndTobagoDollar : Ind UnitOfCurrency ;

  fun TropicalFruit : Class ;
  fun TropicalFruit_Class : SubClass TropicalFruit (both Fruit GroceryProduce) ;

  fun TunisianDinar : Ind UnitOfCurrency ;

  fun TurkeyBird : Class ;
  fun TurkeyBird_Class : SubClass TurkeyBird Poultry ;

  fun TurkeyMeat : Class ;
  fun TurkeyMeat_Class : SubClass TurkeyMeat Meat ;

  fun TurkishLira : Ind UnitOfCurrency ;

  fun TurkmenManat : Ind UnitOfCurrency ;

  fun Turnip : Class ;
  fun Turnip_Class : SubClass Turnip (both GroceryProduce RootVegetable) ;

  fun Turtle : Class ;
  fun Turtle_Class : SubClass Turtle (both Livestock Reptile) ;

  fun TuvaluDollar : Ind UnitOfCurrency ;

  fun TwoTierLaborMarketEconomy : Ind FinancialSectorAttribute ;

  -- UNEconomicDevelopmentLevel 
  -- is a subclass of EconomicDevelopmentLevel containing terms used to 
  -- represent economic development classifications used by UnitedNations 
  -- agencies. The top level of this classification scheme includes the 
  -- concepts of DevelopedCountry, FormerSovietOrEasternEuropeanCountry, 
  -- and LessDevelopedCountry.
  fun UNEconomicDevelopmentLevel : Class ;
  fun UNEconomicDevelopmentLevel_Class : SubClass UNEconomicDevelopmentLevel EconomicDevelopmentLevel ;

  fun UgandanShilling : Ind UnitOfCurrency ;

  fun UkranianHryvnia : Ind UnitOfCurrency ;

  -- UnderdevelopedCountry is an 
  -- Attribute describing less developed countries that have potential 
  -- for above_average economic growth. See also LessDevelopedCountry.
  fun UnderdevelopedCountry : Ind EconomicDevelopmentLevel ;

  fun UnitedArabEmirateDirham : Ind UnitOfCurrency ;

  fun UnitedStatesCentCoin : Class ;
  fun UnitedStatesCentCoin_Class : SubClass UnitedStatesCentCoin CurrencyCoin ;

  fun UnitedStatesDollarBill : Class ;
  fun UnitedStatesDollarBill_Class : SubClass UnitedStatesDollarBill CurrencyBill ;

  fun UnitedStatesFiveCentCoin : Class ;
  fun UnitedStatesFiveCentCoin_Class : SubClass UnitedStatesFiveCentCoin CurrencyCoin ;

  fun UnitedStatesQuarterCoin : Class ;
  fun UnitedStatesQuarterCoin_Class : SubClass UnitedStatesQuarterCoin CurrencyCoin ;

  fun UnitedStatesTenCentCoin : Class ;
  fun UnitedStatesTenCentCoin_Class : SubClass UnitedStatesTenCentCoin CurrencyCoin ;

  -- LowerMiddleIncomeCountry is an Attribute representing the World Bank 
  -- classification for any country where the per capita GNI is 
  -- between 2,996 and 9,266 (inclusive) in UnitedStatesDollars.
  fun UpperMiddleIncomeCountry : Ind WorldBankGNIPerCapitaLevel ;

  fun UruguayanPeso : Ind UnitOfCurrency ;

  fun UzbekistaniSom : Ind UnitOfCurrency ;

  fun Vanilla : Class ;
  fun Vanilla_Class : SubClass Vanilla Spice ;

  fun Veal : Class ;
  fun Veal_Class : SubClass Veal Meat ;

  fun Vegetable : Class ;
  fun Vegetable_Class : SubClass Vegetable FruitOrVegetable ;

  fun VegetableFarming : Ind IndustryAttribute ;

  fun VegetableOil : Class ;
  fun VegetableOil_Class : SubClass VegetableOil PlantAgriculturalProduct ;

  fun VegetableOilIndustry : Ind IndustryAttribute ;

  fun VenezuelanBolivar : Ind UnitOfCurrency ;

  fun VietnameseDong : Ind UnitOfCurrency ;

  fun Walnut : Class ;
  fun Walnut_Class : SubClass Walnut EdibleNut ;

  fun WaterBuffalo : Class ;
  fun WaterBuffalo_Class : SubClass WaterBuffalo (both HoofedMammal Livestock) ;

  fun WaterBuffaloMeat : Class ;
  fun WaterBuffaloMeat_Class : SubClass WaterBuffaloMeat Meat ;

  fun Watermelon : Class ;
  fun Watermelon_Class : SubClass Watermelon Melon ;

  -- WelfareCapitalism is an Attribute 
  -- describing an economy in which the government provides economic subsidies 
  -- to unemployed or disabled individuals.
  fun WelfareCapitalism : Ind EconomicSystemAttribute ;

  fun WesternSamoaNtala : Ind UnitOfCurrency ;

  fun WheatFarming : Ind IndustryAttribute ;

  fun WineGrape : Class ;
  fun WineGrape_Class : SubClass WineGrape PlantAgriculturalProduct ;

  fun WoodProduct : Class ;
  fun WoodProduct_Class : SubClass WoodProduct ForestProduct ;

  fun WoodProductManufacturing : Ind IndustryAttribute ;

  fun WoolFiber : Class ;
  fun WoolFiber_Class : SubClass WoolFiber AnimalAgriculturalProduct ;

  -- WorldBankGNIPerCapitaLevel 
  -- is the subclass of EconomicDevelopmentLevel containing attributes 
  -- that characterize countries according to their per capita gross national 
  -- income (GNI), as determined by the WorldBankGroup. The World Bank 
  -- uses the Atlas method for making cross_country comparisons of national income.
  fun WorldBankGNIPerCapitaLevel : Class ;
  fun WorldBankGNIPerCapitaLevel_Class : SubClass WorldBankGNIPerCapitaLevel EconomicDevelopmentLevel ;

  fun YamTuber : Class ;
  fun YamTuber_Class : SubClass YamTuber (both EdibleTuber GroceryProduce) ;

  fun YemeniRial : Ind UnitOfCurrency ;

  fun YlangYlang : Class ;
  fun YlangYlang_Class : SubClass YlangYlang PerfumeEssence ;

  fun Yugoslavia : Ind Nation ;

  fun YugoslavianDinar : Ind UnitOfCurrency ;

  fun ZaireSezaire : Ind UnitOfCurrency ;

  fun ZambianKwacha : Ind UnitOfCurrency ;

  fun ZimbabweanDollar : Ind UnitOfCurrency ;

  fun ZincIndustry : Ind IndustryAttribute ;

  fun ZincManufacturing : Ind IndustryAttribute ;

  fun ZincOre : Class ;
  fun ZincOre_Class : SubClass ZincOre (both Mineral MiningProduct) ;

  fun ZincOreMining : Ind IndustryAttribute ;

  fun ZincProduct : Class ;
  fun ZincProduct_Class : SubClass ZincProduct (both ManufacturedProduct MetalProduct) ;

  -- (agriculturalProductType ?AREA ?TYPE) means that the 
  -- GeopoliticalArea ?AREA produces a crop or other 
  -- agricultural product of ?TYPE.
  fun agriculturalProductType: El GeopoliticalArea -> Desc Object -> Formula ;

  -- (agriculturalProductTypeByRank ?AREA ?TYPE ?NTH) means that the 
  -- GeopoliticalArea ?AREA produces a crop or other 
  -- agricultural product of ?TYPE, which is its ?NTH most important 
  -- crop.
  fun agriculturalProductTypeByRank: El GeopoliticalArea -> Desc Object -> Desc PositiveInteger -> Formula ;

  -- (annualElectricityConsumption ?AREA ?AMOUNT) means that the 
  -- GeopoliticalArea ?AREA uses ?AMOUNT of electricity (measured in KilowattHours) annually.
  fun annualElectricityConsumption : El GeopoliticalArea -> El PhysicalQuantity -> Formula ;

  -- (annualElectricityExport ?AREA ?AMOUNT) means that the 
  -- GeopoliticalArea ?AREA exported the total ?AMOUNT of 
  -- electricity (measured in KilowattHours) annually.
  fun annualElectricityExport : El GeopoliticalArea -> El PhysicalQuantity -> Formula ;

  -- (annualElectricityImport ?AREA ?AMOUNT) means that the 
  -- GeopoliticalArea ?AREA imported the total ?AMOUNT of 
  -- electricity (measured in KilowattHours) annually.
  fun annualElectricityImport : El GeopoliticalArea -> El PhysicalQuantity -> Formula ;

  -- (annualElectricityProduction ?AREA ?AMOUNT) means that the amount of 
  -- electricity generated annually in the GeographicalArea ?AREA is 
  -- ?AMOUNT, measured in KilowattHours.
  fun annualElectricityProduction : El GeopoliticalArea -> El PhysicalQuantity -> Formula ;

  -- (annualExpendituresOfArea ?AREA ?AMOUNT) means that the annual 
  -- budgetary expenditures of the GeopoliticalArea ?AREA are ?AMOUNT, 
  -- calculated in U.S. dollars according to the currency exchange rate 
  -- method.
  fun annualExpendituresOfArea : El GeopoliticalArea -> El CurrencyMeasure -> Formula ;

  -- (annualExpendituresOfAreaInPeriod ?AREA ?AMOUNT ?PERIOD) means that 
  -- the annual budgetary expenditures of the GeopoliticalArea ?AREA are 
  -- ?AMOUNT for the annual TimeInterval indicated by ?PERIOD, calculated 
  -- in U.S. dollars according to the currency exchange rate method.
  fun annualExpendituresOfAreaInPeriod: El GeopoliticalArea -> El CurrencyMeasure -> Desc TimeInterval -> Formula ;

  -- (annualExportTotal ?AREA ?AMOUNT) means that the total 
  -- value of exports from the GeopoliticalArea ?AREA is ?AMOUNT 
  -- (in UnitedStatesDollars) annually. Export value is calculated 
  -- on a Free on Board (F.O.B.) basis.
  fun annualExportTotal : El GeopoliticalArea -> El CurrencyMeasure -> Formula ;

  -- (annualImportTotal ?AREA ?AMOUNT) means that the total 
  -- value of imports to the GeopoliticalArea ?AREA is ?AMOUNT (in 
  -- UnitedStatesDollars) annually. Import value is calculated on a Cost, 
  -- Insurance, and Freight (C.I.F.) or a Free on Board (F.O.B.) basis.
  fun annualImportTotal : El GeopoliticalArea -> El CurrencyMeasure -> Formula ;

  -- (annualRevenuesOfArea ?AREA ?AMOUNT) means that the annual budgetary 
  -- revenues of the GeopoliticalArea ?AREA are ?AMOUNT, calculated in U.S. 
  -- dollars according to the currency exchange rate method.
  fun annualRevenuesOfArea : El GeopoliticalArea -> El CurrencyMeasure -> Formula ;

  -- (annualRevenuesOfAreaInPeriod ?AREA ?AMOUNT ?PERIOD) means that the 
  -- annual budgetary revenues of the GeopoliticalArea ?AREA are ?AMOUNT 
  -- for the annual TimeInterval indicated by ?PERIOD, calculated in U.S. 
  -- dollars according to the currency exchange rate method.
  fun annualRevenuesOfAreaInPeriod: El GeopoliticalArea -> El CurrencyMeasure -> Desc TimeInterval -> Formula ;

  -- (capitalExpendituresOfArea ?AREA ?AMOUNT) means that the annual 
  -- capital expenditures of the GeopoliticalArea ?AREA are ?AMOUNT, 
  -- calculated in U.S. dollars according to the currency exchange rate 
  -- method. This figure is a portion of the annualExpendituresOfArea 
  -- for ?AREA.
  fun capitalExpendituresOfArea : El GeopoliticalArea -> El CurrencyMeasure -> Formula ;

  -- (capitalExpendituresOfAreaInPeriod ?AREA ?AMOUNT ?PERIOD) means that 
  -- the annual capital expenditures of the GeopoliticalArea ?AREA are 
  -- ?AMOUNT for the annual TimeInterval indicated by ?PERIOD, calculated in 
  -- U.S. dollars according to the currency exchange rate method. This figure 
  -- is a portion of the annualExpendituresOfArea for ?AREA in ?PERIOD.
  fun capitalExpendituresOfAreaInPeriod: El GeopoliticalArea -> El CurrencyMeasure -> Desc TimeInterval -> Formula ;

  -- (currencyCode ?CODE ?UNIT) means 
  -- that ?CODE is the InternationalOrganizationForStandardization 
  -- (ISO) 4217 alphabetic currency code for the national 
  -- CurrencyMeasure ?UNIT.
  fun currencyCode : El SymbolicString -> El UnitOfCurrency -> Formula ;

  -- (currencyExchangePerUSDollar ?AMOUNT ?PERIOD) means that one 
  -- UnitedStatesDollar is worth ?AMOUNT (in a non_U.S. CurrencyMeasure), 
  -- during the TimeInterval indicated by ?PERIOD. The rate of exchange may 
  -- be based either on international market forces or official fiat.
  fun currencyExchangePerUSDollar: El CurrencyMeasure -> Desc TimeInterval -> Formula ;

  -- (currencyExchangeRate ?UNIT ?AMOUNT) means that the currency 
  -- denomination ?UNIT is worth ?AMOUNT (which is in another 
  -- CurrencyMeasure).
  fun currencyExchangeRate : El UnitOfCurrency -> El CurrencyMeasure -> Formula ;

  -- (currencyExchangeRateInPeriod ?UNIT ?AMOUNT ?PERIOD) means that the 
  -- currency denomination ?UNIT is worth ?AMOUNT (which is expressed in another 
  -- UnitOfCurrency) during the TimeInterval indicated by ?PERIOD.
  fun currencyExchangeRateInPeriod: El UnitOfCurrency -> El CurrencyMeasure -> Desc TimeInterval -> Formula ;

  -- (currencyType ?AREA ?UNIT) means 
  -- that the official currency used in the GeopoliticalArea ?AREA 
  -- is the UnitOfMeasure ?UNIT.
  fun currencyType : El GeopoliticalArea -> El UnitOfCurrency -> Formula ;

  -- The currencyValue is a relation between
  -- a physical instrument of currency, such as a bill or coin, and the
  -- measure of its worth in a particular currency.
  fun currencyValue: Desc Currency -> El CurrencyMeasure -> Formula ;

  -- (economicAidDonated ?AGENT ?AMOUNT) means that the GeopoliticalArea 
  -- ?AREA donated ?AMOUNT of aid (valued in U.S. dollars) to developing 
  -- countries and multilateral organizations. This figure covers 'net 
  -- official development assistance' (ODA), which is net financial assistance 
  -- from nations belonging to the 
  -- OrganizationForEconomicCooperationAndDevelopment (OECD), with the main 
  -- goal of promoting economic development and welfare. Such aid contains a 
  -- grant element of at least 25%. This statistic does not cover private 
  -- flows of assistance or other official flows (OOF).
  fun economicAidDonated : El GeopoliticalArea -> El CurrencyMeasure -> Formula ;

  -- (economicAidDonatedInPeriod ?AGENT ?AMOUNT ?PERIOD) means that the 
  -- GeopoliticalArea ?AGENT donated ?AMOUNT of aid (valued in U.S. dollars) 
  -- to developing countries and multilateral organizations during the 
  -- TimeInterval indicated by ?PERIOD. This figure covers 'net official 
  -- development assistance' (ODA), which is net financial assistance from 
  -- nations belonging to the 
  -- OrganizationForEconomicCooperationAndDevelopment (OECD), with the main 
  -- goal of promoting economic development and welfare. Such aid contains a 
  -- grant element of at least 25%. This statistic does not cover private 
  -- flows of assistance or other official flows (OOF).
  fun economicAidDonatedInPeriod: El GeopoliticalArea -> El CurrencyMeasure -> Desc TimeInterval -> Formula ;

  -- (economicAidReceivedNet ?AREA ?AMOUNT) means that the 
  -- GeopoliticalArea ?AREA had a net inflow of Official Development Finance 
  -- (ODF) of ?AMOUNT. ODF includes funds from the World Bank, the IMF, other 
  -- international organizations, and individual donor nations, including both 
  -- grants and loans. The figure includes formal commitments of aid not yet 
  -- disbursed. The figure is the net amount of inflow after deducting 
  -- repayments, valued in U.S. dollars.
  fun economicAidReceivedNet : El GeopoliticalArea -> El CurrencyMeasure -> Formula ;

  -- (economicAidReceivedNetInPeriod ?AREA ?AMOUNT ?PERIOD) means that the 
  -- GeopoliticalArea ?AREA had a net inflow of Official Development Finance 
  -- (ODF) of ?AMOUNT during the TimeInterval indicated by ?PERIOD. ODF 
  -- includes funds from the World Bank, the IMF, other international 
  -- organizations, and individual donor nations, including both grants and 
  -- loans. The figure includes formal commitments of aid not yet disbursed. 
  -- The figure is the net amount of inflow after deducting repayments, 
  -- valued in U.S. dollars.
  fun economicAidReceivedNetInPeriod: El GeopoliticalArea -> El CurrencyMeasure -> Desc TimeInterval -> Formula ;

  -- (economyType ?POLITY ?TYPE) means that the 
  -- GeopoliticalArea ?POLITY has an economic system of TYPE.
  fun economyType : El Agent -> El EconomicAttribute -> Formula ;

  -- (electricityConsumptionInPeriod ?AREA ?AMOUNT ?YEAR) means that 
  -- the GeopoliticalArea ?AREA used ?AMOUNT of electricity (measured in 
  -- KilowattHours) during the TimeInterval indicated by ?YEAR.
  fun electricityConsumptionInPeriod: El GeopoliticalArea -> El PhysicalQuantity -> Desc TimeInterval -> Formula ;

  -- (electricityExportInPeriod ?AREA ?AMOUNT ?PERIOD) means that 
  -- the GeopoliticalArea ?AREA exported the total ?AMOUNT of electricity 
  -- (measured in KilowattHours) during the TimeInterval indicated 
  -- by ?PERIOD.
  fun electricityExportInPeriod: El GeopoliticalArea -> El PhysicalQuantity -> Desc TimeInterval -> Formula ;

  -- (electricityFractionFromSource ?AREA ?SOURCE ?FRACTION) means that in 
  -- the GeopoliticalArea ?AREA, ?SOURCE provides ?FRACTION of the total 
  -- electricity production.
  fun electricityFractionFromSource: El GeopoliticalArea -> Desc PowerGeneration -> El RealNumber -> Formula ;

  -- (electricityFractionFromSourceInPeriod ?AREA ?SOURCE ?FRACTION ?PERIOD) 
  -- means that in the GeopoliticalArea ?AREA, ?SOURCE provides ?FRACTION 
  -- of the total electricity production during the TimeInterval indicated 
  -- by ?PERIOD.
  fun electricityFractionFromSourceInPeriod: El GeopoliticalArea -> Desc PowerGeneration -> El RealNumber -> Desc TimeInterval -> Formula ;

  -- (electricityImportInPeriod ?AREA ?AMOUNT ?PERIOD) means that 
  -- the GeopoliticalArea ?AREA imported the total ?AMOUNT of electricity 
  -- (measured in KilowattHours) during the TimeInterval indicated by ?PERIOD.
  fun electricityImportInPeriod: El GeopoliticalArea -> El PhysicalQuantity -> Desc TimeInterval -> Formula ;

  -- (electricityProductionInPeriod ?AREA ?AMOUNT ?PERIOD) means that the 
  -- GeopoliticalArea ?AREA generates ?AMOUNT of electricity, measured in 
  -- KilowattHours, during the TimeInterval indicated by ?PERIOD.
  fun electricityProductionInPeriod: El GeopoliticalArea -> El PhysicalQuantity -> Desc TimeInterval -> Formula ;

  -- (exportCommodityType ?AREA ?TYPE) means that the GeopoliticalArea 
  -- ?AREA exports the commodity ?TYPE.
  fun exportCommodityType: El GeopoliticalArea -> Desc Object -> Formula ;

  -- (exportCommodityTypeByRank ?AREA ?TYPE ?NTH) means that the 
  -- GeopoliticalArea ?AREA has the commodity ?TYPE as its ?NTH 
  -- most valuable export.
  fun exportCommodityTypeByRank: El GeopoliticalArea -> Desc Object -> El PositiveInteger -> Formula ;

  -- (exportPartner ?AGENT1 ?AGENT2) means that the Agent ?AGENT1 exports goods to the Agent ?AGENT2.
  fun exportPartner : El Agent -> El Agent -> Formula ;

  -- (exportPartnerByFraction ?AREA1 ?AREA2 ?FRACTION) means that 
  -- the GeopoliticalArea ?AREA1 exports goods to GeopoliticalArea 
  -- ?AREA2 and receives ?FRACTION of the exportTotalInPeriod of ?AREA1, 
  -- based on U.S. dollar value of exports.
  fun exportPartnerByFraction : El GeopoliticalArea -> El GeopoliticalArea -> El PositiveRealNumber -> Formula ;

  -- (exportPartnerByFractionInPeriod ?AREA1 ?AREA2 ?FRACTION ?PERIOD) means 
  -- that the GeopoliticalArea ?AREA1 exports goods to GeopoliticalArea 
  -- ?AREA2 and receives ?FRACTION of the exportTotalInPeriod of ?AREA1 
  -- in the TimeInterval ?PERIOD, based on U.S. dollar value of exports.
  fun exportPartnerByFractionInPeriod: El GeopoliticalArea -> El GeopoliticalArea -> El PositiveRealNumber -> Desc TimeInterval -> Formula ;

  -- (exportPartnerByRank ?AREA1 ?AREA2 ?NTH) means that 
  -- the GeopoliticalArea ?AREA1 exports goods to GeopoliticalArea 
  -- ?AREA2 and is the ?NTH most important export partner of ?AREA1, 
  -- based on U.S. dollar value of exports.
  fun exportPartnerByRank : El GeopoliticalArea -> El GeopoliticalArea -> El PositiveInteger -> Formula ;

  -- (exportPartnerByRankInPeriod ?AREA1 ?AREA2 ?NTH ?PERIOD) means that 
  -- the GeopoliticalArea ?AREA1 exports goods to GeopoliticalArea 
  -- ?AREA2 and is the ?NTH most important export partner of ?AREA1, 
  -- in the TimeInterval ?PERIOD, based on U.S. dollar value of exports.
  fun exportPartnerByRankInPeriod: El GeopoliticalArea -> El GeopoliticalArea -> El PositiveInteger -> Desc TimeInterval -> Formula ;

  -- (exportPartnerInPeriod ?AGENT1 ?AGENT2 ?PERIOD) means that the Agent 
  -- ?AGENT1 exports goods to the Agent ?AGENT2 during the TimeInterval 
  -- indicated by ?PERIOD.
  fun exportPartnerInPeriod: El Agent -> El Agent -> Desc TimeInterval -> Formula ;

  -- (exportTotalInPeriod ?AREA ?AMOUNT ?PERIOD) means that the 
  -- total value of exports from the GeopoliticalArea ?AREA is ?AMOUNT 
  -- (in UnitedStatesDollars) for the TimeInterval indicated by ?PERIOD. 
  -- Export value is calculated on a Free on Board (F.O.B.) basis.
  fun exportTotalInPeriod: El GeopoliticalArea -> El CurrencyMeasure -> Desc TimeInterval -> Formula ;

  -- (externalDebt ?COUNTRY ?AMOUNT) means 
  -- that the GeopoliticalArea ?COUNTRY owes the total sum ?AMOUNT of debt 
  -- (public and private) to nonresidents. The amount is valued in U.S. 
  -- dollars but may be repayable in foreign currency, goods, or services.
  fun externalDebt : El GeopoliticalArea -> El CurrencyMeasure -> Formula ;

  -- (externalDebtInPeriod ?COUNTRY ?AMOUNT ?PERIOD) means that the 
  -- GeopoliticalArea ?COUNTRY owes the total sum ?AMOUNT of debt (public 
  -- and private) to nonresidents during the TimeInterval indicated by 
  -- ?PERIOD. The amount is valued in U.S. dollars but may be repayable in 
  -- foreign currency, goods, or services.
  fun externalDebtInPeriod: El GeopoliticalArea -> El CurrencyMeasure -> Desc TimeInterval -> Formula ;

  -- The predicate fiscalYearPeriod 
  -- indicates the period that an Agent or Organization uses as its 
  -- 12_month accounting period. (fiscalYearPeriod ?AGENT Year) means 
  -- that ?AGENT observes its 12_month accounting period during the 
  -- regular calendar year (CY), from January to December. For 
  -- fiscal years with other beginning and ending months (FYs), use 
  -- (fiscalYearPeriod ?AGENT (RecurrentTimeIntervalFn ?STARTMONTH ?ENDMONTH)). 
  -- For example, (fiscalYearPeriod (GovernmentFn UnitedStates) 
  -- (RecurrentTimeIntervalFn October September)). For FYs that begin 
  -- or end mid_month, days may be specified within RecurrentTimeIntervalFn.
  fun fiscalYearPeriod: El Agent -> Desc TimeInterval -> Formula ;

  -- (highestDecileShareOfHouseholdIncome ?AREA ?FRACTION) means that 
  -- in the GeopoliticalArea ?AREA, the highest decile (90_100%) of 
  -- households with respect to household income (or consumption) had 
  -- ?FRACTION amount of the total household income (or consumption). 
  -- Data from different countries may not be directly comparable due to 
  -- variation in the basis of the data (e.g., based on income versus 
  -- based on consumption).
  fun highestDecileShareOfHouseholdIncome : El GeopoliticalArea -> El RealNumber -> Formula ;

  -- (highestDecileShareOfHouseholdIncomeInPeriod ?AREA ?FRACTION ?PERIOD) 
  -- means that in the GeopoliticalArea ?AREA, the highest decile (90_100%) 
  -- of households with respect to household income (or consumption) had 
  -- ?FRACTION amount of the total household income (or consumption), during 
  -- the TimeInterval indicated by ?PERIOD. Data from different countries 
  -- may not be directly comparable due to variation in the basis of the data 
  -- (e.g., based on household income versus based on household consumption).
  fun highestDecileShareOfHouseholdIncomeInPeriod: El GeopoliticalArea -> El RealNumber -> Desc TimeInterval -> Formula ;

  -- (importCommodityType ?AREA ?TYPE) means that the GeopoliticalArea 
  -- ?AREA imports the commodity ?TYPE.
  fun importCommodityType: El GeopoliticalArea -> Desc Object -> Formula ;

  -- (importCommodityTypeByRank ?AREA ?TYPE ?NTH) means that the 
  -- GeopoliticalArea ?AREA has the commodity ?TYPE as its ?NTH 
  -- most valuable import.
  fun importCommodityTypeByRank: El GeopoliticalArea -> Desc Object -> El PositiveInteger -> Formula ;

  -- (importPartner ?AGENT1 ?AGENT2) means 
  -- that the Agent ?AGENT1 imports goods from the Agent ?AGENT2.
  fun importPartner : El Agent -> El Agent -> Formula ;

  -- (importPartnerByFraction ?AREA1 ?AREA2 ?FRACTION) means that 
  -- the GeopoliticalArea ?AREA1 imports goods from GeopoliticalArea 
  -- ?AREA2 and provides ?FRACTION of the importTotalInPeriod of ?AREA1, 
  -- based on U.S. dollar value of imports.
  fun importPartnerByFraction : El GeopoliticalArea -> El GeopoliticalArea -> El PositiveRealNumber -> Formula ;

  -- (importPartnerByFractionInPeriod ?AREA1 ?AREA2 ?FRACTION ?PERIOD) means 
  -- that the GeopoliticalArea ?AREA1 imports goods from GeopoliticalArea 
  -- ?AREA2 and provides ?FRACTION of the importTotalInPeriod of ?AREA1 
  -- during the TimeInterval ?PERIOD, in U.S. dollar value of imports.
  fun importPartnerByFractionInPeriod: El GeopoliticalArea -> El GeopoliticalArea -> El PositiveRealNumber -> Desc TimeInterval -> Formula ;

  -- (importPartnerByRank ?AREA1 ?AREA2 ?NTH) means that 
  -- the GeopoliticalArea ?AREA1 imports goods from GeopoliticalArea 
  -- ?AREA2 is the ?NTH most important import partner of ?AREA1, based on 
  -- U.S. dollar value of imports.
  fun importPartnerByRank : El GeopoliticalArea -> El GeopoliticalArea -> El PositiveInteger -> Formula ;

  -- (importPartnerByRankInPeriod ?AREA1 ?AREA2 ?NTH ?PERIOD) means that 
  -- the GeopoliticalArea ?AREA1 imports goods from GeopoliticalArea 
  -- ?AREA2 is the ?NTH most important import partner of ?AREA1 during 
  -- the TimeInterval ?PERIOD, based on U.S. dollar value of imports.
  fun importPartnerByRankInPeriod: El GeopoliticalArea -> El GeopoliticalArea -> El PositiveInteger -> Desc TimeInterval -> Formula ;

  -- (importPartnerInPeriod ?AGENT1 ?AGENT2 ?PERIOD) means that the Agent 
  -- ?AGENT1 imports goods from the Agent ?AGENT2 during the TimeInterval 
  -- indicated by ?PERIOD.
  fun importPartnerInPeriod: El Agent -> El Agent -> Desc TimeInterval -> Formula ;

  -- (importTotalInPeriod ?AREA ?AMOUNT ?PERIOD) means that the 
  -- total value of imports to the GeopoliticalArea ?AREA is ?AMOUNT 
  -- (in UnitedStatesDollars) for the TimeInterval indicated by ?PERIOD. 
  -- Import value is calculated on a Cost, Insurance, and Freight (C.I.F.) 
  -- or a Free on Board (F.O.B.) basis.
  fun importTotalInPeriod: El GeopoliticalArea -> El CurrencyMeasure -> Desc TimeInterval -> Formula ;

  -- (incomeDistributionByGiniIndex ?AREA ?INDEX) means that in the 
  -- GeopoliticalArea ?AREA, the distribution of family income is ?INDEX, 
  -- as measured by the Gini index for family income distribution.
  fun incomeDistributionByGiniIndex : El GeopoliticalArea -> El NonnegativeRealNumber -> Formula ;

  -- (incomeDistributionByGiniIndexInPeriod ?AREA ?INDEX ?PERIOD) means that 
  -- in the GeopoliticalArea ?AREA, the distribution of family income is 
  -- ?INDEX, as measured by the Gini index, during the TimeInterval indicated 
  -- by ?PERIOD.
  fun incomeDistributionByGiniIndexInPeriod: El GeopoliticalArea -> El NonnegativeRealNumber -> Desc TimeInterval -> Formula ;

  -- (industrialProductionGrowthRate ?AREA ?RATE) means that in 
  -- the GeopoliticalArea ?AREA, the annual percentage increase in 
  -- industrial production is ?RATE.
  fun industrialProductionGrowthRate : El GeopoliticalArea -> El RealNumber -> Formula ;

  -- (industrialProductionGrowthRateInPeriod ?AREA ?RATE ?PERIOD) means 
  -- that in the GeopoliticalArea ?AREA, the annual percentage increase in 
  -- industrial production is ?RATE, for the TimeInterval ?PERIOD.
  fun industrialProductionGrowthRateInPeriod: El GeopoliticalArea -> El RealNumber -> Desc TimeInterval -> Formula ;

  -- (industryOfArea ?AREA ?SECTOR) means that the GeopoliticalArea ?AREA produces 
  -- goods or services in the economic area ?SECTOR.
  fun industryOfArea : El GeopoliticalArea -> El IndustryAttribute -> Formula ;

  -- (industryProductType ?INDUSTRY ?TYPE) means that organizations with 
  -- the IndustryAttribute ?INDUSTRY produce products of the kind ?TYPE.
  fun industryProductType: El IndustryAttribute -> Desc Object -> Formula ;

  -- (industryRankByOutput ?AREA ?SECTOR ?NTH) means that in the 
  -- GeopoliticalArea ?AREA, the economic area ?SECTOR is ?NTH with 
  -- respect to the value of its annual output.
  fun industryRankByOutput : El GeopoliticalArea -> El IndustryAttribute -> El PositiveInteger -> Formula ;

  -- (industryServiceType ?INDUSTRY ?TYPE) means that organizations with 
  -- the IndustryAttribute ?INDUSTRY provide services of the kind ?TYPE.
  fun industryServiceType: El IndustryAttribute -> Desc IntentionalProcess -> Formula ;

  -- (inflationRateOfConsumerPrices ?AREA ?FRACTION) means that in the 
  -- GeopoliticalArea ?AREA, the annual change in consumer prices was 
  -- ?FRACTION, compared with prices from the previous year.
  fun inflationRateOfConsumerPrices : El GeopoliticalArea -> El RealNumber -> Formula ;

  -- (inflationRateOfConsumerPricesInPeriod ?AREA ?FRACTION ?PERIOD) means 
  -- that in the GeopoliticalArea ?AREA, the annual change in consumer 
  -- prices was ?FRACTION, for the TimeInterval indicated by ?PERIOD, 
  -- compared with prices from the prior period.
  fun inflationRateOfConsumerPricesInPeriod: El GeopoliticalArea -> El RealNumber -> Desc TimeInterval -> Formula ;

  -- (laborForceFractionByOccupation ?AREA ?SECTOR ?FRACTION) 
  -- means that in the GeopoliticalArea ?AREA, workers in the job area 
  -- ?SECTOR make up ?FRACTION of the labor force. The unemployed are not 
  -- included in these figures. Occupation may be indicated by an 
  -- OccupationalRole or an IndustryAttribute.
  fun laborForceFractionByOccupation : El GeopoliticalArea -> El Attribute -> El RealNumber -> Formula ;

  -- (laborForceFractionByOccupationInPeriod ?AREA ?SECTOR ?FRACTION ?PERIOD) 
  -- means that in the GeopoliticalArea ?AREA, workers in the job area 
  -- ?SECTOR make up ?FRACTION of the labor force, during the TimeInterval 
  -- indicated by ?PERIOD. The unemployed are not included in these figures. 
  -- Occupation may be indicated by an OccupationalRole or an 
  -- IndustryAttribute.
  fun laborForceFractionByOccupationInPeriod: El GeopoliticalArea -> El Attribute -> El RealNumber -> Desc TimeInterval -> Formula ;

  -- (laborForceTotal ?AREA ?AMOUNT) means that the total labor 
  -- force of the GeopoliticalArea ?AREA is ?AMOUNT. This includes 
  -- unemployed workers.
  fun laborForceTotal : El GeopoliticalArea -> El NonnegativeRealNumber -> Formula ;

  -- (laborForceTotalInPeriod ?AREA ?AMOUNT ?PERIOD) means that the total 
  -- labor force of the GeopoliticalArea ?AREA is ?AMOUNT during the 
  -- TimeInterval indicated by ?PERIOD. This includes unemployed workers.
  fun laborForceTotalInPeriod: El GeopoliticalArea -> El NonnegativeRealNumber -> Desc TimeInterval -> Formula ;

  -- (lowestDecileShareOfHouseholdIncome ?AREA ?FRACTION) means that 
  -- in the GeopoliticalArea ?AREA, the lowest decile (0_10%) of 
  -- households with respect to household income (or consumption) had 
  -- ?FRACTION amount of the total household income (or consumption). 
  -- Data from different countries may not be directly comparable due to 
  -- variation in the basis of the data (e.g., based on income versus based 
  -- on consumption).
  fun lowestDecileShareOfHouseholdIncome : El GeopoliticalArea -> El RealNumber -> Formula ;

  -- (lowestDecileShareOfHouseholdIncomeInPeriod ?AREA ?FRACTION ?PERIOD) 
  -- means that in the GeopoliticalArea ?AREA, the lowest decile (0_10%) 
  -- of households with respect to household income (or consumption) had 
  -- ?FRACTION amount of the total household income (or consumption), during 
  -- the TimeInterval indicated by ?PERIOD. Data from different countries 
  -- may not be directly comparable due to variation in the basis of the data 
  -- (e.g., based on household income versus based on household consumption).
  fun lowestDecileShareOfHouseholdIncomeInPeriod: El GeopoliticalArea -> El RealNumber -> Desc TimeInterval -> Formula ;

  -- (organizationProductType ?BUSINESS ?TYPE) means that the Organization 
  -- ?BUSINESS produces products of the kind ?TYPE.
  fun organizationProductType: El Organization -> Desc Object -> Formula ;

  -- (organizationServiceType ?BUSINESS ?TYPE) means that the Organization 
  -- ?BUSINESS provides services of the kind ?TYPE.
  fun organizationServiceType: El Organization -> Desc IntentionalProcess -> Formula ;

  -- (perCapitaGDP ?AREA ?AMOUNT) means 
  -- that the Gross Domestic Product, on a per capita basis, for the 
  -- GeopoliticalArea ?AREA is ?AMOUNT, calculated in U.S. dollars on a 
  -- purchasing power parity basis. See PPPBasedEconomicValuation.
  fun perCapitaGDP : El GeopoliticalArea -> El CurrencyMeasure -> Formula ;

  -- (perCapitaGDPInPeriod ?AREA ?AMOUNT ?PERIOD) means that the Gross 
  -- Domestic Product, on a per capita basis, for the GeopoliticalArea 
  -- ?AREA is ?AMOUNT during the period indicated by ?PERIOD, calculated in 
  -- U.S. dollars on a purchasing power parity basis. See 
  -- PPPBasedEconomicValuation.
  fun perCapitaGDPInPeriod: El GeopoliticalArea -> El CurrencyMeasure -> Desc TimeInterval -> Formula ;

  -- (populationFractionBelowPovertyLine ?AREA ?FRACTION) means that in 
  -- the GeopoliticalArea ?AREA, the segment of the population living 
  -- below the (locally defined) poverty line is ?FRACTION. Note that the 
  -- definition of the poverty line varies internationally.
  fun populationFractionBelowPovertyLine : El GeopoliticalArea -> El RealNumber -> Formula ;

  -- (populationFractionBelowPovertyLineInPeriod ?AREA ?FRACTION ?PERIOD) 
  -- means that in the GeopoliticalArea ?AREA, the segment of the population 
  -- living below the (locally defined) poverty line is ?FRACTION during the 
  -- TimeInterval indicated by ?PERIOD. Note that the definition of the 
  -- poverty line varies internationally.
  fun populationFractionBelowPovertyLineInPeriod: El GeopoliticalArea -> El RealNumber -> Desc TimeInterval -> Formula ;

  -- (realGrowthRateOfGDP ?AREA ?RATE) 
  -- means that the annual rate of growth in the Gross Domestic Product (GDP) 
  -- for the GeopoliticalArea ?AREA is the fraction ?RATE, adjusted for 
  -- inflation, with GDP calculated on a purchasing power parity basis. 
  -- See PPPBasedEconomicValuation.
  fun realGrowthRateOfGDP : El GeopoliticalArea -> El RealNumber -> Formula ;

  -- (realGrowthRateOfGDPInPeriod ?AREA ?RATE ?PERIOD) means that the 
  -- annual rate of growth in the Gross Domestic Product (GDP) for the 
  -- GeopoliticalArea ?AREA is the fraction ?RATE in the period ?PERIOD, 
  -- adjusted for inflation, with GDP calculated on a purchasing power 
  -- parity basis. See PPPBasedEconomicValuation.
  fun realGrowthRateOfGDPInPeriod: El GeopoliticalArea -> El RealNumber -> Desc TimeInterval -> Formula ;

  -- (resultType ?PROCESS ?TYPE) means that 
  -- the Process ?PROCESS produces some result(s) of the type ?TYPE.
  fun resultType: El Process -> Desc Object -> Formula ;

  -- (sectorCompositionOfGDP ?AREA ?SECTOR ?FRACTION) means 
  -- that in the GeopoliticalArea ?AREA, the economic sector ?SECTOR 
  -- contributes the amount ?FRACTION to the Gross National Product.
  fun sectorCompositionOfGDP : El GeopoliticalArea -> El IndustryAttribute -> El RealNumber -> Formula ;

  -- (sectorCompositionOfGDPInPeriod ?AREA ?SECTOR ?FRACTION ?PERIOD) 
  -- means that in the GeopoliticalArea ?AREA, the economic sector ?SECTOR 
  -- contributes the amount ?FRACTION to the Gross National Product 
  -- during the TimeInterval indicated by ?PERIOD.
  fun sectorCompositionOfGDPInPeriod: El GeopoliticalArea -> El IndustryAttribute -> El RealNumber -> Desc TimeInterval -> Formula ;

  -- (sectorValueOfGDP ?AREA ?SECTOR ?AMOUNT) means that for the 
  -- GeopoliticalArea ?AREA, the economic sector ?SECTOR contributes 
  -- ?AMOUNT to the Gross National Product, evaluated in U.S. dollars on 
  -- a purchasing power parity basis. See PPPBasedEconomicValuation.
  fun sectorValueOfGDP : El GeopoliticalArea -> El IndustryAttribute -> El CurrencyMeasure -> Formula ;

  -- (sectorValueOfGDPInPeriod ?AREA ?SECTOR ?AMOUNT ?PERIOD) means that 
  -- for the GeopoliticalArea ?AREA, the economic sector ?SECTOR contributes 
  -- ?AMOUNT to the Gross National Product during the TimeInterval indicated 
  -- by ?PERIOD, evaluated in U.S. dollars on a purchasing power parity basis. 
  -- See PPPBasedEconomicValuation.
  fun sectorValueOfGDPInPeriod: El GeopoliticalArea -> El IndustryAttribute -> El CurrencyMeasure -> Desc TimeInterval -> Formula ;

  -- (totalGDP ?AREA ?AMOUNT) means that the value 
  -- of all final goods and services produced within the GeopoliticalArea 
  -- ?AREA is ?AMOUNT, in U.S. dollars, calculated on a purchasing power parity 
  -- basis. This represents Gross Domestic Product (GDP). See 
  -- PPPBasedEconomicValuation.
  fun totalGDP : El GeopoliticalArea -> El CurrencyMeasure -> Formula ;

  -- (totalGDPInPeriod ?AREA ?AMOUNT ?PERIOD) 
  -- means that the value of all final goods and services produced within 
  -- the GeopoliticalArea ?AREA is ?AMOUNT in the period indicated by ?PERIOD, 
  -- measured in U.S. dollars calculated on a purchasing power parity basis. 
  -- (See PPPBasedEconomicValuation.) This is the Gross Domestic Product for 
  -- ?AREA for a specified period.
  fun totalGDPInPeriod: El GeopoliticalArea -> El CurrencyMeasure -> Desc TimeInterval -> Formula ;

  -- (unemploymentRateOfArea ?AREA ?RATE ?PERIOD) means that the 
  -- unemployment rate in the GeographicalArea ?AREA is ?RATE, 
  -- during the TimeInterval indicated by ?PERIOD.
  fun unemploymentRateOfArea: El GeopoliticalArea -> El RealNumber -> Desc TimeInterval -> Formula ;

  -- (unemploymentRateOfAreaInPeriod ?AREA ?RATE ?PERIOD) means that the 
  -- unemployment rate in the GeographicalArea ?AREA is ?RATE, during the 
  -- TimeInterval indicated by ?PERIOD.
  fun unemploymentRateOfAreaInPeriod: El GeopoliticalArea -> El RealNumber -> Desc TimeInterval -> Formula ;

}
