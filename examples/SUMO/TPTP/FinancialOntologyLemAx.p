fof(axFinancialLem0, axiom, 
 ( ! [Var_ASSET] : 
 (hasType(type_FinancialAsset, Var_ASSET) => 
(( ? [Var_VALUE] : 
 (hasType(type_CurrencyMeasure, Var_VALUE) &  
(f_monetaryValue(Var_ASSET,Var_VALUE)))))))).

fof(axFinancialLem1, axiom, 
 ( ! [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) => 
(( ? [Var_ORGANIZATION] : 
 (hasType(type_FinancialOrganization, Var_ORGANIZATION) &  
(f_accountAt(Var_ACCOUNT,Var_ORGANIZATION)))))))).

fof(axFinancialLem2, axiom, 
 ( ! [Var_CHECK] : 
 (hasType(type_Check, Var_CHECK) => 
(( ? [Var_VALUE] : 
 (hasType(type_CurrencyMeasure, Var_VALUE) &  
(f_monetaryValue(Var_CHECK,Var_VALUE)))))))).

fof(axFinancialLem3, axiom, 
 ( ! [Var_CHECK] : 
 (hasType(type_Check, Var_CHECK) => 
(( ? [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) &  
(f_checkAccount(Var_CHECK,Var_ACCOUNT)))))))).

fof(axFinancialLem4, axiom, 
 ( ! [Var_PROCESSING] : 
 (hasType(type_ProcessingACheck, Var_PROCESSING) => 
(( ! [Var_WITHDRAWALTIME] : 
 ((hasType(type_Entity, Var_WITHDRAWALTIME) & hasType(type_TimeInterval, Var_WITHDRAWALTIME)) => 
(( ! [Var_PROCESSINGTIME] : 
 ((hasType(type_Entity, Var_PROCESSINGTIME) & hasType(type_TimeInterval, Var_PROCESSINGTIME)) => 
(( ! [Var_ACCOUNT] : 
 ((hasType(type_FinancialAccount, Var_ACCOUNT) & hasType(type_Object, Var_ACCOUNT)) => 
(( ! [Var_AMOUNT] : 
 (hasType(type_CurrencyMeasure, Var_AMOUNT) => 
(( ! [Var_CHECK] : 
 ((hasType(type_Physical, Var_CHECK) & hasType(type_Check, Var_CHECK) & hasType(type_Entity, Var_CHECK) & hasType(type_Object, Var_CHECK)) => 
(((((f_monetaryValue(Var_CHECK,Var_AMOUNT)) & (((f_checkAccount(Var_CHECK,Var_ACCOUNT)) & (((f_patient(Var_PROCESSING,Var_CHECK)) & (f_WhenFn(Var_PROCESSING) = Var_PROCESSINGTIME))))))) => (( ? [Var_WITHDRAWAL] : 
 (hasType(type_Withdrawal, Var_WITHDRAWAL) &  
(((f_instrument(Var_WITHDRAWAL,Var_CHECK)) & (((f_WhenFn(Var_WITHDRAWAL) = Var_WITHDRAWALTIME) & (((f_meetsTemporally(Var_PROCESSINGTIME,Var_WITHDRAWALTIME)) & (((f_transactionAmount(Var_WITHDRAWAL,Var_AMOUNT)) & (f_origin(Var_WITHDRAWAL,Var_ACCOUNT))))))))))))))))))))))))))))))))).

fof(axFinancialLem5, axiom, 
 ( ! [Var_PROCESSING] : 
 (hasType(type_ProcessingACheck, Var_PROCESSING) => 
(( ! [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) => 
(( ! [Var_DEPOSITTIME] : 
 ((hasType(type_Entity, Var_DEPOSITTIME) & hasType(type_TimeInterval, Var_DEPOSITTIME)) => 
(( ! [Var_PROCESSINGTIME] : 
 ((hasType(type_Entity, Var_PROCESSINGTIME) & hasType(type_TimeInterval, Var_PROCESSINGTIME)) => 
(( ! [Var_AMOUNT] : 
 (hasType(type_CurrencyMeasure, Var_AMOUNT) => 
(( ! [Var_CHECK] : 
 ((hasType(type_Physical, Var_CHECK) & hasType(type_Entity, Var_CHECK) & hasType(type_Object, Var_CHECK)) => 
(((((f_monetaryValue(Var_CHECK,Var_AMOUNT)) & (((f_patient(Var_PROCESSING,Var_CHECK)) & (((f_destination(Var_PROCESSING,f_CurrencyFn(Var_ACCOUNT))) & (f_WhenFn(Var_PROCESSING) = Var_PROCESSINGTIME))))))) => (( ? [Var_DEPOSIT] : 
 (hasType(type_Deposit, Var_DEPOSIT) &  
(((f_instrument(Var_DEPOSIT,Var_CHECK)) & (((f_WhenFn(Var_DEPOSIT) = Var_DEPOSITTIME) & (((f_meetsTemporally(Var_PROCESSINGTIME,Var_DEPOSITTIME)) & (((f_transactionAmount(Var_DEPOSIT,Var_AMOUNT)) & (f_destination(Var_DEPOSIT,f_CurrencyFn(Var_ACCOUNT)))))))))))))))))))))))))))))))))).

fof(axFinancialLem6, axiom, 
 ( ! [Var_CHECK] : 
 (hasType(type_Check, Var_CHECK) => 
(( ! [Var_PROCESSING] : 
 (hasType(type_ProcessingACheck, Var_PROCESSING) => 
(((f_patient(Var_PROCESSING,Var_CHECK)) => (( ? [Var_DEPOSITING] : 
 (hasType(type_DepositingACheck, Var_DEPOSITING) &  
(((f_patient(Var_DEPOSITING,Var_CHECK)) & (f_time(Var_DEPOSITING,f_ImmediatePastFn(f_WhenFn(Var_PROCESSING))))))))))))))))).

fof(axFinancialLem7, axiom, 
 ( ! [Var_DEPOSITING] : 
 (hasType(type_DepositingACheck, Var_DEPOSITING) => 
(( ! [Var_CHECK] : 
 (hasType(type_Check, Var_CHECK) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_CognitiveAgent, Var_AGENT)) => 
(((f_agent(Var_DEPOSITING,Var_AGENT)) => (f_signedBy(Var_CHECK,Var_AGENT))))))))))))).

fof(axFinancialLem8, axiom, 
 ( ! [Var_DRAWING] : 
 (hasType(type_DrawingACheck, Var_DRAWING) => 
(( ! [Var_PROCESSING] : 
 (hasType(type_ProcessingACheck, Var_PROCESSING) => 
(( ! [Var_DURATION] : 
 (hasType(type_Quantity, Var_DURATION) => 
(( ! [Var_DUATION] : 
 (hasType(type_TimeDuration, Var_DUATION) => 
(( ! [Var_TIME] : 
 (hasType(type_TimeInterval, Var_TIME) => 
(( ! [Var_PROCESSINGTIME] : 
 ((hasType(type_Entity, Var_PROCESSINGTIME) & hasType(type_TimeInterval, Var_PROCESSINGTIME)) => 
(( ! [Var_PROCESING] : 
 (hasType(type_Physical, Var_PROCESING) => 
(( ! [Var_DRAWINGTIME] : 
 ((hasType(type_Entity, Var_DRAWINGTIME) & hasType(type_TimeInterval, Var_DRAWINGTIME)) => 
(( ! [Var_CHECK] : 
 (hasType(type_Entity, Var_CHECK) => 
(((((f_patient(Var_DRAWING,Var_CHECK)) & (((f_patient(Var_PROCESSING,Var_CHECK)) & (((f_WhenFn(Var_DRAWING) = Var_DRAWINGTIME) & (((f_WhenFn(Var_PROCESING) = Var_PROCESSINGTIME) & (((f_meetsTemporally(Var_DRAWINGTIME,Var_TIME)) & (((f_meetsTemporally(Var_TIME,Var_PROCESSINGTIME)) & (f_duration(Var_TIME,Var_DUATION)))))))))))))) => (f_lessThan(Var_DURATION,f_MeasureFn(6,inst_MonthDuration)))))))))))))))))))))))))))))))).

fof(axFinancialLem9, axiom, 
 ( ! [Var_CHECK] : 
 (hasType(type_PayCheck, Var_CHECK) => 
(( ! [Var_GIVE] : 
 (hasType(type_Giving, Var_GIVE) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Entity, Var_AGENT) & hasType(type_Organization, Var_AGENT)) => 
(( ! [Var_ORGANIZATION] : 
 (hasType(type_CognitiveAgent, Var_ORGANIZATION) => 
(((((f_issuedBy(Var_CHECK,Var_ORGANIZATION)) & (f_destination(Var_GIVE,Var_AGENT)))) => (f_employs(Var_AGENT,Var_ORGANIZATION)))))))))))))))).

fof(axFinancialLem10, axiom, 
 ( ! [Var_CARD] : 
 (hasType(type_BankCard, Var_CARD) => 
(( ? [Var_ORGANIZATION] : 
 (hasType(type_CognitiveAgent, Var_ORGANIZATION) &  
(f_issuedBy(Var_CARD,Var_ORGANIZATION)))))))).

fof(axFinancialLem11, axiom, 
 ( ! [Var_CARD] : 
 (hasType(type_BankCard, Var_CARD) => 
(( ! [Var_BANK] : 
 ((hasType(type_CognitiveAgent, Var_BANK) & hasType(type_FinancialOrganization, Var_BANK)) => 
(((f_issuedBy(Var_CARD,Var_BANK)) => (( ? [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) &  
(((f_cardAccount(Var_CARD,Var_ACCOUNT)) & (f_accountAt(Var_ACCOUNT,Var_BANK))))))))))))))).

fof(axFinancialLem12, axiom, 
 ( ! [Var_CARD] : 
 (hasType(type_DebitCard, Var_CARD) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_CognitiveAgent, Var_AGENT)) => 
(((f_possesses(Var_AGENT,Var_CARD)) => (( ? [Var_ACCOUNT] : 
 (hasType(type_DepositAccount, Var_ACCOUNT) &  
(((f_cardAccount(Var_CARD,Var_ACCOUNT)) & (f_accountHolder(Var_ACCOUNT,Var_AGENT))))))))))))))).

fof(axFinancialLem13, axiom, 
 ( ! [Var_CARD] : 
 (hasType(type_CreditCard, Var_CARD) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_CognitiveAgent, Var_AGENT)) => 
(((f_possesses(Var_AGENT,Var_CARD)) => (( ? [Var_ACCOUNT] : 
 (hasType(type_CreditCardAccount, Var_ACCOUNT) &  
(((f_cardAccount(Var_CARD,Var_ACCOUNT)) & (f_accountHolder(Var_ACCOUNT,Var_AGENT))))))))))))))).

fof(axFinancialLem14, axiom, 
 ( ! [Var_OPENING] : 
 (hasType(type_OpeningAnAccount, Var_OPENING) => 
(( ! [Var_BANK] : 
 (hasType(type_FinancialOrganization, Var_BANK) => 
(( ! [Var_OPENINGTIME] : 
 ((hasType(type_Entity, Var_OPENINGTIME) & hasType(type_TimeInterval, Var_OPENINGTIME)) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_CognitiveAgent, Var_AGENT)) => 
(((((f_located(Var_OPENING,Var_BANK)) & (((f_agent(Var_OPENING,Var_AGENT)) & (f_WhenFn(Var_OPENING) = Var_OPENINGTIME))))) => (( ? [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) &  
(( ? [Var_ACCOUNTPERIOD] : 
 (hasType(type_TimeInterval, Var_ACCOUNTPERIOD) &  
(((f_agreementPeriod(Var_ACCOUNT,Var_ACCOUNTPERIOD)) & (((f_meetsTemporally(Var_OPENINGTIME,Var_ACCOUNTPERIOD)) & (((f_accountAt(Var_ACCOUNT,Var_BANK)) & (f_accountHolder(Var_ACCOUNT,Var_AGENT)))))))))))))))))))))))))))).

fof(axFinancialLem15, axiom, 
 ( ! [Var_USING] : 
 (hasType(type_UsingAnAccount, Var_USING) => 
(( ! [Var_AGENT] : 
 ((hasType(type_CognitiveAgent, Var_AGENT) & hasType(type_Agent, Var_AGENT)) => 
(( ! [Var_ACCOUNT] : 
 ((hasType(type_Entity, Var_ACCOUNT) & hasType(type_FinancialAccount, Var_ACCOUNT)) => 
(((((f_patient(Var_USING,Var_ACCOUNT)) & (f_accountHolder(Var_ACCOUNT,Var_AGENT)))) => (f_agent(Var_USING,Var_AGENT))))))))))))).

fof(axFinancialLem16, axiom, 
 ( ! [Var_DRAWING] : 
 (hasType(type_DrawingACheck, Var_DRAWING) => 
(( ! [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_CognitiveAgent, Var_AGENT)) => 
(( ! [Var_CHECK] : 
 ((hasType(type_Entity, Var_CHECK) & hasType(type_Check, Var_CHECK)) => 
(((((f_patient(Var_DRAWING,Var_CHECK)) & (((f_agent(Var_DRAWING,Var_AGENT)) & (f_checkAccount(Var_CHECK,Var_ACCOUNT)))))) => (f_accountHolder(Var_ACCOUNT,Var_AGENT)))))))))))))))).

fof(axFinancialLem17, axiom, 
 ( ! [Var_DEPOSITING] : 
 (hasType(type_DepositingACheck, Var_DEPOSITING) => 
(( ? [Var_CHECK] : 
 (hasType(type_Check, Var_CHECK) &  
(f_patient(Var_DEPOSITING,Var_CHECK)))))))).

fof(axFinancialLem18, axiom, 
 ( ! [Var_DEPOSITING] : 
 (hasType(type_DepositingACheck, Var_DEPOSITING) => 
(( ! [Var_CHECK] : 
 (hasType(type_Check, Var_CHECK) => 
(( ! [Var_AMOUNT] : 
 (hasType(type_CurrencyMeasure, Var_AMOUNT) => 
(( ! [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) => 
(((((f_patient(Var_DEPOSITING,Var_CHECK)) & (((f_checkAccount(Var_CHECK,Var_ACCOUNT)) & (f_monetaryValue(Var_CHECK,Var_AMOUNT)))))) => (( ? [Var_DEPOSIT] : 
 (hasType(type_Deposit, Var_DEPOSIT) &  
(((f_destination(Var_DEPOSIT,f_CurrencyFn(Var_ACCOUNT))) & (f_transactionAmount(Var_DEPOSIT,Var_AMOUNT))))))))))))))))))))).

fof(axFinancialLem19, axiom, 
 ( ! [Var_CONTROLLING] : 
 (hasType(type_ControllingAnAccount, Var_CONTROLLING) => 
(( ! [Var_BANK] : 
 ((hasType(type_FinancialOrganization, Var_BANK) & hasType(type_Agent, Var_BANK)) => 
(( ! [Var_ACCOUNT] : 
 ((hasType(type_Entity, Var_ACCOUNT) & hasType(type_FinancialAccount, Var_ACCOUNT)) => 
(((((f_patient(Var_CONTROLLING,Var_ACCOUNT)) & (f_accountAt(Var_ACCOUNT,Var_BANK)))) => (f_agent(Var_CONTROLLING,Var_BANK))))))))))))).

fof(axFinancialLem20, axiom, 
 ( ! [Var_PROCESSING] : 
 (hasType(type_ProcessingACheck, Var_PROCESSING) => 
(( ! [Var_PROCESING] : 
 (hasType(type_Process, Var_PROCESING) => 
(( ? [Var_CHECK] : 
 (hasType(type_Check, Var_CHECK) &  
(f_patient(Var_PROCESING,Var_CHECK))))))))))).

fof(axFinancialLem21, axiom, 
 ( ! [Var_PROCESSING] : 
 (hasType(type_ProcessingACheck, Var_PROCESSING) => 
(( ? [Var_AUTHORIZATION] : 
 (hasType(type_AuthorizationOfTransaction, Var_AUTHORIZATION) &  
(f_subProcess(Var_AUTHORIZATION,Var_PROCESSING)))))))).

fof(axFinancialLem22, axiom, 
 ( ! [Var_PAYMENT] : 
 (hasType(type_Payment, Var_PAYMENT) => 
(( ! [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) => 
(( ! [Var_BALANCE2] : 
 ((hasType(type_Entity, Var_BALANCE2) & hasType(type_CurrencyMeasure, Var_BALANCE2)) => 
(( ! [Var_BALANCE1] : 
 ((hasType(type_CurrencyMeasure, Var_BALANCE1) & hasType(type_Quantity, Var_BALANCE1)) => 
(( ! [Var_AMOUNT] : 
 ((hasType(type_CurrencyMeasure, Var_AMOUNT) & hasType(type_Quantity, Var_AMOUNT)) => 
(((((f_origin(Var_PAYMENT,f_CurrencyFn(Var_ACCOUNT))) & (((f_transactionAmount(Var_PAYMENT,Var_AMOUNT)) & (((f_currentAccountBalance(Var_ACCOUNT,f_ImmediatePastFn(f_WhenFn(Var_PAYMENT)),Var_BALANCE1)) & (Var_BALANCE2 = f_SubtractionFn(Var_BALANCE1,Var_AMOUNT)))))))) => (f_currentAccountBalance(Var_ACCOUNT,f_ImmediateFutureFn(f_WhenFn(Var_PAYMENT)),Var_BALANCE2))))))))))))))))))).

fof(axFinancialLem23, axiom, 
 ( ! [Var_DEPOSIT] : 
 (hasType(type_Deposit, Var_DEPOSIT) => 
(( ? [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) &  
(f_destination(Var_DEPOSIT,f_CurrencyFn(Var_ACCOUNT))))))))).

fof(axFinancialLem24, axiom, 
 ( ! [Var_DEPOSIT] : 
 (hasType(type_Deposit, Var_DEPOSIT) => 
(( ! [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) => 
(( ! [Var_BALANCE2] : 
 ((hasType(type_Entity, Var_BALANCE2) & hasType(type_CurrencyMeasure, Var_BALANCE2)) => 
(( ! [Var_BALANCE1] : 
 ((hasType(type_CurrencyMeasure, Var_BALANCE1) & hasType(type_Quantity, Var_BALANCE1)) => 
(( ! [Var_AMOUNT] : 
 ((hasType(type_CurrencyMeasure, Var_AMOUNT) & hasType(type_Quantity, Var_AMOUNT)) => 
(( ! [Var_TIMEOFDEPOSIT] : 
 (hasType(type_TimePosition, Var_TIMEOFDEPOSIT) => 
(((((f_time(Var_DEPOSIT,Var_TIMEOFDEPOSIT)) & (((f_destination(Var_DEPOSIT,f_CurrencyFn(Var_ACCOUNT))) & (((f_transactionAmount(Var_DEPOSIT,Var_AMOUNT)) & (((f_currentAccountBalance(Var_ACCOUNT,f_ImmediatePastFn(f_WhenFn(Var_DEPOSIT)),Var_BALANCE1)) & (Var_BALANCE2 = f_AdditionFn(Var_BALANCE1,Var_AMOUNT)))))))))) => (f_currentAccountBalance(Var_ACCOUNT,f_ImmediateFutureFn(f_FutureFn(Var_DEPOSIT)),Var_BALANCE2)))))))))))))))))))))).

fof(axFinancialLem25, axiom, 
 ( ! [Var_WITHDRAWAL] : 
 (hasType(type_Withdrawal, Var_WITHDRAWAL) => 
(( ? [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) &  
(f_origin(Var_WITHDRAWAL,f_CurrencyFn(Var_ACCOUNT))))))))).

fof(axFinancialLem26, axiom, 
 ( ! [Var_WITHDRAWAL] : 
 (hasType(type_Withdrawal, Var_WITHDRAWAL) => 
(( ! [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) => 
(( ! [Var_BALANCE2] : 
 ((hasType(type_Entity, Var_BALANCE2) & hasType(type_CurrencyMeasure, Var_BALANCE2)) => 
(( ! [Var_BALANCE1] : 
 ((hasType(type_CurrencyMeasure, Var_BALANCE1) & hasType(type_Quantity, Var_BALANCE1)) => 
(( ! [Var_AMOUNT] : 
 ((hasType(type_CurrencyMeasure, Var_AMOUNT) & hasType(type_Quantity, Var_AMOUNT)) => 
(( ! [Var_TIMEOFWITHDRAWAL] : 
 (hasType(type_TimePosition, Var_TIMEOFWITHDRAWAL) => 
(((((f_time(Var_WITHDRAWAL,Var_TIMEOFWITHDRAWAL)) & (((f_origin(Var_WITHDRAWAL,Var_ACCOUNT)) & (((f_transactionAmount(Var_WITHDRAWAL,Var_AMOUNT)) & (((f_currentAccountBalance(Var_ACCOUNT,f_ImmediatePastFn(f_WhenFn(Var_WITHDRAWAL)),Var_BALANCE1)) & (Var_BALANCE2 = f_SubtractionFn(Var_BALANCE1,Var_AMOUNT)))))))))) => (f_currentAccountBalance(Var_ACCOUNT,f_ImmediateFutureFn(f_FutureFn(Var_WITHDRAWAL)),Var_BALANCE2)))))))))))))))))))))).

fof(axFinancialLem27, axiom, 
 ( ! [Var_MONEY] : 
 (hasType(type_CurrencyMeasure, Var_MONEY) => 
(( ! [Var_OBJECT] : 
 ((hasType(type_Entity, Var_OBJECT) & hasType(type_Physical, Var_OBJECT)) => 
(( ! [Var_SELLER] : 
 ((hasType(type_Object, Var_SELLER) & hasType(type_Entity, Var_SELLER)) => 
(( ! [Var_BUYER] : 
 (hasType(type_Agent, Var_BUYER) => 
(( ! [Var_PURCHASE] : 
 (hasType(type_Process, Var_PURCHASE) => 
(((((f_agent(Var_PURCHASE,Var_BUYER)) & (((f_origin(Var_PURCHASE,Var_SELLER)) & (((f_patient(Var_PURCHASE,Var_OBJECT)) & (f_monetaryValue(Var_OBJECT,Var_MONEY)))))))) => (( ? [Var_PAYMENT] : 
 (hasType(type_Payment, Var_PAYMENT) &  
(((f_subProcess(Var_PAYMENT,Var_PURCHASE)) & (((f_transactionAmount(Var_PAYMENT,Var_MONEY)) & (f_destination(Var_PAYMENT,Var_SELLER)))))))))))))))))))))))))).

fof(axFinancialLem28, axiom, 
 ( ! [Var_RATE_DECIMAL] : 
 ((hasType(type_Entity, Var_RATE_DECIMAL) & hasType(type_Quantity, Var_RATE_DECIMAL)) => 
(( ! [Var_PERIOD] : 
 ((hasType(type_TimeInterval, Var_PERIOD) & hasType(type_PhysicalQuantity, Var_PERIOD)) => 
(( ! [Var_AMOUNT] : 
 ((hasType(type_Interest, Var_AMOUNT) & hasType(type_Entity, Var_AMOUNT)) => 
(( ! [Var_RATE] : 
 ((hasType(type_InterestRate, Var_RATE) & hasType(type_PhysicalQuantity, Var_RATE)) => 
(( ! [Var_BALANCE] : 
 ((hasType(type_CurrencyMeasure, Var_BALANCE) & hasType(type_Quantity, Var_BALANCE)) => 
(( ! [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) => 
(((((f_principalAmount(Var_ACCOUNT,Var_BALANCE)) & (((f_fixedInterestRate(Var_ACCOUNT,Var_RATE)) & (((f_simpleInterest(Var_ACCOUNT,Var_AMOUNT,Var_PERIOD)) & (Var_RATE_DECIMAL = f_DivisionFn(f_MagnitudeFn(Var_RATE),100)))))))) => (Var_AMOUNT = f_MultiplicationFn(f_MultiplicationFn(f_MagnitudeFn(Var_PERIOD),Var_BALANCE),Var_RATE_DECIMAL)))))))))))))))))))))).

fof(axFinancialLem29, axiom, 
 ( ! [Var_MULTIPLY] : 
 ((hasType(type_Entity, Var_MULTIPLY) & hasType(type_Quantity, Var_MULTIPLY)) => 
(( ! [Var_EXPONENT] : 
 ((hasType(type_Entity, Var_EXPONENT) & hasType(type_Quantity, Var_EXPONENT)) => 
(( ! [Var_ADD] : 
 ((hasType(type_Entity, Var_ADD) & hasType(type_Quantity, Var_ADD)) => 
(( ! [Var_RATE_DECIMAL] : 
 ((hasType(type_Entity, Var_RATE_DECIMAL) & hasType(type_Quantity, Var_RATE_DECIMAL)) => 
(( ! [Var_PERIOD] : 
 ((hasType(type_TimeInterval, Var_PERIOD) & hasType(type_PhysicalQuantity, Var_PERIOD)) => 
(( ! [Var_INTEREST] : 
 ((hasType(type_Interest, Var_INTEREST) & hasType(type_Entity, Var_INTEREST)) => 
(( ! [Var_RATE] : 
 ((hasType(type_InterestRate, Var_RATE) & hasType(type_Quantity, Var_RATE)) => 
(( ! [Var_BALANCE] : 
 ((hasType(type_CurrencyMeasure, Var_BALANCE) & hasType(type_Quantity, Var_BALANCE)) => 
(( ! [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) => 
(((((f_principalAmount(Var_ACCOUNT,Var_BALANCE)) & (((f_fixedInterestRate(Var_ACCOUNT,Var_RATE)) & (((f_compoundInterest(Var_ACCOUNT,Var_INTEREST,Var_PERIOD)) & (((Var_RATE_DECIMAL = f_DivisionFn(Var_RATE,100)) & (((Var_ADD = f_AdditionFn(1,Var_RATE_DECIMAL)) & (((Var_EXPONENT = f_ExponentiationFn(Var_ADD,f_MagnitudeFn(Var_PERIOD))) & (Var_MULTIPLY = f_MultiplicationFn(Var_EXPONENT,Var_BALANCE)))))))))))))) => (Var_INTEREST = f_SubtractionFn(Var_MULTIPLY,Var_BALANCE))))))))))))))))))))))))))))))).

fof(axFinancialLem30, axiom, 
 ( ! [Var_RATE] : 
 ((hasType(type_Entity, Var_RATE) & hasType(type_InterestRate, Var_RATE)) => 
(( ! [Var_RATE_DECIMAL] : 
 ((hasType(type_Entity, Var_RATE_DECIMAL) & hasType(type_Quantity, Var_RATE_DECIMAL)) => 
(( ! [Var_PRINCIPAL] : 
 ((hasType(type_CurrencyMeasure, Var_PRINCIPAL) & hasType(type_Quantity, Var_PRINCIPAL)) => 
(( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(( ! [Var_INTEREST] : 
 ((hasType(type_Interest, Var_INTEREST) & hasType(type_Quantity, Var_INTEREST)) => 
(( ! [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) => 
(((((f_simpleInterest(Var_ACCOUNT,Var_INTEREST,Var_PERIOD)) & (((f_principalAmount(Var_ACCOUNT,Var_PRINCIPAL)) & (((Var_RATE_DECIMAL = f_DivisionFn(Var_INTEREST,Var_PRINCIPAL)) & (Var_RATE = f_MultiplicationFn(Var_RATE_DECIMAL,100)))))))) => (f_interestRatePerPeriod(Var_ACCOUNT,Var_RATE,Var_PERIOD)))))))))))))))))))))).

fof(axFinancialLem31, axiom, 
 ( ! [Var_ACCOUNT] : 
 (hasType(type_PersonalAccount, Var_ACCOUNT) => 
(( ! [Var_PRIMERATE] : 
 ((hasType(type_InterestRate, Var_PRIMERATE) & hasType(type_Quantity, Var_PRIMERATE)) => 
(( ! [Var_RATE] : 
 ((hasType(type_InterestRate, Var_RATE) & hasType(type_Quantity, Var_RATE)) => 
(( ! [Var_DATE] : 
 (hasType(type_Day, Var_DATE) => 
(((((f_currentInterestRate(Var_ACCOUNT,Var_DATE,Var_RATE)) & (f_primeInterestRate(Var_DATE,Var_PRIMERATE)))) => (f_greaterThan(Var_RATE,Var_PRIMERATE)))))))))))))))).

fof(axFinancialLem32, axiom, 
 ( ! [Var_DATE] : 
 ((hasType(type_TimeInterval, Var_DATE) & hasType(type_TimePosition, Var_DATE)) => 
(( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(( ! [Var_AGREEMENT] : 
 (hasType(type_Contract, Var_AGREEMENT) => 
(((((f_agreementPeriod(Var_AGREEMENT,Var_PERIOD)) & (f_overlapsTemporally(Var_DATE,Var_PERIOD)))) <=> (f_agreementActive(Var_AGREEMENT,Var_DATE))))))))))))).

fof(axFinancialLem33, axiom, 
 ( ! [Var_PRINCIPAL] : 
 (hasType(type_CurrencyMeasure, Var_PRINCIPAL) => 
(( ! [Var_DATE] : 
 ((hasType(type_Day, Var_DATE) & hasType(type_TimePosition, Var_DATE)) => 
(( ! [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) => 
(((((f_maturityDate(Var_ACCOUNT,Var_DATE)) & (f_principalAmount(Var_ACCOUNT,Var_PRINCIPAL)))) => (f_amountDue(Var_ACCOUNT,Var_PRINCIPAL,Var_DATE))))))))))))).

fof(axFinancialLem34, axiom, 
 ( ! [Var_END] : 
 ((hasType(type_TimeInterval, Var_END) & hasType(type_Day, Var_END)) => 
(( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(( ! [Var_ACCOUNT] : 
 ((hasType(type_Contract, Var_ACCOUNT) & hasType(type_FinancialAccount, Var_ACCOUNT)) => 
(((((f_agreementPeriod(Var_ACCOUNT,Var_PERIOD)) & (f_finishes(Var_END,Var_PERIOD)))) <=> (f_maturityDate(Var_ACCOUNT,Var_END))))))))))))).

fof(axFinancialLem35, axiom, 
 ( ! [Var_BALANCE] : 
 (hasType(type_CurrencyMeasure, Var_BALANCE) => 
(( ! [Var_DATE] : 
 (hasType(type_Day, Var_DATE) => 
(( ! [Var_ACCOUNT] : 
 ((hasType(type_Contract, Var_ACCOUNT) & hasType(type_FinancialAccount, Var_ACCOUNT)) => 
(((((f_effectiveDate(Var_ACCOUNT,Var_DATE)) & (f_currentAccountBalance(Var_ACCOUNT,Var_DATE,Var_BALANCE)))) => (f_originalBalance(Var_ACCOUNT,Var_BALANCE))))))))))))).

fof(axFinancialLem36, axiom, 
 ( ! [Var_ACCOUNT] : 
 (hasType(type_LiabilityAccount, Var_ACCOUNT) => 
(( ! [Var_AMOUNT] : 
 ((hasType(type_CurrencyMeasure, Var_AMOUNT) & hasType(type_Quantity, Var_AMOUNT)) => 
(( ! [Var_MINPAYMENT] : 
 ((hasType(type_CurrencyMeasure, Var_MINPAYMENT) & hasType(type_Quantity, Var_MINPAYMENT)) => 
(((((f_minimumPayment(Var_ACCOUNT,Var_MINPAYMENT,inst_MonthDuration)) & (( ? [Var_MONTH] : 
 (hasType(type_Month, Var_MONTH) &  
(( ? [Var_PAYMENT] : 
 (hasType(type_Process, Var_PAYMENT) &  
(((f_destination(Var_PAYMENT,f_CurrencyFn(Var_ACCOUNT))) & (((f_paymentsPerPeriod(Var_ACCOUNT,Var_AMOUNT,Var_MONTH)) & (f_lessThan(Var_AMOUNT,Var_MINPAYMENT)))))))))))))) => (( ? [Var_PENALTY] : 
 (hasType(type_Penalty, Var_PENALTY) &  
(f_destination(Var_PENALTY,f_CurrencyFn(Var_ACCOUNT))))))))))))))))).

fof(axFinancialLem37, axiom, 
 ( ! [Var_OVERDRAFT] : 
 ((hasType(type_Entity, Var_OVERDRAFT) & hasType(type_RealNumber, Var_OVERDRAFT)) => 
(( ! [Var_BALANCE] : 
 ((hasType(type_RealNumber, Var_BALANCE) & hasType(type_Quantity, Var_BALANCE)) => 
(( ! [Var_DATE] : 
 (hasType(type_Day, Var_DATE) => 
(( ! [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) => 
(((((f_currentAccountBalance(Var_ACCOUNT,Var_DATE,f_MeasureFn(Var_BALANCE,inst_UnitedStatesDollar))) & (((f_lessThan(Var_BALANCE,0)) & (Var_OVERDRAFT = f_SubtractionFn(0,Var_BALANCE)))))) => (f_overdraft(Var_ACCOUNT,f_MeasureFn(Var_OVERDRAFT,inst_UnitedStatesDollar),Var_DATE)))))))))))))))).

fof(axFinancialLem38, axiom, 
 ( ! [Var_DATE] : 
 (hasType(type_Day, Var_DATE) => 
(( ! [Var_AMOUNT] : 
 (hasType(type_CurrencyMeasure, Var_AMOUNT) => 
(( ! [Var_LOAN] : 
 ((hasType(type_Loan, Var_LOAN) & hasType(type_Contract, Var_LOAN) & hasType(type_FinancialAccount, Var_LOAN)) => 
(((((f_downPayment(Var_LOAN,Var_AMOUNT)) & (f_effectiveDate(Var_LOAN,Var_DATE)))) => (( ? [Var_PAYMENT] : 
 ((hasType(type_FinancialTransaction, Var_PAYMENT) & hasType(type_Physical, Var_PAYMENT) & hasType(type_Process, Var_PAYMENT)) &  
(((f_transactionAmount(Var_PAYMENT,Var_AMOUNT)) & (((f_date(Var_PAYMENT,Var_DATE)) & (f_destination(Var_PAYMENT,f_CurrencyFn(Var_LOAN))))))))))))))))))))).

fof(axFinancialLem39, axiom, 
 ( ! [Var_BALANCE] : 
 ((hasType(type_Entity, Var_BALANCE) & hasType(type_CurrencyMeasure, Var_BALANCE)) => 
(( ! [Var_VALUE] : 
 ((hasType(type_CurrencyMeasure, Var_VALUE) & hasType(type_Quantity, Var_VALUE)) => 
(( ! [Var_PURCHASE] : 
 ((hasType(type_Object, Var_PURCHASE) & hasType(type_Physical, Var_PURCHASE)) => 
(( ! [Var_AMOUNT] : 
 ((hasType(type_CurrencyMeasure, Var_AMOUNT) & hasType(type_Quantity, Var_AMOUNT)) => 
(( ! [Var_LOAN] : 
 ((hasType(type_Loan, Var_LOAN) & hasType(type_FinancialAccount, Var_LOAN)) => 
(((((f_downPayment(Var_LOAN,Var_AMOUNT)) & (((f_loanForPurchase(Var_LOAN,Var_PURCHASE)) & (((f_monetaryValue(Var_PURCHASE,Var_VALUE)) & (Var_BALANCE = f_SubtractionFn(Var_VALUE,Var_AMOUNT)))))))) => (f_originalBalance(Var_LOAN,Var_BALANCE))))))))))))))))))).

fof(axFinancialLem40, axiom, 
 ( ! [Var_AMOUNT] : 
 (hasType(type_CurrencyMeasure, Var_AMOUNT) => 
(( ! [Var_ACTION] : 
 ((hasType(type_FinancialTransaction, Var_ACTION) & hasType(type_Process, Var_ACTION)) => 
(( ! [Var_BANK] : 
 ((hasType(type_FinancialOrganization, Var_BANK) & hasType(type_Agent, Var_BANK)) => 
(((f_serviceFee(Var_BANK,Var_ACTION,Var_AMOUNT)) => (( ? [Var_FEE] : 
 (hasType(type_ChargingAFee, Var_FEE) &  
(((f_agent(Var_FEE,Var_BANK)) & (((f_causes(Var_ACTION,Var_FEE)) & (f_amountCharged(Var_FEE,Var_AMOUNT)))))))))))))))))))).

fof(axFinancialLem41, axiom, 
 ( ! [Var_TAX] : 
 (hasType(type_Tax, Var_TAX) => 
(( ? [Var_ORG] : 
 (hasType(type_Government, Var_ORG) &  
(f_agent(Var_TAX,Var_ORG)))))))).

fof(axFinancialLem42, axiom, 
 ( ! [Var_ACCOUNT] : 
 (hasType(type_InterestBearingAccount, Var_ACCOUNT) => 
(( ? [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) &  
(( ? [Var_RATE] : 
 (hasType(type_InterestRate, Var_RATE) &  
(f_interestRatePerPeriod(Var_ACCOUNT,Var_RATE,Var_PERIOD))))))))))).

fof(axFinancialLem43, axiom, 
 ( ! [Var_ACCOUNT] : 
 (hasType(type_PersonalAccount, Var_ACCOUNT) => 
(( ! [Var_AGENT] : 
 (hasType(type_Human, Var_AGENT) => 
(f_accountHolder(Var_ACCOUNT,Var_AGENT)))))))).

fof(axFinancialLem44, axiom, 
 ( ! [Var_ACCOUNT] : 
 (hasType(type_SavingsAccount, Var_ACCOUNT) => 
(( ! [Var_TRANSACTION] : 
 (hasType(type_FinancialTransaction, Var_TRANSACTION) => 
(((f_origin(Var_TRANSACTION,f_CurrencyFn(Var_ACCOUNT))) => (( ? [Var_AUTHORIZATION] : 
 (hasType(type_AuthorizationOfTransaction, Var_AUTHORIZATION) &  
(f_subProcess(Var_AUTHORIZATION,Var_TRANSACTION))))))))))))).

fof(axFinancialLem45, axiom, 
 ( ! [Var_ACCOUNT] : 
 (hasType(type_SavingsAccount, Var_ACCOUNT) => 
(( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(( ! [Var_INTEREST] : 
 ((hasType(type_Interest, Var_INTEREST) & hasType(type_CurrencyMeasure, Var_INTEREST)) => 
(( ! [Var_AGENT] : 
 ((hasType(type_CognitiveAgent, Var_AGENT) & hasType(type_Entity, Var_AGENT)) => 
(((((f_accountHolder(Var_ACCOUNT,Var_AGENT)) & (f_interestEarned(Var_ACCOUNT,Var_INTEREST,Var_PERIOD)))) => (( ? [Var_PAYMENT] : 
 ((hasType(type_Process, Var_PAYMENT) & hasType(type_FinancialTransaction, Var_PAYMENT)) &  
(((f_destination(Var_PAYMENT,f_CurrencyFn(Var_ACCOUNT))) & (((f_transactionAmount(Var_PAYMENT,Var_INTEREST)) & (f_destination(Var_PAYMENT,Var_AGENT))))))))))))))))))))))).

fof(axFinancialLem46, axiom, 
 ( ! [Var_CD] : 
 (hasType(type_CertificateOfDeposit, Var_CD) => 
(( ? [Var_DATE] : 
 (hasType(type_Day, Var_DATE) &  
(f_maturityDate(Var_CD,Var_DATE)))))))).

fof(axFinancialLem47, axiom, 
 ( ! [Var_CD] : 
 (hasType(type_CertificateOfDeposit, Var_CD) => 
(( ! [Var_WITHDRAWAL] : 
 (hasType(type_Withdrawal, Var_WITHDRAWAL) => 
(( ! [Var_DATEOFWITHDRAWAL] : 
 ((hasType(type_Day, Var_DATEOFWITHDRAWAL) & hasType(type_TimeInterval, Var_DATEOFWITHDRAWAL)) => 
(( ! [Var_MATURITYDATE] : 
 ((hasType(type_Day, Var_MATURITYDATE) & hasType(type_TimeInterval, Var_MATURITYDATE)) => 
(((((f_maturityDate(Var_CD,Var_MATURITYDATE)) & (((f_origin(Var_WITHDRAWAL,f_CurrencyFn(Var_CD))) & (((f_date(Var_WITHDRAWAL,Var_DATEOFWITHDRAWAL)) & (f_before(f_EndFn(Var_DATEOFWITHDRAWAL),f_BeginFn(Var_MATURITYDATE))))))))) => (( ? [Var_PENALTY] : 
 (hasType(type_Penalty, Var_PENALTY) &  
(((f_destination(Var_PENALTY,f_CurrencyFn(Var_CD))) & (f_causes(Var_WITHDRAWAL,Var_PENALTY))))))))))))))))))))).

fof(axFinancialLem48, axiom, 
 ( ! [Var_ACCOUNT] : 
 (hasType(type_TraditionalSavingsAccount, Var_ACCOUNT) => 
(( ~ ( ? [Var_DATE] : 
 (hasType(type_Day, Var_DATE) &  
(f_maturityDate(Var_ACCOUNT,Var_DATE))))))))).

fof(axFinancialLem49, axiom, 
 ( ! [Var_ACCOUNT] : 
 (hasType(type_TraditionalSavingsAccount, Var_ACCOUNT) => 
(( ! [Var_WITHDRAWAL] : 
 (hasType(type_Withdrawal, Var_WITHDRAWAL) => 
(((f_origin(Var_WITHDRAWAL,f_CurrencyFn(Var_ACCOUNT))) => (( ? [Var_PENALTY] : 
 (hasType(type_Penalty, Var_PENALTY) &  
(((f_destination(Var_PENALTY,f_CurrencyFn(Var_ACCOUNT))) & (f_causes(Var_WITHDRAWAL,Var_PENALTY))))))))))))))).

fof(axFinancialLem50, axiom, 
 ( ! [Var_ACCOUNT] : 
 (hasType(type_CheckingAccount, Var_ACCOUNT) => 
(( ! [Var_TRANSACTION] : 
 (hasType(type_FinancialTransaction, Var_TRANSACTION) => 
(((f_origin(Var_TRANSACTION,f_CurrencyFn(Var_ACCOUNT))) => (((( ? [Var_CHECK] : 
 (hasType(type_Check, Var_CHECK) &  
(f_instrument(Var_TRANSACTION,Var_CHECK))))) | (( ? [Var_DEBITCARD] : 
 (hasType(type_DebitCard, Var_DEBITCARD) &  
(f_instrument(Var_TRANSACTION,Var_DEBITCARD))))))))))))))).

fof(axFinancialLem51, axiom, 
 ( ! [Var_ACCOUNT] : 
 (hasType(type_LiabilityAccount, Var_ACCOUNT) => 
(( ! [Var_BANK] : 
 ((hasType(type_FinancialOrganization, Var_BANK) & hasType(type_CognitiveAgent, Var_BANK)) => 
(( ! [Var_AGENT] : 
 (hasType(type_CognitiveAgent, Var_AGENT) => 
(((((f_accountHolder(Var_ACCOUNT,Var_AGENT)) & (f_accountAt(Var_ACCOUNT,Var_BANK)))) => (( ? [Var_DEBT] : 
 (hasType(type_Liability, Var_DEBT) &  
(((f_agreementMember(Var_DEBT,Var_AGENT)) & (f_agreementMember(Var_DEBT,Var_BANK)))))))))))))))))).

fof(axFinancialLem52, axiom, 
 ( ! [Var_ACCOUNT] : 
 (hasType(type_CreditAccount, Var_ACCOUNT) => 
(( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(( ! [Var_INTEREST] : 
 ((hasType(type_Interest, Var_INTEREST) & hasType(type_CurrencyMeasure, Var_INTEREST)) => 
(( ! [Var_AGENT] : 
 ((hasType(type_CognitiveAgent, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(( ! [Var_ORGANIZATION] : 
 ((hasType(type_FinancialOrganization, Var_ORGANIZATION) & hasType(type_Entity, Var_ORGANIZATION)) => 
(((((f_accountAt(Var_ACCOUNT,Var_ORGANIZATION)) & (((f_accountHolder(Var_ACCOUNT,Var_AGENT)) & (f_interestEarned(Var_ACCOUNT,Var_INTEREST,Var_PERIOD)))))) => (( ? [Var_PAYMENT] : 
 ((hasType(type_Process, Var_PAYMENT) & hasType(type_FinancialTransaction, Var_PAYMENT)) &  
(((f_origin(Var_PAYMENT,Var_AGENT)) & (((f_transactionAmount(Var_PAYMENT,Var_INTEREST)) & (f_destination(Var_PAYMENT,Var_ORGANIZATION)))))))))))))))))))))))))).

fof(axFinancialLem53, axiom, 
 ( ! [Var_ACCOUNT] : 
 (hasType(type_CreditCardAccount, Var_ACCOUNT) => 
(( ! [Var_TRANSACTION] : 
 (hasType(type_FinancialTransaction, Var_TRANSACTION) => 
(((f_origin(Var_TRANSACTION,f_CurrencyFn(Var_ACCOUNT))) => (( ? [Var_CARD] : 
 (hasType(type_CreditCard, Var_CARD) &  
(f_instrument(Var_TRANSACTION,Var_CARD))))))))))))).

fof(axFinancialLem54, axiom, 
 ( ! [Var_LOAN] : 
 (hasType(type_Loan, Var_LOAN) => 
(( ? [Var_LENDER] : 
 (hasType(type_CognitiveAgent, Var_LENDER) &  
(( ? [Var_BORROWER] : 
 (hasType(type_CognitiveAgent, Var_BORROWER) &  
(((f_borrower(Var_LOAN,Var_BORROWER)) & (f_lender(Var_LOAN,Var_LENDER))))))))))))).

fof(axFinancialLem55, axiom, 
 ( ! [Var_INTEREST] : 
 ((hasType(type_Interest, Var_INTEREST) & hasType(type_CurrencyMeasure, Var_INTEREST)) => 
(( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(( ! [Var_LENDER] : 
 ((hasType(type_CognitiveAgent, Var_LENDER) & hasType(type_Entity, Var_LENDER)) => 
(( ! [Var_BORROWER] : 
 ((hasType(type_CognitiveAgent, Var_BORROWER) & hasType(type_Object, Var_BORROWER)) => 
(( ! [Var_LOAN] : 
 ((hasType(type_Loan, Var_LOAN) & hasType(type_Contract, Var_LOAN) & hasType(type_FinancialAccount, Var_LOAN)) => 
(((((f_borrower(Var_LOAN,Var_BORROWER)) & (((f_lender(Var_LOAN,Var_LENDER)) & (((f_agreementPeriod(Var_LOAN,Var_PERIOD)) & (f_interestEarned(Var_LOAN,Var_INTEREST,Var_PERIOD)))))))) => (( ? [Var_PAYMENT] : 
 ((hasType(type_Process, Var_PAYMENT) & hasType(type_FinancialTransaction, Var_PAYMENT)) &  
(((f_origin(Var_PAYMENT,Var_BORROWER)) & (((f_transactionAmount(Var_PAYMENT,Var_INTEREST)) & (f_destination(Var_PAYMENT,Var_LENDER)))))))))))))))))))))))))).

fof(axFinancialLem56, axiom, 
 ( ! [Var_AGENT] : 
 ((hasType(type_CognitiveAgent, Var_AGENT) & hasType(type_Agent, Var_AGENT)) => 
(( ! [Var_LOAN] : 
 (hasType(type_Loan, Var_LOAN) => 
(((f_lender(Var_LOAN,Var_AGENT)) => (( ? [Var_LENDING] : 
 (hasType(type_Lending, Var_LENDING) &  
(f_agent(Var_LENDING,Var_AGENT))))))))))))).

fof(axFinancialLem57, axiom, 
 ( ! [Var_AGENT] : 
 ((hasType(type_CognitiveAgent, Var_AGENT) & hasType(type_Agent, Var_AGENT)) => 
(( ! [Var_LOAN] : 
 (hasType(type_Loan, Var_LOAN) => 
(((f_borrower(Var_LOAN,Var_AGENT)) => (( ? [Var_BORROWING] : 
 (hasType(type_Borrowing, Var_BORROWING) &  
(f_agent(Var_BORROWING,Var_AGENT))))))))))))).

fof(axFinancialLem58, axiom, 
 ( ! [Var_COLLATERAL] : 
 (hasType(type_Collateral, Var_COLLATERAL) => 
(( ? [Var_LOAN] : 
 (hasType(type_SecuredLoan, Var_LOAN) &  
(f_securedBy(Var_LOAN,Var_COLLATERAL)))))))).

fof(axFinancialLem59, axiom, 
 ( ! [Var_LOAN] : 
 (hasType(type_Loan, Var_LOAN) => 
(( ! [Var_DEFAULT] : 
 (hasType(type_FinancialDefault, Var_DEFAULT) => 
(( ! [Var_BANK] : 
 ((hasType(type_CognitiveAgent, Var_BANK) & hasType(type_Agent, Var_BANK)) => 
(( ! [Var_SECURITY] : 
 ((hasType(type_Collateral, Var_SECURITY) & hasType(type_Object, Var_SECURITY)) => 
(((((f_securedBy(Var_LOAN,Var_SECURITY)) & (((f_lender(Var_LOAN,Var_BANK)) & (f_patient(Var_DEFAULT,Var_LOAN)))))) => (f_holdsDuring(f_ImmediateFutureFn(f_WhenFn(Var_DEFAULT)),possesses(Var_BANK,Var_SECURITY))))))))))))))))).

fof(axFinancialLem60, axiom, 
 ( ! [Var_LOAN] : 
 (hasType(type_SecuredLoan, Var_LOAN) => 
(( ? [Var_SECURITY] : 
 (hasType(type_Collateral, Var_SECURITY) &  
(f_securedBy(Var_LOAN,Var_SECURITY)))))))).

fof(axFinancialLem61, axiom, 
 ( ! [Var_LOAN] : 
 (hasType(type_Mortgage, Var_LOAN) => 
(( ? [Var_ESTATE] : 
 (hasType(type_RealEstate, Var_ESTATE) &  
(f_loanForPurchase(Var_LOAN,Var_ESTATE)))))))).

fof(axFinancialLem62, axiom, 
 ( ! [Var_LOAN] : 
 (hasType(type_Mortgage, Var_LOAN) => 
(( ! [Var_REALESTATE] : 
 ((hasType(type_Object, Var_REALESTATE) & hasType(type_Collateral, Var_REALESTATE)) => 
(((f_loanForPurchase(Var_LOAN,Var_REALESTATE)) => (f_securedBy(Var_LOAN,Var_REALESTATE)))))))))).

fof(axFinancialLem63, axiom, 
 ( ! [Var_REFINANCING] : 
 (hasType(type_Refinancing, Var_REFINANCING) => 
(( ! [Var_LOAN] : 
 (hasType(type_Loan, Var_LOAN) => 
(( ! [Var_AMOUNT] : 
 (hasType(type_CurrencyMeasure, Var_AMOUNT) => 
(( ! [Var_DATE] : 
 (hasType(type_Day, Var_DATE) => 
(( ! [Var_BORROWER] : 
 (hasType(type_CognitiveAgent, Var_BORROWER) => 
(( ! [Var_COLLATERAL] : 
 (hasType(type_Collateral, Var_COLLATERAL) => 
(( ! [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) => 
(((((f_time(Var_REFINANCING,Var_TIME)) & (((f_securedBy(Var_LOAN,Var_COLLATERAL)) & (((f_borrower(Var_LOAN,Var_BORROWER)) & (((f_currentAccountBalance(Var_LOAN,Var_DATE,Var_AMOUNT)) & (f_patient(Var_REFINANCING,Var_LOAN)))))))))) => (( ? [Var_NEWLOAN] : 
 (hasType(type_Loan, Var_NEWLOAN) &  
(( ? [Var_PAYMENT] : 
 ((hasType(type_Process, Var_PAYMENT) & hasType(type_Physical, Var_PAYMENT) & hasType(type_FinancialTransaction, Var_PAYMENT)) &  
(((f_borrower(Var_NEWLOAN,Var_BORROWER)) & (((f_securedBy(Var_LOAN,Var_COLLATERAL)) & (((f_destination(Var_PAYMENT,f_CurrencyFn(Var_LOAN))) & (((f_time(Var_PAYMENT,Var_TIME)) & (((f_origin(Var_PAYMENT,f_CurrencyFn(Var_NEWLOAN))) & (f_transactionAmount(Var_PAYMENT,Var_AMOUNT))))))))))))))))))))))))))))))))))))))))).

fof(axFinancialLem64, axiom, 
 ( ! [Var_COMMITMENT] : 
 (hasType(type_LoanCommitment, Var_COMMITMENT) => 
(( ? [Var_LOAN] : 
 (hasType(type_Loan, Var_LOAN) &  
(( ? [Var_BORROWER] : 
 (hasType(type_CognitiveAgent, Var_BORROWER) &  
(( ? [Var_LENDER] : 
 (hasType(type_CognitiveAgent, Var_LENDER) &  
(((f_lender(Var_LOAN,Var_LENDER)) & (((f_borrower(Var_LOAN,Var_BORROWER)) & (((f_agreementMember(Var_COMMITMENT,Var_LENDER)) & (f_agreementMember(Var_COMMITMENT,Var_BORROWER)))))))))))))))))))).

fof(axFinancialLem65, axiom, 
 ( ! [Var_LOAN] : 
 (hasType(type_BankTermLoan, Var_LOAN) => 
(( ! [Var_DURATION] : 
 ((hasType(type_RealNumber, Var_DURATION) & hasType(type_Quantity, Var_DURATION)) => 
(( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(((((f_agreementPeriod(Var_LOAN,Var_PERIOD)) & (f_duration(Var_PERIOD,f_MeasureFn(Var_DURATION,inst_YearDuration))))) => (f_greaterThanOrEqualTo(Var_DURATION,1))))))))))))).

fof(axFinancialLem66, axiom, 
 ( ! [Var_LOAN] : 
 (hasType(type_ConsolidationLoan, Var_LOAN) => 
(( ? [Var_LOAN1] : 
 (hasType(type_Loan, Var_LOAN1) &  
(( ? [Var_LOAN2] : 
 (hasType(type_Loan, Var_LOAN2) &  
(( ? [Var_PAYMENT2] : 
 (hasType(type_Process, Var_PAYMENT2) &  
(( ? [Var_PAYMENT1] : 
 (hasType(type_Process, Var_PAYMENT1) &  
(((f_destination(Var_PAYMENT1,f_CurrencyFn(Var_LOAN1))) & (((f_destination(Var_PAYMENT2,f_CurrencyFn(Var_LOAN2))) & (((f_origin(Var_PAYMENT1,f_CurrencyFn(Var_LOAN))) & (f_origin(Var_PAYMENT2,f_CurrencyFn(Var_LOAN)))))))))))))))))))))))).

fof(axFinancialLem67, axiom, 
 ( ! [Var_MORTGAGE] : 
 (hasType(type_ConventionalMortgage, Var_MORTGAGE) => 
(( ? [Var_GOVERNMENT] : 
 (hasType(type_Government, Var_GOVERNMENT) &  
(f_insured(Var_MORTGAGE,Var_GOVERNMENT)))))))).

fof(axFinancialLem68, axiom, 
 ( ! [Var_LOAN] : 
 (hasType(type_DayLoan, Var_LOAN) => 
(( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(((f_agreementPeriod(Var_LOAN,Var_PERIOD)) & (f_duration(Var_PERIOD,f_MeasureFn(1,inst_DayDuration))))))))))).

fof(axFinancialLem69, axiom, 
 ( ! [Var_LOAN] : 
 (hasType(type_SinglePaymentLoan, Var_LOAN) => 
(( ! [Var_MATURITY] : 
 ((hasType(type_Day, Var_MATURITY) & hasType(type_TimePosition, Var_MATURITY)) => 
(( ! [Var_PRINCIPAL] : 
 (hasType(type_CurrencyMeasure, Var_PRINCIPAL) => 
(((((f_principalAmount(Var_LOAN,Var_PRINCIPAL)) & (f_maturityDate(Var_LOAN,Var_MATURITY)))) => (f_amountDue(Var_LOAN,Var_PRINCIPAL,Var_MATURITY))))))))))))).

fof(axFinancialLem70, axiom, 
 ( ! [Var_LOAN] : 
 (hasType(type_InterestOnlyLoan, Var_LOAN) => 
(( ! [Var_DATE] : 
 ((hasType(type_TimePosition, Var_DATE) & hasType(type_TimeInterval, Var_DATE)) => 
(( ! [Var_INTEREST] : 
 ((hasType(type_Interest, Var_INTEREST) & hasType(type_CurrencyMeasure, Var_INTEREST)) => 
(( ! [Var_PRINCIPAL] : 
 (hasType(type_CurrencyMeasure, Var_PRINCIPAL) => 
(( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(((((f_agreementPeriod(Var_LOAN,Var_PERIOD)) & (((f_principalAmount(Var_LOAN,Var_PRINCIPAL)) & (f_interestEarned(Var_LOAN,Var_INTEREST,Var_PERIOD)))))) => (((f_amountDue(Var_LOAN,Var_PRINCIPAL,f_EndFn(Var_PERIOD))) & (((f_amountDue(Var_LOAN,Var_INTEREST,Var_DATE)) & (f_before(f_EndFn(Var_DATE),f_EndFn(Var_PERIOD)))))))))))))))))))))))).

fof(axFinancialLem71, axiom, 
 ( ! [Var_INDEX] : 
 (hasType(type_Index, Var_INDEX) => 
(( ? [Var_PERFORMANCE] : 
 (hasType(type_EconomicIndicator, Var_PERFORMANCE) &  
(f_benchmark(Var_PERFORMANCE,Var_INDEX)))))))).

fof(axFinancialLem72, axiom, 
 ( ! [Var_INFLATION] : 
 (hasType(type_Inflation, Var_INFLATION) => 
(( ! [Var_CPI] : 
 (hasType(type_ConsumerPriceIndex, Var_CPI) => 
(( ! [Var_PPI] : 
 (hasType(type_ProducerPriceIndex, Var_PPI) => 
(((f_benchmark(Var_INFLATION,Var_CPI)) | (f_benchmark(Var_INFLATION,Var_PPI))))))))))))).

fof(axFinancialLem73, axiom, 
 ( ! [Var_INDEX] : 
 (hasType(type_InflationIndex, Var_INDEX) => 
(( ? [Var_INFLATION] : 
 (hasType(type_Inflation, Var_INFLATION) &  
(f_benchmark(Var_INFLATION,Var_INDEX)))))))).

fof(axFinancialLem74, axiom, 
 ( ! [Var_R] : 
 (hasType(type_RealNumber, Var_R) => 
(( ! [Var_N] : 
 ((hasType(type_Nation, Var_N) & hasType(type_Entity, Var_N)) => 
(((f_inflationRateInCountry(Var_N,Var_R)) => (( ? [Var_I] : 
 (hasType(type_Inflation, Var_I) &  
(((f_duration(f_WhenFn(Var_I),inst_YearDuration)) & (((f_experiencer(Var_I,Var_N)) & (f_inflationRate(Var_I,Var_R))))))))))))))))).

fof(axFinancialLem75, axiom, 
 ( ! [Var_INDEX] : 
 (hasType(type_StockIndex, Var_INDEX) => 
(( ? [Var_STOCK] : 
 (hasType(type_Stock, Var_STOCK) &  
(f_benchmark(Var_INDEX,Var_STOCK)))))))).

fof(axFinancialLem76, axiom, 
 ( ! [Var_INVESTMENT] : 
 (hasType(type_Investment, Var_INVESTMENT) => 
(( ? [Var_AGENT] : 
 (hasType(type_Agent, Var_AGENT) &  
(( ? [Var_INVESTING] : 
 (hasType(type_Process, Var_INVESTING) &  
(((f_agent(Var_INVESTING,Var_AGENT)) & (f_possesses(Var_AGENT,Var_INVESTMENT))))))))))))).

fof(axFinancialLem77, axiom, 
 ( ! [Var_ATTRIBUTE] : 
 (hasType(type_InvestmentAttribute, Var_ATTRIBUTE) => 
(( ? [Var_ACCOUNT] : 
 (hasType(type_InvestmentAccount, Var_ACCOUNT) &  
(f_attribute(Var_ACCOUNT,Var_ATTRIBUTE)))))))).

fof(axFinancialLem78, axiom, 
 ( ! [Var_AGENT] : 
 (hasType(type_Agent, Var_AGENT) => 
(( ! [Var_MONEY] : 
 (hasType(type_CurrencyMeasure, Var_MONEY) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Physical, Var_OBJ) & hasType(type_Entity, Var_OBJ)) => 
(((f_price(Var_OBJ,Var_MONEY,Var_AGENT)) => (( ? [Var_BUYING] : 
 (hasType(type_Buying, Var_BUYING) &  
(((f_agent(Var_BUYING,Var_AGENT)) & (((f_patient(Var_BUYING,Var_OBJ)) & (f_transactionAmount(Var_BUYING,Var_MONEY)))))))))))))))))))).

fof(axFinancialLem79, axiom, 
 ( ! [Var_PLACE] : 
 (hasType(type_PlacingAnOrder, Var_PLACE) => 
(( ! [Var_TIME] : 
 ((hasType(type_Entity, Var_TIME) & hasType(type_TimeInterval, Var_TIME)) => 
(((f_WhenFn(Var_PLACE) = Var_TIME) => (( ? [Var_PERIOD] : 
 ((hasType(type_Entity, Var_PERIOD) & hasType(type_TimeInterval, Var_PERIOD)) &  
(( ? [Var_ORDER] : 
 (hasType(type_Physical, Var_ORDER) &  
(((f_WhenFn(Var_ORDER) = Var_PERIOD) & (f_meetsTemporally(Var_TIME,Var_PERIOD)))))))))))))))))).

fof(axFinancialLem80, axiom, 
 ( ! [Var_ORDER] : 
 (hasType(type_LimitOrder, Var_ORDER) => 
(( ? [Var_PRICE] : 
 (hasType(type_CurrencyMeasure, Var_PRICE) &  
(f_limitPrice(Var_ORDER,Var_PRICE)))))))).

fof(axFinancialLem81, axiom, 
 ( ! [Var_BROKER] : 
 (hasType(type_Broker, Var_BROKER) => 
(( ? [Var_CONTRACT] : 
 (hasType(type_ServiceContract, Var_CONTRACT) &  
(f_agreementMember(Var_CONTRACT,Var_BROKER)))))))).

fof(axFinancialLem82, axiom, 
 ( ! [Var_INVESTMENT] : 
 (hasType(type_TaxFreeInvestment, Var_INVESTMENT) => 
(( ? [Var_TAX] : 
 (hasType(type_Tax, Var_TAX) &  
(f_origin(Var_TAX,Var_INVESTMENT)))))))).

fof(axFinancialLem83, axiom, 
 ( ! [Var_INVESTMENT] : 
 (hasType(type_TaxableInvestment, Var_INVESTMENT) => 
(( ? [Var_TAX] : 
 (hasType(type_Tax, Var_TAX) &  
(f_origin(Var_TAX,Var_INVESTMENT)))))))).

fof(axFinancialLem84, axiom, 
 ( ! [Var_STOCK] : 
 (hasType(type_PreferredStock, Var_STOCK) => 
(( ? [Var_DIVIDEND] : 
 (hasType(type_Dividend, Var_DIVIDEND) &  
(( ? [Var_AMOUNT] : 
 (hasType(type_CurrencyMeasure, Var_AMOUNT) &  
(f_transactionAmount(Var_DIVIDEND,Var_AMOUNT))))))))))).

fof(axFinancialLem85, axiom, 
 ( ! [Var_STOCK] : 
 (hasType(type_PennyStock, Var_STOCK) => 
(( ! [Var_DATE] : 
 (hasType(type_Agent, Var_DATE) => 
(( ! [Var_PRICE] : 
 ((hasType(type_RealNumber, Var_PRICE) & hasType(type_Quantity, Var_PRICE)) => 
(((f_askPrice(Var_STOCK,f_MeasureFn(Var_PRICE,inst_UnitedStatesDollar),Var_DATE)) => (f_lessThan(Var_PRICE,5))))))))))))).

fof(axFinancialLem86, axiom, 
 ( ! [Var_TIMEAFTERSPLIT] : 
 ((hasType(type_Agent, Var_TIMEAFTERSPLIT) & hasType(type_TimeInterval, Var_TIMEAFTERSPLIT)) => 
(( ! [Var_NEWNUMBER] : 
 ((hasType(type_Entity, Var_NEWNUMBER) & hasType(type_RealNumber, Var_NEWNUMBER)) => 
(( ! [Var_N3] : 
 ((hasType(type_Entity, Var_N3) & hasType(type_Quantity, Var_N3)) => 
(( ! [Var_TIMEOFSPLIT] : 
 ((hasType(type_Entity, Var_TIMEOFSPLIT) & hasType(type_TimeInterval, Var_TIMEOFSPLIT)) => 
(( ! [Var_N2] : 
 ((hasType(type_Integer, Var_N2) & hasType(type_Quantity, Var_N2)) => 
(( ! [Var_N1] : 
 ((hasType(type_Integer, Var_N1) & hasType(type_Quantity, Var_N1)) => 
(( ! [Var_TIME] : 
 ((hasType(type_Agent, Var_TIME) & hasType(type_TimeInterval, Var_TIME)) => 
(( ! [Var_NUMBER] : 
 ((hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(( ! [Var_STOCKS] : 
 (hasType(type_Physical, Var_STOCKS) => 
(((((f_price(Var_STOCKS,f_MeasureFn(Var_NUMBER,inst_UnitedStatesDollar),Var_TIME)) & (( ? [Var_EVENT] : 
 ((hasType(type_StockSplit, Var_EVENT) & hasType(type_Physical, Var_EVENT)) &  
(((f_splitFor(Var_EVENT,Var_N1,Var_N2)) & (f_WhenFn(Var_EVENT) = Var_TIMEOFSPLIT)))))))) => (((Var_N3 = f_MultiplicationFn(Var_NUMBER,Var_N1)) & (((Var_NEWNUMBER = f_DivisionFn(Var_N3,Var_N2)) & (((f_price(Var_STOCKS,f_MeasureFn(Var_NEWNUMBER,inst_UnitedStatesDollar),Var_TIMEAFTERSPLIT)) & (((f_meetsTemporally(Var_TIME,Var_TIMEOFSPLIT)) & (f_meetsTemporally(Var_TIMEOFSPLIT,Var_TIMEAFTERSPLIT))))))))))))))))))))))))))))))))))))))).

fof(axFinancialLem87, axiom, 
 ( ! [Var_BOND] : 
 (hasType(type_Bond, Var_BOND) => 
(( ? [Var_DATE] : 
 (hasType(type_Day, Var_DATE) &  
(f_maturityDate(Var_BOND,Var_DATE)))))))).

fof(axFinancialLem88, axiom, 
 ( ! [Var_BOND] : 
 (hasType(type_Bond, Var_BOND) => 
(( ! [Var_BONDHOLDER] : 
 ((hasType(type_Agent, Var_BONDHOLDER) & hasType(type_Entity, Var_BONDHOLDER)) => 
(( ! [Var_INTEREST] : 
 ((hasType(type_Interest, Var_INTEREST) & hasType(type_CurrencyMeasure, Var_INTEREST)) => 
(((((f_couponInterest(Var_BOND,Var_INTEREST)) & (f_possesses(Var_BONDHOLDER,Var_BOND)))) => (( ? [Var_PAYMENT] : 
 (hasType(type_Process, Var_PAYMENT) &  
(( ? [Var_PERIOD] : 
 (hasType(type_TimeDuration, Var_PERIOD) &  
(((f_periodicPayment(f_AccountFn(Var_BOND),Var_INTEREST,Var_PERIOD)) & (f_destination(Var_PAYMENT,Var_BONDHOLDER))))))))))))))))))))).

fof(axFinancialLem89, axiom, 
 ( ! [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) => 
(( ! [Var_ASSET] : 
 ((hasType(type_Object, Var_ASSET) & hasType(type_FinancialAsset, Var_ASSET)) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_CognitiveAgent, Var_AGENT)) => 
(((((f_possesses(Var_AGENT,Var_ASSET)) & (Var_ACCOUNT = f_AccountFn(Var_ASSET)))) <=> (f_accountHolder(Var_ACCOUNT,Var_AGENT))))))))))))).

fof(axFinancialLem90, axiom, 
 ( ! [Var_BOND] : 
 (hasType(type_ZeroCouponBond, Var_BOND) => 
(( ! [Var_BONDACCOUNT] : 
 (hasType(type_FinancialAccount, Var_BONDACCOUNT) => 
(( ! [Var_TOTAL] : 
 ((hasType(type_Entity, Var_TOTAL) & hasType(type_CurrencyMeasure, Var_TOTAL)) => 
(( ! [Var_INTEREST] : 
 ((hasType(type_Interest, Var_INTEREST) & hasType(type_Quantity, Var_INTEREST)) => 
(( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(( ! [Var_PRINCIPAL] : 
 ((hasType(type_CurrencyMeasure, Var_PRINCIPAL) & hasType(type_Quantity, Var_PRINCIPAL)) => 
(( ! [Var_BONDHOLDER] : 
 ((hasType(type_Agent, Var_BONDHOLDER) & hasType(type_Entity, Var_BONDHOLDER)) => 
(( ! [Var_DATE] : 
 (hasType(type_Day, Var_DATE) => 
(((((f_maturityDate(f_AccountFn(Var_BOND),Var_DATE)) & (((f_possesses(Var_BONDHOLDER,Var_BOND)) & (((f_principalAmount(f_AccountFn(Var_BOND),Var_PRINCIPAL)) & (((f_agreementPeriod(f_AccountFn(Var_BOND),Var_PERIOD)) & (((f_interestEarned(f_AccountFn(Var_BOND),Var_INTEREST,Var_PERIOD)) & (Var_TOTAL = f_AdditionFn(Var_PRINCIPAL,Var_INTEREST)))))))))))) => (( ? [Var_PAYMENT] : 
 (hasType(type_Payment, Var_PAYMENT) &  
(((f_destination(Var_PAYMENT,Var_BONDHOLDER)) & (((f_origin(Var_PAYMENT,f_CurrencyFn(Var_BONDACCOUNT))) & (f_transactionAmount(Var_PAYMENT,Var_TOTAL))))))))))))))))))))))))))))))))))).

fof(axFinancialLem91, axiom, 
 ( ! [Var_BOND] : 
 (hasType(type_MunicipalBond, Var_BOND) => 
(( ? [Var_AGENT] : 
 (hasType(type_Government, Var_AGENT) &  
(f_issuedBy(Var_BOND,Var_AGENT)))))))).

fof(axFinancialLem92, axiom, 
 ( ! [Var_BOND] : 
 (hasType(type_CorporateBond, Var_BOND) => 
(( ? [Var_AGENT] : 
 (hasType(type_Corporation, Var_AGENT) &  
(f_issuedBy(Var_BOND,Var_AGENT)))))))).

fof(axFinancialLem93, axiom, 
 ( ! [Var_BOND] : 
 (hasType(type_SecuredBond, Var_BOND) => 
(( ? [Var_SECURITY] : 
 (hasType(type_Collateral, Var_SECURITY) &  
(f_securedBy(Var_BOND,Var_SECURITY)))))))).

fof(axFinancialLem94, axiom, 
 ( ! [Var_BOND] : 
 (hasType(type_SecuredBond, Var_BOND) => 
(( ! [Var_DEFAULT] : 
 (hasType(type_FinancialDefault, Var_DEFAULT) => 
(( ! [Var_AGENT] : 
 (hasType(type_Agent, Var_AGENT) => 
(( ! [Var_SECURITY] : 
 ((hasType(type_Collateral, Var_SECURITY) & hasType(type_Object, Var_SECURITY)) => 
(((((f_securedBy(Var_BOND,Var_SECURITY)) & (((f_possesses(Var_AGENT,Var_BOND)) & (f_patient(Var_DEFAULT,Var_BOND)))))) => (f_holdsDuring(f_ImmediateFutureFn(f_WhenFn(Var_DEFAULT)),possesses(Var_AGENT,Var_SECURITY))))))))))))))))).

fof(axFinancialLem95, axiom, 
 ( ! [Var_BOND] : 
 (hasType(type_TreasuryBond, Var_BOND) => 
(( ? [Var_AGENT] : 
 (hasType(type_Government, Var_AGENT) &  
(f_issuedBy(Var_BOND,Var_AGENT)))))))).

fof(axFinancialLem96, axiom, 
 ( ! [Var_BOND] : 
 (hasType(type_CallableBond, Var_BOND) => 
(( ! [Var_AMOUNT] : 
 (hasType(type_CurrencyMeasure, Var_AMOUNT) => 
(( ! [Var_DATE] : 
 ((hasType(type_Day, Var_DATE) & hasType(type_TimePosition, Var_DATE)) => 
(((((f_currentAccountBalance(f_AccountFn(Var_BOND),Var_DATE,Var_AMOUNT)) & (f_callDate(Var_BOND,Var_DATE)))) => (f_amountDue(f_AccountFn(Var_BOND),Var_AMOUNT,Var_DATE))))))))))))).

fof(axFinancialLem97, axiom, 
 ( ! [Var_OPTION] : 
 (hasType(type_ConventionalOption, Var_OPTION) => 
(( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(( ? [Var_NUMBER] : 
 ((hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) &  
(((f_agreementPeriod(Var_OPTION,Var_PERIOD)) & (((f_duration(Var_PERIOD,f_MeasureFn(Var_NUMBER,inst_MonthDuration))) & (f_lessThan(Var_NUMBER,9))))))))))))))).

fof(axFinancialLem98, axiom, 
 ( ! [Var_OPTION] : 
 (hasType(type_ConventionalOption, Var_OPTION) => 
(( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(( ? [Var_NUMBER] : 
 ((hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) &  
(((f_agreementPeriod(Var_OPTION,Var_PERIOD)) & (((f_duration(Var_PERIOD,f_MeasureFn(Var_NUMBER,inst_MonthDuration))) & (f_lessThan(Var_NUMBER,39))))))))))))))).

fof(axFinancialLem99, axiom, 
 ( ! [Var_DATE] : 
 ((hasType(type_Day, Var_DATE) & hasType(type_TimeInterval, Var_DATE)) => 
(( ! [Var_CONTRACT] : 
 (hasType(type_Contract, Var_CONTRACT) => 
(((f_expirationDate(Var_CONTRACT,Var_DATE)) => (( ? [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) &  
(((f_agreementPeriod(Var_CONTRACT,Var_PERIOD)) & (f_finishes(Var_DATE,Var_PERIOD))))))))))))))).

fof(axFinancialLem100, axiom, 
 ( ! [Var_AGENT] : 
 (hasType(type_CognitiveAgent, Var_AGENT) => 
(( ! [Var_PREMIUM] : 
 (hasType(type_CurrencyMeasure, Var_PREMIUM) => 
(( ! [Var_OPTION] : 
 ((hasType(type_Option, Var_OPTION) & hasType(type_Investment, Var_OPTION)) => 
(((((f_premium(Var_OPTION,Var_PREMIUM)) & (f_optionHolder(Var_OPTION,Var_AGENT)))) => (f_potentialLoss(Var_AGENT,Var_OPTION,Var_PREMIUM))))))))))))).

fof(axFinancialLem101, axiom, 
 ( ! [Var_KILL] : 
 (hasType(type_CancellingAnOrder, Var_KILL) => 
(( ! [Var_ORDER] : 
 ((hasType(type_Entity, Var_ORDER) & hasType(type_Contract, Var_ORDER)) => 
(((f_patient(Var_KILL,Var_ORDER)) => (( ~ (f_agreementActive(Var_ORDER,f_ImmediateFutureFn(f_WhenFn(Var_KILL)))))))))))))).

fof(axFinancialLem102, axiom, 
 ( ! [Var_ORDER] : 
 (hasType(type_IOCOrder, Var_ORDER) => 
(( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(((f_agreementPeriod(Var_ORDER,Var_PERIOD)) => (((( ? [Var_FILL] : 
 (hasType(type_FillingAnOrder, Var_FILL) &  
(( ? [Var_TIME1] : 
 ((hasType(type_Entity, Var_TIME1) & hasType(type_TimeInterval, Var_TIME1)) &  
(((f_patient(Var_FILL,Var_ORDER)) & (((f_WhenFn(Var_FILL) = Var_TIME1) & (f_starts(Var_TIME1,Var_PERIOD)))))))))))) | (( ? [Var_KILL] : 
 (hasType(type_CancellingAnOrder, Var_KILL) &  
(( ? [Var_TIME2] : 
 ((hasType(type_Entity, Var_TIME2) & hasType(type_TimeInterval, Var_TIME2)) &  
(((f_patient(Var_KILL,Var_ORDER)) & (((f_WhenFn(Var_KILL) = Var_TIME2) & (f_starts(Var_TIME2,Var_PERIOD)))))))))))))))))))))).

fof(axFinancialLem103, axiom, 
 ( ! [Var_ORDER] : 
 (hasType(type_FOKOrder, Var_ORDER) => 
(( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(((f_agreementPeriod(Var_ORDER,Var_PERIOD)) => (((( ? [Var_FILL] : 
 (hasType(type_FillingAnOrder, Var_FILL) &  
(( ? [Var_TIME1] : 
 ((hasType(type_Entity, Var_TIME1) & hasType(type_TimeInterval, Var_TIME1)) &  
(((f_patient(Var_FILL,Var_ORDER)) & (((f_WhenFn(Var_FILL) = Var_TIME1) & (f_starts(Var_TIME1,Var_PERIOD)))))))))))) | (( ? [Var_KILL] : 
 (hasType(type_CancellingAnOrder, Var_KILL) &  
(( ? [Var_TIME2] : 
 ((hasType(type_Entity, Var_TIME2) & hasType(type_TimeInterval, Var_TIME2)) &  
(((f_patient(Var_KILL,Var_ORDER)) & (((f_WhenFn(Var_KILL) = Var_TIME2) & (f_starts(Var_TIME2,Var_PERIOD)))))))))))))))))))))).

fof(axFinancialLem104, axiom, 
 ( ! [Var_ORDER] : 
 (hasType(type_GTCOrder, Var_ORDER) => 
(( ! [Var_END] : 
 ((hasType(type_Entity, Var_END) & hasType(type_TimeInterval, Var_END)) => 
(( ! [Var_TIME] : 
 ((hasType(type_Entity, Var_TIME) & hasType(type_TimeInterval, Var_TIME)) => 
(( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(((f_agreementPeriod(Var_ORDER,Var_PERIOD)) => (((( ? [Var_EXECUTE] : 
 (hasType(type_FillingAnOrder, Var_EXECUTE) &  
(((f_patient(Var_EXECUTE,Var_ORDER)) & (((f_WhenFn(Var_EXECUTE) = Var_TIME) & (f_overlapsTemporally(Var_TIME,Var_PERIOD))))))))) | (( ? [Var_CANCEL] : 
 (hasType(type_CancellingAnOrder, Var_CANCEL) &  
(((f_patient(Var_CANCEL,Var_ORDER)) & (((f_WhenFn(Var_CANCEL) = Var_END) & (f_finishes(Var_END,Var_PERIOD))))))))))))))))))))))))).

fof(axFinancialLem105, axiom, 
 ( ! [Var_ORDER] : 
 (hasType(type_DayOrder, Var_ORDER) => 
(( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(((f_agreementPeriod(Var_ORDER,Var_PERIOD)) & (f_duration(Var_PERIOD,f_MeasureFn(1,inst_DayDuration))))))))))).

fof(axFinancialLem106, axiom, 
 ( ! [Var_OPTION] : 
 (hasType(type_CallOption, Var_OPTION) => 
(( ! [Var_TIME] : 
 ((hasType(type_Agent, Var_TIME) & hasType(type_TimePosition, Var_TIME)) => 
(((( ? [Var_STRIKEPRICE] : 
 ((hasType(type_CurrencyMeasure, Var_STRIKEPRICE) & hasType(type_Quantity, Var_STRIKEPRICE)) &  
(( ? [Var_STOCKPRICE] : 
 ((hasType(type_CurrencyMeasure, Var_STOCKPRICE) & hasType(type_Quantity, Var_STOCKPRICE)) &  
(( ? [Var_STOCK] : 
 ((hasType(type_FinancialInstrument, Var_STOCK) & hasType(type_Physical, Var_STOCK)) &  
(((f_underlier(Var_OPTION,Var_STOCK)) & (((f_price(Var_STOCK,Var_STOCKPRICE,Var_TIME)) & (((f_strikePrice(Var_OPTION,Var_STRIKEPRICE)) & (f_lessThan(Var_STRIKEPRICE,Var_STOCKPRICE))))))))))))))))) <=> (f_inTheMoney(Var_OPTION,Var_TIME)))))))))).

fof(axFinancialLem107, axiom, 
 ( ! [Var_OPTION] : 
 (hasType(type_PutOption, Var_OPTION) => 
(( ! [Var_TIME] : 
 ((hasType(type_Agent, Var_TIME) & hasType(type_TimePosition, Var_TIME)) => 
(((( ? [Var_STRIKEPRICE] : 
 ((hasType(type_CurrencyMeasure, Var_STRIKEPRICE) & hasType(type_Quantity, Var_STRIKEPRICE)) &  
(( ? [Var_STOCKPRICE] : 
 ((hasType(type_CurrencyMeasure, Var_STOCKPRICE) & hasType(type_Quantity, Var_STOCKPRICE)) &  
(( ? [Var_STOCK] : 
 ((hasType(type_FinancialInstrument, Var_STOCK) & hasType(type_Physical, Var_STOCK)) &  
(((f_underlier(Var_OPTION,Var_STOCK)) & (((f_price(Var_STOCK,Var_STOCKPRICE,Var_TIME)) & (((f_strikePrice(Var_OPTION,Var_STRIKEPRICE)) & (f_lessThan(Var_STOCKPRICE,Var_STRIKEPRICE))))))))))))))))) <=> (f_inTheMoney(Var_OPTION,Var_TIME)))))))))).

fof(axFinancialLem108, axiom, 
 ( ! [Var_OPTION] : 
 (hasType(type_Option, Var_OPTION) => 
(( ! [Var_TIME] : 
 ((hasType(type_Agent, Var_TIME) & hasType(type_TimePosition, Var_TIME)) => 
(((( ? [Var_STRIKEPRICE] : 
 ((hasType(type_CurrencyMeasure, Var_STRIKEPRICE) & hasType(type_Entity, Var_STRIKEPRICE)) &  
(( ? [Var_STOCKPRICE] : 
 ((hasType(type_CurrencyMeasure, Var_STOCKPRICE) & hasType(type_Entity, Var_STOCKPRICE)) &  
(( ? [Var_STOCK] : 
 ((hasType(type_FinancialInstrument, Var_STOCK) & hasType(type_Physical, Var_STOCK)) &  
(((f_underlier(Var_OPTION,Var_STOCK)) & (((f_price(Var_STOCK,Var_STOCKPRICE,Var_TIME)) & (((f_strikePrice(Var_OPTION,Var_STRIKEPRICE)) & (Var_STOCKPRICE = Var_STRIKEPRICE)))))))))))))))) <=> (f_atTheMoney(Var_OPTION,Var_TIME)))))))))).

fof(axFinancialLem109, axiom, 
 ( ! [Var_OPTION] : 
 (hasType(type_CallOption, Var_OPTION) => 
(( ! [Var_TIME] : 
 ((hasType(type_Agent, Var_TIME) & hasType(type_TimePosition, Var_TIME)) => 
(((( ? [Var_STRIKEPRICE] : 
 ((hasType(type_CurrencyMeasure, Var_STRIKEPRICE) & hasType(type_Quantity, Var_STRIKEPRICE)) &  
(( ? [Var_STOCKPRICE] : 
 ((hasType(type_CurrencyMeasure, Var_STOCKPRICE) & hasType(type_Quantity, Var_STOCKPRICE)) &  
(( ? [Var_STOCK] : 
 ((hasType(type_FinancialInstrument, Var_STOCK) & hasType(type_Physical, Var_STOCK)) &  
(((f_underlier(Var_OPTION,Var_STOCK)) & (((f_price(Var_STOCK,Var_STOCKPRICE,Var_TIME)) & (((f_strikePrice(Var_OPTION,Var_STRIKEPRICE)) & (f_lessThan(Var_STOCKPRICE,Var_STRIKEPRICE))))))))))))))))) <=> (f_outOfTheMoney(Var_OPTION,Var_TIME)))))))))).

fof(axFinancialLem110, axiom, 
 ( ! [Var_OPTION] : 
 (hasType(type_PutOption, Var_OPTION) => 
(( ! [Var_TIME] : 
 ((hasType(type_Agent, Var_TIME) & hasType(type_TimePosition, Var_TIME)) => 
(((( ? [Var_STRIKEPRICE] : 
 ((hasType(type_CurrencyMeasure, Var_STRIKEPRICE) & hasType(type_Quantity, Var_STRIKEPRICE)) &  
(( ? [Var_STOCKPRICE] : 
 ((hasType(type_CurrencyMeasure, Var_STOCKPRICE) & hasType(type_Quantity, Var_STOCKPRICE)) &  
(( ? [Var_STOCK] : 
 ((hasType(type_FinancialInstrument, Var_STOCK) & hasType(type_Physical, Var_STOCK)) &  
(((f_underlier(Var_OPTION,Var_STOCK)) & (((f_price(Var_STOCK,Var_STOCKPRICE,Var_TIME)) & (((f_strikePrice(Var_OPTION,Var_STRIKEPRICE)) & (f_lessThan(Var_STRIKEPRICE,Var_STOCKPRICE))))))))))))))))) <=> (f_outOfTheMoney(Var_OPTION,Var_TIME)))))))))).

fof(axFinancialLem111, axiom, 
 ( ! [Var_SPREAD] : 
 (hasType(type_SpreadOption, Var_SPREAD) => 
(( ? [Var_OPTION1] : 
 (hasType(type_Option, Var_OPTION1) &  
(( ? [Var_OPTION2] : 
 (hasType(type_Option, Var_OPTION2) &  
(( ? [Var_BUY] : 
 (hasType(type_Buying, Var_BUY) &  
(( ? [Var_SELL] : 
 (hasType(type_Selling, Var_SELL) &  
(( ? [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) &  
(((f_patient(Var_BUY,Var_OPTION1)) & (((f_patient(Var_SELL,Var_OPTION2)) & (((f_time(Var_BUY,Var_TIME)) & (f_time(Var_SELL,Var_TIME)))))))))))))))))))))))))).

fof(axFinancialLem112, axiom, 
 ( ! [Var_SPREAD] : 
 (hasType(type_ButterflySpread, Var_SPREAD) => 
(( ? [Var_CALL1] : 
 (hasType(type_CallOption, Var_CALL1) &  
(( ? [Var_CALL2] : 
 (hasType(type_CallOption, Var_CALL2) &  
(( ? [Var_CALL3] : 
 (hasType(type_CallOption, Var_CALL3) &  
(( ? [Var_CALL4] : 
 (hasType(type_CallOption, Var_CALL4) &  
(( ? [Var_PRICE4] : 
 ((hasType(type_CurrencyMeasure, Var_PRICE4) & hasType(type_Quantity, Var_PRICE4)) &  
(( ? [Var_PRICE3] : 
 ((hasType(type_CurrencyMeasure, Var_PRICE3) & hasType(type_Quantity, Var_PRICE3)) &  
(( ? [Var_PRICE2] : 
 ((hasType(type_CurrencyMeasure, Var_PRICE2) & hasType(type_Quantity, Var_PRICE2)) &  
(( ? [Var_PRICE1] : 
 ((hasType(type_CurrencyMeasure, Var_PRICE1) & hasType(type_Quantity, Var_PRICE1)) &  
(((f_strikePrice(Var_CALL1,Var_PRICE1)) & (((f_strikePrice(Var_CALL2,Var_PRICE2)) & (((f_strikePrice(Var_CALL3,Var_PRICE3)) & (((f_strikePrice(Var_CALL4,Var_PRICE4)) & (((f_lessThan(Var_PRICE1,Var_PRICE2)) & (((f_lessThan(Var_PRICE1,Var_PRICE3)) & (((f_greaterThan(Var_PRICE4,Var_PRICE2)) & (f_greaterThan(Var_PRICE4,Var_PRICE2))))))))))))))))))))))))))))))))))))))))))).

fof(axFinancialLem113, axiom, 
 ( ! [Var_TRANSACTION] : 
 (hasType(type_StockMarketTransaction, Var_TRANSACTION) => 
(( ? [Var_MARKET] : 
 (hasType(type_StockMarket, Var_MARKET) &  
(f_located(Var_TRANSACTION,Var_MARKET)))))))).

fof(axFinancialLem114, axiom, 
 ( ! [Var_UPTICK] : 
 (hasType(type_Uptick, Var_UPTICK) => 
(( ! [Var_PRICE2] : 
 ((hasType(type_CurrencyMeasure, Var_PRICE2) & hasType(type_Quantity, Var_PRICE2)) => 
(( ! [Var_PRICE1] : 
 ((hasType(type_CurrencyMeasure, Var_PRICE1) & hasType(type_Quantity, Var_PRICE1)) => 
(( ! [Var_TIME1] : 
 ((hasType(type_Entity, Var_TIME1) & hasType(type_Agent, Var_TIME1) & hasType(type_TimeInterval, Var_TIME1)) => 
(( ! [Var_STOCK] : 
 ((hasType(type_Entity, Var_STOCK) & hasType(type_Physical, Var_STOCK)) => 
(((((f_patient(Var_UPTICK,Var_STOCK)) & (((f_WhenFn(Var_UPTICK) = Var_TIME1) & (f_price(Var_STOCK,Var_PRICE1,Var_TIME1)))))) => (( ? [Var_TRANSACTION] : 
 (hasType(type_StockMarketTransaction, Var_TRANSACTION) &  
(( ? [Var_TIME2] : 
 ((hasType(type_Entity, Var_TIME2) & hasType(type_TimeInterval, Var_TIME2) & hasType(type_Agent, Var_TIME2)) &  
(((f_patient(Var_TRANSACTION,Var_STOCK)) & (((f_WhenFn(Var_TRANSACTION) = Var_TIME2) & (((f_meetsTemporally(Var_TIME2,Var_TIME1)) & (((f_price(Var_STOCK,Var_PRICE2,Var_TIME2)) & (f_lessThan(Var_PRICE2,Var_PRICE1))))))))))))))))))))))))))))))))).

fof(axFinancialLem115, axiom, 
 ( ! [Var_DOWNTICK] : 
 (hasType(type_Downtick, Var_DOWNTICK) => 
(( ! [Var_PRICE2] : 
 ((hasType(type_CurrencyMeasure, Var_PRICE2) & hasType(type_Quantity, Var_PRICE2)) => 
(( ! [Var_PRICE1] : 
 ((hasType(type_CurrencyMeasure, Var_PRICE1) & hasType(type_Quantity, Var_PRICE1)) => 
(( ! [Var_TIME1] : 
 ((hasType(type_Entity, Var_TIME1) & hasType(type_Agent, Var_TIME1) & hasType(type_TimeInterval, Var_TIME1)) => 
(( ! [Var_STOCK] : 
 ((hasType(type_Entity, Var_STOCK) & hasType(type_Physical, Var_STOCK)) => 
(((((f_patient(Var_DOWNTICK,Var_STOCK)) & (((f_WhenFn(Var_DOWNTICK) = Var_TIME1) & (f_price(Var_STOCK,Var_PRICE1,Var_TIME1)))))) => (( ? [Var_TRANSACTION] : 
 (hasType(type_StockMarketTransaction, Var_TRANSACTION) &  
(( ? [Var_TIME2] : 
 ((hasType(type_Entity, Var_TIME2) & hasType(type_TimeInterval, Var_TIME2) & hasType(type_Agent, Var_TIME2)) &  
(((f_patient(Var_TRANSACTION,Var_STOCK)) & (((f_WhenFn(Var_TRANSACTION) = Var_TIME2) & (((f_meetsTemporally(Var_TIME2,Var_TIME1)) & (((f_price(Var_STOCK,Var_PRICE2,Var_TIME2)) & (f_greaterThan(Var_PRICE2,Var_PRICE1))))))))))))))))))))))))))))))))).

fof(axFinancialLem116, axiom, 
 ( ! [Var_AGENT] : 
 (hasType(type_CognitiveAgent, Var_AGENT) => 
(( ! [Var_ORG] : 
 ((hasType(type_Organization, Var_ORG) & hasType(type_CognitiveAgent, Var_ORG)) => 
(((f_employs(Var_ORG,Var_AGENT)) <=> (( ? [Var_EMPLOYMENT] : 
 (hasType(type_Employment, Var_EMPLOYMENT) &  
(((f_agreementMember(Var_EMPLOYMENT,Var_ORG)) & (f_agreementMember(Var_EMPLOYMENT,Var_AGENT))))))))))))))).

fof(axFinancialLem117, axiom, 
 ( ! [Var_MONEY] : 
 (hasType(type_CurrencyMeasure, Var_MONEY) => 
(( ! [Var_AGENT] : 
 (hasType(type_Human, Var_AGENT) => 
(((f_monthlyIncome(Var_AGENT,Var_MONEY)) <=> (( ? [Var_MONTH] : 
 (hasType(type_Month, Var_MONTH) &  
(f_income(Var_AGENT,Var_MONEY,Var_MONTH))))))))))))).

fof(axFinancialLem118, axiom, 
 ( ! [Var_ACTIVITY] : 
 ((hasType(type_OrganizationalProcess, Var_ACTIVITY) & hasType(type_Process, Var_ACTIVITY)) => 
(( ! [Var_MONEY] : 
 (hasType(type_CurrencyMeasure, Var_MONEY) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Human, Var_AGENT) & hasType(type_Agent, Var_AGENT)) => 
(((f_incomeEarned(Var_AGENT,Var_MONEY,Var_ACTIVITY)) => (f_agent(Var_ACTIVITY,Var_AGENT))))))))))))).

fof(axFinancialLem119, axiom, 
 ( ! [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) => 
(( ! [Var_ACTIVITY] : 
 ((hasType(type_OrganizationalProcess, Var_ACTIVITY) & hasType(type_Physical, Var_ACTIVITY) & hasType(type_Process, Var_ACTIVITY)) => 
(( ! [Var_INCOME] : 
 (hasType(type_CurrencyMeasure, Var_INCOME) => 
(( ! [Var_AGENT] : 
 (hasType(type_Human, Var_AGENT) => 
(((((f_taxDeferredIncome(Var_AGENT,Var_INCOME,Var_ACTIVITY)) & (f_time(Var_ACTIVITY,Var_TIME)))) => (( ? [Var_TAX] : 
 (hasType(type_Tax, Var_TAX) &  
(((f_causes(Var_ACTIVITY,Var_TAX)) & (f_time(Var_TAX,Var_TIME))))))))))))))))))))).

fof(axFinancialLem120, axiom, 
 ( ! [Var_ATINCOME] : 
 ((hasType(type_Entity, Var_ATINCOME) & hasType(type_OrganizationalProcess, Var_ATINCOME)) => 
(( ! [Var_ACTIVITY] : 
 ((hasType(type_OrganizationalProcess, Var_ACTIVITY) & hasType(type_Process, Var_ACTIVITY) & hasType(type_CurrencyMeasure, Var_ACTIVITY)) => 
(( ! [Var_AGENT] : 
 (hasType(type_Human, Var_AGENT) => 
(((( ? [Var_TAXAMOUNT] : 
 ((hasType(type_CurrencyMeasure, Var_TAXAMOUNT) & hasType(type_Quantity, Var_TAXAMOUNT)) &  
(( ? [Var_TAX] : 
 ((hasType(type_ChargingAFee, Var_TAX) & hasType(type_Process, Var_TAX)) &  
(( ? [Var_INCOME] : 
 ((hasType(type_CurrencyMeasure, Var_INCOME) & hasType(type_Quantity, Var_INCOME)) &  
(((f_incomeEarned(Var_AGENT,Var_INCOME,Var_ACTIVITY)) & (((f_amountCharged(Var_TAX,Var_TAXAMOUNT)) & (((f_causes(Var_ACTIVITY,Var_TAX)) & (Var_ATINCOME = f_SubtractionFn(Var_INCOME,Var_TAXAMOUNT))))))))))))))))) <=> (f_afterTaxIncome(Var_AGENT,Var_ACTIVITY,Var_ATINCOME))))))))))))).

fof(axFinancialLem121, axiom, 
 ( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(( ! [Var_MONEY] : 
 (hasType(type_CurrencyMeasure, Var_MONEY) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Human, Var_AGENT) & hasType(type_CognitiveAgent, Var_AGENT) & hasType(type_Entity, Var_AGENT)) => 
(((f_employeeContribution(Var_AGENT,Var_MONEY,Var_PERIOD)) => (( ? [Var_PLAN] : 
 (hasType(type_PensionPlan, Var_PLAN) &  
(( ? [Var_ORG] : 
 ((hasType(type_Organization, Var_ORG) & hasType(type_Agent, Var_ORG)) &  
(((f_employs(Var_ORG,Var_AGENT)) & (((f_agent(Var_PLAN,Var_ORG)) & (f_destination(Var_PLAN,Var_AGENT))))))))))))))))))))))).

fof(axFinancialLem122, axiom, 
 ( ! [Var_PERIOD] : 
 ((hasType(type_TimePosition, Var_PERIOD) & hasType(type_Entity, Var_PERIOD)) => 
(( ! [Var_MONEY] : 
 (hasType(type_CurrencyMeasure, Var_MONEY) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Human, Var_AGENT) & hasType(type_Agent, Var_AGENT)) => 
(((f_compensationPackage(Var_AGENT,Var_MONEY,Var_PERIOD)) => (( ? [Var_ACTIVITY] : 
 (hasType(type_Working, Var_ACTIVITY) &  
(((f_agent(Var_ACTIVITY,Var_AGENT)) & (((Var_PERIOD = f_WhenFn(Var_ACTIVITY)) & (f_incomeEarned(Var_AGENT,Var_MONEY,Var_ACTIVITY)))))))))))))))))))).

fof(axFinancialLem123, axiom, 
 ( ! [Var_STARTDATE] : 
 ((hasType(type_Day, Var_STARTDATE) & hasType(type_TimeInterval, Var_STARTDATE)) => 
(( ! [Var_AGREEMENT] : 
 (hasType(type_Contract, Var_AGREEMENT) => 
(((f_effectiveDate(Var_AGREEMENT,Var_STARTDATE)) <=> (( ? [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) &  
(((f_agreementPeriod(Var_AGREEMENT,Var_PERIOD)) & (f_starts(Var_STARTDATE,Var_PERIOD))))))))))))))).

fof(axFinancialLem124, axiom, 
 ( ! [Var_CASH] : 
 (hasType(type_Cash, Var_CASH) => 
(( ? [Var_VALUE] : 
 (hasType(type_CurrencyMeasure, Var_VALUE) &  
(f_monetaryValue(Var_CASH,Var_VALUE)))))))).

fof(axFinancialLem125, axiom, 
 ( ! [Var_INVESTMENT] : 
 (hasType(type_Investment, Var_INVESTMENT) => 
(( ! [Var_LEVEL] : 
 (hasType(type_RiskAttribute, Var_LEVEL) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Investor, Var_AGENT) & hasType(type_Agent, Var_AGENT)) => 
(((((f_riskTolerance(Var_AGENT,Var_LEVEL)) & (f_possesses(Var_AGENT,Var_INVESTMENT)))) => (f_riskLevel(Var_INVESTMENT,Var_LEVEL))))))))))))).

fof(axFinancialLem126, axiom, 
 ( ! [Var_ACCOUNT] : 
 ((hasType(type_FinancialAccount, Var_ACCOUNT) & hasType(type_Entity, Var_ACCOUNT)) => 
(( ! [Var_CARD] : 
 (hasType(type_BankCard, Var_CARD) => 
(( ! [Var_CODE] : 
 (hasType(type_ContentBearingObject, Var_CODE) => 
(((((f_cardCode(Var_CODE,Var_CARD)) & (f_cardAccount(Var_CARD,Var_ACCOUNT)))) => (( ? [Var_ENCODING] : 
 (hasType(type_Encoding, Var_ENCODING) &  
(f_patient(Var_ENCODING,Var_ACCOUNT)))))))))))))))).

fof(axFinancialLem127, axiom, 
 ( ! [Var_CARD] : 
 (hasType(type_DebitCard, Var_CARD) => 
(( ! [Var_TRANSACTION] : 
 (hasType(type_FinancialTransaction, Var_TRANSACTION) => 
(( ! [Var_AGENT] : 
 (hasType(type_Agent, Var_AGENT) => 
(((((f_possesses(Var_AGENT,Var_CARD)) & (f_instrument(Var_TRANSACTION,Var_CARD)))) => (( ? [Var_ENTER] : 
 (hasType(type_EnteringAPin, Var_ENTER) &  
(( ? [Var_PIN] : 
 ((hasType(type_SymbolicString, Var_PIN) & hasType(type_Entity, Var_PIN)) &  
(((f_pin(Var_PIN,Var_CARD)) & (((f_patient(Var_ENTER,Var_PIN)) & (f_agent(Var_ENTER,Var_AGENT))))))))))))))))))))))).

fof(axFinancialLem128, axiom, 
 ( ! [Var_ENTER] : 
 (hasType(type_EnteringAPin, Var_ENTER) => 
(( ? [Var_CARD] : 
 (hasType(type_BankCard, Var_CARD) &  
(( ? [Var_PIN] : 
 ((hasType(type_SymbolicString, Var_PIN) & hasType(type_Entity, Var_PIN)) &  
(((f_pin(Var_PIN,Var_CARD)) & (f_patient(Var_ENTER,Var_PIN))))))))))))).

fof(axFinancialLem129, axiom, 
 ( ! [Var_CHECK] : 
 (hasType(type_VerifyingCardCode, Var_CHECK) => 
(( ! [Var_CARD] : 
 (hasType(type_BankCard, Var_CARD) => 
(( ! [Var_CODE] : 
 ((hasType(type_Entity, Var_CODE) & hasType(type_ContentBearingObject, Var_CODE)) => 
(((((f_patient(Var_CHECK,Var_CODE)) & (f_cardCode(Var_CODE,Var_CARD)))) => (( ? [Var_DECODE] : 
 (hasType(type_Decoding, Var_DECODE) &  
(((f_subProcess(Var_DECODE,Var_CHECK)) & (f_patient(Var_DECODE,Var_CODE)))))))))))))))))).

fof(axFinancialLem130, axiom, 
 ( ! [Var_AGENT2] : 
 ((hasType(type_CognitiveAgent, Var_AGENT2) & hasType(type_Agent, Var_AGENT2)) => 
(( ! [Var_AGENT1] : 
 ((hasType(type_CognitiveAgent, Var_AGENT1) & hasType(type_Entity, Var_AGENT1)) => 
(((f_customer(Var_AGENT1,Var_AGENT2)) <=> (( ? [Var_SERVICE] : 
 (hasType(type_FinancialTransaction, Var_SERVICE) &  
(((f_agent(Var_SERVICE,Var_AGENT2)) & (f_destination(Var_SERVICE,Var_AGENT1))))))))))))))).

fof(axFinancialLem131, axiom, 
 ( ! [Var_BANK] : 
 ((hasType(type_FinancialOrganization, Var_BANK) & hasType(type_CognitiveAgent, Var_BANK)) => 
(( ! [Var_AGENT] : 
 (hasType(type_CognitiveAgent, Var_AGENT) => 
(( ! [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) => 
(((((f_accountHolder(Var_ACCOUNT,Var_AGENT)) & (f_accountAt(Var_ACCOUNT,Var_BANK)))) => (f_customer(Var_AGENT,Var_BANK))))))))))))).

fof(axFinancialLem132, axiom, 
 ( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(( ! [Var_PERSON2] : 
 ((hasType(type_CognitiveAgent, Var_PERSON2) & hasType(type_Entity, Var_PERSON2)) => 
(( ! [Var_PERSON1] : 
 ((hasType(type_CognitiveAgent, Var_PERSON1) & hasType(type_Agent, Var_PERSON1)) => 
(((f_customerRepresentative(Var_PERSON1,Var_PERSON2,Var_ORG)) <=> (( ? [Var_SERVICE] : 
 (hasType(type_FinancialTransaction, Var_SERVICE) &  
(((f_employs(Var_ORG,Var_PERSON1)) & (((f_agent(Var_SERVICE,Var_PERSON1)) & (f_destination(Var_SERVICE,Var_PERSON2)))))))))))))))))))).

fof(axFinancialLem133, axiom, 
 ( ! [Var_SLOT] : 
 (hasType(type_ATMSlot, Var_SLOT) => 
(( ? [Var_ATM] : 
 (hasType(type_ATMMachine, Var_ATM) &  
(f_hole(Var_SLOT,Var_ATM)))))))).

fof(axFinancialLem134, axiom, 
 ( ! [Var_SLOT] : 
 (hasType(type_ATMSlot, Var_SLOT) => 
(( ? [Var_INSERT] : 
 (hasType(type_Putting, Var_INSERT) &  
(( ? [Var_CARD] : 
 (hasType(type_BankCard, Var_CARD) &  
(((f_patient(Var_INSERT,Var_CARD)) & (f_destination(Var_INSERT,Var_SLOT))))))))))))).

fof(axFinancialLem135, axiom, 
 ( ! [Var_FAX] : 
 (hasType(type_Fax, Var_FAX) => 
(( ? [Var_FAXMACHINE] : 
 (hasType(type_FaxMachine, Var_FAXMACHINE) &  
(f_instrument(Var_FAX,Var_FAXMACHINE)))))))).

fof(axFinancialLem136, axiom, 
 ( ! [Var_AMOUNT1] : 
 (hasType(type_Quantity, Var_AMOUNT1) => 
(( ! [Var_DAY] : 
 (hasType(type_Day, Var_DAY) => 
(( ! [Var_AMOUNT] : 
 (hasType(type_CurrencyMeasure, Var_AMOUNT) => 
(( ! [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) => 
(((( ? [Var_TRANSACTION] : 
 (hasType(type_FinancialTransaction, Var_TRANSACTION) &  
(((f_origin(Var_TRANSACTION,f_CurrencyFn(Var_ACCOUNT))) & (((f_transactionAmount(Var_TRANSACTION,Var_AMOUNT)) & (f_date(Var_TRANSACTION,Var_DAY))))))))) => (( ? [Var_AMOUNT2] : 
 ((hasType(type_CurrencyMeasure, Var_AMOUNT2) & hasType(type_Quantity, Var_AMOUNT2)) &  
(((f_availableBalance(Var_ACCOUNT,Var_DAY,Var_AMOUNT2)) & (f_greaterThanOrEqualTo(Var_AMOUNT1,Var_AMOUNT2))))))))))))))))))))).

fof(axFinancialLem137, axiom, 
 ( ! [Var_CASH] : 
 (hasType(type_Cash, Var_CASH) => 
(( ! [Var_AMOUNT1] : 
 (hasType(type_Quantity, Var_AMOUNT1) => 
(( ! [Var_DAY] : 
 (hasType(type_Day, Var_DAY) => 
(( ! [Var_AMOUNT] : 
 (hasType(type_CurrencyMeasure, Var_AMOUNT) => 
(( ! [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) => 
(((( ? [Var_TRANSACTION] : 
 (hasType(type_FinancialTransaction, Var_TRANSACTION) &  
(((f_origin(Var_TRANSACTION,f_CurrencyFn(Var_ACCOUNT))) & (((f_transactionAmount(Var_TRANSACTION,Var_AMOUNT)) & (((f_instrument(Var_TRANSACTION,Var_CASH)) & (f_date(Var_TRANSACTION,Var_DAY))))))))))) => (( ? [Var_AMOUNT2] : 
 ((hasType(type_CurrencyMeasure, Var_AMOUNT2) & hasType(type_Quantity, Var_AMOUNT2)) &  
(((f_availableCash(Var_ACCOUNT,Var_DAY,Var_AMOUNT2)) & (f_greaterThanOrEqualTo(Var_AMOUNT1,Var_AMOUNT2)))))))))))))))))))))))).

fof(axFinancialLem138, axiom, 
 ( ! [Var_STATEMENT] : 
 (hasType(type_BankStatement, Var_STATEMENT) => 
(( ! [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) => 
(((f_statementAccount(Var_STATEMENT,Var_ACCOUNT)) => (( ? [Var_TRANSACTION] : 
 (hasType(type_FinancialTransaction, Var_TRANSACTION) &  
(((((f_origin(Var_TRANSACTION,f_CurrencyFn(Var_ACCOUNT))) | (f_destination(Var_TRANSACTION,f_CurrencyFn(Var_ACCOUNT))))) & (f_realization(Var_STATEMENT,Var_TRANSACTION))))))))))))))).

fof(axFinancialLem139, axiom, 
 ( ! [Var_TRANSACTION1] : 
 (hasType(type_FinancialTransaction, Var_TRANSACTION1) => 
(( ! [Var_TRANSACTION2] : 
 (hasType(type_FinancialTransaction, Var_TRANSACTION2) => 
(( ! [Var_STATEMENT] : 
 ((hasType(type_BankStatement, Var_STATEMENT) & hasType(type_Process, Var_STATEMENT)) => 
(( ! [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) => 
(((((f_lastStatement(Var_ACCOUNT,Var_STATEMENT)) & (((( ~ (f_realization(Var_STATEMENT,Var_TRANSACTION1)))) & (f_realization(Var_STATEMENT,Var_TRANSACTION2)))))) => (f_earlier(f_WhenFn(Var_TRANSACTION2),f_WhenFn(Var_TRANSACTION1))))))))))))))))).

fof(axFinancialLem140, axiom, 
 ( ! [Var_LOAN] : 
 (hasType(type_Loan, Var_LOAN) => 
(( ! [Var_AMOUNT] : 
 ((hasType(type_Interest, Var_AMOUNT) & hasType(type_CurrencyMeasure, Var_AMOUNT)) => 
(((( ? [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) &  
(((f_agreementPeriod(Var_LOAN,Var_PERIOD)) & (f_interestEarned(Var_LOAN,Var_AMOUNT,Var_PERIOD))))))) <=> (f_loanInterest(Var_LOAN,Var_AMOUNT)))))))))).

fof(axFinancialLem141, axiom, 
 ( ! [Var_DATE] : 
 (hasType(type_Day, Var_DATE) => 
(( ! [Var_STATEMENT] : 
 ((hasType(type_BankStatement, Var_STATEMENT) & hasType(type_Proposition, Var_STATEMENT)) => 
(((f_dateOfStatement(Var_STATEMENT,Var_DATE)) => (( ? [Var_COPY] : 
 ((hasType(type_ContentBearingPhysical, Var_COPY) & hasType(type_Physical, Var_COPY)) &  
(((f_containsInformation(Var_COPY,Var_STATEMENT)) & (f_date(Var_COPY,Var_DATE))))))))))))))).

fof(axFinancialLem142, axiom, 
 ( ! [Var_DATE] : 
 (hasType(type_Day, Var_DATE) => 
(( ! [Var_BALANCE] : 
 (hasType(type_CurrencyMeasure, Var_BALANCE) => 
(( ! [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) => 
(((f_lastStatementBalance(Var_ACCOUNT,Var_BALANCE)) => (( ? [Var_STATEMENT] : 
 (hasType(type_BankStatement, Var_STATEMENT) &  
(((f_lastStatement(Var_ACCOUNT,Var_STATEMENT)) & (((f_dateOfStatement(Var_STATEMENT,Var_DATE)) & (f_currentAccountBalance(Var_ACCOUNT,Var_DATE,Var_ACCOUNT)))))))))))))))))))).

fof(axFinancialLem143, axiom, 
 ( ! [Var_DURATION] : 
 ((hasType(type_TimeDuration, Var_DURATION) & hasType(type_Entity, Var_DURATION)) => 
(( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(( ! [Var_STATEMENT] : 
 (hasType(type_BankStatement, Var_STATEMENT) => 
(((((f_statementPeriod(Var_STATEMENT,Var_PERIOD)) & (f_duration(Var_PERIOD,Var_DURATION)))) => (Var_DURATION = inst_MonthDuration)))))))))))).

fof(axFinancialLem144, axiom, 
 ( ! [Var_DATE] : 
 ((hasType(type_Day, Var_DATE) & hasType(type_TimeInterval, Var_DATE)) => 
(( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(( ! [Var_STATEMENT] : 
 (hasType(type_BankStatement, Var_STATEMENT) => 
(((((f_statementPeriod(Var_STATEMENT,Var_PERIOD)) & (f_dateOfStatement(Var_STATEMENT,Var_DATE)))) => (f_finishes(Var_DATE,Var_PERIOD))))))))))))).

fof(axFinancialLem145, axiom, 
 ( ! [Var_ACCOUNT] : 
 (hasType(type_FinancialAccount, Var_ACCOUNT) => 
(( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(( ! [Var_INTEREST] : 
 (hasType(type_CurrencyMeasure, Var_INTEREST) => 
(( ! [Var_STATEMENT] : 
 (hasType(type_BankStatement, Var_STATEMENT) => 
(((((f_statementInterest(Var_STATEMENT,Var_INTEREST)) & (((f_statementPeriod(Var_STATEMENT,Var_PERIOD)) & (f_statementAccount(Var_STATEMENT,Var_ACCOUNT)))))) => (( ? [Var_AMOUNT] : 
 (hasType(type_Interest, Var_AMOUNT) &  
(f_interestEarned(Var_ACCOUNT,Var_AMOUNT,Var_PERIOD))))))))))))))))))).

fof(axFinancialLem146, axiom, 
 ( ! [Var_TRANSFER] : 
 (hasType(type_ExternalTransfer, Var_TRANSFER) => 
(( ! [Var_ORGANIZATION1] : 
 (hasType(type_FinancialOrganization, Var_ORGANIZATION1) => 
(( ! [Var_ORGANIZATION2] : 
 (hasType(type_FinancialOrganization, Var_ORGANIZATION2) => 
(((((f_origin(Var_TRANSFER,Var_ORGANIZATION1)) & (f_destination(Var_TRANSFER,Var_ORGANIZATION2)))) => (Var_ORGANIZATION1 != Var_ORGANIZATION2)))))))))))).

fof(axFinancialLem147, axiom, 
 ( ! [Var_TRANSFER] : 
 (hasType(type_ExternalTransfer, Var_TRANSFER) => 
(( ! [Var_ORGANIZATION1] : 
 (hasType(type_FinancialOrganization, Var_ORGANIZATION1) => 
(( ! [Var_ORGANIZATION2] : 
 (hasType(type_FinancialOrganization, Var_ORGANIZATION2) => 
(( ! [Var_ORGANIZATION2] : 
 (hasType(type_Entity, Var_ORGANIZATION2) => 
(((((f_origin(Var_TRANSFER,Var_ORGANIZATION1)) & (f_destination(Var_TRANSFER,Var_ORGANIZATION2)))) => (Var_ORGANIZATION1 = Var_ORGANIZATION2))))))))))))))).

fof(axFinancialLem148, axiom, 
 ( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(( ! [Var_AMOUNT] : 
 ((hasType(type_CurrencyMeasure, Var_AMOUNT) & hasType(type_Interest, Var_AMOUNT)) => 
(( ! [Var_LOAN] : 
 ((hasType(type_Loan, Var_LOAN) & hasType(type_Contract, Var_LOAN) & hasType(type_FinancialAccount, Var_LOAN)) => 
(((((f_loanFeeAmount(Var_LOAN,Var_AMOUNT)) & (f_agreementPeriod(Var_LOAN,Var_PERIOD)))) => (f_interestEarned(Var_LOAN,Var_AMOUNT,Var_PERIOD))))))))))))).

