--1 Predefined functions for concrete syntax

-- The definitions of these constants are hard-coded in GF, and defined
-- in [AppPredefined.hs ../src/GF/Grammar/AppPredefined.hs]. Applying
-- them to run-time variables leads to compiler errors that are often
-- only detected at the code generation time.

resource Predef = {

-- This type of booleans is for internal use only.

  param PBool = PTrue | PFalse ;

  oper Error : Type = variants {} ;          -- the empty type
  oper Int   : Type = variants {} ;          -- the type of integers
  oper Ints  : Int -> Type = variants {} ;   -- the type of integers from 0 to n

  oper error  : Str        -> Error    = variants {} ; -- forms error message
  oper length : Tok ->        Int      = variants {} ; -- length of string
  oper drop   : Int -> Tok -> Tok      = variants {} ; -- drop prefix of length
  oper take   : Int -> Tok -> Tok      = variants {} ; -- take prefix of length
  oper tk     : Int -> Tok -> Tok      = variants {} ; -- drop suffix of length
  oper dp     : Int -> Tok -> Tok      = variants {} ; -- take suffix of length
  oper eqInt  : Int -> Int -> PBool    = variants {} ; -- test if equal integers
  oper lessInt: Int -> Int -> PBool    = variants {} ; -- test order of integers
  oper plus   : Int -> Int -> Int      = variants {} ; -- add integers
  oper eqStr  : Tok -> Tok -> PBool    = variants {} ; -- test if equal strings
  oper occur  : Tok -> Tok -> PBool    = variants {} ; -- test if occurs as substring
  oper occurs : Tok -> Tok -> PBool    = variants {} ; -- test if any char occurs
  oper isUpper : Tok       -> PBool    = variants {} ; -- test if all chars are upper-case
  oper toUpper : Tok       -> Tok      = variants {} ; -- map all chars to upper case
  oper toLower : Tok       -> Tok      = variants {} ; -- map all chars to lower case
  oper show   : (P : Type) -> P -> Tok = variants {} ; -- convert param to string
  oper read   : (P : Type) -> Tok -> P = variants {} ; -- convert string to param
  oper toStr  : (L : Type) -> L -> Str = variants {} ; -- find the "first" string
  oper mapStr : (L : Type) -> (Str -> Str) -> L -> L = variants {} ; 
               -- map all strings in a data structure; experimental ---

} ;

