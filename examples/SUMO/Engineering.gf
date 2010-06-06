abstract Engineering = MidLevelOntology ** {

  --  A PureTwopole that accumulates across variable.
  fun AcrossVariableAccumulator : Class ;
  fun AcrossVariableAccumulator_Class : SubClass AcrossVariableAccumulator PureTwopole ;

  -- A Source that models a generator of across variable.
  fun AcrossVariableSource : Class ;
  fun AcrossVariableSource_Class : SubClass AcrossVariableSource Source ;

  -- algebraic equation or set of equations
  fun AlgebraicAttribute : Ind EquationAttribute ;

  -- An Equation that is not
  -- a DifferentialEquation
  fun AlgebraicEquation : Class ;
  fun AlgebraicEquation_Class : SubClass AlgebraicEquation Equation ;

  -- Set of both differential and algebraic equations
  fun AlgebroDifferentialAttribute : Ind InternalAttribute ;

  -- Electronic equipment that increases strength of
  -- signals passing through it, it can be modeled using a controlled
  -- source, or an operational amplifier.
  fun Amplifier : Class ;
  fun Amplifier_Class : SubClass Amplifier ElectricalCircuit ;

  -- PhysicalDimension of angular velocity, [s^_1].
  fun AngularVelocity : Ind PhysicalDimension ;

  -- set of application domains (medicine, physics, etc)
  fun ApplicationDomain : Class ;
  fun ApplicationDomain_Class : SubClass ApplicationDomain InternalAttribute ;

  -- article
  fun ArticleCategory : Ind DocumentCategory ;

  -- astronomy
  fun AstronomyDomain : Class ;
  fun AstronomyDomain_Class : SubClass AstronomyDomain PhysicsDomain ;

  -- For given class and for given attribute, return
  -- a subclass of the class of object having the attribute
  fun AttrFn : Class -> El Attribute -> Class ;

  -- autonomous
  fun Autonomous : Class ;
  fun Autonomous_Class : SubClass Autonomous InternalAttribute ;

  -- With no backlash.
  fun Backlashless : Class ;
  fun Backlashless_Class : SubClass Backlashless InternalAttribute ;

  -- the part of a transistor that separates the emitter 
  -- from the collector
  fun Base : Class ;
  fun Base_Class : SubClass Base Terminal ;

  -- Battery is a subclass of Device. Batteries are 
  -- devices that use chemical means to store or produce electrical power.
  fun Battery : Class ;
  fun Battery_Class : SubClass Battery (both ElectricDevice DCPowerSource) ;

  -- Bessel's equation
  fun BesselsEquation : Class ;
  fun BesselsEquation_Class : SubClass BesselsEquation (both NonlinearEquation OrdinaryDifferentialEquation) ;

  -- Bipolar transistor
  fun BjtTransistor : Class ;
  fun BjtTransistor_Class : SubClass BjtTransistor Transistor ;

  -- A SinglePhaseRectifier of
  -- that exploits both polarities of the input power source.
  fun BridgeSinglePhaseRectifier : Class ;
  fun BridgeSinglePhaseRectifier_Class : SubClass BridgeSinglePhaseRectifier SinglePhaseRectifier ;

  -- With no brushes (of electrical motors)
  fun Brushless : Class ;
  fun Brushless_Class : SubClass Brushless InternalAttribute ;

  -- An ElectricalComponent characterized by its
  -- capacitance.
  fun Capacitor : Class ;
  fun Capacitor_Class : SubClass Capacitor ElectricalComponent ;

  -- An AcrossVariableAccumulator from electrical energy domain.
  fun CapacitorElement : Class ;
  fun CapacitorElement_Class : SubClass CapacitorElement ElectricDevice ;

  -- 4_wheeled motor vehicle, usually propelled by
  -- an internal combustion engine
  fun Car : Class ;
  fun Car_Class : SubClass Car Vehicle ;

  -- circuit theory
  fun CircuitTheoryDomain : Class ;
  fun CircuitTheoryDomain_Class : SubClass CircuitTheoryDomain (both ElectricalEngineeringDomain PhysicsDomain) ;

  -- the electrode in a transistor through which a 
  -- primary flow of carriers leaves the inter_electrode region
  fun Collector : Class ;
  fun Collector_Class : SubClass Collector Terminal ;

  -- The ability of material to stretch or bend.
  fun Compliance : Ind PhysicalAttribute ;

  -- A collection of bytes stored as an 
  -- individual entity. All data on disk is stored as a file with an 
  -- assigned file name that is unique within the folder (directory) 
  -- it resides in. ComputerFile file systems contain only files and folders
  fun ComputerFile : Class ;
  fun ComputerFile_Class : SubClass ComputerFile ContentBearingObject ;

  fun ComputerProgram_ITAgent : SubClass ComputerProgram ITAgent ;

  -- the ability of a material to lead current
  fun Conductivity : Ind PhysicalAttribute ;

  -- A Substance that readily conducts
  -- electricity.
  fun ConductorSubstance : Class ;
  fun ConductorSubstance_Class : SubClass ConductorSubstance Substance ;

  -- A class of control design method
  fun ControlDesignMethod : Class ;
  fun ControlDesignMethod_Class : SubClass ControlDesignMethod Method ;

  -- control
  fun ControlDomain : Class ;
  fun ControlDomain_Class : SubClass ControlDomain EngineeringDomain ;

  -- a mechanism that controls the operation of some
  -- device
  fun Controller : Class ;
  fun Controller_Class : SubClass Controller UnknownDomainDevice ;

  -- PhysicalDimension of electrical current, [A].
  fun Current : Ind PhysicalDimension ;

  -- A direct_current PowerSource.
  fun DCPowerSource : Class ;
  fun DCPowerSource_Class : SubClass DCPowerSource PowerSource ;

  -- A Dissipator from translatory energy domain.
  fun DamperElement : Class ;
  fun DamperElement_Class : SubClass DamperElement (both Dissipator TranslatoryTwopole) ;

  -- A direct_current electrical motor.
  fun DcMotor : Class ;
  fun DcMotor_Class : SubClass DcMotor ElectricalMotor ;

  -- differential equation or set of equations
  fun DifferentialAttribute : Ind EquationAttribute ;

  -- An Equation containing differentials
  -- of a function
  fun DifferentialEquation : Class ;
  fun DifferentialEquation_Class : SubClass DifferentialEquation Equation ;

  -- Dimensionless PhysicalDimension.
  fun Dimensionless : Ind PhysicalDimension ;

  -- A semiconductor device that consists of a p_n
  -- junction, it is used e.g. in rectifiers or demodulators.
  fun Diode : Class ;
  fun Diode_Class : SubClass Diode SemiconductorComponent ;

  -- Valve that controls the direction
  -- of flow of a fluid
  fun DirectionalControlValve : Class ;
  fun DirectionalControlValve_Class : SubClass DirectionalControlValve Valve ;

  -- A method of converting continuous problem
  -- to a discrete one, loaded by some discretization error.
  fun Discretization : Class ;
  fun Discretization_Class : SubClass Discretization MathematicalMethod ;

  -- A PureTwopole that models a dissipation of energy.
  fun Dissipator : Class ;
  fun Dissipator_Class : SubClass Dissipator PureTwopole ;

  -- document category
  fun DocumentCategory : Class ;
  fun DocumentCategory_Class : SubClass DocumentCategory WebDocumentAttribute ;

  -- A SinglePhaseRectifier of
  -- that exploits both polarities of the input power source.
  fun DoublerSinglePhaseRectifier : Class ;
  fun DoublerSinglePhaseRectifier_Class : SubClass DoublerSinglePhaseRectifier SinglePhaseRectifier ;

  -- Asserts that the constitutive relation of
  -- a multipole does depend on time.
  fun DynamicMultipole : Ind MultipoleAttribute ;

  -- Electrical energetic interaction
  fun Electrical : Ind PhysicalDomain ;

  -- A complex ElectricDevice consisting
  -- of several mutually interconnected electrical components.
  fun ElectricalCircuit : Class ;
  fun ElectricalCircuit_Class : SubClass ElectricalCircuit ElectricDevice ;

  -- A discrete ElectricDevice for
  -- general usage, such as resistors, capacitors, diodes, transistors etc.
  fun ElectricalComponent : Class ;
  fun ElectricalComponent_Class : SubClass ElectricalComponent ElectricDevice ;

  -- An ElectricalComponent designed to
  -- transmit electricity
  fun ElectricalConductor : Class ;
  fun ElectricalConductor_Class : SubClass ElectricalConductor ElectricalComponent ;

  -- electrical drives (motors)
  fun ElectricalDrivesDomain : Class ;
  fun ElectricalDrivesDomain_Class : SubClass ElectricalDrivesDomain ElectroMechanicalDevicesDomain ;

  -- domain involving electrical engineering
  fun ElectricalEngineeringDomain : Class ;
  fun ElectricalEngineeringDomain_Class : SubClass ElectricalEngineeringDomain EngineeringDomain ;

  -- A Method used in electrical
  -- engineering for designing and constructing electrical devices.
  fun ElectricalEngineeringMethod : Class ;
  fun ElectricalEngineeringMethod_Class : SubClass ElectricalEngineeringMethod Method ;

  -- An electrical motor.
  fun ElectricalMotor : Class ;
  fun ElectricalMotor_Class : SubClass ElectricalMotor (both ElectricDevice Motor) ;

  -- A MultipoleModel containing only
  -- electrical multipoles.
  fun ElectricalMultipoleModel : Class ;
  fun ElectricalMultipoleModel_Class : SubClass ElectricalMultipoleModel MultipoleModel ;

  -- A Process in which electrical
  -- interactions take place
  fun ElectricalProcess : Class ;
  fun ElectricalProcess_Class : SubClass ElectricalProcess NaturalProcess ;

  -- a resonance of electrical energy.
  fun ElectricalResonance : Class ;
  fun ElectricalResonance_Class : SubClass ElectricalResonance (both ElectricalProcess Resonance) ;

  -- A PureTwopole from electrical energy domain.
  fun ElectricalTwopole : Class ;
  fun ElectricalTwopole_Class : SubClass ElectricalTwopole PureTwopole ;

  -- electrical drives (motors)
  fun ElectroMechanicalDevicesDomain : Class ;
  fun ElectroMechanicalDevicesDomain_Class : SubClass ElectroMechanicalDevicesDomain (both ElectricalEngineeringDomain MechanicalEngineeringDomain) ;

  -- electronic circuits _ electrical circuits 
  -- containing complex semiconductor components
  fun ElectronicsDomain : Class ;
  fun ElectronicsDomain_Class : SubClass ElectronicsDomain ElectricalEngineeringDomain ;

  -- the electrode in a transistor where electrons originate
  fun Emitter : Class ;
  fun Emitter_Class : SubClass Emitter Terminal ;

  -- engineering (mechanical, electrical)
  fun EngineeringDomain : Class ;
  fun EngineeringDomain_Class : SubClass EngineeringDomain ScienceDomain ;

  -- a process of designing, manufacturing and
  -- operating of an engineering system involving all stages of the life cycle.
  fun EngineersProcess : Class ;
  fun EngineersProcess_Class : SubClass EngineersProcess EngineersSubprocess ;

  -- a class of subprocesses that are needed to
  -- design and operate an engineering system
  fun EngineersSubprocess : Class ;
  fun EngineersSubprocess_Class : SubClass EngineersSubprocess IntentionalProcess ;

  -- a mathematical statement that two expressions are equal.
  fun Equation : Class ;
  fun Equation_Class : SubClass Equation Proposition ;

  -- an attribute that applies to an equation
  -- or to a set of equations
  fun EquationAttribute : Class ;
  fun EquationAttribute_Class : SubClass EquationAttribute InternalAttribute ;

  -- Field_effect transistor.
  fun FetTransistor : Class ;
  fun FetTransistor_Class : SubClass FetTransistor Transistor ;

  -- file system
  fun FileSystem : Class ;
  fun FileSystem_Class : SubClass FileSystem Group ;

  -- A DifferentialEquation
  -- where variables are differentiated only once.
  fun FirstOrderDifferentialEquation : Class ;
  fun FirstOrderDifferentialEquation_Class : SubClass FirstOrderDifferentialEquation DifferentialEquation ;

  -- A FluidPowerDevice designed to transform
  -- fluid_power energy into mechanical translatory energy.
  fun FluidCylinder : Class ;
  fun FluidCylinder_Class : SubClass FluidCylinder (both FluidPowerDevice MechanicalDevice) ;

  -- Fluid power energetic interaction
  fun FluidPower : Ind PhysicalDomain ;

  -- An EngineeringComponent in function of
  -- which play role fluid_power energetical interactions.
  fun FluidPowerDevice : Class ;
  fun FluidPowerDevice_Class : SubClass FluidPowerDevice EngineeringComponent ;

  -- fluid power (hydraulic) systems
  fun FluidPowerDomain : Class ;
  fun FluidPowerDomain_Class : SubClass FluidPowerDomain MechanicalEngineeringDomain ;

  -- PhysicalDimension of force, [N].
  fun Force : Ind PhysicalDimension ;

  -- Computing a Fourier series for given
  -- periodic function
  fun FourierAnalysis : Class ;
  fun FourierAnalysis_Class : SubClass FourierAnalysis MathematicalMethod ;

  -- Reconstruction of a periodic function
  -- from its Fourier series representation.
  fun FourierSynthesis : Class ;
  fun FourierSynthesis_Class : SubClass FourierSynthesis MathematicalMethod ;

  -- A Multipole with exactly four poles.
  fun Fourpole : Class ;
  fun Fourpole_Class : SubClass Fourpole Multipole ;

  -- Alters the frequency spectrum of signals
  -- passing through it
  fun FrequencyFilter : Class ;
  fun FrequencyFilter_Class : SubClass FrequencyFilter ElectricalCircuit ;

  -- A MechanicalProcess in which mechanical
  -- energy is converted into a heat
  fun Friction : Class ;
  fun Friction_Class : SubClass Friction MechanicalProcess ;

  -- a toothed wheel that engages another toothed
  -- mechanism in order to change the speed or direction of transmitted motion.
  fun Gear : Class ;
  fun Gear_Class : SubClass Gear MechanicalDevice ;

  -- a pair of gears that are used to change speed or
  -- direction of an angular motion, ideal gear train can be modeled using
  -- a transformer.
  fun GearTrain : Class ;
  fun GearTrain_Class : SubClass GearTrain MechanicalDevice ;

  -- A device composed of several gear_trains used
  -- to change speed and torque of transmitted motion.
  fun Gearbox : Class ;
  fun Gearbox_Class : SubClass Gearbox MechanicalDevice ;

  -- A Transducer for which the ratio of
  -- across variable on one side and through variable on the
  -- other side is equal to the ratio of the remaining two variables.
  fun Gyrator : Class ;
  fun Gyrator_Class : SubClass Gyrator Transducer ;

  -- A SinglePhaseRectifier of
  -- that exploits only one polarity of the input power source.
  fun HalfWaveSinglePhaseRectifier : Class ;
  fun HalfWaveSinglePhaseRectifier_Class : SubClass HalfWaveSinglePhaseRectifier SinglePhaseRectifier ;

  -- A DifferentialEquation
  -- where variables are differentiated more than once.
  fun HigherOrderDifferentialEquation : Class ;
  fun HigherOrderDifferentialEquation_Class : SubClass HigherOrderDifferentialEquation DifferentialEquation ;

  fun Human_ITAgent : SubClass Human ITAgent ;

  -- agent capable of performing ITProcess
  fun ITAgent : Class ;
  fun ITAgent_Class : SubClass ITAgent Agent ;

  -- A process performed on a computer by a human
  -- operator.
  fun ITProcess : Class ;
  fun ITProcess_Class : SubClass ITProcess IntentionalProcess ;

  -- A Fourpole modeling an
  -- OperationalAmplifier with ideal properties.
  fun IdealOperationalAmplifier : Class ;
  fun IdealOperationalAmplifier_Class : SubClass IdealOperationalAmplifier Fourpole ;

  -- A PureTwopole that models an ideal switch.
  fun IdealSwitch : Class ;
  fun IdealSwitch_Class : SubClass IdealSwitch PureTwopole ;

  -- A PureTwopole that is linear.
  fun IdealTwopole : Class ;
  fun IdealTwopole_Class : SubClass IdealTwopole PureTwopole ;

  -- Asserts that a constitutive relation of a multipole 
  -- does not refer to other variables than terminal or inner.
  fun IndependentMultipole : Ind MultipoleAttribute ;

  -- A property of an electric circuit by which an
  -- electromotive force is induced in it by a variation of current.
  fun Inductance : Class ; --  subattribute PhysicalAttribute

  -- An electrical motor powered by a three_phase power suply.
  fun InductionMotor : Class ;
  fun InductionMotor_Class : SubClass InductionMotor ElectricalMotor ;

  -- An ElectricalComponent that introduces inductance into a circuit.
  fun Inductor : Class ;
  fun Inductor_Class : SubClass Inductor ElectricalComponent ;

  -- A ThroughVariableAccumulator from electrical energy domain.
  fun InductorElement : Class ;
  fun InductorElement_Class : SubClass InductorElement ElectricDevice ;

  -- An AcrossVariableAccumulator from translatory energy domain.
  fun Inertor : Class ;
  fun Inertor_Class : SubClass Inertor (both AcrossVariableAccumulator TranslatoryTwopole) ;

  -- The process of deploying an application
  -- on a computer.
  fun Installation : Class ;
  fun Installation_Class : SubClass Installation ITProcess ;

  -- a Substance such as glass or
  -- porcelain with negligible electrical conductivity.
  fun InsulatorSubstance : Class ;
  fun InsulatorSubstance_Class : SubClass InsulatorSubstance Substance ;

  -- An Amplifier that changes the polarity of the input signal.
  fun InvertingAmplifier : Class ;
  fun InvertingAmplifier_Class : SubClass InvertingAmplifier Amplifier ;

  -- Junction field_effect transistor.
  fun JfetTransistor : Class ;
  fun JfetTransistor_Class : SubClass JfetTransistor FetTransistor ;

  -- light emitted at a p_n junction is proportional 
  -- to the bias current, color depends on the material used
  fun LED : Class ;
  fun LED_Class : SubClass LED Diode ;

  -- PhysicalDimension of length, [m].
  fun Length : Ind PhysicalDimension ;

  -- adjective
  fun LexAdjective : Ind LexiconCategory ;

  -- adverb
  fun LexAdverb : Ind LexiconCategory ;

  -- noun
  fun LexNoun : Ind LexiconCategory ;

  -- verb
  fun LexVerb : Ind LexiconCategory ;

  -- WordNet category: noun, verb, adjective or adverb
  fun LexiconCategory : Class ;
  fun LexiconCategory_Class : SubClass LexiconCategory InternalAttribute ;

  -- library model
  fun LibraryModelCategory : Ind DocumentCategory ;

  -- A polynomial Equation of the first degree.
  fun LinearEquation : Class ;
  fun LinearEquation_Class : SubClass LinearEquation Equation ;

  -- Asserts that the constitutive relation of
  -- a multipole is linear.
  fun LinearMultipole : Ind MultipoleAttribute ;

  -- A Method that involves using mathematical aparatus.
  fun MathematicalMethod : Class ;
  fun MathematicalMethod_Class : SubClass MathematicalMethod Method ;

  -- A model that uses the mathematical aparatus
  fun MathematicalModel : Class ;
  fun MathematicalModel_Class : SubClass MathematicalModel Model ;

  -- A model of a Pendulum consisting
  -- of a mass hanged on a stiff string.
  fun MathematicalPendulum : Class ;
  fun MathematicalPendulum_Class : SubClass MathematicalPendulum MathematicalModel ;

  -- mathematics
  fun MathematicsDomain : Class ;
  fun MathematicsDomain_Class : SubClass MathematicsDomain NaturalSciencesDomain ;

  -- An EngineeringComponent in function of
  -- which play role mechanical energetical interactions.
  fun MechanicalDevice : Class ;
  fun MechanicalDevice_Class : SubClass MechanicalDevice EngineeringComponent ;

  -- domain involving mechanical engineering
  fun MechanicalEngineeringDomain : Class ;
  fun MechanicalEngineeringDomain_Class : SubClass MechanicalEngineeringDomain EngineeringDomain ;

  -- A Process in which mechanical interactions take place
  fun MechanicalProcess : Class ;
  fun MechanicalProcess_Class : SubClass MechanicalProcess NaturalProcess ;

  -- a resonance of mechanical energy.
  fun MechanicalResonance : Class ;
  fun MechanicalResonance_Class : SubClass MechanicalResonance (both MechanicalProcess Resonance) ;

  -- basic (theoretic) mechanics
  fun MechanicsDomain : Class ;
  fun MechanicsDomain_Class : SubClass MechanicsDomain PhysicsDomain ;

  -- a way of doing something, esp. a systematic one;
  -- implies an orderly logical arrangement (usually in steps).
  fun Method : Class ;
  fun Method_Class : SubClass Method Procedure ;

  -- An abstract object that models certain aspect of a
  -- physical object, is subject to abstraction and idealization.
  fun Model : Class ;
  fun Model_Class : SubClass Model Abstract ;

  -- A creative process of creating a model.
  fun Modeling : Class ;
  fun Modeling_Class : SubClass Modeling IntentionalProcess ;

  -- Metal_oxyde semiconductor field_effect
  -- transistor.
  fun MosfetTransistor : Class ;
  fun MosfetTransistor_Class : SubClass MosfetTransistor FetTransistor ;

  -- An actuator intended to deliver mechanical power
  fun Motor : Class ;
  fun Motor_Class : SubClass Motor MechanicalDevice ;

  -- Basic element of a multipole diagram, a
  -- multipole is a model of a component of a dynamic system, it can model a
  -- real separable component, such as a motor of a vehicle, or just an
  -- attribute of the system, such as inertia or friction, multipole interacts
  -- with other multipoles through its poles. Multipole Each multipole must have at least one section.
  fun Multipole : Class ;
  fun Multipole_Class : SubClass Multipole Model ;

  -- a set of tags that can be associated with multipoles
  fun MultipoleAttribute : Class ;
  fun MultipoleAttribute_Class : SubClass MultipoleAttribute InternalAttribute ;

  -- Graphical representation of a MultipoleModel.
  fun MultipoleDiagram : Class ;
  fun MultipoleDiagram_Class : SubClass MultipoleDiagram ContentBearingObject ;

  -- Model of a physical system consisting of
  -- mutually interconnected multipoles.
  fun MultipoleModel : Class ;
  fun MultipoleModel_Class : SubClass MultipoleModel Model ;

  -- modeling of a dynamic system by means of
  -- its representation by a multipole diagram.
  fun MultipoleModeling : Class ;
  fun MultipoleModeling_Class : SubClass MultipoleModeling Modeling ;

  -- A part of multipole pole that models
  -- a single energetical interaction. If a pole belongs to a multipole, it also belongs to
  -- one of its sections.
  fun MultipolePole : Class ;
  fun MultipolePole_Class : SubClass MultipolePole Model ;

  -- MultipoleSection that contains exactly two
  -- poles. MultipolePort Ports do not have three distinct poles.
  fun MultipolePort : Class ;
  fun MultipolePort_Class : SubClass MultipolePort MultipoleSection ;

  -- One of the postulates of the multipole modeling theory.
  fun MultipolePostulate : Class ;

  -- a multipole variable that have physical
  -- dimension and meaning.
  fun MultipoleQuantity : Class ;
  fun MultipoleQuantity_Class : SubClass MultipoleQuantity Quantity ;

  -- A set of poles that is subject to
  -- the postulate of continuity. A multipole may consist of one or
  -- more sections. Sections of a single multipole do not overlap
  -- and cover all its poles. MultipoleSection Each section must have at least two distinct poles.
  fun MultipoleSection : Class ;
  fun MultipoleSection_Class : SubClass MultipoleSection Model ;

  -- a variable that describes energetical
  -- interactions between multipoles.
  fun MultipoleVariable : Class ;
  fun MultipoleVariable_Class : SubClass MultipoleVariable Number ;

  -- Property whereby an electromotive force is
  -- induced in a circuit by variation of current in a neighboring circuit.
  fun MutualInductance : Class ;
  fun MutualInductance_Class : SubClass MutualInductance Inductance ;

  -- natural sciences (mathematics, physics)
  fun NaturalSciencesDomain : Class ;
  fun NaturalSciencesDomain_Class : SubClass NaturalSciencesDomain ScienceDomain ;

  -- A body remains at rest or in motion with
  -- a constant velocity unless acted upon by an external force
  fun NewtonsFirstLaw : Class ;
  fun NewtonsFirstLaw_Class : SubClass NewtonsFirstLaw NewtonsLaw ;

  -- One of three basic laws of classical mechanics.
  fun NewtonsLaw : Class ;
  fun NewtonsLaw_Class : SubClass NewtonsLaw ScientificLaw ;

  -- The rate of change of momentum is
  -- proportional to the imposed force and goes in the direction of
  -- the force
  fun NewtonsSecondLaw : Class ;
  fun NewtonsSecondLaw_Class : SubClass NewtonsSecondLaw NewtonsLaw ;

  -- Action and reaction are equal and opposite.
  fun NewtonsThirdLaw : Class ;
  fun NewtonsThirdLaw_Class : SubClass NewtonsThirdLaw NewtonsLaw ;

  -- An Amplifier that does not change the polarity 
  -- of the input signal.
  fun NoninvertingAmplifier : Class ;
  fun NoninvertingAmplifier_Class : SubClass NoninvertingAmplifier Amplifier ;

  -- The description of the entity (e.g. a Model)
  -- involves nonlinear functions.
  fun Nonlinear : Class ;
  fun Nonlinear_Class : SubClass Nonlinear InternalAttribute ;

  -- An ElectricalMultipoleModel containing
  -- nonlinear multipoles.
  fun NonlinearCircuit : Class ;
  fun NonlinearCircuit_Class : SubClass NonlinearCircuit ElectricalMultipoleModel ;

  -- An Equation that is not a LinearEquation.
  fun NonlinearEquation : Class ;
  fun NonlinearEquation_Class : SubClass NonlinearEquation Equation ;

  -- A BjtTransistor with N_P_N junctions.
  fun NpnTransistor : Class ;
  fun NpnTransistor_Class : SubClass NpnTransistor BjtTransistor ;

  -- A complex semiconductor device with
  -- behaviour similar to the IdealOperationalAmplifier.
  fun OperationalAmplifier : Class ;
  fun OperationalAmplifier_Class : SubClass OperationalAmplifier ElectricalCircuit ;

  -- A DifferentialEquation
  -- that is not a PartialDifferentialEquation.
  fun OrdinaryDifferentialEquation : Class ;
  fun OrdinaryDifferentialEquation_Class : SubClass OrdinaryDifferentialEquation DifferentialEquation ;

  -- Resonance taking place in a series RLC
  -- circuit, i.e. in a circuit where its elements are connected in_series.
  fun ParallelResonance : Class ;
  fun ParallelResonance_Class : SubClass ParallelResonance ElectricalResonance ;

  -- A DifferentialEquation
  -- involving a functions of more than one variable.
  fun PartialDifferentialEquation : Class ;
  fun PartialDifferentialEquation_Class : SubClass PartialDifferentialEquation DifferentialEquation ;

  -- A MechanicalDevice of an object mounted so that
  -- it swings freely under the influence of gravity.
  fun Pendulum : Class ;
  fun Pendulum_Class : SubClass Pendulum MechanicalDevice ;

  -- A DC motor in which the auxiliary
  -- magnetic field is provided by a permanent magnet.
  fun PermanentMagnetDcMotor : Class ;
  fun PermanentMagnetDcMotor_Class : SubClass PermanentMagnetDcMotor DcMotor ;

  -- A physical dimension such as
  -- length, mass, force etc.
  fun PhysicalDimension : Class ;
  fun PhysicalDimension_Class : SubClass PhysicalDimension Quantity ;

  -- An attribute of a multipole pole describing
  -- the kind of physical interaction the pole models.
  fun PhysicalDomain : Class ;
  fun PhysicalDomain_Class : SubClass PhysicalDomain InternalAttribute ;

  -- physics
  fun PhysicsDomain : Class ;
  fun PhysicsDomain_Class : SubClass PhysicsDomain NaturalSciencesDomain ;

  -- A BjtTransistor with P_N_P junctions.
  fun PnpTransistor : Class ;
  fun PnpTransistor_Class : SubClass PnpTransistor BjtTransistor ;

  -- The sum of through variables of
  -- poles of multipole section is equal to zero.
  fun PostulateOfContinuity : Class ;
  fun PostulateOfContinuity_Class : SubClass PostulateOfContinuity MultipolePostulate ;

  -- PhysicalDimension of power, [W].
  fun Power : Ind PhysicalDimension ;

  -- power electronic circuits (power supplies etc.)
  fun PowerElectronicsDomain : Class ;
  fun PowerElectronicsDomain_Class : SubClass PowerElectronicsDomain ElectronicsDomain ;

  -- PhysicalDimension of pressure, [Pa],[N.m^_2].
  fun Pressure : Ind PhysicalDimension ;

  -- valve that controls the pressure in a fluid
  fun PressureControlValve : Class ;
  fun PressureControlValve_Class : SubClass PressureControlValve Valve ;

  -- A Twopole that models single physical
  -- phenomenon, its constitutive relation has special structure.
  fun PureTwopole : Class ;
  fun PureTwopole_Class : SubClass PureTwopole Twopole ;

  -- Pulse_width modulation technique
  fun Pwm : Class ;
  fun Pwm_Class : SubClass Pwm ElectricalEngineeringMethod ;

  -- An ElectricalMultipoleModel containing
  -- a ResistorElement and a CapacitorElement.
  fun RCCircuit : Class ;
  fun RCCircuit_Class : SubClass RCCircuit ElectricalMultipoleModel ;

  -- An ElectricalMultipoleModel containing
  -- a ResistorElement, an InductorElement and a CapacitorElement.
  fun RLCCircuit : Class ;
  fun RLCCircuit_Class : SubClass RLCCircuit ElectricalMultipoleModel ;

  -- An ElectricalMultipoleModel containing
  -- a ResistorElement and an InductorElement.
  fun RLCircuit : Class ;
  fun RLCircuit_Class : SubClass RLCircuit ElectricalMultipoleModel ;

  -- electrical device that transforms alternating
  -- into direct current.
  fun Rectifier : Class ;
  fun Rectifier_Class : SubClass Rectifier ElectricalCircuit ;

  -- an electro_mechanical device used as a controlled switch
  fun Relay : Class ;
  fun Relay_Class : SubClass Relay (both ElectricalComponent MechanicalDevice) ;

  -- relays
  fun RelaysDomain : Class ;
  fun RelaysDomain_Class : SubClass RelaysDomain ElectroMechanicalDevicesDomain ;

  -- Most common type of a presure control valve;
  -- it consists of a piston that is retained on its seat by a spring
  fun ReliefValve : Class ;
  fun ReliefValve_Class : SubClass ReliefValve PressureControlValve ;

  -- A material's opposition to the flow of
  -- electric current.
  fun Resistivity : Ind PhysicalAttribute ;

  -- An ElectricalComponent that resists the flow of
  -- electrical current. A Dissipator from electrical energy domain.
  fun ResistorElement : Class ;
  fun ResistorElement_Class : SubClass ResistorElement (both ElectricDevice ElectricalComponent) ;

  -- a vibration of large amplitude produced by
  -- a relatively small vibration near the same frequency of vibration
  -- as the natural frequency of the resonating system.
  fun Resonance : Class ;
  fun Resonance_Class : SubClass Resonance NaturalProcess ;

  -- Root_locus control design method
  fun RootLocus : Class ;
  fun RootLocus_Class : SubClass RootLocus ControlDesignMethod ;

  -- Mechanic rotary energetic interaction
  fun Rotary : Ind PhysicalDomain ;

  -- The Rotating component of a motor, generator or similar 
  -- Device. Rotor The rotating armature of a motor or generator.
  fun Rotor : Class ;
  fun Rotor_Class : SubClass Rotor (both EngineeringComponent (both ElectricDevice MechanicalDevice)) ;

  -- science (natural sciences, engineering, medicine...)
  fun ScienceDomain : Class ;
  fun ScienceDomain_Class : SubClass ScienceDomain ApplicationDomain ;

  -- A generalization based on recurring facts or events 
  -- (in science or mathematics etc)
  fun ScientificLaw : Class ;
  fun ScientificLaw_Class : SubClass ScientificLaw Proposition ;

  -- An electrical device that exploits
  -- properties of semiconductors.
  fun SemiconductorComponent : Class ;
  fun SemiconductorComponent_Class : SubClass SemiconductorComponent ElectricalComponent ;

  -- A DC motor in which the auxiliary
  -- magnetic field is provided an active circuit.
  fun SeparatelyExcitedDcMotor : Class ;
  fun SeparatelyExcitedDcMotor_Class : SubClass SeparatelyExcitedDcMotor DcMotor ;

  -- Resonance taking place in a parallel RLC
  -- circuit, i.e. in a circuit where its elements are connected in_parallel.
  fun SeriesResonance : Class ;
  fun SeriesResonance_Class : SubClass SeriesResonance ElectricalResonance ;

  -- A Set of equations
  fun SetOfEquations : Class ;
  fun SetOfEquations_Class : SubClass SetOfEquations Set ;

  -- A revolving rod that transmits power or motion.
  fun Shaft : Class ;
  fun Shaft_Class : SubClass Shaft MechanicalDevice ;

  -- A PowerSource of single phase
  -- alternating current.
  fun SinglePhasePowerSource : Class ;
  fun SinglePhasePowerSource_Class : SubClass SinglePhasePowerSource PowerSource ;

  -- A Rectifier of single phase AC
  -- voltage.
  fun SinglePhaseRectifier : Class ;
  fun SinglePhaseRectifier_Class : SubClass SinglePhaseRectifier Rectifier ;

  -- solved example
  fun SolvedExampleCategory : Ind DocumentCategory ;

  -- A PureTwopole that models a generator of either across or through variable.
  fun Source : Class ;
  fun Source_Class : SubClass Source PureTwopole ;

  -- a directional control valve that uses a spool
  -- to control the direction of flow
  fun SpoolValve : Class ;
  fun SpoolValve_Class : SubClass SpoolValve DirectionalControlValve ;

  -- a metal device that returns to its shape or
  -- position when pushed or pulled or pressed
  fun Spring : Class ;
  fun Spring_Class : SubClass Spring MechanicalDevice ;

  -- A ThroughVariableAccumulator from translatory energy domain.
  fun SpringElement : Class ;
  fun SpringElement_Class : SubClass SpringElement (both ThroughVariableAccumulator TranslatoryTwopole) ;

  -- Stationary part of a motor or generator in or
  -- around which the rotor revolves.
  fun Stator : Class ;
  fun Stator_Class : SubClass Stator (both ElectricDevice MechanicalDevice) ;

  -- The physical property of being inflexible
  -- and hard to stretch.
  fun Stiffness : Ind PhysicalAttribute ;

  -- a process of designing an engineering system
  fun SystemDesign : Class ;
  fun SystemDesign_Class : SubClass SystemDesign EngineersSubprocess ;

  -- a process of specifying requirements
  -- on a system
  fun SystemSpecification : Class ;
  fun SystemSpecification_Class : SubClass SystemSpecification EngineersSubprocess ;

  -- A practical Method or art applied to some
  -- particular task
  fun Technique : Class ;
  fun Technique_Class : SubClass Technique Method ;

  -- a point on an electrical device (such as a 
  -- battery) at which electric current enters or leaves
  fun Terminal : Class ; --  meronym ElectricalComponent

  -- A PowerSource of three phase
  -- alternating current.
  fun ThreePhasePowerSource : Class ;
  fun ThreePhasePowerSource_Class : SubClass ThreePhasePowerSource PowerSource ;

  -- A Rectifier of single phase AC
  -- voltage.
  fun ThreePhaseRectifier : Class ;
  fun ThreePhaseRectifier_Class : SubClass ThreePhaseRectifier Rectifier ;

  -- A PureTwopole that accumulates through variable.
  fun ThroughVariableAccumulator : Class ;
  fun ThroughVariableAccumulator_Class : SubClass ThroughVariableAccumulator PureTwopole ;

  -- A Source that models a generator of through variable.
  fun ThroughVariableSource : Class ;
  fun ThroughVariableSource_Class : SubClass ThroughVariableSource Source ;

  -- a SemiconductorComponent that consists of three
  -- p_n junctions, it is used e.g. in controlled rectifiers.
  fun Thyristor : Class ;
  fun Thyristor_Class : SubClass Thyristor SemiconductorComponent ;

  -- PhysicalDimension of torque, [N/m].
  fun Torque : Ind PhysicalDimension ;

  -- A Transducer for which the ratio of
  -- across variables and through variables respectively is equal.
  fun Transformer : Class ;
  fun Transformer_Class : SubClass Transformer Transducer ;

  -- An ElectricalDevice by which alternating 
  -- current of one voltage is changed to another voltage.
  fun TransformerDevice : Class ;
  fun TransformerDevice_Class : SubClass TransformerDevice ElectricDevice ;

  -- A semiconductor device capable of amplification
  -- or switching.
  fun Transistor : Class ;
  fun Transistor_Class : SubClass Transistor SemiconductorComponent ;

  -- Mechanic translatory energetic interaction
  fun Translatory : Ind PhysicalDomain ;

  -- A PureTwopole from translatory energy domain.
  fun TranslatoryTwopole : Class ;
  fun TranslatoryTwopole_Class : SubClass TranslatoryTwopole PureTwopole ;

  fun Truck_Car : SubClass Truck Car ;

  -- tutorial
  fun TutorialCategory : Ind DocumentCategory ;

  -- A Multipole with exactly two poles. Twopole Twopole has exactly one port.
  fun Twopole : Class ;
  fun Twopole_Class : SubClass Twopole Multipole ;

  -- A Multipole with exactly two sections.
  fun Twoport : Class ;
  fun Twoport_Class : SubClass Twoport Fourpole ;

  -- The process of removing of an installed
  -- application from a computer.
  fun UnInstallation : Class ;
  fun UnInstallation_Class : SubClass UnInstallation ITProcess ;

  -- An EngineeringComponent for which
  -- the principal physical domain is not specified.
  fun UnknownDomainDevice : Class ;
  fun UnknownDomainDevice_Class : SubClass UnknownDomainDevice EngineeringComponent ;

  -- A hydraulic valve.
  fun Valve : Class ;
  fun Valve_Class : SubClass Valve (both FluidPowerDevice MechanicalDevice) ;

  -- Bessel's equation
  fun VanderpolsEquation : Class ;
  fun VanderpolsEquation_Class : SubClass VanderpolsEquation (both NonlinearEquation OrdinaryDifferentialEquation) ;

  -- PhysicalDimension of velocity, [m/s].
  fun Velocity : Ind PhysicalDimension ;

  -- PhysicalDimension of voltage, [V].
  fun Voltage : Ind PhysicalDimension ;

  -- valve that controls the flow rate of
  -- a fluid
  fun VolumeControlValve : Class ;
  fun VolumeControlValve_Class : SubClass VolumeControlValve Valve ;

  -- PhysicalDimension of volume flow, [m^_3].
  fun VolumeFlow : Ind PhysicalDimension ;

  -- knowledge base document _ a document in natural language 
  -- representing one piece of knowledge in the knowledge base
  fun WebDocument : Class ;
  fun WebDocument_Class : SubClass WebDocument ContentBearingObject ;

  -- knowledge base document attribute
  fun WebDocumentAttribute : Class ;
  fun WebDocumentAttribute_Class : SubClass WebDocumentAttribute InternalAttribute ;

  fun ZenerDiode : Class ;
  fun ZenerDiode_Class : SubClass ZenerDiode Diode ;

  -- A meronymy relation similar to part, but
  -- for abstract rather than physical things.
  fun abstractPart : El Abstract -> El Abstract -> Formula;

  -- multipole pole has across variable
  fun hasAcrossVariable : El MultipolePole -> El MultipoleVariable -> Formula ;

  -- multipole quantity has certain dimension
  fun hasDimension : El MultipoleQuantity -> El PhysicalDimension -> Formula ;

  -- multipole pole has through variable
  fun hasThroughVariable : El MultipolePole -> El MultipoleVariable -> Formula ;

  -- multipole quantity has certain variable
  fun hasVariable : El MultipoleQuantity -> El MultipoleVariable -> Formula ;

  -- associates a SUMO concept with a lexicon word
  fun lexicon : El SetOrClass -> El LexiconCategory -> El SymbolicString -> Formula ;

  -- A relation similar to WordNet meronymy relation.
  -- If class A is a meronym of class B, it means that instances of A
  -- typically are parts of instances of B.
  fun meronym : Desc Object -> Desc Object -> Formula ;

  -- A relation signaling that certain model is
  -- convenient for modeling of certain class of devices.
  fun models : El Model -> El EngineeringComponent -> Formula ;

  -- Relation that holds for pairs of physical
  -- dimensions that multiply up into a physical dimension of Power.
  -- The first is considered for across variable, the second for through variable.
  fun physicalDomain : El PhysicalDimension -> El PhysicalDimension -> El PhysicalDomain -> Formula ;

}
