--# -path=.:../abstract:../../prelude

resource LogicEng = Logic with 
  (Atom = AtomEng), (Resource = ResourceEng) ;

-- this is the standard form of a derived resource. AR 12/1/2004
