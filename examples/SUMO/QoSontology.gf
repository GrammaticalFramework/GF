abstract QoSontology = open Merge, Mid_level_ontology, engineering in {




--  To exit a function or application without saving 
-- any data that has been changed.
fun Abort : Class ;
fun Abort_Class : SubClass Abort ComputerProcess ;

-- This is a subclass of 
-- TimingRequirementAttribute, which includes Instrument_AbstractionLevel, 
-- Method_AbstractionLevel, Object_AbstractionLevel, Task_AbstractionLevel,
-- and TaskGroup_AbstractionLevel.
fun AbstractionLevelAttribute : Class ;
fun AbstractionLevelAttribute_Class : SubClass AbstractionLevelAttribute TimingRequirementAttribute ;

-- (AddressFn ?FILE) returns as its value the 
-- physical address of the ComputerFile ?FILE.
fun AddressFn : El ComputerFile -> Ind PhysicalAddress ;


-- An instance of the class 
-- RealtimeSystem has Initiation_DesignPattern if it consists of 
-- sensors connected to a software module that filters data from the 
-- sensors and sends the filtered data to another software module that 
-- evaluates the filtered data and sends decisions to a subsystem. 
-- The design pattern is a data source that produces a data stream for 
-- a data handler. The data source is typically a periodically sampled 
-- collection of sensors. The data stream's size may vary and is 
-- unbounded. Data may be either homogeneous or heterogeneous. The 
-- workload per data element for homogeneous data is constant. The 
-- workload per data element for heterogeneous data is a function of 
-- each element type. There is one deadline for real_time situation 
-- assessment systems. It is the upper bound on the time to process 
-- all elements in the data stream once.
fun Assessment_DesignPattern : Class ;
fun Assessment_DesignPattern_Class : SubClass Assessment_DesignPattern DesignPatternAttribute ;

-- A program which is started 
-- automatically, as opposed to an application started in response to 
-- some condition becoming true.
fun AutomaticApplication : Class ;
fun AutomaticApplication_Class : SubClass AutomaticApplication ComputerProgram ;

-- Berkeley Software Distribution (UNIX), 
-- a version of Unix distributed by the University of California at Berkeley. Widely 
-- used as a standard for early versions of Unix and Unix software libraries.
fun BerkeleySoftwareDistribution : Class ;
fun BerkeleySoftwareDistribution_Class : SubClass BerkeleySoftwareDistribution OperatingSystem ;

-- The measurement of the speed of data 
-- transfer in a communications system.
fun BitsPerSecond : Class ;


-- A network in which all nodes are connected 
-- to a single wire (the bus) that has two endpoints. Ethernet 10Base_2 
-- and 10Base_5 networks, for example, are bus networks. Other common 
-- network types include StarNetworks and RingNetworks.
fun BusNetwork : Class ;
fun BusNetwork_Class : SubClass BusNetwork LAN ;

-- CPU (Central Processing Unit) is the computing part 
-- of the computer.
fun CPU : Class ;
fun CPU_Class : SubClass CPU (both ComputerComponent ComputerHardware) ;


-- (CPUUtilizationFn ?PROGRAM) refers to 
-- the percentage of time the CPU is used by an application ?PROGRAM.
fun CPUUtilizationFn : El ComputerProgram -> Ind ConstantQuantity ;


-- A subclass of 
-- TimingRequirementAttribute, which includes
-- MultipleRequirement_Complexity and SingleRequirement_Complexity.
fun ComplexityAttribute : Class ;
fun ComplexityAttribute_Class : SubClass ComplexityAttribute TimingRequirementAttribute ;

-- Instances of ComputationalSystems 
-- include instances of SoftwareSystems, HardwareSystems, and 
-- ComputerNetworks.
fun ComputationalSystem : Class ;
fun ComputationalSystem_Class : SubClass ComputationalSystem Product ;

-- A general_purpose machine that processes 
-- data according to a set of instructions that are stored internally 
-- either temporarily or permanently.
fun Computer : Class ;
fun Computer_Class : SubClass Computer ElectricDevice ;

-- An instance of ComputerComponent is a 
-- piece of computer hardware that has measurable performance characteristics 
-- in terms of different units. Components include hard drives, the performance
-- of which can be measured in terms of BitsPerSecond required to transfer data 
-- to and from the drive, network adapters, the performance of which can be 
-- measured by PacketsPerSecond units of data transfered to and from the adapter, 
-- and other common components like ComputerMemory and CentralProcessingUnit.
fun ComputerComponent : Class ;
fun ComputerComponent_Class : SubClass ComputerComponent ComputerHardware ;

-- The term ComputerData refers to files 
-- and databases, text documents, and images.
fun ComputerData : Class ;
fun ComputerData_Class : SubClass ComputerData ContentBearingObject ;

-- This is the class of catalogs that 
-- identify and locate instances of ComputerFiles. The catalog's entries 
-- consist of at least ComputerFile names and a physical address on a memory
-- device of the ComputerFile or an index (e.g., file descriptor) into a 
-- table of ComputerFile physical addresses. ComputerDirectories are thus 
-- collections of data elements and must be named and stored on memory devices, 
-- hence, ComputerDirectory is a subset of ComputerFile. ComputerDirectory folders contain only files and other folders
fun ComputerDirectory : Class ;
fun ComputerDirectory_Class : SubClass ComputerDirectory ComputerFile ;

fun ComputerFile_ComputerData : SubClass ComputerFile ComputerData ;

-- The hardware is the physical part of 
-- a computer system.
fun ComputerHardware : Class ;
fun ComputerHardware_Class : SubClass ComputerHardware EngineeringComponent ;

-- A peripheral device that generates 
-- input for the computer such as a keyboard, scanner, or mouse.
fun ComputerInputDevice : Class ;
fun ComputerInputDevice_Class : SubClass ComputerInputDevice ComputerHardware ;

-- The EnglishLanguage computer's workspace (physically, 
-- a collection of RAM chips). It is an important resource, since it 
-- determines the size and number of programs that can be run at the 
-- same time, as well as the amount of data that can be processed 
-- instantly.
fun ComputerMemory : Class ;
fun ComputerMemory_Class : SubClass ComputerMemory (both ComputerComponent ComputerHardware) ;


-- The network includes the network 
-- operating system in the client and server machines, the cables 
-- connecting them and all supporting hardware in between such as 
-- bridges, routers and switches.
fun ComputerNetwork : Class ;
fun ComputerNetwork_Class : SubClass ComputerNetwork (both ComputationalSystem RealtimeSystem) ;


-- Any peripheral that presents 
-- output from the computer, such as a screen or printer.
fun ComputerOutputDevice : Class ;
fun ComputerOutputDevice_Class : SubClass ComputerOutputDevice ComputerHardware ;

-- A word or code used to serve as a security 
-- measure against unauthorized access to data. It is normally managed by the 
-- operating system or DBMS.
fun ComputerPassword : Class ;
fun ComputerPassword_Class : SubClass ComputerPassword SymbolicString ;

-- An instance of ComputerPath is a series 
-- of programs that connects input devices, typically sensors, to output 
-- devices, typically actuators.
fun ComputerPath : Class ;
fun ComputerPath_Class : SubClass ComputerPath ComputerData ;

-- The class of all attributes that are 
-- specific to ComputerPaths.
fun ComputerPathAttribute : Class ;
fun ComputerPathAttribute_Class : SubClass ComputerPathAttribute SoftwareAttribute ;

-- An instance of ComputerProcess is a 
-- process which manipulates data in the computer.
fun ComputerProcess : Class ;
fun ComputerProcess_Class : SubClass ComputerProcess InternalChange ;

-- A collection of data, presented in a preformatted 
-- manner.
fun ComputerReport : Class ;
fun ComputerReport_Class : SubClass ComputerReport ComputerData ;

-- One element of hardware, software or data 
-- that is part of a larger system. For example, network resources are the 
-- available servers and printers in the network. Software resources can be 
-- programs, utilities or even smaller elements within a program. Data 
-- resources are the files and databases that can be accessed.
fun ComputerResource : Class ;
fun ComputerResource_Class : SubClass ComputerResource ComputationalSystem ;

-- A ComputerProcess which attempts to 
-- comply with a user's request.
fun ComputerResponse : Class ;
fun ComputerResponse_Class : SubClass ComputerResponse ComputerProcess ;

-- An attribute which describes status of the 
-- Computer, such as HostDown, HostReady.
fun ComputerStatus : Class ;
fun ComputerStatus_Class : SubClass ComputerStatus RelationalAttribute ;

-- In a multitasking environment, an 
-- independently running program or subprogram. Each task is assigned 
-- a task number.
fun ComputerTask : Class ;
fun ComputerTask_Class : SubClass ComputerTask ComputerProcess ;

-- A ComputerOutputDevice for displaying
-- information on some sort of screen or other reusable output surface. This
-- is contrasted with a Printer, which places a substance on a surface
-- that is for practical purposes, permanent.
fun ComputerTerminal : Class ;
fun ComputerTerminal_Class : SubClass ComputerTerminal ComputerOutputDevice ;

-- Any individual who interacts with a 
-- computer.
fun ComputerUser : Class ;
fun ComputerUser_Class : SubClass ComputerUser CognitiveAgent ;

-- This attribute applies to 
-- real_time systems that are designed and implemented so that the system 
-- can adapt by replicating the system components and executing them 
-- concurrently.
fun Concurrency_FormOfAdaptation : Class ;
fun Concurrency_FormOfAdaptation_Class : SubClass Concurrency_FormOfAdaptation FormOfAdaptationAttribute ;

-- A Program which is started inside 
-- an Xterm or other console.
fun ConsoleApplication : Class ;
fun ConsoleApplication_Class : SubClass ConsoleApplication ComputerProgram ;

-- The attribute which denotes that the 
-- path type is continuous, as opposed to transient or quasiconstinuous 
-- paths. A continuous path handles a stream of data arriving at a comment 
-- of rate.
fun ContinuousPath : Class ;
fun ContinuousPath_Class : SubClass ContinuousPath ComputerPathAttribute ;

-- Encoding data to take up less storage 
-- space.
fun DataCompression : Class ;
fun DataCompression_Class : SubClass DataCompression ComputerProcess ;

-- A process of copying the document, record or 
-- image being worked on onto a storage medium. Saving updates the file by 
-- writing the data that currently resides in memory (RAM) onto disk or tape. 
-- Most applications prompt the user to save data upon exiting.
fun DataSaving : Class ;
fun DataSaving_Class : SubClass DataSaving ComputerProcess ;

-- A device or part of the computer that 
-- receives data.
fun DataSink : Class ;
fun DataSink_Class : SubClass DataSink ComputerInputDevice ;

-- A subclass of ComputerProcesses which 
-- send data over a computer channel or bus.
fun DataTransfer : Class ;
fun DataTransfer_Class : SubClass DataTransfer ComputerProcess ;

-- A set of related files that is created and 
-- managed by a database management system (DBMS).
fun Database : Class ;
fun Database_Class : SubClass Database ComputerData ;

-- An instance of RealtimeSystem 
-- is described as Dependent_TaskRelation if it depends on at least one 
-- other function in the system, that is, its correct execution depends on 
-- the input from another function, the execution state of another function, 
-- or the acceptance of its outputs by another function.
fun Dependent_TaskRelation : Ind TaskRelationAttribute ;


-- This is a subclass of 
-- RealtimeSystemAttribute, which includes Guidance_DesignPattern, 
-- Initiation_DesignPattern, and Assessment_DesignPattern.
fun DesignPatternAttribute : Class ;
fun DesignPatternAttribute_Class : SubClass DesignPatternAttribute RealtimeSystemAttribute ;

-- The attribute which denotes that 
-- the data stream is conceived as a stream of one datum after another, and 
-- each datum or identifiable group of data is separated by a constant of 
-- time.
fun DeterministicDataStream : Class ;
fun DeterministicDataStream_Class : SubClass DeterministicDataStream ComputerPathAttribute ;

-- The attribute which denotes that the 
-- path data stream type is dynamic, i.e. the time changes but the data 
-- stream follows a pattern.
fun DynamicDataStream : Class ;
fun DynamicDataStream_Class : SubClass DynamicDataStream ComputerPathAttribute ;

-- The class of attributes which 
-- correspond to environment variables. Environment variables are defined 
-- outside of a ComputerProgram, unlike ordinary variables that are 
-- defined in the source code of the ComputerProgram. Typically, the 
-- environment variable stores some value that many if not all 
-- ComputerProgams will need when they execute. An example is the
-- environment variable PATH under Unix_like operating systems that stores 
-- the ComputerDirectories where executable ComputerPrograms can be found. 
-- Another example is the environment variable CLASSPATH for Java programs, 
-- which stores the directory where Java class files can be found that will be 
-- needed by any ComputerProgram written in Java.
fun EnvironmentSoftwareAttribute : Class ;
fun EnvironmentSoftwareAttribute_Class : SubClass EnvironmentSoftwareAttribute RelationalAttribute ;

-- An instant in time that is arbitrarily selected as a point 
-- of reference.
fun Epoch : Class ;
fun Epoch_Class : SubClass Epoch TimePoint ;

-- Able to be run in its current format.
fun Executable : Ind RelationalAttribute ;


-- The class of all messages to a resource 
-- management program from one of its processes.
fun Feedback : Class ;
fun Feedback_Class : SubClass Feedback ContentBearingObject ;

-- An attribute that applies to a 
-- RealtimeSystem just in case a fixed percentage of requirements 
-- is met.
fun Firm_Strictness : Class ;
fun Firm_Strictness_Class : SubClass Firm_Strictness StrictnessAttribute ;

-- A subclass of 
-- RealtimeSystemAttribute, which includes Precision_FormOfAdaptation, 
-- Slack_FormOfAdaptation, Concurrency_FormOfAdaptation, and 
-- ResourceAllocation_FormOfAdaptation.
fun FormOfAdaptationAttribute : Class ;
fun FormOfAdaptationAttribute_Class : SubClass FormOfAdaptationAttribute RealtimeSystemAttribute ;

-- Instances of RealtimeSystems 
-- are described as systems with Guidance_DesignPattern if they consist 
-- of sensors connected to a software module that filters data from the 
-- sensors and sends the filtered data to a software module that evaluates 
-- the filtered data and sends instructions to a software module that 
-- commands actuators. The design pattern is an event source that produces 
-- events and a data source that produces data, both executing in parallel 
-- and handled by a single event_driven periodic data handler. The two 
-- separate input streams have fundamentally different characteristics. 
-- The event stream is necessarily asychronous, or transient. Once an 
-- event is sensed, the handler accepts data from the data stream, which 
-- has an invariant cycle time. There are two deadlines for a real_time 
-- guidance system. The period deadline is the time to process all elements 
-- in the data stream once and generate an actuator command. The action 
-- completion deadline is the time to guide the actuator to completion of 
-- the action.
fun Guidance_DesignPattern : Class ;
fun Guidance_DesignPattern_Class : SubClass Guidance_DesignPattern DesignPatternAttribute ;

-- The primary computer storage medium, which 
-- is made of one or more aluminum or glass platters, coated with a 
-- ferromagnetic material. Most hard disks are fixed disks, which are 
-- permanently sealed in the drive.
fun HardDiskDrive : Class ;
fun HardDiskDrive_Class : SubClass HardDiskDrive (both ComputerComponent ComputerHardware) ;


-- An attribute that applies to a 
-- RealtimeSystem just in case all deadlines are met.
fun Hard_Strictness : Class ;
fun Hard_Strictness_Class : SubClass Hard_Strictness StrictnessAttribute ;

-- The class of hardware systems is the 
-- connection of three types of physical modules: instances of 
-- ComputerProcessor(s), ComputerMemory, and ComputerNetwork. 
-- ComputerProcessors execute instructions from ComputerPrograms, 
-- which usually include instructions to read and write data from 
-- memory, and send data via instances of ComputerNetworks.
fun HardwareSystem : Class ;
fun HardwareSystem_Class : SubClass HardwareSystem (both ComputationalSystem (both ComputerHardware RealtimeSystem)) ;


-- Used to indicate that a ComputationalSystem 
-- has a high priority.
fun HighPriority : Ind PriorityAttribute ;


-- An attribute which applies to a computer that ceases to 
-- operate due to hardware or software failure.
fun HostDown : Ind ComputerStatus ;


-- An attribute which applies to a computer that is 
-- functional, operating properly, and ready to receive work requests.
fun HostReady : Ind ComputerStatus ;


-- An attribute that applies to a 
-- RealtimeSystem just in case the strictness of the system is a 
-- combination of Hard/Firm/Soft_Strictness with Importance_Strictness 
-- or a combination of Utility_Strictness with Importance_Strictness.
fun Hybrid_Strictness : Class ;
fun Hybrid_Strictness_Class : SubClass Hybrid_Strictness StrictnessAttribute ;

-- An instance of the class 
-- RealtimeSystem shows Hybrid_SystemBehavior if it is 
-- activated by transient events, i.e. it is executed at regular 
-- intervals when activated, and is deactivated by action completion.
fun Hybrid_SystemBehavior : Class ;
fun Hybrid_SystemBehavior_Class : SubClass Hybrid_SystemBehavior SystemBehaviorAttribute ;

-- The Internet Protocol address, a numeric address such as 123.231.32.2 that 
-- the domain name server translates into a domain name.
fun IPAddress : Class ;
fun IPAddress_Class : SubClass IPAddress PhysicalAddress ;

-- A picture (graphic) stored in a particular 
-- coding scheme and stored as a file. Note that this can include vector as 
-- well as raster images. Raster images will entail a particular number of 
-- horizontal and vertical pixels. Vector images will not entail a 
-- particular size or resolution.
fun ImageFile : Class ;
fun ImageFile_Class : SubClass ImageFile ComputerData ;

-- An attribute that applies to a 
-- RealtimeSystem just in case it is designed and implemented to meet 
-- the more important requirements first.
fun Importance_Strictness : Class ;
fun Importance_Strictness_Class : SubClass Importance_Strictness StrictnessAttribute ;

-- An instance of RealtimeSystem 
-- is described as Independent_TaskRelation if its correct execution 
-- does not depend on the inputs from any other function, the execution state 
-- of any other function, or the acceptance of its outputs by any other 
-- function.
fun Independent_TaskRelation : Class ;
fun Independent_TaskRelation_Class : SubClass Independent_TaskRelation TaskRelationAttribute ;

-- The function which returns as its value 
-- the initial profile of the program, i.e. a report of its execution 
-- characteristics.
fun InitialProfileFn : El ComputerProgram -> Ind ProcessState ;


-- An instance of the class 
-- RealtimeSystem has Initiation_DesignPattern if it consists of 
-- one software module and the actuators it commands. The design pattern 
-- is an event source which produces events for an event handler. The 
-- event source is typically an evaluate_and_decide software module. 
-- The event stream is necessarily asychronous, or transient. The arrival 
-- rate of events may vary and is unbounded. Events may be either 
-- homogeneous or heterogeneous. The workload per event for homogeneous 
-- events is constant. The workload per event for heterogeneous events 
-- is a function of each event type. There is one deadline for real_time 
-- action initiation systems. It is the upper bound on the time to 
-- generate a command for the actuator.
fun Initiation_DesignPattern : Class ;
fun Initiation_DesignPattern_Class : SubClass Initiation_DesignPattern DesignPatternAttribute ;

-- The attribute 
-- Instrument_AbstractionLevel is the lowest level of abstraction, 
-- which can be used to describe a real_time system or subsystem.
fun Instrument_AbstractionLevel : Class ;
fun Instrument_AbstractionLevel_Class : SubClass Instrument_AbstractionLevel AbstractionLevelAttribute ;

-- A computer network that spans a relatively small 
-- area. Most LANs are confined to a single building or group of buildings. 
-- However, one LAN can be connected to other LANs over any distance via 
-- telephone lines and radio waves. LAN A local_area network (LAN) whose topology is a ring. 
-- That is, all of the nodes are connected in a closed loop. Messages 
-- travel around the ring, with each node reading those messages addressed 
-- to it.
fun LAN : Class ;
fun LAN_Class : SubClass LAN ComputerNetwork ;

-- Used to indicate that a ComputationalSystem 
-- has a low priority.
fun LowPriority : Ind PriorityAttribute ;


-- Each element of MeasuringPerformance 
-- is an event of measuring the performance of an instance of ComputerComponent, 
-- performed by a MonitoringProgram.
fun MeasuringPerformance : Class ;
fun MeasuringPerformance_Class : SubClass MeasuringPerformance ComputerProcess ;

-- The attribute 
-- Method_AbstractionLevel is the next to the lowest level of 
-- abstraction that can be used to describe a real_time system or 
-- subsystem. This is at the level of describing every callable 
-- function (or method in an object_oriented language) implemented 
-- in software.
fun Method_AbstractionLevel : Class ;
fun Method_AbstractionLevel_Class : SubClass Method_AbstractionLevel AbstractionLevelAttribute ;

-- This command is to change the monitoring 
-- for any component for which a componentDataID was sent on initial connection.
fun MonitorApplicationCmd : Class ;
fun MonitorApplicationCmd_Class : SubClass MonitorApplicationCmd MonitoringProgram ;

-- This is the command to monitor any of the 
-- generic components _ hard drive, network, cpu, memory, etc.
fun MonitorComponentCmd : Class ;
fun MonitorComponentCmd_Class : SubClass MonitorComponentCmd MonitoringProgram ;

-- This is the command to get a list 
-- of applications periodically.
fun MonitorConnectivityCmd : Class ;
fun MonitorConnectivityCmd_Class : SubClass MonitorConnectivityCmd MonitoringProgram ;

-- A program which monitors performance 
-- of an application, a component, etc.
fun MonitoringProgram : Class ;
fun MonitoringProgram_Class : SubClass MonitoringProgram ComputerProgram ;

-- An attribute that describes 
-- instances of RealtimeSystems which require multiple timing requirements, 
-- both a bound for completion time for its transient behavior and a cycle 
-- deadline for its periodic behavior.
fun MultipleRequirement_Complexity : Class ;
fun MultipleRequirement_Complexity_Class : SubClass MultipleRequirement_Complexity ComplexityAttribute ;

-- The running of two or more programs in one 
-- computer at the same time. The number of programs that can be effectively 
-- multitasked depends on the type of multitasking performed (preemptive vs 
-- cooperative), CPU speed and memory and disk capacity.
fun Multitasking : Class ;
fun Multitasking_Class : SubClass Multitasking ComputerProcess ;

-- A network adapter, also known as a Network 
-- Interface Card or NIC, is a physical device installed in a computer on its 
-- system bus. Its purpose is to connect to a specific type of network,
-- usually an ethernet or a token ring network.
fun NetworkAdapter : Class ;
fun NetworkAdapter_Class : SubClass NetworkAdapter ComputerComponent ;

-- Network resources are the available 
-- servers and printers in the network.
fun NetworkResource : Class ;
fun NetworkResource_Class : SubClass NetworkResource ComputerResource ;

-- The attribute 
-- Object_AbstractionLevel is immediately above the attribute 
-- Method_AbstractionLevel and can be used to describe a real_time 
-- system or subsystem. This is at the level of describing every software 
-- object that can be created from a class together with its data structures 
-- and methods (which define the interface for manipulating the object).
fun Object_AbstractionLevel : Class ;
fun Object_AbstractionLevel_Class : SubClass Object_AbstractionLevel AbstractionLevelAttribute ;

-- The master control program that runs the 
-- computer. It is the first program loaded when the computer is turned on, 
-- and its main part, called the kernel, resides in memory at all times. It 
-- may be developed by the vendor of the computer it's running in or by a 
-- third party.
fun OperatingSystem : Class ;
fun OperatingSystem_Class : SubClass OperatingSystem SoftwareSystem ;

-- Optimization means finding the best solution according 
-- to a set of criteria. For a computer program, an optimal solution would be the 
-- fastest program (according to some benchmark) or the smallest program.
fun Optimization : Class ;
fun Optimization_Class : SubClass Optimization ProcessTask ;

-- A block of data used for transmission in packet 
-- switched systems.
fun Packet : Class ;
fun Packet_Class : SubClass Packet ComputerData ;

-- The rate or speed of Packet_Networks 
-- transferred in a second.
fun PacketsPerSecond : Ind CompositeUnitOfMeasure ;


-- The attribute which denotes that 
-- the path importance is defined by the dynamic library procedure 
-- pathImportanceFunction. This functions passes arguments for priority 
-- and current time and returns an integer that represents importance.
fun PathImportanceFunction : Ind ComputerPathAttribute ;


-- An instance of the class 
-- RealtimeSystem is described as a system with Periodic_SystemBehavior 
-- when it is activated at regular intervals.
fun Periodic_SystemBehavior : Class ;
fun Periodic_SystemBehavior_Class : SubClass Periodic_SystemBehavior SystemBehaviorAttribute ;

-- The collection of all addresses which 
-- identify a location of a ComputerFile.
fun PhysicalAddress : Class ;
fun PhysicalAddress_Class : SubClass PhysicalAddress SymbolicString ;

fun Precision_FormOfAdaptation : Class ;
fun Precision_FormOfAdaptation_Class : SubClass Precision_FormOfAdaptation FormOfAdaptationAttribute ;
-- A device that converts computer output into 
-- printed images.
fun Printer : Class ;
fun Printer_Class : SubClass Printer ComputerOutputDevice ;

-- A class of attributes which describe 
-- priorities of ComputationalSystems.
fun PriorityAttribute : Class ;
fun PriorityAttribute_Class : SubClass PriorityAttribute RelationalAttribute ;

-- An attribute that denotes the failure of the Process to achieve 
-- its goal.
fun ProcessFailure : Ind ProcessStatus ;


-- The class of all the information required 
-- for a ComputerProgram to run on a processor. It is a vector that 
-- contains a pointer to the next program instruction to be executed as well 
-- as the values of all intermediate and defined variables, the state of the 
-- processor executing the program, and the allocated address space among 
-- other data.
fun ProcessState : Class ;
fun ProcessState_Class : SubClass ProcessState ContentBearingObject ;

-- A class of attributes. Each instance of ProcessStatus describes a 
-- status of a Process, such as ProcessFailure, ProcessSuccess, etc.
fun ProcessStatus : Class ;
fun ProcessStatus_Class : SubClass ProcessStatus RelationalAttribute ;

-- An attribute that denotes the success of the Process to achieve 
-- its goal.
fun ProcessSuccess : Ind ProcessStatus ;


-- A function to be performed.
fun ProcessTask : Class ;
fun ProcessTask_Class : SubClass ProcessTask Abstract ;

-- An attribute which applies to 
-- computer paths which handle random events, which initiate a bounded 
-- stream of data arriving at a comment of rate, which the path must 
-- process.
fun QuasicontinuousPath : Class ;
fun QuasicontinuousPath_Class : SubClass QuasicontinuousPath ComputerPathAttribute ;

-- A program started by a Resource 
-- Management program, which determines if and where to start the 
-- application.
fun RM_StartApplication : Class ;
fun RM_StartApplication_Class : SubClass RM_StartApplication ComputerProgram ;

-- An computer_controlled system, the 
-- correct operation of which depends on meeting specified timing 
-- constraints.
fun RealtimeSystem : Class ;
fun RealtimeSystem_Class : SubClass RealtimeSystem ComputationalSystem ;

-- The class of Attributes which 
-- describe instances of the class RealtimeSystem.
fun RealtimeSystemAttribute : Class ;
fun RealtimeSystemAttribute_Class : SubClass RealtimeSystemAttribute RelationalAttribute ;

-- The attribute which denotes that 
-- a program can be restarted on the same host.
fun ReplicationsOnSameHostOK : Ind SoftwareAttribute ;


-- This attribute applies 
-- to real_time systems that are designed and implemented so that the system 
-- can adapt under the control of a resource allocation manager like Desiderata.
fun ResourceAllocation_FormOfAdaptation : Class ;
fun ResourceAllocation_FormOfAdaptation_Class : SubClass ResourceAllocation_FormOfAdaptation FormOfAdaptationAttribute ;

-- The class of resource 
-- management programs.
fun ResourceManagementProgram : Class ;
fun ResourceManagementProgram_Class : SubClass ResourceManagementProgram ComputerProgram ;

-- The attribute which denotes that a program 
-- can be restarted.
fun Restartable : Ind SoftwareAttribute ;


-- To use the same resource again.
fun ReusingAResource : Class ;
fun ReusingAResource_Class : SubClass ReusingAResource ComputerProcess ;

fun RingNetwork : Class ;
fun RingNetwork_Class : SubClass RingNetwork LAN ;
-- SatisfyingRequirements covers cases of 
-- finding a solution that satisfies necessary conditions.
fun SatisfyingRequirements : Class ;
fun SatisfyingRequirements_Class : SubClass SatisfyingRequirements ProcessTask ;

-- The attribute which denotes that 
-- an application can combine its input stream from different preceding 
-- applications or devices for greater scalability.
fun ScalabilityCombining : Ind SoftwareAttribute ;


-- The attribute which denotes that 
-- a program can split its output stream to different succeeding 
-- applications or devices for greater scalability.
fun ScalabilitySplitting : Ind SoftwareAttribute ;


-- The attribute which denotes that the path is 
-- scalable, i.e. the applications in the path can be replicated to meet 
-- realtime QoS requirements.
fun Scalable : Class ;
fun Scalable_Class : SubClass Scalable ComputerPathAttribute ;

-- Sensors include software that measures any 
-- attribute of executing computer programs or collections of executing 
-- programs, such as CPU utilization, aka load, memory utilization, I/O, 
-- overall task performance, network load and latency, etc.
fun Sensor : Class ;
fun Sensor_Class : SubClass Sensor ComputerHardware ;

-- A computer in a network shared by multiple users. 
-- The term may refer to both the hardware and software or just the software 
-- that performs the service.
fun Server : Class ;
fun Server_Class : SubClass Server ComputationalSystem ;

-- A typically small instance of 
-- ComputerProgram whose function is to end a typically larger
-- instance of ComputerProgram.
fun ShutdownBlock : Class ;
fun ShutdownBlock_Class : SubClass ShutdownBlock ComputerProgram ;

-- (ShutdownFn ?Program) returns an instance of 
-- ShutdownBlock which contains the instructions to end ?PROGRAM.
fun ShutdownFn : El ComputerProgram -> Ind ShutdownBlock ;


-- An attribute that describes 
-- instances of RealtimeSystems which require a single timing requirement,
-- either a bound for completion time for systems with 
-- Transient_SystemBehavior or cycle deadline for systems with 
-- Periodic_SystemBehavior.
fun SingleRequirement_Complexity : Class ;
fun SingleRequirement_Complexity_Class : SubClass SingleRequirement_Complexity ComplexityAttribute ;

-- The attribute Slack_FormOfAdaptation 
-- applies to real_time systems that are designed and implemented with enough 
-- resource overhead that the system can always adapt by utilizing the overhead 
-- without complicated decision making.
fun Slack_FormOfAdaptation : Class ;
fun Slack_FormOfAdaptation_Class : SubClass Slack_FormOfAdaptation FormOfAdaptationAttribute ;

-- An attribute that applies to a 
-- RealtimeSystem just in case it maximizes the number of timing 
-- requirements like deadlines that are met but does not guarantee that 
-- all such requirements will be met or any fixed percentage of 
-- requirements will be met.
fun Soft_Strictness : Class ;
fun Soft_Strictness_Class : SubClass Soft_Strictness StrictnessAttribute ;

-- The class of all attributes that are 
-- specific to SoftwareSystems.
fun SoftwareAttribute : Class ;
fun SoftwareAttribute_Class : SubClass SoftwareAttribute RelationalAttribute ;

-- This is the class of mutually supportive 
-- groups of instances of ComputerProgram for a single general purpose. 
-- For example, a database management system is a collection of many instances
-- of ComputerProgram that work together to store, retrieve, modify, and 
-- delete data.
fun SoftwareSystem : Class ;
fun SoftwareSystem_Class : SubClass SoftwareSystem (both ComputationalSystem RealtimeSystem) ;


-- The class of all instances of Solaris , a 
-- unix_based operating system for Sun SPARC computers. It includes the 
-- Open Look and Motif graphical user interfaces, OpenWindows (the Sun 
-- version of X Windows), DOS and Windows Emulation, and ONC networking.
fun Solaris : Class ;
fun Solaris_Class : SubClass Solaris OperatingSystem ;

-- A local_area network (LAN) that uses a star 
-- topology in which all nodes are connected to a central computer.
fun StarNetwork : Class ;
fun StarNetwork_Class : SubClass StarNetwork LAN ;

-- A typically small instance of ComputerProgram 
-- (a sequence of instructions that will run on a computer) whose function is 
-- to load and initialize a typically larger instance of ComputerProgram 
-- and start it running.
fun StartupBlock : Class ;
fun StartupBlock_Class : SubClass StartupBlock ComputerProgram ;

-- (StartupFn ?Program) returns an instance of 
-- StartupBlock which contains the instructions to start the ?Program.
fun StartupFn : El ComputerProgram -> Ind StartupBlock ;


-- The attribute which denotes that 
-- the time between data or groups of data changes according to no 
-- discernible pattern.
fun StochasticDataStream : Class ;
fun StochasticDataStream_Class : SubClass StochasticDataStream ComputerPathAttribute ;

-- This is a subclass of 
-- TimingRequirementAttribute, which includes Hard_Strictness, 
-- Firm_Strictness, Soft_Strictness, Importance_Strictness,
-- Utility_Strictness, and Hybrid_Strictness
fun StrictnessAttribute : Class ;
fun StrictnessAttribute_Class : SubClass StrictnessAttribute TimingRequirementAttribute ;

-- A subclass of 
-- RealtimeSystemAttribute, which includes the following Attributes: 
-- Periodic_SystemBehavior, Transient_SystemBehavior, and 
-- Hybrid_SystemBehavior.
fun SystemBehaviorAttribute : Class ;
fun SystemBehaviorAttribute_Class : SubClass SystemBehaviorAttribute RealtimeSystemAttribute ;

-- The attribute 
-- TaskGroup_AbstractionLevel is immediately above the attribute 
-- Task_AbstractionLevel and can be used to describe a real_time 
-- system or subsystem This is at the level of describing groups of 
-- tasks which are related or connected by the real_time systems and 
-- are typically part of a concurrently executing path.
fun TaskGroup_AbstractionLevel : Class ;
fun TaskGroup_AbstractionLevel_Class : SubClass TaskGroup_AbstractionLevel AbstractionLevelAttribute ;

-- This is a subclass of 
-- RealtimeSystemAttribute, which includes Independent_TaskRelation 
-- and Dependent_TaskRelation.
fun TaskRelationAttribute : Class ;
fun TaskRelationAttribute_Class : SubClass TaskRelationAttribute RealtimeSystemAttribute ;

-- The attribute 
-- Task_AbstractionLevel is immediately above the attribute 
-- Object_AbstractionLevel and can be used to describe a real_time 
-- system or subsystem. This is at the level of describing the major 
-- tasks that are carried out by the real_time systems and are typically 
-- executable as individual processes. The description of a task would 
-- consist of listing all the software objects used to perform the task.
fun Task_AbstractionLevel : Class ;
fun Task_AbstractionLevel_Class : SubClass Task_AbstractionLevel AbstractionLevelAttribute ;

-- A subclass of 
-- RealtimeSystemAttribute which includes ComplexityAttribute, 
-- StrictnessAttribute, and AbstractionLevelAttribute.
fun TimingRequirementAttribute : Class ;
fun TimingRequirementAttribute_Class : SubClass TimingRequirementAttribute RealtimeSystemAttribute ;

-- An attribute which applies to computer 
-- paths which handle random events.
fun TransientPath : Class ;
fun TransientPath_Class : SubClass TransientPath ComputerPathAttribute ;

-- An instance of the class 
-- RealtimeSystem shows Transient_SystemBehavior when it is 
-- activated by sporadic events.
fun Transient_SystemBehavior : Class ;
fun Transient_SystemBehavior_Class : SubClass Transient_SystemBehavior SystemBehaviorAttribute ;

-- A UniformResourceIdentifier 
-- (URI) is a compact string of characters for identifying an abstract or 
-- physical resource. A URI can be further classified as a locator, a name, 
-- or both (source: http://www.ietf.org/rfc/rfc2396.txt).
fun UniformResourceIdentifier : Class ;
fun UniformResourceIdentifier_Class : SubClass UniformResourceIdentifier ContentBearingObject ;

-- The term UniformResourceLocator 
-- (URL) refers to the subset of URI that identify resources via a 
-- representation of their primary access mechanism (e.g., their network 
-- location), rather than identifying the resource by name or by some other 
-- attribute(s) of that resource (source: http://www.ietf.org/rfc/rfc2396.txt).
fun UniformResourceLocator : Class ;
fun UniformResourceLocator_Class : SubClass UniformResourceLocator UniformResourceIdentifier ;

-- The term UniformResourceName (URN) 
-- refers to the subset of URI that are required to remain globally unique 
-- and persistent even when the resource ceases to exist or becomes 
-- unavailable (source: http://www.ietf.org/rfc/rfc2396.txt).
fun UniformResourceName : Class ;
fun UniformResourceName_Class : SubClass UniformResourceName UniformResourceIdentifier ;

-- The Unix epoch or point of reference is 00:00:00 UTC, 
-- January 1, 1970.
fun UnixEpoch : Ind Epoch ;


-- An established relationship between a user and a 
-- computer, network or information service. User accounts require a username and 
-- password, and new user accounts are given a default set of permissions.
fun UserAccount : Class ;
fun UserAccount_Class : SubClass UserAccount ContentBearingObject ;

-- The name a person uses to identify himself or herself 
-- when logging onto a computer system or online service.
fun UserName : Class ;
fun UserName_Class : SubClass UserName SymbolicString ;

-- A request made by a ComputerUser, such as 
-- looking up a customer record.
fun UserRequest : Class ;
fun UserRequest_Class : SubClass UserRequest ComputerProcess ;

-- A ComputerProcess which requires access to a 
-- ComputerResource.
fun UsingAResource : Class ;
fun UsingAResource_Class : SubClass UsingAResource ComputerProcess ;

-- A program that performs a specific task related to the 
-- management of computer functions, resources, or files. Utility programs range 
-- from the simple to the sophisticated, and many programmers specialize in producing 
-- and distributing them as shareware. There are utilities that perform file and 
-- directory management, data compression, disk defragmentation and repair, system 
-- diagnostics, graphics viewing, and system security, for example. Many utilities 
-- are written as memory_resident programs meant to serve as adjuncts to operating 
-- systems. Many operating systems incorporate such popular utility functions as 
-- undeleting, password protection, memory management, virus protection, and file 
-- compression.
fun Utility : Class ;
fun Utility_Class : SubClass Utility ComputerProgram ;

-- An attribute that applies to a 
-- RealtimeSystem just in case it is designed and implemented to use 
-- a utility_computing function, which is applied to competing timing 
-- requirements to determine which should be met because meeting the 
-- requirement produces higher utility as defined by the function.
fun Utility_Strictness : Class ;
fun Utility_Strictness_Class : SubClass Utility_Strictness StrictnessAttribute ;

fun abstractionLevel : El RealtimeSystem -> El AbstractionLevelAttribute -> Formula ;

-- (bandwidthOf ?NET ?BANDWIDTH) holds if 
-- ?BANDWIDTH is the amount of data which can be sent through an instance 
-- of a ComputerNetwork ?NET, measured in bits per second.
fun bandwidthOf : El ComputerNetwork -> El BitsPerSecond -> Formula ;


-- (batchInterArrival ?PATH ?TIME) 
-- holds if ?TIME is the maximum allowable time between processing of a 
-- particular element of a continuous or quasicontinuous path's data 
-- stream in successive cycles.
fun batchInterArrival : El ComputerPath -> El TimeDuration -> Formula ;


-- (batchLatency ?PATH ?TIME)holds if ?TIME 
-- is the maximum allowed latency for all cycles of a quasicontinuous path.
fun batchLatency : El ComputerPath -> El TimeDuration -> Formula ;


-- (benchmarkPerformance ?SYSTEM 
-- ?TEST ?NUMBER) holds if ?NUMBER is a benchmark for measuring the performance 
-- of an instance of a ComputationalSystem.
fun benchmarkPerformance : El ComputationalSystem -> El MonitoringProgram -> El Quantity -> Formula ;


-- (collectRate ?System ?Period) holds if ?Period is 
-- the period at which ComputationalSystem ?System collects data.
fun collectRate : El ComputationalSystem -> El TimeDuration -> Formula ;


-- (commandLineArguments ?PROGRAM 
-- ?LIST) means that the application ?PROGRAM requires command line 
-- arguments, as specified in ?LIST.
fun commandLineArguments : El ComputerProgram -> El List -> Formula ;


-- (complexity ?System ?Attribute) holds if 
-- ?Attribute is a TimingRequirementAttribute which describes the 
-- RealtimeSystem ?System.
fun complexity : El RealtimeSystem -> El TimingRequirementAttribute -> Formula ;


-- (componentDataID ?TIME ?COMPONENT ?INSTANCE 
-- ?UNIT ?NUMBER) holds if ?INSTANCE is an instance of ?COMPONENT, identified by 
-- IDNumber ?NUMBER, and whose performance is measured by a UnitOfMeasure_ComputerPerformance ?UNIT. The timestamp ?TIME identifies the time when this 
-- information was created.
fun componentDataID: El TimePosition -> Desc ComputerComponent -> El ComputerComponent -> El UnitOfMeasure -> El SymbolicString -> Formula ;


-- (computerResponseTo ?Response ?Request) means that 
-- ?Response is a ComputerResponse to the UserRequest ?Request.
fun computerResponseTo : El ComputerResponse -> El UserRequest -> Formula ;


-- (computerRunning ?Process ?Computer) 
-- means that the ComputerProcess ?Process is running on ?Computer.
fun computerRunning : El ComputerProcess -> El Computer -> Formula ;


-- (criticalityLevel ?PROGRAM ?INTEGER) 
-- holds just in case ?INTEGER indicates the relative priority of ?PROGRAM 
-- with respect to other applications within the SoftwareSystem.
fun criticalityLevel : El ComputerProgram -> El Integer -> Formula ;


-- (dataID ?PROGRAM ?NUMBER) holds if ?NUMBER is a small 
-- number associated with an instance of MonitoringProgram.
fun dataID : El MonitoringProgram -> El SymbolicString -> Formula ;


-- The data being processed during a 
-- ComputerProcess.
fun dataProcessed : El ComputerProcess -> El ComputerData -> Formula ;


-- (dataStreamSlack ?PATH ?N) means that 
-- a continuous or quasicontinuous path ?PATH should be able to process ?N 
-- additional data items at any time.
fun dataStreamSlack : El ComputerPath -> El PositiveInteger -> Formula ;


-- (defaultNetwork ?SYSTEM ?NET) holds if 
-- ?NET is the default network of the HardwareSystem ?SYSTEM.
fun defaultNetwork : El HardwareSystem -> El ComputerNetwork -> Formula ;


-- if the dependency type is StartupBlock, 
-- then (dependencyDelay ?PROGRAM ?TIME) means that the application 
-- ?PROGRAM can only be started after a dependency delay of ?TIME after the 
-- startup of the application. If the dependency type is ShutdownBlock, then 
-- (dependencyDelay ?PROGRAM ?TIME) means that the application ?PROGRAM can 
-- only be stopped after a dependency delay of ?TIME after the application 
-- is stopped.
fun dependencyDelay : El ComputerProgram -> El TimeDuration -> Formula ;


-- (dependencyType ?PROGRAM ?TYPE) means 
-- that ?PROGRAM has a dependency type ?TYPE, where ?TYPE can be either 
-- StartupBlock or ShutdownBlock.
fun dependencyType: El ComputerProgram -> Desc ComputerProgram -> Formula ;


-- (designPattern ?System ?Attribute) holds 
-- if ?Attribute is a DesignPatternAttribute which describes the 
-- RealtimeSystem ?System.
fun designPattern : El RealtimeSystem -> El DesignPatternAttribute -> Formula ;


-- (directoryOf ?FILE ?DIRECTORY) means that 
-- the ComputerFile ?FILE is in the ComputerDirectory ?DIRECTORY.
fun directoryOf : El ComputerFile -> El ComputerDirectory -> Formula ;


-- (environmentAttributes ?Program 
-- ?Attribute) holds if ?Attribute is an EnvironmentSoftwareAttribute 
-- which describes the ComputerProgram ?Program.
fun environmentAttributes : El ComputerProgram -> El EnvironmentSoftwareAttribute -> Formula ;


-- (formOfAdaptation ?System ?Attribute) 
-- holds if ?Attribute is a FormOfAdaptationAttribute which describes the 
-- RealtimeSystem ?System.
fun formOfAdaptation : El RealtimeSystem -> El FormOfAdaptationAttribute -> Formula ;


-- Granularity is a sub_property of the 
-- timing requirements property of real_time systems. Granularity is 
-- defined by how a timing requirement is specified in units of time.
fun granularity : El RealtimeSystem -> El TimeDuration -> Formula ;


-- (hardwareType ?TYPE ?COMPUTER) means that 
-- TYPE represents the computer vendor model name, as well as the version 
-- of the product.
fun hardwareType : El SymbolicString -> El Computer -> Formula ;


-- (hasAccount ?User ?Account) holds if ?User is 
-- assigned the UserAccount ?Account.
fun hasAccount : El ComputerUser -> El UserAccount -> Formula ;


-- (hasDependency ?PROGRAM1 ?PROGRAM2) 
-- holds if ?PROGRAM1 is dependent on the application ?PROGRAM2.
fun hasDependency : El ComputerProgram -> El ComputerProgram -> Formula ;


-- (heartBeatRate ?Program ?Period) holds if 
-- ?Period is the period at which the ComputerProgram ?Program sends its heartbeat 
-- to a monitoring process.
fun heartBeatRate : El ComputerProgram -> El TimeDuration -> Formula ;


-- Interference on an analog line caused by a variation 
-- of a signal from its reference timing slots. Jitter can cause problems in the receipt 
-- of data and any subsequent processing of that data.
fun hostJitter : El Computer -> El ConstantQuantity -> Formula ;


-- (hostOf ?SYSTEM ?COMPUTER) means that ?COMPUTER 
-- is the host of the computational system ?SYSTEM.
fun hostOf : El ComputationalSystem -> El Computer -> Formula ;


-- (hostStatus ?Computer ?Status) means that ?Status 
-- describes the status of the Computer, such as HostDown, HostReady.
fun hostStatus : El Computer -> El ComputerStatus -> Formula ;


-- The degree of sharpness of a displayed or printed 
-- image.
fun imageResolution : El ImageFile -> El PhysicalQuantity -> Formula ;


-- (ipAddressOf ?HOST ?ADDRESS) holds if ?ADDRESS is the IPAddress of 
-- the computer ?HOST.
fun ipAddressOf : El Computer -> El IPAddress -> Formula ;


-- In performance measurement, the current use of a 
-- system as a percentage of total capacity.
fun load : El ComputerComponent -> El ConstantQuantity -> Formula ;


-- (maximumReplications ?PROGRAM ?INTEGER) means that 
-- ?INTEGER represents the maximum number of copies of this application which can be run 
-- during a process.
fun maximumReplications : El ComputerProgram -> El PositiveInteger -> Formula ;


-- (memorySize ?System ?Size) holds if 
-- ?Size is the required memory size for the ComputationalSystem 
-- ?System.
fun memorySize : El ComputationalSystem -> El ConstantQuantity -> Formula ;


-- (minimumReplications ?PROGRAM 
-- ?INTEGER) means that ?INTEGER represents the minimum copies of the 
-- application ?PROGRAM required to be survivable, where a program is 
-- survivable if the failure of one or more resources does not result 
-- in the failure of the program. Either long MTTF for the system as a 
-- whole or short MTTR when failure occurs would improve the survivability
-- of a program.
fun minimumReplications : El ComputerProgram -> El PositiveInteger -> Formula ;


-- (monitorApplicationData ?TIME 
-- ?APPLICATION) holds if the time stamp ?TIME specifies the time at which 
-- ?APPLICATION is running.
fun monitorApplicationData : El TimePosition -> El ComputerProgram -> Formula ;


-- (monitorComponentData ?TIME ?ID 
-- ?NUMBER) holds if at time ?TIME, a component with the IDNumber ?ID 
-- has a performance of a value ?NUMBER.
fun monitorComponentData : El TimePosition -> El SymbolicString -> El RealNumber -> Formula ;


-- (monitorConnectivityData ?TIME 
-- ?IPADDRESS) is a relation between a timestamp ?TIME and an ?IP address.
fun monitorConnectivityData : El TimePosition -> El IPAddress -> Formula ;


-- (numberOfCPUs ?COMPUTER ?INTEGER) means 
-- that the number of CPUs for the host ?COMPUTER is equal to INTEGER.
fun numberOfCPUs : El Computer -> El PositiveInteger -> Formula ;


-- (password ?Password ?User) means that ?Password is 
-- the password the ComputerUser uses while logging onto a computer system.
fun password : El ComputerUser -> El ComputerPassword -> Formula ;


-- (performanceResult ?EVENT ?COMPONENT 
-- ?NUMBER) holds if the performance of ?COMPONENT has a value ?NUMBER, 
-- measured by ?EVENT, an instance of MeasuringPerformance.
fun performanceResult : El MeasuringPerformance -> El ComputerComponent -> El RealNumber -> Formula ;


-- (portNumber ?PROGRAM ?NUMBER) holds if ?NUMBER identifies a protocol 
-- port, i.e. a TCP_IP software abstraction used to distinguish different applications providing 
-- services within a single destination computer. The different ports on a host are identified by a 
-- positive 16_bit number.
fun portNumber : El ComputerProgram -> El PositiveInteger -> Formula ;


-- (priority ?SYSTEM ?QUANTITY) means that the 
-- priority of the ?SYSTEM is characterized by a PriorityAttribute, such 
-- as HighPriority or LowPriority.
fun priority : El ComputationalSystem -> El PriorityAttribute -> Formula ;


-- (processAborted ?Abort ?Process) means 
-- that the ComputerProcess ?Process is aborted as the result of ?Abort.
fun processAborted : El Abort -> El ComputerProcess -> Formula ;


-- (processID ?PROCESS ?NUMBER) holds if ?NUMBER is a unique number 
-- generated by the operating system and used to refer to the ComputerProcess ?PROCESS. There 
-- is usually no significance to the numbers as they are reused as old processes die and new processes 
-- are created.
fun processID : El ComputerProcess -> El PositiveInteger -> Formula ;


-- The arguments of this relation are data 
-- structures, each of which contains the information necessary for the 
-- process already loaded by the operating system to execute on a processor.
fun processList : [El Entity] -> Formula ;


-- (productModel ?Model ?Product) means that 
-- ?Model represents the type of the Product ?Product
fun productModel : El SymbolicString -> El Product -> Formula ;


-- (programCopy ?File ?Program) means that 
-- the ComputerFile ?File is one of the copies of the ComputerProgram 
-- ?Program.
fun programCopy : El ComputerFile -> El ComputerProgram -> Formula ;


-- (programRunning ?Process ?Program) 
-- means that the ComputerProcess ?Process is executing the 
-- ComputerProgram ?Program.
fun programRunning : El ComputerProcess -> El ComputerProgram -> Formula ;


-- (qoSSlack ?PATH ?MIN ?MAX) holds if ?PATH 
-- has a realtime QoS maximum slack percentage of ?MAX and minimum of 
-- ?MIN.
fun qoSSlack : El ComputerPath -> El ConstantQuantity -> El ConstantQuantity -> Formula ;


-- (rMProgram_of ?RM ?SYSTEM) means that 
-- ?RM is the resource management program of the SoftwareSystem ?SYSTEM.
fun rMProgram_of : El ResourceManagementProgram -> El SoftwareSystem -> Formula ;


-- (requestRate ?Request ?Period) means that 
-- ?Period is the period at which the user sends its ?Request.
fun requestRate : El UserRequest -> El TimeDuration -> Formula ;


-- (resourceUsed ?Process ?Resource) means that the 
-- ComputerProcess ?Process has access to the ComputerResource ?Resource.
fun resourceUsed : El ComputerProcess -> El ComputerResource -> Formula ;


-- (responseRate ?Response ?Period) means 
-- that ?Period is the period at which the computer sends its ?Response.
fun responseRate : El ComputerResponse -> El TimeDuration -> Formula ;


-- The time it takes for the computer to comply 
-- with a user's request, such as looking up a customer record.
fun responseTime : El UserRequest -> El TimeDuration -> Formula ;


-- (runningOn ?Program ?Computer) holds if the 
-- ComputerProgram ?Program is being executed on ?Computer.
fun runningOn : El ComputerProgram -> El Computer -> Formula ;


-- (runsOn ?Program ?Computer) means that ?Program 
-- is capable of running on ?Computer.
fun runsOn : El ComputerProgram -> El Computer -> Formula ;


-- (sendRate ?Program ?Period) holds if ?Period is the 
-- period at which the ComputationalSystem ?System sends data reports.
fun sendRate : El ComputationalSystem -> El TimeDuration -> Formula ;


-- (settlingTime ?PROGRAM ?TIME) says that 
-- ?TIME represents seconds to delay after an action was taken with respect 
-- to QoS.
fun settlingTime : El ComputerProgram -> El TimeDuration -> Formula ;


-- (shutdownOf ?SHUTDOWN ?PROGRAM) holds just 
-- in case an instance of ShutdownBlock ?SHUTDOWN specifies a set of 
-- instructions to end ?PROGRAM.
fun shutdownOf : El ShutdownBlock -> El ComputerProgram -> Formula ;


-- (simpleDeadline ?PATH ?TIME)holds if 
-- ?TIME is the maximum end_to_end path latency during a cycle of a 
-- continuous or quasicontinuous path or during the activation of a transient 
-- path.
fun simpleDeadline : El ComputerPath -> El TimeDuration -> Formula ;


-- (slidingWindowSize ?PATH ?N) holds 
-- if PATH has a realtime QoS sliding window size of ?N measured samples.
fun slidingWindowSize : El ComputerPath -> El PositiveInteger -> Formula ;


-- (softwarePath ?SYSTEM ?PATH) means that 
-- ?PATH is a computer path for the instance of SoftwareSystem ?SYSTEM.
fun softwarePath : El SoftwareSystem -> El ComputerPath -> Formula ;


-- (standardErrorDevice ?PROGRAM 
-- ?DEVICE) holds just in case the DEVICE is the predefined error channel
-- with which the running version of this program is initialised.
fun standardErrorDevice : El ComputerProcess -> El ComputerOutputDevice -> Formula ;


-- (standardInputDevice ?PROCESS 
-- ?DEVICE) holds just in case the DEVICE is the predefined input channel
-- with which the running version of the program PROCESS is initialised.
fun standardInputDevice : El ComputerProcess -> El ComputerInputDevice -> Formula ;


-- (standardOutputDevice ?PROGRAM 
-- ?DEVICE) holds just in case the DEVICE is the predefined output channel 
-- with which the running version of this program is initialised.
fun standardOutputDevice : El ComputerProcess -> El ComputerOutputDevice -> Formula ;


-- (startupOf ?STARTUP ?PROGRAM) holds just in 
-- case an instance of StartupBlock ?STARTUP specifies a set of instructions 
-- to start the ?PROGRAM.
fun startupOf : El StartupBlock -> El ComputerProgram -> Formula ;


-- (startupTimeDelay ?PROGRAM ?TIME) 
-- says that ?TIME is the time to delay after the previous application 
-- was started before starting the application ?PROGRAM.
fun startupTimeDelay : El ComputerProgram -> El TimeDuration -> Formula ;


-- (stateOfProcess ?PROCESS ?STATE) says 
-- that ?STATE is a state of the ComputerProcess ?PROCESS.
fun stateOfProcess : El ComputerProcess -> El ProcessState -> Formula ;


-- (status ?PROCESS ?STATUS) holds if ?STATUS is the current status of ?PROCESS.
fun status : El ComputerProcess -> El ProcessStatus -> Formula ;


-- (strictness ?System ?Attribute) holds if 
-- the StrictnessAttribute ?Attribute describes the RealtimeSystem 
-- ?System.
fun strictness : El RealtimeSystem -> El StrictnessAttribute -> Formula ;


-- (systemBehavior ?System ?Attribute) 
-- holds if ?Attribute is a SystemBehaviorAttribute which describes the 
-- RealtimeSystem ?System.
fun systemBehavior : El RealtimeSystem -> El SystemBehaviorAttribute -> Formula ;


-- (systemMeasured ?Event ?System) means that 
-- ?Event is an event of measuring the performance of the ComputationalSystem 
-- ?System.
fun systemMeasured : El MeasuringPerformance -> El ComputationalSystem -> Formula ;


-- (task ?Process ?Task) means that ?Task is a function to 
-- be performed by the ComputerProcess ?Process.
fun task : El ComputerProcess -> El ProcessTask -> Formula ;


-- (taskRelation ?System ?Attribute) holds 
-- if ?Attribute is a TaskRelationAttribute which describes the 
-- RealtimeSystem ?System.
fun taskRelation : El RealtimeSystem -> El TaskRelationAttribute -> Formula ;


fun thresholdOf : El Computer -> El PositiveRealNumber -> Formula ;

-- (unitMeasuringPerformance ?COMPONENT 
-- ?UNIT) holds in case ?UNIT is an instance of UnitOfMeasure which is used to 
-- measure the performance of ?COMPONENT.
fun unitMeasuringPerformance : El ComputerComponent -> El UnitOfMeasure -> Formula ;


-- (userName ?Name ?User) means that ?Name is the name 
-- the ComputerUser uses to identify himself or herself when logging onto a 
-- computer system.
fun userName : El ComputerUser -> El UserName -> Formula ;
}
