concrete RelativeEng of Relative = CatEng ** open ResEng in {

  flags optimize=all_subs ;

  lin

    RelCl cl = {
      s = \\t,a,p,_ => "such" ++ "that" ++ cl.s ! t ! a ! p ! oDir ; 
      c = npNom
      } ;

    RelVP rp vp = {
      s = \\t,ant,b,ag => 
        let 
          agr = case rp.a of {
            RNoAg => ag ;
            RAg a => a
            } ;
          cl = mkClause (rp.s ! RC (fromAgr agr).g npNom) agr vp
        in
        cl.s ! t ! ant ! b ! oDir ;
      c = npNom
      } ;

-- Pied piping: "that we are looking at". Pied piping and empty
-- relative are defined in $ExtraEng.gf$ ("at which we are looking", 
-- "we are looking at").

    RelSlash rp slash = {
      s = \\t,a,p,ag => 
        rp.s ! RC (fromAgr ag).g NPAcc ++ slash.s ! t ! a ! p ! oDir ++ slash.c2 ;
      c = NPAcc
      } ;

    FunRP p np rp = {
      s = \\c => np.s ! NPAcc ++ p.s ++ rp.s ! RPrep (fromAgr np.a).g ;
      a = RAg np.a
      } ;


-- relative pronoun "that" used by default, because it is always correct, even in absence of gender/animateness information

    IdRP =
     { s = table {
        RC _ (NCase Gen) | RC _ NPNomPoss => "whose" ; 
        RC Neutr _  => "that" ;
        RC _ NPAcc    => "that" ;
        RC _ (NCase Nom)    => "that" ;
        RPrep Neutr => "which" ;
        RPrep _     => "who"
        } ;
      a = RNoAg
      } ;

}
