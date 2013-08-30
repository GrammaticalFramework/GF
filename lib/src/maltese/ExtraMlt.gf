-- ExtraMlt.gf: extra stuff
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Licensed under LGPL

concrete ExtraMlt of ExtraMltAbs = CatMlt **
  open (R=ResMlt), ParadigmsMlt in {

  flags coding=utf8 ;

  lin
    SlashVa v = (R.predV v) ** { c2 = noCompl } ; -- See Verb.SlashV2a

    -- VasV2 v = v ** { c2 = noCompl } ;

    -- ProDrop : Pron -> Pron
    -- unstressed subject pronoun becomes []: "(jiena) norqod"
    ProDrop p = {
      s = table {
        R.Personal => [] ;
        c => p.s ! c
        } ;
      a = p.a ;
      } ;

}
