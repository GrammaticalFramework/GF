-- predefined functions for concrete syntax, defined in AppPredefined.hs

resource Predef = {

  -- this type is for internal use only
  param PBool = PTrue | PFalse ;

  -- these operations have their proper definitions in AppPredefined.hs

  oper Int  : Type = variants {} ;                     -- the type of integers
  oper Ints : Int -> Type = variants {} ;              -- the type of integers from 0 to n

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
  oper show   : (P : Type) -> P -> Tok = variants {} ; -- convert param to string
  oper read   : (P : Type) -> Tok -> P = variants {} ; -- convert string to param

  } ;

