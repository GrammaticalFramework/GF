module PGF.ByteCode(CodeLabel, Instr(..), ppCode, ppInstr) where

import PGF.CId
import Text.PrettyPrint

type CodeLabel = Int

data Instr
  = ENTER
  | EVAL_ARG_VAR   {-# UNPACK #-} !Int
  | EVAL_FREE_VAR  {-# UNPACK #-} !Int
  | CASE CId     {-# UNPACK #-} !CodeLabel
  | CASE_INT Int    {-# UNPACK #-} !CodeLabel
  | CASE_STR String {-# UNPACK #-} !CodeLabel
  | CASE_FLT Double {-# UNPACK #-} !CodeLabel
  | ALLOC  {-# UNPACK #-} !Int
  | PUT_CONSTR CId
  | PUT_FUN CId
  | PUT_CLOSURE   {-# UNPACK #-} !CodeLabel
  | PUT_INT {-# UNPACK #-} !Int
  | PUT_STR String
  | PUT_FLT {-# UNPACK #-} !Double
  | SET_VALUE      {-# UNPACK #-} !Int
  | SET_ARG_VAR    {-# UNPACK #-} !Int
  | SET_FREE_VAR   {-# UNPACK #-} !Int
  | PUSH_VALUE     {-# UNPACK #-} !Int
  | PUSH_ARG_VAR   {-# UNPACK #-} !Int
  | PUSH_FREE_VAR  {-# UNPACK #-} !Int
  | TAIL_CALL    CId
  | UPDATE
  | FAIL
  | RET {-# UNPACK #-} !Int

ppCode :: Int -> [[Instr]] -> Doc
ppCode l []       = empty
ppCode l (is:iss) = ppLabel l <+> vcat (map ppInstr is) $$ ppCode (l+1) iss

ppInstr (ENTER          ) = text "ENTER"
ppInstr (EVAL_ARG_VAR  n) = text "EVAL_ARG_VAR " <+> int n
ppInstr (EVAL_FREE_VAR n) = text "EVAL_FREE_VAR" <+> int n
ppInstr (CASE id l      ) = text "CASE         " <+> ppCId id <+> ppLabel l
ppInstr (CASE_INT n l   ) = text "CASE_INT     " <+> int n <+> ppLabel l
ppInstr (CASE_STR str l ) = text "CASE_STR     " <+> text (show str) <+> ppLabel l
ppInstr (CASE_FLT d l   ) = text "CASE_FLT     " <+> double d <+> ppLabel l
ppInstr (ALLOC         n) = text "ALLOC        " <+> int n
ppInstr (PUT_CONSTR   id) = text "PUT_CONSTR   " <+> ppCId id
ppInstr (PUT_FUN      id) = text "PUT_FUN      " <+> ppCId id
ppInstr (PUT_CLOSURE   l) = text "PUT_CLOSURE  " <+> ppLabel l
ppInstr (PUT_INT n      ) = text "PUT_INT      " <+> int n
ppInstr (PUT_STR str    ) = text "PUT_STR      " <+> text (show str)
ppInstr (PUT_FLT d      ) = text "PUT_FLT      " <+> double d
ppInstr (SET_VALUE     n) = text "SET_VALUE    " <+> int n
ppInstr (SET_ARG_VAR   n) = text "SET_ARG_VAR  " <+> int n
ppInstr (SET_FREE_VAR  n) = text "SET_FREE_VAR " <+> int n
ppInstr (PUSH_VALUE    n) = text "PUSH_VALUE   " <+> int n
ppInstr (PUSH_ARG_VAR  n) = text "PUSH_ARG_VAR " <+> int n
ppInstr (PUSH_FREE_VAR n) = text "PUSH_FREE_VAR" <+> int n
ppInstr (TAIL_CALL    id) = text "TAIL_CALL    " <+> ppCId id
ppInstr (FAIL           ) = text "FAIL"
ppInstr (RET           n) = text "RET          " <+> int n

ppLabel l = text (let s = show l in replicate (3-length s) '0' ++ s)
