abstract ExtraEusAbs = Extra ** {

cat 

    Attr ;  -- morpheme to turn an phrase into an adnominal/attributive
fun

  ko_Attr : Attr ;

   -- AdnP = Adnominal phrase

   AdnP : Adv -> Attr -> AP ; 

--   ProDrop : Pron -> Pron ;

-- or to drop pronouns by default and have explicit pronouns in Extra?
--   ExplicitPron : Clause -> Clause ;

} ;
