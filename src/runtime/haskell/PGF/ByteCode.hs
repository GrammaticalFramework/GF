module PGF.ByteCode(Literal(..),
                    CodeLabel, Instr(..), IVal(..), TailInfo(..),
                    ppLit, ppCode, ppInstr
                   ) where
import Prelude hiding ((<>)) -- GHC 8.4.1 clash with Text.PrettyPrint
import PGF.CId
import Text.PrettyPrint

data Literal =
   LStr String                      -- ^ string constant
 | LInt Int                         -- ^ integer constant
 | LFlt Double                      -- ^ floating point constant
 deriving (Eq,Ord,Show)

type CodeLabel = Int

data Instr
  = CHECK_ARGS {-# UNPACK #-} !Int
  | CASE CId  {-# UNPACK #-} !CodeLabel
  | CASE_LIT Literal  {-# UNPACK #-} !CodeLabel
  | SAVE {-# UNPACK #-} !Int
  | ALLOC  {-# UNPACK #-} !Int
  | PUT_CONSTR CId
  | PUT_CLOSURE   {-# UNPACK #-} !CodeLabel
  | PUT_LIT Literal
  | SET IVal
  | SET_PAD
  | PUSH_FRAME
  | PUSH IVal
  | TUCK IVal {-# UNPACK #-} !Int
  | EVAL IVal TailInfo
  | DROP {-# UNPACK #-} !Int
  | JUMP {-# UNPACK #-} !CodeLabel
  | FAIL
  | PUSH_ACCUM Literal
  | POP_ACCUM
  | ADD

data IVal
  = HEAP     {-# UNPACK #-} !Int
  | ARG_VAR  {-# UNPACK #-} !Int
  | FREE_VAR {-# UNPACK #-} !Int
  | GLOBAL   CId
  deriving Eq

data TailInfo
  = RecCall
  | TailCall {-# UNPACK #-} !Int
  | UpdateCall

ppLit (LStr s) = text (show s)
ppLit (LInt n) = int n
ppLit (LFlt d) = double d

ppCode :: Int -> [[Instr]] -> Doc
ppCode l []       = empty
ppCode l (is:iss) = ppLabel l <+> vcat (map ppInstr is) $$ ppCode (l+1) iss

ppInstr (CHECK_ARGS    n) = text "CHECK_ARGS " <+> int n
ppInstr (CASE id l      ) = text "CASE       " <+> ppCId id <+> ppLabel l
ppInstr (CASE_LIT lit l ) = text "CASE_LIT   " <+> ppLit lit <+> ppLabel l
ppInstr (SAVE          n) = text "SAVE       " <+> int n
ppInstr (ALLOC         n) = text "ALLOC      " <+> int n
ppInstr (PUT_CONSTR   id) = text "PUT_CONSTR " <+> ppCId id
ppInstr (PUT_CLOSURE   l) = text "PUT_CLOSURE" <+> ppLabel l
ppInstr (PUT_LIT lit    ) = text "PUT_LIT    " <+> ppLit lit
ppInstr (SET           v) = text "SET        " <+> ppIVal v
ppInstr (SET_PAD        ) = text "SET_PAD"
ppInstr (PUSH_FRAME     ) = text "PUSH_FRAME"
ppInstr (PUSH          v) = text "PUSH       " <+> ppIVal v
ppInstr (EVAL       v ti) = text "EVAL       " <+> ppIVal v <+> ppTailInfo ti
ppInstr (TUCK v n       ) = text "TUCK       " <+> ppIVal v <+> int n
ppInstr (DROP n         ) = text "DROP       " <+> int n
ppInstr (JUMP l         ) = text "JUMP       " <+> ppLabel l
ppInstr (FAIL           ) = text "FAIL"
ppInstr (PUSH_ACCUM  lit) = text "PUSH_ACCUM " <+> ppLit lit
ppInstr (POP_ACCUM      ) = text "POP_ACCUM"
ppInstr (ADD            ) = text "ADD"

ppIVal (HEAP     n) = text "hp"  <> parens (int n)
ppIVal (ARG_VAR  n) = text "stk" <> parens (int n)
ppIVal (FREE_VAR n) = text "env" <> parens (int n)
ppIVal (GLOBAL  id) = ppCId id

ppTailInfo RecCall      = empty
ppTailInfo (TailCall n) = text "tail" <> parens (int n)
ppTailInfo UpdateCall   = text "update"

ppLabel l = text (let s = show l in replicate (3-length s) '0' ++ s)
