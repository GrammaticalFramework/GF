abstract FinancialOntology = open Merge, Mid_level_ontology in {




-- The highest rating given by bond rating agencies
fun AAA_Rating : Ind FinancialRating ;


-- All_or_none order (AON) is a type of option order 
-- which requires that the order be executed completely or not at all. An AON 
-- order may be either a day order or a GTC order.
fun AONOrder : Class ;
fun AONOrder_Class : SubClass AONOrder FinancialOrder ;

-- (Automatic Teller Machine) A banking terminal that 
-- accepts deposits and dispenses cash. ATMs are activated by inserting a cash or 
-- credit card that contains the user's account number and PIN on a magnetic stripe. 
-- The ATM calls up the bank's computers to verify the balance, dispenses the cash 
-- and then transmits a completed transaction notice.
fun ATMMachine : Class ;
fun ATMMachine_Class : SubClass ATMMachine StationaryArtifact ;

-- A narrow opening in an ATM machine where cards are inserted.
fun ATMSlot : Class ;
fun ATMSlot_Class : SubClass ATMSlot Hole ;

-- A unary function that maps a FinancialAsset to the FinancialAccount 
-- associated with the Asset.
fun AccountFn : El FinancialAsset -> Ind FinancialAccount ;


fun Active : Ind StatusAttribute ;

-- An InterestBearingAccount in which 
-- the interest rate is adjusted periodically, usually based on a standard 
-- market rate outside the control of the bank or savings institution, such 
-- as that prevailing on TreasuryBill or the primeInterestRate.
fun AdjustableRateAccount : Class ;
fun AdjustableRateAccount_Class : SubClass AdjustableRateAccount InterestBearingAccount ;

fun AmericanExpressCard : Class ;
fun AmericanExpressCard_Class : SubClass AmericanExpressCard CreditCard ;
-- An option that can be exercised at any time 
-- prior to its expiration date
fun AmericanStyleOption : Ind Option ;


-- A contract sold by an insurance company designed to provide 
-- payments to the holder at specified intervals, usually after retirement. FixedAnnuities 
-- guarantee a certain payment amount, while VariableAnnuities do not, but do have the 
-- potential for greater returns, but both are relatively safe, low_yielding investments.
fun Annuity : Class ;
fun Annuity_Class : SubClass Annuity FinancialContract ;

-- The process of dividing investments among different kinds of 
-- assets, such as Stocks, Bonds, RealEstate and cash, to optimize the risk/reward tradeoff based 
-- on an individual's or institution's specific situation and goals.
fun AssetAllocation : Class ;
fun AssetAllocation_Class : SubClass AssetAllocation FinancialTransaction ;

-- An activity which approves or 
-- disapproves a transaction.
fun AuthorizationOfTransaction : Class ;
fun AuthorizationOfTransaction_Class : SubClass AuthorizationOfTransaction (both ControllingAnAccount (both FinancialService RegulatoryProcess)) ;


-- Transactions which occur through computer 
-- networks and which do not require direct management.
fun AutomaticTransaction : Class ;
fun AutomaticTransaction_Class : SubClass AutomaticTransaction FinancialTransaction ;

-- A mid_range rating given by bond rating agencies.
fun B_Rating : Ind FinancialRating ;


-- A long_term loan, often a mortgage, that has 
-- one large payment (the balloon payment) due upon maturity. Often done 
-- when refinancing or a major cash flow event is anticipated.
fun BalloonLoan : Class ;
fun BalloonLoan_Class : SubClass BalloonLoan Loan ;

-- A CreditCard or a DebitCard issued by a 
-- FinancialOrganization.
fun BankCard : Class ;
fun BankCard_Class : SubClass BankCard FinancialInstrument ;

-- A monthly report sent to a debtor or bank depositor.
fun BankStatement : Class ;
fun BankStatement_Class : SubClass BankStatement Proposition ;

-- A bank loan terminating in one year or more.
fun BankTermLoan : Class ;
fun BankTermLoan_Class : SubClass BankTermLoan Loan ;

-- An organization, chartered by a state or 
-- federal government, which does most or all of the following: receives Deposits, 
-- honors FinancialInstruments drawn on them, and pays Interest on them, discounts 
-- Notes, makes Loans, and invests in SecuredLoans, collects Checks, Drafts 
-- and Notes, certifies depositor's checks, and issues drafts and Cashier's checks.
fun Bank_FinancialOrganization : Class ;
fun Bank_FinancialOrganization_Class : SubClass Bank_FinancialOrganization FinancialOrganization ;

-- An adjective describing the opinion that a stock, or 
-- a market in general, will decline in price __ a negative or pessimistic outlook.
fun Bearish : Class ;
fun Bearish_Class : SubClass Bearish InvestmentAttribute ;

-- Stock with a solid and stable earnings record from a 
-- company that either leads or dominates or is a major player in a specific industry.
fun BlueChipStock : Class ;
fun BlueChipStock_Class : SubClass BlueChipStock Stock ;

-- A debt instrument issued for a period of more than one year with 
-- the purpose of raising capital by borrowing. The Federal government, states, cities, 
-- corporations, and many other types of institutions sell bonds. A bond is generally a 
-- promise to repay the principal along with interest on a specified maturityDate.
fun Bond : Class ;
fun Bond_Class : SubClass Bond (both FinancialInstrument Investment) ;


-- Stock in a short sale.
fun BorrowedStock : Class ;
fun BorrowedStock_Class : SubClass BorrowedStock Stock ;

-- Short_term financing which is expected to be paid back relatively 
-- quickly, such as by a subsequent longer_term loan.
fun BridgeLoan : Class ;
fun BridgeLoan_Class : SubClass BridgeLoan Loan ;

-- An individual or firm which acts as an intermediary between 
-- a buyer and seller, usually charging a commisssion.
fun Broker : Class ;
fun Broker_Class : SubClass Broker CognitiveAgent ;

-- Money lent to brokers by banks, for financing 
-- the underwriting of new issues, financing customer margin accounts, and 
-- other purposes.
fun BrokerLoan : Class ;
fun BrokerLoan_Class : SubClass BrokerLoan Loan ;

-- A fund that a customer has entrusted to 
-- a securities brokerage.
fun BrokerageAccount : Ind InvestmentAccount ;


-- An attribute describing the opinion that a stock, or the 
-- market in general, will rise in price __ a positive or optimistic outlook.
fun Bullish : Class ;
fun Bullish_Class : SubClass Bullish InvestmentAttribute ;

-- A complex option strategy that involves 
-- selling two calls and buying two calls on the same or different markets, 
-- with several maturity dates. One of the options has a higher exercise 
-- price and the other has a lower exercise price than the other two options. 
-- The payoff diagram resembles the shape of a butterfly.
fun ButterflySpread : Class ;
fun ButterflySpread_Class : SubClass ButterflySpread SpreadOption ;

-- A mid_range rating given by bond rating agencies.
fun C_Rating : Ind FinancialRating ;


fun Call : Class ;
fun Call_Class : SubClass Call FinancialTransaction ;
-- An option contract that gives the holder the 
-- right to buy a certain quantity (usually 100 shares) of an underlying 
-- security from the writer of the option, at a specified price (the strike 
-- price) up to a specified date (the expiration date).
fun CallOption : Class ;
fun CallOption_Class : SubClass CallOption Option ;

-- A bond which the issuer has the right to redeem 
-- prior to its maturity date, under certain conditions.
fun CallableBond : Class ;
fun CallableBond_Class : SubClass CallableBond Bond ;

-- A loan that must repaid upon the lender's demand.
fun CallableLoan : Class ;
fun CallableLoan_Class : SubClass CallableLoan Loan ;

fun CancellingAnOrder : Class ;
fun CancellingAnOrder_Class : SubClass CancellingAnOrder FinancialTransaction ;
-- Circulating paper money
fun Cash : Class ;
fun Cash_Class : SubClass Cash (both FinancialAsset FinancialInstrument) ;


-- CDs (certificates of deposit) are bank, credit union or savings 
-- and loan instruments that allow the depositor to lock in an interest rate for a specific period of 
-- time (e.g. six months, one year, five years). If the money is withdrawn from the CD before the CD 
-- matures, there is likely to be an early_withdrawal penalty __ often three month's interest. Generally, 
-- the longer the time period of the CD, the higher the interest paid.
fun CertificateOfDeposit : Class ;
fun CertificateOfDeposit_Class : SubClass CertificateOfDeposit SavingsAccount ;

-- A FinancialInstrument drawn against deposited funds, 
-- to pay a specified amount of money to a specific person upon demand.
fun Check : Class ;
fun Check_Class : SubClass Check FinancialInstrument ;

-- A bank account against which the depositor can draw checks
fun CheckingAccount : Class ;
fun CheckingAccount_Class : SubClass CheckingAccount DepositAccount ;

-- The attribute which describes services that are 
-- shut or closed.
fun ClosedService : Ind ServiceAttribute ;


-- An activity of closing a financial account
fun ClosingAnAccount : Class ;
fun ClosingAnAccount_Class : SubClass ClosingAnAccount FinancialTransaction ;

-- Assets pledged by a borrower to secure a loan or other credit, and 
-- subject to seizure in the event of FinancialDefault.
fun Collateral : Class ;
fun Collateral_Class : SubClass Collateral FinancialAsset ;

-- Securities representing equity, ownership in a 
-- Corporation, providing voting rights, and entitling the holder to a share 
-- of the company's success through dividends and/or capital appreciation. 
-- In the event of liquidation, common stock holders have rights to a 
-- company's assets only after bondholders, other debt holders, and 
-- PreferredStock holders have been satisfied.
fun CommonStock : Class ;
fun CommonStock_Class : SubClass CommonStock Stock ;

-- The replacement of multiple loans with a single loan, often 
-- with a lower monthly payment and a longer repayment period.
fun ConsolidationLoan : Class ;
fun ConsolidationLoan_Class : SubClass ConsolidationLoan Loan ;

-- An inflationary indicator that measures 
-- the change in the cost of a fixed basket of products and services, 
-- including housing, electricity, food, and transportation. The CPI is 
-- published monthly.
fun ConsumerPriceIndex : Class ;
fun ConsumerPriceIndex_Class : SubClass ConsumerPriceIndex InflationIndex ;

-- Attribute that applies to Propositions where 
-- something is promised in return, i.e. a reciprocal promise.
fun Contract : Class ; --  make subclass with Promise 


-- An activity of controlling a financial account
fun ControllingAnAccount : Class ;
fun ControllingAnAccount_Class : SubClass ControllingAnAccount FinancialTransaction ;

-- A mortgage that is not insured or guaranteed 
-- by the government.
fun ConventionalMortgage : Class ;
fun ConventionalMortgage_Class : SubClass ConventionalMortgage Mortgage ;

-- Short_term option contracts.
fun ConventionalOption : Class ;
fun ConventionalOption_Class : SubClass ConventionalOption Option ;

-- This is the class of accounts held by corporations. This class 
-- is disjoint with PersonalAccounts.
fun CorporateAccount : Class ;
fun CorporateAccount_Class : SubClass CorporateAccount FinancialAccount ;

-- A bond issued by a corporation. Such bonds usually have 
-- a par value of 1,000, are taxable, have a term maturity, are paid for out of a sinking 
-- fund accumulated for that purpose, and are traded on major exchanges.
fun CorporateBond : Class ;
fun CorporateBond_Class : SubClass CorporateBond (both Bond TaxableInvestment) ;


-- An unregistered, negotiable bond on which interest and principal 
-- are payable to the holder, regardless of whom it was originally issued to. The coupons are 
-- attached to the bond, and each coupon represents a single interest payment. The holder submits 
-- a coupon, usually semi_annually, to the issuer or paying agent to receive payment. Coupon bonds 
-- are being phased out in favor of registered bonds.
fun CouponBond : Class ;
fun CouponBond_Class : SubClass CouponBond Bond ;

-- Credit extended by a business to a customer
fun CreditAccount : Class ;
fun CreditAccount_Class : SubClass CreditAccount LiabilityAccount ;

-- Any card that may be used repeatedly to borrow money 
-- or buy products and services on credit. Issued by banks, savings and loans, retail 
-- stores, and other businesses.
fun CreditCard : Class ;
fun CreditCard_Class : SubClass CreditCard BankCard ;

-- A type of CreditAccount which uses a CreditCard for 
-- FinancialTransactions.
fun CreditCardAccount : Class ;
fun CreditCardAccount_Class : SubClass CreditCardAccount CreditAccount ;

-- Credit unions are non_profit, member_owned, financial 
-- cooperatives. They are operated entirely by and for their members. When you deposit 
-- money in a credit union, you become a member of the union because your deposit is 
-- considered partial ownership in the credit union. Many large organizations have 
-- established credit unions for their employees.
fun CreditUnion : Class ;
fun CreditUnion_Class : SubClass CreditUnion FinancialOrganization ;

-- A unary function that maps a FinancialAccount to the 
-- currency linked to the account.
fun CurrencyFn : El FinancialAccount -> Ind FinancialInstrument ;


-- The lowest rating given by bond rating agencies.
fun D_Rating : Ind FinancialRating ;


-- A bank loan to a broker for the purchase of securities pending delivery 
-- through clearing later the same day.
fun DayLoan : Class ;
fun DayLoan_Class : SubClass DayLoan Loan ;

-- A type of option order which instructs the broker 
-- to cancel any unfilled portion of the order at the close of trading on the 
-- day the order is first entered.
fun DayOrder : Class ;
fun DayOrder_Class : SubClass DayOrder FinancialOrder ;

-- A card which allows customers to access their funds 
-- immediately, electronically. Unlike a credit card, a debit card does not have 
-- any float.
fun DebitCard : Class ;
fun DebitCard_Class : SubClass DebitCard BankCard ;

-- DefensiveStocks are stocks of food companies, drug 
-- manufacturers and utility companies.
fun DefensiveStock : Class ;
fun DefensiveStock_Class : SubClass DefensiveStock Stock ;

-- A company retirement plan, such as 
-- a 401(k) or 403(b), in which the employee elects to defer some amount of 
-- his/her salary into the plan and bears the investment risk.
fun DefinedContributionPlan : Class ;
fun DefinedContributionPlan_Class : SubClass DefinedContributionPlan PensionPlan ;

-- An Activity of money being transferred into a customer's 
-- account at a financial institution.
fun Deposit : Class ;
fun Deposit_Class : SubClass Deposit FinancialTransaction ;

-- An account where money is deposited for checking, savings or 
-- brokerage use.
fun DepositAccount : Class ;
fun DepositAccount_Class : SubClass DepositAccount FinancialAccount ;

-- An activity of depositing a check into a 
-- FinancialOrganization.
fun DepositingACheck : Class ;
fun DepositingACheck_Class : SubClass DepositingACheck UsingAnAccount ;

-- A distribution from qualified pension plan, 401(k)
--  plan, or 403(b) plan, that is remitted directly to the trustee, custodian, or 
-- issuer of the receiving IRA and is reported to the IRS as a rollover. This can only 
-- be done once per year, per account.
fun DirectRollover : Class ;
fun DirectRollover_Class : SubClass DirectRollover Rollover ;

fun DiscoverCard : Class ;
fun DiscoverCard_Class : SubClass DiscoverCard CreditCard ;
-- A taxable payment declared by a company's board of directors 
-- and given to its shareHolders out of the company's current or retained earnings. 
-- Usually quarterly. Usually given as cash, but it can also take the form of Stock or 
-- other property.
fun Dividend : Class ;
fun Dividend_Class : SubClass Dividend Payment ;

-- A stock market transaction (or sometimes, a quote) 
-- at a price lower than the preceding one for the same security.
fun Downtick : Class ;
fun Downtick_Class : SubClass Downtick StockMarketTransaction ;

-- An activity of paying by a check.
fun DrawingACheck : Class ;
fun DrawingACheck_Class : SubClass DrawingACheck UsingAnAccount ;

-- Data which provide information about or 
-- predict the overall health of the economy or the financial markets, 
-- examples are inflation, interest rates, employment, etc.
fun EconomicIndicator : Class ;
fun EconomicIndicator_Class : SubClass EconomicIndicator Proposition ;

fun Employment : Class ;
fun Employment_Class : SubClass Employment (both FinancialContract ServiceContract) ;

-- A subclass of AuthorizationOfTransaction where 
-- a customer enters his/her personal identification number.
fun EnteringAPin : Class ;
fun EnteringAPin_Class : SubClass EnteringAPin AuthorizationOfTransaction ;

fun EnteringAPing : Class ;
fun EnteringAPing_Class : SubClass EnteringAPing ContentDevelopment ;
-- An option on shares of an individual common stock.
fun EquityOption : Class ;
fun EquityOption_Class : SubClass EquityOption Option ;

-- An option that can be exercised only during 
-- a specified period of time just prior to its expiration.
fun EuropeanStyleOption : Ind Option ;


-- A short_term loan which is continually renewed rather than repaid.
fun EvergreenLoan : Class ;
fun EvergreenLoan_Class : SubClass EvergreenLoan Loan ;

-- An activity when the owner of the the Option 
-- contract invokes his rights. In the case of a call, the option owner buys the 
-- underlying stock. In the case of a put, the option owner sells the underlying stock.
fun ExerciseAnOption : Ind FinancialTransaction ;


-- A class of expired BankCards.
fun ExpiredCard : Class ;
fun ExpiredCard_Class : SubClass ExpiredCard BankCard ;

-- A subclass of FinancialTransactions from one 
-- FinancialOrganization to another.
fun ExternalTransfer : Class ;
fun ExternalTransfer_Class : SubClass ExternalTransfer FinancialTransaction ;

-- A government mortgage that is insured by the Federal Housing 
-- Administration (FHA).
fun FHALoan : Class ;
fun FHALoan_Class : SubClass FHALoan Mortgage ;

-- Fill_or_kill order is a type of option order 
-- which requires that the order be executed completely or not at all. A 
-- fill_or_kill order is similar to an all_or_none (AON) order. The 
-- difference is that if the order cannot be completely executed (i.e., 
-- filled in its entirety) as soon as it is announced in the trading crowd, 
-- it is to be 'killed' (i.e., cancelled) immediately. Unlike an AON order, 
-- a FOK order cannot be used as part of a GTC order.
fun FOKOrder : Class ;
fun FOKOrder_Class : SubClass FOKOrder FinancialOrder ;

-- The communication of a printed page between remote locations.
fun Fax : Class ;
fun Fax_Class : SubClass Fax Communication ;

-- Fax machines scan a paper form and transmit a coded 
-- image over the telephone system. The receiving machine prints a facsimile of 
-- the original. A fax machine is made up of a scanner, printer and modem with 
-- fax signaling.
fun FaxMachine : Class ;
fun FaxMachine_Class : SubClass FaxMachine Device ;

fun FederalHousingAdministration : Class ;
fun FederalHousingAdministration_Class : SubClass FederalHousingAdministration Government ;
-- Execute an order or buy or sell a security 
-- or commodity.
fun FillingAnOrder : Class ;
fun FillingAnOrder_Class : SubClass FillingAnOrder FinancialTransaction ;

-- A financial agreement between two or more parties
fun FinancialContract : Class ;


-- Failure to make required debt payments on a timely basis 
-- or to comply with other conditions of an obligation or agreement.
fun FinancialDefault : Class ;
fun FinancialDefault_Class : SubClass FinancialDefault FinancialTransaction ;

-- A request from a client to a broker to buy (buy order) or sell 
-- (sell order) a specified amount of a particular security or commodity at a specific 
-- price or at the market price.
fun FinancialOrder : Class ;
fun FinancialOrder_Class : SubClass FinancialOrder ServiceContract ;

-- The class FinancialOrganization includes, 
-- as subclasses, Bank_FinancialOrganization, CreditUnion and SavingsAnLoans.
fun FinancialOrganization : Class ;
fun FinancialOrganization_Class : SubClass FinancialOrganization Organization ;

-- The highest rating is usually AAA_Rating, 
-- and the lowest is D_Rating.
fun FinancialRating : Class ;
fun FinancialRating_Class : SubClass FinancialRating RelationalAttribute ;

-- A request for financial data sent in order
-- to get a FinancialResponse.
fun FinancialRequest : Class ;
fun FinancialRequest_Class : SubClass FinancialRequest FinancialTransaction ;

-- The response data provided to fulfil a FinancialRequest.
fun FinancialResponse : Class ;
fun FinancialResponse_Class : SubClass FinancialResponse FinancialTransaction ;

-- An investment vehicle offered by an insurance company, that 
-- guarantees a stream of fixed payments over the life of the annuity. The insurer, not the 
-- insured, takes the investment risk.
fun FixedAnnuity : Class ;
fun FixedAnnuity_Class : SubClass FixedAnnuity Annuity ;

-- An InterestBearingAccount in which the interest rate does not 
-- change during the entire term of the loan.
fun FixedRateAccount : Class ;
fun FixedRateAccount_Class : SubClass FixedRateAccount InterestBearingAccount ;

-- Good_'til_cancelled (GTC) order is a type of limit order 
-- that remains in effect until it is either executed (filled) or cancelled, as opposed 
-- to a day order, which expires if not executed by the end of the trading day. A GTC 
-- option order is an order which if not executed will be automatically cancelled at the 
-- option's expiration
fun GTCOrder : Class ;
fun GTCOrder_Class : SubClass GTCOrder FinancialOrder ;

-- A bond sold by the U.S. government.
fun GovernmentBond : Class ;
fun GovernmentBond_Class : SubClass GovernmentBond Bond ;

-- Investment term that is applied to a Stock that is expected 
-- to appreciate in value at a high rate, pay big dividends or split.
fun GrowthStock : Class ;
fun GrowthStock_Class : SubClass GrowthStock Stock ;

-- An Attribute of FinancialAccounts which can be easily 
-- converted to cash.
fun HighLiquidity : Ind LiquidityAttribute ;


-- An Attribute that characterizes investments which are likely 
-- to lose their principal.
fun HighRisk : Ind RiskAttribute ;


-- An Attribute that characterizes accounts that are very profitable.
fun HighYield : Ind YieldAttribute ;


-- Immediate or cancel Order is a type of option order 
-- which gives the trading crowd one opportunity to take the other side of the 
-- trade. After being announced, the order will be either partially or totally 
-- filled with any remaining balance immediately cancelled. An IOC order, which 
-- can be considered a type of day order, cannot be used as part of a GTC order 
-- since it will be cancelled shortly after being entered. The difference between 
-- fill_or_kill (FOK) orders and IOC orders is that a IOC order may be partially 
-- executed.
fun IOCOrder : Class ;
fun IOCOrder_Class : SubClass IOCOrder FinancialOrder ;

-- A benchmark against which financial or economic performance is measured, 
-- such as the S&P 500 or the Consumer Price Index.
fun Index : Class ;
fun Index_Class : SubClass Index PerformanceMeasure ;

-- A bond whose cash flow is inflation_adjusted, by 
-- being linked to the purchasing power of a particular currency.
fun IndexBond : Class ;
fun IndexBond_Class : SubClass IndexBond Bond ;

-- An option whose underlying interest is an index. 
-- Generally, index options are cash_settled.
fun IndexOption : Class ;
fun IndexOption_Class : SubClass IndexOption Option ;

-- A loan in which payments change in response to 
-- changes in an index such as the Consumer Price Index.
fun IndexedLoan : Class ;
fun IndexedLoan_Class : SubClass IndexedLoan Loan ;

-- A tax_deferred retirement 
-- account for an individual that permits individuals to set aside up to 
-- 2,000 per year, with earnings tax_deferred until withdrawals begin at age 
-- 59 1/2 or later (or earlier, with a 10% penalty). Only those who do not 
-- participate in a pension plan at work or who do participate and meet 
-- certain income guidelines can make deductible contributions to an IRA. 
-- All others can make contributions to an IRA on a non_deductible basis. 
-- Such contributions qualify as a deduction against income earned in that 
-- year and interest accumulates tax_deferred until the funds are withdrawn.
fun IndividualRetirementAccount : Class ;
fun IndividualRetirementAccount_Class : SubClass IndividualRetirementAccount (both PensionPlan (both PersonalAccount SavingsAccount)) ;


-- The overall general upward price movement of 
-- goods and services in an economy, usually as measured by the Consumer 
-- Price Index and the Producer Price Index.
fun Inflation : Class ;
fun Inflation_Class : SubClass Inflation EconomicIndicator ;

fun InflationIndex : Class ;
fun InflationIndex_Class : SubClass InflationIndex Index ;
-- Money paid for the use of money.
fun Interest : Class ;
fun Interest_Class : SubClass Interest CurrencyMeasure ;

-- FinancialAccounts that have a fixed or adjustable interest rate.
fun InterestBearingAccount : Class ;
fun InterestBearingAccount_Class : SubClass InterestBearingAccount FinancialAccount ;

-- A non_amortized loan in which interest is 
-- due at regular intervals until maturity, when the full principal on the 
-- loan is due.
fun InterestOnlyLoan : Class ;
fun InterestOnlyLoan_Class : SubClass InterestOnlyLoan Loan ;

-- The usual way of calculating Interest, as a 
-- percentage of the sum borrowed.
fun InterestRate : Class ;
fun InterestRate_Class : SubClass InterestRate (both ConstantQuantity EconomicIndicator) ;


-- A subclass of FinancialTransactions within 
-- one FinancialOrganization.
fun InternalTransfer : Class ;
fun InternalTransfer_Class : SubClass InternalTransfer FinancialTransaction ;

-- An activity of commiting money or capital in order to 
-- gain a financial return.
fun Investing : Class ;
fun Investing_Class : SubClass Investing FinancialTransaction ;

-- An account acquired for future financial return or benefit
fun InvestmentAccount : Class ;
fun InvestmentAccount_Class : SubClass InvestmentAccount DepositAccount ;

fun InvestmentAttribute : Class ;
fun InvestmentAttribute_Class : SubClass InvestmentAttribute RelationalAttribute ;
-- A person who purchases income_producing assets.
fun Investor : Class ;
fun Investor_Class : SubClass Investor SocialRole ;

-- An account owned by two or more people, usually sharing a household 
-- and expenses. Each co_owner has equal access to the account. Most types of accounts, whether it's 
-- basic checking, savings or money market, allow for joint use
fun JointAccount : Class ;
fun JointAccount_Class : SubClass JointAccount PersonalAccount ;

-- A high_risk, non_investment_grade bond with a low 
-- credit rating, usually BB or lower, as a consequence, it usually has a high 
-- yield.
fun JunkBond : Class ;
fun JunkBond_Class : SubClass JunkBond CorporateBond ;

-- Calls and puts with an expiration as long as 
-- thirty_nine months. Currently, equity LEAPS have two series at any 
-- time with a January expiration. For example, in October 2000, LEAPS 
-- are available with expirations of January 2002 and January 2003.
fun LEAPS : Class ;
fun LEAPS_Class : SubClass LEAPS Option ;

-- A financial obligation, debt, claim, or potential loss
fun Liability : Class ;
fun Liability_Class : SubClass Liability FinancialContract ;

-- An account for which a person is liable
fun LiabilityAccount : Class ;
fun LiabilityAccount_Class : SubClass LiabilityAccount FinancialAccount ;

-- LimitOrder is an order to a Broker to buy a specified quantity 
-- of a Security at or below a specified price, or to sell it at or above a specified limitPrice.
fun LimitOrder : Class ;
fun LimitOrder_Class : SubClass LimitOrder FinancialOrder ;

-- The class of events of selling all of a company's assets, 
-- paying outstanding debts, and distribution of the remainder to shareholders, and them 
-- going out of business.
fun Liquidation : Class ;
fun Liquidation_Class : SubClass Liquidation FinancialTransaction ;

-- A class of attributes which describe the degree to 
-- which accounts can be easily converted to cash.
fun LiquidityAttribute : Class ;
fun LiquidityAttribute_Class : SubClass LiquidityAttribute RelationalAttribute ;

-- An arrangement in which a lender gives money or property to a borrower, 
-- and the borrower agrees to return the property or repay the money, usually along with interest, 
-- at some future point(s) in time.
fun Loan : Class ;
fun Loan_Class : SubClass Loan LiabilityAccount ;

-- A formal offer by a lender making explicit 
-- the terms under which it agrees to lend money to a borrower over a certain 
-- period of time.
fun LoanCommitment : Class ;
fun LoanCommitment_Class : SubClass LoanCommitment Contract ;

fun Locked : Ind StatusAttribute ;

-- A straddle in which a long position is taken in 
-- both a put and a call option
fun LongStraddle : Class ;
fun LongStraddle_Class : SubClass LongStraddle Straddle ;

-- An Attribute of FinancialAccounts which cannot be easily 
-- converted to cash.
fun LowLiquidity : Ind LiquidityAttribute ;


fun LowRisk : Ind RiskAttribute ;

-- An Attribute that characterizes accounts that are not very profitable.
fun LowYield : Ind YieldAttribute ;


-- A Market_not_held order is a type of market order 
-- which allows the investor to give discretion to the floor broker regarding 
-- the price and/or time at which a trade is executed.
fun MNHOrder : Class ;
fun MNHOrder_Class : SubClass MNHOrder FinancialOrder ;

-- A Market_on_close order is a type of option order 
-- which requires that an order be executed at or near the close of trading on 
-- the day the order is entered. A MOC order, which can be considered a type of 
-- day order, cannot be used as part of a GTC order
fun MOCOrder : Class ;
fun MOCOrder_Class : SubClass MOCOrder FinancialOrder ;

-- One who directs a business or other enterprise.
fun Manager : Ind Position ;


-- An order to buy or sell security at the best prices available.
fun MarketOrder : Class ;
fun MarketOrder_Class : SubClass MarketOrder FinancialOrder ;

-- A stock index in which each stock affects the 
-- index in proportion to its number of shares outstanding.
fun MarketShareWeightedIndex : Class ;
fun MarketShareWeightedIndex_Class : SubClass MarketShareWeightedIndex Index ;

-- A stock index in which each stock 
-- affects the index in proportion to its market value. Examples include 
-- NASDAQ Composite Index, S&P 500, Wilshire 5000 Equity Index, Hang Seng 
-- Index, and EAFE Index.
fun MarketValueWeightedIndex : Class ;
fun MarketValueWeightedIndex_Class : SubClass MarketValueWeightedIndex Index ;

fun MasterCard : Class ;
fun MasterCard_Class : SubClass MasterCard CreditCard ;
-- MoneyMarket is for borrowing and lending money for three years 
-- or less. The securities in a money market can be U.S. government bonds, TreasuryBills and commercial 
-- paper from banks and companies.
fun MoneyMarket : Class ;
fun MoneyMarket_Class : SubClass MoneyMarket SavingsAccount ;

-- A loan to finance the purchase of real estate, usually with specified payment 
-- periods and interest rates.
fun Mortgage : Class ;
fun Mortgage_Class : SubClass Mortgage SecuredLoan ;

-- These are bonds generally bought through a 
-- government agency that deals in the real estate market. They are bonds 
-- issued by mortgage lenders.
fun MortgageBond : Class ;
fun MortgageBond_Class : SubClass MortgageBond CorporateBond ;

-- Bond issued by a state, city, or local government to 
-- finance operations or special projects, interest on it is often tax_free.
fun MunicipalBond : Class ;
fun MunicipalBond_Class : SubClass MunicipalBond (both Bond TaxFreeInvestment) ;


-- An open_ended fund operated by an investment company which 
-- raises money from shareholders and invests in a group of assets, in accordance with a stated 
-- set of objectives. Benefits include diversification and professional money management. Shares 
-- are issued and redeemed on demand, based on the fund's net asset value which is determined at 
-- the end of each trading session.
fun MutualFundAccount : Class ;
fun MutualFundAccount_Class : SubClass MutualFundAccount InvestmentAccount ;

-- National Association of Securities Dealers Automated Quotations 
-- system.
fun NASDAQ : Ind Organization ;


-- A market_value weighted index of all common stocks 
-- listed on NASDAQ.
fun NASDAQCompositeIndex : Class ;
fun NASDAQCompositeIndex_Class : SubClass NASDAQCompositeIndex Index ;

-- A not_held order is a type of order which releases 
-- normal obligations implied by the other terms of the order. For example, a 
-- limit order designated as 'not_held' allows discretion to the floor trader in 
-- filling the order when the market trades at the limit price of the order. In 
-- this case, there is no obligation to provide the customer with an execution if 
-- the market trades through the limit price on the order.
fun NHOrder : Class ;
fun NHOrder_Class : SubClass NHOrder FinancialOrder ;

fun New : Ind StatusAttribute ;

-- Index of 225 leading stocks traded on the Tokyo Stock 
-- Exchange.
fun NikkeiIndex : Class ;
fun NikkeiIndex_Class : SubClass NikkeiIndex Index ;

-- A legal document that obligates a borrower to repay a loan 
-- at a specified interestRate during a specified period of time or on demand
fun Note : Class ;
fun Note_Class : SubClass Note FinancialInstrument ;

-- One_cancels_other order (OCO) is a type of option 
-- order which treats two or more option orders as a package, whereby the execution 
-- of any one of the orders causes all the orders to be reduced by the same amount. 
-- For example, the investor would enter an OCO order if he/she wished to buy 
-- 10 May 60 calls or 10 June 60 calls or any combination of the two which when 
-- summed equaled 10 contracts. An OCO order may be either a day order or a GTC order
fun OCOOrder : Class ;
fun OCOOrder_Class : SubClass OCOOrder FinancialOrder ;

-- The attribute which describes services that 
-- are ready to transact business.
fun OpenService : Ind ServiceAttribute ;


-- An activity of opening a financial account
fun OpeningAnAccount : Class ;
fun OpeningAnAccount_Class : SubClass OpeningAnAccount FinancialTransaction ;

-- An option is a contract to buy or sell 100 shares 
-- of a stock at a fixed price (the strike price) on or before a fixed date.
fun Option : Class ;
fun Option_Class : SubClass Option FinancialContract ;

-- A collection of buying/selling options 
-- whose purpose is to result in an optimal profit for the investor.
fun OptionStrategy : Class ;
fun OptionStrategy_Class : SubClass OptionStrategy FinancialTransaction ;

-- A check issued to an employee in payment of salary or wages
fun PayCheck : Class ;
fun PayCheck_Class : SubClass PayCheck Check ;

-- The partial or complete discharge of an obligation by 
-- its settlement in the form of the transfer of funds, assets, or services equal 
-- to the monetary value of part or all of the debtor's obligation.
fun Payment : Class ;
fun Payment_Class : SubClass Payment FinancialTransaction ;

-- A fee charged as a penalty.
fun Penalty : Class ;
fun Penalty_Class : SubClass Penalty ChargingAFee ;

fun Pending : Ind StatusAttribute ;

-- Extremely speculative, high_risk Stock, usually 
-- with a price of less than 5 dollars per share. In the U.S., nearly all 
-- are traded on the over_the_counter bulletin board.
fun PennyStock : Class ;
fun PennyStock_Class : SubClass PennyStock Stock ;

-- A bond issued by an insurance company to 
-- guarantee satisfactory completion of a project by a contractor.
fun PerformanceBond : Class ;
fun PerformanceBond_Class : SubClass PerformanceBond Bond ;

fun PerformanceMeasure : Class ;
fun PerformanceMeasure_Class : SubClass PerformanceMeasure PhysicalQuantity ;
-- This is the class of personal accounts, as opposed to 
-- CorporateAccounts.
fun PersonalAccount : Class ;
fun PersonalAccount_Class : SubClass PersonalAccount FinancialAccount ;

-- Two lenders participating in the same loan.
fun PiggybankLoan : Class ;
fun PiggybankLoan_Class : SubClass PiggybankLoan Loan ;

fun PlacingAnOrder : Class ;
fun PlacingAnOrder_Class : SubClass PlacingAnOrder FinancialTransaction ;
-- CapitalStock which provides a specific Dividend 
-- that is paid before any dividends are paid to common stock holders, and which takes 
-- precedence over common stock in the event of a liquidation. Usually does not carry 
-- voting rights.
fun PreferredStock : Class ;
fun PreferredStock_Class : SubClass PreferredStock Stock ;

-- Prepayment is the payment of all or part of a debt 
-- prior to its due date.
fun Prepayment : Class ;
fun Prepayment_Class : SubClass Prepayment Payment ;

-- A stock index in which each stock affects the index 
-- in proportion to its price per share.
fun PriceWeightedIndex : Class ;
fun PriceWeightedIndex_Class : SubClass PriceWeightedIndex Index ;

-- An activity of paying the amount specified on the 
-- check from funds on deposit.
fun ProcessingACheck : Class ;
fun ProcessingACheck_Class : SubClass ProcessingACheck (both AuthorizationOfTransaction ControllingAnAccount) ;


-- An inflationary indicator published by the U.S. Bureau 
-- of Labor Statistics to evaluate wholesale price levels in the economy.
fun ProducerPriceIndex : Class ;
fun ProducerPriceIndex_Class : SubClass ProducerPriceIndex InflationIndex ;

-- An option contract that gives the holder the 
-- right to sell a certain quantity of an underlying security to the writer 
-- of the option, at a specified price (strike price) up to a specified date 
-- (expiration date).
fun PutOption : Class ;
fun PutOption_Class : SubClass PutOption Option ;

-- Land, including all the natural resources and permanent buildings on it.
fun RealEstate : Class ;
fun RealEstate_Class : SubClass RealEstate (both CorpuscularObject (both FinancialAsset Region)) ;


-- A written acknowledgment that a specified article, 
-- sum of money, or shipment of merchandise has been received.
fun Receipt : Ind FinancialInstrument ;


-- Paying off an existing loan with the proceeds from a new loan, using 
-- the same property as collateral.
fun Refinancing : Class ;
fun Refinancing_Class : SubClass Refinancing FinancialTransaction ;

-- A bond issued with the name of the owner printed on the 
-- face of the certificate. It can be transferred to another individual only with the 
-- owner's endorsement.
fun RegisteredBond : Class ;
fun RegisteredBond_Class : SubClass RegisteredBond Bond ;

-- Securities, usually issued in private placements, that 
-- have limited transferability.
fun RestrictedStock : Class ;
fun RestrictedStock_Class : SubClass RestrictedStock Stock ;

-- A class of attributes which describe the degree of risk 
-- of a particular investment.
fun RiskAttribute : Class ;
fun RiskAttribute_Class : SubClass RiskAttribute RelationalAttribute ;

-- A tax_free reinvestment of a distribution from a 
-- qualified retirement plan into an IRA or other qualified plan within 60 days. 
-- Also called IRA rollover. Or more generally, a movement of funds from one investment 
-- to another.
fun Rollover : Class ;
fun Rollover_Class : SubClass Rollover FinancialTransaction ;

-- An individual retirement account in which a person 
-- can set aside after_tax income up to a specified amount each year. Earnings on the 
-- account are tax_free, and tax_free withdrawals may be made at retirement age.
fun RothIRAAccount : Class ;
fun RothIRAAccount_Class : SubClass RothIRAAccount IndividualRetirementAccount ;

fun SARSEPPlan : Class ;
fun SARSEPPlan_Class : SubClass SARSEPPlan DefinedContributionPlan ;
-- An account in a bank on which interest is usually paid and from 
-- which withdrawals can be made usually only by presentation of a passbook or by written authorization 
-- on a prescribed form.
fun SavingsAccount : Class ;
fun SavingsAccount_Class : SubClass SavingsAccount (both DepositAccount InterestBearingAccount) ;


-- A federally or state chartered FinancialOrganization 
-- that takes Deposits from individuals, funds Mortgages, and pays Dividends.
fun SavingsAndLoans : Class ;
fun SavingsAndLoans_Class : SubClass SavingsAndLoans FinancialOrganization ;

-- A defined contribution plan offered by a 
-- corporation to its employees, which allows employees to set aside 
-- tax_deferred income for retirement purposes. The name 401(k) comes from 
-- the IRS section describing the program.
fun SavingsPlan_401K : Class ;
fun SavingsPlan_401K_Class : SubClass SavingsPlan_401K DefinedContributionPlan ;

-- A retirement plan similar to a 401(k) plan, but 
-- one which is offered by non_profit organizations, such as universities and 
-- some charitable organizations, rather than corporations.
fun SavingsPlan_403B : Class ;
fun SavingsPlan_403B_Class : SubClass SavingsPlan_403B DefinedContributionPlan ;

-- A simpler alternative to a 401(k) plan available 
-- only to companies with 25 or fewer employees, which gives employees the 
-- opportunity to make contributions to their SEP accounts with pre_tax 
-- dollars and reduce their current year's net income.
fun SavingsPlan_408K : Class ;
fun SavingsPlan_408K_Class : SubClass SavingsPlan_408K PensionPlan ;

-- Bond backed by collateral, such as a mortgage 
-- or lien, the title to which would be transferred to the bondholders in the 
-- event of default.
fun SecuredBond : Class ;
fun SecuredBond_Class : SubClass SecuredBond Bond ;

fun SecuredLoan : Class ;
fun SecuredLoan_Class : SubClass SecuredLoan Loan ;
-- An investment instrument, other than an insurance policy or 
-- FixedAnnuity insurance policy or fixed annuity issued by a corporation, government, 
-- or other organization which offers evidence of debt or equity.
fun Security : Class ;
fun Security_Class : SubClass Security FinancialInstrument ;

-- The class of attributes which describe 
-- CommercialServices, such as OpenService and ClosedService.
fun ServiceAttribute : Class ;
fun ServiceAttribute_Class : SubClass ServiceAttribute RelationalAttribute ;

-- A Contract where an Agent agrees to 
-- perform a service for another Agent (usually for a price).
fun ServiceContract : Class ; 
fun ServiceContract_Class : SubClass ServiceContract Contract ;

-- Certificate, representing one unit of ownership in a corporation, 
-- MutualFund, or limited partnership.
fun Share : Class ;
fun Share_Class : SubClass Share (both CurrencyMeasure Security) ;


-- Borrowing a security (or commodity futures 
-- contract) from a broker and selling it, with the understanding that it 
-- must later be bought back (hopefully at a lower price) and returned to the 
-- broker. SEC rules allow investors to sell short only on an uptick or a 
-- zero_plus tick, to prevent 'pool operators' from driving down a stock 
-- price through heavy short_selling, then buying the shares for a large 
-- profit.
fun ShortSale : Class ;
fun ShortSale_Class : SubClass ShortSale FinancialTransaction ;

-- A put or call option by itself, as opposed to 
-- multiple options as used in a spread or straddle.
fun SingleOption : Class ;
fun SingleOption_Class : SubClass SingleOption OptionStrategy ;

-- A loan whose principal is due in total with a single 
-- payment at maturity.
fun SinglePaymentLoan : Class ;
fun SinglePaymentLoan_Class : SubClass SinglePaymentLoan Loan ;

-- The purchase of one option and the 
-- simultaneous sale of a related option, such as two options of the same 
-- class but different strike prices and/or expiration dates.
fun SpreadOption : Class ;
fun SpreadOption_Class : SubClass SpreadOption OptionStrategy ;

-- A class of four Attributes indicating the 
-- status of a FinancialAccount, viz. Active, Locked, New, and Pending.
fun StatusAttribute : Class ;
fun StatusAttribute_Class : SubClass StatusAttribute RelationalAttribute ;

-- Any index which is intended to gauge upward or downward trends 
-- in stock prices.
fun StockIndex : Class ;
fun StockIndex_Class : SubClass StockIndex Index ;

-- General term for the organized trading of stocks through 
-- exchanges and over_the_counter.
fun StockMarket : Class ;
fun StockMarket_Class : SubClass StockMarket Organization ;

-- Any FinancialTransaction which involves 
-- Stock and which occurs in a StockMarket.
fun StockMarketTransaction : Class ;
fun StockMarketTransaction_Class : SubClass StockMarketTransaction FinancialTransaction ;

-- An option in which the underlier is the 
-- common stock of a corporation, giving the holder the right to buy or 
-- sell its stock, at a specified price, by a specific date.
fun StockOption : Class ;
fun StockOption_Class : SubClass StockOption Option ;

-- Exchange of the number of shares of stock outstanding 
-- for a larger number.
fun StockSplit : Class ;
fun StockSplit_Class : SubClass StockSplit FinancialTransaction ;

-- A market order to buy or sell a certain quantity of 
-- a certain security if a specified price (the stopPrice) is reached or passed.
fun StopOrder : Class ;
fun StopOrder_Class : SubClass StopOrder FinancialOrder ;

-- The purchase or sale of an equal number of puts and 
-- calls, with the same strike price and expiration dates.
fun Straddle : Class ;
fun Straddle_Class : SubClass Straddle OptionStrategy ;

fun TaxFreeInvestment : Class ;
fun TaxFreeInvestment_Class : SubClass TaxFreeInvestment Investment ;
fun TaxableInvestment : Class ;
fun TaxableInvestment_Class : SubClass TaxableInvestment Investment ;
-- The instrument, such as a deed, that constitutes evidence 
-- of a legal right of possession or control.
fun Title : Class ;
fun Title_Class : SubClass Title FinancialInstrument ;

-- Accounts that pay interest, usually at below_market 
-- interest rates, that do not have a specific maturity, and that usually can be withdrawn upon demand
fun TraditionalSavingsAccount : Class ;
fun TraditionalSavingsAccount_Class : SubClass TraditionalSavingsAccount SavingsAccount ;

-- A negotiable debt obligation issued by the U.S. government and backed 
-- by its full faith and credit, having a maturity of one year or less. Exempt from state and local taxes
fun TreasuryBill : Class ;
fun TreasuryBill_Class : SubClass TreasuryBill SavingsAccount ;

-- A negotiable, coupon_bearing debt obligation 
-- issued by the U.S. government and backed by its full faith and credit, having 
-- a maturity of more than 7 years. Interest is paid semi_annually. Exempt from 
-- state and local taxes.
fun TreasuryBond : Class ;
fun TreasuryBond_Class : SubClass TreasuryBond Bond ;

fun UnsecuredLoan : Class ;
fun UnsecuredLoan_Class : SubClass UnsecuredLoan Loan ;
-- To change data in a file or database
fun Update : Class ;
fun Update_Class : SubClass Update (both ContentDevelopment FinancialTransaction) ;


-- A stock market transaction (or sometimes, a quote) 
-- at a price higher than the preceding one for the same security.
fun Uptick : Class ;
fun Uptick_Class : SubClass Uptick StockMarketTransaction ;

-- An activity of using a financial account
fun UsingAnAccount : Class ;
fun UsingAnAccount_Class : SubClass UsingAnAccount FinancialTransaction ;

-- A class of valid BankCards
fun ValidCard : Class ;
fun ValidCard_Class : SubClass ValidCard BankCard ;

-- When the shares in a company are considered attractive because 
-- the company is undervalue, usually because it has a low P/E ratio.
fun ValueStock : Class ;
fun ValueStock_Class : SubClass ValueStock Stock ;

-- An investment vehicle offered by an insurance company that 
-- does not guarantee a payment amount but does have the potential for greater returns than 
-- a FixedAnnuity.
fun VariableAnnuity : Class ;
fun VariableAnnuity_Class : SubClass VariableAnnuity Annuity ;

-- A subclass of AuthorizationOfTransaction 
-- where an ATM machine checks the code of the BankCard inserted to this machine.
fun VerifyingCardCode : Class ;
fun VerifyingCardCode_Class : SubClass VerifyingCardCode AuthorizationOfTransaction ;

fun VisaCard : Class ;
fun VisaCard_Class : SubClass VisaCard CreditCard ;
-- An activity of money being transferred from a customer's 
-- account at a financial institution.
fun Withdrawal : Class ;
fun Withdrawal_Class : SubClass Withdrawal FinancialTransaction ;

-- A class of attributes which describe the degree to which 
-- accounts are profitable.
fun YieldAttribute : Class ;
fun YieldAttribute_Class : SubClass YieldAttribute RelationalAttribute ;

-- A bond in which no periodic coupon is paid over the 
-- life of the contract. Instead, both the principal and the interest are paid at the 
-- maturity date.
fun ZeroCouponBond : Class ;
fun ZeroCouponBond_Class : SubClass ZeroCouponBond Bond ;

-- (accountAt ?Account ?Bank) means that ?Account is a 
-- FinancialAccount opened in the FinancialOrganization ?Bank.
fun accountAt : El FinancialAccount -> El FinancialOrganization -> Formula ;


-- (accountHolder ?Account ?Agent) means that ?Agent 
-- is the account holder of the FinancialAccount ?Account.
fun accountHolder : El FinancialAccount -> El CognitiveAgent -> Formula ;


fun accountNumber : El FinancialAccount -> El PositiveInteger -> Formula ;

-- (accountStatus ?Account ?Status) holds if 
-- ?Status describes the status of the account, such as Active, Locked, 
-- New or Pending.
fun accountStatus : El FinancialAccount -> El StatusAttribute -> Formula ;


-- The accumulated coupon interest, paid to the seller of a 
-- bond by the buyer unless the bond is in default.
fun accruedInterest : El Bond -> El Interest -> Formula ;


fun administrator : El FinancialAccount -> El Position -> Formula ;

-- (administratorStatus ?Administrator ?Status) 
-- holds is ?Status describes the status of the administrator.
fun administratorStatus : El Position -> El StatusAttribute -> Formula ;


-- An amount (usually income) after taxes 
-- have been subtracted.
fun afterTaxIncome : El Human -> El CurrencyMeasure -> El OrganizationalProcess -> Formula ;


-- (agreementActive ?Agreement ?Date) holds if 
-- ?Agreement is in force at the time specified by ?Date.
fun agreementActive : El Contract -> El TimePosition -> Formula ;


-- (agreementMember ?Agreement ?Agent) means that 
-- ?Agent is one of the participants of the Agreement.
fun agreementMember : El Contract -> El CognitiveAgent -> Formula ;


-- (agreementPeriod ?Agreement ?Period) holds if 
-- ?Period specifies a Time interval during which ?Agreement is in force.
fun agreementPeriod : El Contract -> El TimeInterval -> Formula ;


-- (amountCharged ?Fee ?Amount) means that ?Amount is the amount of 
-- the fee charged.
fun amountCharged : El ChargingAFee -> El CurrencyMeasure -> Formula ;


-- (amountDue ?ACCOUNT ?AMOUNT ?DATE) means ?DATE is the 
-- date on which the amount of Money ?AMOUNT of a particular ?ACCOUNT is due and payable
fun amountDue : El FinancialAccount -> El CurrencyMeasure -> El TimePosition -> Formula ;


fun appraisedValue : El Collateral -> El CurrencyMeasure -> Formula ;

-- (askPrice ?Obj ?Money ?Agent) means that ?Agent offers to sell 
-- ?Obj for the amount of ?Money.
fun askPrice : El Object -> El CurrencyMeasure -> El Agent -> Formula ;


-- A term that describes an option with a strike 
-- price that is equal to the current market price of the underlying stock.
fun atTheMoney : El Option -> El TimePosition -> Formula ;


-- (availableBalance ?Account ?Day ?Amount) means 
-- that ?Amount is the balance which is available for withdrawal from the FinancialAccount 
-- ?Account.
fun availableBalance : El FinancialAccount -> El Day -> El CurrencyMeasure -> Formula ;


-- (availableCash ?Account ?Day ?Cash) holds if 
-- ?Cash is a cash amount available for withdrawal from the FinancialAccount 
-- ?Account.
fun availableCash : El FinancialAccount -> El Day -> El CurrencyMeasure -> Formula ;


-- (bankAccount ?Type ?Bank) holds if ?Type is a 
-- type of the financial accounts offered by the bank.
fun bankAccount: Desc FinancialAccount -> El Bank_FinancialOrganization -> Formula ;


-- Income before taxes are deducted
fun beforeTaxIncome : El Human -> El CurrencyMeasure -> El OrganizationalProcess -> Formula ;


-- A standard by which something can be measured or judged.
fun benchmark : El Abstract -> El PerformanceMeasure -> Formula ;


-- (bidPrice ?Obj ?Money ?Agent) means that ?Agent offers to buy 
-- ?Obj for the amount of ?Money.
fun bidPrice : El Object -> El CurrencyMeasure -> El Agent -> Formula ;


-- A measure of the quality and safety of a bond, 
-- based on the issuer's financial condition. More specifically, an 
-- evaluation from a rating service indicating the likelihood that a debt 
-- issuer will be able to meet scheduled interest and principal repayments. 
-- Typically, AAA is highest (best), and D is lowest (worst).
fun bondRating : El Bond -> El FinancialRating -> Formula ;


-- (borrower ?Loan ?Agent) means that ?Agent is a borrower of the ?Loan
fun borrower : El Loan -> El CognitiveAgent -> Formula ;


-- (buyingPowerAmount ?Account ?Day ?Amount) holds 
-- if ?Amount is the buying power amount of the FinancialAccount ?Account on the Day 
-- ?Day.
fun buyingPowerAmount : El FinancialAccount -> El Day -> El CurrencyMeasure -> Formula ;


-- Date, prior to maturity, on which a callable bond 
-- may be redeemed.
fun callDate : El Bond -> El Day -> Formula ;


-- (cardAccount ?Card ?Account) means that ?Account is 
-- the FinancialAccount linked to a BankCard ?Card.
fun cardAccount : El BankCard -> El FinancialAccount -> Formula ;


-- (cardCode ?Code ?Card) means that ?Code represents 
-- the account number of the BankCard ?Card.
fun cardCode : El ContentBearingObject -> El BankCard -> Formula ;


-- (checkAccount ?Check ?Account) means that ?Account 
-- is the FinancialAccount from which the amount specifed on the check is paid.
fun checkAccount : El Check -> El FinancialAccount -> Formula ;


fun checkNumber : El Check -> El PositiveInteger -> Formula;

-- (closingPrice ?Stock ?Amount ?Day) means that the closing 
-- price of the Stock ?Stock on the Day ?Day was ?Amount.
fun closingPrice : El Stock -> El CurrencyMeasure -> El Day -> Formula ;


-- The total monetary value an employee 
-- receives during a certain time period.
fun compensationPackage : El Human -> El CurrencyMeasure -> El TimePosition -> Formula ;


-- (compoundInterest ?Account ?Amount ?Time) means 
-- that ?Amount is the interest which is calculated not only on the initial principal 
-- but also the accumulated interest of prior periods. Compound interest can be 
-- calculated annually, semi_annually, quartely, monthly, or daily.
fun compoundInterest : El FinancialAccount -> El Interest -> El TimeInterval -> Formula ;


fun confirmationNumber : El FinancialTransaction -> El SymbolicString -> Formula ;

-- (couponInterest ?BOND ?INTEREST) means that ?INTEREST is 
-- the periodic interest payment made to bondholders during the life of the ?BOND.
fun couponInterest : El Bond -> El Interest -> Formula ;


-- (creditLimit ?ACCOUNT ?AMNT) holds if ?AMNT is the 
-- maximum amount of credit that a bank or other lender will extend to a customer.
fun creditLimit : El CreditAccount -> El CurrencyMeasure -> Formula ;


-- (creditRanking ?Agent ?Rating) holds if 
-- ?Rating is a FinancialRating based on financial analysis by a credit 
-- bureau, of one's financial history, specifically as it relates to one's 
-- ability to meet debt obligations. Lenders use this information to decide 
-- whether to approve a loan.
fun creditRanking : El CognitiveAgent -> El FinancialRating -> Formula ;


-- (creditsPerPeriod ?Account ?Amount ?Period) 
-- holds if ?Amount is the amount credited to the FinancialAccount ?Account during 
-- the time period ?Period.
fun creditsPerPeriod : El FinancialAccount -> El CurrencyMeasure -> El TimeInterval -> Formula ;


-- (currentAccountBalance ?Account ?Date ?Amount) means that ?Amount is the balance of the FinancialAccount ?Account as of the date 
-- ?Date.
fun currentAccountBalance : El FinancialAccount -> El Day -> El CurrencyMeasure -> Formula ;


-- (currentInterestRate ?Account ?Day ?Rate) 
-- means that ?Rate is the interest rate of the Account on a specific day ?Day.
fun currentInterestRate : El FinancialAccount -> El Day -> El InterestRate -> Formula ;


-- A very general relation that exists whenever there
-- is a FinancialTransaction between the two Agents such that the first is
-- the destination of the FinancialTransaction and the second is the
-- agent.
fun customer : El CognitiveAgent -> El CognitiveAgent -> Formula ;


-- (customerRepresentative 
-- ?PERSON1 ?PERSON2 ?ORG) means that ?PERSON1 acts as a representative 
-- of Organization ?ORG in a SocialInteraction involving ?PERSON2.
fun customerRepresentative : El CognitiveAgent -> El CognitiveAgent -> El Organization -> Formula ;


-- (dailyLimit ?Account ?TransactionType ?Amount) 
-- means that ?Amount is the daily limit of the ?Account for the type of 
-- FinancialTransactions ?TransactionType.
fun dailyLimit: El FinancialAccount -> Desc FinancialTransaction -> El CurrencyMeasure -> Formula ;


-- (dateOfStatement ?Statement ?Date) holds if 
-- ?Date is the date when BankStatement was issued.
fun dateOfStatement : El BankStatement -> El Day -> Formula ;


-- (dayPhone ?Phone ?Agent) means that ?Phone is a phone 
-- number corresponding to the location where ?Agent can be reached during the day.
fun dayPhone : El SymbolicString -> El Agent -> Formula ;


-- The part of the purchase price paid in cash up front, 
-- reducing the amount of the loan or mortgage.
fun downPayment : El Loan -> El CurrencyMeasure -> Formula ;


-- Legal date an agreement or document goes into force.
fun effectiveDate : El Contract -> El Day -> Formula ;


-- (emailAddress ?Address ?Agent) means that ?Address is 
-- an electronic address of the location where ?Agent can be reached.
fun emailAddress : El SymbolicString -> El Agent -> Formula ;


-- An individual's contribution to his/her 
-- own retirement plan, often tax_deferred.
fun employeeContribution : El Human -> El CurrencyMeasure -> El TimeInterval -> Formula ;


-- (eveningPhone ?Phone ?Agent) means that ?Phone 
-- is a phone number corresponidng to the location where ?Agent can be reached 
-- during the evening.
fun eveningPhone : El SymbolicString -> El Agent -> Formula ;


-- (expirationDate ?Contract ?Date) means that 
-- ?Date is the date on which ?Contract expires.
fun expirationDate : El Contract -> El Day -> Formula ;


-- The nominal dollar amount assigned to a security by the issuer. 
-- For an equity security, par is usually a very small amount that bears no relationship to 
-- its market price, except for preferred stock, in which case par is used to calculate dividend 
-- payments. For a debt security, par is the amount repaid to the investor when the bond matures 
-- (usually, corporate bonds have a par value of 1000, municipal bonds 5000, and federal bonds 
-- 10,000).
fun faceValue : El Collateral -> El CurrencyMeasure -> Formula ;


fun finalPrice : El Stock -> El CurrencyMeasure -> Formula ;

-- (financialResponseTo ?Response ?Request) means that 
-- ?Response is a FinancialResponse to the FinancialRequest ?Request.
fun financialResponseTo : El FinancialResponse -> El FinancialRequest -> Formula ;


-- (fixedInterestRate ?Account ?Rate) holds if 
-- ?Rate is the interest rate that does not change during the entire term of the 
-- account.
fun fixedInterestRate : El FinancialAccount -> El InterestRate -> Formula ;


-- A minimum amount that a lender is willing to loan
fun floorLoan : El Loan -> El CurrencyMeasure -> Formula ;


-- A call option is in the money if the stock 
-- price is above the strike price. A put option is in the money if the 
-- stock price is below the strike price.
fun inTheMoney : El Option -> El TimePosition -> Formula ;


-- (incomeOf ?Agent ?Money ?Period) means that 
-- ?Money is the amount of money or its equivalent received during a period 
-- of time in exchange for labor or services, from the sale of goods or 
-- property, or as profit from financial investments
fun income : El Human -> El CurrencyMeasure -> El TimeInterval -> Formula ;


-- (incomeEarned ?Agent ?Money ?Action) means 
-- that ?Agent earned the amount of money ?Money from performing ?Action. Note 
-- that incomeEarned denotes that amount of money made before taxes are 
-- deducted.
fun incomeEarned : El Human -> El CurrencyMeasure -> El OrganizationalProcess -> Formula ;


-- The percentage increase in the price of goods and services, 
-- usually annually.
fun inflationRate : El Inflation -> El RealNumber -> Formula ;


-- The annually percentage increase 
-- in the price of goods and services for the given Nation.
fun inflationRateInCountry : El Nation -> El RealNumber -> Formula ;


-- (insured ?Contract ?Org) means that ?Contract is insured 
-- by the ?Organization.
fun insured : El Contract -> El Organization -> Formula ;


-- (interestEarned ?Account ?Interest ?Period) means 
-- that ?Interest is the amount earned on the FinancialAccount ?Account, for the 
-- duration ?Period.
fun interestEarned : El FinancialAccount -> El Interest -> El TimeInterval -> Formula ;


-- (interestRatePerPeriod ?ACCOUNT ?RATE ?TIME) means that ?RATE is the interest 
-- per the period TIME divided by principal amount, expressed as a percentage
fun interestRatePerPeriod : El FinancialAccount -> El InterestRate -> El TimeInterval -> Formula ;


-- (issuedBy ?Instrument ?Agent) means that a 
-- FinancialInstrument ?Instrument is produced and offered by ?Agent.
fun issuedBy : El FinancialInstrument -> El CognitiveAgent -> Formula ;


-- (lastStatement ?Account ?Statement) means that 
-- ?Statement is the most recent monthly report sent to a debtor or bank depositor.
fun lastStatement : El FinancialAccount -> El BankStatement -> Formula ;


-- (lastStatementBalance ?Account ?Amount) 
-- holds if ?Amount is the balance shown on the last statement.
fun lastStatementBalance : El FinancialAccount -> El CurrencyMeasure -> Formula ;


-- (lender ?Loan ?Agent) means that ?Agent is a private, public or 
-- institutional entity that put up the funds for the ?Loan.
fun lender : El Loan -> El CognitiveAgent -> Formula ;


-- (limitPrice ?Order ?Money) means that ?Money is the limit price 
-- for the limit order ?Order. If ?Order is a buy order, then ?Money specifies the maximum price
-- to be paid. If ?Order is a sell order, then ?Money specifies the minimum price to be paid.
fun limitPrice : El LimitOrder -> El CurrencyMeasure -> Formula ;


-- Degree to which accounts can be easily converted to cash.
fun liquidity : El FinancialAccount -> El LiquidityAttribute -> Formula ;


fun listedOn : El Stock -> El Organization -> Formula ;

-- (loanFeeAmount ?Loan ?Amount) means that 
-- ?Amount is the fee amount of the Loan ?Loan.
fun loanFeeAmount : El Loan -> El CurrencyMeasure -> Formula ;


-- (loanForPurchase ?ACCOUNT ?PRODUCT) means that ?ACCOUNT is a 
-- loan to finance the purchase of ?PRODUCT.
fun loanForPurchase : El Loan -> El Object -> Formula ;


fun loanInterest : El Loan -> El CurrencyMeasure -> Formula ;

-- (marginBalanceAmount ?Account ?Day ?Amount) 
-- holds if ?Amount is the margin balance amount of the FinancialAccount ?Account 
-- on the Day ?Day.
fun marginBalanceAmount : El FinancialAccount -> El Day -> El CurrencyMeasure -> Formula ;


fun marketValueAmount : El FinancialAccount -> El Day -> El CurrencyMeasure -> Formula ;

-- The date on which the principal amount of the account 
-- becomes due and payable.
fun maturityDate : El FinancialAccount -> El Day -> Formula ;


-- (minimumBalance ?Account ?ActivityType ?Amount) 
-- means that ?Amount is the mimimum amount required by the type of 
-- FinancialTransaction ?ActivityType.
fun minimumBalance: El FinancialAccount -> Desc FinancialTransaction -> El CurrencyMeasure -> Formula ;


-- The smallest amount which can be paid on a revolving 
-- charge account to avoid a penalty.
fun minimumPayment : El LiabilityAccount -> El CurrencyMeasure -> El TimeDuration -> Formula ;


-- (monthlyIncome ?Agent ?Money) means that 
-- ?Money is the amount of money received during one month period
fun monthlyIncome : El Human -> El CurrencyMeasure -> Formula ;


-- The amount due the supplier after commissions 
-- have been deducted.
fun netAmount : El Investment -> El CurrencyMeasure -> Formula ;


-- Total assets minus total liabilities of an individual or company.
fun netWorth : El CognitiveAgent -> El CurrencyMeasure -> El Day -> Formula ;


-- (optionHolder ?Option ?Agent) means that 
-- ?Agent is the holder of the option.
fun optionHolder : El Option -> El CognitiveAgent -> Formula ;


-- (optionSeller ?Option ?Agent) means that 
-- ?Agent is the writer of the option.
fun optionSeller : El Option -> El CognitiveAgent -> Formula ;


-- (orderFor ?Order ?Transaction ?Security) means that the content of ?Order 
-- is to realize an instance of ?Transaction where ?Security is the patient of ?Transaction.
fun orderFor: El FinancialTransaction -> Desc FinancialTransaction -> El Security -> Formula ;


-- (originalBalance ?ACCOUNT ?BALANCE) means that 
-- ?BALANCE is the balance of the account at the time the account is opened.
fun originalBalance : El FinancialAccount -> El CurrencyMeasure -> Formula ;


-- A call option is out of the money if the 
-- stock price is below its strike price. A put option is out of the money 
-- if the stock price is above its strike price.
fun outOfTheMoney : El Option -> El TimePosition -> Formula ;


-- The amount by which withdrawals exceed deposits.
fun overdraft : El FinancialAccount -> El CurrencyMeasure -> El Day -> Formula ;


-- (paymentsPerPeriod ?Account ?Amount ?Period) 
-- holds if ?Amount is the amount paid on the FinancialAccount ?Account during the 
-- time period ?Period.
fun paymentsPerPeriod : El FinancialAccount -> El CurrencyMeasure -> El TimeInterval -> Formula ;


-- (periodicPayment ?Pay ?Amount ?Period) holds if 
-- ?Pay is one of the periodic payments for the amount ?Amount.
fun periodicPayment : El FinancialAccount -> El CurrencyMeasure -> El TimeDuration -> Formula ;


-- (phoneNumber ?Phone ?Agent) holds if ?Phone is 
-- a phone number corresponding to the Telephone ?Phone.
fun phoneNumber : El SymbolicString -> El Telephone -> Formula ;


-- (pin ?PIN ?Card) means that ?PIN is a personal identification 
-- number linked to the ?Card.
fun pin : El SymbolicString -> El BankCard -> Formula ;


-- The maximum amount of money the Agent can lose by choosing 
-- this type of Investment.
fun potentialLoss : El CognitiveAgent -> El Investment -> El CurrencyMeasure -> Formula ;


-- Total price of an option.
fun premium : El Option -> El CurrencyMeasure -> Formula ;


-- (price ?Obj ?Money ?Agent) means that ?Agent pays the amount of 
-- money ?Money for ?Obj.
fun price : El Physical -> El CurrencyMeasure -> El Agent -> Formula ;


-- The interest rate that commercial banks charge 
-- their most creditworthy borrowers, such as large corporations. The prime rate is 
-- a lagging indicator.
fun primeInterestRate : El Day -> El InterestRate -> Formula ;


-- (principalAmount ?ACCOUNT ?BALANCE) means 
-- that ?BALANCE is the amount borrowed, or the part of the amount borrowed 
-- which remains unpaid (excluding interest).
fun principalAmount : El FinancialAccount -> El CurrencyMeasure -> Formula ;


-- The positive gain from an investment or business operation after 
-- subtracting for all expenses.
fun profit : El FinancialTransaction -> El CurrencyMeasure -> Formula ;


-- (purchasesPerPeriod ?Account ?Amount ?Period) 
-- holds if ?Amount is the amount of purchases added to the FinancialAccount ?Account 
-- during the time period ?Period.
fun purchasesPerPeriod : El FinancialAccount -> El CurrencyMeasure -> El TimeInterval -> Formula ;


-- Relates an instance of Investing to the level of risk associated 
-- with the investment.
fun riskLevel : El Investment -> El RiskAttribute -> Formula ;


fun riskTolerance : El Investor -> El RiskAttribute -> Formula ;

-- Assets pledged by a borrower to secure a loan 
-- or other credit, and subject to seizure in the event of FinancialDefault.
fun securedBy : El FinancialAccount -> El Collateral -> Formula ;


-- A charge to the customer levied by a FinancialOrganization 
-- for a FinancialTransaction, such as OpeningAnAccount or UsingAnAccount.
fun serviceFee : El FinancialOrganization -> El FinancialTransaction -> El CurrencyMeasure -> Formula ;


-- (shareHolder ?Stock ?Agent) means that ?Agent possesses 
-- shares of Stock in a corporation or mutual fund.
fun shareHolder : El Share -> El CognitiveAgent -> Formula ;


fun shareOf : El Share -> El Organization -> Formula ;

-- (marketvalueAmount ?Account ?Day ?Amount) holds 
-- if ?Amount is the market value amount of the FinancialAccount ?Account on the Day 
-- ?Day. shortBalanceAmount (shortBalanceAmount ?Account ?Day ?Amount) 
-- holds if ?Amount is the short balance amount of the FinancialAccount ?Account 
-- on the Day ?Day.
fun shortBalanceAmount : El FinancialAccount -> El Day -> El CurrencyMeasure -> Formula ;


-- (signedBy ?Instrument ?Agent) means that ?Instrument 
-- has been signed by ?Agent.
fun signedBy : El Certificate -> El CognitiveAgent -> Formula ;


-- (simpleInterest ?Account ?Amount ?Time) means 
-- that ?Amount is the interest calculated on a principal sum, not compounded on 
-- earned interest, for the duration ?Time.
fun simpleInterest : El FinancialAccount -> El Interest -> El TimeInterval -> Formula ;


fun splitFor : El StockSplit -> El Integer -> El Integer -> Formula ;

-- (statementAccount ?Statement ?Account) means 
-- that ?Account is the account of the BankStatement ?Statement.
fun statementAccount : El BankStatement -> El FinancialAccount -> Formula ;


-- (statementInterest ?Statement ?Amount) holds 
-- if ?Amount is the interest amount as shown on the BankStatement ?Statement.
fun statementInterest : El BankStatement -> El CurrencyMeasure -> Formula ;


-- (statementPeriod ?Statement ?Period) means that 
-- ?Period is the time period of the BankStatement ?Statement.
fun statementPeriod : El BankStatement -> El TimeInterval -> Formula ;


-- A unique symbol assigned to a security. NYSE and 
-- AMEX listed stocks have symbols of three characters or less. NASDAQ_listed 
-- securities have four or five characters.
fun stockSymbol : El Stock -> El SymbolicString -> Formula ;


-- The specified price on an option contract at 
-- which the contract may be exercised, whereby a call option buyer can buy 
-- the underlier or a put option buyer can sell the underlier.
fun strikePrice : El FinancialInstrument -> El CurrencyMeasure -> Formula ;


-- Income whose taxes can be postponed 
-- until a later date. Examples include IRA, 401(k), Keogh Plan, annuity, 
-- Savings Bond and Employee Stock Ownership Plan.
fun taxDeferredIncome : El Human -> El CurrencyMeasure -> El OrganizationalProcess -> Formula ;


-- (underlier ?Option ?Instrument) means that 
-- ?Instrument is a security which is subject to delivery upon exercise of 
-- ?Option.
fun underlier : El Option -> El FinancialInstrument -> Formula ;


-- The annual rate of return on an investment, expressed as a 
-- percentage. For bonds and notes, it is the coupon rate divided by the market price.
fun yield : El Investment -> El FunctionQuantity -> Formula ;


-- A profit obtained from an investment. yieldLevel Relates a FinancialAccount to the yield level (i.e. the type of profit) 
--which can be expected from the account.
fun yieldLevel : El FinancialAccount -> El YieldAttribute -> Formula ;
}
