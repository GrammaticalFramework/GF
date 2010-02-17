fof(axQoSLem0, axiom, 
 ( ! [Var_HARDWARE] : 
 (hasType(type_ComputerHardware, Var_HARDWARE) => 
(( ? [Var_COMPUTER] : 
 (hasType(type_Computer, Var_COMPUTER) &  
(f_component(Var_HARDWARE,Var_COMPUTER)))))))).

fof(axQoSLem1, axiom, 
 ( ! [Var_TRANSFER] : 
 (hasType(type_DataTransfer, Var_TRANSFER) => 
(( ? [Var_ORIGIN] : 
 (hasType(type_HardwareSystem, Var_ORIGIN) &  
(( ? [Var_DESTINATION] : 
 (hasType(type_ComputationalSystem, Var_DESTINATION) &  
(( ? [Var_SYSTEM] : 
 (hasType(type_HardwareSystem, Var_SYSTEM) &  
(( ? [Var_DATA] : 
 (hasType(type_ComputerData, Var_DATA) &  
(((f_origin(Var_TRANSFER,Var_ORIGIN)) & (((f_destination(Var_TRANSFER,Var_DESTINATION)) & (((f_instrument(Var_TRANSFER,Var_SYSTEM)) & (f_patient(Var_TRANSFER,Var_DATA))))))))))))))))))))))).

fof(axQoSLem2, axiom, 
 ( ! [Var_PROCESS] : 
 (hasType(type_ComputerProcess, Var_PROCESS) => 
(( ? [Var_COMPUTER] : 
 (hasType(type_Computer, Var_COMPUTER) &  
(( ? [Var_PROGRAM] : 
 (hasType(type_ComputerProgram, Var_PROGRAM) &  
(((f_computerRunning(Var_PROCESS,Var_COMPUTER)) & (f_programRunning(Var_PROCESS,Var_PROGRAM))))))))))))).

fof(axQoSLem3, axiom, 
 ( ! [Var_PROGRAM] : 
 (hasType(type_ComputerProgram, Var_PROGRAM) => 
(( ! [Var_PROCESS] : 
 (hasType(type_ComputerProcess, Var_PROCESS) => 
(((f_programRunning(Var_PROCESS,Var_PROGRAM)) => (( ? [Var_COMPUTER] : 
 (hasType(type_Computer, Var_COMPUTER) &  
(f_runningOn(Var_PROGRAM,Var_COMPUTER))))))))))))).

fof(axQoSLem4, axiom, 
 ( ! [Var_COMPUTER] : 
 (hasType(type_Computer, Var_COMPUTER) => 
(( ! [Var_PROGRAM] : 
 (hasType(type_ComputerProgram, Var_PROGRAM) => 
(((f_runningOn(Var_PROGRAM,Var_COMPUTER)) => (( ? [Var_PROCESS] : 
 (hasType(type_ComputerProcess, Var_PROCESS) &  
(((f_programRunning(Var_PROCESS,Var_PROGRAM)) & (f_computerRunning(Var_PROCESS,Var_COMPUTER))))))))))))))).

fof(axQoSLem5, axiom, 
 ( ! [Var_DIRECTORY] : 
 (hasType(type_ComputerDirectory, Var_DIRECTORY) => 
(( ! [Var_FILE] : 
 (hasType(type_ComputerFile, Var_FILE) => 
(((f_directoryOf(Var_FILE,Var_DIRECTORY)) => (f_refers(f_AddressFn(Var_FILE),Var_DIRECTORY)))))))))).

fof(axQoSLem6, axiom, 
 ( ! [Var_SOFTWARE] : 
 (hasType(type_SoftwareSystem, Var_SOFTWARE) => 
(( ! [Var_PROCESS] : 
 (hasType(type_ComputerProcess, Var_PROCESS) => 
(((f_programRunning(Var_PROCESS,Var_SOFTWARE)) => (( ? [Var_HARDWARE] : 
 (hasType(type_HardwareSystem, Var_HARDWARE) &  
(f_computerRunning(Var_PROCESS,Var_HARDWARE))))))))))))).

fof(axQoSLem7, axiom, 
 ( ! [Var_SYSTEM] : 
 (hasType(type_HardwareSystem, Var_SYSTEM) => 
(( ? [Var_PROCESSOR] : 
 (hasType(type_CPU, Var_PROCESSOR) &  
(( ? [Var_MEMORY] : 
 (hasType(type_ComputerMemory, Var_MEMORY) &  
(( ? [Var_NETWORK] : 
 (hasType(type_ComputerNetwork, Var_NETWORK) &  
(((f_component(Var_SYSTEM,Var_PROCESSOR)) & (((f_component(Var_SYSTEM,Var_MEMORY)) & (f_component(Var_SYSTEM,Var_NETWORK)))))))))))))))))).

fof(axQoSLem8, axiom, 
 ( ! [Var_COMPUTER] : 
 (hasType(type_Computer, Var_COMPUTER) => 
(( ! [Var_PROGRAM] : 
 (hasType(type_ComputerProgram, Var_PROGRAM) => 
(((( ? [Var_PROCESS] : 
 (hasType(type_ComputerProcess, Var_PROCESS) &  
(((f_programRunning(Var_PROCESS,Var_PROGRAM)) & (f_computerRunning(Var_PROCESS,Var_COMPUTER))))))) => (f_runsOn(Var_PROGRAM,Var_COMPUTER)))))))))).

fof(axQoSLem9, axiom, 
 ( ! [Var_STARTUP] : 
 (hasType(type_StartupBlock, Var_STARTUP) => 
(( ? [Var_APPLICATION] : 
 (hasType(type_ComputerProgram, Var_APPLICATION) &  
(f_startupOf(Var_STARTUP,Var_APPLICATION)))))))).

fof(axQoSLem10, axiom, 
 ( ! [Var_PROCESS1] : 
 (hasType(type_ComputerProcess, Var_PROCESS1) => 
(( ! [Var_TIME1] : 
 ((hasType(type_Entity, Var_TIME1) & hasType(type_TimeInterval, Var_TIME1)) => 
(( ! [Var_APPLICATION] : 
 (hasType(type_ComputerProgram, Var_APPLICATION) => 
(( ! [Var_STARTUP] : 
 ((hasType(type_StartupBlock, Var_STARTUP) & hasType(type_ComputerProgram, Var_STARTUP)) => 
(((((f_startupOf(Var_STARTUP,Var_APPLICATION)) & (((f_programRunning(Var_PROCESS1,Var_STARTUP)) & (f_WhenFn(Var_PROCESS1) = Var_TIME1))))) => (( ? [Var_PROCESS2] : 
 (hasType(type_ComputerProcess, Var_PROCESS2) &  
(( ? [Var_TIME2] : 
 ((hasType(type_Entity, Var_TIME2) & hasType(type_TimeInterval, Var_TIME2)) &  
(((f_programRunning(Var_PROCESS2,Var_APPLICATION)) & (((f_WhenFn(Var_PROCESS2) = Var_TIME2) & (f_meetsTemporally(Var_TIME1,Var_TIME2)))))))))))))))))))))))))).

fof(axQoSLem11, axiom, 
 ( ! [Var_SHUTDOWN] : 
 (hasType(type_ShutdownBlock, Var_SHUTDOWN) => 
(( ? [Var_APPLICATION] : 
 (hasType(type_ComputerProgram, Var_APPLICATION) &  
(f_shutdownOf(Var_SHUTDOWN,Var_APPLICATION)))))))).

fof(axQoSLem12, axiom, 
 ( ! [Var_PROCESS1] : 
 (hasType(type_ComputerProcess, Var_PROCESS1) => 
(( ! [Var_TIME1] : 
 ((hasType(type_Entity, Var_TIME1) & hasType(type_TimeInterval, Var_TIME1)) => 
(( ! [Var_APPLICATION] : 
 (hasType(type_ComputerProgram, Var_APPLICATION) => 
(( ! [Var_SHUTDOWN] : 
 ((hasType(type_ShutdownBlock, Var_SHUTDOWN) & hasType(type_ComputerProgram, Var_SHUTDOWN)) => 
(((((f_shutdownOf(Var_SHUTDOWN,Var_APPLICATION)) & (((f_programRunning(Var_PROCESS1,Var_SHUTDOWN)) & (f_WhenFn(Var_PROCESS1) = Var_TIME1))))) => (( ? [Var_PROCESS2] : 
 (hasType(type_ComputerProcess, Var_PROCESS2) &  
(( ? [Var_TIME2] : 
 ((hasType(type_Entity, Var_TIME2) & hasType(type_TimeInterval, Var_TIME2)) &  
(((f_programRunning(Var_PROCESS2,Var_APPLICATION)) & (((f_WhenFn(Var_PROCESS2) = Var_TIME2) & (f_meetsTemporally(Var_TIME2,Var_TIME1)))))))))))))))))))))))))).

fof(axQoSLem13, axiom, 
 ( ! [Var_PROGRAM] : 
 (hasType(type_ComputerProgram, Var_PROGRAM) => 
(( ! [Var_PROCESS] : 
 (hasType(type_ComputerProcess, Var_PROCESS) => 
(((f_programRunning(Var_PROCESS,Var_PROGRAM)) => (( ? [Var_DEVICE] : 
 (hasType(type_ComputerInputDevice, Var_DEVICE) &  
(f_standardInputDevice(Var_PROCESS,Var_DEVICE))))))))))))).

fof(axQoSLem14, axiom, 
 ( ! [Var_PROGRAM] : 
 (hasType(type_ComputerProgram, Var_PROGRAM) => 
(( ! [Var_PROCESS] : 
 (hasType(type_ComputerProcess, Var_PROCESS) => 
(((f_programRunning(Var_PROCESS,Var_PROGRAM)) => (( ? [Var_DEVICE] : 
 (hasType(type_ComputerOutputDevice, Var_DEVICE) &  
(f_standardOutputDevice(Var_PROCESS,Var_DEVICE))))))))))))).

fof(axQoSLem15, axiom, 
 ( ! [Var_PROGRAM] : 
 (hasType(type_ComputerProgram, Var_PROGRAM) => 
(( ! [Var_PROCESS] : 
 (hasType(type_ComputerProcess, Var_PROCESS) => 
(((f_programRunning(Var_PROCESS,Var_PROGRAM)) => (( ? [Var_DEVICE] : 
 (hasType(type_ComputerOutputDevice, Var_DEVICE) &  
(f_standardErrorDevice(Var_PROCESS,Var_DEVICE))))))))))))).

fof(axQoSLem16, axiom, 
 ( ! [Var_STATE] : 
 (hasType(type_ProcessState, Var_STATE) => 
(( ? [Var_PROGRAM] : 
 (hasType(type_ComputerProgram, Var_PROGRAM) &  
(( ! [Var_PROCESS] : 
 ((hasType(type_ComputerProcess, Var_PROCESS) & hasType(type_Entity, Var_PROCESS)) => 
(((f_programRunning(Var_PROCESS,Var_PROGRAM)) => (f_represents(Var_STATE,Var_PROCESS))))))))))))).

fof(axQoSLem17, axiom, 
 ( ! [Var_APPLICATION] : 
 (hasType(type_AutomaticApplication, Var_APPLICATION) => 
(( ! [Var_SYSTEM] : 
 (hasType(type_SoftwareSystem, Var_SYSTEM) => 
(((f_part(Var_APPLICATION,Var_SYSTEM)) => (f_part(f_StartupFn(Var_APPLICATION),f_StartupFn(Var_SYSTEM))))))))))).

fof(axQoSLem18, axiom, 
 ( ! [Var_RM] : 
 (hasType(type_RM_StartApplication, Var_RM) => 
(( ? [Var_APPLICATION] : 
 (hasType(type_ComputerProgram, Var_APPLICATION) &  
(( ? [Var_RMCOPY] : 
 ((hasType(type_ComputerFile, Var_RMCOPY) & hasType(type_Agent, Var_RMCOPY)) &  
(( ? [Var_PROCESS] : 
 ((hasType(type_ComputerProcess, Var_PROCESS) & hasType(type_Process, Var_PROCESS)) &  
(((f_programCopy(Var_RMCOPY,Var_RM)) & (((f_programRunning(Var_PROCESS,f_StartupFn(Var_APPLICATION))) & (f_agent(Var_PROCESS,Var_RMCOPY)))))))))))))))))).

fof(axQoSLem19, axiom, 
 ( ! [Var_SYSTEM] : 
 ((hasType(type_SoftwareSystem, Var_SYSTEM) & hasType(type_Object, Var_SYSTEM)) => 
(( ! [Var_RM] : 
 ((hasType(type_ResourceManagementProgram, Var_RM) & hasType(type_ComputerProgram, Var_RM)) => 
(((f_rMProgram_of(Var_RM,Var_SYSTEM)) => (( ? [Var_RMCOPY] : 
 ((hasType(type_ComputerFile, Var_RMCOPY) & hasType(type_Agent, Var_RMCOPY)) &  
(( ? [Var_PROCESS] : 
 ((hasType(type_ComputerProcess, Var_PROCESS) & hasType(type_Process, Var_PROCESS)) &  
(( ? [Var_APPLICATION] : 
 ((hasType(type_Object, Var_APPLICATION) & hasType(type_ComputerProgram, Var_APPLICATION)) &  
(((f_part(Var_APPLICATION,Var_SYSTEM)) & (((f_programCopy(Var_RMCOPY,Var_RM)) & (((f_programRunning(Var_PROCESS,Var_APPLICATION)) & (f_agent(Var_PROCESS,Var_RMCOPY))))))))))))))))))))))))).

fof(axQoSLem20, axiom, 
 ( ! [Var_PROCESS1] : 
 (hasType(type_ComputerProcess, Var_PROCESS1) => 
(( ! [Var_PROCESS2] : 
 (hasType(type_ComputerProcess, Var_PROCESS2) => 
(( ! [Var_TIME] : 
 ((hasType(type_TimeInterval, Var_TIME) & hasType(type_Object, Var_TIME)) => 
(( ! [Var_TIME2] : 
 ((hasType(type_Entity, Var_TIME2) & hasType(type_TimeInterval, Var_TIME2)) => 
(( ! [Var_TIME1] : 
 ((hasType(type_Entity, Var_TIME1) & hasType(type_TimeInterval, Var_TIME1)) => 
(( ! [Var_DELAY] : 
 ((hasType(type_TimeDuration, Var_DELAY) & hasType(type_PhysicalQuantity, Var_DELAY)) => 
(( ! [Var_APPLICATION] : 
 (hasType(type_ComputerProgram, Var_APPLICATION) => 
(((((f_startupTimeDelay(Var_APPLICATION,Var_DELAY)) & (((f_programRunning(Var_PROCESS1,Var_APPLICATION)) & (((f_WhenFn(Var_PROCESS1) = Var_TIME1) & (((f_WhenFn(Var_PROCESS2) = Var_TIME2) & (((f_meetsTemporally(Var_TIME1,Var_TIME)) & (f_meetsTemporally(Var_TIME,Var_TIME2)))))))))))) => (f_measure(Var_TIME,Var_DELAY))))))))))))))))))))))))).

fof(axQoSLem21, axiom, 
 ( ! [Var_FEEDBACK] : 
 (hasType(type_Feedback, Var_FEEDBACK) => 
(( ! [Var_SEND] : 
 (hasType(type_DataTransfer, Var_SEND) => 
(( ? [Var_PROGRAM] : 
 ((hasType(type_SoftwareSystem, Var_PROGRAM) & hasType(type_ComputerProgram, Var_PROGRAM)) &  
(( ? [Var_PROCESS] : 
 (hasType(type_ComputerProcess, Var_PROCESS) &  
(( ? [Var_RM] : 
 ((hasType(type_ResourceManagementProgram, Var_RM) & hasType(type_Entity, Var_RM)) &  
(((f_rMProgram_of(Var_RM,Var_PROGRAM)) & (((f_programRunning(Var_PROCESS,Var_PROGRAM)) & (((f_patient(Var_SEND,Var_FEEDBACK)) & (f_destination(Var_SEND,Var_RM))))))))))))))))))))))).

fof(axQoSLem22, axiom, 
 ( ! [Var_COMPONENT] : 
 (hasType(type_ComputerComponent, Var_COMPONENT) => 
(( ? [Var_UNIT] : 
 (hasType(type_UnitOfMeasure, Var_UNIT) &  
(f_unitMeasuringPerformance(Var_COMPONENT,Var_UNIT)))))))).

fof(axQoSLem23, axiom, 
 ( ! [Var_NA] : 
 (hasType(type_NetworkAdapter, Var_NA) => 
(( ? [Var_NET] : 
 (hasType(type_ComputerNetwork, Var_NET) &  
(f_connected(Var_NA,Var_NET)))))))).

fof(axQoSLem24, axiom, 
 ( ! [Var_NA] : 
 (hasType(type_NetworkAdapter, Var_NA) => 
(f_unitMeasuringPerformance(Var_NA,inst_PacketsPerSecond))))).

fof(axQoSLem25, axiom, 
 ( ! [Var_MONITOR] : 
 (hasType(type_MonitoringProgram, Var_MONITOR) => 
(( ? [Var_MONITORCOPY] : 
 ((hasType(type_ComputerFile, Var_MONITORCOPY) & hasType(type_Agent, Var_MONITORCOPY)) &  
(( ? [Var_EVENT] : 
 ((hasType(type_MeasuringPerformance, Var_EVENT) & hasType(type_Process, Var_EVENT)) &  
(( ? [Var_SYSTEM] : 
 (hasType(type_ComputationalSystem, Var_SYSTEM) &  
(((f_systemMeasured(Var_EVENT,Var_SYSTEM)) & (((f_programCopy(Var_MONITORCOPY,Var_MONITOR)) & (f_agent(Var_EVENT,Var_MONITORCOPY)))))))))))))))))).

fof(axQoSLem26, axiom, 
 ( ! [Var_EVENT] : 
 (hasType(type_MeasuringPerformance, Var_EVENT) => 
(( ? [Var_PROGRAM] : 
 (hasType(type_MonitoringProgram, Var_PROGRAM) &  
(( ? [Var_COPY] : 
 ((hasType(type_ComputerFile, Var_COPY) & hasType(type_Agent, Var_COPY)) &  
(((f_programCopy(Var_COPY,Var_PROGRAM)) & (f_agent(Var_EVENT,Var_COPY))))))))))))).

fof(axQoSLem27, axiom, 
 ( ! [Var_APPLICATION] : 
 (hasType(type_ComputerProgram, Var_APPLICATION) => 
(( ! [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) => 
(((f_monitorApplicationData(Var_TIME,Var_APPLICATION)) => (( ? [Var_PROCESS] : 
 ((hasType(type_ComputerProcess, Var_PROCESS) & hasType(type_Physical, Var_PROCESS)) &  
(((f_programRunning(Var_PROCESS,Var_APPLICATION)) & (f_time(Var_PROCESS,Var_TIME))))))))))))))).

fof(axQoSLem28, axiom, 
 ( ! [Var_PROGRAM] : 
 ((hasType(type_ComputerProgram, Var_PROGRAM) & hasType(type_Entity, Var_PROGRAM)) => 
(((( ? [Var_PROCESS] : 
 (hasType(type_ComputerProcess, Var_PROCESS) &  
(f_programRunning(Var_PROCESS,Var_PROGRAM))))) <=> (f_property(Var_PROGRAM,inst_Executable))))))).

fof(axQoSLem29, axiom, 
 ( ! [Var_MODEL] : 
 ((hasType(type_SymbolicString, Var_MODEL) & hasType(type_ContentBearingObject, Var_MODEL)) => 
(( ! [Var_COMPUTER] : 
 ((hasType(type_Computer, Var_COMPUTER) & hasType(type_Product, Var_COMPUTER)) => 
(( ! [Var_TYPE] : 
 ((hasType(type_SymbolicString, Var_TYPE) & hasType(type_ContentBearingObject, Var_TYPE)) => 
(((((f_hardwareType(Var_TYPE,Var_COMPUTER)) & (f_productModel(Var_MODEL,Var_COMPUTER)))) => (f_subsumesContentInstance(Var_TYPE,Var_MODEL))))))))))))).

fof(axQoSLem30, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Quantity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER)) => 
(( ! [Var_TEST] : 
 (hasType(type_MonitoringProgram, Var_TEST) => 
(( ! [Var_SYSTEM] : 
 ((hasType(type_ComputationalSystem, Var_SYSTEM) & hasType(type_ComputerComponent, Var_SYSTEM)) => 
(((f_benchmarkPerformance(Var_SYSTEM,Var_TEST,Var_NUMBER)) => (( ? [Var_EVENT] : 
 (hasType(type_MeasuringPerformance, Var_EVENT) &  
(f_performanceResult(Var_EVENT,Var_SYSTEM,Var_NUMBER)))))))))))))))).

fof(axQoSLem31, axiom, 
 ( ! [Var_ATTRIBUTE] : 
 (hasType(type_ComputerPathAttribute, Var_ATTRIBUTE) => 
(( ? [Var_PATH] : 
 (hasType(type_ComputerPath, Var_PATH) &  
(f_property(Var_PATH,Var_ATTRIBUTE)))))))).

fof(axQoSLem32, axiom, 
 ( ! [Var_PROCESS1] : 
 (hasType(type_ComputerProcess, Var_PROCESS1) => 
(( ! [Var_PROCESS2] : 
 (hasType(type_ComputerProcess, Var_PROCESS2) => 
(( ! [Var_TIME] : 
 (hasType(type_TimeInterval, Var_TIME) => 
(( ! [Var_PROGRAM2] : 
 (hasType(type_ComputerProgram, Var_PROGRAM2) => 
(( ! [Var_DELAY] : 
 (hasType(type_TimeDuration, Var_DELAY) => 
(( ! [Var_PROGRAM1] : 
 (hasType(type_ComputerProgram, Var_PROGRAM1) => 
(((( ? [Var_TIME2] : 
 ((hasType(type_Entity, Var_TIME2) & hasType(type_TimeInterval, Var_TIME2)) &  
(( ? [Var_TIME1] : 
 ((hasType(type_Entity, Var_TIME1) & hasType(type_TimeInterval, Var_TIME1)) &  
(((f_dependencyDelay(Var_PROGRAM1,Var_DELAY)) & (((f_dependencyType(Var_PROGRAM1,type_StartupBlock)) & (((f_hasDependency(Var_PROGRAM1,Var_PROGRAM2)) & (((f_programRunning(Var_PROCESS1,Var_PROGRAM1)) & (((f_programRunning(Var_PROCESS2,Var_PROGRAM2)) & (((f_WhenFn(Var_PROCESS2) = Var_TIME2) & (((f_starts(Var_TIME2,Var_TIME)) & (((f_WhenFn(Var_PROCESS1) = Var_TIME1) & (f_EndFn(Var_TIME) = f_BeginFn(Var_TIME1)))))))))))))))))))))))) => (f_duration(Var_TIME,Var_DELAY)))))))))))))))))))))).

fof(axQoSLem33, axiom, 
 ( ! [Var_PROCESS1] : 
 (hasType(type_ComputerProcess, Var_PROCESS1) => 
(( ! [Var_PROCESS2] : 
 (hasType(type_ComputerProcess, Var_PROCESS2) => 
(( ! [Var_TIME] : 
 (hasType(type_TimeInterval, Var_TIME) => 
(( ! [Var_PROGRAM2] : 
 (hasType(type_ComputerProgram, Var_PROGRAM2) => 
(( ! [Var_DELAY] : 
 (hasType(type_TimeDuration, Var_DELAY) => 
(( ! [Var_PROGRAM1] : 
 (hasType(type_ComputerProgram, Var_PROGRAM1) => 
(((( ? [Var_TIME2] : 
 ((hasType(type_Entity, Var_TIME2) & hasType(type_TimeInterval, Var_TIME2)) &  
(( ? [Var_TIME1] : 
 (hasType(type_TimeInterval, Var_TIME1) &  
(((f_dependencyDelay(Var_PROGRAM1,Var_DELAY)) & (((f_dependencyType(Var_PROGRAM1,type_ShutdownBlock)) & (((f_hasDependency(Var_PROGRAM1,Var_PROGRAM2)) & (((f_programRunning(Var_PROCESS1,Var_PROGRAM1)) & (((f_programRunning(Var_PROCESS2,Var_PROGRAM2)) & (((f_WhenFn(Var_PROCESS2) = Var_TIME2) & (((f_finishes(Var_TIME,Var_TIME1)) & (((f_WhenFn(Var_PROCESS2) = Var_TIME2) & (f_BeginFn(Var_TIME) = f_EndFn(Var_TIME2)))))))))))))))))))))))) => (f_duration(Var_TIME,Var_DELAY)))))))))))))))))))))).

fof(axQoSLem34, axiom, 
 ( ! [Var_PROGRAM] : 
 (hasType(type_Entity, Var_PROGRAM) => 
(((f_property(Var_PROGRAM,inst_ReplicationsOnSameHostOK)) => (f_property(Var_PROGRAM,inst_Restartable))))))).

fof(axQoSLem35, axiom, 
 ( ! [Var_URI] : 
 (hasType(type_UniformResourceIdentifier, Var_URI) => 
(( ? [Var_RESOURCE] : 
 (hasType(type_ComputerData, Var_RESOURCE) &  
(f_refers(Var_URI,Var_RESOURCE)))))))).

fof(axQoSLem36, axiom, 
 ( ! [Var_URL] : 
 (hasType(type_UniformResourceLocator, Var_URL) => 
(( ? [Var_ADDRESS] : 
 (hasType(type_IPAddress, Var_ADDRESS) &  
(f_represents(Var_URL,Var_ADDRESS)))))))).

fof(axQoSLem37, axiom, 
 ( ! [Var_SINK] : 
 (hasType(type_DataSink, Var_SINK) => 
(( ? [Var_TRANSFER] : 
 (hasType(type_DataTransfer, Var_TRANSFER) &  
(f_destination(Var_TRANSFER,Var_SINK)))))))).

fof(axQoSLem38, axiom, 
 ( ! [Var_USER] : 
 (hasType(type_ComputerUser, Var_USER) => 
(( ? [Var_COMPUTER] : 
 (hasType(type_Computer, Var_COMPUTER) &  
(f_uses(Var_USER,Var_COMPUTER)))))))).

fof(axQoSLem39, axiom, 
 ( ! [Var_REQUEST] : 
 (hasType(type_UserRequest, Var_REQUEST) => 
(( ? [Var_USER] : 
 (hasType(type_ComputerUser, Var_USER) &  
(f_agent(Var_REQUEST,Var_USER)))))))).

fof(axQoSLem40, axiom, 
 ( ! [Var_RESPONSE] : 
 ((hasType(type_ComputerResponse, Var_RESPONSE) & hasType(type_Physical, Var_RESPONSE)) => 
(( ! [Var_TIME] : 
 (hasType(type_TimeDuration, Var_TIME) => 
(( ! [Var_REQUEST] : 
 (hasType(type_UserRequest, Var_REQUEST) => 
(((((f_responseTime(Var_REQUEST,Var_TIME)) & (f_computerResponseTo(Var_RESPONSE,Var_REQUEST)))) => (f_duration(f_WhenFn(Var_RESPONSE),Var_TIME))))))))))))).

fof(axQoSLem41, axiom, 
 ( ! [Var_PROCESS] : 
 (hasType(type_Multitasking, Var_PROCESS) => 
(( ? [Var_PROGRAM2] : 
 ((hasType(type_ComputerProgram, Var_PROGRAM2) & hasType(type_Entity, Var_PROGRAM2)) &  
(( ? [Var_PROGRAM1] : 
 ((hasType(type_ComputerProgram, Var_PROGRAM1) & hasType(type_Entity, Var_PROGRAM1)) &  
(((f_programRunning(Var_PROCESS,Var_PROGRAM1)) & (((f_programRunning(Var_PROCESS,Var_PROGRAM2)) & (Var_PROGRAM1 != Var_PROGRAM2)))))))))))))).

fof(axQoSLem42, axiom, 
 ( ! [Var_TASK] : 
 (hasType(type_ComputerTask, Var_TASK) => 
(( ? [Var_PROCESS] : 
 (hasType(type_Multitasking, Var_PROCESS) &  
(( ? [Var_PROGRAM] : 
 (hasType(type_ComputerProgram, Var_PROGRAM) &  
(((f_part(Var_TASK,Var_PROCESS)) & (f_programRunning(Var_TASK,Var_PROGRAM))))))))))))).

fof(axQoSLem43, axiom, 
 ( ! [Var_RESOURCE] : 
 (hasType(type_ComputerResource, Var_RESOURCE) => 
(( ? [Var_SYSTEM] : 
 (hasType(type_ComputationalSystem, Var_SYSTEM) &  
(f_part(Var_RESOURCE,Var_SYSTEM)))))))).

fof(axQoSLem44, axiom, 
 ( ! [Var_LOAD] : 
 ((hasType(type_ConstantQuantity, Var_LOAD) & hasType(type_RealNumber, Var_LOAD)) => 
(( ! [Var_SYSTEM] : 
 (hasType(type_ComputerComponent, Var_SYSTEM) => 
(((f_load(Var_SYSTEM,Var_LOAD)) => (( ? [Var_EVENT] : 
 (hasType(type_MeasuringPerformance, Var_EVENT) &  
(f_performanceResult(Var_EVENT,Var_SYSTEM,Var_LOAD))))))))))))).

fof(axQoSLem45, axiom, 
 ( ! [Var_DATA] : 
 (hasType(type_ComputerData, Var_DATA) => 
(( ? [Var_HARDWARE] : 
 (hasType(type_ComputerHardware, Var_HARDWARE) &  
(f_located(Var_DATA,Var_HARDWARE)))))))).

fof(axQoSLem46, axiom, 
 ( ! [Var_DATA] : 
 (hasType(type_ComputerData, Var_DATA) => 
(( ! [Var_PROCESS] : 
 (hasType(type_ComputerProcess, Var_PROCESS) => 
(( ! [Var_ABORT] : 
 (hasType(type_Abort, Var_ABORT) => 
(((((f_processAborted(Var_ABORT,Var_PROCESS)) & (f_dataProcessed(Var_PROCESS,Var_DATA)))) => (( ? [Var_SAVE] : 
 (hasType(type_DataSaving, Var_SAVE) &  
(f_dataProcessed(Var_SAVE,Var_DATA)))))))))))))))).

fof(axQoSLem47, axiom, 
 ( ! [Var_SAVE] : 
 (hasType(type_DataSaving, Var_SAVE) => 
(( ? [Var_DATA] : 
 (hasType(type_ComputerData, Var_DATA) &  
(f_dataProcessed(Var_SAVE,Var_DATA)))))))).

fof(axQoSLem48, axiom, 
 ( ! [Var_COMPRESSION] : 
 (hasType(type_DataCompression, Var_COMPRESSION) => 
(( ! [Var_NEWMEMORY] : 
 ((hasType(type_RealNumber, Var_NEWMEMORY) & hasType(type_Quantity, Var_NEWMEMORY)) => 
(( ! [Var_MEASURE] : 
 (hasType(type_UnitOfMeasure, Var_MEASURE) => 
(( ! [Var_MEMORY] : 
 ((hasType(type_RealNumber, Var_MEMORY) & hasType(type_Quantity, Var_MEMORY)) => 
(( ! [Var_DATA] : 
 ((hasType(type_ComputerData, Var_DATA) & hasType(type_ComputationalSystem, Var_DATA)) => 
(((((f_dataProcessed(Var_COMPRESSION,Var_DATA)) & (((f_holdsDuring(f_ImmediatePastFn(f_WhenFn(Var_COMPRESSION)),memorySize(Var_DATA,f_MeasureFn(Var_MEMORY,Var_MEASURE)))) & (f_holdsDuring(f_ImmediateFutureFn(f_WhenFn(Var_COMPRESSION)),memorySize(Var_DATA,f_MeasureFn(Var_NEWMEMORY,Var_MEASURE)))))))) => (f_lessThan(Var_NEWMEMORY,Var_MEMORY))))))))))))))))))).

fof(axQoSLem49, axiom, 
 ( ! [Var_TASK] : 
 (hasType(type_ProcessTask, Var_TASK) => 
(( ? [Var_PROCESS] : 
 (hasType(type_ComputerProcess, Var_PROCESS) &  
(f_task(Var_PROCESS,Var_TASK)))))))).

fof(axQoSLem50, axiom, 
 ( ! [Var_USING] : 
 (hasType(type_UsingAResource, Var_USING) => 
(( ? [Var_RESOURCE] : 
 (hasType(type_ComputerResource, Var_RESOURCE) &  
(f_resourceUsed(Var_USING,Var_RESOURCE)))))))).

fof(axQoSLem51, axiom, 
 ( ! [Var_USING] : 
 (hasType(type_UsingAResource, Var_USING) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(( ! [Var_RESOURCE] : 
 ((hasType(type_ComputerResource, Var_RESOURCE) & hasType(type_Agent, Var_RESOURCE)) => 
(((((f_resourceUsed(Var_USING,Var_RESOURCE)) & (f_agent(Var_USING,Var_AGENT)))) => (f_uses(Var_AGENT,Var_RESOURCE))))))))))))).

fof(axQoSLem52, axiom, 
 ( ! [Var_USING] : 
 (hasType(type_ReusingAResource, Var_USING) => 
(( ? [Var_RESOURCE] : 
 (hasType(type_ComputerResource, Var_RESOURCE) &  
(f_resourceUsed(Var_USING,Var_RESOURCE)))))))).

fof(axQoSLem53, axiom, 
 ( ! [Var_REUSING] : 
 (hasType(type_ReusingAResource, Var_REUSING) => 
(( ! [Var_RESOURCE] : 
 (hasType(type_ComputerResource, Var_RESOURCE) => 
(((f_resourceUsed(Var_REUSING,Var_RESOURCE)) => (( ? [Var_USING] : 
 (hasType(type_UsingAResource, Var_USING) &  
(((f_resourceUsed(Var_USING,Var_RESOURCE)) & (f_earlier(f_WhenFn(Var_USING),f_WhenFn(Var_REUSING)))))))))))))))).

fof(axQoSLem54, axiom, 
 ( ! [Var_ACCOUNT] : 
 (hasType(type_UserAccount, Var_ACCOUNT) => 
(( ? [Var_USER] : 
 (hasType(type_ComputerUser, Var_USER) &  
(f_hasAccount(Var_USER,Var_ACCOUNT)))))))).

fof(axQoSLem55, axiom, 
 ( ! [Var_ACCOUNT] : 
 (hasType(type_UserAccount, Var_ACCOUNT) => 
(( ! [Var_USER] : 
 (hasType(type_ComputerUser, Var_USER) => 
(((f_hasAccount(Var_USER,Var_ACCOUNT)) => (( ? [Var_NAME] : 
 (hasType(type_UserName, Var_NAME) &  
(f_userName(Var_USER,Var_NAME))))))))))))).

fof(axQoSLem56, axiom, 
 ( ! [Var_ACCOUNT] : 
 (hasType(type_UserAccount, Var_ACCOUNT) => 
(( ! [Var_USER] : 
 ((hasType(type_ComputerUser, Var_USER) & hasType(type_ComputerPassword, Var_USER)) => 
(((f_hasAccount(Var_USER,Var_ACCOUNT)) => (( ? [Var_PASSWORD] : 
 (hasType(type_ComputerUser, Var_PASSWORD) &  
(f_password(Var_PASSWORD,Var_USER))))))))))))).

