-- predefined functions for concrete syntax, defined in AppPredefined.hs

resource Predef = {

  -- this type is for internal use only
  param PBool = PTrue | PFalse ;

  -- these operations have their definitions in AppPredefined.hs
  oper Int : Type = variants {} ; ----

  oper length : Tok ->        Int  = variants {} ;
  oper drop   : Int -> Tok -> Tok  = variants {} ;
  oper take   : Int -> Tok -> Tok  = variants {} ;
  oper tk     : Int -> Tok -> Tok  = variants {} ;
  oper dp     : Int -> Tok -> Tok  = variants {} ;
  oper eqInt  : Int -> Int -> PBool = variants {} ; 
  oper plus   : Int -> Int -> Int  = variants {} ;

  oper eqStr  : Tok -> Tok -> PBool   = variants {} ; 
  oper eqTok  : (P : Type) -> P -> P -> PBool = variants {} ; 
  oper show   : (P : Type) -> P -> Tok = variants {} ; 
  oper read   : (P : Type) -> Tok -> P = variants {} ; 

  } ;

