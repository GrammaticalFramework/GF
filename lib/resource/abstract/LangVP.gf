--# -path=.:../abstract:../../prelude

-- alternative API that is able to return VP's by parsing with Cl
-- constructors and then computing. AR 14/11/2005
--
-- to import: 'i -noparse=vp.gfnoparse LangVPEng'
-- to use:    'p -cat=Cl "I see her" |  wt -c trCl'

abstract LangVP = 
  Lang,
  Verbphrase,
  ClauseVP ** {
} ;
