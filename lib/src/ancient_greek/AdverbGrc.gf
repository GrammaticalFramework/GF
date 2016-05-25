concrete AdverbGrc of Adverb = CatGrc ** open ResGrc, Prelude in {

 lin
    PositAdvAdj a = { s = a.adv ! Posit } ;

    ComparAdvAdj cadv a np = let agr = Ag Neutr Sg P3 -- default, TODO s:Agr => ..
      in {
        s = cadv.s ++ a.adv ! Compar ++ np.s ! Gen  -- TODO: check
      } ;

--    ComparAdvAdjS cadv a s = {
--      s = cadv.s ++ a.s ! AAdv ++ "than" ++ s.s
--      } ;

    PrepNP prep np = { -- prepositions need stressed pronouns,  BR 
        s = appPrep prep np -- default; TODO s:Agr => ..
        } ;

--    AdAdv = cc2 ;

    SubjS = cc2 ;
-----b    AdvSC s = s ; --- this rule give stack overflow in ordinary parsing
--
--    AdnCAdv cadv = {s = cadv.s ++ "than"} ;
--
}
