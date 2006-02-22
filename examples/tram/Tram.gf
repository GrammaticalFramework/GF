abstract Tram = PredefAbs ** {

cat
  Dep ;    -- from here, from Angered
  Dest ;   -- to here, to Angered
  Query ;  -- message sent to the dialogue manager: sequentialized
  Input ;  -- user input: parallel text and clicks
  Click ;  -- map clicks

fun
  QInput : Input -> Query ; -- sequentialize user input

fun
  GoFromTo  : Dep  -> Dest -> Input ; -- user input "want to go from a to b"
  GoToFrom  : Dest -> Dep  -> Input ; -- user input "want to go to a from b"
  ComeFrom  : Dep  -> Input ;         -- user input "want to come from x (to where I am now)
  GoTo      : Dest -> Input ;         -- user input "want to go to x (from where I am now)

  DepClick  : Click -> Dep ;          -- "from here" with click
  DestClick : Click -> Dest ;         -- "to here" with click
  DepHere   : Dep ;                   -- "from here" indexical
  DestHere  : Dest ;                  -- "to here" indexical
  DepNamed  : String -> Dep ;         -- from a place name
  DestNamed : String -> Dest ;        -- to a place name

  CCoord    : Int -> Int -> Click ;

--- the syntax of here (prep + adverb, not prep + np) prevent these
--  Place ;  -- any way to identify a place: name, click, or indexical "here"
--  PClick   : Click -> Place ;          -- click associated with a "here"
--  PHere    : Place ;                   -- indexical "here", without a click

--  FromThisPlace : Dep ;               -- "from this place"
--  ToThisPlace   : Dest ;              -- "to this place"

}
