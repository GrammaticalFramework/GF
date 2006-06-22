concrete RelativeEng of Relative = CatEng ** open ResEng in {

  flags optimize=all_subs ;

  lin

    RelCl cl = {
      s = \\t,a,p,_ => "such" ++ "that" ++ cl.s ! t ! a ! p ! ODir ; 
      c = Nom
      } ;

    RelVP rp vp = {
      s = \\t,ant,b,ag => 
        let 
          agr = case rp.a of {
            RNoAg => ag ;
            RAg a => a
            } ;
          cl = mkClause (rp.s ! RC Nom) agr vp
        in
        cl.s ! t ! ant ! b ! ODir ;
      c = Nom
      } ;

-- Pied piping: "at which we are looking". Stranding and empty
-- relative are defined in $ExtraEng.gf$ ("that we are looking at", 
-- "we are looking at").

    RelSlash rp slash = {
      s = \\t,a,p,_ => slash.c2 ++ rp.s ! RPrep ++ slash.s ! t ! a ! p ! ODir ;
      c = Acc
      } ;

    FunRP p np rp = {
      s = \\c => np.s ! Acc ++ p.s ++ rp.s ! RPrep ;
      a = RAg np.a
      } ;

    IdRP = {
      s = table {
        RC Gen => "whose" ; 
        RC _   => "that" ;
        RPrep  => "which"
        } ;
      a = RNoAg
      } ;

}
