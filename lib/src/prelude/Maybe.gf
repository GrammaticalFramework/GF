{-
  Maybe type, modelled on Haskell
  John J. Camilleri
-}
resource Maybe = open Prelude, Predef in {

  oper

    -- Constructors
    Maybe   : (t : Type) -> Type = \t -> {
      inner : t ;
      exists : Bool ;
      } ;
    Just    : (T : Type) -> T -> Maybe T = \_,t -> {
      inner = t ;
      exists = True ;
      } ;
    Nothing : (T : Type) -> T -> Maybe T = \_,t -> {
      inner = t ;
      exists = False ;
      } ;

    -- IMPORTANT
    -- This version of Nothing would be preferred, but it may not work as expected.
    -- This happens when using Nothing within a record. For discussion of this see:
    -- https://groups.google.com/d/msg/gf-dev/KAQEttN-0Cs/EjGHjOXEKO0J
    Nothing' : (T : Type) -> Maybe T = \_ -> {
      inner = variants {} ;
      exists = False ;
      } ;
    -- You have been warned!

    -- Functions
    exists   : (T : Type) -> Maybe T -> Bool = \_,m -> m.exists ;
    isJust   : (T : Type) -> Maybe T -> Bool = \_,m -> m.exists ;
    fromJust : (T : Type) -> Maybe T -> T = \_,m -> case m.exists of {
      True  => m.inner ;
      False => Predef.error "Called fromJust with Nothing"
      } ;
    fromMaybe : (T : Type) -> T -> Maybe T -> T = \_,n,m -> case m.exists of {
      True  => m.inner ;
      False => n
      } ;

    -- Instance with Str, since it's common
    MaybeS   = Maybe Str ;
    JustS    : Str -> Maybe Str = \r -> Just Str r ;
    -- NothingS : Maybe Str        =       Nothing Str ;
    NothingS : Maybe Str        =       Nothing Str "" ;

    existsS   : Maybe Str -> Bool = exists Str ;
    fromJustS : Maybe Str -> Str  = fromJust Str ;
    fromMaybeS : Str -> Maybe Str -> Str = fromMaybe Str ;

    -- Example
    -- j : MaybeS = JustS "hello" ;
    -- n : MaybeS = NothingS ;
    -- s : Str = fromJustS j;
    -- b : Bool = existsS j ;
    -- r : Str = if_then_Str (existsS j) ("present") ("not present") ;

}
