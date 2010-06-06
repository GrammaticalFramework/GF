abstract Merge = Basic ** {

  -- Any AnatomicalStructure which 
  -- is not normally found in the Organism of which it is a part, i.e. it is 
  -- the result of a PathologicProcess. This class covers tumors, birth marks, 
  -- goiters, etc.
  fun AbnormalAnatomicalStructure  : Class ;
  fun AbnormalAnatomicalStructure_Class : SubClass AbnormalAnatomicalStructure AnatomicalStructure ;

  -- This is a PositionalAttribute derived from the 
  -- up/down schema and not involving contact. Note that this means directly 
  -- above, i.e., if one object is Above another object, then the projections 
  -- of the two objects overlap.
  fun Above  : Ind AntiSymmetricPositionalAttribute ;

  -- The value of (AbsoluteValueFn ?NUMBER) 
  -- is the absolute value of the RealNumber ?NUMBER.
  fun AbsoluteValueFn  : El RealNumber -> Ind NonnegativeRealNumber ;

  -- Properties or qualities as distinguished from any 
  -- particular embodiment of the properties/qualities in a physical medium. 
  -- Instances of Abstract can be said to exist in the same sense as mathematical 
  -- objects such as sets and relations, but they cannot exist at a particular 
  -- place and time without some physical encoding or embodiment.
  fun Abstract  : Class ;
  fun Abstract_Class : SubClass Abstract Entity ;

  -- A UnaryFunction that maps a Class into 
  -- the instance of Attribute that specifies the condition(s) for membership 
  -- in the Class.
  fun AbstractionFn  : Class -> Ind Attribute ;

  -- If ?NUMBER1 and ?NUMBER2 are Numbers, then 
  -- (AdditionFn ?NUMBER1 ?NUMBER2) is the arithmetical sum of these 
  -- numbers.
  fun AdditionFn  : El Quantity -> El Quantity -> Ind Quantity ;

  -- Used to assert that an object ?OBJ1 is close 
  -- to, near or abutting ?OBJ2. This PositionalAttribute covers the 
  -- following common sense notions: adjoins, abuts, is contiguous to, 
  -- is juxtaposed, and is close to.
  fun Adjacent  : Ind SymmetricPositionalAttribute ;

  -- One of the parts of speech. The Class of 
  -- Words that conventionally denote Attributes of Objects.
  fun Adjective  : Class ;
  fun Adjective_Class : SubClass Adjective Word ;

  -- One of the parts of speech. The Class of Words 
  -- that conventionally denote Attributes of Processes.
  fun Adverb  : Class ;
  fun Adverb_Class : SubClass Adverb Word ;

  -- A Disseminating whose purpose is to 
  -- promote the sale of an Object represented in a Text or Icon 
  -- (the advertisement).
  fun Advertising  : Class ;
  fun Advertising_Class : SubClass Advertising Disseminating ;

  -- A GroupOfPeople whose members all have the 
  -- same age.
  fun AgeGroup  : Class ;
  fun AgeGroup_Class : SubClass AgeGroup GroupOfPeople ;

  -- Something or someone that can act on its own and 
  -- produce changes in the world.
  fun Agent  : Class ;
  fun Agent_Class : SubClass Agent Object ;

  -- Air is the gaseous stuff that makes up the 
  -- atmosphere surrounding Earth.
  fun Air  : Class ;
  fun Air_Class : SubClass Air GasMixture ;

  -- A Class containing all of the Attributes 
  -- relating to the notions of possibility and necessity.
  fun AlethicAttribute  : Class ;
  fun AlethicAttribute_Class : SubClass AlethicAttribute ObjectiveNorm ;

  -- A chiefly aquatic plant that contains chlorophyll, 
  -- but does not form embryos during development and lacks vascular tissue.
  fun Alga  : Class ;
  fun Alga_Class : SubClass Alga NonFloweringPlant ;

  -- Any BodyMotion which is accomplished by 
  -- means of the legs of an Animal for the purpose of moving from one 
  -- point to another.
  fun Ambulating  : Class ;
  fun Ambulating_Class : SubClass Ambulating (both BodyMotion Translocation) ;

  -- SI electric current measure. Symbol: A. It is 
  -- one of the base units in SI. It is defined as follows: the Ampere is 
  -- that constant current which, if maintained in two straight parallel 
  -- conductors of infinite length, of negligible circular cross_section, and 
  -- placed 1 Meter apart in a vacuum, would produce between these conductors 
  -- a force equal to 2*10^(_7) Newton per Meter of length.
  fun Ampere  : Ind CompositeUnitOfMeasure ;

  -- A cold_blooded, smooth_skinned Vertebrate 
  -- which characteristically hatches as an aquatic larva, breathing by 
  -- gills. When mature, the Amphibian breathes with Lungs.
  fun Amphibian  : Class ;
  fun Amphibian_Class : SubClass Amphibian ColdBloodedVertebrate ;

  -- Atomic mass unit. Symbol: u. It is the mass of 
  -- the twelfth part of an atom of the Carbon 12 isotope.
  fun Amu  : Ind UnitOfMass ;

  -- A normal or pathological part 
  -- of the anatomy or structural organization of an Organism. This 
  -- class covers BodyParts, as well as structures that are given off 
  -- by Organisms, e.g. ReproductiveBodies.
  fun AnatomicalStructure  : Class ;
  fun AnatomicalStructure_Class : SubClass AnatomicalStructure OrganicObject ;

  -- The value of an angle in a plane or in a 
  -- solid.
  fun AngleMeasure  : Class ;
  fun AngleMeasure_Class : SubClass AngleMeasure ConstantQuantity ;

  -- The Angstrom is a LengthMeasure. 
  -- 1 Angstrom = 10^(_10) m
  fun Angstrom  : Ind UnitOfLength ;

  -- A plane angle measure.
  fun AngularDegree  : Ind UnitOfAngularMeasure ;

  -- Attributes that indicate whether an 
  -- Organism is alive or not.
  fun AnimacyAttribute  : Class ;
  fun AnimacyAttribute_Class : SubClass AnimacyAttribute BiologicalAttribute ;

  -- An Organism with eukaryotic Cells, and lacking 
  -- stiff cell walls, plastids, and photosynthetic pigments.
  fun Animal  : Class ;
  fun Animal_Organism  : SubClassC Animal Organism (\ANIMAL -> and (forall AnimalSubstance (\SUBSTANCE -> part(var AnimalSubstance Object ? SUBSTANCE)(var Organism Object ? ANIMAL))) (forall AnimalAnatomicalStructure (\STRUCTURE -> part(var AnimalAnatomicalStructure Object ? STRUCTURE)(var Organism Object ? ANIMAL)))) ;

  -- AnatomicalStructures that 
  -- are possessed exclusively by Animals.
  fun AnimalAnatomicalStructure  : Class ;
  fun AnimalAnatomicalStructure_Class : SubClass AnimalAnatomicalStructure AnatomicalStructure ;

  -- The subclass of Languages used by 
  -- Animals other than Humans.
  fun AnimalLanguage  : Class ;
  fun AnimalLanguage_Class : SubClass AnimalLanguage Language ;

  -- BodySubstances that are produced 
  -- exclusively by Animals.
  fun AnimalSubstance  : Class ;
  fun AnimalSubstance_Class : SubClass AnimalSubstance BodySubstance ;

  -- AntiSymmetricPositionalAttribute is the class of 
  -- PositionalAttribute that hold in only one direction. I.e. two objects cannot
  -- simulataneously be On each other.
  fun AntiSymmetricPositionalAttribute  : Class ;
  fun AntiSymmetricPositionalAttribute_Class : SubClass AntiSymmetricPositionalAttribute PositionalAttribute ;

  -- Various Primates with no tails or only short 
  -- tails.
  fun Ape  : Class ;
  fun Ape_Class : SubClass Ape Primate ;

  -- The Class of all Months which are April.
  fun April  : Class ;
  fun April_Class : SubClass April Month ;

  -- The Class of Mammals that dwell chiefly 
  -- in the water. Includes whales, dolphins, manatees, seals, and walruses.
  fun AquaticMammal  : Class ;
  fun AquaticMammal_Class : SubClass AquaticMammal Mammal ;

  -- A Class of Arthropods that includes 
  -- ticks and spiders.
  fun Arachnid  : Class ;
  fun Arachnid_Class : SubClass Arachnid Arthropod ;

  -- Measures of the amount of space in two 
  -- dimensions.
  fun AreaMeasure  : Class ;
  fun AreaMeasure_Class : SubClass AreaMeasure FunctionQuantity ;

  -- Any proposition which has the form of a deductive 
  -- or inductive argument, i.e. a set of premises which, it is claimed, imply 
  -- a conclusion.
  fun Argument  : Class ;
  fun Argument_Class : SubClass Argument Proposition ;

  -- Artifacts that are created primarily for 
  -- aesthetic appreciation. Note that this Class does not include 
  -- most examples of architecture, which belong under StationaryArtifact.
  fun ArtWork  : Class ;
  fun ArtWork_Class : SubClass ArtWork Artifact ;

  -- A Class of Invertebrate that includes 
  -- Arachnids and Insects.
  fun Arthropod  : Class ;
  fun Arthropod_Class : SubClass Arthropod Invertebrate ;

  -- A relatively short Text that either is unbound or is 
  -- bound with other Articles in a Book.
  fun Article  : Class ;
  fun Article_Class : SubClass Article Text ;

  -- A CorpuscularObject that is the product of a 
  -- Making.
  fun Artifact  : Class ;
  fun Artifact_Class : SubClass Artifact CorpuscularObject ;

  -- The subclass of Languages that are 
  -- designed by Humans.
  fun ArtificialLanguage  : Class ;
  fun ArtificialLanguage_Class : SubClass ArtificialLanguage Language ;

  -- Asexual Processes of biological 
  -- reproduction.
  fun AsexualReproduction  : Class ;
  fun AsexualReproduction_Class : SubClass AsexualReproduction Replication ;

  -- Attribute that applies to Organisms that are 
  -- sleeping.
  fun Asleep  : Ind ConsciousnessAttribute ;

  -- The Class of all astronomical 
  -- objects of significant size. It includes SelfConnectedObjects 
  -- like planets, stars, and asteroids, as well as Collections like 
  -- nebulae, galaxies, and constellations. Note that the planet Earth 
  -- is an AstronomicalBody, but every Region of Earth is a 
  -- GeographicArea.
  fun AstronomicalBody  : Class ;
  fun AstronomicalBody_Class : SubClass AstronomicalBody Region ;

  -- An extremely small unit of matter that retains its 
  -- identity in Chemical reactions. It consists of an AtomicNucleus and 
  -- Electrons surrounding the AtomicNucleus.
  fun Atom  : Class ;
  fun Atom_Class : SubClass Atom ElementalSubstance ;

  -- MassMeasure that is also known as the gram_atom. 
  -- Defined as the mass in grams of 1 Mole of pure substance. For example, 
  -- 1 AtomGram of Carbon 12 will be 12 Grams of pure Carbon 12. 2 AtomGrams 
  -- of the same substance will be 24 Grams of it. This is an unusual unit in 
  -- that it is essentially 1 Mole of 'stuff' measured in grams, so that the 
  -- actual value (i.e. mass) depends on the type of substance.
  fun AtomGram  : Ind UnitOfMass ;

  -- The core of the Atom. It is composed of 
  -- Protons and Neutrons.
  fun AtomicNucleus  : Class ;
  fun AtomicNucleus_Class : SubClass AtomicNucleus SubatomicParticle ;

  -- A Process where one Object becomes attached 
  -- to another Object. Note that this differs from Putting in that two 
  -- things which are attached may already be in the same location. Note that 
  -- Combining is different from Attaching in that the former applies to 
  -- Substances, while the latter applies to CorpuscularObjects. Note too 
  -- that Attaching is different from Putting in that one or both of the 
  -- two things which are attached may or may not be moved from the location 
  -- where they were combined.
  fun Attaching  : Class ;
  fun Attaching_Class : SubClass Attaching DualObjectProcess ;

  -- A Device whose purpose is to attach one thing 
  -- to something else, e.g. nails, screws, buttons, etc.
  fun AttachingDevice  : Class ;
  fun AttachingDevice_Class : SubClass AttachingDevice Device ;

  -- A Maneuver in a ViolentContest where the 
  -- agent attempts to inflict damage on the patient.
  fun Attack  : Class ;
  fun Attack_Class : SubClass Attack Maneuver ;

  -- Qualities which we cannot or choose not to 
  -- reify into subclasses of Object.
  fun Attribute  : Class ;
  fun Attribute_Class : SubClass Attribute Abstract ;

  -- A sound level capable of being heard by a Human.
  fun Audible  : Ind SoundAttribute ;

  -- The Class of all Months which are August.
  fun August  : Class ;
  fun August_Class : SubClass August Month ;

  -- The class of PhysiologicProcesses of 
  -- which there is not conscious awareness and control.
  fun AutonomicProcess  : Class ;
  fun AutonomicProcess_Class : SubClass AutonomicProcess PhysiologicProcess ;

  -- Attribute that applies to Organisms that are 
  -- neither Unconscious nor Asleep.
  fun Awake  : Ind ConsciousnessAttribute ;

  -- A Function that maps an Object to the side 
  -- that is opposite the FrontFn of the Object. Note that this is a 
  -- partial function, since some Objects do not have sides, e.g. apples 
  -- and spheres. Note too that the range of this Function is indefinite in 
  -- much the way that ImmediateFutureFn and ImmediatePastFn are indefinite. 
  -- Although this indefiniteness is undesirable from a theoretical standpoint, 
  -- it does not have significant practical implications, since there is 
  -- widespread intersubjective agreement about the most common cases.
  fun BackFn  : El SelfConnectedObject -> Ind SelfConnectedObject ;

  -- A small, typically one_celled, prokaryotic 
  -- Microorganism.
  fun Bacterium  : Class ;
  fun Bacterium_Class : SubClass Bacterium Microorganism ;

  -- A ViolentContest between two or more military 
  -- units within the context of a war. Note that this does not cover the 
  -- metaphorical sense of 'battle', which simply means a struggle of some 
  -- sort. This sense should be represented with the more general concept of 
  -- Contest.
  fun Battle  : Class ;
  fun Battle_Class : SubClass Battle ViolentContest ;

  -- SI activity measure. Symbol: Bq. It measures 
  -- the amount of radioactivity contained in a given sample of matter. It is 
  -- that quantity of a radioactive element in which there is one atomic 
  -- disintegration per SecondDuration. Becquerel = s^(_1).
  fun Becquerel  : Ind CompositeUnitOfMeasure ;

  -- A UnaryFunction that maps a TimeInterval to 
  -- the TimePoint at which the interval begins.
  fun BeginFn  : El TimeInterval -> Ind TimePoint ;

  -- A UnaryFunction that maps a GraphPath 
  -- to the GraphNode that is the beginning of the GraphPath. Note that, 
  -- unlike InitialNodeFn (which relates a GraphArc to a GraphNode), 
  -- BeginNodeFn is a total function _ every GraphPath has a beginning.
  fun BeginNodeFn  : El GraphPath -> Ind GraphNode ;

  -- A GroupOfPeople whose members share a belief 
  -- or set of beliefs.
  fun BeliefGroup  : Class ;
  fun BeliefGroup_Class : SubClass BeliefGroup GroupOfPeople ;

  -- This PositionalAttribute is derived from the 
  -- up/down schema and may or may not involve contact. Note that this means 
  -- directly below, i.e., if one object is Below another object, then the 
  -- projections of the two objects overlap.
  fun Below  : Ind AntiSymmetricPositionalAttribute ;

  -- A FinancialTransaction where an instance of 
  -- CurrencyMeasure is exchanged for the possibility of winning a larger 
  -- instance of CurrencyMeasure within the context of some sort of 
  -- Game.
  fun Betting  : Class ;
  fun Betting_Class : SubClass Betting FinancialTransaction ;

  -- Any Food that is ingested by Drinking. 
  -- Note that this class is disjoint with the other subclasses of Food, 
  -- i.e. Meat and FruitOrVegetable.
  fun Beverage  : Class ;
  fun Beverage_Class : SubClass Beverage Food ;

  -- Elements from the number system with base 2. 
  -- Every BinaryNumber is expressed as a sequence of the digits 1 and 0.
  fun BinaryNumber  : Class ;
  fun BinaryNumber_Class : SubClass BinaryNumber RealNumber ;

  -- Attributes that apply specifically 
  -- to instances of Organism.
  fun BiologicalAttribute  : Class ;
  fun BiologicalAttribute_Class : SubClass BiologicalAttribute InternalAttribute ;

  -- A Process embodied in an Organism.
  fun BiologicalProcess  : Class ;
  fun BiologicalProcess_Class : SubClass BiologicalProcess InternalChange ;

  -- A Substance that is capable of inducing a change in the structure or functioning of an 
  -- Organism. This Class includes Substances used in the treatment, 
  -- diagnosis, prevention or analysis of normal and abnormal body function. 
  -- This Class also includes Substances that occur naturally in the body 
  -- and are administered therapeutically. Finally, BiologicallyActiveSubstance 
  -- includes Nutrients, most drugs of abuse, and agents that require special 
  -- handling because of their toxicity.
  fun BiologicallyActiveSubstance  : Class ;
  fun BiologicallyActiveSubstance_Class : SubClass BiologicallyActiveSubstance Substance ;

  -- A Vertebrate having a constant body temperature 
  -- and characterized by the presence of feathers.
  fun Bird  : Class ;
  fun Bird_Class : SubClass Bird WarmBloodedVertebrate ;

  -- The Process of being born.
  fun Birth  : Class ;
  fun Birth_Class : SubClass Birth OrganismProcess ;

  -- One Bit of information. A one or a zero.
  fun Bit  : Ind UnitOfInformation ;

  -- The Attribute of being black in color.
  fun Black  : Ind PrimaryColor ;

  -- A fluid present in Animals that transports 
  -- Nutrients to and waste products away from various BodyParts.
  fun Blood  : Class ;
  fun Blood_Class : SubClass Blood BodySubstance ;

  -- The Attribute of being blue in color.
  fun Blue  : Ind PrimaryColor ;

  -- Any BodyPart which contains an unfilled space, 
  -- e.g. BodyVessels, the atria and ventricles of the heart, the lungs, etc.
  fun BodyCavity  : Class ;
  fun BodyCavity_Class : SubClass BodyCavity BodyPart ;

  -- Any BodyPart which is a covering of another 
  -- BodyPart or of an entire Organism. This would include the rinds of 
  -- FruitOrVegetables and the skins of Animals.
  fun BodyCovering  : Class ;
  fun BodyCovering_Class : SubClass BodyCovering BodyPart ;

  -- The place where two BodyParts 
  -- meet or connect.
  fun BodyJunction  : Class ;
  fun BodyJunction_Class : SubClass BodyJunction BodyPart ;

  -- Any Motion where the agent is an Organism 
  -- and the patient is a BodyPart.
  fun BodyMotion  : Class ;
  fun BodyMotion_Class : SubClass BodyMotion Motion ;

  -- A collection of Cells and Tissues which 
  -- are localized to a specific area of an Organism and which are not 
  -- pathological. The instances of this Class range from gross structures 
  -- to small components of complex Organs.
  fun BodyPart  : Class ;
  fun BodyPart_Class : SubClass BodyPart AnatomicalStructure ;

  -- The class of Attributes expressing 
  -- configurations of bodies or parts of bodies of animals or humans, 
  -- e.g. standing, sitting, kneeling, lying down, etc.
  fun BodyPosition  : Class ;
  fun BodyPosition_Class : SubClass BodyPosition BiologicalAttribute ;

  -- Extracellular material and mixtures of 
  -- cells and extracellular material that are produced, excreted or accreted 
  -- by an Organism. Included here are Substances such as saliva, dental 
  -- enamel, sweat, hormones, and gastric acid.
  fun BodySubstance  : Class ;
  fun BodySubstance_Class : SubClass BodySubstance Substance ;

  -- Any tube_like structure which occurs naturally in 
  -- an Organism and through which a BodySubstance can circulate.
  fun BodyVessel  : Class ;
  fun BodyVessel_Class : SubClass BodyVessel BodyCavity ;

  -- The Class of Processes where a Substance is 
  -- heated and converted from a Liquid to a Gas.
  fun Boiling  : Class ;
  fun Boiling_Class : SubClass Boiling StateChange ;

  -- Rigid Tissue composed largely of calcium that makes up 
  -- the skeleton of Vertebrates. Note that this Class also includes teeth.
  fun Bone  : Class ;
  fun Bone_Class : SubClass Bone (both AnimalSubstance Tissue) ;

  -- A Text that has pages and is bound.
  fun Book  : Class ;
  fun Book_Class : SubClass Book Text ;

  -- The subclass of Getting Processes where 
  -- the agent gets something for a limited period of time with the expectation 
  -- that it will be returned later (perhaps with interest).
  fun Borrowing  : Class ;
  fun Borrowing_Class : SubClass Borrowing Getting ;

  -- The Process of respiration, by which oxygen 
  -- is made available to an Animal. This covers processes of inhalation, 
  -- exhalation, and alternations between the two.
  fun Breathing  : Class ;
  fun Breathing_Class : SubClass Breathing (both AutonomicProcess OrganismProcess) ;

  -- An energy measure.
  fun BritishThermalUnit  : Ind CompositeUnitOfMeasure ;

  -- The Class of StationaryArtifacts which are 
  -- intended to house Humans and their activities.
  fun Building  : Class ;
  fun Building_Class : SubClass Building StationaryArtifact ;

  -- A FinancialTransaction in which an instance of 
  -- CurrencyMeasure is exchanged for an instance of Physical.
  fun Buying  : Class ;
  fun Buying_Class : SubClass Buying FinancialTransaction ;

  -- One Byte of information. A Byte is eight Bits.
  fun Byte  : Ind UnitOfInformation ;

  -- IntentionalPsychologicalProcesses which involve 
  -- the consideration and/or manipulation of instances of Quantity.
  fun Calculating  : Class ;
  fun Calculating_Class : SubClass Calculating IntentionalPsychologicalProcess ;

  -- A Calorie is an energy measure.
  fun Calorie  : Ind CompositeUnitOfMeasure ;

  -- SI luminosity intensity measure. Symbol: cd. 
  -- It is one of the base units in SI, and it is currently defined as 
  -- follows: the Candela is the luminous intensity, in a given direction, 
  -- of a source that emits monochromatic radiation of frequency 540*10^12 
  -- Hertz and that has a radiant intensity in that direction of 1/683 
  -- Watt per Steradian.
  fun Candela  : Ind CompositeUnitOfMeasure ;

  -- The Class of Carnivores with completely 
  -- separable toes, nonretractable claws, and long muzzles.
  fun Canine  : Class ;
  fun Canine_Class : SubClass Canine Carnivore ;

  -- An element of living cells and a source of 
  -- energy for Animals. This class includes both simple Carbohydrates, 
  -- i.e. sugars, and complex Carbohydrates, i.e. starches.
  fun Carbohydrate  : Class ;
  fun Carbohydrate_Class : SubClass Carbohydrate Nutrient ;

  fun CardinalityFn  : El (either SetOrClass Collection) -> Ind Number ;

  -- The Class of flesh_eating Mammals. Members 
  -- of this Class typically have four or five claws on each paw. Includes 
  -- cats, dogs, bears, racoons, and skunks.
  fun Carnivore  : Class ;
  fun Carnivore_Class : SubClass Carnivore Mammal ;

  -- Transfer from one point to another by means of 
  -- an Animal or Human.
  fun Carrying  : Class ;
  fun Carrying_Class : SubClass Carrying Transfer ;

  -- (CeilingFn ?NUMBER) returns the smallest 
  -- Integer greater than or equal to the RealNumber ?NUMBER.
  fun CeilingFn  : El RealNumber -> Ind Integer ;

  -- The fundamental structural and functional unit of 
  -- living Organisms.
  fun Cell  : Class ;
  fun Cell_Class : SubClass Cell BodyPart ;

  -- A TemperatureMeasure. The freezing point 
  -- and the boiling point of water are, respectively, 0 CelsiusDegrees and 100 
  -- CelsiusDegrees.
  fun CelsiusDegree  : Ind (both TemperatureMeasure UnitOfMeasure) ;

  -- (CenterOfCircleFn ?CIRCLE) denotes the 
  -- GeometricPoint that is the center of the Circle ?CIRCLE.
  fun CenterOfCircleFn  : El Circle -> Ind GeometricPoint ;

  -- Submultiple of Meter. Symbol: cm. It is 
  -- the 100th part of a Meter
  fun Centimeter  : Ind UnitOfLength ;

  -- A TimeZone that covers much of the 
  -- midwestern United States.
  fun CentralTimeZone  : Ind TimeZone ;

  -- A Text that confers a right or obligation 
  -- on the holder of the Certificate. Note that the right or obligation 
  -- need not be a legal one, as in the case of an academic diploma that grants 
  -- certain privileges in the professional world.
  fun Certificate  : Class ;
  fun Certificate_Class : SubClass Certificate Text ;

  -- The Class of Processes where 
  -- ownership of something is transferred from one Agent to another.
  fun ChangeOfPossession  : Class ;
  fun ChangeOfPossession_Class : SubClass ChangeOfPossession SocialInteraction ;

  -- An element of an alphabet, a set of numerals, etc. 
  -- Note that a Character may or may not be part of a Language. Character 
  -- is a subclass of SymbolicString, because every instance of Character is 
  -- an alphanumeric sequence consisting of a single element.
  fun Character  : Class ;
  fun Character_Class : SubClass Character SymbolicString ;

  -- The Class of ChemicalProcesses 
  -- in which a CompoundSubstance breaks down into simpler products.
  fun ChemicalDecomposition  : Class ;
  fun ChemicalDecomposition_Class : SubClass ChemicalDecomposition (both ChemicalProcess Separating) ;

  -- A ChemicalProcess occurs whenever 
  -- chemical compounds (CompoundSubstances) are formed or decomposed. 
  -- For example, reactants disappear as chemical change occurs, and products 
  -- appear as chemical change occurs. In a chemical change a chemical 
  -- reaction takes place. Catalysts in a ChemicalProcess may speed up the 
  -- reaction, but aren't themselves produced or consumed. Examples: rusting of 
  -- iron and the decomposition of water, induced by an electric current, to 
  -- gaseous hydrogen and gaseous oxygen.
  fun ChemicalProcess  : Class ;
  fun ChemicalProcess_Class : SubClass ChemicalProcess InternalChange ;

  -- The Class of ChemicalProcesses in 
  -- which a CompoundSubstance is formed from simpler reactants.
  fun ChemicalSynthesis  : Class ;
  fun ChemicalSynthesis_Class : SubClass ChemicalSynthesis (both ChemicalProcess Combining) ;

  -- The class of Ovals such that all GeometricPoints 
  -- that make up the Circle are equidistant from a single GeometricPoint, 
  -- known as the center of the Circle.
  fun Circle  : Class ;
  fun Circle_Class : SubClass Circle Oval ;

  -- A LandArea of relatively small size, inhabited 
  -- by a community of people, and having some sort of political structure. 
  -- Note that this class includes both large cities and small settlements 
  -- like towns, villages, hamlets, etc.
  fun City  : Class ;
  fun City_Class : SubClass City (both GeopoliticalArea LandArea) ;

  -- The Class of IntentionalPsychologicalProcesses 
  -- which involve attaching a name or category to a thing or set of things. 
  -- Note that Classifying is distinguished from Learning by the fact 
  -- that the latter covers the acquisition by a CognitiveAgent of any 
  -- Proposition, while the former involves the assignment of a label 
  -- or category.
  fun Classifying  : Class ;
  fun Classifying_Class : SubClass Classifying IntentionalPsychologicalProcess ;

  -- Any TwoDimensionalFigure which 
  -- has a well defined interior and exterior.
  fun ClosedTwoDimensionalFigure  : Class ;
  fun ClosedTwoDimensionalFigure_Class : SubClass ClosedTwoDimensionalFigure TwoDimensionalFigure ;

  -- Artifact made out of fabrics and possibly other 
  -- materials that are used to cover the bodies of Humans.
  fun Clothing  : Class ;
  fun Clothing_Class : SubClass Clothing WearableItem ;

  -- Any GasMixture that is visible, e.g. Smoke produced 
  -- by a fire or clouds of water vapor in the sky.
  fun Cloud  : Class ;
  fun Cloud_Class : SubClass Cloud GasMixture ;

  -- A SentientAgent with responsibilities 
  -- and the ability to reason, deliberate, make plans, etc. This is 
  -- essentially the legal/ethical notion of a person. Note that, although 
  -- Human is a subclass of CognitiveAgent, there may be instances of 
  -- CognitiveAgent which are not also instances of Human. For example, 
  -- chimpanzees, gorillas, dolphins, whales, and some extraterrestrials 
  -- (if they exist) may be CognitiveAgents.
  fun CognitiveAgent  : Class ;
  fun CognitiveAgent_Class : SubClass CognitiveAgent SentientAgent ;

  -- Vertebrates whose body temperature 
  -- is not internally regulated.
  fun ColdBloodedVertebrate  : Class ;
  fun ColdBloodedVertebrate_Class : SubClass ColdBloodedVertebrate Vertebrate ;

  -- Collections have members like Classes, but, unlike Classes, 
  -- they have a position in space_time and members can be 
  -- added and subtracted without thereby changing the identity of the 
  -- Collection. Some examples are toolkits, football teams, and flocks 
  -- of sheep.
  fun Collection  : Class ;
  fun Collection_Class : SubClass Collection Object ;

  -- The Class of Attributes relating to the 
  -- color of Objects.
  fun ColorAttribute  : Class ;
  fun ColorAttribute_Class : SubClass ColorAttribute InternalAttribute ;

  -- The subclass of SurfaceChange where a 
  -- ColorAttribute of the patient is altered. Note that the change in
  -- color may apply to just part of the object.
  fun Coloring  : Class ;
  fun Coloring_Class : SubClass Coloring SurfaceChange ;

  -- A Process where two or more SelfConnectedObjects 
  -- are incorporated into a single SelfConnectedObject. Note that Combining 
  -- is different from Attaching in that the former results in one of the objects 
  -- being part of the other, while Attaching only results in the two objects 
  -- being connected with one another. Note too that Combining is different 
  -- from Putting in that one or both of the two things which are combined may or 
  -- may not be moved from the location where they were combined.
  fun Combining  : Class ;
  fun Combining_Class : SubClass Combining DualObjectProcess ;

  -- The Class of ChemicalProcesses in which an Object 
  -- reacts with oxygen and gives off heat. This includes all Processes in which 
  -- something is burning.
  fun Combustion  : Class ;
  fun Combustion_Class : SubClass Combustion ChemicalDecomposition ;

  -- An Agent that provides products and/or 
  -- services for a fee with the aim of making a profit.
  fun CommercialAgent  : Class ;
  fun CommercialAgent_Class : SubClass CommercialAgent Agent ;

  -- Any FinancialTransaction by a 
  -- CommercialAgent where the aim is to produce a profit.
  fun CommercialService  : Class ;
  fun CommercialService_Class : SubClass CommercialService (both FinancialTransaction ServiceProcess) ;

  -- Instances of this Class commit the agent to some 
  -- future course. For example, Bob promised Susan that he would be home by 11pm.
  fun Committing  : Class ;
  fun Committing_Class : SubClass Committing LinguisticCommunication ;

  -- A SocialInteraction that involves 
  -- the transfer of information between two or more CognitiveAgents. 
  -- Note that Communication is closely related to, but essentially 
  -- different from, ContentDevelopment. The latter involves the creation 
  -- or modification of a ContentBearingObject, while Communication is 
  -- the transfer of information for the purpose of conveying a message.
  fun Communication  : Class ;
  fun Communication_Class : SubClass Communication (both ContentBearingProcess SocialInteraction) ;

  -- The Class of IntentionalPsychologicalProcesses 
  -- which involve comparing, relating, contrasting, etc. the properties of 
  -- two or more Entities.
  fun Comparing  : Class ;
  fun Comparing_Class : SubClass Comparing (both DualObjectProcess IntentionalPsychologicalProcess) ;

  -- The complement of a given SetOrClass C is the 
  -- SetOrClass of all things that are not instances of C. In other words, an 
  -- object is an instance of the complement of a SetOrClass C just in case it 
  -- is not an instance of C.
  fun ComplementFn  : El SetOrClass -> Ind SetOrClass ;

  -- A Number that has the form: x + yi, where x 
  -- and y are RealNumbers and i is the square root of _1.
  fun ComplexNumber  : Class ;
  fun ComplexNumber_Class : SubClass ComplexNumber Number ;

  -- Instances
  -- of this Class are UnitsOfMeasure defined by the functional
  -- composition of other units, each of which might be a
  -- CompositeUnitOfMeasure or a NonCompositeUnitOfMeasure.
  fun CompositeUnitOfMeasure  : Class ;
  fun CompositeUnitOfMeasure_Class : SubClass CompositeUnitOfMeasure UnitOfMeasure ;

  -- The Class of Substances that contain 
  -- two or more elements (ElementalSubstances), in definite proportion by weight. 
  -- The composition of a pure compound will be invariant, regardless of the method 
  -- of preparation. Compounds are composed of more than one kind of atom (element). 
  -- The term molecule is often used for the smallest unit of a compound that still 
  -- retains all of the properties of the compound. Examples: Table salt (sodium 
  -- chloride, NaCl), sugar (sucrose, C_{12}H_{22}O_{11}), and water (H_2O).
  fun CompoundSubstance  : Class ;
  fun CompoundSubstance_Class : SubClass CompoundSubstance PureSubstance ;

  -- The class of Languages designed for 
  -- and interpreted by a computer.
  fun ComputerLanguage  : Class ;
  fun ComputerLanguage_Class : SubClass ComputerLanguage ArtificialLanguage ;

  -- A set of instructions in a computer 
  -- programming language that can be executed by a computer.
  fun ComputerProgram  : Class ;
  fun ComputerProgram_Class : SubClass ComputerProgram Procedure ;

  -- The process of developing a 
  -- ComputerProgram
  fun ComputerProgramming  : Class ;
  fun ComputerProgramming_Class : SubClass ComputerProgramming ContentDevelopment ;

  -- The Class of Processes where an Object is 
  -- cooled and converted from a Gas to a Liquid.
  fun Condensing  : Class ;
  fun Condensing_Class : SubClass Condensing StateChange ;

  -- The Class of Keeping Processes where the 
  -- patient is a Human or an Animal and is kept involuntarily. This covers 
  -- caging, imprisonment, jailing, etc.
  fun Confining  : Class ;
  fun Confining_Class : SubClass Confining Keeping ;

  -- Attributes that indicate whether 
  -- an Organism is conscious or the qualitative degree of consciousness of 
  -- an Organism.
  fun ConsciousnessAttribute  : Class ;
  fun ConsciousnessAttribute_Class : SubClass ConsciousnessAttribute StateOfMind ;

  -- A ConstantQuantity is a PhysicalQuantity that has a constant value, e.g. 
  -- 3 Meters and 5 HourDurations. The magnitude (see MagnitudeFn) of every
  -- ConstantQuantity is a RealNumber. ConstantQuantity is
  -- distinguished from FunctionQuantity, in that each instance of the
  -- latter is formed through the mapping of one PhysicalQuantity to
  -- another PhysicalQuantity. Each instance of ConstantQuantity is
  -- expressed with the BinaryFunction MeasureFn, which takes a
  -- Number and a UnitOfMeasure as arguments. For example, 3 Meters
  -- is expressed as (MeasureFn 3 Meter). Instances of
  -- ConstantQuantity form a partial order (see
  -- PartialOrderingRelation) with the lessThan relation, since
  -- lessThan is a RelationExtendedToQuantities and lessThan is
  -- defined over the RealNumbers. The lessThan relation is not a
  -- total order (see TotalOrderingRelation) over the class
  -- ConstantQuantity since elements of some subclasses of
  -- ConstantQuantity (such as length quantities) are incomparable to
  -- elements of other subclasses of ConstantQuantity
  -- (such as mass quantities).
  fun ConstantQuantity  : Class ;
  fun ConstantQuantity_Class : SubClass ConstantQuantity PhysicalQuantity ;

  -- An ConstructedLanguage is a 
  -- HumanLanguage that did not evolve spontaneously within a language
  -- community, but rather had its core grammar and vocabulary invented by 
  -- one or more language experts, often with an aim to produce a more 
  -- grammatically regular language than any language that has evolved 
  -- naturally. This Class includes languages like Esperanto that were 
  -- created to facilitate international communication
  fun ConstructedLanguage  : Class ;
  fun ConstructedLanguage_Class : SubClass ConstructedLanguage (both ArtificialLanguage HumanLanguage) ;

  -- The subclass of Making in which a 
  -- StationaryArtifact is built.
  fun Constructing  : Class ;
  fun Constructing_Class : SubClass Constructing Making ;

  -- Any SelfConnectedObject that expresses 
  -- content. This content may be a Proposition, e.g. when the ContentBearingObject 
  -- is a Sentence or Text, or it may be a representation of an abstract or 
  -- physical object, as with an Icon, a Word or a Phrase.
  fun ContentBearingObject  : Class ;
  fun ContentBearingObject_Class : SubClass ContentBearingObject (both ContentBearingPhysical CorpuscularObject) ;

  -- Any Object or Process that
  -- expresses content. This covers Objects that contain a Proposition,
  -- such as a book, as well as ManualSignLanguage, which may similarly
  -- contain a Proposition.
  fun ContentBearingPhysical  : Class ;
  fun ContentBearingPhysical_Class : SubClass ContentBearingPhysical Physical ;

  -- Any Process, for example 
  -- ManualHumanLanguage, which may contain a Proposition.
  fun ContentBearingProcess  : Class ;
  fun ContentBearingProcess_Class : SubClass ContentBearingProcess ContentBearingPhysical ;

  -- A subclass of IntentionalProcess in 
  -- which content is modified, its form is altered or it is created anew.
  fun ContentDevelopment  : Class ;
  fun ContentDevelopment_Class : SubClass ContentDevelopment IntentionalProcess ;

  -- A SocialInteraction where the agent and 
  -- patient are CognitiveAgents who are trying to defeat one another. 
  -- Note that this concept is often applied in a metaphorical sense in natural 
  -- language, when we speak, e.g., of the struggle of plants for space or 
  -- sunlight, or of bacteria for food resources in some environment.
  fun Contest  : Class ;
  fun Contest_Class : SubClass Contest SocialInteraction ;

  -- A Class containing Attributes that are 
  -- specific to participants in a Contest. In particular, these Attributes 
  -- indicate the position of one of the agents in the Contest with respect 
  -- to other agent(s) in the Contest. Some examples of these Attributes 
  -- are winning, losing, won, lost, etc.
  fun ContestAttribute  : Class ;
  fun ContestAttribute_Class : SubClass ContestAttribute ObjectiveNorm ;

  -- As defined in the CIA World Fact Book, 
  -- Continent covers seven land masses: Africa, NorthAmerica, 
  -- SouthAmerica, Antarctica, Europe, Asia, and Oceania. 
  -- Note that Australia, counted as a continent in some other systems, 
  -- is included in Oceania in the Fact Book. As a consequence, there 
  -- is no Nation which is also a Continent.
  fun Continent  : Class ;
  fun Continent_Class : SubClass Continent LandArea ;

  -- The Making of an instance of Food. Note 
  -- that this can cover any preparation of Food, e.g. making a salad, 
  -- cutting up fruit, etc. It does not necessarily involve the application 
  -- of heat.
  fun Cooking  : Class ;
  fun Cooking_Class : SubClass Cooking Making ;

  -- Any Decreasing Process where the PhysicalQuantity 
  -- decreased is a TemperatureMeasure.
  fun Cooling  : Class ;
  fun Cooling_Class : SubClass Cooling Decreasing ;

  -- The subclass of SocialInteraction where 
  -- the participants involved work together for the achievement of a common 
  -- goal.
  fun Cooperation  : Class ;
  fun Cooperation_Class : SubClass Cooperation SocialInteraction ;

  -- A TimeZone which functions 
  -- as the standard time zone. It is also known as Zulu time (in the military), 
  -- Greenwich Mean Time, and the Western European time zone. Note that whenever 
  -- a TimeZone is not specified, the TimePosition is understood to be with 
  -- respect to the CoordinatedUniversalTimeZone.
  fun CoordinatedUniversalTimeZone  : Ind TimeZone ;

  -- An Organization that has a special legal status 
  -- that allows a group of persons to act as a CommercialAgent and that insulates 
  -- the owners (shareholders) from many liabilities that might result from the 
  -- corporation's operation.
  fun Corporation  : Class ;
  fun Corporation_Class : SubClass Corporation (both CommercialAgent Organization) ;

  -- A SelfConnectedObject whose parts have 
  -- properties that are not shared by the whole.
  fun CorpuscularObject  : Class ;
  fun CorpuscularObject_Class : SubClass CorpuscularObject SelfConnectedObject ;

  -- (CosineFn ?DEGREE) returns the cosine of the 
  -- PlaneAngleMeasure ?DEGREE. The cosine of ?DEGREE is the ratio of the 
  -- side next to ?DEGREE to the hypotenuse in a right_angled triangle.
  fun CosineFn  : El PlaneAngleMeasure -> Ind RealNumber ;

  -- SI electric charge measure. Symbol: C. It is 
  -- the quantity of electric charge transported through a cross section of 
  -- a conductor in an electric circuit during each SecondDuration by a 
  -- current of 1 Ampere. Coulomb = s*A.
  fun Coulomb  : Ind CompositeUnitOfMeasure ;

  -- Enumerating something. The Class of Calculating 
  -- Processes where the aim is to determine the Number corresponding to the 
  -- patient.
  fun Counting  : Class ;
  fun Counting_Class : SubClass Counting Calculating ;

  -- A GeopoliticalArea that is larger than a city, 
  -- usually encompassing several cities, and smaller than a StateOrProvince. 
  -- Aside from City, this is the smallest geopolitical subdivision, and it is 
  -- known by various names in various counties, e.g. parrish, commune, etc.
  fun County  : Class ;
  fun County_Class : SubClass County (both GeopoliticalArea LandArea) ;

  -- The Class of Putting processes where the agent 
  -- covers the patient, either completely or only partially, with something 
  -- else.
  fun Covering  : Class ;
  fun Covering_Class : SubClass Covering Putting ;

  -- The subclass of Process in which 
  -- something is created. Note that the thing created is specified 
  -- with the result CaseRole.
  fun Creation  : Class ;
  fun Creation_Class : SubClass Creation InternalChange ;

  -- A Class of Arthropods that mainly dwells 
  -- in water and has a segmented body and a chitinous exoskeleton. Includes 
  -- lobsters, crabs, shrimp, and barnacles.
  fun Crustacean  : Class ;
  fun Crustacean_Class : SubClass Crustacean Arthropod ;

  -- English unit of volume equal to 1/2 of a Pint.
  fun Cup  : Ind UnitOfVolume ;

  -- Any element of the official currrency of some 
  -- Nation. This covers both CurrencyBills and CurrencyCoins.
  fun Currency  : Class ;
  fun Currency_Class : SubClass Currency FinancialInstrument ;

  -- Instances of this
  -- subclass of ConstantQuantity are measures of monetaryValue
  -- stated in terms of some UnitOfCurrency such as UnitedStatesDollar,
  -- UnitedStatesCent, Lire, Yen, etc.
  fun CurrencyMeasure  : Class ;
  fun CurrencyMeasure_Class : SubClass CurrencyMeasure ConstantQuantity ;

  -- A UnaryFunction that assigns a Graph the 
  -- Class of GraphPaths that partition the graph into two separate 
  -- graphs if cut. There may be more than one cutset for a given graph.
  fun CutSetFn : El Graph -> Desc GraphPath ;

  -- The subclass of Poking Processes which 
  -- involve a sharp instrument.
  fun Cutting  : Class ;
  fun Cutting_Class : SubClass Cutting Poking ;

  -- The Class of Processes where the agent brings about a situation
  -- where the patient no longer functions normally or as intended.
  fun Damaging  : Class ;
  fun Damaging_Class : SubClass Damaging InternalChange ;

  -- An Attribute which indicates that the associated 
  -- Object contains some Liquid.
  fun Damp  : Ind SaturationAttribute ;

  -- Any BodyMotion of Humans which is deliberately coordinated with music.
  fun Dancing  : Class ;
  fun Dancing_Class : SubClass Dancing BodyMotion ;

  -- The Class of all calendar Days.
  fun Day  : Class ;
  fun Day_Class : SubClass Day TimeInterval ;

  -- Time unit. 1 day = 24 hours.
  fun DayDuration  : Ind UnitOfDuration ;

  -- A BinaryFunction that assigns a PositiveRealNumber and 
  -- a subclass of Months to the Days within each Month corresponding to that 
  -- PositiveRealNumber. For example, (DayFn 16 August) is the Class of all 
  -- sixteenth days of August. For another example, (DayFn 9 Month) would return 
  -- the class of all ninth days of any month. For still another example, (DayFn 18 
  -- (MonthFn August (YearFn 1912))) denotes the 18th day of August 1912.
  fun DayFn : El PositiveInteger -> Desc Month -> Desc Day ;

  -- This Attribute applies to Organisms that are 
  -- not alive.
  fun Dead  : Ind (both AnimacyAttribute ConsciousnessAttribute) ;

  -- The Process of dying.
  fun Death  : Class ;
  fun Death_Class : SubClass Death OrganismProcess ;

  -- The Class of all Months which are December.
  fun December  : Class ;
  fun December_Class : SubClass December Month ;

  -- The subclass of Selecting where the agent 
  -- opts for one course of action out of a set of multiple possibilities 
  -- that are open to him/her.
  fun Deciding  : Class ;
  fun Deciding_Class : SubClass Deciding Selecting ;

  -- The Class of LinguisticCommunications that 
  -- effect an institutional alteration when performed by competent authority. 
  -- Some examples are nominating, marrying, and excommunicating.
  fun Declaring  : Class ;
  fun Declaring_Class : SubClass Declaring LinguisticCommunication ;

  -- Converting a document or message that has previously 
  -- been encoded (see Encoding) into a Language that can be understood by a 
  -- relatively large number of speakers.
  fun Decoding  : Class ;
  fun Decoding_Class : SubClass Decoding Writing ;

  -- Any QuantityChange where the PhysicalQuantity is decreased.
  fun Decreasing  : Class ;
  fun Decreasing_Class : SubClass Decreasing QuantityChange ;

  -- An Argument which has the form of a deduction, i.e. 
  -- it is claimed that the set of premises entails the conclusion.
  fun DeductiveArgument  : Class ;
  fun DeductiveArgument_Class : SubClass DeductiveArgument Argument ;

  -- A Maneuver in a ViolentContest 
  -- where the agent attempts to avoid being damaged.
  fun DefensiveManeuver  : Class ;
  fun DefensiveManeuver_Class : SubClass DefensiveManeuver Maneuver ;

  -- Exhibiting something or a range of things 
  -- before the public in a particular location. This would cover software 
  -- demos, theatrical plays, lectures, dance and music recitals, museum 
  -- exhibitions, etc.
  fun Demonstrating  : Class ;
  fun Demonstrating_Class : SubClass Demonstrating Disseminating ;

  -- (DenominatorFn ?NUMBER) returns the 
  -- denominator of the canonical reduced form of the RealNumber ?NUMBER.
  fun DenominatorFn  : El RealNumber -> Ind Integer ;

  -- DensityFn maps an instance of MassMeasure 
  -- and an instance of VolumeMeasure to the density represented by this 
  -- proportion of mass and volume. For example, (DensityFn (MeasureFn 3 Gram) 
  -- (MeasureFn 1 Liter)) represents the density of 3 grams per liter.
  fun DensityFn  : El MassMeasure -> El VolumeMeasure -> Ind FunctionQuantity;

  -- A Class containing all of the Attributes 
  -- relating to the notions of permission, obligation, and prohibition.
  fun DeonticAttribute  : Class ;
  fun DeonticAttribute_Class : SubClass DeonticAttribute ObjectiveNorm ;

  -- The spatial analogue of Planning. Designing a 
  -- Collection of Objects involves determining a placement of the Objects 
  -- with respect to one another and perhaps other Objects as well, in order to 
  -- satisfy a particular purpose.
  fun Designing  : Class ;
  fun Designing_Class : SubClass Designing IntentionalPsychologicalProcess ;

  -- The subclass of Damagings in which the patient (or an essential element of the patient) is destroyed. 
  -- Note that the difference between this concept and its superclass is solely one of extent.
  fun Destruction  : Class ;
  fun Destruction_Class : SubClass Destruction Damaging ;

  -- A Process where the agent detaches one thing 
  -- from something else. Note that Detaching is different from Separating 
  -- in that the latter applies to Substances, while the former applies to 
  -- CorpuscularObjects. Note too that Detaching is different from 
  -- Removing in that one or both of the two things which are detached may or 
  -- may not be moved from the location where they were attached.
  fun Detaching  : Class ;
  fun Detaching_Class : SubClass Detaching DualObjectProcess ;

  -- Attributes that indicate the stage of development of an Organism.
  fun DevelopmentalAttribute  : Class ;
  fun DevelopmentalAttribute_Class : SubClass DevelopmentalAttribute BiologicalAttribute ;

  -- A Device is an Artifact whose purpose is to 
  -- serve as an instrument in a specific subclass of Process.
  fun Device  : Class ;
  fun Device_Class : SubClass Device Artifact ;

  -- A Process that is carried out for 
  -- the purpose of determining the nature of a DiseaseOrSyndrome.
  fun DiagnosticProcess  : Class ;
  fun DiagnosticProcess_Class : SubClass DiagnosticProcess Investigating ;

  -- The Process by which Food that has been ingested is broken down
  -- into simpler chemical compounds and absorbed by the Organism.
  fun Digesting  : Class ;
  fun Digesting_Class : SubClass Digesting (both AutonomicProcess OrganismProcess) ;


  -- The Class of directed graphs. A directed graph is a Graph in which all GraphArcs
  -- have direction, i.e. every GraphArc has an initial node (see 
  -- InitialNodeFn) and a terminal node (see TerminalNodeFn).
  fun DirectedGraph  : Class ;
  fun DirectedGraph_Class : SubClass DirectedGraph Graph ;

  -- Instances of this Class urge some further action 
  -- among the receivers. A Directing can be an Ordering, a Requesting or 
  -- a Questioning.
  fun Directing  : Class ;
  fun Directing_Class : SubClass Directing LinguisticCommunication ;

  -- The act of changing the direction in 
  -- which the patient of the act is oriented.
  fun DirectionChange  : Class ;
  fun DirectionChange_Class : SubClass DirectionChange Motion ;

  -- The subclass of PositionalAttributes 
  -- that concern compass directions.
  fun DirectionalAttribute  : Class ;
  fun DirectionalAttribute_Class : SubClass DirectionalAttribute PositionalAttribute ;

  -- A Stating in which two Agents have
  -- contradictory statements. This is distinguished from Arguing in
  -- that the statement in dispute may be a simple assertion, rather than
  -- a chain of deduction, and that two entities must be disagreeing with
  -- each other, whereas a single entity may craft an argument for a given
  -- point of view, without the need for another agent to disagree with.
  fun Disagreeing  : Class ;
  fun Disagreeing_Class : SubClass Disagreeing Stating ;

  -- Finding something that was sought. Note that 
  -- this class is restricted to cases of discovering something Physical. 
  -- For cases involving the acquisition of knowledge, the class Learning 
  -- should be used.
  fun Discovering  : Class ;
  fun Discovering_Class : SubClass Discovering IntentionalPsychologicalProcess ;

  -- A BiologicalAttribute which qualifies 
  -- something that alters or interferes with a normal process, state or activity 
  -- of an Organism. It is usually characterized by the abnormal functioning of 
  -- one or more of the host's systems, parts, or Organs.
  fun DiseaseOrSyndrome  : Class ;
  fun DiseaseOrSyndrome_Class : SubClass DiseaseOrSyndrome BiologicalAttribute ;

  -- Any Communication that involves a 
  -- single agent and many destinations. This covers the release 
  -- of a published book, broadcasting, a theatrical performance, giving 
  -- orders to assembled troops, delivering a public lecture, etc.
  fun Disseminating  : Class ;
  fun Disseminating_Class : SubClass Disseminating Communication ;

  -- If ?NUMBER1 and ?NUMBER2 are Numbers, then 
  -- (DivisionFn ?NUMBER1 ?NUMBER2) is the result of dividing ?NUMBER1 by 
  -- ?NUMBER2. Note that when ?NUMBER1 = 1 (DivisionFn ?NUMBER1 ?NUMBER2) 
  -- is the reciprocal of ?NUMBER2. Note too that (DivisionFn ?NUMBER1 ?NUMBER2)
  -- is undefined when ?NUMBER2 = 0.
  fun DivisionFn  : El Quantity -> El Quantity -> Ind Quantity ;

  -- The Process by which liquid Food, i.e. 
  -- Beverages, are incorporated into an Animal.
  fun Drinking  : Class ;
  fun Drinking_Class : SubClass Drinking Ingesting ;

  -- Controlling the direction and/or speed of a 
  -- Vehicle. This includes navigating a ship, driving a car or truck, 
  -- operating a train, etc.
  fun Driving  : Class ;
  fun Driving_Class : SubClass Driving Guiding ;

  -- An Attribute which indicates that the associated 
  -- Object contains no Liquid.
  fun Dry  : Ind SaturationAttribute ;

  -- The Class of Processes where a Liquid is removed 
  -- from an Object.
  fun Drying  : Class ;
  fun Drying_Class : SubClass Drying Removing ;

  -- Any Process that requires two, 
  -- nonidentical patients.
  fun DualObjectProcess  : Class ;
  fun DualObjectProcess_Class : SubClass DualObjectProcess Process ;

  -- The compass direction of East.
  fun East  : Ind DirectionalAttribute ;

  -- A TimeZone that covers much of the eastern United States.
  fun EasternTimeZone  : Ind TimeZone ;

  -- The Process by which solid Food is incorporated into an Animal.
  fun Eating  : Class ;
  fun Eating_Class : SubClass Eating Ingesting ;

  -- A binary function that maps a type of text 
  -- (e.g. Agatha Christie's Murder_on_the_Orient_Express) and a number 
  -- to the edition of the text type corresponding to the number.
  fun EditionFn : Desc ContentBearingObject -> El PositiveInteger -> Desc ContentBearingObject ;

  -- A EducationalOrganization is an institution of learning. 
  -- Some examples are public and private K_12 schools, and colleges and universities.
  fun EducationalOrganization  : Class ;
  fun EducationalOrganization_Class : SubClass EducationalOrganization Organization ;

  -- Any Process which is intended to result in Learning.
  fun EducationalProcess  : Class ;
  fun EducationalProcess_Class : SubClass EducationalProcess Guiding ;

  -- The fertilized or unfertilized female ReproductiveBody of an Animal. 
  -- This includes Bird and Reptile eggs, as well as mammalian ova.
  fun Egg  : Class ;
  fun Egg_Class : SubClass Egg (both AnimalAnatomicalStructure ReproductiveBody) ;

  -- Election is the class of events conducted by an 
  -- organization, in which qualified participants vote for officers, adopt 
  -- resolutions, or settle other issues in that Organization.
  fun Election  : Class ;
  fun Election_Class : SubClass Election OrganizationalProcess ;

  -- SubatomicParticles that surround the AtomicNucleus. They have a negative charge.
  fun Electron  : Class ;
  fun Electron_Class : SubClass Electron SubatomicParticle ;

  -- The ElectronVolt is an energy measure. 
  -- Symbol: eV. It is the kinetic energy acquired by an electron in passing 
  -- through a potential difference of 1 Volt in a vacuum.
  fun ElectronVolt  : Ind CompositeUnitOfMeasure ;

  -- The Class of PureSubstances that 
  -- cannot be separated into two or more Substances by ordinary chemical 
  -- (or physical) means. This excludes nuclear reactions. ElementalSubstances 
  -- are composed of only one kind of atom. Examples: Iron (Fe), copper (Cu), 
  -- and oxygen (O_2). ElementalSubstances are the simplest 
  -- PureSubstances.
  fun ElementalSubstance  : Class ;
  fun ElementalSubstance_Class : SubClass ElementalSubstance PureSubstance ;

  -- The stage of an Organism or an 
  -- AnatomicalStructure that exists only before the Organism is born. 
  -- Mammals, for example, have this Attribute only prior to 
  -- their birth.
  fun Embryonic  : Ind DevelopmentalAttribute ;

  -- The Class of Attributes that denote emotional states of Organisms.
  fun EmotionalState  : Class ;
  fun EmotionalState_Class : SubClass EmotionalState StateOfMind ;

  -- Converting a document or message into a formal 
  -- language or into a code that can be understood only by a relatively small 
  -- body of Agents. Generally speaking, this hinders wide dissemination of 
  -- the content in the original document or message.
  fun Encoding  : Class ;
  fun Encoding_Class : SubClass Encoding Writing ;

  -- A UnaryFunction that maps a TimeInterval to 
  -- the TimePoint at which the interval ends.
  fun EndFn  : El TimeInterval -> Ind TimePoint ;

  -- A UnaryFunction that maps a GraphPath 
  -- to the GraphNode that is the end of the GraphPath. Note that, unlike 
  -- TerminalNodeFn (which relates a GraphArc to a GraphNode), 
  -- EndNodeFn is a total function _ every GraphPath has a end.
  fun EndNodeFn  : El GraphPath -> Ind GraphNode ;

  -- A fundamental concept that applies 
  -- in many engineering domains. An EngineeringComponent is an element of 
  -- a Device that is a physically whole object, such as one might 
  -- see listed as standard parts in a catalog. The main difference betweeen 
  -- EngineeringComponents and arbitrary globs of matter is that 
  -- EngineeringComponents are object_like in a modeling sense. Thus, an 
  -- EngineeringComponent is not an arbtrary subregion, but a part of a 
  -- system with a stable identity.
  fun EngineeringComponent  : Class ;
  fun EngineeringComponent_Class : SubClass EngineeringComponent Device ;

  -- An EngineeringConnection is an 
  -- EngineeringComponent that represents a connection relationship between 
  -- two other EngineeringComponents. It is a reification of the 
  -- Predicate connectedEngineeringComponents. That means that whenever 
  -- this Predicate holds between two EngineeringComponents, there exists an 
  -- EngineeringConnection. The practical reason for reifying a relationship 
  -- is to be able to attach other information about it. For example, one
  -- might want to say that a particular connection is associated with some 
  -- shared parameters, or that it is of a particular type. 
  -- EngineeringConnections are EngineeringComponents and can therefore be 
  -- an engineeringSubcomponent of other EngineeringComponents. However, 
  -- to provide for modular regularity in component systems, 
  -- EngineeringConnections cannot be connected. For each pair of 
  -- EngineeringComponents related by connectedEngineeringComponents, there 
  -- exists at least one EngineeringConnection. However, that object may not 
  -- be unique, and the same EngineeringConnection may be associated with 
  -- several pairs of EngineeringComponents.
  fun EngineeringConnection  : Class ;
  fun EngineeringConnection_Class : SubClass EngineeringConnection EngineeringComponent ;

  -- The universal class of individuals. This is the root 
  -- node of the ontology.
  fun Entity  : Class ;

  -- A complex Protein that is produced by living cells and which
  -- catalyzes specific biochemical reactions. There are six 
  -- main types of enzymes: oxidoreductases, transferases, hydrolases, 
  -- lyases, isomerases, and ligases.
  fun Enzyme  : Class ;
  fun Enzyme_Class : SubClass Enzyme Protein ;

  -- A GroupOfPeople whose members originate 
  -- from the same GeographicArea or share the same Language and/or cultural 
  -- practices.
  fun EthnicGroup  : Class ;
  fun EthnicGroup_Class : SubClass EthnicGroup GroupOfPeople ;

  -- A currency measure. 1 EuroCent is equal to .01 EuroDollars.
  fun EuroCent  : Ind UnitOfCurrency ;

  -- A currency measure of most European Union countries.
  fun EuroDollar  : Ind UnitOfCurrency ;

  -- The Class of Processes where a Substance is converted
  -- from a Liquid to a Gas at a temperature below its Boiling point.
  fun Evaporating  : Class ;
  fun Evaporating_Class : SubClass Evaporating StateChange ;

  -- An Integer that is evenly divisible 
  -- by 2.
  fun EvenInteger  : Class ;
  fun EvenInteger_Class : SubClass EvenInteger Integer ;

  -- The system of Bones that are on the Outside of an organism and 
  -- make up the supporting structure of many Invertebrates.
  fun Exoskeleton  : Class ;
  fun Exoskeleton_Class : SubClass Exoskeleton (both AnimalAnatomicalStructure BodyPart) ;

  -- Investigating the truth of a Proposition 
  -- by constructing and observing a trial. Note that the trial may be either 
  -- controlled or uncontrolled, blind or not blind.
  fun Experimenting  : Class ;
  fun Experimenting_Class : SubClass Experimenting Investigating ;

  -- An Argument where the conclusion is an 
  -- observed fact and the premises are other facts which collectively imply 
  -- the conclusion. Note that this is the they hypothetico_deductive model 
  -- of explanation.
  fun Explanation  : Class ;
  fun Explanation_Class : SubClass Explanation DeductiveArgument ;

  -- (ExponentiationFn ?NUMBER ?INT) returns 
  -- the RealNumber ?NUMBER raised to the power of the Integer ?INT.
  fun ExponentiationFn  : El Quantity -> El Integer -> Ind Quantity ;

  -- Instances of this Class express a state of the agent. 
  -- For example, Jane thanked Barbara for the present she had given her. The thanking 
  -- in this case expresses the gratitude of Jane towards Barbara. Note that Expressing, 
  -- unlike the other speech act types, is not a subclass of LinguisticCommunication. 
  -- This is because emotions, for example, can be expressed without language, e.g. by 
  -- smiling.
  fun Expressing  : Class ;
  fun Expressing_Class : SubClass Expressing Communication ;

  -- A UnaryFunction that maps an Attribute 
  -- into the Class whose condition for membership is the Attribute.
  fun ExtensionFn  : El Attribute -> Class ;

  -- Artifacts that are created by weaving together 
  -- natural or synthetic fibers or by treating the skins of certain sorts of 
  -- Animals. Note that this Class includes articles that are created by 
  -- stitching together various types of fabrics, e.g. bedspreads. On the other 
  -- hand, Clothing is not a subclass of Fabric, because many clothing items 
  -- contain elements that are not fabrics.
  fun Fabric  : Class ;
  fun Fabric_Class : SubClass Fabric Artifact ;

  -- The class of Texts that purport to 
  -- reveal facts about the world. Such texts are often known as information 
  -- or as non_fiction. Note that something can be an instance of 
  -- FactualText, even if it is wholly inaccurate. Whether something 
  -- is a FactualText is determined by the beliefs of the agent creating 
  -- the text.
  fun FactualText  : Class ;
  fun FactualText_Class : SubClass FactualText Text ;

  -- A UnitOfTemperature that is commonly 
  -- used in the United States. On the Fahrenheit scale, the freezing point 
  -- of water is 32 FahrenheitDegrees, and the boiling point of water is 
  -- 212 FahrenheitDegrees.
  fun FahrenheitDegree  : Ind UnitOfTemperature ;

  -- Falling is the class of events in which something moves 
  -- from a higher location to a lower location under the force of gravity.
  fun Falling  : Class ;
  fun Falling_Class : SubClass Falling (both MotionDownward Translocation) ;

  -- The TruthValue of being false.
  fun False  : Ind TruthValue ;

  -- A GroupOfPeople whose members bear 
  -- familyRelations to one another.
  fun FamilyGroup  : Class ;
  fun FamilyGroup_Class : SubClass FamilyGroup GroupOfPeople ;

  -- SI capacitance measure. Symbol: F. It is the 
  -- capacitance of a capacitator between the plates of which there appears 
  -- a difference of potential of 1 Volt when it is charged by a quantity 
  -- of electricity equal to 1 Coulomb. Farad = C/V = 
  -- m^(_2)*kg(_1)*s^4*A^2.
  fun Farad  : Ind CompositeUnitOfMeasure ;

  -- Nonrigid Tissue that is composed largely of fat cells.
  fun FatTissue  : Class ;
  fun FatTissue_Class : SubClass FatTissue Tissue ;

  -- The Class of all Months which are February.
  fun February  : Class ;
  fun February_Class : SubClass February Month ;

  -- The Class of Carnivores with completely
  -- separable toes, slim bodies, and rounded heads. All felines other than
  -- the cheetah have retractable claws.
  fun Feline  : Class ;
  fun Feline_Class : SubClass Feline Carnivore ;

  -- An Attribute indicating that an Organism is 
  -- female in nature.
  fun Female  : Ind SexAttribute ;

  -- A NonFloweringPlant that contains vascular tissue. 
  -- This class includes true ferns, as well as horsetails, club mosses, and 
  -- whisk ferns.
  fun Fern  : Class ;
  fun Fern_Class : SubClass Fern NonFloweringPlant ;

  -- The class of Texts that purport to 
  -- be largely a product of the author's imagination, i.e. the author 
  -- does not believe that most of the content conveyed by the text is 
  -- an accurate depiction of the real world. Note that something can 
  -- be an instance of FictionalText, even if it is completely true. 
  -- Whether something is a FictionalText is determined by the beliefs 
  -- of the agent creating the text.
  fun FictionalText  : Class ;
  fun FictionalText_Class : SubClass FictionalText Text ;

  -- An academic or applied discipline with 
  -- recognized experts and with a core of accepted theory or practice. Note 
  -- that FieldOfStudy is a subclass of Proposition, because a 
  -- FieldOfStudy is understood to be a body of abstract, informational 
  -- content, with varying degrees of certainty attached to each element of 
  -- this content.
  fun FieldOfStudy  : Class ;
  fun FieldOfStudy_Class : SubClass FieldOfStudy Proposition ;

  -- Something is Fillable if it can be filled by 
  -- something else. Note that 'filled' here means perfectly filled.
  -- Something is fillable just in case it is part of a hole, i.e., 
  -- fillability is an exclusive property of holes and their parts.
  fun Fillable  : Ind ShapeAttribute ;

  -- A document having monetary value 
  -- or recording a monetary transaction
  fun FinancialInstrument  : Class ;
  fun FinancialInstrument_Class : SubClass FinancialInstrument Certificate ;

  -- A Transaction where an instance 
  -- of Currency is exchanged for something else.
  fun FinancialTransaction  : Class ;
  fun FinancialTransaction_Class : SubClass FinancialTransaction Transaction ;

  -- A Set containing a finite number of elements.
  fun FiniteSet  : Class ;
  fun FiniteSet_Class : SubClass FiniteSet Set ;

  -- A cold_blooded aquatic Vertebrate characterized by 
  -- fins and breathing by gills. Included here are Fish having either a bony 
  -- skeleton, such as a perch, or a cartilaginous skeleton, such as a shark. 
  -- Also included are those Fish lacking a jaw, such as a lamprey or 
  -- hagfish.
  fun Fish  : Class ;
  fun Fish_Class : SubClass Fish ColdBloodedVertebrate ;

  -- The Attribute of being flammable at normal temperatures
  -- (i.e. not while a Plasma).
  fun Flammable  : Ind PhysicalAttribute ;

  -- (FloorFn ?NUMBER) returns the largest Integer 
  -- less than or equal to the RealNumber ?NUMBER.
  fun FloorFn  : El RealNumber -> Ind Integer ;

  -- FlowRegion is a class of things whose 
  -- boundaries are relatively stable but whose constitutive material is continuously moving 
  -- through the region itself and being replaced by 
  -- other, similar material. Each FlowRegion is constituted by a stream 
  -- of matter moving as a whole. A FlowRegion may be liquid or gaseous. 
  -- A wind may be considered as a Process or as a FlowRegion, similarly 
  -- an OceanCurrent or a WaterWave. The motion process associated with a 
  -- FlowRegion F is denoted by (FlowFn F). Note that certain 
  -- properties belong to the FlowRegion itself (e.g., mass, length, volume, 
  -- temperature, and speed or velocity of the region moving as a whole), 
  -- while other properties of interest belong to the Motion of its 
  -- constitutive stuff (e.g., velocity, direction). The motion of 
  -- a FlowRegion as a whole (e.g., JetStream moves within the atmosphere) 
  -- is distinguished from the motion of the pieces of stuff constituting the 
  -- FlowRegion. See FlowFn and FlowRegionFn.
  fun FlowRegion  : Class ;

  -- A Plant that produces seeds and flowers. 
  -- This class includes trees, shrubs, herbs, and flowers.
  fun FloweringPlant  : Class ;
  fun FloweringPlant_Class : SubClass FloweringPlant Plant ;

  -- Fluid is the PhysicalState attribute of an 
  -- Object that does not have a fixed shape and thus tends to flow or to 
  -- conform to the shape of a container.
  fun Fluid  : Ind PhysicalState ;

  -- Any SelfConnectedObject containing Nutrients, 
  -- such as carbohydrates, proteins, and fats, that can be ingested by a 
  -- living Animal and metabolized into energy and body tissue.
  fun Food  : Class ;
  fun Food_Class : SubClass Food SelfConnectedObject ;

  -- English length unit of feet.
  fun FootLength  : Ind UnitOfLength ;

  -- The Class of Processes where an Object is 
  -- cooled and converted from a Liquid to a Solid.
  fun Freezing  : Class ;
  fun Freezing_Class : SubClass Freezing StateChange ;

  -- A subclass of
  -- TimeDependentQuantity, instances of which are measures of the
  -- frequency with which some Process occurs.
  fun FrequencyMeasure  : Class ;
  fun FrequencyMeasure_Class : SubClass FrequencyMeasure TimeDependentQuantity ;

  -- A WaterArea whose Water is not saline, 
  -- e.g. most rivers and lakes.
  fun FreshWaterArea  : Class ;
  fun FreshWaterArea_Class : SubClass FreshWaterArea WaterArea ;

  -- The Class of all calendar Fridays.
  fun Friday  : Class ;
  fun Friday_Class : SubClass Friday Day ;

  -- A Function that maps an Object to the side 
  -- that generally receives the most attention or that typically faces the 
  -- direction in which the Object moves. Note that this is a partial 
  -- function, since some Objects do not have sides, e.g. apples and 
  -- spheres. Note too that the range of this Function is indefinite in 
  -- much the way that ImmediateFutureFn and ImmediatePastFn are indefinite. 
  -- Although this indefiniteness is undesirable from a theoretical standpoint, 
  -- it does not have significant practical implications, since there is 
  -- widespread intersubjective agreement about the most common cases.
  fun FrontFn  : El SelfConnectedObject -> Ind SelfConnectedObject ;

  -- Any fruit or vegetable, i.e. a 
  -- ripened ReproductiveBody of a Plant. Note that FruitOrVegetable 
  -- is not a subclass of Food, because some fruits, e.g. poisonous 
  -- berries, are not edible.
  fun FruitOrVegetable  : Class ;
  fun FruitOrVegetable_Class : SubClass FruitOrVegetable (both PlantAnatomicalStructure ReproductiveBody) ;

  -- The stage of an Organism when it has reached 
  -- the end of its growth phase.
  fun FullyFormed  : Ind DevelopmentalAttribute ;

  -- A FunctionQuantity
  -- is a PhysicalQuantity that is returned by a Function that maps
  -- from one or more instances of ConstantQuantity to another instance
  -- of ConstantQuantity. For example, the velocity of a particle would
  -- be represented by a FunctionQuantity relating values of time (which
  -- are instances of ConstantQuantity) to values of distance
  -- (also instances of ConstantQuantity). Note that all elements of the
  -- range of the Function corresponding to a FunctionQuantity have the
  -- same physical dimension as the FunctionQuantity itself.
  fun FunctionQuantity  : Class ;
  fun FunctionQuantity_Class : SubClass FunctionQuantity PhysicalQuantity ;

  -- Any instance of Giving where the patient is an 
  -- instance of Currency. Note that this class covers both financing, e.g. 
  -- where a firm funds a software company with venture capital with the agreement 
  -- that a certain percentage of the profits on the investment will be returned 
  -- to the firm, and instances of UnilateralGiving, e.g. providing a tuition 
  -- waiver and/or a stipend to a student as part of scholarship or fellowship.
  fun Funding  : Class ;
  fun Funding_Class : SubClass Funding Giving ;

  -- A eukaryotic Organism characterized by the 
  -- absence of chlorophyll and the presence of rigid cell walls. Included 
  -- here are both slime molds and true fungi such as yeasts, molds, mildews, 
  -- and mushrooms.
  fun Fungus  : Class ;
  fun Fungus_Class : SubClass Fungus Organism ;

  -- A UnaryFunction that maps a TimePosition 
  -- to the TimeInterval which it meets and which ends at 
  -- PositiveInfinity.
  fun FutureFn  : El TimePosition -> Ind TimeInterval ;

  -- A Contest whose purpose is the 
  -- enjoyment/stimulation of the participants or spectators of the Game.
  fun Game  : Class ;
  fun Game_Class : SubClass Game (both Contest RecreationOrExercise) ;

  -- An Object has the Attribute of Gas if it has 
  -- neither a fixed volume nor a fixed shape.
  fun Gas  : Ind PhysicalState ;

  -- Any Mixture that satisfies two conditions, 
  -- viz. it is made up predominantly of things which are a Gas and any 
  -- component other than Gas in the Mixture is in the form of fine particles 
  -- which are suspended in the Gas.
  fun GasMixture  : Class ;
  fun GasMixture_Class : SubClass GasMixture Mixture ;

  -- Any Motion where the patient is a 
  -- Gas. This class would cover, in particular, the motion of 
  -- Air, e.g. a breeze or wind.
  fun GasMotion  : Class ;
  fun GasMotion_Class : SubClass GasMotion Motion ;

  -- A UnaryFunction that takes a 
  -- SetOrClass of Classes as its single argument and returns a SetOrClass which 
  -- is the intersection of all of the Classes in the original SetOrClass, i.e. 
  -- the SetOrClass containing just those instances which are instances of all 
  -- instances of the original SetOrClass.
  fun GeneralizedIntersectionFn : Desc SetOrClass -> Ind SetOrClass ;

  -- A UnaryFunction that takes a SetOrClass 
  -- of Classes as its single argument and returns a SetOrClass which is the 
  -- merge of all of the Classes in the original SetOrClass, i.e. the SetOrClass 
  -- containing just those instances which are instances of an instance of the 
  -- original SetOrClass.
  fun GeneralizedUnionFn : Desc SetOrClass -> Ind SetOrClass ;

  -- A geographic location, generally having 
  -- definite boundaries. Note that this differs from its immediate superclass 
  -- Region in that a GeographicArea is a three_dimensional Region of the 
  -- earth. Accordingly, all astronomical objects other than earth and all 
  -- one_dimensional and two_dimensional Regions are not classed under 
  -- GeographicArea.
  fun GeographicArea  : Class ;
  fun GeographicArea_Class : SubClass GeographicArea Region ;

  -- The class of activities that 
  -- are caused by geological forces and affect geological features, 
  -- and which may affect the biosphere as well.
  fun GeologicalProcess  : Class ;
  fun GeologicalProcess_Class : SubClass GeologicalProcess (both InternalChange Motion) ;

  -- The class of all geometric figures, i.e. the 
  -- class of all abstract, spatial representations. The instances of this class 
  -- are GeometricPoints, TwoDimensionalFigures or ThreeDimensionalFigures.
  fun GeometricFigure  : Class ;
  fun GeometricFigure_Class : SubClass GeometricFigure ShapeAttribute ;

  -- The class of zero_dimensional 
  -- GeometricFigures, i.e. the class of GeometricFigures that have position 
  -- but lack extension in any dimension.
  fun GeometricPoint  : Class ;
  fun GeometricPoint_Class : SubClass GeometricPoint GeometricFigure ;

  -- Any GeographicArea which is associated 
  -- with some sort of political structure. This class includes Lands, 
  -- Cities, districts of cities, counties, etc. Note that the identity 
  -- of a GeopoliticalArea may remain constant after a change in borders.
  fun GeopoliticalArea  : Class ;
  fun GeopoliticalArea_Class : SubClass GeopoliticalArea (both Agent GeographicArea) ;

  -- Any BodyMotion, e.g. a hand wave, a nod of the 
  -- head, a smile, which is also an instance of Communication.
  fun Gesture  : Class ;
  fun Gesture_Class : SubClass Gesture (both BodyMotion Communication) ;

  -- The subclass of ChangeOfPossession where the
  -- agent gets something. Note that the source from which something is 
  -- obtained is specified with the origin CaseRole.
  fun Getting  : Class ;
  fun Getting_Class : SubClass Getting ChangeOfPossession ;

  -- A UnaryFunction that maps a UnitOfMeasure into 
  -- a UnitOfMeasure that is equal to 1,000,000,000 units of the original 
  -- UnitOfMeasure. For example, (GigaFn Hertz) is 1,000,000,000 Hertz.
  fun GigaFn  : El UnitOfMeasure -> Ind UnitOfMeasure;

  -- The subclass of ChangeOfPossession where the 
  -- agent gives the destination something.
  fun Giving  : Class ;
  fun Giving_Class : SubClass Giving ChangeOfPossession ;

  -- Any instance of Giving where the agent gives 
  -- something to the destination which was previously given to the agent by 
  -- the destination, e.g. returing a book that was borrowed from someone.
  fun GivingBack  : Class ;
  fun GivingBack_Class : SubClass GivingBack Giving ;

  -- An Organ that removes Substances from the Blood, 
  -- alters them in some way, and then releases them.
  fun Gland  : Class ;
  fun Gland_Class : SubClass Gland Organ ;

  -- The ruling body of a GeopoliticalArea.
  fun Government  : Class ;
  fun Government_Class : SubClass Government GovernmentOrganization ;

  -- (GovernmentFn ?AREA) denotes the 
  -- Government of the GeopoliticalArea ?AREA. For example, 
  -- (GovernmentFn UnitedStates) denotes the Federal_level government of 
  -- the United States, (GovernmentFn PuertoRico) denotes the government of 
  -- the Commonwealth of Puerto Rico.
  fun GovernmentFn  : El GeopoliticalArea -> Ind Government ;

  -- GovernmentOrganization is the 
  -- class of official Organizations that are concerned with the government 
  -- of a GeopoliticalArea at some level. They may be a subOrganization 
  -- of a government.
  fun GovernmentOrganization  : Class ;
  fun GovernmentOrganization_Class : SubClass GovernmentOrganization Organization ;

  -- Any instance of Touching which results in 
  -- a situation where the agent grasps the patient of the Touching.
  fun Grabbing  : Class ;
  fun Grabbing_Class : SubClass Grabbing (both Attaching Touching) ;

  -- The OrganizationalProcess of graduating 
  -- from an EducationalOrganization.
  fun Graduation  : Class ;
  fun Graduation_Class : SubClass Graduation LeavingAnOrganization ;

  -- Submultiple of kilogram. Symbol: g. 
  -- 1 kilogram = 1000 Grams.
  fun Gram  : Ind UnitOfMass ;

  -- The Class of graphs, where a graph is understood 
  -- to be a set of GraphNodes connected by GraphArcs. Note that this 
  -- Class includes only connected graphs, i.e. graphs in which there is a 
  -- GraphPath between any two GraphNodes. Note too that every Graph 
  -- is required to contain at least two GraphArcs and three GraphNodes.
  fun Graph  : Class ;
  fun Graph_Class : SubClass Graph Abstract ;

  -- Graphs are comprised of GraphNodes 
  -- and GraphArcs. Every GraphArc links two GraphNodes.
  fun GraphArc  : Class ;
  fun GraphArc_Class : SubClass GraphArc GraphElement ;

  -- A GraphPath that begins (see 
  -- BeginNodeFn) and ends (see EndNodeFn) at the same 
  -- GraphNode.
  fun GraphCircuit  : Class ;
  fun GraphCircuit_Class : SubClass GraphCircuit GraphPath ;

  -- Noncompositional parts of Graphs. 
  -- These parts are restricted to GraphNodes and GraphArcs.
  fun GraphElement  : Class ;
  fun GraphElement_Class : SubClass GraphElement Abstract ;

  -- A GraphArc in which a GraphNode is 
  -- linked to itself.
  fun GraphLoop  : Class ;
  fun GraphLoop_Class : SubClass GraphLoop GraphArc ;

  -- Graphs are comprised of GraphNodes 
  -- and GraphArcs. Every GraphNode is linked by a GraphArc.
  fun GraphNode  : Class ;
  fun GraphNode_Class : SubClass GraphNode GraphElement ;

  -- Informally, a single, directed route between 
  -- two GraphNodes in a Graph. Formally, a DirectedGraph that is a 
  -- subGraph of the original Graph and such that no two GraphArcs in 
  -- the DirectedGraph have the same intial node (see InitialNodeFn) or 
  -- the same terminal node (see TerminalNodeFn).
  fun GraphPath  : Class ;
  fun GraphPath_Class : SubClass GraphPath DirectedGraph ;

  -- A BinaryFunction that maps two GraphNodes 
  -- to the Class of GraphPaths between those two nodes. Note that the two 
  -- GraphNodes must belong to the same Graph.
  fun GraphPathFn : El GraphNode -> El GraphNode -> Desc GraphPath ;

  -- SI absorbed dose measure. Symbol: Gy. It measures 
  -- the dose of radiation absorbed in living tissue. It is equal approximately 
  -- to the absorbed dose delivered when the energy per unit mass imparted to
  -- matter by ionizing radiation is 1 Joule per kilogram. Gray = J/kg 
  -- = m^2*s^(_2).
  fun Gray  : Ind CompositeUnitOfMeasure ;

  -- (GreatestCommonDivisorFn 
  -- ?NUMBER1 ?NUMBER2 ... ?NUMBER) returns the greatest common divisor of 
  -- ?NUMBER1 through ?NUMBER.
  fun GreatestCommonDivisorFn  : [El Integer] -> Ind Integer ;

  -- A Collection of Agents, e.g. a flock 
  -- of sheep, a herd of goats, or the local Boy Scout troop.
  fun Group  : Class ;
  fun Group_Class : SubClass Group (both Agent Collection) ;

  -- Any Group whose members are 
  -- exclusively Humans.
  fun GroupOfPeople  : Class ;
  fun GroupOfPeople_Class : SubClass GroupOfPeople Group ;

  -- The Process of biological development in which 
  -- an Organism or part of an Organism changes its form or its size.
  fun Growth  : Class ;
  fun Growth_Class : SubClass Growth AutonomicProcess ;

  -- Any IntentionalProcess where the agent tries to 
  -- direct the behavior of another Object, whether an Agent or not.
  fun Guiding  : Class ;
  fun Guiding_Class : SubClass Guiding IntentionalProcess ;

  -- The subclass of Perception in which the 
  -- sensing is done by an auditory Organ.
  fun Hearing  : Class ;
  fun Hearing_Class : SubClass Hearing Perception ;

  -- Any Increasing Process where the PhysicalQuantity 
  -- increased is a TemperatureMeasure.
  fun Heating  : Class ;
  fun Heating_Class : SubClass Heating Increasing ;

  -- SI inductance measure. Symbol: H. One Henry 
  -- is equivalent to one Volt divided by one Ampere per SecondDuration. 
  -- If a current changing at the rate of one Ampere per SecondDuration 
  -- induces an electromotive force of one Volt, the circuit has an 
  -- inductance of one Henry. Henry = Wb/A = m^2*kg*s^(_2)*A^(_2).
  fun Henry  : Ind CompositeUnitOfMeasure ;

  -- SI frequency measure. Symbol: Hz. It is the 
  -- number of cycles per second. Hertz = s^(_1). Note that Hertz 
  -- does not have a conversion function.
  fun Hertz  : Ind UnitOfFrequency ;

  -- OrganizationalProcesses where someone is made an 
  -- employee of an Organization.
  fun Hiring  : Class ;
  fun Hiring_Class : SubClass Hiring JoiningAnOrganization ;

  -- A hole is an immaterial body located at the surface 
  -- of an Object. Since every Hole is ontologically dependent on its host 
  -- (i.e., the object in which it is a hole), being a Hole is defined as 
  -- being a hole in something. Note that two Holes may occupy the same 
  -- region, or part of the same region, without sharing any parts. Any two 
  -- hosts of a hole have a common proper part that entirely hosts the hole. A 
  -- common host of two holes hosts all parts of the sum of those holes. Any 
  -- object that includes the host of a hole is a host of that hole, unless its 
  -- parts also include parts of that very hole. Overlapping holes have 
  -- overlapping hosts. No hole is atomic. Holes are connected with their 
  -- hosts. No hole can have a proper part that is externally connected with 
  -- exactly the same things as the hole itself.
  fun Hole  : Class ;
  fun Hole_Class : SubClass Hole Region ;

  -- A UnaryFunction that maps a Hole to 
  -- the Object which is its principal host. The principle host of a Hole 
  -- is its maximally connected host (a notion taken here to be defined only 
  -- when the argument is a hole).
  fun HoleHostFn  : El Hole -> Ind Object ;

  -- A UnaryFunction that maps a Hole to the skin 
  -- of the Hole. The skin of a Hole is the fusion of those superficial 
  -- parts (see superficialPart) of the Hole's principal host (see 
  -- HoleHostFn) with which the Hole is externally connected.
  fun HoleSkinFn  : El Hole -> Ind Object ;

  -- Includes Humans and relatively recent 
  -- ancestors of Humans.
  fun Hominid  : Class ;
  fun Hominid_Class : SubClass Hominid Primate ;

  -- The Class of quadruped Mammals with hooves. 
  -- Includes horses, cows, sheep, pigs, antelope, etc.
  fun HoofedMammal  : Class ;
  fun HoofedMammal_Class : SubClass HoofedMammal Mammal ;

  -- Attribute used to indicate that an Object 
  -- is positioned width_wise with respect to another Object.
  fun Horizontal  : Ind PositionalAttribute ;

  -- In Animals, a chemical secreted by an 
  -- endocrine gland whose products are released into the circulating fluid. 
  -- Plant hormones or synthetic hormones which are used only to alter or 
  -- control various physiologic processes, e.g., reproductive control agents, 
  -- are assigned to the Class BiologicallyActiveSubstance. Hormones act as 
  -- chemical messengers and regulate various physiologic processes such as 
  -- growth, reproduction, metabolism, etc. They usually fall into two broad 
  -- categories, viz. steroid hormones and peptide hormones.
  fun Hormone  : Class ;
  fun Hormone_Class : SubClass Hormone (both BiologicallyActiveSubstance BodySubstance) ;

  -- A power measure that is equal to 746 Watts.
  fun Horsepower  : Ind CompositeUnitOfMeasure ;

  -- The Class of all clock Hours.
  fun Hour  : Class ;
  fun Hour_Class : SubClass Hour TimeInterval ;

  -- Time unit. 1 hour = 60 minutes.
  fun HourDuration  : Ind UnitOfDuration ;

  -- A BinaryFunction that assigns a PositiveRealNumber and 
  -- a subclass of Days to the Hours within each Day corresponding to that 
  -- NonnegativeInteger. For example, (HourFn 12 Thursday) is the Class of all 
  -- instances of noon Thursday. For another example, (HourFn 0 Day) would return 
  -- the class of all instances of midnight. For still another example, (HourFn 14 
  -- (DayFn 18 (MonthFn August (YearFn 1912)))) denotes 2 PM on the 18th day of 
  -- August 1912.
  fun HourFn : El NonnegativeInteger -> Desc Day -> Desc Hour ;

  -- A ResidentialBuilding which is intended to be 
  -- inhabited by members of the same SocialUnit. Houses are distinguished 
  -- from temporary housing like hotels and multi_family dwellings like condominium 
  -- and apartment buildings.
  fun House  : Class ;
  fun House_Class : SubClass House (both ResidentialBuilding SingleFamilyResidence) ;

  -- Modern man, the only remaining species of the Homo 
  -- genus.
  fun Human  : Class ;
  fun Human_Class : SubClass Human (both CognitiveAgent Hominid) ;

  -- The subclass of Languages used by 
  -- Humans.
  fun HumanLanguage  : Class ;
  fun HumanLanguage_Class : SubClass HumanLanguage Language ;

  -- Hunting is the class of Processes in which 
  -- an animal or animals are pursued and sometimes captured and/or killed.
  fun Hunting  : Class ;
  fun Hunting_Class : SubClass Hunting Pursuing ;

  -- This is the subclass of ContentBearingPhysical 
  -- which are not part of a Language and which have some sort of similarity 
  -- with the Objects that they represent. This Class would include symbolic 
  -- roadway signs, representational art works, photographs, etc.
  fun Icon  : Class ;
  fun Icon_Class : SubClass Icon ContentBearingPhysical ;

  -- The Attribute of Regions that are 
  -- illuminated to some degree, i.e. in which some shapes are visually 
  -- discernable.
  fun Illuminated  : Ind VisualAttribute ;

  -- Any Number that is the result of 
  -- multiplying a RealNumber by the square root of _1.
  fun ImaginaryNumber  : Class ;
  fun ImaginaryNumber_Class : SubClass ImaginaryNumber Number ;

  -- (ImaginaryPartFn ?NUMBER) returns 
  -- the part of ?NUMBER that has the square root of _1 as its factor.
  fun ImaginaryPartFn  : El ComplexNumber -> Ind ImaginaryNumber ;

  -- (ImmediateFamilyFn ?PERSON) denotes the 
  -- immediate family of ?PERSON, i.e. the Group consisting of the parents of 
  -- ?PERSON and anyone of whom ?PERSON is a parent.
  fun ImmediateFamilyFn  : El Human -> Ind FamilyGroup ;

  -- A UnaryFunction that maps a 
  -- TimePosition to a short, indeterminate TimeInterval that 
  -- immediately follows the TimePosition.
  fun ImmediateFutureFn  : El TimePosition -> Ind TimeInterval ;

  -- A UnaryFunction that maps a 
  -- TimePosition to a short, indeterminate TimeInterval that 
  -- immediately precedes the TimePosition.
  fun ImmediatePastFn  : El TimePosition -> Ind TimeInterval ;

  -- Any Touching where something comes into 
  -- sudden, forceful, physical contact with something else. Some examples 
  -- would be striking, knocking, whipping etc.
  fun Impacting  : Class ;
  fun Impacting_Class : SubClass Impacting Touching ;

  -- The subclass of Transfer where the patient 
  -- travels through space by means of a sudden, forceful event. Some examples 
  -- would be shooting, throwing, tossing, etc.
  fun Impelling  : Class ;
  fun Impelling_Class : SubClass Impelling Transfer ;

  -- English length unit of inches.
  fun Inch  : Ind UnitOfLength ;

  -- InchMercury is a UnitOfMeasure 
  -- for barometricPressure. It is used to express the number of 
  -- inches of mercury supported in a mercurial barometer by the 
  -- surrounding air pressure.
  fun InchMercury  : Ind UnitOfAtmosphericPressure ;

  -- Any QuantityChange where the PhysicalQuantity 
  -- is increased.
  fun Increasing  : Class ;
  fun Increasing_Class : SubClass Increasing QuantityChange ;

  -- An Argument which is inductive, i.e. it is 
  -- claimed that a set of specific cases makes the conclusion, which generalizes 
  -- these cases, more likely to be true.
  fun InductiveArgument  : Class ;
  fun InductiveArgument_Class : SubClass InductiveArgument Argument ;

  -- Measures of the amount of information. 
  -- Includes Bit, Byte, and multiples of these, e.g. KiloByte and 
  -- MegaByte.
  fun InformationMeasure  : Class ;
  fun InformationMeasure_Class : SubClass InformationMeasure ConstantQuantity ;

  -- The Process by which Food is 
  -- taken into an Animal.
  fun Ingesting  : Class ;
  fun Ingesting_Class : SubClass Ingesting OrganismProcess ;

  -- A UnaryFunction that maps a 
  -- GraphArc to the initial node of the GraphArc. Note
  -- that this is a partial function. In particular, the function is 
  -- undefined for GraphArcs that are not part of a DirectedGraph.
  fun InitialNodeFn  : El GraphArc -> Ind GraphNode ;

  -- Inserting a BiologicallyActiveSubstance into an 
  -- Animal or a Human with a syringe.
  fun Injecting  : Class ;
  fun Injecting_Class : SubClass Injecting Inserting ;

  -- The process of creating a traumatic wound or 
  -- injury. Since Injuring is not possible without some biologic function 
  -- of the organism being injured, it is a subclass of BiologicalProcess.
  fun Injuring  : Class ;
  fun Injuring_Class : SubClass Injuring PathologicProcess ;
  fun Injuring_Damaging  : SubClassC Injuring Damaging (\INJ -> exists Organism (\ORGANISM -> patient(var Damaging Process ? INJ)(var Organism Entity ? ORGANISM)));

  -- A Class of small Arthropods that are 
  -- air_breathing and that are distinguished by appearance.
  fun Insect  : Class ;
  fun Insect_Class : SubClass Insect Arthropod ;

  -- Putting one thing inside of another thing.
  fun Inserting  : Class ;
  fun Inserting_Class : SubClass Inserting Putting ;

  -- A negative or nonnegative whole number.
  fun Integer  : Class ;
  fun Integer_Class : SubClass Integer RationalNumber ;

  -- (IntegerSquareRootFn ?NUMBER) 
  -- returns the integer square root of ?NUMBER.
  fun IntegerSquareRootFn  : El RealNumber -> Ind NonnegativeInteger ;

  -- A Process that has a specific 
  -- purpose for the CognitiveAgent who performs it.
  fun IntentionalProcess  : Class ;
  fun IntentionalProcess_Class : SubClass IntentionalProcess Process ;

  -- An IntentionalProcess that 
  -- can be realized entirely within the mind or brain of an Organism. Thus, 
  -- for example, Reasoning is a subclass of IntentionalPsychologicalProcess, 
  -- because one can reason simply by exercising one's mind/brain. On the other 
  -- hand, RecreationOrExercise is not a subclass of IntentionalPsychologicalProcess,
  -- because many instances of RecreationOrExercise necessarily have subProcesses 
  -- of BodyMotion.
  fun IntentionalPsychologicalProcess  : Class ;
  fun IntentionalPsychologicalProcess_Class : SubClass IntentionalPsychologicalProcess (both IntentionalProcess PsychologicalProcess) ;

  -- Any Attribute of an Entity that is an 
  -- internal property of the Entity, e.g. its shape, its color, its fragility, 
  -- etc.
  fun InternalAttribute  : Class ;
  fun InternalAttribute_Class : SubClass InternalAttribute Attribute ;

  -- Processes which involve altering an internal 
  -- property of an Object, e.g. the shape of the Object, its coloring, its 
  -- structure, etc. Processes that are not instances of this class include 
  -- changes that only affect the relationship to other objects, e.g. changes in 
  -- spatial or temporal location.
  fun InternalChange  : Class ;
  fun InternalChange_Class : SubClass InternalChange Process ;

  -- Any Process of assigning a Proposition to 
  -- a Text, i.e. understanding the Text.
  fun Interpreting  : Class ;
  fun Interpreting_Class : SubClass Interpreting IntentionalPsychologicalProcess ;

  -- A BinaryFunction that maps two 
  -- SetOrClasses to the intersection of these SetOrClasses. An object is 
  -- an instance of the intersection of two SetOrClasses just in case it is 
  -- an instance of both of those SetOrClasses.
  fun IntersectionFn  : El SetOrClass -> El SetOrClass -> Ind SetOrClass ;

  -- A BinaryFunction that
  -- maps two instances of ConstantQuantity to the subclass of
  -- ConstantQuantity that comprises the interval from the first
  -- ConstantQuantity to the second ConstantQuantity. For
  -- example, (IntervalFn (MeasureFn 8 Meter) (MeasureFn 14 Meter)) 
  -- would return the subclass of ConstantQuantity comprising quantities 
  -- between 8 and 14 meters in length.
  fun IntervalFn : El ConstantQuantity -> El ConstantQuantity -> Desc ConstantQuantity ;
  
  -- A class-forming operator that takes two arguments: 
  -- a variable and a formula containing at least one unbound 
  -- occurrence of the variable. The result of applying kappa 
  -- to a variable and a formula is the set or class of things 
  -- that satisfy the formula. For example, we can denote the set or class
  -- of prime numbers that are less than 100 with the following expression:
  -- (KappaFn ?NUMBER (and (instance ?NUMBER PrimeNumber) 
  --                       (lessThan ?NUMBER 100))). 
  -- Note that the use of this function is discouraged, since there is 
  -- currently no axiomatic support for it.
  fun KappaFn : (c : Class) -> (Ind c -> Formula) -> Class ;

  -- DeductiveArguments that are not 
  -- ValidDeductiveArguments, i.e. it is not the case that the set of premises 
  -- in fact entails the conclusion.
  fun InvalidDeductiveArgument  : Class ;
  fun InvalidDeductiveArgument_Class : SubClass InvalidDeductiveArgument DeductiveArgument ;

  -- An Animal which has no spinal column.
  fun Invertebrate  : Class ;
  fun Invertebrate_Class : SubClass Invertebrate Animal ;

  -- The class of IntentionalPsychologicalProcesses 
  -- where the agent attempts to obtaina information (i.e. a Proposition denoted 
  -- by a Formula).
  fun Investigating  : Class ;
  fun Investigating_Class : SubClass Investigating IntentionalPsychologicalProcess ;

  -- Any RealNumber that is not also a 
  -- RationalNumber.
  fun IrrationalNumber  : Class ;
  fun IrrationalNumber_Class : SubClass IrrationalNumber RealNumber ;

  -- A LandArea that is completely surrounded by a WaterArea.
  fun Island  : Class ;
  fun Island_Class : SubClass Island LandArea ;

  -- The Class of all Months which are January.
  fun January  : Class ;
  fun January_Class : SubClass January Month ;

  -- The OrganizationalProcess of 
  -- becoming a member of an Organization.
  fun JoiningAnOrganization  : Class ;
  fun JoiningAnOrganization_Class : SubClass JoiningAnOrganization OrganizationalProcess ;

  -- SI energy measure. Symbol: J. It is the work 
  -- done when the point of application of 1 Newton is displaced a distance 
  -- of 1 Meter in the direction of the force. Joule = N*m = 
  -- m^2*kg*s^(_2).
  fun Joule  : Ind CompositeUnitOfMeasure ;

  -- The subclass of Selecting where the agent opts 
  -- for one belief out of a set of multiple possibilities that are available to 
  -- him/her.
  fun Judging  : Class ;
  fun Judging_Class : SubClass Judging Selecting ;

  -- JudicialOrganization is the class 
  -- of Organizations whose primary purpose is to render judgments according 
  -- to the statutes or regulations of a government or other organization. 
  -- Judicial bodies are not necessarily government organizations, for example, 
  -- those associated with sporting associations.
  fun JudicialOrganization  : Class ;
  fun JudicialOrganization_Class : SubClass JudicialOrganization Organization ;

  -- Any legal proceeding which is conducted 
  -- by a JudicialOrganization. Note that there is an important difference 
  -- between the concepts LegalAction and JudicialProcess. The former 
  -- refers to legal claims that are brought by a plaintiff, e.g. law suits, 
  -- while the second refers to trials and other sorts of judicial hearings 
  -- where the merits of a LegalAction are decided.
  fun JudicialProcess  : Class ;
  fun JudicialProcess_PoliticalProcess  : SubClassC JudicialProcess PoliticalProcess (\PROCESS -> forall Organization (\ORG -> agent(var PoliticalProcess Process ? PROCESS)(var Organization Agent ? ORG)));

  -- The Class of all Months which are July.
  fun July  : Class ;
  fun July_Class : SubClass July Month ;

  -- The Class of all Months which are June.
  fun June  : Class ;
  fun June_Class : SubClass June Month ;

  -- The Class of Processes where the agent 
  -- keeps something in a particular location for an extended period of time.
  fun Keeping  : Class ;
  fun Keeping_Class : SubClass Keeping IntentionalProcess ;

  -- SI UnitOfMeasure used
  -- with MeasureFn to produce terms denoting instances of
  -- TemperatureMeasure. Symbol: K. It is one of the base units in
  -- SI (it is also a unit in the ITS system). Kelvin differs from the
  -- Celsius scale in that the triple point of water is defined to be
  -- 273.16 KelvinDegrees while it is 0 CelsiusDegrees. The magnitudes
  -- of intervals in the two scales are the same. By definition the
  -- conversion constant is 273.15.
  fun KelvinDegree  : Ind UnitOfTemperature ;

  -- The subclass of Destruction in which the 
  -- death of an Organism is caused by an Organism. Note that in cases 
  -- of suicide the Organism would be the same in both cases.
  fun Killing  : Class ;
  fun Killing_Class : SubClass Killing Destruction ;

  -- One KiloByte (KB) of information. One 
  -- KiloByte is 1024 Bytes. Note that this sense of 'kilo' is 
  -- different from the one accepted in the SI system.
  fun KiloByte  : Ind UnitOfInformation ;

  -- A UnaryFunction that maps a UnitOfMeasure into 
  -- a UnitOfMeasure that is equal to 1,000 units of the original UnitOfMeasure. 
  -- For example, (KiloFn Gram) is 1,000 Grams.
  fun KiloFn  : El UnitOfMeasure -> Ind UnitOfMeasure;

  -- Supermultiple of Gramm. Symbol: kg. 1 Kilogram
  -- = 1000 Grams.
  fun Kilogram  : Ind UnitOfMass ;

  -- Supermultiple of Meter. Symbol: km. A
  -- Meter is the 1000th part of a Kilometer
  fun Kilometer  : Ind UnitOfLength ;

  -- An area which is predominantly solid ground, 
  -- e.g. a Nation, a mountain, a desert, etc. Note that a LandArea may 
  -- contain some relatively small WaterAreas. For example, Australia is 
  -- a LandArea even though it contains various rivers and lakes.
  fun LandArea  : Class ;
  fun LandArea_Class : SubClass LandArea GeographicArea ;

  -- LandTransitway is the subclass of 
  -- Transitway that represents areas intended for motion over the ground.
  fun LandTransitway  : Class ;
  fun LandTransitway_Class : SubClass LandTransitway (both LandArea Transitway) ;

  -- A system of signs for expressing thought. The 
  -- system can be either natural or artificial, i.e. something that emerges 
  -- gradually as a cultural artifact or something that is intentionally created 
  -- by a person or group of people.
  fun Language  : Class ;
  fun Language_Class : SubClass Language LinguisticExpression ;

  -- Form of most Invertebrates, Amphibians, and 
  -- Fish immediately after they hatch. This form is fundamentally unlike 
  -- the adult form, and metamorphosis is required to reach the latter form.
  fun Larval  : Ind DevelopmentalAttribute ;

  -- Attribute that applies to Propositions that are 
  -- required by a government or a branch of the government and that are enforced 
  -- with penalties for noncompliance. These Propositions may be codified as 
  -- legislation or they may be more informal, as in the case of government policy.
  fun Law  : Ind DeonticAttribute ;

  -- The Class of all leap years. These are years 
  -- which are either (i.) evenly divisible by 4 and not by 100 or (ii.) evenly 
  -- divisible by 400 (this latter case is known as a leap century).
  fun LeapYear  : Class ;
  fun LeapYear_Class : SubClass LeapYear Year ;

  -- The Class of Processes which relate to the 
  -- acquisition of information.
  fun Learning  : Class ;
  fun Learning_Class : SubClass Learning IntentionalPsychologicalProcess ;

  -- (LeastCommonMultipleFn 
  -- ?NUMBER1 ?NUMBER2 ... ?NUMBER) returns the least common multiple of 
  -- ?NUMBER1 through ?NUMBER.
  fun LeastCommonMultipleFn  : [El Integer] -> Ind Integer ;

  -- The OrganizationalProcess of 
  -- leaving an Organization, whether voluntarily or involuntarily.
  fun LeavingAnOrganization  : Class ;
  fun LeavingAnOrganization_Class : SubClass LeavingAnOrganization OrganizationalProcess ;

  -- This PositionalAttribute is derived from the 
  -- left/right schema. Note that this means directly to the left, so that, 
  -- if one object is to the left of another, then the projections of the 
  -- two objects overlap.
  fun Left  : Ind AntiSymmetricPositionalAttribute ;

  -- Any Process where a CognitiveAgent seeks 
  -- to obtain something through a court of law.
  fun LegalAction  : Class ;
  fun LegalAction_Class : SubClass LegalAction Contest ;

  -- A decision issued by a court with respect to 
  -- a LegalAction. Note that a LegalDecision is the act of Declaring a 
  -- decision of a court, it is not the act of judge or jury Deciding the merits 
  -- of a particular LegalAction.
  fun LegalDecision  : Class ;
  fun LegalDecision_Class : SubClass LegalDecision (both Declaring JudicialProcess) ;

  -- The subclass of Giving Processes where 
  -- the agent gives the destination something for a limited period of 
  -- time with the expectation that it will be returned later (perhaps with 
  -- interest).
  fun Lending  : Class ;
  fun Lending_Class : SubClass Lending Giving ;

  -- A subclass of
  -- ConstantQuantity, instances of which are measures of length.
  fun LengthMeasure  : Class ;
  fun LengthMeasure_Class : SubClass LengthMeasure ConstantQuantity ;

  -- The ProbabilityAttribute of being probable, i.e. more 
  -- likely than not to be True.
  fun Likely  : Ind ProbabilityAttribute ;

  -- A Communication that involves 
  -- the transfer of information via a LinguisticExpression.
  fun LinguisticCommunication  : Class ;
  fun LinguisticCommunication_Class : SubClass LinguisticCommunication Communication ;

  -- This is the subclass of 
  -- ContentBearingPhysical which are language_related. Note that this Class 
  -- encompasses both Language and the the elements of Languages, 
  -- e.g. Words.
  fun LinguisticExpression  : Class ;
  fun LinguisticExpression_Class : SubClass LinguisticExpression ContentBearingPhysical ;

  -- An Object has the Attribute of Liquid if 
  -- it has a fixed volume but not a fixed shape.
  fun Liquid  : Ind PhysicalState ;

  -- Any Mixture that satisfies two conditions, 
  -- viz. it is made up predominantly of things which are a Liquid and any 
  -- component other than Liquid in the Mixture is in the form of fine particles 
  -- which are suspended in the Liquid.
  fun LiquidMixture  : Class ;
  fun LiquidMixture_Class : SubClass LiquidMixture Mixture ;

  -- Any Motion where the patient is a 
  -- Liquid. This class would cover, in particular, the flow of 
  -- Water.
  fun LiquidMotion  : Class ;
  fun LiquidMotion_Class : SubClass LiquidMotion Motion ;

  -- Every List is a particular ordered n_tuple of 
  -- items. Generally speaking, Lists are created by means of the ListFn 
  -- Function, which takes any number of items as arguments and returns a 
  -- List with the items in the same order. Anything, including other 
  -- Lists, may be an item in a List. Note too that Lists are 
  -- extensional _ two lists that have the same items in the same order are 
  -- identical. Note too that a List may contain no items. In that case, 
  -- the List is the NullList.
  fun List  : Class ;

  -- A Function that returns the concatenation 
  -- of the two Lists that are given as arguments. For example, the value of 
  -- (ListConcatenateFn (ListFn Monday Tuesday) (ListFn Wednesday 
  -- Thursday)) would be (ListFn Monday Tuesday Wednesday Thursday).
  fun ListConcatenateFn  : El List -> El List -> Ind List ;

  -- A Function that takes any number of arguments and 
  -- returns the List containing those arguments in exactly the same order.
  fun ListFn  : [El Entity] -> Ind List ;

  -- A Function that takes a List as its sole 
  -- argument and returns the number of items in the List. For example, 
  -- (ListLengthFn (ListFn Monday Tuesday Wednesday)) would return the 
  -- value 3.
  fun ListLengthFn  : El List -> Ind NonnegativeInteger ;

  -- (ListOrderFn ?LIST ?NUMBER) denotes the item 
  -- that is in the ?NUMBER position in the List ?LIST. For example, 
  -- (ListOrderFn (ListFn Monday Tuesday Wednesday) 2) would return the 
  -- value Tuesday.
  fun ListOrderFn  : El List -> El PositiveInteger -> Ind Entity ;

  -- Any instance of Hearing which is intentional.
  fun Listening  : Class ;
  fun Listening_Class : SubClass Listening (both Hearing IntentionalProcess) ;

  -- Unit of volume in the metric
  -- system. It is currently defined to be equal to one cubic
  -- decimeter (0.001 cubic meter). Symbol: l.
  fun Liter  : Ind UnitOfVolume ;

  -- This Attribute applies to Organisms that are 
  -- alive.
  fun Living  : Ind AnimacyAttribute ;

  -- (LogFn ?NUMBER ?INT) returns the logarithm of the 
  -- RealNumber ?NUMBER in the base denoted by the Integer ?INT.
  fun LogFn  : El RealNumber -> El PositiveInteger -> Ind RealNumber ;

  -- This Class comprises all 
  -- of the logical operators (viz. 'and', 'or', 'not', '=>', and '<=>').
  fun LogicalOperator  : Class ;

  -- Any instance of Seeing which is intentional.
  fun Looking  : Class ;
  fun Looking_Class : SubClass Looking (both IntentionalProcess Seeing) ;

  -- SI luminous flux measure. Symbol: lm. It is the 
  -- amount streaming outward through one solid angle of 1 Steradian from a 
  -- uniform point source having an intensity of one Candela. Lumen = 
  -- cd*sr = cd * 1.
  fun Lumen  : Ind CompositeUnitOfMeasure ;

  -- SI illuminance measure. Symbol: lx. It is the 
  -- amount of illumination provided when one Lumen is evenly distributed 
  -- over an area of 1 square Meter. This is also equivalent to the 
  -- illumination that would exist on a surface all points of which are one 
  -- Meter from a point source of one Candela. Lux = lm/m^2 = 
  -- m^(_2)*cd.
  fun Lux  : Ind CompositeUnitOfMeasure ;

  -- Machines are Devices that that have a 
  -- well_defined resource and result and that automatically convert 
  -- the resource into the result.
  fun Machine  : Class ;
  fun Machine_Class : SubClass Machine Device ;

  -- The magnitude of a PhysicalQuantity is the 
  -- numeric value for the quantity. In other words, MagnitudeFn converts 
  -- a PhysicalQuantity with an associated UnitOfMeasure into an ordinary 
  -- RealNumber. For example, the magnitude of the ConstantQuantity 2 
  -- Kilometers is the RealNumber 2. Note that the magnitude of a 
  -- quantity in a given unit times that unit is equal to the original 
  -- quantity.
  fun MagnitudeFn  : El PhysicalQuantity -> Ind RealNumber ;

  -- The Class of Processes where the agent 
  -- cares for or maintains the Object.
  fun Maintaining  : Class ;
  fun Maintaining_Class : SubClass Maintaining IntentionalProcess ;

  -- The subclass of Creation in which an individual 
  -- Artifact or a type of Artifact is made.
  fun Making  : Class ;
  fun Making_Class : SubClass Making (both Creation IntentionalProcess) ;

  -- An Attribute indicating that an Organism is 
  -- male in nature.
  fun Male  : Ind SexAttribute ;

  -- A Vertebrate having a constant body temperature 
  -- and characterized by the presence of hair, mammary glands, and sweat 
  -- glands.
  fun Mammal  : Class ;
  fun Mammal_Class : SubClass Mammal WarmBloodedVertebrate ;

  -- The class of Male Humans.
  fun Man  : Class ;
  fun Man_Class : SubClass Man Human ;

  -- OrganizationalProcesses that involve overseeing 
  -- the activities of others. Note the key differences between RegulatoryProcess 
  -- and its sibling Managing. The latter implies a long_term relationship between 
  -- the manager and the managed, while the former implies a normative standard to which 
  -- the activities of the regulated are referred.
  fun Managing  : Class ;
  fun Managing_Class : SubClass Managing (both Guiding OrganizationalProcess) ;

  -- An intentional move or play within a Contest. 
  -- In many cases, a Maneuver is a realization of part of a strategy for 
  -- winning the Contest, but it also may be just an arbitrary or semi_arbitrary 
  -- division of the overarching Contest, e.g. innings in a baseball game.
  fun Maneuver  : Class ;
  fun Maneuver_Class : SubClass Maneuver IntentionalProcess ;

  -- A ManualHumanLanguage is a
  -- HumanLanguage which has as its medium gestures and movement, such 
  -- as the shape, position, and movement of the hands.
  fun ManualHumanLanguage  : Class ;
  fun ManualHumanLanguage_Class : SubClass ManualHumanLanguage HumanLanguage ;

  -- The Making of Artifacts on a mass 
  -- scale.
  fun Manufacture  : Class ;
  fun Manufacture_Class : SubClass Manufacture Making ;

  -- Any Corporation which manufactures Products.
  fun Manufacturer  : Class ;
  fun Manufacturer_Class : SubClass Manufacturer Corporation ;

  -- The Class of all Months which are March.
  fun March  : Class ;
  fun March_Class : SubClass March Month ;

  -- The Class of Mammals which have a pouch for 
  -- their young.
  fun Marsupial  : Class ;
  fun Marsupial_Class : SubClass Marsupial Mammal ;

  -- A subclass of
  -- ConstantQuantity, instances of which are measures of the amount of
  -- matter in an Object.
  fun MassMeasure  : Class ;
  fun MassMeasure_Class : SubClass MassMeasure ConstantQuantity ;

  -- The OrganizationalProcess of joining an 
  -- EducationalOrganization as a student.
  fun Matriculation  : Class ;
  fun Matriculation_Class : SubClass Matriculation JoiningAnOrganization ;

  -- (MaxFn ?NUMBER1 ?NUMBER2) is the largest of 
  -- ?NUMBER1 and ?NUMBER2. In cases where ?NUMBER1 is equal to ?NUMBER2, 
  -- MaxFn returns one of its arguments.
  fun MaxFn  : El Quantity -> El Quantity -> Ind Quantity ;

  -- This BinaryFunction assigns two 
  -- GraphNodes to the GraphPath with the largest sum of weighted arcs 
  -- between the two GraphNodes.
  fun MaximalWeightedPathFn  : El GraphNode -> El GraphNode -> Ind GraphPath ;

  -- The Class of all Months which are May.
  fun May  : Class ;
  fun May_Class : SubClass May Month ;

  -- This BinaryFunction maps a
  -- RealNumber and a UnitOfMeasure to that Number of units. It is
  -- used to express `measured' instances of PhysicalQuantity. Example:
  -- the concept of three meters is represented as (MeasureFn 3
  -- Meter).
  fun MeasureFn  : El RealNumber -> El UnitOfMeasure -> Ind PhysicalQuantity ;

  -- The Class of Calculating Processes where 
  -- the aim is to determine the PhysicalQuantity of some aspect of the patient.
  fun Measuring  : Class ;
  fun Measuring_Class : SubClass Measuring Calculating ;

  -- Any Device whose purpose is to measure a 
  -- PhysicalQuantity.
  fun MeasuringDevice  : Class ;
  fun MeasuringDevice_Class : SubClass MeasuringDevice Device ;

  -- Any Food which was originally part of an 
  -- Animal and is not ingested by drinking, including eggs and animal 
  -- blood that is eaten as food. Note that this class covers both raw 
  -- meat and meat that has been prepared in some way, e.g. by cooking. 
  -- Note too that preparations involving Meat and FruitOrVegetable 
  -- are classed directly under Food.
  fun Meat  : Class ;
  fun Meat_Class : SubClass Meat Food ;

  -- The coming together of two or more 
  -- CognitiveAgents for the purpose of Communication. This covers informal 
  -- meetings, e.g. visits with family members, and formal meetings, e.g. a board 
  -- of directors meeting.
  fun Meeting  : Class ;
  fun Meeting_Class : SubClass Meeting SocialInteraction ;

  -- One MegaByte (MB) of information. One 
  -- MegaByte is 1024 KiloBytes. Note that this sense of 'mega' is 
  -- different from the one accepted in the SI system.
  fun MegaByte  : Ind UnitOfInformation ;

  -- A UnaryFunction that maps a UnitOfMeasure into 
  -- a UnitOfMeasure that is equal to 1,000,000 units of the original 
  -- UnitOfMeasure. For example, (MegaFn Hertz) is 1,000,000 Hertz.
  fun MegaFn  : El UnitOfMeasure -> Ind UnitOfMeasure;

  -- The Class of Processes where an Object is 
  -- heated and converted from a Solid to a Liquid.
  fun Melting  : Class ;
  fun Melting_Class : SubClass Melting StateChange ;

  -- Any Corporation which sells 
  -- goods or services to customers for a profit.
  fun MercantileOrganization  : Class ;
  fun MercantileOrganization_Class : SubClass MercantileOrganization Corporation ;

  -- (MereologicalDifferenceFn ?OBJ1 ?OBJ2)
  -- denotes the Object consisting of the parts which belong to ?OBJ1 
  -- and not to ?OBJ2.
  fun MereologicalDifferenceFn  : El Object -> El Object -> Ind Object ;

  -- (MereologicalProductFn ?OBJ1 ?OBJ2) 
  -- denotes the Object consisting of the parts which belong to both ?OBJ1 
  -- and ?OBJ2.
  fun MereologicalProductFn  : El Object -> El Object -> Ind Object ;

  -- (MereologicalSumFn ?OBJ1 ?OBJ2) 
  -- denotes the Object consisting of the parts which belong to either 
  -- ?OBJ1 or ?OBJ2.
  fun MereologicalSumFn  : El Object -> El Object -> Ind Object ;

  -- A Metal is an ElementalSubstance that conducts heat 
  -- and electricity, is shiny and reflects many colors of light, and can be hammered 
  -- into sheets or drawn into wire. About 80% of the known chemical elements 
  -- (ElementalSubstances) are metals.
  fun Metal  : Class ;
  fun Metal_Class : SubClass Metal ElementalSubstance ;

  -- SI UnitOfLength. Symbol: m. It is one of the
  -- base units in SI, and it is currently defined as follows: the Meter 
  -- is the length of the path traveled by light in a vacuum during a time 
  -- interval of 1/299792458 of a SecondDuration.
  fun Meter  : Ind UnitOfLength ;

  -- A UnaryFunction that maps a UnitOfMeasure into 
  -- a UnitOfMeasure that is equal to .000001 units of the original UnitOfMeasure. 
  -- For example, (MicroFn Meter) is .000001 Meters.
  fun MicroFn  : El UnitOfMeasure -> Ind UnitOfMeasure;

  -- An Organism that can be seen only with the aid of a microscope.
  fun Microorganism  : Class ;
  fun Microorganism_Class : SubClass Microorganism Organism ;

  -- English length unit of miles.
  fun Mile  : Ind UnitOfLength ;

  -- MilitaryForce is the subclass of 
  -- Organizations that are organized along military lines and for the 
  -- purpose of either defensive or offensive combat, whether or not 
  -- the force is an official GovernmentOrganization.
  fun MilitaryForce  : Class ;
  fun MilitaryForce_Class : SubClass MilitaryForce PoliticalOrganization ;

  -- Any heavily armed Organization 
  -- that is part of a Government and that is charged with representing the 
  -- Government in international conflicts.
  fun MilitaryOrganization  : Class ;
  fun MilitaryOrganization_Class : SubClass MilitaryOrganization (both GovernmentOrganization MilitaryForce) ;

  -- Any Process that is carried out by a 
  -- military organization. Note that this class covers Processes, e.g. 
  -- military operations, that are the result of careful planning, as well as 
  -- those which are unscripted.
  fun MilitaryProcess  : Class ;
  fun MilitaryProcess_Class : SubClass MilitaryProcess PoliticalProcess ;

  -- A UnaryFunction that maps a UnitOfMeasure into 
  -- a UnitOfMeasure that is equal to .001 units of the original UnitOfMeasure. 
  -- For example, (MilliFn Gram) is .001 Grams.
  fun MilliFn  : El UnitOfMeasure -> Ind UnitOfMeasure;

  -- Submultiple of Meter. Symbol: mm. A millimeter
  -- is the 1000th part of a meter
  fun Millimeter  : Ind UnitOfLength ;

  -- (MinFn ?NUMBER1 ?NUMBER2) is the smallest of 
  -- ?NUMBER1 and ?NUMBER2. In cases where ?NUMBER1 is equal to ?NUMBER2, 
  -- MinFn returns one of its arguments.
  fun MinFn  : El Quantity -> El Quantity -> Ind Quantity ;

  -- Any of various naturally occurring homogeneous 
  -- substances (such as stone, coal, salt, sulfur, sand, petroleum), or 
  -- synthetic substances having the chemical composition and crystalline form 
  -- and properties of a naturally occurring mineral.
  fun Mineral  : Class ;
  fun Mineral_Class : SubClass Mineral Substance ;

  -- A UnaryFunction that assigns a Graph 
  -- the Class of GraphPaths which comprise cutsets for the Graph and 
  -- which have the least number of GraphArcs.
  fun MinimalCutSetFn : El Graph -> Desc GraphPath ;

  -- This BinaryFunction assigns two 
  -- GraphNodes to the GraphPath with the smallest sum of weighted arcs 
  -- between the two GraphNodes.
  fun MinimalWeightedPathFn  : El GraphNode -> El GraphNode -> Ind GraphPath ;

  -- The Class of all clock Minutes.
  fun Minute  : Class ;
  fun Minute_Class : SubClass Minute TimeInterval ;

  -- Time unit. 1 minute = 60 seconds.
  fun MinuteDuration  : Ind UnitOfDuration ;

  -- A BinaryFunction that assigns a PositiveRealNumber and 
  -- a subclass of Hours to the Minutes within each Hour corresponding to that 
  -- NonnegativeInteger. For example, (MinuteFn 30 (HourFn 17 Day)) is the Class 
  -- of all 5:30's in the afternoon. For another example, (MinuteFn 15 Hour) would return 
  -- the class of all instances of quarter past the hour. For still another example, 
  -- (MinuteFn 15 (HourFn 14 (DayFn 18 (MonthFn August (YearFn 1912))))) denotes 
  -- 15 minutes after 2 PM on the 18th day of August 1912.
  fun MinuteFn : El NonnegativeInteger -> Desc Hour -> Desc Minute ;

  -- A Mixture is two or more PureSubstances, 
  -- combined in varying proportions _ each retaining its own specific properties. 
  -- The components of a Mixture can be separated by physical means, i.e. without 
  -- the making and breaking of chemical bonds. Examples: Air, table salt thoroughly 
  -- dissolved in water, milk, wood, and concrete.
  fun Mixture  : Class ;
  fun Mixture_Class : SubClass Mixture Substance ;

  -- MmMercury is a UnitOfMeasure 
  -- for barometricPressure. It is used to express the number 
  -- of millimeters of mercury supported in a mercurial barometer
  --  by the surrounding air pressure.
  fun MmMercury  : Ind UnitOfAtmosphericPressure ;

  -- SI amount of substance
  -- unit. symbol: mol. It is one of the base units in SI. It is defined as
  -- follows: the Mole is the amount of substance of a system which
  -- contains as many elementary entities as there are atoms in 0.012
  -- Kilograms of carbon 12. Note that, when this UnitOfMeasure is
  -- used, the elementary entities must be specified _ they may be atoms,
  -- molecules, ions, electrons, etc. or groups of such particles.
  fun Mole  : Ind UnitOfMass ;

  -- A molecule is the smallest unit of matter of a 
  -- CompoundSubstance that retains all the physical and chemical properties 
  -- of that substance, e.g., Ne, H2, H2O. A molecule is two or more Atoms 
  -- linked by a chemical bond.
  fun Molecule  : Class ;
  fun Molecule_Class : SubClass Molecule CompoundSubstance ;

  -- Soft_bodied Invertebrate that is usually 
  -- contained in a shell. Includes oysters, clams, mussels, snails, slugs, 
  -- octopi, and squid.
  fun Mollusk  : Class ;
  fun Mollusk_Class : SubClass Mollusk Invertebrate ;

  -- The Class of all calendar Mondays.
  fun Monday  : Class ;
  fun Monday_Class : SubClass Monday Day ;

  -- Various Primates with relatively long 
  -- tails.
  fun Monkey  : Class ;
  fun Monkey_Class : SubClass Monkey Primate ;

  -- An Object with this Attribute has 
  -- the same color on every part of its surface.
  fun Monochromatic  : Ind ColorAttribute ;

  -- The Class of all calendar Months.
  fun Month  : Class ;
  fun Month_Class : SubClass Month TimeInterval ;

  -- Time unit. A month's duration is at least
  -- 28 days, and no more than 31 days. Note that this unit is a range, rather
  -- than an exact amount, unlike most other units.
  fun MonthDuration  : Ind UnitOfDuration ;

  -- A BinaryFunction that maps a subclass of Month and a 
  -- subclass of Year to the class containing the Months corresponding to thos Years. 
  -- For example (MonthFn January (YearFn 1912)) is the class containing the eighth 
  -- Month, i.e. August, of the Year 1912. For another example, (MonthFn August 
  -- Year) is equal to August, the class of all months of August. Note that this function 
  -- returns a Class as a value. The reason for this is that the related functions, viz. 
  -- DayFn, HourFn, MinuteFn, and SecondFn, are used to generate both specific TimeIntervals 
  -- and recurrent intervals, and the only way to do this is to make the domains and ranges of 
  -- these functions classes rather than individuals.
  fun MonthFn : Desc Month -> Desc Year -> Desc Month ;

  -- Part of a Word which cannot be subdivided 
  -- and which expresses a meaning.
  fun Morpheme  : Class ;
  fun Morpheme_Class : SubClass Morpheme LinguisticExpression ;

  -- A NonFloweringPlant without true roots and little 
  -- if any vascular tissue.
  fun Moss  : Class ;
  fun Moss_Class : SubClass Moss NonFloweringPlant ;

  -- Any Process of movement.
  fun Motion  : Class ;
  fun Motion_Class : SubClass Motion Process ;

  -- Motion where an Object is moving toward the 
  -- ground.
  fun MotionDownward  : Class ;
  fun MotionDownward_Class : SubClass MotionDownward Motion ;

  -- A ContentBearingObject which depicts motion 
  -- (and which may have an audio or text component as well). This Class covers 
  -- films, videos, etc.
  fun MotionPicture  : Class ;
  fun MotionPicture_Class : SubClass MotionPicture Text ;

  -- Motion where an Object is moving away from the ground.
  fun MotionUpward  : Class ;
  fun MotionUpward_Class : SubClass MotionUpward Motion ;

  -- A TimeZone that covers much of the 
  -- Rocky Mountain region of the United States.
  fun MountainTimeZone  : Ind TimeZone ;

  -- The Class of multigraphs. A multigraph 
  -- is a Graph containing at least one pair of GraphNodes that are 
  -- connected by more than one GraphArc.
  fun MultiGraph  : Class ;
  fun MultiGraph_Class : SubClass MultiGraph Graph ;

  -- If ?NUMBER1 and ?NUMBER2 are Numbers, 
  -- then (MultiplicationFn ?NUMBER1 ?NUMBER2) is the arithmetical product 
  -- of these numbers.
  fun MultiplicationFn  : El Quantity -> El Quantity -> Ind Quantity ;

  -- Nonrigid Tissue appearing only in Animals and 
  -- composed largely of contractile cells.
  fun Muscle  : Class ;
  fun Muscle_Class : SubClass Muscle (both AnimalSubstance Tissue) ;

  -- The subclass of RadiatingSound where the 
  -- sound is intended to be melodic and is produced deliberately.
  fun Music  : Class ;
  fun Music_Class : SubClass Music RadiatingSound ;

  -- A Device which is manipulated by a Human 
  -- and whose purpose is to produce Music.
  fun MusicalInstrument  : Class ;
  fun MusicalInstrument_Class : SubClass MusicalInstrument Device ;

  -- A SetOrClass is a MutuallyDisjointClass 
  -- just in case there exists nothing which is an instance of all of the instances of 
  -- the original SetOrClass.
  fun MutuallyDisjointClass  : Class ;
  fun MutuallyDisjointClass_Class : SubClass MutuallyDisjointClass SetOrClass ;

  -- A Class of Arthropods that includes 
  -- centipedes and millipedes.
  fun Myriapod  : Class ;
  fun Myriapod_Class : SubClass Myriapod Arthropod ;

  -- A Promise where nothing is promised in return, 
  -- i.e. a nudum pactum.
  fun NakedPromise  : Ind DeonticAttribute ;

  -- The Process of assigning a name to someone or something.
  fun Naming  : Class ;
  fun Naming_Class : SubClass Naming Declaring ;

  -- A UnaryFunction that maps a UnitOfMeasure into 
  -- a UnitOfMeasure that is equal to .000000001 units of the original 
  -- UnitOfMeasure. For example, (MicroFn SecondDuration) is .000000001 
  -- SecondDurations.
  fun NanoFn  : El UnitOfMeasure -> Ind UnitOfMeasure;

  -- The broadest GeopoliticalArea, i.e. Nations are 
  -- GeopoliticalAreas that are not part of any other overarching and 
  -- comprehensive governance structure (excepting commonwealths and other sorts 
  -- of loose international organizations).
  fun Nation  : Class ;
  fun Nation_Class : SubClass Nation (both GeopoliticalArea LandArea) ;

  -- The subclass of HumanLanguages which 
  -- are not designed and which evolve from generation to generation. This 
  -- Class includes all of the national languages, e.g. English, Spanish, 
  -- Japanese, etc. Note that this class includes dialects of natural 
  -- languages.
  fun NaturalLanguage  : Class ;
  fun NaturalLanguage_Class : SubClass NaturalLanguage HumanLanguage ;

  -- A Process that take place in nature
  -- spontanously.
  fun NaturalProcess  : Class ;
  fun NaturalProcess_Class : SubClass NaturalProcess Process ;

  -- Any Substance that is not the result of 
  -- an IntentionalProcess, i.e. any substance that occurs naturally.
  fun NaturalSubstance  : Class ;
  fun NaturalSubstance_Class : SubClass NaturalSubstance Substance ;

  -- The relation of common sense adjacency. Note that, if 
  -- an object is Near another object, then the objects are not connected.
  fun Near  : Ind SymmetricPositionalAttribute ;

  -- Attribute that applies to Propositions that are 
  -- necessary, i.e. true in every possible world.
  fun Necessity  : Ind AlethicAttribute ;

  -- The TimePoint that is before all other TimePoints.
  fun NegativeInfinity  : Ind TimePoint ;

  -- An Integer that is less than zero.
  fun NegativeInteger  : Class ;
  fun NegativeInteger_Class : SubClass NegativeInteger (both Integer NegativeRealNumber) ;

  -- A RealNumber that is less than zero.
  fun NegativeRealNumber  : Class ;
  fun NegativeRealNumber_RealNumber  : SubClassC NegativeRealNumber RealNumber 
                                                 (\NUMBER -> lessThan (var RealNumber Quantity ? NUMBER)
                                                                      (el Integer Quantity ? (toInt 0)));

  -- A system in Vertebrates that is made up of 
  -- the Brain, the spinal cord, nerves, etc.
  fun NervousSystem  : Class ;
  fun NervousSystem_Class : SubClass NervousSystem (both AnimalAnatomicalStructure Organ) ;

  -- Components of the AtomicNucleus. They have no charge.
  fun Neutron  : Class ;
  fun Neutron_Class : SubClass Neutron SubatomicParticle ;

  -- SI force measure. Symbol: N. It is that force 
  -- which gives to a mass of 1 kilogram an acceleration of 1 Meter per 
  -- SecondDuration. Newton = m*kg*s^(_2).
  fun Newton  : Ind CompositeUnitOfMeasure ;

  -- Instances of
  -- this Class are UnitsOfMeasure that are applied to a single
  -- dimension, and so are not intrinsically defined by the functional
  -- composition of other units.
  fun NonCompositeUnitOfMeasure  : Class ;
  fun NonCompositeUnitOfMeasure_Class : SubClass NonCompositeUnitOfMeasure UnitOfMeasure ;

  -- A Plant that reproduces with spores and 
  -- does not produce flowers.
  fun NonFloweringPlant  : Class ;
  fun NonFloweringPlant_Class : SubClass NonFloweringPlant Plant ;

  -- The stage of an Organism before it is FullyFormed.
  fun NonFullyFormed  : Ind DevelopmentalAttribute ;

  -- Any SetOrClass that contains at least one instance.
  fun NonNullSet  : Class ;
  fun NonNullSet_Class : SubClass NonNullSet SetOrClass ;

  -- An Integer that is greater than or equal to zero.
  fun NonnegativeInteger  : Class ;
  fun NonnegativeInteger_Class : SubClass NonnegativeInteger (both Integer NonnegativeRealNumber) ;

  -- A RealNumber that is greater than or equal to zero.
  fun NonnegativeRealNumber  : Class ;
  fun NonnegativeRealNumber_RealNumber  : SubClassC NonnegativeRealNumber RealNumber (\NUMBER -> greaterThanOrEqualTo(var RealNumber Quantity ? NUMBER)(el Integer Quantity ? (toInt 0)));

  -- A Class containing all of the 
  -- Attributes that are specific to morality, legality, aesthetics, 
  -- etiquette, etc. Many of these attributes express a judgement that 
  -- something ought or ought not to be the case.
  fun NormativeAttribute  : Class ;
  fun NormativeAttribute_Class : SubClass NormativeAttribute RelationalAttribute ;

  -- The compass direction of North.
  fun North  : Ind DirectionalAttribute ;

  -- One of the parts of speech. The Class of Words 
  -- that conventionally denote Objects.
  fun Noun  : Class ;
  fun Noun_Class : SubClass Noun Word ;

  -- A Phrase that has the same function as a Noun.
  fun NounPhrase  : Class ;
  fun NounPhrase_Class : SubClass NounPhrase Phrase ;

  -- The Class of all Months which are November.
  fun November  : Class ;
  fun November_Class : SubClass November Month ;

  -- The List that has no items. The uniqueness of 
  -- NullList follows from the extensionality of Lists, i.e. the fact that 
  -- two Lists with the same items in the same order are identical.
  fun NullList  : Ind List ;

  -- Any SetOrClass that contains no instances.
  fun NullSet  : Class ;
  fun NullSet_Class : SubClass NullSet SetOrClass ;

  -- A measure of how many things there are, or how
  -- much there is, of a certain kind. Numbers are subclassed into 
  -- RealNumber, ComplexNumber, and ImaginaryNumber.
  fun Number  : Class ;
  fun Number_Class : SubClass Number Quantity ;

  -- NumberE is the RealNumber that is the base for 
  -- natural logarithms. It is approximately equal to 2.718282.
  fun NumberE  : Ind PositiveRealNumber ;

  -- (NumeratorFn ?NUMBER) returns the numerator 
  -- of the canonical reduced form ?NUMBER.
  fun NumeratorFn  : El RealNumber -> Ind Integer ;

  -- A BiologicallyActiveSubstance required by an Organism. 
  -- It is generally ingested as Food, and it is of primary interest because of its role 
  -- in the biologic functioning of the Organism.
  fun Nutrient  : Class ;
  fun Nutrient_Class : SubClass Nutrient BiologicallyActiveSubstance ;

  -- Corresponds roughly to the class of ordinary 
  -- objects. Examples include normal physical objects, geographical regions, 
  -- and locations of Processes, the complement of Objects in the Physical 
  -- class. In a 4D ontology, an Object is something whose spatiotemporal 
  -- extent is thought of as dividing into spatial parts roughly parallel to the 
  -- time_axis.
  fun Object  : Class ;
  fun Object_Class : SubClass Object Physical ;

  -- The Class of NormativeAttributes that are 
  -- associated with an objective criterion for their attribution, i.e. there is 
  -- broad consensus about the cases where these attributes are applicable.
  fun ObjectiveNorm  : Class ;
  fun ObjectiveNorm_Class : SubClass ObjectiveNorm NormativeAttribute ;

  -- Attribute that applies to Propositions that an 
  -- Agent is required, by some authority, to make true.
  fun Obligation  : Ind DeonticAttribute ;

  -- The Class of all Months which are October.
  fun October  : Class ;
  fun October_Class : SubClass October Month ;

  -- An Integer that is not evenly divisible by 2.
  fun OddInteger  : Class ;
  fun OddInteger_Class : SubClass OddInteger Integer ;

  -- The subclass of Committing in which a 
  -- CognitiveAgent offers something Physical to another agent. Offerings 
  -- may be unconditional (in which case they are a promise to effect a 
  -- UnilateralGiving) or conditional (in which case they are a promise to 
  -- effect a Transaction of some sort).
  fun Offering  : Class ;
  fun Offering_Class : SubClass Offering Committing ;

  -- SI electric resistance measure. It is the electric
  -- resistance between two points of a conductor when a constant difference 
  -- of potential of 1 Volt, applied between these two points,
  -- produces in this conductor a current of 1 Ampere, this conductor not
  -- being the force of any electromotive force. Ohm = V/A = 
  -- m^2*kg*s^(_3)*A^(_2).
  fun Ohm  : Ind CompositeUnitOfMeasure ;

  -- The Class of properties that are 
  -- detectable by smell.
  fun OlfactoryAttribute  : Class ;
  fun OlfactoryAttribute_Class : SubClass OlfactoryAttribute PerceptualAttribute ;

  -- This is used to assert that an object is on top of 
  -- another object, and it is derived from the up/down schema and involves 
  -- contact.
  fun On  : Ind AntiSymmetricPositionalAttribute ;

  -- The class of GeometricFigures that 
  -- have position and an extension along a single dimension, viz. straight lines.
  fun OneDimensionalFigure  : Class ;
  fun OneDimensionalFigure_Class : SubClass OneDimensionalFigure GeometricFigure ;

  -- The class of TwoDimensionalFigures that 
  -- are not ClosedTwoDimensionalFigures.
  fun OpenTwoDimensionalFigure  : Class ;
  fun OpenTwoDimensionalFigure_Class : SubClass OpenTwoDimensionalFigure TwoDimensionalFigure ;

  -- A Directing in which the receiver is 
  -- commanded to realize the content of a ContentBearingObject. Orders 
  -- are injunctions, the disobedience of which involves sanctions, or 
  -- which express an obligation upon the part of the orderee.
  fun Ordering  : Class ;
  fun Ordering_Class : SubClass Ordering Directing ;

  -- A somewhat independent BodyPart that performs a 
  -- specialized function. Note that this functional definition covers bodily 
  -- systems, e.g. the digestive system or the central nervous system.
  fun Organ  : Class ;
  fun Organ_Class : SubClass Organ BodyPart ;

  -- A PhysiologicProcess of a 
  -- particular Organ or Tissue.
  fun OrganOrTissueProcess  : Class ;
  fun OrganOrTissueProcess_Class : SubClass OrganOrTissueProcess AutonomicProcess ;

  -- This class encompasses Organisms, 
  -- CorpuscularObjects that are parts of Organisms, i.e. BodyParts, 
  -- and CorpuscularObjects that are nonintentionally produced by 
  -- Organisms, e.g. ReproductiveBodies.
  fun OrganicObject  : Class ;
  fun OrganicObject_Class : SubClass OrganicObject CorpuscularObject ;

  -- Generally, a living individual, including all 
  -- Plants and Animals.
  fun Organism  : Class ;
  fun Organism_Class : SubClass Organism (both Agent OrganicObject) ;

  -- A physiologic function of the 
  -- Organism as a whole, of multiple organ systems or of multiple 
  -- Organs or Tissues.
  fun OrganismProcess  : Class ;
  fun OrganismProcess_Class : SubClass OrganismProcess PhysiologicProcess ;

  -- An Organization is a corporate or similar 
  -- institution. The members of an Organization typically have a common 
  -- purpose or function. Note that this class also covers divisions, departments, 
  -- etc. of organizations. For example, both the Shell Corporation and the 
  -- accounting department at Shell would both be instances of Organization. 
  -- Note too that the existence of an Organization is dependent on the existence 
  -- of at least one member (since Organization is a subclass of Collection). 
  -- Accordingly, in cases of purely legal organizations, a fictitious member 
  -- should be assumed.
  fun Organization  : Class ;
  fun Organization_Class : SubClass Organization (both CognitiveAgent Group) ;

  -- An IntentionalProcess that involves an Organization.
  fun OrganizationalProcess  : Class ;
  fun OrganizationalProcess_Class : SubClass OrganizationalProcess IntentionalProcess ;

  -- English unit of volume equal to 1/8 of a Cup.
  fun Ounce  : Ind UnitOfVolume ;

  -- The class of ClosedTwoDimensionalFigures that are 
  -- produced by the intersection of a Cone with a ClosedTwoDimensionalFigure.
  fun Oval  : Class ;
  fun Oval_Class : SubClass Oval ClosedTwoDimensionalFigure ;

  -- A TimeZone that covers much of the 
  -- western part of the United States.
  fun PacificTimeZone  : Ind TimeZone ;

  -- A SetOrClass is a PairwiseDisjointClass 
  -- just in case every instance of the SetOrClass is either equal to or disjoint 
  -- from every other instance of the SetOrClass.
  fun PairwiseDisjointClass  : Class ;
  fun PairwiseDisjointClass_Class : SubClass PairwiseDisjointClass SetOrClass ;

  -- An Organization which is much like 
  -- a MilitaryOrganization, e.g. it is made up of armed fighters, except that it 
  -- is not associated with a Government.
  fun ParamilitaryOrganization  : Class ;
  fun ParamilitaryOrganization_Class : SubClass ParamilitaryOrganization MilitaryForce ;

  -- An umbrella Class for any Word that does not 
  -- fit into the other subclasses of Word. A ParticleWord is generally a small 
  -- term that serves a grammatical or logical function, e.g. 'and', 'of', 
  -- 'since', etc. At some point, this class might be broken up into the 
  -- subclasses 'Connective', 'Preposition', etc. Note that the class ParticleWord 
  -- includes both personal and possessive pronouns, e.g. 'she', 'hers', 'it', 'its', 
  -- etc.
  fun ParticleWord  : Class ;
  fun ParticleWord_Class : SubClass ParticleWord Word ;

  -- SI pressure measure. Symbol:Pa. It is the 
  -- pressure of one Newton per square Meter. Pascal = N/m^2 
  -- = m^(_1)*kg*s^(_2).
  fun Pascal  : Ind CompositeUnitOfMeasure ;

  -- A UnaryFunction that maps a TimePosition 
  -- to the TimeInterval that meets it and that begins at 
  -- NegativeInfinity.
  fun PastFn  : El TimePosition -> Ind TimeInterval ;

  -- A Certificate that expresses the content of an 
  -- invention that has been accorded legal protection by a governemental 
  -- entity.
  fun Patent  : Class ;
  fun Patent_Class : SubClass Patent Certificate ;

  -- A UnaryFunction that maps a GraphPath to 
  -- the sum of the arcWeights on the GraphArcs in the GraphPath.
  fun PathWeightFn  : El GraphPath -> Ind Quantity ;

  -- A disordered process, activity, or 
  -- state of the Organism as a whole, of a body system or systems, or of 
  -- multiple Organs or Tissues. Included here are normal responses to a 
  -- negative stimulus as well as patholologic conditions or states that are 
  -- less specific than a disease. Pathologic functions frequently have 
  -- systemic effects.
  fun PathologicProcess  : Class ;
  fun PathologicProcess_Class : SubClass PathologicProcess BiologicalProcess ;

  -- PerFn maps two instances of PhysicalQuantity to 
  -- the FunctionQuantity composed of these two instances. For example, 
  -- (PerFn (MeasureFn 2 (MicroFn Gram)) (MeasureFn 1 (KiloFn 
  -- Gram))) denotes the FunctionQuantity of 2 micrograms per kiogram. 
  -- This function is useful, because it allows the knowledge engineer to 
  -- dynamically generate instances of FunctionQuantity.
  fun PerFn  : El PhysicalQuantity -> El PhysicalQuantity -> Ind FunctionQuantity ;

  -- Sensing some aspect of the material world. 
  -- Note that the agent of this sensing is assumed to be an Animal.
  fun Perception  : Class ;
  fun Perception_Class : SubClass Perception PsychologicalProcess ;

  -- Any Attribute whose presence is detected 
  -- by an act of Perception.
  fun PerceptualAttribute  : Class ;
  fun PerceptualAttribute_Class : SubClass PerceptualAttribute InternalAttribute ;

  -- A Series whose elements are published separately 
  -- and on a periodic basis.
  fun Periodical  : Class ;
  fun Periodical_Class : SubClass Periodical Series ;

  -- A BinaryFunction that maps a subclass of 
  -- Periodical and a number to all of the issues of the Periodical corresponding 
  -- to the number.
  fun PeriodicalIssueFn : Desc Periodical -> El PositiveInteger -> Desc Periodical ;

  -- A Residence where people live, i.e. 
  -- where people have a home.
  fun PermanentResidence  : Class ;
  fun PermanentResidence_Class : SubClass PermanentResidence Residence ;

  -- Attribute that applies to Propositions that an 
  -- Agent is permitted, by some authority, to make true.
  fun Permission  : Ind DeonticAttribute ;

  -- A set of Words in a Language which form a unit, 
  -- i.e. express a meaning in the Language.
  fun Phrase  : Class ;
  fun Phrase_Class : SubClass Phrase LinguisticExpression ;

  -- An entity that has a location in space_time. 
  -- Note that locations are themselves understood to have a location in 
  -- space_time.
  fun Physical  : Class ;
  fun Physical_Class : SubClass Physical Entity ;

  -- An InternalAttribute given by physical
  -- properties of the object.
  fun PhysicalAttribute  : Class ;
  fun PhysicalAttribute_Class : SubClass PhysicalAttribute InternalAttribute ;

  -- A PhysicalQuantity is a measure of 
  -- some quantifiable aspect of the modeled world, such as 'the earth's 
  -- diameter' (a constant length) and 'the stress in a loaded deformable 
  -- solid' (a measure of stress, which is a function of three spatial 
  -- coordinates). Every PhysicalQuantity is either a ConstantQuantity
  -- or FunctionQuantity. Instances of ConstantQuantity are dependent 
  -- on a UnitOfMeasure, while instances of FunctionQuantity are 
  -- Functions that map instances of ConstantQuantity to other instances 
  -- of ConstantQuantity (e.g., a TimeDependentQuantity is a
  -- FunctionQuantity). Although the name and definition of 
  -- PhysicalQuantity is borrowed from physics, a PhysicalQuantity need 
  -- not be material. Aside from the dimensions of length, time, velocity, 
  -- etc., nonphysical dimensions such as currency are also possible. 
  -- Accordingly, amounts of money would be instances of PhysicalQuantity. 
  -- A PhysicalQuantity is distinguished from a pure Number by the fact that 
  -- the former is associated with a dimension of measurement.
  fun PhysicalQuantity  : Class ;
  fun PhysicalQuantity_Class : SubClass PhysicalQuantity Quantity ;

  -- The physical state of an Object. There 
  -- are three reified instances of this Class: Solid, Liquid, and Gas. 
  -- Physical changes are not characterized by the transformation of one 
  -- substance into another, but rather by the change of the form (physical 
  -- states) of a given substance. For example, melting an iron nail yields a 
  -- substance still called iron.
  fun PhysicalState  : Class ;
  fun PhysicalState_Class : SubClass PhysicalState InternalAttribute ;

  -- PhysicalSystem is the class of complex 
  -- Physical things. A PhysicalSystem may have one or more 
  -- corresponding abstract Graph representations.
  fun PhysicalSystem  : Class ;
  fun PhysicalSystem_Class : SubClass PhysicalSystem Physical ;

  -- A normal process of an Organism 
  -- or part of an Organism.
  fun PhysiologicProcess  : Class ;
  fun PhysiologicProcess_Class : SubClass PhysiologicProcess BiologicalProcess ;

  -- Pi is the RealNumber that 
  -- is the ratio of the perimeter of a circle to its diameter. It is 
  -- approximately equal to 3.141592653589793.
  fun Pi  : Ind PositiveRealNumber ;

  -- A UnaryFunction that maps a UnitOfMeasure into 
  -- a UnitOfMeasure that is equal to .000000000001 units of the original 
  -- UnitOfMeasure. For example, (PicoFn SecondDuration) is .000000000001 
  -- SecondDurations.
  fun PicoFn  : El UnitOfMeasure -> Ind UnitOfMeasure;

  -- English unit of volume equal to 1/2 of a 
  -- Quart.
  fun Pint  : Ind UnitOfVolume ;

  -- A specification of a sequence of Processes which 
  -- is intended to satisfy a specified purpose at some future time.
  fun Plan  : Class ;
  fun Plan_Class : SubClass Plan Procedure ;

  -- The value of an angle in a plane.
  fun PlaneAngleMeasure  : Class ;
  fun PlaneAngleMeasure_Class : SubClass PlaneAngleMeasure AngleMeasure ;

  -- Specifying a set of actions in order to meet a 
  -- set of goals or objectives.
  fun Planning  : Class ;
  fun Planning_Class : SubClass Planning IntentionalPsychologicalProcess ;

  -- An Organism having cellulose cell walls, growing 
  -- by synthesis of Substances, generally distinguished by the presence of 
  -- chlorophyll, and lacking the power of locomotion.
  fun Plant  : Class ;
  fun Plant_Organism  : SubClassC Plant Organism (\PLANT -> and (forall PlantSubstance (\SUBSTANCE -> part(var PlantSubstance Object ? SUBSTANCE)(var Organism Object ? PLANT))) (forall PlantAnatomicalStructure (\STRUCTURE -> part(var PlantAnatomicalStructure Object ? STRUCTURE)(var Organism Object ? PLANT))));

  -- AnatomicalStructures that 
  -- are possessed exclusively by Plants.
  fun PlantAnatomicalStructure  : Class ;
  fun PlantAnatomicalStructure_Class : SubClass PlantAnatomicalStructure AnatomicalStructure ;

  -- BodySubstances that are produced 
  -- exclusively by Plants.
  fun PlantSubstance  : Class ;
  fun PlantSubstance_Class : SubClass PlantSubstance BodySubstance ;

  -- An extremely energetic PhysicalState that consists 
  -- of atomic nuclei stripped of electrons. That is, a plasma is composed of 
  -- positive ions and free electrons. Plasma behaves differently enough from 
  -- Gas that it is referred to as the fourth state of matter.
  fun Plasma  : Ind PhysicalState ;

  -- The shape of an Object with this Attribute 
  -- can easily be altered.
  fun Pliable  : Ind InternalAttribute ;

  -- A Poisoning is caused by an external 
  -- substance. Since Poisoning is not possible without some biologic 
  -- function which affects the Organism being injured, it is a subclass 
  -- of BiologicalProcess.
  fun Poisoning  : Class ;
  fun Poisoning_Class : SubClass Poisoning Injuring ;

  -- The Class of Processes where the agent
  -- pierces the surface of the Object with an instrument.
  fun Poking  : Class ;
  fun Poking_Class : SubClass Poking IntentionalProcess ;

  -- Any GovernmentOrganization 
  -- that is charged with domestic enforcement of the laws of the Government.
  fun PoliceOrganization  : Class ;
  fun PoliceOrganization_Class : SubClass PoliceOrganization GovernmentOrganization ;

  -- An Organization that is attempting to bring about some sort 
  -- of political change.
  fun PoliticalOrganization  : Class ;
  fun PoliticalOrganization_Class : SubClass PoliticalOrganization Organization ;

  -- An OrganizationalProcess carried 
  -- out by, for or against officially constituted governments. Some examples 
  -- would be voting on proposed legislation, electing a government representative, 
  -- or even overthrowing a government in a revolution.
  fun PoliticalProcess  : Class ;
  fun PoliticalProcess_Class : SubClass PoliticalProcess OrganizationalProcess ;

  -- A powder produced by FloweringPlants that contains male 
  -- gametes and is capable of fertilizing the seeds of FloweringPlants of the same 
  -- species.
  fun Pollen  : Class ;
  fun Pollen_Class : SubClass Pollen (both PlantAnatomicalStructure ReproductiveBody) ;

  -- An Object with this Attribute has 
  -- different colors on different parts of its surface.
  fun Polychromatic  : Ind ColorAttribute ;

  -- A formal position of reponsibility within an 
  -- Organization. Examples of Positions include president, laboratory 
  -- director, senior researcher, sales representative, etc.
  fun Position  : Class ;
  fun Position_Class : SubClass Position SocialRole ;

  -- Attributes characterizing the 
  -- orientation of an Object, e.g. Vertical versus Horizontal, Left 
  -- versus Right etc.
  fun PositionalAttribute  : Class ;
  fun PositionalAttribute_Class : SubClass PositionalAttribute RelationalAttribute ;

  -- The TimePoint that is after all other TimePoints.
  fun PositiveInfinity  : Ind TimePoint ;

  -- An Integer that is greater than zero.
  fun PositiveInteger  : Class ;
  fun PositiveInteger_Class : SubClass PositiveInteger (both NonnegativeInteger PositiveRealNumber) ;

  -- A RealNumber that is greater than 
  -- zero.
  fun PositiveRealNumber  : Class ;
  fun PositiveRealNumber_NonnegativeRealNumber  : SubClassC PositiveRealNumber NonnegativeRealNumber (\NUMBER -> greaterThan(var NonnegativeRealNumber Quantity ? NUMBER)(el Integer Quantity ? (toInt 0)));

  -- Attribute that applies to Propositions that are 
  -- possible, i.e. true in at least one possible world.
  fun Possibility  : Ind AlethicAttribute ;

  -- English pound of force. The conversion
  -- factor depends on the local value of the acceleration of free fall. A
  -- mean value is used in the conversion axiom associated with this 
  -- constant.
  fun PoundForce  : Ind CompositeUnitOfMeasure ;

  -- English mass unit of pounds.
  fun PoundMass  : Ind UnitOfMass ;

  -- (PowerSetFn ?CLASS) maps the SetOrClass 
  -- ?CLASS to the SetOrClass of all subclasses of ?CLASS.
  fun PowerSetFn : El SetOrClass -> Desc SetOrClass ;

  -- Precipitation is the process of 
  -- water molecules falling from the air to the ground, in either a 
  -- liquid or frozen state.
  fun Precipitation  : Class ;
  fun Precipitation_Class : SubClass Precipitation (both Falling (both WaterMotion WeatherProcess)) ;

  -- A unary function that maps an Integer to 
  -- its predecessor, e.g. the predecessor of 5 is 4.
  fun PredecessorFn  : El Integer -> Ind Integer ;

  -- The Class of IntentionalPsychologicalProcesses 
  -- which involve the formulation of a Proposition about a state of affairs 
  -- which might be realized in the future.
  fun Predicting  : Class ;
  fun Predicting_Class : SubClass Predicting IntentionalPsychologicalProcess ;

  -- (PremisesFn ?ARGUMENT) returns the complete 
  -- set of premises of the Argument ?ARGUMENT.
  fun PremisesFn  : El Argument -> Ind Proposition ;

  -- A Phrase that begins with a 
  -- preposition and that functions as an Adjective or an Adverb.
  fun PrepositionalPhrase  : Class ;
  fun PrepositionalPhrase_Class : SubClass PrepositionalPhrase Phrase ;

  -- Any SocialInteraction where a 
  -- CognitiveAgent or Group of CognitiveAgents attempts to make 
  -- another CognitiveAgent or Group of CognitiveAgents believe 
  -- something that is false. This covers deceit, affectation, 
  -- impersonation, and entertainment productions, to give just a few 
  -- examples.
  fun Pretending  : Class ;
  fun Pretending_Class : SubClass Pretending SocialInteraction ;

  -- Colors which can be blended to form any 
  -- color and which cannot be derived from any other colors.
  fun PrimaryColor  : Class ;
  fun PrimaryColor_Class : SubClass PrimaryColor ColorAttribute ;

  -- The Class of Mammals which are 
  -- Primates.
  fun Primate  : Class ;
  fun Primate_Class : SubClass Primate Mammal ;

  -- An Integer that is evenly divisible only 
  -- by itself and 1.
  fun PrimeNumber  : Class ;
  fun PrimeNumber_Class : SubClass PrimeNumber Integer ;

  -- A class containing all of the Attributes 
  -- relating to objective, qualitative assessments of probability, e.g. Likely and 
  -- Unlikely.
  fun ProbabilityAttribute  : Class ;
  fun ProbabilityAttribute_Class : SubClass ProbabilityAttribute ObjectiveNorm ;

  -- One of the basic ProbabilityRelations, 
  -- ProbabilityFn is used to state the a priori probability of a state of 
  -- affairs. (ProbabilityFn ?FORMULA) denotes the a priori probability 
  -- of ?FORMULA.
  fun ProbabilityFn  : Formula -> Ind RealNumber ;

  -- A sequence_dependent specification. Some 
  -- examples are ComputerPrograms, finite_state machines, cooking recipes, 
  -- musical scores, conference schedules, driving directions, and the scripts 
  -- of plays and movies.
  fun Procedure  : Class ;
  fun Procedure_Class : SubClass Procedure Proposition ;

  -- The class of things that happen 
  -- and have temporal parts or stages. Examples include extended events 
  -- like a football match or a race, actions like Pursuing and Reading, 
  -- and biological processes. The formal definition is: anything that occurs in
  -- time but is not an Object. Note that a Process may have 
  -- participants 'inside' it which are Objects, such as the players 
  -- in a football match. In a 4D ontology, a Process is something whose 
  -- spatiotemporal extent is thought of as dividing into temporal stages 
  -- roughly perpendicular to the time_axis.
  fun Process  : Class ;
  fun Process_Class : SubClass Process Physical ;

  -- An Artifact that is produced by Manufacture.
  fun Product  : Class ;
  fun Product_Class : SubClass Product Artifact ;

  -- Prohibition is the DeonticAttribute that 
  -- applies to Formulas that an Agent is forbidden, by some authority, 
  -- to make true.
  fun Prohibition  : Ind DeonticAttribute ;

  -- Attribute that applies to Propositions that 
  -- an Agent promises to make true. Promises may be implicit or explicit. 
  -- They may be expressed in a written or verbal or gestural manner.
  fun Promise  : Ind DeonticAttribute ;

  -- A UnaryFunction that maps an Agent to the 
  -- Set of Objects owned by the Agent.
  fun PropertyFn  : El Agent -> Ind Set ;

  -- Propositions are Abstract entities that 
  -- express a complete thought or a set of such thoughts. As an example, 
  -- the formula '(instance Yojo Cat)' expresses the Proposition that the 
  -- entity named Yojo is an element of the Class of Cats. Note that 
  -- propositions are not restricted to the content expressed by individual 
  -- sentences of a Language. They may encompass the content expressed by 
  -- theories, books, and even whole libraries. It is important to distinguish 
  -- Propositions from the ContentBearingObjects that express them. A 
  -- Proposition is a piece of information, e.g. that the cat is on the mat, 
  -- but a ContentBearingObject is an Object that represents this information. 
  -- A Proposition is an abstraction that may have multiple representations: 
  -- strings, sounds, icons, etc. For example, the Proposition that the cat is 
  -- on the mat is represented here as a string of graphical characters displayed 
  -- on a monitor and/or printed on paper, but it can be represented by a sequence 
  -- of sounds or by some non_latin alphabet or by some cryptographic form
  fun Proposition  : Class ;
  fun Proposition_Class : SubClass Proposition Abstract ;

  -- The BodyPosition of lying down, being in a 
  -- horizontal position.
  fun Prostrate  : Ind BodyPosition ;

  -- A Nutrient made up of amino acids joined by 
  -- peptide bonds.
  fun Protein  : Class ;
  fun Protein_Class : SubClass Protein Nutrient ;

  -- Components of the AtomicNucleus. They have a 
  -- positive charge.
  fun Proton  : Class ;
  fun Proton_Class : SubClass Proton SubatomicParticle ;

  -- The Class of pseudographs. A pseudograph 
  -- is a Graph containing at least one GraphLoop.
  fun PseudoGraph  : Class ;
  fun PseudoGraph_Class : SubClass PseudoGraph Graph ;

  -- Attributes that characterize the mental 
  -- or behavioral life of an Organism.
  fun PsychologicalAttribute  : Class ;
  fun PsychologicalAttribute_Class : SubClass PsychologicalAttribute BiologicalAttribute ;

  -- A clinically significant 
  -- dysfunction whose major manifestation is behavioral or psychological. 
  -- These dysfunctions may have identified or presumed biological etiologies 
  -- or manifestations.
  fun PsychologicalDysfunction  : Class ;
  fun PsychologicalDysfunction_Class : SubClass PsychologicalDysfunction (both DiseaseOrSyndrome PsychologicalAttribute) ;

  -- A BiologicalProcess which takes place in 
  -- the mind or brain of an Organism and which may be manifested in the behavior 
  -- of the Organism.
  fun PsychologicalProcess  : Class ;
  fun PsychologicalProcess_Class : SubClass PsychologicalProcess BiologicalProcess ;

  -- The Manufacture of Texts. Note that 
  -- there is no implication that the Texts are distributed. Such 
  -- distribution, when it occurs, is an instance of Dissemination.
  fun Publication  : Class ;
  fun Publication_Class : SubClass Publication (both ContentDevelopment Manufacture) ;

  -- A Contract between two Agents in 
  -- which one Agent agrees to render the other some good or service in 
  -- exchange for currency.
  fun PurchaseContract  : Ind DeonticAttribute ;

  -- The Class of Substances with constant 
  -- composition. A PureSubstance can be either an element (ElementalSubstance) 
  -- or a compound of elements (CompoundSubstance). Examples: Table salt 
  -- (sodium chloride, NaCl), sugar (sucrose, C_{12}H_{22}O_{11}), water (H_2O), 
  -- iron (Fe), copper (Cu), and oxygen (O_2).
  fun PureSubstance  : Class ;
  fun PureSubstance_Class : SubClass PureSubstance Substance ;

  -- The class of IntentionalProcesses where something is 
  -- sought. Some examples would be hunting, shopping, trawling, and stalking.
  fun Pursuing  : Class ;
  fun Pursuing_Class : SubClass Pursuing IntentionalProcess ;

  -- The Class of Processes where something is put 
  -- in a location. Note that the location is specified with the CaseRole 
  -- destination.
  fun Putting  : Class ;
  fun Putting_Class : SubClass Putting Transfer ;

  -- Any specification of how many or how much of 
  -- something there is. Accordingly, there are two subclasses of Quantity: 
  -- Number (how many) and PhysicalQuantity (how much).
  fun Quantity  : Class ;
  fun Quantity_Class : SubClass Quantity Abstract ;

  -- Any InternalChange where a PhysicalQuantity 
  -- associated with the patient is altered.
  fun QuantityChange  : Class ;
  fun QuantityChange_Class : SubClass QuantityChange InternalChange ;

  -- English unit of volume equal to 1/4 of a 
  -- UnitedStatesGallon.
  fun Quart  : Ind UnitOfVolume ;

  -- A request for information. For example, John asked 
  -- Bill if the President had said anything about taxes in his State of the Union 
  -- address.
  fun Questioning  : Class ;
  fun Questioning_Class : SubClass Questioning Directing ;

  -- SI plane angle measure. Symbol: rad. It is the 
  -- angle of a circle subtended by an arc equal in length to the circle's 
  -- radius. Another definition is: the plane angle between two radii of a 
  -- circle which cut off on the circumference an arc equal in length to the 
  -- radius. Radian = m/m = 1.
  fun Radian  : Ind UnitOfAngularMeasure ;

  -- Processes in which some form of electromagnetic 
  -- radiation, e.g. radio waves, light waves, electrical energy, etc., is given 
  -- off or absorbed by something else.
  fun Radiating  : Class ;
  fun Radiating_Class : SubClass Radiating Motion ;

  -- RadiatingElectromagnetic 
  -- is the subclass of Radiating processes in which electromagnetic 
  -- radiation is transmitted or absorbed.
  fun RadiatingElectromagnetic  : Class ;
  fun RadiatingElectromagnetic_Class : SubClass RadiatingElectromagnetic Radiating ;

  -- Any instance of Radiating where the 
  -- wavelengths are longer than those of visible light and shorter than those 
  -- of radio emissions.
  fun RadiatingInfrared  : Class ;
  fun RadiatingInfrared_Class : SubClass RadiatingInfrared RadiatingElectromagnetic ;

  -- The subclass of Radiating in which 
  -- light is given off or absorbed. Some examples include blinking, flashing, 
  -- and glittering.
  fun RadiatingLight  : Class ;
  fun RadiatingLight_Class : SubClass RadiatingLight RadiatingElectromagnetic ;

  -- Releasing atomic energy, i.e. energy from 
  -- a nuclear reaction.
  fun RadiatingNuclear  : Class ;
  fun RadiatingNuclear_Class : SubClass RadiatingNuclear Radiating ;

  -- The subclass of Radiating in which 
  -- sound waves are given off or absorbed. Some examples include creaking, 
  -- roaring, and whistling.
  fun RadiatingSound  : Class ;
  fun RadiatingSound_Class : SubClass RadiatingSound Radiating ;

  fun RadiatingXRay  : Class ;
  fun RadiatingXRay_Class : SubClass RadiatingXRay RadiatingElectromagnetic ;

  -- A TemperatureMeasure. Note that 0 RankineDegrees is
  -- the same as the absolute zero (i.e. 0 KelvinDegrees).
  fun RankineDegree  : Ind UnitOfTemperature ;

  -- Any RealNumber that is the product of 
  -- dividing two Integers.
  fun RationalNumber  : Class ;
  fun RationalNumber_Class : SubClass RationalNumber RealNumber ;

  -- (RationalNumberFn ?NUMBER) returns 
  -- the rational representation of ?NUMBER.
  fun RationalNumberFn  : El Number -> Ind RationalNumber ;

  -- A subclass of ContentDevelopment in which 
  -- content is converted from a written form into a spoken representation. 
  -- Note that the class Interpreting should be used in cases where a 
  -- Text is read silently.
  fun Reading  : Class ;
  fun Reading_Class : SubClass Reading ContentDevelopment ;

  -- Any Number that can be expressed as a 
  -- (possibly infinite) decimal, i.e. any Number that has a position 
  -- on the number line.
  fun RealNumber  : Class ;
  fun RealNumber_Class : SubClass RealNumber Number ;

  -- (RealNumberFn ?NUMBER) returns the part of 
  -- ?NUMBER that is a RealNumber.
  fun RealNumberFn  : El Number -> Ind RealNumber ;

  -- The Class of IntentionalPsychologicalProcesses 
  -- which involve concluding, on the basis of either deductive or inductive 
  -- evidence, that a particular Proposition or Sentence is true.
  fun Reasoning  : Class ;
  fun Reasoning_Class : SubClass Reasoning IntentionalPsychologicalProcess ;

  -- (ReciprocalFn ?NUMBER) is the reciprocal 
  -- element of ?NUMBER with respect to the multiplication operator 
  -- (MultiplicationFn), i.e. 1/?NUMBER. Not all numbers have a reciprocal 
  -- element. For example the number 0 does not. If a number ?NUMBER has a 
  -- reciprocal ?RECIP, then the product of ?NUMBER and ?RECIP will be 
  -- 1, e.g. 3*1/3 = 1. The reciprocal of an element is equal to 
  -- applying the ExponentiationFn function to the element to the power 
  -- _1.
  fun ReciprocalFn  : El Quantity -> Ind Quantity ;

  -- A Process that is carried out for 
  -- the purpose of recreation or exercise. Since RecreationOrExercise is a 
  -- subclass of IntentionalProcess, the intent of a process determines whether 
  -- or not it is an instance of the class. Hence, if John and Bill watch the same 
  -- program on television, and John watches it to relax while Bill watches it solely 
  -- to satisfy an educational requirement, then John's watching the movie is an 
  -- instance of RecreationOrExercise, while Bill's is not (both cases of 
  -- watching the television program would however be in the class of Seeing, since 
  -- being an instance of this latter class is not determined by intention).
  fun RecreationOrExercise  : Class ;
  fun RecreationOrExercise_Class : SubClass RecreationOrExercise IntentionalProcess ;

  -- A function that is useful for generating 
  -- recurring time intervals. For example, (RecurrentTimeIntervalFn (HourFn 6 Day) 
  -- (HourFn 12 Day)) returns the Class of TimeIntervals beginning at 6 in the 
  -- morning and ending at 12 noon. For another example, (RecurrentTimeInterval 
  -- Saturday Sunday) returns the Class of all weekends. For still another example, 
  -- (RecurrentTimeInterval June August) returns the Class containing the academic 
  -- summer period.
  fun RecurrentTimeIntervalFn : Desc TimeInterval -> Desc TimeInterval -> Desc TimeInterval ;

  -- The Attribute of redness.
  fun Red  : Ind PrimaryColor ;

  -- A topographic location. Regions encompass 
  -- surfaces of Objects, imaginary places, and GeographicAreas. Note 
  -- that a Region is the only kind of Object which can be located at 
  -- itself. Note too that Region is not a subclass of SelfConnectedObject, 
  -- because some Regions, e.g. archipelagos, have parts which are not 
  -- connected with one another.
  fun Region  : Class ;
  fun Region_Class : SubClass Region Object ;

  -- an Guiding whose aim is the enforcement 
  -- of rules or regulations. Note the key differences between RegulatoryProcess 
  -- and the related concept Managing. The latter implies a long_term relationship 
  -- between a single manager and limited number of agents who are managed, while the 
  -- former implies a normative standard to which the activities of the regulated are 
  -- referred.
  fun RegulatoryProcess  : Class ;
  fun RegulatoryProcess_Class : SubClass RegulatoryProcess Guiding ;

  -- Any Attribute that an Entity has by 
  -- virtue of a relationship that it bears to another Entity or set of Entities, 
  -- e.g. SocialRoles and PositionalAttributes.
  fun RelationalAttribute  : Class ;
  fun RelationalAttribute_Class : SubClass RelationalAttribute Attribute ;

  -- A BinaryFunction that maps two 
  -- SetOrClasses to the difference between these SetOrClasses. More 
  -- precisely, (RelativeComplementFn ?CLASS1 ?CLASS2) denotes the instances 
  -- of ?CLASS1 that are not also instances of ?CLASS2.
  fun RelativeComplementFn  : El SetOrClass -> El SetOrClass -> Ind SetOrClass ;

  -- A means of converting TimePositions 
  -- between different TimeZones. (RelativeTimeFn ?TIME ?ZONE) 
  -- denotes the TimePosition in CoordinatedUniversalTime that is 
  -- contemporaneous with the TimePosition ?TIME in TimeZone ?ZONE.
  -- For example, (RelativeTimeFn (MeasureFn 14 HourDuration) EasternTimeZone) 
  -- would return the value (MeasureFn 19 HourDuration).
  fun RelativeTimeFn  : El TimePosition -> El TimeZone -> Ind TimePosition ;

  -- Any instance of Transfer which results in 
  -- a situation where it is not the case that the agent grasps something 
  -- which he/she grasps previously.
  fun Releasing  : Class ;
  fun Releasing_Class : SubClass Releasing Transfer ;

  -- An Organization whose members 
  -- share a set of religious beliefs.
  fun ReligiousOrganization  : Class ;
  fun ReligiousOrganization_Class : SubClass ReligiousOrganization (both BeliefGroup Organization) ;

  -- An OrganizationalProcess that is 
  -- carried out within or by a ReligiousOrganization.
  fun ReligiousProcess  : Class ;
  fun ReligiousProcess_Class : SubClass ReligiousProcess OrganizationalProcess ;

  -- (RemainderFn ?NUMBER ?DIVISOR) is the 
  -- remainder of the number ?NUMBER divided by the number ?DIVISOR. 
  -- The result has the same sign as ?DIVISOR.
  fun RemainderFn  : El Quantity -> El Quantity -> Ind Quantity ;

  -- The Class of PsychologicalProcesses which 
  -- involve the recollection of prior experiences and/or of knowledge 
  -- which was previously acquired.
  fun Remembering  : Class ;
  fun Remembering_Class : SubClass Remembering PsychologicalProcess ;

  -- The Class of Processes where something is 
  -- taken away from a location. Note that the thing removed and the location 
  -- are specified with the CaseRoles patient and origin, respectively.
  fun Removing  : Class ;
  fun Removing_Class : SubClass Removing Transfer ;

  -- The Class of Processes where the agent 
  -- makes a modification or series of modifications to an Object that is not 
  -- functioning as intended so that it works properly.
  fun Repairing  : Class ;
  fun Repairing_Class : SubClass Repairing IntentionalProcess ;

  -- The Process of biological reproduction. 
  -- This can be either a sexual or an asexual process.
  fun Replication  : Class ;
  fun Replication_Class : SubClass Replication OrganismProcess ;

  -- Any ArtWork that represents 
  -- something Physical.
  fun RepresentationalArtWork  : Class ;
  fun RepresentationalArtWork_Class : SubClass RepresentationalArtWork (both ArtWork Icon) ;

  -- Reproductive structure of Organisms. 
  -- Consists of an Embryonic Object and a nutritive/protective envelope. 
  -- Note that this class includes seeds, spores, and FruitOrVegetables, as 
  -- well as the eggs produced by Animals.
  fun ReproductiveBody  : Class ;
  fun ReproductiveBody_Class : SubClass ReproductiveBody BodyPart ;

  -- A ColdBloodedVertebrate having an external 
  -- covering of scales or horny plates. Reptiles breathe by means of 
  -- Lungs and generally lay eggs.
  fun Reptile  : Class ;
  fun Reptile_Class : SubClass Reptile ColdBloodedVertebrate ;

  -- A request expresses a desire that some future 
  -- action be performed. For example, the 5th Battalion requested air support 
  -- from the 3rd Bomber Group. Note that this class covers proposals, 
  -- recommendations, suggestions, etc.
  fun Requesting  : Class ;
  fun Requesting_Class : SubClass Requesting Directing ;

  -- A Building or part of a Building which provides 
  -- some accomodation for sleeping.
  fun Residence  : Class ;
  fun Residence_Class : SubClass Residence StationaryArtifact ;

  -- A Building which provides some 
  -- accomodation for sleeping. Note that this class does not cover just 
  -- permanent residences, e.g. Houses and condominium and apartment buildings, 
  -- but also temporary residences, e.g. hotels and dormitories. 
  -- ResidentialBuildings are also distinguished from CommercialBuildings, 
  -- which are intended to serve an organizational rather than a residential 
  -- function.
  fun ResidentialBuilding  : Class ;
  fun ResidentialBuilding_Class : SubClass ResidentialBuilding (both Building Residence) ;

  -- This PositionalAttribute is derived from the 
  -- left/right schema. Note that this means directly to the right, so that, 
  -- if one object is to the right of another, then the projections of the 
  -- two objects overlap.
  fun Right  : Ind AntiSymmetricPositionalAttribute ;

  -- The shape of an Object with this Attribute 
  -- cannot be altered without breaking.
  fun Rigid  : Ind InternalAttribute ;

  -- Roadway is the subclass of LandTransitways 
  -- that are areas intended for surface travel by self_powered, wheeled 
  -- vehicles, excluding those that travel on tracks. Roadways have been 
  -- at least minimally improved to enable the passage of vehicles. 
  -- Roadways include dirt and gravelled roads, paved streets, and 
  -- expressways.
  fun Roadway  : Class ;
  fun Roadway_Class : SubClass Roadway LandTransitway ;

  -- The Class of Mammals with one or two pairs 
  -- of incisors for gnawing. Includes rats, mice, guinea pigs, and 
  -- rabbits.
  fun Rodent  : Class ;
  fun Rodent_Class : SubClass Rodent Mammal ;

  -- A properPart of a Building which is separated from 
  -- the exterior of the Building and/or other Rooms of the Building by walls. 
  -- Some Rooms may have a specific purpose, e.g. sleeping, bathing, cooking, 
  -- entertainment, etc.
  fun Room  : Class ;
  fun Room_Class : SubClass Room StationaryArtifact ;

  -- An Object with this Attribute has a rough 
  -- surface.
  fun Rough  : Ind TextureAttribute ;

  -- (RoundFn ?NUMBER) is the Integer closest 
  -- to ?NUMBER on the number line. If ?NUMBER is halfway between two 
  -- Integers (for example 3.5), it denotes the larger Integer.
  fun RoundFn  : El Quantity -> Ind Quantity ;

  -- Ambulating relatively quickly, i.e. moving in such a 
  -- way that, with each step, neither foot is in contact with the ground for a 
  -- period of time.
  fun Running  : Class ;
  fun Running_Class : SubClass Running Ambulating ;

  -- A WaterArea whose Water is saline, e.g. 
  -- oceans and seas.
  fun SaltWaterArea  : Class ;
  fun SaltWaterArea_Class : SubClass SaltWaterArea WaterArea ;

  -- A Class of Attributes that specify, in 
  -- a qualitative manner, the extent of the presence of one kind of Object in 
  -- another kind of Object.
  fun SaturationAttribute  : Class ;
  fun SaturationAttribute_Class : SubClass SaturationAttribute InternalAttribute ;

  -- The Class of all calendar Saturdays.
  fun Saturday  : Class ;
  fun Saturday_Class : SubClass Saturday Day ;

  -- The Class of all clock Seconds.
  fun Second  : Class ;
  fun Second_Class : SubClass Second TimeInterval ;

  -- SI UnitOfDuration. Symbol: s. 
  -- It is one of the base units in SI, and it is currently defined as 
  -- follows: the SecondDuration is the duration of 9192631770 periods of 
  -- the radiation corresponding to the transition between the two hyperfine 
  -- levels of the ground state of the cesium 133 atom.
  fun SecondDuration  : Ind UnitOfDuration ;

  -- A BinaryFunction that assigns a PositiveRealNumber and a 
  -- subclass of Minutes to the Seconds within each Minute corresponding to that 
  -- PositiveRealNumber. For example, (SecondFn 4 (MinuteFn 5 Hour)) is the Class 
  -- of all fourth Seconds of every fifth Minute of every hour. For another example, 
  -- (SecondFn 8 Minute) would return the eighth second of every minute. For still 
  -- another example, 
  --
  -- (SecondFn 9 (MinuteFn 15 (HourFn 14 (DayFn 18 (MonthFn August (YearFn 1912)))))) 
  --
  -- denotes 9 seconds and 15 minutes after 2 PM on the 18th day of August 1912.
  fun SecondFn : El PositiveRealNumber -> Desc Minute -> Desc Second ;

  -- The fertilized or unfertilized female ReproductiveBody 
  -- of a FloweringPlant.
  fun Seed  : Class ;
  fun Seed_Class : SubClass Seed (both PlantAnatomicalStructure ReproductiveBody) ;

  -- The subclass of Perception in which the 
  -- sensing is done by an ocular Organ.
  fun Seeing  : Class ;
  fun Seeing_Class : SubClass Seeing Perception ;

  -- The Class of IntentionalPsychologicalProcesses 
  -- which involve opting for one or more Entity out of a larger set of Entities. 
  -- Note that this covers all cases of judging or evaluating.
  fun Selecting  : Class ;
  fun Selecting_Class : SubClass Selecting IntentionalPsychologicalProcess ;

  -- A SelfConnectedObject is any 
  -- Object that does not consist of two or more disconnected parts.
  fun SelfConnectedObject  : Class ;
  fun SelfConnectedObject_Class : SubClass SelfConnectedObject Object ;

  -- A FinancialTransaction in which an instance of 
  -- Physical is exchanged for an instance of CurrencyMeasure.
  fun Selling  : Class ;
  fun Selling_Class : SubClass Selling FinancialTransaction ;

  -- A syntactically well_formed formula of a 
  -- Language. It includes, at minimum, a predicate and a subject (which 
  -- may be explicit or implicit), and it expresses a Proposition.
  fun Sentence  : Class ;
  fun Sentence_Class : SubClass Sentence LinguisticExpression ;

  -- An Agent that has rights but may or may 
  -- not have responsibilities and the ability to reason. If the latter are 
  -- present, then the Agent is also an instance of CognitiveAgent. 
  -- Domesticated animals are an example of SentientAgents that are not 
  -- also CognitiveAgents.
  fun SentientAgent  : Class ;
  fun SentientAgent_Class : SubClass SentientAgent Agent ;

  -- A Process where a SelfConnectedObject is 
  -- separated into (some of) its parts. Note that Separating is different 
  -- from Detaching in that the latter only results in the two objects not 
  -- being connected. Note too that Separating is different from 
  -- Removing in that one or both of the two things which are separated 
  -- may or may not be moved from the location where they were separated.
  fun Separating  : Class ;
  fun Separating_Class : SubClass Separating DualObjectProcess ;

  -- The Class of all Months which are September.
  fun September  : Class ;
  fun September_Class : SubClass September Month ;

  -- A Text consisting of multiple self_contained units. 
  -- Some examples are an encyclopedia containing a couple dozen volumes, a television 
  -- series made up of many episodes, a film serial, etc.
  fun Series  : Class ;
  fun Series_Class : SubClass Series Text ;

  -- A BinaryFunction that maps a type of Series 
  -- (e.g. the Encyclopedia_Britannica or the Popular_Mechanics periodical) and a 
  -- number to the volumes of the text type designated by the number.
  fun SeriesVolumeFn : Desc Series -> El PositiveInteger -> Desc Text ;

  -- ServiceProcess denotes the class
  -- of events in which one agent performs a service for another. The
  -- service need not be commercial, and it need not be the case that
  -- the serviceRecipient pays or recompenses the serviceProvider
  -- for the service.
  fun ServiceProcess  : Class ;
  fun ServiceProcess_Class : SubClass ServiceProcess SocialInteraction ;

  -- A SetOrClass that satisfies extensionality as well as
  -- other constraints specified by some choice of set theory. Sets differ 
  -- from Classes in two important respects. First, Sets are extensional _ 
  -- two Sets with the same elements are identical. Second, a Set can be 
  -- an arbitrary stock of objects. That is, there is no requirement that Sets 
  -- have an associated condition that determines their membership. Note that Sets 
  -- are not assumed to be unique sets, i.e. elements of a Set may occur more 
  -- than once in the Set.
  fun Set  : Class ;
  fun Set_Class : SubClass Set SetOrClass ;

  -- The SetOrClass of Sets
  -- and Classes, i.e. any instance of Abstract that has elements or
  -- instances.
  fun SetOrClass  : Class ;
  fun SetOrClass_Class : SubClass SetOrClass Abstract ;

  -- Attributes that indicate the sex of an 
  -- Organism.
  fun SexAttribute  : Class ;
  fun SexAttribute_Class : SubClass SexAttribute BiologicalAttribute ;

  -- Sexual Processes of biological 
  -- reproduction.
  fun SexualReproduction  : Class ;
  fun SexualReproduction_Class : SubClass SexualReproduction Replication ;

  -- Any Attribute that relates to the 
  -- shape of an Object.
  fun ShapeAttribute  : Class ;
  fun ShapeAttribute_Class : SubClass ShapeAttribute InternalAttribute ;

  -- The Process of changing the shape of an Object.
  fun ShapeChange  : Class ;
  fun ShapeChange_Class : SubClass ShapeChange InternalChange ;

  -- The subclass of Impelling where the patient 
  -- is a projectile that is fired through the air by means of some sort of 
  -- Device.
  fun Shooting  : Class ;
  fun Shooting_Class : SubClass Shooting Impelling ;

  -- A ShoreArea is a LandArea approximately 
  -- 1_3 km wide bordering a body of water, such as an ocean, bay, river, 
  -- or lake. A ShoreArea may comprise a variety of LandForms, such as dunes, 
  -- sloughs, and marshes.
  fun ShoreArea  : Class ;
  fun ShoreArea_Class : SubClass ShoreArea LandArea ;

  -- SI electric conductance measure. Symbol: S. 
  -- In the case of direct current, the conductance in Siemens is the 
  -- reciprocal of the resistance in Ohms, in the case of alternating current, 
  -- it is the reciprocal of the impedance in ohms. siemens = A/V = 
  -- m^(_2)*kg(_1)*s^(3)*A^2.
  fun Siemens  : Ind CompositeUnitOfMeasure ;

  -- SI dose equivalent measure. Symbol: Sv. It is 
  -- a unit of biologic dose of ionizing radiation. The Sievert makes it 
  -- possible to normalize doses of different types of radiation. It takes 
  -- into account the relative biologic effectiveness of ionizing radiation, 
  -- since each form of such radiation__e.g., X rays, gamma rays, neutrons__
  -- has a slightly different effect on living tissue for a given absorbed 
  -- dose. The dose equivalent of a given type of radiation (in Sievert) is 
  -- the dose of the radiation in Gray multiplied by a quality factor that 
  -- is based on the relative biologic effectiveness of the radiation. 
  -- Accordingly, one Sievert is generally defined as the amount of radiation 
  -- roughly equivalent in biologic effectiveness to one Gray of gamma 
  -- radiation. Sievert = J/kg = m^2*s^(_2)
  fun Sievert  : Ind CompositeUnitOfMeasure ;

  -- (SignumFn ?NUMBER) denotes the sign of ?NUMBER. 
  -- This is one of the following values: _1, 1, or 0.
  fun SignumFn  : El RealNumber -> Ind Integer ;

  -- (SineFn ?DEGREE) is the sine of the 
  -- PlaneAngleMeasure ?DEGREE. The sine of ?DEGREE is the ratio of the side 
  -- opposite ?DEGREE to the hypotenuse in a right_angled triangle.
  fun SineFn  : El PlaneAngleMeasure -> Ind RealNumber ;

  -- Speaking that is also Music.
  fun Singing  : Class ;
  fun Singing_Class : SubClass Singing (both Music Speaking) ;

  -- SingleAgentProcess 
  -- is the Class of all Processes that require exactly one agent in order to occur.
  fun SingleAgentProcess  : Class ;
  fun SingleAgentProcess_Class : SubClass SingleAgentProcess Process ;

  -- A PermanentResidence which is 
  -- intended to be the home of a single SocialUnit. This class covers 
  -- Houses, ApartmentUnits, and CondominiumUnits.
  fun SingleFamilyResidence  : Class ;
  fun SingleFamilyResidence_Class : SubClass SingleFamilyResidence PermanentResidence ;

  -- The BodyPosition of being recumbent, i.e. 
  -- knees bent and back side supported.
  fun Sitting  : Ind BodyPosition ;

  -- The system of Bones that make up the supporting structure 
  -- of Vertebrates.
  fun Skeleton  : Class ;
  fun Skeleton_Class : SubClass Skeleton (both AnimalAnatomicalStructure BodyPart) ;

  -- English mass unit of slugs.
  fun Slug  : Ind UnitOfMass ;

  -- The subclass of Perception in which the 
  -- sensing is done by an olefactory Organ.
  fun Smelling  : Class ;
  fun Smelling_Class : SubClass Smelling Perception ;

  -- A mixture of fine particles suspended in a gas that is 
  -- produced by Combustion.
  fun Smoke  : Class ;
  fun Smoke_Class : SubClass Smoke Cloud ;

  -- An Object with this Attribute has a smooth 
  -- surface.
  fun Smooth  : Ind TextureAttribute ;

  -- The subclass of 
  -- IntentionalProcess that involves interactions between 
  -- CognitiveAgents.
  fun SocialInteraction  : Class ;
  fun SocialInteraction_Class : SubClass SocialInteraction IntentionalProcess ;

  -- The Class of all Attributes that 
  -- specify the position or status of a CognitiveAgent within an 
  -- Organization or other Group.
  fun SocialRole  : Class ;
  fun SocialRole_Class : SubClass SocialRole RelationalAttribute ;

  -- A GroupOfPeople who all have the same home.
  fun SocialUnit  : Class ;
  fun SocialUnit_Class : SubClass SocialUnit GroupOfPeople ;

  -- An Object has the Attribute of Solid if it 
  -- has a fixed shape and a fixed volume.
  fun Solid  : Ind PhysicalState ;

  -- The value of an angle in a solid.
  fun SolidAngleMeasure  : Class ;
  fun SolidAngleMeasure_Class : SubClass SolidAngleMeasure AngleMeasure ;

  -- A liquid mixture. The most abundant component in 
  -- a solution is called the solvent. Other components are called solutes. 
  -- A solution, though homogeneous, may nonetheless have variable composition. 
  -- Any amount of salt, up to a maximum limit, can be dissolved in a given 
  -- amount of water.
  fun Solution  : Class ;
  fun Solution_Class : SubClass Solution LiquidMixture ;

  -- The volume of sound relative to a listener.
  fun SoundAttribute  : Class ;
  fun SoundAttribute_Class : SubClass SoundAttribute RelationalAttribute ;

  -- The compass direction of South.
  fun South  : Ind DirectionalAttribute ;

  -- Any LinguisticGeneration which is also a 
  -- Vocalizing, i.e. any LinguisticCommunication by a Human which 
  -- involves his/her vocal cords.
  fun Speaking  : Class ;
  fun Speaking_Class : SubClass Speaking (both LinguisticCommunication Vocalizing) ;

  -- Maps an instance of LengthMeasure and an instance of 
  -- TimeDuration to the speed represented by this proportion of distance and time. 
  -- For example, (SpeedFn (MeasureFn 55 Mile)(MeasureFn 1 HourDuration)) 
  -- represents the velocity of 55 miles per hour.
  fun SpeedFn  : El LengthMeasure -> El TimeDuration -> Ind FunctionQuantity ;

  -- A flexible column made out of bones called 
  -- vertebrae. The main function of the SpinalColumn is to protect the 
  -- spinal cord.
  fun SpinalColumn  : Class ;
  fun SpinalColumn_Class : SubClass SpinalColumn (both AnimalAnatomicalStructure Organ) ;

  -- A SpokenHumanLanguage is a
  -- HumanLanguage which has as its medium the human voice. It can also 
  -- berepresented visually through writing, although not all 
  -- SpokenHumanLanguages have a codified written form.
  fun SpokenHumanLanguage  : Class ;
  fun SpokenHumanLanguage_Class : SubClass SpokenHumanLanguage HumanLanguage ;

  -- Any ReproductiveBody of a NonFloweringPlant.
  fun Spore  : Class ;
  fun Spore_Class : SubClass Spore (both PlantAnatomicalStructure ReproductiveBody) ;

  -- A Game which requires some degree of physical 
  -- exercion from the participants of the game.
  fun Sport  : Class ;
  fun Sport_Class : SubClass Sport Game ;

  -- (SquareRootFn ?NUMBER) is the principal 
  -- square root of ?NUMBER.
  fun SquareRootFn  : El RealNumber -> Ind Number ;

  -- The BodyPosition of being upright, i.e. being 
  -- fully extended and supported by nothing other than one's own feet.
  fun Standing  : Ind BodyPosition ;

  -- Any Process where the PhysicalState 
  -- of part of the patient of the Process changes.
  fun StateChange  : Class ;
  fun StateChange_Class : SubClass StateChange InternalChange ;

  -- The class StateOfMind is distinguished from 
  -- its complement TraitAttribute by the fact that instances of the former are 
  -- transient while instances of the latter are persistent features of a creature's behavioral/psychological make_up.
  fun StateOfMind  : Class ;
  fun StateOfMind_Class : SubClass StateOfMind PsychologicalAttribute ;

  -- Administrative subdivisions of a 
  -- Nation that are broader than any other political subdivisions that 
  -- may exist. This Class includes the states of the United States, as 
  -- well as the provinces of Canada and European countries.
  fun StateOrProvince  : Class ;
  fun StateOrProvince_Class : SubClass StateOrProvince (both GeopoliticalArea LandArea) ;

  -- A WaterArea in which water does not flow 
  -- constantly or in the same direction, e.g. most lakes and ponds.
  fun StaticWaterArea  : Class ;
  fun StaticWaterArea_Class : SubClass StaticWaterArea WaterArea ;

  -- Instances of this Class commit the agent to some truth. 
  -- For example, John claimed that the moon is made of green cheese.
  fun Stating  : Class ;
  fun Stating_Class : SubClass Stating LinguisticCommunication ;

  -- A StationaryArtifact is an Artifact 
  -- that has a fixed spatial location. Most instances of this Class are 
  -- architectural works, e.g. the Eiffel Tower, the Great Pyramids, office towers, 
  -- single_family houses, etc.
  fun StationaryArtifact  : Class ;
  fun StationaryArtifact_Class : SubClass StationaryArtifact Artifact ;

  -- SI solid angle measure. Symbol: sr. It is 
  -- the solid angle of a sphere subtended by a portion of the surface whose 
  -- area is equal to the square of the sphere's radius. Another definition 
  -- is: the solid angle which, having its vertex in the center of the sphere, 
  -- cuts off an area of the surface of the sphere equal to that of a square 
  -- with sides of length equal to the radius of the sphere. Steradian = 
  -- m^2/m^2 = 1.
  fun Steradian  : Ind UnitOfAngularMeasure ;

  -- A relatively narrow WaterArea where the 
  -- water flows constantly and in the same direction, e.g. a river, a stream, 
  -- etc.
  fun StreamWaterArea  : Class ;
  fun StreamWaterArea_Class : SubClass StreamWaterArea (both FlowRegion WaterArea) ;

  -- The class of ElementalSubstances that 
  -- are smaller than Atoms and compose Atoms.
  fun SubatomicParticle  : Class ;
  fun SubatomicParticle_Class : SubClass SubatomicParticle ElementalSubstance ;

  -- The Class of NormativeAttributes
  -- which lack an objective criterion for their attribution, i.e. the attribution of 
  -- these Attributes varies from subject to subject and even with respect to the 
  -- same subject over time. This Class is, generally speaking, only used when 
  -- mapping external knowledge sources to the SUMO. If a term from such a knowledge 
  -- source seems to lack objective criteria for its attribution, it is assigned to 
  -- this Class.
  fun SubjectiveAssessmentAttribute  : Class ;
  fun SubjectiveAssessmentAttribute_Class : SubClass SubjectiveAssessmentAttribute NormativeAttribute ;

  -- An Object in which every part is similar to 
  -- every other in every relevant respect. More precisely, something is a 
  -- Substance when it has only arbitrary pieces as parts _ any parts have 
  -- properties which are similar to those of the whole. Note that a Substance 
  -- may nonetheless have physical properties that vary. For example, the 
  -- temperature, chemical constitution, density, etc. may change from one part 
  -- to another. An example would be a body of water.
  fun Substance  : Class ;
  fun Substance_Class : SubClass Substance SelfConnectedObject ;

  -- The Class of Transfers where one thing is 
  -- replaced with something else.
  fun Substituting  : Class ;
  fun Substituting_Class : SubClass Substituting (both DualObjectProcess Transfer) ;

  -- If ?NUMBER1 and ?NUMBER2 are Numbers, 
  -- then (SubtractionFn ?NUMBER1 ?NUMBER2) is the arithmetical difference 
  -- between ?NUMBER1 and ?NUMBER2, i.e. ?NUMBER1 minus ?NUMBER2. An 
  -- exception occurs when ?NUMBER1 is equal to 0, in which case 
  -- (SubtractionFn ?NUMBER1 ?NUMBER2) is the negation of ?NUMBER2.
  fun SubtractionFn  : El Quantity -> El Quantity -> Ind Quantity ;

  -- A UnaryFunction that maps an Integer to 
  -- its successor, e.g. the successor of 5 is 6.
  fun SuccessorFn  : El Integer -> Ind Integer ;

  -- A short Text that is a summary of another, 
  -- longer Text.
  fun Summary  : Class ;
  fun Summary_Class : SubClass Summary Text ;

  -- The Class of all calendar Sundays.
  fun Sunday  : Class ;
  fun Sunday_Class : SubClass Sunday Day ;

  -- Instances of this Class suppose, for the sake of 
  -- argument, that a proposition is true. For example, John considered what he 
  -- would do if he won the lottery.
  fun Supposing  : Class ;
  fun Supposing_Class : SubClass Supposing LinguisticCommunication ;

  -- Processes which involve altering 
  -- the properties that apply to the surface of an Object.
  fun SurfaceChange  : Class ;
  fun SurfaceChange_Class : SubClass SurfaceChange InternalChange ;

  -- Any TherapeuticProcess that involves making an 
  -- incision in the Animal that is the patient of the TherapeuticProcess.
  fun Surgery  : Class ;
  fun Surgery_Class : SubClass Surgery TherapeuticProcess ;

  -- A LiquidMixture where at least one of the 
  -- components of the Mixture is equally distributed throughout the Mixture 
  -- but is not dissolved in it.
  fun Suspension  : Class ;
  fun Suspension_Class : SubClass Suspension LiquidMixture ;

  -- Any deliberate and controlled BodyMotion 
  -- through water that is accomplished by an Organism.
  fun Swimming  : Class ;
  fun Swimming_Class : SubClass Swimming BodyMotion ;

  -- The Class of alphanumeric sequences.
  fun SymbolicString  : Class ;
  fun SymbolicString_Class : SubClass SymbolicString ContentBearingObject ;

  -- SymmetricAttribute is the class of 
  -- PositionalAttribute that hold between two items regardless of their 
  -- order or orientation.
  fun SymmetricPositionalAttribute  : Class ;
  fun SymmetricPositionalAttribute_Class : SubClass SymmetricPositionalAttribute PositionalAttribute ;

  -- Any Substance that is the result of an 
  -- IntentionalProcess, i.e. any substance that is created by Humans.
  fun SyntheticSubstance  : Class ;
  fun SyntheticSubstance_Substance  : SubClassC SyntheticSubstance Substance 
                                                (\SUBSTANCE -> exists IntentionalProcess
                                                                      (\PROCESS -> result (var IntentionalProcess Process ? PROCESS)
                                                                                          (var Substance Entity ? SUBSTANCE)));

  -- The Class of Systeme 
  -- International (SI) units.
  fun SystemeInternationalUnit  : Class ;
  fun SystemeInternationalUnit_Class : SubClass SystemeInternationalUnit UnitOfMeasure ;

  -- The subclass of Perception in which 
  -- the sensing is done by Touching. Note that Touching need not involve 
  -- TactilePerception. For example, a person who has lost all sensation in 
  -- both of his legs would have no TactilePerception of anything his legs 
  -- were Touching.
  fun TactilePerception  : Class ;
  fun TactilePerception_Class : SubClass TactilePerception Perception ;

  -- (TangentFn ?DEGREE) is the tangent of the 
  -- PlaneAngleMeasure ?DEGREE. The tangent of ?DEGREE is the ratio of 
  -- the side opposite ?DEGREE to the side next to ?DEGREE in a right_angled 
  -- triangle.
  fun TangentFn  : El PlaneAngleMeasure -> Ind RealNumber ;

  -- The Class of Attributes relating to 
  -- the taste of Objects.
  fun TasteAttribute  : Class ;
  fun TasteAttribute_Class : SubClass TasteAttribute PerceptualAttribute ;

  -- The subclass of Perception in which the 
  -- sensing is done by of an Organ which can discriminate various tastes.
  fun Tasting  : Class ;
  fun Tasting_Class : SubClass Tasting Perception ;

  -- Measures of temperature. 
  -- In scientific circles, the temperature of something is understood as the 
  -- average velocity of the atoms or molecules that make up the thing.
  fun TemperatureMeasure  : Class ;
  fun TemperatureMeasure_Class : SubClass TemperatureMeasure ConstantQuantity ;

  -- The basic Function for expressing 
  -- the composition of larger TimeIntervals out of smaller TimeIntervals. 
  -- For example, if ThisSeptember is an instance of September, 
  -- (TemporalCompositionFn ThisSeptember Day) denotes the Class of 
  -- consecutive days that make up ThisSeptember. Note that one can obtain 
  -- the number of instances of this Class by using the function CardinalityFn.
  fun TemporalCompositionFn : El TimeInterval -> Desc TimeInterval -> Desc TimeInterval ;

  -- A Residence which is strictly temporary, 
  -- i.e. where no one makes his/her home.
  fun TemporaryResidence  : Class ;
  fun TemporaryResidence_Class : SubClass TemporaryResidence Residence ;

  -- A UnaryFunction that maps a UnitOfMeasure 
  -- into a UnitOfMeasure that is equal to 1,000,000,000,000 units of the original 
  -- UnitOfMeasure. For example, (TeraFn Hertz) is 1,000,000,000,000 Hertz.
  fun TeraFn  : El UnitOfMeasure -> Ind UnitOfMeasure;

  -- A UnaryFunction that maps a 
  -- GraphArc to the terminal node of the GraphArc. Note that this 
  -- is a partial function. In particular, the function is undefined 
  -- for GraphArcs that are not part of a DirectedGraph.
  fun TerminalNodeFn  : El GraphArc -> Ind GraphNode ;

  -- OrganizationalProcesses where someone 
  -- ceases to be an employee of an Organization. Note that this covers being 
  -- laid off, being fired, and voluntarily leaving a job.
  fun TerminatingEmployment  : Class ;
  fun TerminatingEmployment_Class : SubClass TerminatingEmployment LeavingAnOrganization ;

  -- SI magnetic flux density measure. Symbol: T.
  -- One Tesla equals one Weber per square Meter. Tesla = Wb/m^2 = 
  -- kg*s^(_2)*A^(_1).
  fun Tesla  : Ind CompositeUnitOfMeasure ;

  -- A LinguisticExpression or set of 
  -- LinguisticExpressions that perform a specific function related 
  -- to Communication, e.g. express a discourse about a particular 
  -- topic, and that are inscribed in a CorpuscularObject by Humans.
  fun Text  : Class ;
  fun Text_Class : SubClass Text (both Artifact (both ContentBearingObject LinguisticExpression)) ;

  -- Any Attribute that characterizes the 
  -- texture of an Object.
  fun TextureAttribute  : Class ;
  fun TextureAttribute_Class : SubClass TextureAttribute PerceptualAttribute ;

  -- A Process that is carried out 
  -- for the purpose of curing, improving or reducing the pain associated 
  -- with a DiseaseOrSyndrome.
  fun TherapeuticProcess  : Class ;
  fun TherapeuticProcess_Class : SubClass TherapeuticProcess Repairing ;

  -- The class of GeometricFigures that 
  -- have position and an extension along three dimensions, viz. geometric solids 
  -- like polyhedrons and cylinders.
  fun ThreeDimensionalFigure  : Class ;
  fun ThreeDimensionalFigure_Class : SubClass ThreeDimensionalFigure GeometricFigure ;

  -- The Class of all calendar Thursdays.
  fun Thursday  : Class ;
  fun Thursday_Class : SubClass Thursday Day ;

  -- A UnaryConstantFunctionQuantity of continuous time. All instances of
  -- this Class are returned by Functions that map a time quantity into
  -- another ConstantQuantity such as temperature. For example, 'the
  -- temperature at the top of the Empire State Building' is a
  -- TimeDependentQuantity, since its value depends on the time.
  fun TimeDependentQuantity  : Class ;
  fun TimeDependentQuantity_Class : SubClass TimeDependentQuantity UnaryConstantFunctionQuantity ;

  -- Any measure of length of time, 
  -- with or without respect to the universal timeline.
  fun TimeDuration  : Class ;
  fun TimeDuration_Class : SubClass TimeDuration TimeMeasure ;

  -- An interval of time.
  -- Note that a TimeInterval has both an extent and a location on the
  -- universal timeline. Note too that a TimeInterval has no gaps,
  -- i.e. this class contains only convex time intervals.
  fun TimeInterval  : Class ;
  fun TimeInterval_Class : SubClass TimeInterval TimePosition ;

  -- A BinaryFunction that takes two TimePoints 
  -- as arguments and returns the TimeInterval defined by these two TimePoints. 
  -- Note that the first TimePoint must occur earlier than the second TimePoint.
  fun TimeIntervalFn  : El TimePoint -> El TimePoint -> Ind TimeInterval ;

  -- The class of temporal durations (instances 
  -- of TimeDuration) and positions of TimePoints and TimeIntervals along 
  -- the universal timeline (instances of TimePosition).
  fun TimeMeasure  : Class ;
  fun TimeMeasure_Class : SubClass TimeMeasure ConstantQuantity ;

  -- An extensionless point on
  -- the universal timeline. The TimePoints at which Processes occur
  -- can be known with various degrees of precision and approximation, but
  -- conceptually TimePoints are point_like and not interval_like. That
  -- is, it doesn't make sense to talk about how long a TimePoint
  -- lasts.
  fun TimePoint  : Class ;
  fun TimePoint_Class : SubClass TimePoint TimePosition ;

  -- Any TimePoint or TimeInterval 
  -- along the universal timeline from NegativeInfinity to 
  -- PositiveInfinity.
  fun TimePosition  : Class ;
  fun TimePosition_Class : SubClass TimePosition TimeMeasure ;

  -- An Attribute which is used to specify coordinates 
  -- in which time measures are uniform, i.e. all time devices are synchronized to 
  -- the same TimePositions.
  fun TimeZone  : Class ;
  fun TimeZone_Class : SubClass TimeZone RelationalAttribute ;

  -- An aggregation of similarly specialized Cells 
  -- and the associated intercellular substance. Tissues are relatively 
  -- non_localized in comparison to BodyParts, Organs or Organ components. 
  -- The main features of Tissues are self_connectivity (see 
  -- SelfConnectedObject) and being a homogeneous mass (all parts in the 
  -- same granularity are instances of Tissue as well).
  fun Tissue  : Class ;
  fun Tissue_Class : SubClass Tissue BodySubstance ;

  -- Any Transfer where two Objects are 
  -- brought into immediate physical contact with one another.
  fun Touching  : Class ;
  fun Touching_Class : SubClass Touching Transfer ;

  -- Attributes that indicate the the 
  -- behavior/personality traits of an Organism.
  fun TraitAttribute  : Class ;
  fun TraitAttribute_Class : SubClass TraitAttribute PsychologicalAttribute ;

  -- The subclass of ChangeOfPossession where 
  -- something is exchanged for something else.
  fun Transaction  : Class ;
  fun Transaction_Class : SubClass Transaction (both ChangeOfPossession DualObjectProcess) ;

  -- Any instance of Translocation where the agent 
  -- and the patient are not the same thing.
  fun Transfer  : Class ;
  fun Transfer_Class : SubClass Transfer Translocation ;

  -- Transitway is the broadest class 
  -- of regions which may be passed through as a path in instances 
  -- of Translocation. Transitway includes land, air, and sea 
  -- regions, and it includes both natural and artificial transitways.
  fun Transitway  : Class ;
  fun Transitway_Class : SubClass Transitway (both Region SelfConnectedObject) ;

  -- Converting content from one Language into another. 
  -- This covers oral translation (i.e. interpreting) as well as written translation.
  fun Translating  : Class ;
  fun Translating_Class : SubClass Translating (both ContentDevelopment DualObjectProcess) ;

  -- Translocation is that class of Motions 
  -- in which an object moves from one place to another. In the case of round 
  -- trips, the origin and destination are the same, but the intervening 
  -- motion passes through other locations. Translocation represents linear 
  -- motion, in contrast to rotation or other movement in place. A vehicle is 
  -- not necessary, Ambulating is a kind of Translocation.
  fun Translocation  : Class ;
  fun Translocation_Class : SubClass Translocation Motion ;

  -- Motion from one point to another by means 
  -- of a TransportationDevice.
  fun Transportation  : Class ;
  fun Transportation_Class : SubClass Transportation Translocation ;

  -- A TransportationDevice is a Device 
  -- which serves as the instrument in a Transportation Process which carries 
  -- the patient of the Process from one point to another.
  fun TransportationDevice  : Class ;
  fun TransportationDevice_Class : SubClass TransportationDevice Device ;

  -- A Tree is a DirectedGraph that has no 
  -- GraphLoops.
  fun Tree  : Class ;
  fun Tree_Class : SubClass Tree Graph ;

  -- The TruthValue of being true.
  fun True  : Ind TruthValue ;

  -- The Class of truth values, e.g. True and 
  -- False. These are Attributes of Sentences and Propositions.
  fun TruthValue  : Class ;
  fun TruthValue_Class : SubClass TruthValue RelationalAttribute ;

  -- The Class of all calendar Tuesdays.
  fun Tuesday  : Class ;
  fun Tuesday_Class : SubClass Tuesday Day ;

  -- Any two OneDimensionalFigures (i.e. 
  -- straight lines) meeting at a single GeometricPoint.
  fun TwoDimensionalAngle  : Class ;
  fun TwoDimensionalAngle_Class : SubClass TwoDimensionalAngle OpenTwoDimensionalFigure ;

  -- The class of GeometricFigures that 
  -- have position and an extension along two dimensions, viz. plane figures 
  -- like circles and polygons.
  fun TwoDimensionalFigure  : Class ;
  fun TwoDimensionalFigure_Class : SubClass TwoDimensionalFigure GeometricFigure ;

  -- A subclass of FunctionQuantity, instances of which are returned by
  -- UnaryFunctions that map from one instance of the Class
  -- ConstantQuantity to another instance of the Class
  -- ConstantQuantity.
  fun UnaryConstantFunctionQuantity  : Class ;
  fun UnaryConstantFunctionQuantity_Class : SubClass UnaryConstantFunctionQuantity FunctionQuantity ;

  -- Attribute that applies to Organisms that 
  -- are unconscious. An Organism may be Unconscious because it is Dead 
  -- or because of a blow to the head, a drug, etc.
  fun Unconscious  : Ind ConsciousnessAttribute ;

  -- The Class of Removing processes where the agent 
  -- uncovers the patient, either completely or only partially.
  fun Uncovering  : Class ;
  fun Uncovering_Class : SubClass Uncovering Removing ;

  -- The Attribute of a CognitiveAgent when 
  -- he/she is unemployed.
  fun Unemployed  : Ind SocialRole ;

  -- Any instance of Detaching which results in 
  -- a situation where it is not the case that the agent grasps something 
  -- which he/she grasps previously.
  fun Ungrasping  : Class ;
  fun Ungrasping_Class : SubClass Ungrasping Detaching ;

  -- Any instance of Getting that is not part 
  -- of a Transaction. In other words, any instance of Getting where nothing 
  -- is given in return. Some examples of UnilateralGetting are: appropriating, 
  -- commandeering, stealing, etc.
  fun UnilateralGetting  : Class ;
  fun UnilateralGetting_Class : SubClass UnilateralGetting Getting ;

  -- Any instance of Giving that is not part 
  -- of a Transaction. In other words, any instance of Giving where nothing 
  -- is received in return. Some examples of UnilateralGiving are: honorary 
  -- awards, gifts, and financial grants.
  fun UnilateralGiving  : Class ;
  fun UnilateralGiving_Class : SubClass UnilateralGiving Giving ;

  -- The Attribute of Regions that are 
  -- unilluminated, i.e in which no shapes are visually discernable.
  fun Unilluminated  : Ind VisualAttribute ;

  -- A BinaryFunction that maps two SetOrClasses to 
  -- the union of these SetOrClasses. An object is an element of the union 
  -- of two SetOrClasses just in case it is an instance of either SetOrClass.
  fun UnionFn  : El SetOrClass -> El SetOrClass -> Ind SetOrClass ;

  -- A List in which no item appears more than once, 
  -- i.e. a List for which there are no distinct numbers ?NUMBER1 and ?NUMBER2 
  -- such that (ListOrderFn ?LIST ?NUMBER1) and (ListOrderFn ?LIST ?NUMBER2) 
  -- return the same value.
  fun UniqueList  : Class ;
  fun UniqueList_Class : SubClass UniqueList List ;

  -- UnitFn returns just the UnitOfMeasure of a PhysicalQuantity with an associated
  -- UnitOfMeasure and RealNumber magnitude. For example, the unit of
  -- the ConstantQuantity (MeasureFn 2 Kilometer) is the
  -- UnitOfMeasure Kilometer.
  fun UnitFn  : El PhysicalQuantity -> Ind UnitOfMeasure ;

  -- Every instance of this Class is a UnitOfMeasure that can be used
  -- with MeasureFn to form instances of AngleMeasure.
  fun UnitOfAngularMeasure  : Class ;
  fun UnitOfAngularMeasure_Class : SubClass UnitOfAngularMeasure NonCompositeUnitOfMeasure ;

  -- Every instance of this Class is a UnitOfMeasure that can be used with MeasureFn to form
  -- instances of AreaMeasure.
  fun UnitOfArea  : Class ;
  fun UnitOfArea_Class : SubClass UnitOfArea CompositeUnitOfMeasure ;

  -- UnitOfAtmosphericPressure includes those instances of
  -- UnitOfMeasure used to measure atmospheric pressure (barometricPressure),
  -- e.g., InchMercury.
  fun UnitOfAtmosphericPressure  : Class ;
  fun UnitOfAtmosphericPressure_Class : SubClass UnitOfAtmosphericPressure CompositeUnitOfMeasure ;

  -- Every instance of this Class is a UnitOfMeasure that can be used with MeasureFn to form
  -- instances of CurrencyMeasure.
  fun UnitOfCurrency  : Class ;
  fun UnitOfCurrency_Class : SubClass UnitOfCurrency NonCompositeUnitOfMeasure ;

  -- Every instance of this Class is a UnitOfMeasure that can be used with MeasureFn to form
  -- instances of TimeDuration. Note that TimeDuration is a subclass of TimeMeasure.
  fun UnitOfDuration  : Class ;
  fun UnitOfDuration_Class : SubClass UnitOfDuration NonCompositeUnitOfMeasure ;

  -- Every instance of this
  -- Class is a UnitOfMeasure that can be used with MeasureFn to form
  -- instances of FrequencyMeasure.
  fun UnitOfFrequency  : Class ;
  fun UnitOfFrequency_Class : SubClass UnitOfFrequency CompositeUnitOfMeasure ;

  -- Every instance of this
  -- Class is a UnitOfMeasure that can be used with MeasureFn to form
  -- instances of InformationMeasure.
  fun UnitOfInformation  : Class ;
  fun UnitOfInformation_Class : SubClass UnitOfInformation NonCompositeUnitOfMeasure ;

  -- Every instance of this
  -- Class is a UnitOfMeasure that can be used with MeasureFn to form
  -- instances of LengthMeasure.
  fun UnitOfLength  : Class ;
  fun UnitOfLength_Class : SubClass UnitOfLength NonCompositeUnitOfMeasure ;

  -- Every instance of this
  -- Class is a UnitOfMeasure that can be used with MeasureFn to form
  -- instances of MassMeasure, which denote the amount of matter in
  -- PhysicalObjects.
  fun UnitOfMass  : Class ;
  fun UnitOfMass_Class : SubClass UnitOfMass NonCompositeUnitOfMeasure ;

  -- A standard of measurement for some dimension. 
  -- For example, the Meter is a UnitOfMeasure for the dimension of length, 
  -- as is the Inch. There is no intrinsic property of a UnitOfMeasure that 
  -- makes it primitive or fundamental, rather, a system of units (e.g. 
  -- SystemeInternationalUnit) defines a set of orthogonal dimensions and 
  -- assigns units for each.
  fun UnitOfMeasure  : Class ;
  fun UnitOfMeasure_Class : SubClass UnitOfMeasure PhysicalQuantity ;

  -- Every instance of this Class is a UnitOfMeasure that can be used with MeasureFn to form
  -- instances of TemperatureMeasure.
  fun UnitOfTemperature  : Class ;
  fun UnitOfTemperature_Class : SubClass UnitOfTemperature NonCompositeUnitOfMeasure ;

  -- Every instance of this Class is a UnitOfMeasure that can be used with MeasureFn to form
  -- instances of VolumeMeasure.
  fun UnitOfVolume  : Class ;
  fun UnitOfVolume_Class : SubClass UnitOfVolume CompositeUnitOfMeasure ;

  -- Unit of volume commonly used in the United Kingdom.
  fun UnitedKingdomGallon  : Ind UnitOfVolume ;

  -- A currency measure. 1 UnitedStatesCent is equal to .01 UnitedStatesDollars.
  fun UnitedStatesCent  : Ind UnitOfCurrency ;

  -- A currency measure.
  fun UnitedStatesDollar  : Ind UnitOfCurrency ;

  -- Unit of volume commonly used in the United States.
  fun UnitedStatesGallon  : Ind UnitOfVolume ;

  -- The ProbabilityAttribute of being improbable, i.e. more 
  -- likely than not to be False.
  fun Unlikely  : Ind ProbabilityAttribute ;

  -- A DeductiveArgument which is valid, i.e. the set of premises in fact entails the conclusion.
  fun ValidDeductiveArgument  : Class ;
  fun ValidDeductiveArgument_Class : SubClass ValidDeductiveArgument DeductiveArgument ;

  -- Vehicle is the subclass of 
  -- TransportationDevices that transport passengers or goods 
  -- from one place to another by moving from one place to the other 
  -- with them, e.g., cars, trucks, ferries, and airplanes. Contrast 
  -- with devices such as pipelines, escalators, or supermarket 
  -- checkout belts, which carry items from one place to another by means 
  -- of a moving part, without the device removing from the origin to 
  -- the destination.
  fun Vehicle  : Class ;
  fun Vehicle_Class : SubClass Vehicle TransportationDevice ;

  -- Specifies the velocity of an object, i.e. the speed 
  -- and the direction of the speed. For example (VelocityFn (MeasureFn 55 Mile) 
  -- (MeasureFn 2 HourDuration) ?REFERENCE North) denotes the velocity of 55 miles 
  -- per hour North of the given reference point ?REFERENCE.
  fun VelocityFn  : El LengthMeasure -> El TimeDuration -> El Region -> El DirectionalAttribute -> Ind FunctionQuantity ;

  -- One of the parts of speech. The Class of Words 
  -- that conventionally denote Processes.
  fun Verb  : Class ;
  fun Verb_Class : SubClass Verb Word ;

  -- A Phrase that has the same function as a Verb.
  fun VerbPhrase  : Class ;
  fun VerbPhrase_Class : SubClass VerbPhrase Phrase ;

  -- An Animal which has a spinal column.
  fun Vertebrate  : Class ;
  fun Vertebrate_Animal  : SubClassC Vertebrate Animal 
                                     (\VERT -> and (and (and (exists SpinalColumn (\SPINE -> component (var SpinalColumn CorpuscularObject ? SPINE)
                                                                                                       (var Animal CorpuscularObject ? VERT)))
                                                             (forall NervousSystem (\S -> part (var NervousSystem Object ? S)
                                                                                               (var Animal Object ? VERT))))
                                                        (forall Skeleton (\SKELETON -> part (var Skeleton Object ? SKELETON)
                                                                                            (var Animal Object ? VERT))))
                                                   (forall Exoskeleton (\SKELETON -> part (var Exoskeleton Object ? SKELETON)
                                                                                          (var Animal Object ? VERT))));

  -- Attribute used to indicate that an Object 
  -- is positioned height_wise with respect to another Object.
  fun Vertical  : Ind PositionalAttribute ;

  -- A Contest where one participant attempts to 
  -- physically injure another participant.
  fun ViolentContest  : Class ;
  fun ViolentContest_Class : SubClass ViolentContest Contest ;

  -- An Organism consisting of a core of a single 
  -- nucleic acid enclosed in a protective coat of protein. A virus may replicate 
  -- only inside a host living cell. A virus exhibits some but not all of the 
  -- usual characteristics of living things.
  fun Virus  : Class ;
  fun Virus_Class : SubClass Virus Microorganism ;

  -- The Class of visually discernible 
  -- properties.
  fun VisualAttribute  : Class ;
  fun VisualAttribute_Class : SubClass VisualAttribute PerceptualAttribute ;

  -- A Nutrient present in natural products or made 
  -- synthetically, which is essential in the diet of Humans and other higher 
  -- Animals. Included here are Vitamin precursors and provitamins.
  fun Vitamin  : Class ;
  fun Vitamin_Class : SubClass Vitamin Nutrient ;

  -- The vocal cords, are composed
  -- of two folds of mucous membrane stretched horizontally across the
  -- larynx. They vibrate, modulating the flow of air being expelled from the
  -- lungs during Vocalizing.
  fun VocalCords  : Class ;
  fun VocalCords_Class : SubClass VocalCords Organ ;

  -- Any instance of RadiatingSound where the 
  -- instrument is the Human vocal cords. This covers grunts, screams, 
  -- roars, as well as Speaking.
  fun Vocalizing  : Class ;
  fun Vocalizing_Class : SubClass Vocalizing (both BodyMotion RadiatingSound) ;

  -- SI electric potential measure. Symbol: V. It is 
  -- the difference of electric potential between two points of a conducting 
  -- wire carrying a constant current of 1 Ampere, when the power dissipated 
  -- between these points is equal to 1 Watt. Volt = W/A = 
  -- m^2*kg*s^(_3)*A^(_1).
  fun Volt  : Ind CompositeUnitOfMeasure ;

  -- Measures of the amount of space in three dimensions.
  fun VolumeMeasure  : Class ;
  fun VolumeMeasure_Class : SubClass VolumeMeasure FunctionQuantity ;

  -- Voting is the activity of voting in an 
  -- Election. Voting is typically done by individuals, while Elections 
  -- are conducted by Organizations. The voting process by an individual 
  -- voter is part of an Election process.
  fun Voting  : Class ;
  fun Voting_Class : SubClass Voting Deciding ;

  -- Ambulating relatively slowly, i.e. moving in such a 
  -- way that at least one foot is always in contact with the ground.
  fun Walking  : Class ;
  fun Walking_Class : SubClass Walking Ambulating ;

  -- A military confrontation between two or more 
  -- GeopoliticalAreas or Organizations whose members are GeopoliticalAreas. 
  -- As the corresponding axiom specifies, a War is made up of Battles.
  fun War  : Class ;
  fun War_Class : SubClass War ViolentContest ;

  -- Vertebrates whose body temperature 
  -- is internally regulated.
  fun WarmBloodedVertebrate  : Class ;
  fun WarmBloodedVertebrate_Class : SubClass WarmBloodedVertebrate Vertebrate ;

  -- A Contract that states the cirumstances 
  -- under which defects in the product will be corrected for no charge. 
  -- A Warranty is usually limited to a length of time that is specified 
  -- in the Warranty itself. A Warranty also includes information about 
  -- what is not covered and actions that invalidate the Warranty.
  fun Warranty  : Ind DeonticAttribute ;

  -- The Class of samples of the compound H20. Note 
  -- that this Class covers both pure and impure Water.
  fun Water  : Class ;
  fun Water_Class : SubClass Water CompoundSubstance ;

  -- A body which is made up predominantly of water, 
  -- e.g. rivers, lakes, oceans, etc.
  fun WaterArea  : Class ;
  fun WaterArea_Class : SubClass WaterArea GeographicArea ;

  -- Any Cloud that is composed primarily of water vapor.
  fun WaterCloud  : Class ;
  fun WaterCloud_Class : SubClass WaterCloud Cloud ;

  -- Any LiquidMotion where the Liquid is Water.
  fun WaterMotion  : Class ;
  fun WaterMotion_Class : SubClass WaterMotion LiquidMotion ;

  -- SI power measure. Symbol: W. A UnitOfMeasure 
  -- that measures power, i.e. energy produced or expended divided by 
  -- TimeDuration. It is the power which gives rise to the production 
  -- of energy (or work) at the rate of one Joule per SecondDuration. 
  -- Watt = J/s = m^2*kg*s^(_3).
  fun Watt  : Ind CompositeUnitOfMeasure ;

  -- A UnaryFunction that maps an Agent to a 
  -- CurrencyMeasure specifying the value of the property owned by the Agent. 
  -- Note that this Function is generally used in conjunction with the 
  -- Function PropertyFn, e.g. (WealthFn (PropertyFn BillGates)) would 
  -- return the monetary value of the sum of Bill Gates' holdings.
  fun WealthFn  : El Agent -> Ind CurrencyMeasure ;

  -- The Class of Devices that are designed 
  -- primarily to damage or destroy Humans/Animals, StationaryArtifacts or 
  -- the places inhabited by Humans/Animals.
  fun Weapon  : Class ;
  fun Weapon_Class : SubClass Weapon Device ;

  -- WearableItem is the subclass of 
  -- Artifacts that are made to be worn on the body.
  fun WearableItem  : Class ;
  fun WearableItem_Class : SubClass WearableItem Artifact ;

  -- WeatherProcess is the broadest class of 
  -- processes that involve weather, including weather seasons (not to be confused 
  -- with instances of SeasonOfYear), weather systems, and short_term weather 
  -- events.
  fun WeatherProcess  : Class ;
  fun WeatherProcess_Class : SubClass WeatherProcess Motion ;

  -- SI magnetic flux measure. Symbol: Wb. It is the 
  -- magnetic flux which, linking a circuit of one turn, produces in it an
  -- electromotive force of 1 Volt as it is reduced to zero at a uniform
  -- rate in 1 SecondDuration. Weber = V*s = m^2*kg*s^(_2)*A^(_1).
  fun Weber  : Ind CompositeUnitOfMeasure ;

  -- Any Declaring that leads to one person being 
  -- the spouse of another.
  fun Wedding  : Class ;
  fun Wedding_Class : SubClass Wedding Declaring ;

  -- The Class of all calendar Wednesdays.
  fun Wednesday  : Class ;
  fun Wednesday_Class : SubClass Wednesday Day ;

  -- The Class of all calendar weeks.
  fun Week  : Class ;
  fun Week_Class : SubClass Week TimeInterval ;

  -- Time unit. A week's duration is seven days.
  fun WeekDuration  : Ind UnitOfDuration ;

  -- The compass direction of West.
  fun West  : Ind DirectionalAttribute ;

  -- An Attribute which indicates that the 
  -- associated Object is fully saturated with a Liquid, i.e. 
  -- every part of the Object has a subpart which is a Liquid.
  fun Wet  : Ind SaturationAttribute ;

  -- The Class of Processes where a Liquid is 
  -- added to an Object.
  fun Wetting  : Class ;
  fun Wetting_Class : SubClass Wetting Putting ;

  -- A UnaryFunction that maps an Object or 
  -- Process to the exact TimeInterval during which it exists. Note 
  -- that, for every TimePoint ?TIME outside of the TimeInterval 
  -- (WhenFn ?THING), (time ?THING ?TIME) does not hold.
  fun WhenFn  : El Physical -> Ind TimeInterval ;

  -- Maps an Object and a TimePoint at which the Object exists to
  -- the Region where the Object existed at that TimePoint.
  fun WhereFn  : El Physical -> El TimePoint -> Ind Region ;

  -- The Attribute of being white in color.
  fun White  : Ind PrimaryColor ;

  -- Any Motion of Air.
  fun Wind  : Class ;
  fun Wind_Class : SubClass Wind GasMotion ;

  -- The class of Female Humans.
  fun Woman  : Class ;
  fun Woman_Class : SubClass Woman Human ;

  -- A term of a Language that represents a concept.
  fun Word  : Class ;
  fun Word_Class : SubClass Word LinguisticExpression ;

  -- Long, narrow, soft_bodied Invertebrates.
  fun Worm  : Class ;
  fun Worm_Class : SubClass Worm Invertebrate ;

  -- A subclass of ContentDevelopment in which 
  -- content is converted from one form (e.g. uttered, written or represented 
  -- mentally) into a written form. Note that this class covers both 
  -- transcription and original creation of written Texts.
  fun Writing  : Class ;
  fun Writing_Class : SubClass Writing ContentDevelopment ;

  -- The Class of all calendar Years.
  fun Year  : Class ;
  fun Year_Class : SubClass Year TimeInterval ;

  -- Time unit. one calendar year. 1 year = 365 days = 31536000 seconds.
  fun YearDuration  : Ind UnitOfDuration ;

  -- A UnaryFunction that maps a number to the corresponding calendar 
  -- Year. For example, (YearFn 1912) returns the Class containing just one instance, 
  -- the year of 1912. As might be expected, positive integers return years in the Common Era, 
  -- while negative integers return years in B.C.E. Note that this function returns a Class 
  -- as a value. The reason for this is that the related functions, viz. MonthFn, DayFn, 
  -- HourFn, MinuteFn, and SecondFn, are used to generate both specific TimeIntervals 
  -- and recurrent intervals, and the only way to do this is to make the domains and ranges of 
  -- these functions classes rather than individuals.
  fun YearFn : El Integer -> Desc Year ;

  -- The Attribute of being yellow in color.
  fun Yellow  : Ind PrimaryColor ;

  -- (abstractCounterpart ?AB ?PHYS
  -- relates a Physical entity to an Abstract one which is an idealized
  -- model in some dimension of the Physical entity. For example, an
  -- Abstract GraphNode could be stated to be the counterpart of an 
  -- actual Computer in a ComputerNetwork.
  fun abstractCounterpart  : El Abstract -> El Physical -> Formula ;

  -- (acquaintance ?H1 ?H2) means that ?H1 has
  -- met and knows something about ?H2, such as ?H2's name and appearance.
  -- Statements made with this predicate should be temporally specified with
  -- holdsDuring. Note that acquaintance is not symmetric. For the
  -- symmetric version, see mutualAcquaintance.
  fun acquaintance  : El Human -> El Human -> Formula ;

  -- Simply relates an Object to a ConstantQuantity 
  -- specifying the age of the Object.
  fun age  : El Object -> El TimeDuration -> Formula ;

  -- (agent ?PROCESS ?AGENT) means that ?AGENT is 
  -- an active determinant, either animate or inanimate, of the Process 
  -- ?PROCESS, with or without voluntary intention. For example, Eve is an 
  -- agent in the following proposition: Eve bit an apple.
  fun agent  : El Process -> El Agent -> Formula ;

  -- A TernaryPredicate that is
  -- used to state the distance between the top of an Object and
  -- another point that is below the top of the Object (often this
  -- other point will be sea level). Note that this Predicate can be
  -- used to specify, for example, the height of geographic features,
  -- e.g. mountains, the altitude of aircraft, and the orbit of satellites
  -- around the Earth.
  fun altitude  : El Physical -> El Physical -> El LengthMeasure -> Formula ;

  -- The transitive closure of the parent predicate. 
  -- (ancestor ?DESCENDANT ?ANCESTOR) means that ?ANCESTOR is either the 
  -- parent of ?DESCENDANT or the parent of the parent of DESCENDANT or etc.
  fun ancestor  : El Organism -> El Organism -> Formula ;

  -- (angleOfFigure ?ANGLE ?FIGURE) means that 
  -- the TwoDimensionalAngle ?ANGLE is part of the GeometricFigure ?FIGURE.
  fun angleOfFigure  : El GeometricFigure -> El GeometricFigure -> Formula ;

  -- (angularMeasure ?ANGLE ?MEASURE) means that 
  -- the two_dimensional geometric angle ?ANGLE has the PlaneAngleMeasure of 
  -- ?MEASURE.
  fun angularMeasure  : El TwoDimensionalAngle -> El PlaneAngleMeasure -> Formula ;

  -- This predicate indicates the value of a 
  -- GraphArc in a Graph. This could map to the length of a road in 
  -- a road network or the flow rate of a pipe in a plumbing system.
  fun arcWeight  : El GraphArc -> El Quantity -> Formula ;

  -- (atomicNumber ?ELEMENT ?NUMBER) means that 
  -- the ElementalSubstance ?ELEMENT has the atomic number ?NUMBER. The 
  -- atomic number is the number of Protons in the nucleus of an Atom.
  fun atomicNumber : Desc ElementalSubstance -> El PositiveInteger -> Formula ;

  -- (attends ?DEMO ?PERSON) means that ?PERSON attends, 
  -- i.e. is a member of the audience, of the performance event ?DEMO.
  fun attends  : El Demonstrating -> El Human -> Formula ;

  -- (attribute ?OBJECT ?PROPERTY) means that 
  -- ?PROPERTY is a Attribute of ?OBJECT. For example, 
  -- (attribute MyLittleRedWagon Red).
  fun attribute  : El Object -> El Attribute -> Formula ;

  -- (authors ?AGENT ?TEXT) means that ?AGENT is 
  -- creatively responsible for ?TEXT. For example, Agatha Christie is 
  -- author of Murder_on_the_Orient_Express.
  fun authors : El Agent -> Desc Text -> Formula ;

  -- A partial function that relates a List to a 
  -- RealNumber, provided that the List only has list elements that are 
  -- RealNumbers. The RealNumber associated with the List is equal to the 
  -- mathematical average of the RealNumbers in the List divided by the total
  -- number of list elements.
  fun average  : El List -> El RealNumber -> Formula ;

  -- (barometricPressure ?AREA ?PRESSURE) means that the atmospheric 
  -- pressure measured at ?AREA is ?PRESSURE. Barometric pressure is 
  -- typically expressed in units of InchMercury or MmMercury. For 
  -- example, standard sea level pressure is 29.92 inches (760 mm) of mercury: 
  -- (barometricPressure SeaLevel (MeasureFn 29.92 InchMercury)).
  fun barometricPressure  : El Object -> El UnitOfAtmosphericPressure -> Formula ;

  -- (before ?POINT1 ?POINT2) means that ?POINT1 
  -- precedes ?POINT2 on the universal timeline.
  fun before  : El TimePoint -> El TimePoint -> Formula ;

  -- (beforeOrEqual ?POINT1 ?POINT2) means that ?POINT1 
  -- is identical with ?POINT2 or occurs before it on the universal timeline.
  fun beforeOrEqual  : El TimePoint -> El TimePoint -> Formula ;

  -- The epistemic predicate of belief. (believes ?AGENT ?FORMULA) means 
  -- that ?AGENT believes the proposition expressed by ?FORMULA.
  fun believes  : El CognitiveAgent -> Formula -> Formula ;

  -- (between ?OBJ1 ?OBJ2 ?OBJ3) means that ?OBJ2 is 
  -- spatially located between ?OBJ1 and ?OBJ3. Note that this implies that 
  -- ?OBJ2 is directly between ?OBJ1 and ?OBJ3, i.e. the projections of ?OBJ1 
  -- and ?OBJ3 overlap with ?OBJ2.
  fun between  : El Object -> El Object -> El Object -> Formula ;

  -- The temperature at which a PureSubstance changes
  -- state from a Liquid to a Gas.
  fun boilingPoint : Desc PureSubstance -> El TemperatureMeasure -> Formula ;

  -- (bottom ?BOTTOM ?OBJECT) holds if ?BOTTOM is the 
  -- lowest or deepest maximal superficial part of ?OBJECT.
  fun bottom  : El SelfConnectedObject -> El SelfConnectedObject -> Formula ;

  -- The general relationship of being a brother. 
  -- (brother ?MAN ?PERSON) means that ?MAN is the brother of ?PERSON.
  fun brother  : El Man -> El Human -> Formula ;

  -- The causation relation between instances of Process. 
  -- (causes ?PROCESS1 ?PROCESS2) means that the instance of Process ?PROCESS1 
  -- brings about the instance of Process ?PROCESS2.
  fun causes  : El Process -> El Process -> Formula ;

  -- (causesProposition ?FORMULA1 ?FORMULA2) means
  -- that the state of affairs described by ?FORMULA1
  -- causes, or mechanistically brings about, the state of affairs
  -- described by ?FORMULA2. Note that unlike entails, the time
  -- during which ?FORMULA2 holds cannot precede the time during which
  -- ?FORMULA1 holds, although ?FORMULA1 and ?FORMULA2 can hold
  -- simultaneously. Note, also, that causesProposition is a
  -- predicate, not a truth function. The following rule
  -- (contraposition) does not hold: (=> (causesProp ?FORMULA1
  -- ?FORMULA2) (causesProp (not ?FORMULA2) (not ?FORMULA1))).
  fun causesProposition  : Formula -> Formula -> Formula ;

  -- The causation relation between subclasses of Process. 
  -- (causesSubclass ?PROCESS1 ?PROCESS2) means that the subclass of Process ?PROCESS1 
  -- brings about the subclass of Process ?PROCESS2, e.g. (causesSubclass Killing 
  -- Death).
  fun causesSubclass : Desc Process -> Desc Process -> Formula ;

  -- (citizen ?PERSON ?NATION) means that the 
  -- Human ?PERSON is a citizen of Nation ?NATION.
  fun citizen  : El Human -> El Nation -> Formula ;

  -- (completelyFills ?OBJ ?HOLE) 
  -- means that some part of the Object ?OBJ fills the Hole ?HOLE. 
  -- Note that if (completelyFills ?OBJ1 ?HOLE) and (part ?OBJ1 ?OBJ2),
  -- then (completelyFills ?OBJ2 ?HOLE). A complete filler of (a part of) a hole
  -- is connected with everything with which (that part of) the hole itself is connected. 
  -- A perfect filler of (a part of) a hole completely fills every proper 
  -- part of (that part of) that hole.
  fun completelyFills  : El Object -> El Hole -> Formula ;

  -- A specialized common sense notion of part 
  -- for heterogeneous parts of complexes. (component ?COMPONENT ?WHOLE) 
  -- means that ?COMPONENT is a component of ?WHOLE. Examples of component 
  -- include the doors and walls of a house, the states or provinces of a 
  -- country, or the limbs and organs of an animal. Compare piece, which 
  -- is also a subrelation of part.
  fun component  : El CorpuscularObject -> El CorpuscularObject -> Formula ;

  -- (conclusion ?ARGUMENT ?PROPOSITION) means that
  -- the Proposition ?PROPOSITION is the conclusion explicitly drawn from the 
  -- Argument ?ARGUMENT. Note that it may or may not be the case that ?ARGUMENT 
  -- entails ?PROPOSITION.
  fun conclusion  : El Argument -> El Proposition -> Formula ;

  -- One of the basic ProbabilityRelations. 
  -- conditionalProbability is used to state the numeric value of a conditional 
  -- probability. (conditionalProbability ?FORMULA1 ?FORMULA2 ?NUMBER) means 
  -- that the probability of ?FORMULA2 being true given that ?FORMULA1 is true is 
  -- ?NUMBER.
  fun conditionalProbability  : Formula -> Formula -> El RealNumber -> Formula ;

  -- Expresses the relationship between a Formula, 
  -- an Entity, and an ObjectiveNorm when the Entity brings it about that 
  -- the Formula has the ObjectiveNorm.
  fun confersNorm  : El Entity -> Formula -> El ObjectiveNorm -> Formula ;

  -- Expresses the relationship between a 
  -- a Formula, an Entity, and a CognitiveAgent when the Entity 
  -- obligates the CognitiveAgent to bring it about that the Formula is true.
  fun confersObligation  : Formula -> El Entity -> El CognitiveAgent -> Formula ;

  -- Expresses the relationship between a Formula, 
  -- an Entity, and a CognitiveAgent when the Entity authorizes the 
  -- CognitiveAgent to bring it about that the Formula is true.
  fun confersRight  : Formula -> El Entity -> El CognitiveAgent -> Formula ;

  -- (connected ?OBJ1 ?OBJ2) means that ?OBJ1 
  -- meetsSpatially ?OBJ2 or that ?OBJ1 overlapsSpatially ?OBJ2.
  fun connected  : El Object -> El Object -> Formula ;

  -- This is the most general 
  -- connection relation between EngineeringComponents. If 
  -- (connectedEngineeringComponents ?COMP1 ?COMP2), then neither ?COMP1 nor 
  -- ?COMP2 can be an engineeringSubcomponent of the other. The relation 
  -- connectedEngineeringComponents is a SymmetricRelation, there is no 
  -- information in the direction of connection between two components. It is 
  -- also an IrreflexiveRelation, no EngineeringComponent bears this relation 
  -- to itself. Note that this relation does not associate a name or type 
  -- with the connection.
  fun connectedEngineeringComponents  : El EngineeringComponent -> El EngineeringComponent -> Formula ;

  -- The relationship between three things, when one of 
  -- the three things connects the other two. More formally, (connects ?OBJ1 ?OBJ2 ?OBJ3)
  -- means that (connected ?OBJ1 ?OBJ2) and (connected ?OBJ1 ?OBJ3)
  -- and not (connected ?OBJ2 ?OBJ3).
  fun connects  : El SelfConnectedObject -> El SelfConnectedObject -> El SelfConnectedObject -> Formula ;

  -- connectsEngineeringComponents 
  -- is a TernaryPredicate that maps from an EngineeringConnection to the 
  -- EngineeringComponents it connects. Since EngineeringComponents cannot 
  -- be connected to themselves and there cannot be an EngineeringConnection 
  -- without a connectedEngineeringComponents Predicate, the second and third 
  -- arguments of any connectsEngineeringComponents relationship will always be 
  -- distinct for any given first argument.
  fun connectsEngineeringComponents  : El EngineeringComponent -> El EngineeringComponent -> El SelfConnectedObject -> Formula ;

  -- (considers ?AGENT ?FORMULA) means that ?AGENT considers or wonders
  -- about the truth of the proposition expressed by ?FORMULA.
  fun considers  : El CognitiveAgent -> Formula -> Formula ;

  -- (consistent ?PROP1 ?PROP2) means that the two 
  -- Propositions ?PROP1 and ?PROP2 are consistent with one another, i.e. it 
  -- is possible for both of them to be true at the same time.
  fun consistent  : El Proposition -> El Proposition -> Formula ;

  -- The relation of spatial containment for two 
  -- separable objects. When the two objects are not separable (e.g. an 
  -- automobile and one of its seats), the relation of part should be used. 
  -- (contains ?OBJ1 ?OBJ2) means that the SelfConnectedObject ?OBJ1 has 
  -- a space (i.e. a Hole) which is at least partially filled by ?OBJ2.
  fun contains  : El SelfConnectedObject -> El Object -> Formula ;

  -- A subrelation of represents. This 
  -- predicate relates a ContentBearingPhysical to the Proposition that is 
  -- expressed by the ContentBearingPhysical. Examples include the relationships 
  -- between a physical novel and its story and between a printed score and its 
  -- musical content.
  fun containsInformation  : El ContentBearingPhysical -> El Proposition -> Formula ;

  -- A contraryAttribute is a set of Attributes 
  -- such that something can not simultaneously have more than one of these Attributes. 
  -- For example, (contraryAttribute Pliable Rigid) means that nothing can be both 
  -- Pliable and Rigid.
  fun contraryAttribute  : [El Attribute] -> Formula ;

  -- (cooccur ?THING1 ?THING2) means that the 
  -- Object or Process ?THING1 occurs at the same time as, together with, 
  -- or jointly with the Object or Process ?THING2. This covers the 
  -- following temporal relations: is co_incident with, is concurrent with, 
  -- is contemporaneous with, and is concomitant with.
  fun cooccur  : El Physical -> El Physical -> Formula ;

  -- relates an Object to an exact copy of the 
  -- Object, where an exact copy is indistinguishable from the original 
  -- with regard to every property except (possibly) spatial and/or temporal 
  -- location.
  fun copy  : El Object -> El Object -> Formula ;

  -- (crosses ?OBJ1 ?OBJ2) means that Object ?OBJ1 
  -- traverses Object ?OBJ2, without being connected to it.
  fun crosses  : El Object -> El Object -> Formula ;

  -- A BinaryPredicate that specifies a 
  -- TimePosition in absolute calendar time, at the resolution 
  -- of one day, for a particular Object or Process.
  fun date  : El Physical -> El Day -> Formula ;

  -- The general relationship of daughterhood. 
  -- (daughter ?CHILD ?PARENT) means that ?CHILD is 
  -- the biological daughter of ?PARENT.
  fun daughter  : El Organism -> El Organism -> Formula ;

  -- One of the basic ProbabilityRelations. 
  -- (decreasesLikelihood ?FORMULA1 ?FORMULA2) means that ?FORMULA2 is less 
  -- likely to be true if ?FORMULA1 is true.
  fun decreasesLikelihood  : Formula -> Formula -> Formula ;

  -- Expresses the relationship between an 
  -- Entity, a Formula, and an ObjectiveNorm when the Entity 
  -- brings it about that the Formula does not have the ObjectiveNorm.
  fun deprivesNorm  : El Entity -> Formula -> El ObjectiveNorm -> Formula ;

  -- A TernaryPredicate that is
  -- used to state the distance between the top of an Object and
  -- another point that is above the top of the Object (often this
  -- other point will be sea level). Note that this Predicate can be
  -- used to specify, for example, the depth of marine life or submarines,
  -- for example.
  fun depth  : El Physical -> El Physical -> El LengthMeasure -> Formula ;

  -- (desires ?AGENT ?FORMULA) means that ?AGENT wants 
  -- to bring about the state of affairs expressed by ?FORMULA. Note that there 
  -- is no implication that what is desired by the agent is not already true. 
  -- Note too that desires is distinguished from wants only in that the former 
  -- is a PropositionalAttitude, while wants is an ObjectAttitude.
  fun desires  : El CognitiveAgent -> Formula -> Formula ;

  -- (destination ?PROCESS ?GOAL) means that 
  -- ?GOAL is the target or goal of the Process ?PROCESS. For example, 
  -- Danbury would be the destination in the following proposition: Bob went 
  -- to Danbury. Note that this is a very general CaseRole and, in 
  -- particular, that it covers the concepts of 'recipient' and 'beneficiary'. 
  -- Thus, John would be the destination in the following proposition: 
  -- Tom gave a book to John.
  fun destination  : El Process -> El Entity -> Formula ;

  -- (developmentalForm ?OBJECT ?FORM) 
  -- means that ?FORM is an earlier stage in the individual maturation of 
  -- ?OBJECT. For example, tadpole and caterpillar are developmentalForms 
  -- of frogs and butterflies, respectively.
  fun developmentalForm  : El OrganicObject -> El DevelopmentalAttribute -> Formula ;

  -- (diameter ?CIRCLE ?LENGTH) means that the diameter 
  -- of the Circle ?CIRCLE has a length of ?LENGTH.
  fun diameter  : El Circle -> El LengthMeasure -> Formula ;

  -- (direction ?PROC ?ATTR) means that the 
  -- Process ?PROC is moving in the direction ?ATTR. For example, one 
  -- would use this Predicate to represent the fact that Max is moving 
  -- North.
  fun direction  : El Process -> El DirectionalAttribute -> Formula ;

  -- Classes are disjoint only if they share no 
  -- instances, i.e. just in case the result of applying IntersectionFn to
  -- them is empty.
  fun disjoint  : El SetOrClass -> El SetOrClass -> Formula ;

  -- A disjointDecomposition of a Class 
  -- C is a set of subclasses of C that are mutually disjoint.
  fun disjointDecomposition  : Class -> [Class] -> Formula ;

  -- (distance ?OBJ1 ?OBJ2 ?QUANT) means that the 
  -- shortest distance between the two objects ?OBJ1 and ?OBJ2 is ?QUANT. Note 
  -- that the difference between the predicates length and distance is that 
  -- the length is used to state the LengthMeasure of one of the dimensions of 
  -- a single object, while distance is used to state the LengthMeasure that 
  -- separates two distinct objects.
  fun distance  : El Physical -> El Physical -> El LengthMeasure -> Formula ;

  -- A relation between objects 
  -- in the domain of discourse and strings of natural language text stated in 
  -- a particular HumanLanguage. The domain of documentation is not 
  -- constants (names), but the objects themselves. This means that one does 
  -- not quote the names when associating them with their documentation.
  fun documentation  : El Entity -> El HumanLanguage -> El SymbolicString -> Formula ;

  -- (duration ?POS ?TIME) means that the 
  -- duration of the TimePosition ?POS is ?TIME. Note that this 
  -- Predicate can be used in conjunction with the Function WhenFn 
  -- to specify the duration of any instance of Physical.
  fun duration  : El TimeInterval -> El TimeDuration -> Formula ;

  -- (during ?INTERVAL1 ?INTERVAL2) means that 
  -- ?INTERVAL1 starts after and ends before ?INTERVAL2.
  fun during  : El TimeInterval -> El TimeInterval -> Formula ;

  -- (earlier ?INTERVAL1 ?INTERVAL2) means that 
  -- the TimeInterval ?INTERVAL1 ends before the TimeInterval ?INTERVAL2 
  -- begins.
  fun earlier  : El TimeInterval -> El TimeInterval -> Formula ;

  -- (editor ?AGENT ?TEXT) means that ?AGENT is 
  -- an editor of ?TEXT.
  fun editor : El Agent -> Desc Text -> Formula ;

  -- (element ?ENTITY ?SET) is true just in case 
  -- ?ENTITY is contained in the Set ?SET. An Entity can be an element 
  -- of another Entity only if the latter is a Set.
  fun element  : El Entity -> El Set -> Formula ;

  -- (employs ?ORG ?PERSON) means that ?ORG has 
  -- hired ?PERSON and currently retains ?PERSON, on a salaried, hourly 
  -- or contractual basis, to provide services in exchange for monetary 
  -- compensation.
  fun employs  : El Organization -> El CognitiveAgent -> Formula ;

  -- (engineeringSubcomponent ?SUB ?SUPER)
  -- means that the EngineeringComponent ?SUB is structurally a 
  -- properPart of ?SUPER. This relation is an AsymmetricRelation, since 
  -- two EngineeringComponents cannot be subcomponents of each other.
  fun engineeringSubcomponent  : El EngineeringComponent -> El EngineeringComponent -> Formula ;

  -- The operator of logical entailment. (entails ?FORMULA1 ?FORMULA2)
  -- means that ?FORMULA2 can be derived from ?FORMULA1 
  -- by means of the proof theory of SUO_KIF.
  fun entails  : Formula -> Formula -> Formula ;

  -- (equal ?ENTITY1 ?ENTITY2) is true just in case 
  -- ?ENTITY1 is identical with ?ENTITY2.
  fun equal  : El Entity -> El Entity -> Formula ;

  -- A binary predicate that relates two subclasses of ContentBearingObject. 
  -- (equivalentContentClass ?CLASS1 ?CLASS2) means that the content expressed by
  -- each instance of ?CLASS1 is also expressed by each instance of ?CLASS2, 
  -- and vice versa. An example would be the relationship between English and Russian
  -- editions of Agatha Christie's 'Murder on the Orient Express'. Note that 
  -- (equivalentContentClass ?CLASS1 ?CLASS2) implies
  -- (subsumesContentClass ?CLASS1 ?CLASS2) and (subsumesContentClass ?CLASS2 ?CLASS1).
  fun equivalentContentClass  : Desc ContentBearingObject -> Desc ContentBearingObject -> Formula ;

  -- A BinaryPredicate relating two 
  -- instances of ContentBearingObject. (equivalentContentInstance ?OBJ1 ?OBJ2)
  -- means that the content expressed by ?OBJ1 is identical to 
  -- the content expressed by ?OBJ2. An example would be the relationship 
  -- between a handwritten draft of a letter to one's lawyer and a typed 
  -- copy of the same letter. Note that (equivalentContentInstance ?OBJ1 ?OBJ2) 
  -- implies (subsumesContentInstance ?OBJ1 ?OBJ2) and 
  -- (subsumesContentInstance ?OBJ2 ?OBJ2).
  fun equivalentContentInstance  : El ContentBearingObject -> El ContentBearingObject -> Formula ;

  -- The actual, minimal location of an Object. 
  -- This is a subrelation of the more general Predicate located.
  fun exactlyLocated  : El Physical -> El Object -> Formula ;

  -- This predicate relates a Class to a 
  -- set of Attributes, and it means that the elements of this set exhaust the 
  -- instances of the Class. For example, (exhaustiveAttribute PhysicalState 
  -- Solid Fluid Liquid Gas Plasma) means that there are only five instances of 
  -- the class PhysicalState, viz. Solid, Fluid, Liquid, Gas and Plasma.
  fun exhaustiveAttribute : Desc Attribute -> [El Attribute] -> Formula ;

  -- An exhaustiveDecomposition of a 
  -- Class C is a set of subclasses of C such that every instance of C is an 
  -- instance of one of the subclasses in the set. Note: this does not necessarily 
  -- mean that the elements of the set are disjoint (see partition _ a partition 
  -- is a disjoint exhaustive decomposition).
  fun exhaustiveDecomposition  : Class -> [Class] -> Formula ;

  -- (experiencer ?PROCESS ?AGENT) means 
  -- that ?AGENT experiences the Process ?PROCESS. For example, Yojo 
  -- is the experiencer of seeing in the following proposition: Yojo 
  -- sees the fish. Note that experiencer, unlike agent, does 
  -- not entail a causal relation between its arguments.
  fun experiencer  : El Process -> El Entity -> Formula ;

  -- (exploits ?OBJ ?AGENT) means that ?OBJ is used 
  -- by ?AGENT as a resource in an unspecified instance of Process. This 
  -- Predicate, as its corresponding axiom indicates, is a composition of the 
  -- relations agent and resource.
  fun exploits  : El Object -> El Agent -> Formula ;

  -- (expressedInLanguage ?EXPRESS ?LANG) means that the
  -- LinguisticExpression ?EXPRESS is part of the Language ?LANG.
  fun expressedInLanguage  : El LinguisticExpression -> El Language -> Formula ;

  -- (faces ?OBJ ?DIRECTION) means that the front of 
  -- ?OBJ (see FrontFn) is positioned towards the compass direction ?DIRECTION. 
  -- More precisely, it means that if a line were extended from the center of 
  -- ?DIRECTION, the line would intersect with the front of ?OBJ before it 
  -- intersected with its back (see BackFn).
  fun faces  : El Object -> El DirectionalAttribute -> Formula ;

  -- A very general Predicate for biological 
  -- relationships. (familyRelation ?ORGANISM1 ?ORGANISM2) means that 
  -- ?ORGANISM1 and ?ORGANISM2 are biologically derived from a common ancestor.
  fun familyRelation  : El Organism -> El Organism -> Formula ;

  -- The general relationship of fatherhood. 
  -- (father ?CHILD ?FATHER) means that ?FATHER is the biological father of ?CHILD.
  fun father  : El Organism -> El Organism -> Formula ;

  -- Holes can be filled. (fills ?OBJ ?HOLE) 
  -- means that the Object ?OBJ fills the Hole ?HOLE. Note that 
  -- fills here means perfectly filled. Perfect fillers and fillable entities have no parts in common (rather, 
  -- they may occupy the same spatial region).
  fun fills  : El Object -> El Hole -> Formula ;

  -- (finishes ?INTERVAL1 ?INTERVAL2) means that 
  -- ?INTERVAL1 and ?INTERVAL2 are both TimeIntervals that have the same 
  -- ending TimePoint and that ?INTERVAL2 begins before ?INTERVAL1.
  fun finishes  : El TimeInterval -> El TimeInterval -> Formula ;

  -- (frequency ?PROC ?TIME) means that the 
  -- Process type of ?PROC recurs after every interval of ?TIME.
  fun frequency : Desc Process -> El TimeDuration -> Formula ;

  -- (geographicSubregion ?PART ?WHOLE) means that the GeographicArea ?PART is
  -- part of the GeographicArea ?WHOLE.
  fun geographicSubregion  : El GeographicArea -> El GeographicArea -> Formula ;

  -- (geometricDistance ?POINT1 ?POINT2 ?LENGTH)
  -- means that ?LENGTH is the distance between the two 
  -- GeometricPoints ?POINT1 and ?POINT2.
  fun geometricDistance  : El GeometricPoint -> El GeometricPoint -> El LengthMeasure -> Formula ;

  -- (geometricPart ?PART ?WHOLE) means that the 
  -- GeometricFigure ?PART is part of the GeometricFigure ?WHOLE.
  fun geometricPart  : El GeometricFigure -> El GeometricFigure -> Formula ;

  -- (geopoliticalSubdivision ?AREA1 ?AREA2) means that ?AREA1 is any 
  -- geopolitical part of ?AREA2, that is, ?AREA1 is
  -- an integral geographicSubregion of ?AREA2 (not a DependencyOrSpecialSovereigntyArea), 
  -- having its own associated GovernmentOrganization which is subordinated to or constrained by 
  -- the government of ?AREA2. Cf. dependentGeopoliticalArea.
  fun geopoliticalSubdivision  : El GeopoliticalArea -> El GeopoliticalArea -> Formula ;

  -- (graphMeasure ?GRAPH ?MEAS) fixes a 
  -- UnitOfMeasure that is used for the arcWeight of a given Graph. Stating 
  -- such a relationship entails that the components of given graph are the 
  -- abstractCounterparts of sets of Physical Entity(ies).
  fun graphMeasure  : El Graph -> El UnitOfMeasure -> Formula ;

  -- A basic relation for Graphs and their 
  -- parts. (graphPart ?PART ?GRAPH) means that ?PART is a GraphArc 
  -- or GraphNode of the Graph ?GRAPH.
  fun graphPart  : El GraphElement -> El Graph -> Formula ;

  -- The state of grasping an Object. (grasps ?ANIMAL ?OBJ) means
  -- that the Animal ?ANIMAL is intentionally holding
  -- on to the Object ?OBJ.
  fun grasps  : El Animal -> El Object -> Formula ;

  -- (greaterThan ?NUMBER1 ?NUMBER2) is true 
  -- just in case the Quantity ?NUMBER1 is greater than the Quantity 
  -- ?NUMBER2.
  fun greaterThan  : El Quantity -> El Quantity -> Formula ;

  -- (greaterThanByQuality ?ENTITY1 ?ENTITY2 ?ATT) means that
  -- ?ENTITY1 has more of the given quality ?ATT than ?ENTITY2
  fun greaterThanByQuality  : El Entity -> El Entity -> El Attribute -> Formula ;

  -- (greaterThanOrEqualTo ?NUMBER1 
  -- ?NUMBER2) is true just in case the Quantity ?NUMBER1 is greater 
  -- than the Quantity ?NUMBER2.
  fun greaterThanOrEqualTo  : El Quantity -> El Quantity -> Formula ;

  -- This Predicate expresses the concept of a 
  -- conventional goal, i.e. a goal with a neutralized agent's intention. 
  -- Accordingly, (hasPurpose ?THING ?FORMULA) means that the instance of 
  -- Physical ?THING has, as its purpose, the Proposition expressed by 
  -- ?FORMULA. Note that there is an important difference in meaning between 
  -- the Predicates hasPurpose and result. Although the second argument 
  -- of the latter can satisfy the second argument of the former, 
  -- a conventional goal is an expected and desired outcome, while a result 
  -- may be neither expected nor desired. For example, a machine process may 
  -- have outcomes but no goals, aimless wandering may have an outcome but no 
  -- goal, a learning process may have goals with no outcomes, and so on.
  fun hasPurpose  : El Physical -> Formula -> Formula ;

  -- Expresses a cognitive attitude of an 
  -- agent with respect to a particular instance of Physical. More precisely, 
  -- (hasPurposeForAgent ?THING ?FORMULA ?AGENT) means that the purpose of 
  -- ?THING for ?AGENT is the proposition expressed by ?FORMULA. Very complex 
  -- issues are involved here. In particular, the rules of inference of the 
  -- first order predicate calculus are not truth_preserving for the second 
  -- argument position of this Predicate.
  fun hasPurposeForAgent  : El Physical -> Formula -> El CognitiveAgent -> Formula ;

  -- Similar to the capability Predicate 
  -- with the additional restriction that the ability be practised/
  -- demonstrated to some measurable degree.
  fun hasSkill : Desc Process -> El Agent -> Formula ;

  -- The height of an Object is the distance between 
  -- its top and its bottom.
  fun height  : El SelfConnectedObject -> El LengthMeasure -> Formula ;

  -- (holdsDuring ?TIME ?FORMULA) means that the 
  -- proposition denoted by ?FORMULA is true in the time frame ?TIME. Note 
  -- that this implies that ?FORMULA is true at every TimePoint which is a 
  -- temporalPart of ?TIME.
  fun holdsDuring  : El TimePosition -> Formula -> Formula ;

  -- Expresses a relationship between a 
  -- Formula and a CognitiveAgent whereby the CognitiveAgent has 
  -- the obligation to bring it about that the Formula is true.
  fun holdsObligation  : Formula -> El CognitiveAgent -> Formula ;

  -- Expresses a relationship between a Formula 
  -- and a CognitiveAgent whereby the CognitiveAgent has the right to 
  -- bring it about that the Formula is true.
  fun holdsRight  : Formula -> El CognitiveAgent -> Formula ;

  -- (hole ?HOLE ?OBJ) means that ?HOLE is a 
  -- Hole in ?OBJ. A Hole is a fillable body located at the 
  -- surface an Object.
  fun hole  : El Hole -> El SelfConnectedObject -> Formula ;

  -- The relation between a Human and a PermanentResidence 
  -- of the Human.
  fun home  : El Human -> El PermanentResidence -> Formula ;

  -- (husband ?MAN ?WOMAN) means that ?MAN is the 
  -- husband of ?WOMAN.
  fun husband  : El Man -> El Woman -> Formula ;

  -- (identicalListItems ?LIST1 ?LIST2) 
  -- means that ?LIST1 and ?LIST2 have exactly the same items in their 
  -- respective lists. Although ?LIST1 and ?LIST2 are required to share 
  -- exactly the same items, they may order these items differently.
  fun identicalListItems  : El List -> El List -> Formula ;

  -- A SetOrClass ?CLASS1 is an immediateSubclass 
  -- of another SetOrClass ?CLASS2 just in case ?CLASS1 is a subclass of ?CLASS2 and 
  -- there is no other subclass of ?CLASS2 such that ?CLASS1 is also a subclass of it.
  fun immediateSubclass  : El SetOrClass -> El SetOrClass -> Formula ;

  -- The analog of element and instance for Lists. 
  -- (inList ?OBJ ?LIST) means that ?OBJ is in the List ?LIST. For example, 
  -- (inList Tuesday (ListFn Monday Tuesday Wednesday)) would be true.
  fun inList  : El Entity -> El List -> Formula ;

  -- A very general Predicate. 
  -- (inScopeOfInterest ?AGENT ?ENTITY) means that ?ENTITY is within the 
  -- scope of interest of ?AGENT. Note that the interest indicated can be 
  -- either positive or negative, i.e. the ?AGENT can have an interest in 
  -- avoiding or promoting ?ENTITY.
  fun inScopeOfInterest  : El CognitiveAgent -> El Entity -> Formula ;

  -- One of the basic ProbabilityRelations. 
  -- (increasesLikelihood ?FORMULA1 ?FORMULA2) means that ?FORMULA2 is more 
  -- likely to be true if ?FORMULA1 is true.
  fun increasesLikelihood  : Formula -> Formula -> Formula ;

  -- One of the basic ProbabilityRelations. 
  -- (independentProbability ?FORMULA1 ?FORMULA2) means that the probabilities of 
  -- ?FORMULA1 and ?FORMULA2 being true are independent.
  fun independentProbability  : Formula -> Formula -> Formula ;

  -- A very basic notion of living within something 
  -- else. (inhabits ?ORGANISM ?OBJECT) means that ?OBJECT is the residence 
  -- (either permanent or temporary), nest, etc. of ?ORGANISM.
  fun inhabits  : El Organism -> El Object -> Formula ;

  -- A very general Predicate. (inhibits ?PROC1 ?PROC2) means
  -- that the Process ?PROC1 inhibits or hinders 
  -- the occurrence of the Process ?PROC2. For example, obstructing an 
  -- object inhibits moving it. Note that this is a relation between types 
  -- of Processes, not between instances.
  fun inhibits : Desc Process -> Desc Process -> Formula ;

  -- (instrument ?EVENT ?TOOL) means that ?TOOL 
  -- is used by an agent in bringing about ?EVENT and that ?TOOL is not 
  -- changed by ?EVENT. For example, the key is an instrument in the 
  -- following proposition: The key opened the door. Note that instrument 
  -- and resource cannot be satisfied by the same ordered pair.
  fun instrument  : El Process -> El Object -> Formula ;

  -- (interiorPart ?OBJ1 ?OBJ2) means 
  -- that ?OBJ1 is part ?OBJ2 and there is no overlap between ?OBJ1 and 
  -- any superficialPart ?OBJ2.
  fun interiorPart  : El Object -> El Object -> Formula ;

  -- (involvedInEvent ?EVENT ?THING) means 
  -- that in the Process ?EVENT, the Entity ?THING plays some CaseRole.
  fun involvedInEvent  : El Process -> El Entity -> Formula ;

  -- The epistemic predicate of knowing. (knows 
  -- ?AGENT ?FORMULA) means that ?AGENT knows the proposition expressed by 
  -- ?FORMULA. Note that knows entails conscious awareness, so this 
  -- Predicate cannot be used to express tacit or subconscious or 
  -- unconscious knowledge.
  fun knows  : El CognitiveAgent -> Formula -> Formula ;

  -- (larger ?OBJ1 ?OBJ2) means that ?OBJ1 is 
  -- larger, with respect to all LengthMeasures, than ?OBJ2.
  fun larger  : El Object -> El Object -> Formula ;

  -- (leader ?INSTITUTION ?PERSON)
  -- means that the leader of ?INSTITUTION is ?PERSON.
  fun leader  : El Agent -> El Human -> Formula ;

  -- (legalRelation ?AGENT1 ?AGENT2) means 
  -- that ?AGENT1 and ?AGENT2 are relatives by virtue of a legal relationship. 
  -- Some examples include marriage, adoption, etc.
  fun legalRelation  : El Human -> El Human -> Formula ;

  -- binary predicate that is used to state the measure 
  -- of an Object along its longest span.
  fun length  : El Object -> El PhysicalQuantity -> Formula ;

  -- (lessThan ?NUMBER1 ?NUMBER2) is true just 
  -- in case the Quantity ?NUMBER1 is less than the Quantity ?NUMBER2.
  fun lessThan  : El Quantity -> El Quantity -> Formula ;

  -- (lessThanOrEqualTo ?NUMBER1 ?NUMBER2) is true
  -- just in case the Quantity ?NUMBER1 is less than or equal to 
  -- the Quantity ?NUMBER2.
  fun lessThanOrEqualTo  : El Quantity -> El Quantity -> Formula ;

  -- (lineMeasure ?LINE ?MEASURE) means that the 
  -- straight line ?LINE has the LengthMeasure of ?MEASURE.
  fun lineMeasure  : El OneDimensionalFigure -> El LengthMeasure -> Formula ;

  -- Binary predicate that is used to state the measure 
  -- of an Object from one point to another point along its surface. Note 
  -- that the difference between the predicates length and distance is that 
  -- the length is used to state the LengthMeasure of one of the dimensions of 
  -- a single object, while distance is used to state the LengthMeasure that 
  -- separates two distinct objects.
  fun linearExtent  : El Object -> El LengthMeasure -> Formula ;

  -- a TernaryPredicate that specifies the 
  -- GraphArc connecting two GraphNodes.
  fun links  : El GraphNode -> El GraphNode -> El GraphArc -> Formula ;

  -- (located ?PHYS ?OBJ) means that ?PHYS is partlyLocated at ?OBJ, 
  -- and there is no part or subProcess of ?PHYS that is not located at ?OBJ.
  fun located  : El Physical -> El Object -> Formula ;

  -- (manner ?PROCESS ?MANNER) means that the 
  -- Process ?PROCESS is qualified by the Attribute ?MANNER. The Attributes 
  -- of Processes are usually denoted by adverbs and include things like the 
  -- speed of the wind, the style of a dance, or the intensity of a sports 
  -- competition.
  fun manner  : El Process -> El Attribute -> Formula ;

  -- (material ?SUBSTANCE ?OBJECT) means that 
  -- ?OBJECT is structurally made up in part of ?SUBSTANCE. This relation 
  -- encompasses the concepts of 'composed of', 'made of', and 'formed of'. 
  -- For example, plastic is a material of my computer monitor. Compare 
  -- part and its subrelations, viz component and piece.
  fun material : Desc Substance -> El CorpuscularObject -> Formula ;

  -- A very general Predicate for
  -- asserting that a particular Object is measured by a particular
  -- PhysicalQuantity. In general, the second argument of this
  -- Predicate will be a term produced with the Function MeasureFn.
  fun measure  : El Object -> El PhysicalQuantity -> Formula ;

  -- (meetsSpatially ?OBJ1 ?OBJ2) means that 
  -- ?OBJ1 and ?OBJ2 are connected but that neither ?OBJ1 nor ?OBJ2 
  -- overlapsSpatially the other.
  fun meetsSpatially  : El Object -> El Object -> Formula ;

  -- (meetsTemporally ?INTERVAL1 ?INTERVAL2) 
  -- means that the terminal point of the TimeInterval ?INTERVAL1 is the 
  -- initial point of the TimeInterval ?INTERVAL2.
  fun meetsTemporally  : El TimeInterval -> El TimeInterval -> Formula ;

  -- The temperature at which a PureSubstance changes
  -- state from a Solid to a Liquid. Note that Arsenic can sublimate directly
  -- from Solid to Gas which means that its melting and boiling points are equal.
  fun meltingPoint : Desc PureSubstance -> El TemperatureMeasure -> Formula ;

  -- A specialized common sense notion of part for 
  -- uniform parts of Collections. For example, each sheep in a flock of 
  -- sheep would have the relationship of member to the flock.
  fun member  : El SelfConnectedObject -> El Collection -> Formula ;

  -- A BinaryRelation that is used to state the 
  -- normative force of a Proposition. (modalAttribute ?FORMULA ?PROP) means 
  -- that the Proposition expressed by ?FORMULA has the NormativeAttribute 
  -- ?PROP. For example, (modalAttribute (exists (?ACT ?OBJ) (and 
  -- (instance ?ACT Giving) (agent ?ACT John) (patient ?ACT ?OBJ) 
  -- (destination ?ACT Tom))) Obligation) means that John is obligated to give 
  -- Tom something.
  fun modalAttribute  : Formula -> El NormativeAttribute -> Formula ;

  -- A BinaryPredicate that associates an 
  -- Object or Process with its value expressed as an instance of 
  -- CurrencyMeasure.
  fun monetaryValue  : El Physical -> El CurrencyMeasure -> Formula ;

  -- The general relationship of motherhood. 
  -- (mother ?CHILD ?MOTHER) means that ?MOTHER is the biological mother 
  -- of ?CHILD.
  fun mother  : El Organism -> El Organism -> Formula ;

  -- (multiplicativeFactor ?NUMBER1 ?NUMBER2) 
  -- means that ?NUMBER1 is a factor of ?NUMBER2, i.e. ?NUMBER1 can be multiplied by 
  -- some Integer to give ?NUMBER2 as a result.
  fun multiplicativeFactor  : El Integer -> El Integer -> Formula ;

  -- (mutualAcquaintance ?H1 ?H2) means
  -- that ?H1 and ?H2 have met each other and know something about each other,
  -- such as name and appearance. Statements made with this predicate should
  -- be temporally specified with holdsDuring. See also the weaker,
  -- non_symmetric version of this predicate, acquaintance.
  fun mutualAcquaintance  : El Human -> El Human -> Formula ;

  -- (names ?STRING ?ENTITY) means that the thing ?ENTITY 
  -- has the SymbolicString ?STRING as its name. Note that names and represents 
  -- are the two immediate subrelations of refers. The predicate names is used 
  -- when the referring item is merely a tag without connotative content, while the 
  -- predicate represents is used for referring items that have such content.
  fun names  : El SymbolicString -> El Entity -> Formula ;

  -- (needs ?AGENT ?OBJECT) means that ?OBJECT is 
  -- physically required for the continued existence of ?AGENT.
  fun needs  : El CognitiveAgent -> El Physical -> Formula ;

  -- (occupiesPosition ?PERSON ?POSITION ?ORG) 
  -- means that ?PERSON holds the Position ?POSITION at Organization ?ORG. 
  -- For example, (occupiesPosition TomSmith ResearchDirector 
  -- AcmeLaboratory) means that TomSmith is a research director at Acme Labs.
  fun occupiesPosition  : El Human -> El Position -> El Organization -> Formula ;

  -- A general Predicate for indicating how two 
  -- Objects are oriented with respect to one another. For example, 
  -- (orientation ?OBJ1 ?OBJ2 North) means that ?OBJ1 is north of ?OBJ2, and 
  -- (orientation ?OBJ1 ?OBJ2 Vertical) means that ?OBJ1 is positioned 
  -- vertically with respect to ?OBJ2.
  fun orientation  : El Object -> El Object -> El PositionalAttribute -> Formula ;

  -- (origin ?PROCESS ?SOURCE) means that ?SOURCE 
  -- indicates where the ?Process began. Note that this relation implies 
  -- that ?SOURCE is present at the beginning of the process, but need not 
  -- participate throughout the process. For example, the submarine is the 
  -- origin in the following proposition: the missile was launched from a 
  -- submarine.
  fun origin  : El Process -> El Object -> Formula ;

  -- (overlapsPartially ?OBJ1 ?OBJ2) means 
  -- that ?OBJ1 and ?OBJ2 have part(s) in common, but neither ?OBJ1 nor ?OBJ2 
  -- is a part of the other.
  fun overlapsPartially  : El Object -> El Object -> Formula ;

  -- (overlapsSpatially ?OBJ1 ?OBJ2) means 
  -- that the Objects ?OBJ1 and ?OBJ2 have some parts in common. This is a 
  -- reflexive and symmetric (but not transitive) relation.
  fun overlapsSpatially  : El Object -> El Object -> Formula ;

  -- (overlapsTemporally ?INTERVAL1 ?INTERVAL2) 
  -- means that the TimeIntervals ?INTERVAL1 and ?INTERVAL2 
  -- have a TimeInterval as a common part.
  fun overlapsTemporally  : El TimeInterval -> El TimeInterval -> Formula ;

  -- (parallel ?LINE1 ?LINE2) means that the 
  -- OneDimensionalFigures ?LINE1 and ?LINE2 are parallel to one another, 
  -- i.e. they are equidistant from one another at every point.
  fun parallel  : El OneDimensionalFigure -> El OneDimensionalFigure -> Formula ;

  -- The general relationship of parenthood. 
  -- (parent ?CHILD ?PARENT) means that ?PARENT is a biological parent 
  -- of ?CHILD.
  fun parent  : El Organism -> El Organism -> Formula ;
  
  -- A binary predicate is a partial ordering on a set or class
  -- only if the relation is reflexive on the set or class, 
  -- and it is both an antisymmetric relation, and a transitive relation.
  fun partialOrderingOn : (c : Class) -> (El c -> El c -> Formula) -> Formula ;

  -- The basic mereological relation. All other 
  -- mereological relations are defined in terms of this one. 
  -- (part ?PART ?WHOLE) simply means that the Object ?PART is part
  -- of the Object ?WHOLE. Note that, since part is a 
  -- ReflexiveRelation, every Object is a part of itself.
  fun part  : El Object -> El Object -> Formula ;

  -- (partiallyFills ?OBJ ?HOLE) means that ?OBJ completelyFills some part of ?HOLE. 
  -- Note that if (partiallyFills ?OBJ1 ?HOLE) and (part ?OBJ1 ?OBJ2), then (partiallyFills ?OBJ2 ?HOLE). 
  -- Note too that a partial filler need not be wholly inside a hole (it may 
  -- stick out), which means that every complete filler also qualifies as 
  -- (is a limit case of) a partial one.
  fun partiallyFills  : El Physical -> El Object -> Formula ;

  -- A partition of a class C is a set of 
  -- mutually disjoint classes (a subclass partition) which covers C. 
  -- Every instance of C is an instance of exactly one of the subclasses 
  -- in the partition.
  fun partition  : Class -> [Class] -> Formula ;

  -- (partlyLocated ?THING ?OBJ) means that the 
  -- instance of Physical ?THING is at least partially located at ?OBJ. For 
  -- example, Istanbul is partly located in Asia and partly located in Europe. 
  -- Note that partlyLocated is the most basic localization relation: located 
  -- is an immediate subrelation of partlyLocated and exactlyLocated is 
  -- an immediate subrelation of located.
  fun partlyLocated  : El Physical -> El Object -> Formula ;

  -- (path ?MOTION ?PATH) means that ?PATH is a route 
  -- along which ?MOTION occurs. For example, Highway 101 is the path in the 
  -- following proposition: the car drove up Highway 101.
  fun path  : El Motion -> El Object -> Formula ;

  -- A BinaryPredicate that specifies the 
  -- length (in number of GraphNodes) of a GraphPath.
  -- (pathLength ?PATH ?NUMBER) means that there are ?NUMBER nodes in 
  -- the GraphPath ?PATH.
  fun pathLength  : El GraphPath -> El PositiveInteger -> Formula ;

  -- (patient ?PROCESS ?ENTITY) means that ?ENTITY 
  -- is a participant in ?PROCESS that may be moved, said, experienced, etc. 
  -- For example, the direct objects in the sentences 'The cat swallowed the 
  -- canary' and 'Billy likes the beer' would be examples of patients. Note 
  -- that the patient of a Process may or may not undergo structural 
  -- change as a result of the Process. The CaseRole of patient is used 
  -- when one wants to specify as broadly as possible the object of a 
  -- Process.
  fun patient  : El Process -> El Entity -> Formula ;

  -- (penetrates ?OBJ1 ?OBJ2) means that ?OBJ1 is connected to ?OBJ2 along
  -- at least one whole dimension (length, width or depth).
  fun penetrates  : El Object -> El Object -> Formula ;

  -- A specialized common sense notion of part for 
  -- arbitrary parts of Substances. Quasi_synonyms are: chunk, hunk, bit, 
  -- etc. Compare component, another subrelation of part.
  fun piece  : El Substance -> El Substance -> Formula ;

  -- (pointOfFigure ?POINT ?FIGURE) means that 
  -- the GeometricPoint ?POINT is part of the GeometricFigure ?FIGURE.
  fun pointOfFigure  : El GeometricFigure -> El GeometricFigure -> Formula ;

  -- (pointOfIntersection ?FIGURE1 ?FIGURE2 
  -- ?POINT) means that the two straight lines ?FIGURE1 and ?FIGURE2 meet at the 
  -- point ?POINT.
  fun pointOfIntersection  : El OneDimensionalFigure -> El OneDimensionalFigure -> El GeometricPoint -> Formula ;

  -- Relation that holds between an Agent and 
  -- an Object when the Agent has ownership of the Object.
  fun possesses  : El Agent -> El Object -> Formula ;

  -- A very general Predicate. (precondition 
  -- ?PROC1 ?PROC2) means that an instance of ?PROC2 can exist only if an 
  -- instance of ?PROC1 also exists.
  fun precondition : Desc Process -> Desc Process -> Formula ;

  -- (prefers ?AGENT ?FORMULA1 ?FORMULA2) means that 
  -- CognitiveAgent ?AGENT prefers the state of affairs expressed by ?FORMULA1
  -- over the state of affairs expressed by ?FORMULA2 all things being equal.
  fun prefers  : El CognitiveAgent -> Formula -> Formula -> Formula ;

  -- (premise ?ARGUMENT ?PROPOSITION) means that the 
  -- Proposition ?PROPOSITION is an explicit assumption of the Argument 
  -- ?ARGUMENT.
  fun premise  : El Argument -> El Proposition -> Formula ;

  -- A very general Predicate. (prevents ?PROC1 ?PROC2) means that ?PROC1 
  -- prevents the occurrence of ?PROC2. In other words, if ?PROC1 is occurring
  -- in a particular time and place, ?PROC2 cannot occur at the same time and place.
  -- For example, innoculating prevents contracting disease. Note that this is a 
  -- relation between types of Processes, not between instances.
  fun prevents : Desc Process -> Desc Process -> Formula ;

  -- (properPart ?OBJ1 ?OBJ2) means that 
  -- ?OBJ1 is a part of ?OBJ2 other than ?OBJ2 itself. This is a 
  -- TransitiveRelation and AsymmetricRelation (hence an 
  -- IrreflexiveRelation).
  fun properPart  : El Object -> El Object -> Formula ;

  -- (properlyFills ?OBJ ?HOLE) 
  -- means that ?HOLE is properly (though perhaps incompletely) filled by 
  -- ?OBJ, i.e. some part of ?HOLE is perfectly filled by ?OBJ. Note that 
  -- properlyFills is the dual of completelyFills, and is so 
  -- related to partiallyFills that ?OBJ properlyFills ?HOLE just in 
  -- case ?OBJ partiallyFills every part of ?HOLE. (Thus, every perfect 
  -- filler is both complete and proper in this sense). 
  -- Every hole is connected with everything with which a proper filler 
  -- of the hole is connected. Every proper part of a perfect filler of (a part of) a hole properly 
  -- fills (that part of) that hole.
  fun properlyFills  : El Object -> El Hole -> Formula ;

  -- This Predicate holds between an instance of 
  -- Entity and an instance of Attribute. (property ?ENTITY ?ATTR) 
  -- means that ?ENTITY has the Attribute ?ATTR.
  fun property  : El Entity -> El Attribute -> Formula ;

  -- (publishes ?ORG ?TEXT) means that ?ORG 
  -- publishes ?TEXT. For example, Bantam Books publishes Agatha Christie's 
  -- Murder_on_the_Orient_Express.
  fun publishes : El Organization -> Desc Text -> Formula ;

  -- (radius ?CIRCLE ?LENGTH) means that the radius of 
  -- the Circle ?CIRCLE has a length of ?LENGTH.
  fun radius  : El Circle -> El LengthMeasure -> Formula ;

  -- A subrelation of represents. 
  -- (realization ?PROCESS ?PROP) means that ?PROCESS is a Process which 
  -- expresses the content of ?PROP. Examples include a particular musical 
  -- performance, which realizes the content of a musical score, or the 
  -- reading of a poem.
  fun realization  : El Process -> El Proposition -> Formula ;

  -- (refers ?OBJ1 ?OBJ2) means that ?OBJ1 
  -- mentions or includes a reference to ?OBJ2. Note that refers is 
  -- more general in meaning than represents, because presumably something 
  -- can represent something else only if it refers to this other thing. 
  -- For example, an article whose topic is a recent change in the price of 
  -- oil may refer to many other things, e.g. the general state of the economy, 
  -- the weather in California, the prospect of global warming, the options 
  -- for alternative energy sources, the stock prices of various oil companies, 
  -- etc.
  fun refers  : El Entity -> El Entity -> Formula ;
  
  -- A binary predicate is reflexive on a set or class only if
  -- every instance of the set or class bears the relation to itself.
  fun reflexiveOn  : (c : Class) -> (El c -> El c -> Formula) -> Formula ;

  -- (relatedEvent ?EVENT1 ?EVENT2) means 
  -- that the Process ?EVENT1 is related to the Process ?EVENT2. The 
  -- relationship is between separate individual events, not events and 
  -- their subprocesses. On the other hand, two subProcesses of the same 
  -- overarching event may be relatedEvents. The argument order does not 
  -- imply temporal ordering.
  fun relatedEvent  : El Process -> El Process -> Formula ;

  -- Used to signify a three_place 
  -- relation between a concept in an external knowledge source, a concept 
  -- in the SUMO, and the name of the other knowledge source.
  fun relatedExternalConcept  : El SymbolicString -> El Entity -> El Language -> Formula ;

  -- Means that the two arguments are 
  -- related concepts within the SUMO, i.e. there is a significant similarity 
  -- of meaning between them. To indicate a meaning relation between a SUMO 
  -- concept and a concept from another source, use the Predicate 
  -- relatedExternalConcept.
  fun relatedInternalConcept  : El Entity -> El Entity -> Formula ;

  -- (relative ?O1 ?O2) means that ?O1
  -- and ?O2 are relatives, whether through common ancestry (consanguinity),
  -- someone's marriage (affinity), or someone's adoption. This definition is
  -- intentionally broad, so as to capture a wide array of `familial'
  -- relations. The notion of who counts as `family' also varies between
  -- cultures, but that aspect of meaning is not addressed here.
  fun relative  : El Organism -> El Organism -> Formula ;

  -- A very general semiotics Predicate. 
  -- (represents ?THING ?ENTITY) means that ?THING in some way indicates, 
  -- expresses, connotes, pictures, describes, etc. ?ENTITY. The Predicates 
  -- containsInformation and realization are subrelations of represents. 
  -- Note that represents is a subrelation of refers, since something can 
  -- represent something else only if it refers to this other thing. See the 
  -- documentation string for names.
  fun represents  : El Entity -> El Entity -> Formula ;

  -- A very general predicate. 
  -- (representsForAgent ?ENTITY1 ?ENTITY2 ?AGENT) means that the ?AGENT 
  -- chooses to use ?ENTITY1 to 'stand for' ?ENTITY2.
  fun representsForAgent  : El Entity -> El Entity -> El Agent -> Formula ;

  -- A very general predicate. 
  -- (representsInLanguage ?THING ?ENTITY ?LANGUAGE) means that the 
  -- LinguisticExpression ?THING stands for ?ENTITY in the Language 
  -- ?LANGUAGE.
  fun representsInLanguage  : El LinguisticExpression -> El Entity -> El Language -> Formula ;

  fun resourceS  : El Process -> El Entity -> Formula ;

  -- (result ?ACTION ?OUTPUT) means that ?OUTPUT is 
  -- a product of ?ACTION. For example, house is a result in the 
  -- following proposition: Eric built a house.
  fun result  : El Process -> El Entity -> Formula ;

  -- The relationship between two Organisms that 
  -- have the same mother and father. Note that this relationship does 
  -- not hold between half_brothers, half_sisters, etc.
  fun sibling  : El Organism -> El Organism -> Formula ;

  -- (side ?SIDE ?OBJECT) means that ?SIDE is a side of the object, 
  -- as opposed to the top or bottom.
  fun side  : El SelfConnectedObject -> El SelfConnectedObject -> Formula ;

  -- The general relationship of being a sister. 
  -- (sister ?WOMAN ?PERSON) means that ?WOMAN is the sister of ?PERSON.
  fun sister  : El Woman -> El Human -> Formula ;

  -- (smaller ?OBJ1 ?OBJ2) means that ?OBJ1 
  -- is smaller, with respect to all LengthMeasures, than ?OBJ2.
  fun smaller  : El Object -> El Object -> Formula ;

  -- The general relationship of being a son. 
  -- (son ?CHILD ?PARENT) means that ?CHILD is the biological 
  -- son of ?PARENT.
  fun son  : El Organism -> El Organism -> Formula ;

  -- The relationship of marriage between two Humans.
  fun spouse  : El Human -> El Human -> Formula ;

  -- (starts ?INTERVAL1 ?INTERVAL2) means that 
  -- ?INTERVAL1 and ?INTERVAL2 are both TimeIntervals that have the same 
  -- initial TimePoint and that ?INTERVAL1 ends before ?INTERVAL2.
  fun starts  : El TimeInterval -> El TimeInterval -> Formula ;

  -- The relation between a Human and a TemporaryResidence 
  -- of the Human.
  fun stays  : El Human -> El TemporaryResidence -> Formula ;

  -- Means that the second argument can be 
  -- ascribed to everything which has the first argument ascribed to it.
  fun subAttribute  : El Attribute -> El Attribute -> Formula ;

  -- (subCollection ?COLL1 ?COLL2) means that 
  -- the Collection ?COLL1 is a proper part of the Collection ?COLL2.
  fun subCollection  : El Collection -> El Collection -> Formula ;

  -- The relation between two Graphs when one 
  -- Graph is a part of the other. (subGraph ?GRAPH1 ?GRAPH2) means 
  -- that ?GRAPH1 is a part of ?GRAPH2.
  fun subGraph  : El Graph -> El Graph -> Formula ;

  -- (subList ?LIST1 ?LIST2) means that ?LIST1 is a 
  -- sublist of ?LIST2, i.e. every element of ?LIST1 is an element of ?LIST2 and 
  -- the elements that are common to both Lists have the same order in both 
  -- Lists. Elements that are common to both Lists and are consecutive in one 
  -- list must also be consecutive in the other list. (Therefore _ the list of 
  -- prime numbers smaller than 10 [1 2 3 5 7] is not a subList of the 
  -- natural numbers smaller than 10 [1 2 3 4 5 6 7 8 9]).
  fun subList  : El List -> El List -> Formula ;

  -- (subOrganization ?ORG1 ?ORG2) means 
  -- that ?ORG1 is an Organization which is a part of the Organization 
  -- ?ORG2. Note that subOrganization is a ReflexiveRelation, so every 
  -- Organization is a subOrganization of itself.
  fun subOrganization  : El Organization -> El Organization -> Formula ;

  -- (subPlan ?PLAN1 ?PLAN2) means that ?PLAN1 
  -- is a Plan which is a proper part of ?PLAN2. This relation is generally 
  -- used to relate a supporting Plan to the overall Plan in a particular 
  -- context.
  fun subPlan  : El Plan -> El Plan -> Formula ;

  -- (subProcess ?SUBPROC ?PROC) means that ?SUBPROC 
  -- is a subprocess of ?PROC. A subprocess is here understood as a temporally 
  -- distinguished part (proper or not) of a Process.
  fun subProcess  : El Process -> El Process -> Formula ;

  -- (subProposition ?PROP1 ?PROP2) means that 
  -- ?PROP1 is a Proposition which is a proper part of the Proposition ?PROP2. 
  -- In other words, subProposition is the analogue of properPart for chunks 
  -- of abstract content.
  fun subProposition  : El Proposition -> El Proposition -> Formula ;

  -- (subSystem ?SUB ?SYSTEM) means that the 
  -- PhysicalSystem ?SUB is a part of the PhysicalSystem ?SYSTEM.
  fun subSystem  : El PhysicalSystem -> El PhysicalSystem -> Formula ;

  -- (subclass ?CLASS1 ?CLASS2) means that ?CLASS1 is 
  -- a subclass of ?CLASS2, i.e. every instance of ?CLASS1 is also an instance of 
  -- ?CLASS2. A class may have multiple superclasses and subclasses.
  fun subclass  : El SetOrClass -> El SetOrClass -> Formula ;

  -- (subset ?SET1 ?SET2) is true just in case the 
  -- elements of the Set ?SET1 are also elements of the Set ?SET2.
  fun subset  : El Set -> El Set -> Formula ;

  -- (subsumedExternalConcept 
  -- ?STRING ?THING ?LANGUAGE) means that the SUMO concept ?THING is subsumed 
  -- by the meaning of ?STRING in ?LANGUAGE, i.e. the concept ?THING is narrower 
  -- in meaning than ?STRING.
  fun subsumedExternalConcept  : El SymbolicString -> El Entity -> El Language -> Formula ;

  -- A BinaryPredicate that relates two 
  -- subclasses of ContentBearingObject. (subsumesContentClass ?CLASS1 
  -- ?CLASS2) means that the content expressed by each instance of ?CLASS2 is 
  -- also expressed by each instance of ?CLASS1. Examples include the 
  -- relationship between a poem and one of its stanzas or between a book and 
  -- one of its chapters. Note that this is a relation between subclasses of 
  -- ContentBearingObject, rather than instances. If one wants to relate 
  -- instances, the Predicate subsumesContentInstance can be used. Note 
  -- that subsumesContentClass is needed in many cases. Consider, for 
  -- example, the relation between the King James edition of the Bible and its 
  -- Book of Genesis. This relation holds for every copy of this edition and 
  -- not just for a single instance.
  fun subsumesContentClass : Desc ContentBearingObject -> Desc ContentBearingObject -> Formula ;

  -- A BinaryPredicate relating two 
  -- instances of ContentBearingObject. (subsumesContentInstance ?OBJ1 ?OBJ2) 
  -- means that the content expressed by ?OBJ2 is part of the content expressed 
  -- by ?OBJ1. An example is the relationship between a handwritten poem and 
  -- one of its stanzas. Note that this is a relation between instances, 
  -- rather than Classes. If one wants to assert a content relationship 
  -- between Classes, e.g. between the version of an intellectual work and a 
  -- part of that work, the relation subsumesContentClass should be used.
  fun subsumesContentInstance  : El ContentBearingObject -> El ContentBearingObject -> Formula ;

  -- (subsumingExternalConcept 
  -- ?STRING ?THING ?LANGUAGE) means that the SUMO concept ?THING subsumes 
  -- the meaning of ?STRING in ?LANGUAGE, i.e. the concept ?THING is broader 
  -- in meaning than ?STRING.
  fun subsumingExternalConcept  : El SymbolicString -> El Entity -> El Language -> Formula ;

  -- (successorAttribute ?ATTR1 ?ATTR2) 
  -- means that ?ATTR2 is the Attribute that comes immediately after ?ATTR1 
  -- on the scale that they share.
  fun successorAttribute  : El Attribute -> El Attribute -> Formula ;

  -- The transitive closure of 
  -- successorAttribute. (successorAttributeClosure ?ATTR1 ?ATTR2) means 
  -- that there is a chain of successorAttribute assertions connecting 
  -- ?ATTR1 and ?ATTR2.
  fun successorAttributeClosure  : El Attribute -> El Attribute -> Formula ;

  -- (superficialPart ?OBJ1 ?OBJ2) 
  -- means that ?OBJ1 is a part of ?OBJ2 that has no interior parts of its own 
  -- (or, intuitively, that only overlaps those parts of ?OBJ2 that are 
  -- externally connected with the mereological complement of ?OBJ2). This too 
  -- is a transitive relation closed under MereologicalSumFn and 
  -- MereologicalProductFn.
  fun superficialPart  : El Object -> El Object -> Formula ;

  -- (surface ?OBJ1 ?OBJ2) means that ?OBJ1 
  -- is a maximally connected superficialPart of ?OBJ2. Note that some 
  -- SelfConnectedObjects have more than one surface, e.g. a hollow 
  -- object like a tennis ball has both an inner and an outer surface.
  fun surface  : El SelfConnectedObject -> El SelfConnectedObject -> Formula ;

  -- (synonymousExternalConcept 
  -- ?STRING ?THING ?LANGUAGE) means that the SUMO concept ?THING has the 
  -- same meaning as ?STRING in ?LANGUAGE.
  fun synonymousExternalConcept  : El SymbolicString -> El Entity -> El Language -> Formula ;

  -- (systemPart ?PART ?SYSTEM) means that 
  -- the Physical thing ?PART is a SystemElement in the PhysicalSystem 
  -- ?SYSTEM.
  fun systemPart  : El Physical -> El PhysicalSystem -> Formula ;

  -- The temporal analogue of the spatial part 
  -- predicate. (temporalPart ?POS1 ?POS2) means that TimePosition ?POS1 
  -- is part of TimePosition ?POS2. Note that since temporalPart is a 
  -- ReflexiveRelation every TimePostion is a temporalPart of itself.
  fun temporalPart  : El TimePosition -> El TimePosition -> Formula ;

  -- (temporallyBetween ?POINT1 ?POINT2 
  -- ?POINT3) means that the TimePoint ?POINT2 is between the TimePoints 
  -- ?POINT1 and ?POINT3, i.e. ?POINT1 is before ?POINT2 and ?POINT2 is before 
  -- ?POINT3.
  fun temporallyBetween  : El TimePoint -> El TimePoint -> El TimePoint -> Formula ;

  -- (temporallyBetweenOrEqual ?POINT1 ?POINT2 
  -- ?POINT3) means that the TimePoint ?POINT1 is before or equal to the 
  -- TimePoint ?POINT2 and ?POINT2 is before or equal to the TimePoint 
  -- ?POINT3.
  fun temporallyBetweenOrEqual  : El TimePoint -> El TimePoint -> El TimePoint -> Formula ;

  -- This relation holds between an instance of 
  -- Physical and an instance of TimePosition just in case the temporal 
  -- lifespan of the former includes the latter. In other words, (time
  -- ?THING ?TIME) means that ?THING existed or occurred at ?TIME. Note 
  -- that time does for instances of Physical what holdsDuring does 
  -- for instances of Formula. The constants located and time are 
  -- the basic spatial and temporal predicates, respectively.
  fun time  : El Physical -> El TimePosition -> Formula ;
  
  fun totalOrderingOn : (c : Class) -> (El c -> El c -> Formula) -> Formula ;

  -- (top ?TOP ?OBJECT) means that ?TOP is the highest maximal 
  -- superficial part of ?OBJECT.
  fun top  : El SelfConnectedObject -> El SelfConnectedObject -> Formula ;

  -- (transactionAmount ?TRANSACTION 
  -- ?AMOUNT) means that ?AMOUNT is an instance of CurrencyMeasure being 
  -- exhanged in the FinancialTransaction ?TRANSACTION.
  fun transactionAmount  : El FinancialTransaction -> El CurrencyMeasure -> Formula ;

  -- (traverses ?OBJ1 ?OBJ2) means that ?OBJ1 
  -- crosses or extends across ?OBJ2. Note that crosses and 
  -- penetrates are subrelations of traverses.
  fun traverses  : El Object -> El Object -> Formula ;

  -- The BinaryPredicate that relates a Sentence 
  -- to its TruthValue.
  fun truth  : El Sentence -> El TruthValue -> Formula ;

  -- The class of names that uniquely identify 
  -- an instance of Entity. Some examples of uniqueIdentifiers are the keys 
  -- of tables in database applications and
  -- the ISBN (International Standard Book Number).
  fun uniqueIdentifier  : El SymbolicString -> El Entity -> Formula ;

  -- (uses ?OBJECT AGENT) means that ?OBJECT is used by 
  -- ?AGENT as an instrument in an unspecified Process. This Predicate, 
  -- as its corresponding axiom indicates, is a composition of the CaseRoles 
  -- agent and instrument.
  fun uses  : El Object -> El Agent -> Formula ;

  -- Some Artifacts have a life cycle with discrete 
  -- stages or versions. (version ARTIFACT1 ARTIFACT2) means that ARTIFACT1 
  -- is a version of ARTIFACT2. Note that this Predicate relates subclasses of 
  -- Artifact and not instances.
  fun version : Desc Artifact -> Desc Artifact -> Formula ;

  -- (wants ?AGENT ?OBJECT) means that ?OBJECT is desired by ?AGENT, 
  -- i.e. ?AGENT believes that ?OBJECT will satisfy one of its goals. Note that there is 
  -- no implication that what is wanted by an agent is not already possessed by the agent.
  fun wants  : El CognitiveAgent -> El Physical -> Formula ;

  -- (wears ?AGENT ?CLOTHING) means that ?AGENT is wearing 
  -- the item of Clothing ?CLOTHING.
  fun wears  : El Animal -> El Clothing -> Formula ;

  -- (weight ?O ?MM) means that on planet earth
  -- the SelfConnectedObject ?O has the weight ?MM.
  fun weight  : El SelfConnectedObject -> El MassMeasure -> Formula ;

  -- binary predicate that is used to state the measure 
  -- of an Object from side to side at its widest span.
  fun width  : El Object -> El PhysicalQuantity -> Formula ;

  -- (wife ?WOMAN ?MAN) means that ?WOMAN is the wife of ?MAN.
  fun wife  : El Woman -> El Man -> Formula ;


  -- relations
  fun SingleValuedRelation : (c : Class) -> (El c -> Formula) -> Formula;
  def SingleValuedRelation c f = 
          forall c (\x -> forall c (\y -> impl (and (f (var c c ? x)) (f (var c c ? y)))
                                               (equal (var c Entity ? x) (var c Entity ? y))));

  fun AntisymmetricRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
  def AntisymmetricRelation c f = 
          forall c (\x -> forall c (\y -> impl (and (f (var c c ? x) (var c c ? y))
                                                    (f (var c c ? y) (var c c ? x)))
                                               (equal (var c Entity ? x) (var c Entity ? y)))) ;

  fun IntentionalRelation : (c1,c2 : Class) -> (El c1 -> El c2 -> Formula) -> Formula ;
  def IntentionalRelation c1 c2 f = 
          -- assume binary predicate, since it is mostly used for that
          forall c1 (\x -> forall c2 (\y -> inScopeOfInterest (var c1 CognitiveAgent ? x) (var c2 Entity ? y)));
        

  fun ReflexiveRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
  def ReflexiveRelation c f = 
          forall c (\x -> f (var c c ? x) (var c c ? x));

  fun SymmetricRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
  def SymmetricRelation c f = 
          forall c (\x -> forall c (\y -> impl (f (var c c ? x) (var c c ? y))
                                               (f (var c c ? y) (var c c ? x))));

  fun EquivalenceRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
  def EquivalenceRelation c f = 
          and (and (ReflexiveRelation c f)
                   (SymmetricRelation c f))
              (TransitiveRelation c f);

  fun TransitiveRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
  def TransitiveRelation c f = 
          forall c (\x -> forall c (\y -> forall c (\z -> impl (and (f (var c c ? x) (var c c ? y)) 
                                                                    (f (var c c ? y) (var c c ? z)))
                                                               (f (var c c ? x) (var c c ? z)))));

  fun IrreflexiveRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
  def IrreflexiveRelation c f = 
          forall c (\x -> not (f (var c c ? x) (var c c ? x))) ;

  fun AsymmetricRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
  def AsymmetricRelation c f = 
          and (AntisymmetricRelation c f) (IrreflexiveRelation c f);

  fun PropositionalAttitude : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
  def PropositionalAttitude c f = 
          AsymmetricRelation c f;

  fun ObjectAttitude : (c1,c2 : Class) -> (El c1 -> El c2 -> Formula) -> Formula ;
  def ObjectAttitude c1 c2 f = 
          IntentionalRelation c1 c2 f ;

  fun IntransitiveRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
  def IntransitiveRelation c f = 
          forall c (\x -> forall c (\y -> forall c (\z -> impl (and (f (var c c ? x) (var c c ? y)) 
                                                                    (f (var c c ? y) (var c c ? z)))
                                                               (not (f (var c c ? x) (var c c ? z)))))) ;

  fun PartialOrderingRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
  def PartialOrderingRelation c f = 
          and (and (TransitiveRelation c f)
                   (AntisymmetricRelation c f))
              (ReflexiveRelation c f) ;

  fun TrichotomizingRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
  def TrichotomizingRelation c f = 
          forall c (\x -> forall c (\y -> or (or (and (and (f (var c c ? x) (var c c ? y))
                                                           (not (equal (var c Entity ? x) (var c Entity ? y))))
                                                      (not (f (var c c ? y) (var c c ? x))))
                                                 (and (and (not (f (var c c ? x) (var c c ? y)))
                                                           (equal (var c Entity ? x) (var c Entity ? y)))
                                                      (not (f (var c c ? y) (var c c ? x)))))
                                             (and (and (f (var c c ? y) (var c c ? x))
                                                       (not (equal (var c Entity ? x) (var c Entity ? y))))
                                                  (not (f (var c c ? x) (var c c ? y))))));

  fun TotalOrderingRelation : (c : Class) -> (El c -> El c -> Formula) -> Formula ;
  def TotalOrderingRelation c f = 
            and (PartialOrderingRelation c f) (TrichotomizingRelation c f) ;

  fun OneToOneFunction : (c1, c2 : Class) -> (El c1 -> Ind c2) -> Formula ;
  def OneToOneFunction c1 c2 f = forall c1(\x -> 
            forall c1 (\y -> impl (not (equal (var c1 Entity ? x) (var c1 Entity ? y))) 
                                  (not (equal (el c2 Entity ? (f (var c1 c1 ? x)))
                                              (el c2 Entity ? (f (var c1 c1 ? y)))))));

  fun SequenceFunction : (c : Class) -> (El Integer -> Ind c) -> Formula ;
  def SequenceFunction c f = 
            OneToOneFunction Integer c f ;

  fun AssociativeFunction : (c : Class) -> (El c -> El c -> Ind c) -> Formula ;
  def AssociativeFunction c f = 
            forall c (\x -> forall c (\y -> forall c (\z -> equal (el c Entity ? (f (var c c ? x) (el c c ? (f (var c c ? y) (var c c ? z))))) 
                                                                  (el c Entity ? (f (el c c ? (f (var c c ? x) (var c c ? y))) (var c c ? z))))));

  fun CommutativeFunction : (c1,c2 : Class) -> (El c1 -> El c1 -> Ind c2) -> Formula ;
  def CommutativeFunction c1 c2 f = 
            forall c1 (\x -> forall c1 (\y -> equal (el c2 Entity ? (f (var c1 c1 ? x) (var c1 c1 ? y)))
                                                    (el c2 Entity ? (f (var c1 c1 ? y) (var c1 c1 ? y)))));

  fun identityElement : (c : Class) -> (El c -> El c -> Ind c) -> El c -> Formula ;
  def identityElement c f elem = 
            forall c (\x -> equal (el c Entity ? (f (var c c ? x) elem)) (var c Entity ? x));

  fun distributes : (c : Class) -> (El c -> El c -> Ind c) -> (El c -> El c -> Ind c) -> Formula ;
  def distributes c f g = 
            forall c (\x -> forall c (\y -> forall c (\z -> equal (el c Entity ? (g (el c c ? (f (var c c ? x) (var c c ? y))) (var c c ? z)))
                                                                  (el c Entity ? (f (el c c ? (g (var c c ? x) (var c c ? z))) (el c c ? (g (var c c ? y) (var c c ? z))))))));
 
  fun inverse : (c : Class) -> (El c -> El c -> Formula) -> (El c -> El c -> Formula) -> Formula ;
  def inverse c f g = 
            forall c (\x -> forall c (\y -> equiv (f (var c c ? x) (var c c ? y))
                                                  (g (var c c ? y) (var c c ? x))));                                     

  fun subRelation2El : (c1,c2,c3,c4 : Class) -> (El c1 -> El c2 -> Formula) -> (El c3 -> El c4 -> Formula) -> Formula ;
  def subRelation2El c1 c2 c3 c4 f g = 
            forall c1 (\x -> forall c2 (\y -> impl (f (var c1 c1 ? x) (var c2 c2 ? y))
                                                   (g (var c1 c3 ? x) (var c2 c4 ? y))));


  --others
  fun toInt : Int -> Ind Integer ;
  fun toRealNum : Float -> Ind RealNumber ;

}
