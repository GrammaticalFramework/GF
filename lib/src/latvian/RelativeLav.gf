--# -path=.:../abstract:../common:../prelude

concrete RelativeLav of Relative = CatLav ** open
  ResLav,
  VerbLav
  in {

flags
  optimize = all_subs ;
  coding = utf8 ;

lin
  RelCl cl = { s = \\m,p,_ => "ka" ++ cl.s ! m ! p } ;

  RelVP rp vp = {
    s = \\m,p,ag =>
      rp.s ! Masc ! Nom ++ 
      buildVerb vp.v m p (toAgr (fromAgr ag).n P3 (fromAgr ag).g) ++ 
      vp.compl ! ag
  } ;

  -- FIXME: vārdu secība - nevis 'kas mīl viņu' bet 'kas viņu mīl' (?)
  -- FIXME: Masc varētu nebūt labi
  RelSlash rp slash = {
    s = \\m,p,ag => slash.p.s ++ rp.s ! Masc ! (slash.p.c ! Sg) ++  slash.s ! m ! p
  } ;

  -- FIXME: placeholder
  -- TODO: jātestē, kautkas nav labi ar testpiemēru
  FunRP p np rp = {
    s = \\g,c => p.s ++ rp.s ! g ! c ++ np.s ! (p.c ! (fromAgr np.a).n)
  } ;

  IdRP = {
    s = table {
      Masc => table {
        Nom => "kurš" ;
        Gen => "kura" ;
        Dat => "kuram" ;
        Acc => "kuru" ;
        Loc => "kurā" ;
        ResLav.Voc => NON_EXISTENT
      } ;
      Fem => table {
        Nom => "kura" ;
        Gen => "kuras" ;
        Dat => "kurai" ;
        Acc => "kuru" ;
        Loc => "kurā" ;
        ResLav.Voc => NON_EXISTENT
      }
    }
  } ;

}
