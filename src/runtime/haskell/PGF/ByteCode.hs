module PGF.ByteCode(CodeLabel, Instr(..), ppCode, ppInstr) where

import PGF.CId
import Text.PrettyPrint

type CodeLabel = Int

data Instr
  = EVAL   {-# UNPACK #-} !Int
  | CASE CId     {-# UNPACK #-} !CodeLabel
  | CASE_INT Int    {-# UNPACK #-} !CodeLabel
  | CASE_STR String {-# UNPACK #-} !CodeLabel
  | CASE_FLT Double {-# UNPACK #-} !CodeLabel
  | ALLOC  {-# UNPACK #-} !Int
  | PUT_CONSTR CId
  | PUT_CLOSURE   {-# UNPACK #-} !CodeLabel
  | PUT_INT {-# UNPACK #-} !Int
  | PUT_STR String
  | PUT_FLT {-# UNPACK #-} !Double
  | SET_VALUE {-# UNPACK #-} !Int
  | SET_VARIABLE    {-# UNPACK #-} !Int
  | TAIL_CALL    CId
  | FAIL
  | RET {-# UNPACK #-} !Int

ppCode :: CodeLabel -> [Instr] -> Doc
ppCode l []     = empty
ppCode l (i:is) = ppLabel l <+> ppInstr l i $$ ppCode (l+1) is

ppInstr l (EVAL         n) = text "EVAL        " <+> int n
ppInstr l (CASE id o     ) = text "CASE        " <+> ppCId id <+> ppLabel (l+o+1)
ppInstr l (CASE_INT n o  ) = text "CASE_INT    " <+> int n <+> ppLabel (l+o+1)
ppInstr l (CASE_STR s o  ) = text "CASE_STR    " <+> text (show s) <+> ppLabel (l+o+1)
ppInstr l (CASE_FLT d o  ) = text "CASE_FLT    " <+> double d <+> ppLabel (l+o+1)
ppInstr l (ALLOC        n) = text "ALLOC       " <+> int n
ppInstr l (SET_VALUE    n) = text "SET_VALUE   " <+> int n
ppInstr l (PUT_CONSTR  id) = text "PUT_CONSTR  " <+> ppCId id
ppInstr l (PUT_CLOSURE  c) = text "PUT_CLOSURE " <+> ppLabel c
ppInstr l (PUT_INT n     ) = text "PUT_INT     " <+> int n
ppInstr l (PUT_STR s     ) = text "PUT_STR     " <+> text (show s)
ppInstr l (PUT_FLT d     ) = text "PUT_FLT     " <+> double d
ppInstr l (SET_VARIABLE n) = text "SET_VARIABLE" <+> int n
ppInstr l (TAIL_CALL   id) = text "TAIL_CALL   " <+> ppCId id
ppInstr l (FAIL          ) = text "FAIL"
ppInstr l (RET          n) = text "RET         " <+> int n

ppLabel l = text (let s = show l in replicate (4-length s) '0' ++ s)
