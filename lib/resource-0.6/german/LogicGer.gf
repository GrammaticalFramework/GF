--# -path=.:../abstract:../../prelude

resource LogicGer = Logic with 
  (Atom = AtomGer), (Resource = ResourceGer) ;

-- this is the standard form of a derived resource. AR 12/1/2004
