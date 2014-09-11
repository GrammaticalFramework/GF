module PGF.ByteCode(Literal(..),
                    CodeLabel, Instr(..), IVal(..), TailInfo(..),
                    ppLit, ppCode, ppInstr
                   ) where

import PGF.CId
import Text.PrettyPrint

data Literal =
   LStr String                      -- ^ string constant
 | LInt Int                         -- ^ integer constant
 | LFlt Double                      -- ^ floating point constant
 deriving (Eq,Ord,Show)

type CodeLabel = Int

data Instr
  = ENTER
  | CASE CId     {-# UNPACK #-} !CodeLabel
  | CASE_LIT Literal  {-# UNPACK #-} !CodeLabel
  | ALLOC  {-# UNPACK #-} !Int
  | PUT_CONSTR CId
  | PUT_FUN CId
  | PUT_CLOSURE   {-# UNPACK #-} !CodeLabel
  | PUT_LIT Literal
  | SET IVal
  | SET_PAD
  | PUSH IVal
  | EVAL IVal TailInfo
  | CALL CId  TailInfo
  | FAIL
  | UPDATE
  | RET {-# UNPACK #-} !Int

data IVal
  = HEAP     {-# UNPACK #-} !Int
  | ARG_VAR  {-# UNPACK #-} !Int
  | FREE_VAR {-# UNPACK #-} !Int

data TailInfo
  = RecCall
  | TailCall {-# UNPACK #-} !Int {-# UNPACK #-} !Int

ppLit (LStr s) = text (show s)
ppLit (LInt n) = int n
ppLit (LFlt d) = double d

ppCode :: Int -> [[Instr]] -> Doc
ppCode l []       = empty
ppCode l (is:iss) = ppLabel l <+> vcat (map ppInstr is) $$ ppCode (l+1) iss

ppInstr (ENTER          ) = text "ENTER"
ppInstr (CASE id l      ) = text "CASE       " <+> ppCId id <+> ppLabel l
ppInstr (CASE_LIT lit l ) = text "CASE_LIT   " <+> ppLit lit <+> ppLabel l
ppInstr (ALLOC         n) = text "ALLOC      " <+> int n
ppInstr (PUT_CONSTR   id) = text "PUT_CONSTR " <+> ppCId id
ppInstr (PUT_FUN      id) = text "PUT_FUN    " <+> ppCId id
ppInstr (PUT_CLOSURE   l) = text "PUT_CLOSURE" <+> ppLabel l
ppInstr (PUT_LIT lit    ) = text "PUT_LIT    " <+> ppLit lit
ppInstr (SET           v) = text "SET        " <+> ppIVal v
ppInstr (SET_PAD        ) = text "SET_PAD"
ppInstr (PUSH          v) = text "PUSH       " <+> ppIVal v
ppInstr (EVAL       v ti) = text "EVAL       " <+> ppIVal v <+> ppTailInfo ti
ppInstr (CALL       v ti) = text "CALL       " <+> ppCId v  <+> ppTailInfo ti
ppInstr (FAIL           ) = text "FAIL"
ppInstr (UPDATE         ) = text "UPDATE"
ppInstr (RET           n) = text "RET        " <+> int n

ppIVal (HEAP     n) = text "hp"  <> parens (int n)
ppIVal (ARG_VAR  n) = text "stk" <> parens (int n)
ppIVal (FREE_VAR n) = text "env" <> parens (int n)

ppTailInfo RecCall        = empty
ppTailInfo (TailCall a b) = text "tail" <> parens (int a <> comma <> int b)

ppLabel l = text (let s = show l in replicate (3-length s) '0' ++ s)
