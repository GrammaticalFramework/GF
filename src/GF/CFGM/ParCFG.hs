-- parser produced by Happy Version 1.13

module ParCFG where
import AbsCFG
import LexCFG
import ErrM

data HappyAbsSyn t4 t5 t6
	= HappyTerminal Token
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 (Grammars)
	| HappyAbsSyn8 (Grammar)
	| HappyAbsSyn9 ([Grammar])
	| HappyAbsSyn10 (Flag)
	| HappyAbsSyn11 ([Flag])
	| HappyAbsSyn12 (Rule)
	| HappyAbsSyn13 ([Rule])
	| HappyAbsSyn14 (Profile)
	| HappyAbsSyn15 (Ints)
	| HappyAbsSyn16 ([Ints])
	| HappyAbsSyn17 ([Integer])
	| HappyAbsSyn18 (Symbol)
	| HappyAbsSyn19 ([Symbol])
	| HappyAbsSyn20 (Name)
	| HappyAbsSyn21 ([IdentParam])
	| HappyAbsSyn22 (Category)
	| HappyAbsSyn23 (IdentParam)
	| HappyAbsSyn24 (Param)
	| HappyAbsSyn25 ([Param])

action_0 (7) = happyGoto action_3
action_0 (9) = happyGoto action_4
action_0 _ = happyReduce_6

action_1 (40) = happyShift action_2
action_1 _ = happyFail

action_2 _ = happyReduce_1

action_3 (44) = happyAccept
action_3 _ = happyFail

action_4 (38) = happyShift action_6
action_4 (8) = happyGoto action_5
action_4 _ = happyReduce_4

action_5 _ = happyReduce_7

action_6 (40) = happyShift action_2
action_6 (4) = happyGoto action_7
action_6 _ = happyFail

action_7 (11) = happyGoto action_8
action_7 _ = happyReduce_9

action_8 (39) = happyShift action_11
action_8 (10) = happyGoto action_9
action_8 (13) = happyGoto action_10
action_8 _ = happyReduce_12

action_9 (26) = happyShift action_18
action_9 _ = happyFail

action_10 (37) = happyShift action_17
action_10 (40) = happyShift action_2
action_10 (4) = happyGoto action_15
action_10 (12) = happyGoto action_16
action_10 _ = happyFail

action_11 (40) = happyShift action_2
action_11 (4) = happyGoto action_12
action_11 (22) = happyGoto action_13
action_11 (23) = happyGoto action_14
action_11 _ = happyFail

action_12 (34) = happyShift action_23
action_12 _ = happyFail

action_13 _ = happyReduce_8

action_14 (28) = happyShift action_22
action_14 _ = happyFail

action_15 (27) = happyShift action_21
action_15 _ = happyFail

action_16 (26) = happyShift action_20
action_16 _ = happyFail

action_17 (38) = happyShift action_19
action_17 _ = happyFail

action_18 _ = happyReduce_10

action_19 _ = happyReduce_5

action_20 _ = happyReduce_13

action_21 (20) = happyGoto action_26
action_21 (21) = happyGoto action_27
action_21 _ = happyReduce_27

action_22 (40) = happyShift action_2
action_22 (4) = happyGoto action_25
action_22 _ = happyFail

action_23 (25) = happyGoto action_24
action_23 _ = happyReduce_32

action_24 (35) = happyShift action_34
action_24 (36) = happyShift action_35
action_24 (24) = happyGoto action_33
action_24 _ = happyFail

action_25 (25) = happyGoto action_32
action_25 _ = happyReduce_32

action_26 (30) = happyShift action_31
action_26 (14) = happyGoto action_30
action_26 _ = happyFail

action_27 (40) = happyShift action_2
action_27 (4) = happyGoto action_12
action_27 (22) = happyGoto action_28
action_27 (23) = happyGoto action_29
action_27 _ = happyFail

action_28 _ = happyReduce_26

action_29 (28) = happyShift action_22
action_29 (33) = happyShift action_41
action_29 _ = happyFail

action_30 (28) = happyShift action_40
action_30 _ = happyFail

action_31 (30) = happyShift action_39
action_31 (15) = happyGoto action_37
action_31 (16) = happyGoto action_38
action_31 _ = happyReduce_16

action_32 (36) = happyShift action_35
action_32 (24) = happyGoto action_33
action_32 _ = happyReduce_29

action_33 _ = happyReduce_33

action_34 _ = happyReduce_30

action_35 (40) = happyShift action_2
action_35 (4) = happyGoto action_36
action_35 _ = happyFail

action_36 _ = happyReduce_31

action_37 (32) = happyShift action_47
action_37 _ = happyReduce_17

action_38 (31) = happyShift action_46
action_38 _ = happyFail

action_39 (41) = happyShift action_45
action_39 (5) = happyGoto action_43
action_39 (17) = happyGoto action_44
action_39 _ = happyReduce_19

action_40 (40) = happyShift action_2
action_40 (4) = happyGoto action_12
action_40 (22) = happyGoto action_42
action_40 (23) = happyGoto action_14
action_40 _ = happyFail

action_41 _ = happyReduce_28

action_42 (29) = happyShift action_51
action_42 _ = happyFail

action_43 (32) = happyShift action_50
action_43 _ = happyReduce_20

action_44 (31) = happyShift action_49
action_44 _ = happyFail

action_45 _ = happyReduce_2

action_46 _ = happyReduce_14

action_47 (30) = happyShift action_39
action_47 (15) = happyGoto action_37
action_47 (16) = happyGoto action_48
action_47 _ = happyReduce_16

action_48 _ = happyReduce_18

action_49 _ = happyReduce_15

action_50 (41) = happyShift action_45
action_50 (5) = happyGoto action_43
action_50 (17) = happyGoto action_53
action_50 _ = happyReduce_19

action_51 (19) = happyGoto action_52
action_51 _ = happyReduce_24

action_52 (40) = happyShift action_2
action_52 (42) = happyShift action_57
action_52 (4) = happyGoto action_12
action_52 (6) = happyGoto action_54
action_52 (18) = happyGoto action_55
action_52 (22) = happyGoto action_56
action_52 (23) = happyGoto action_14
action_52 _ = happyReduce_11

action_53 _ = happyReduce_21

action_54 _ = happyReduce_23

action_55 _ = happyReduce_25

action_56 _ = happyReduce_22

action_57 _ = happyReduce_3

happyReduce_1 = happySpecReduce_1 4 happyReduction_1
happyReduction_1 (HappyTerminal (PT _ (TV happy_var_1)))
	 =  HappyAbsSyn4
		 (Ident happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1 5 happyReduction_2
happyReduction_2 (HappyTerminal (PT _ (TI happy_var_1)))
	 =  HappyAbsSyn5
		 ((read happy_var_1) :: Integer
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1 6 happyReduction_3
happyReduction_3 (HappyTerminal (PT _ (TL happy_var_1)))
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1 7 happyReduction_4
happyReduction_4 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn7
		 (Grammars (reverse happy_var_1)
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happyReduce 6 8 happyReduction_5
happyReduction_5 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_4) `HappyStk`
	(HappyAbsSyn11  happy_var_3) `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (Grammar happy_var_2 (reverse happy_var_3) (reverse happy_var_4)
	) `HappyStk` happyRest

happyReduce_6 = happySpecReduce_0 9 happyReduction_6
happyReduction_6  =  HappyAbsSyn9
		 ([]
	)

happyReduce_7 = happySpecReduce_2 9 happyReduction_7
happyReduction_7 (HappyAbsSyn8  happy_var_2)
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_7 _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_2 10 happyReduction_8
happyReduction_8 (HappyAbsSyn22  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (StartCat happy_var_2
	)
happyReduction_8 _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_0 11 happyReduction_9
happyReduction_9  =  HappyAbsSyn11
		 ([]
	)

happyReduce_10 = happySpecReduce_3 11 happyReduction_10
happyReduction_10 _
	(HappyAbsSyn10  happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happyReduce 8 12 happyReduction_11
happyReduction_11 ((HappyAbsSyn19  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn22  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_4) `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (Rule happy_var_1 happy_var_3 happy_var_4 happy_var_6 (reverse happy_var_8)
	) `HappyStk` happyRest

happyReduce_12 = happySpecReduce_0 13 happyReduction_12
happyReduction_12  =  HappyAbsSyn13
		 ([]
	)

happyReduce_13 = happySpecReduce_3 13 happyReduction_13
happyReduction_13 _
	(HappyAbsSyn12  happy_var_2)
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3 14 happyReduction_14
happyReduction_14 _
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (Profile happy_var_2
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3 15 happyReduction_15
happyReduction_15 _
	(HappyAbsSyn17  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (Ints happy_var_2
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_0 16 happyReduction_16
happyReduction_16  =  HappyAbsSyn16
		 ([]
	)

happyReduce_17 = happySpecReduce_1 16 happyReduction_17
happyReduction_17 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn16
		 ((:[]) happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3 16 happyReduction_18
happyReduction_18 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn16
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_0 17 happyReduction_19
happyReduction_19  =  HappyAbsSyn17
		 ([]
	)

happyReduce_20 = happySpecReduce_1 17 happyReduction_20
happyReduction_20 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn17
		 ((:[]) happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3 17 happyReduction_21
happyReduction_21 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn17
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1 18 happyReduction_22
happyReduction_22 (HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn18
		 (CatS happy_var_1
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1 18 happyReduction_23
happyReduction_23 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn18
		 (TermS happy_var_1
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_0 19 happyReduction_24
happyReduction_24  =  HappyAbsSyn19
		 ([]
	)

happyReduce_25 = happySpecReduce_2 19 happyReduction_25
happyReduction_25 (HappyAbsSyn18  happy_var_2)
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn19
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_25 _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_2 20 happyReduction_26
happyReduction_26 (HappyAbsSyn22  happy_var_2)
	(HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn20
		 (Name (reverse happy_var_1) happy_var_2
	)
happyReduction_26 _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_0 21 happyReduction_27
happyReduction_27  =  HappyAbsSyn21
		 ([]
	)

happyReduce_28 = happySpecReduce_3 21 happyReduction_28
happyReduction_28 _
	(HappyAbsSyn23  happy_var_2)
	(HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn21
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happyReduce 4 22 happyReduction_29
happyReduction_29 ((HappyAbsSyn25  happy_var_4) `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (Category happy_var_1 happy_var_3 (reverse happy_var_4)
	) `HappyStk` happyRest

happyReduce_30 = happyReduce 4 23 happyReduction_30
happyReduction_30 (_ `HappyStk`
	(HappyAbsSyn25  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (IdentParam happy_var_1 (reverse happy_var_3)
	) `HappyStk` happyRest

happyReduce_31 = happySpecReduce_2 24 happyReduction_31
happyReduction_31 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn24
		 (Param happy_var_2
	)
happyReduction_31 _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_0 25 happyReduction_32
happyReduction_32  =  HappyAbsSyn25
		 ([]
	)

happyReduce_33 = happySpecReduce_2 25 happyReduction_33
happyReduction_33 (HappyAbsSyn24  happy_var_2)
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_33 _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 44 44 (error "reading EOF!") (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	PT _ (TS ";") -> cont 26;
	PT _ (TS ":") -> cont 27;
	PT _ (TS ".") -> cont 28;
	PT _ (TS "->") -> cont 29;
	PT _ (TS "[") -> cont 30;
	PT _ (TS "]") -> cont 31;
	PT _ (TS ",") -> cont 32;
	PT _ (TS "/") -> cont 33;
	PT _ (TS "{") -> cont 34;
	PT _ (TS "}") -> cont 35;
	PT _ (TS "!") -> cont 36;
	PT _ (TS "end") -> cont 37;
	PT _ (TS "grammar") -> cont 38;
	PT _ (TS "startcat") -> cont 39;
	PT _ (TV happy_dollar_dollar) -> cont 40;
	PT _ (TI happy_dollar_dollar) -> cont 41;
	PT _ (TL happy_dollar_dollar) -> cont 42;
	_ -> cont 43;
	_ -> happyError tks
	}

happyThen :: Err a -> (a -> Err b) -> Err b
happyThen = (thenM)
happyReturn :: a -> Err a
happyReturn = (returnM)
happyThen1 m k tks = (thenM) m (\a -> k a tks)
happyReturn1 = \a tks -> (returnM) a

pGrammars tks = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn7 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq

returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ if null ts then [] else (" before " ++ unwords (map prToken (take 4 ts)))

myLexer = tokens
{-# LINE 1 "GenericTemplate.hs" #-}
-- $Id: ParCFG.hs,v 1.1 2004/08/23 08:51:37 bringert Exp $

{-# LINE 15 "GenericTemplate.hs" #-}






















































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

happyAccept j tk st sts (HappyStk ans _) = 

					   (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 150 "GenericTemplate.hs" #-}


-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
	 sts1@(((st1@(HappyState (action))):(_))) ->
        	let r = fn stk in  -- it doesn't hurt to always seq here...
       		happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
        happyThen1 (fn stk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))
       where sts1@(((st1@(HappyState (action))):(_))) = happyDrop k ((st):(sts))
             drop_stk = happyDropStk k stk

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail  (1) tk old_st _ stk =
--	trace "failing" $ 
    	happyError


{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
						(saved_tok `HappyStk` _ `HappyStk` stk) =
--	trace ("discarding state, depth " ++ show (length stk))  $
	action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
	action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--	happySeq = happyDoSeq
-- otherwise it emits
-- 	happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
