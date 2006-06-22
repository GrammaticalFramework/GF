concrete RelativeGer of Relative = CatGer ** open ResGer in {

  flags optimize=all_subs ;

  lin

    RelCl cl = {
      s = \\t,a,b,_ => "derart" ++ conjThat ++ cl.s ! t ! a ! b ! Sub ;
      c = Nom
      } ;

    RelVP rp vp = {
      s = \\t,ant,b,gn => 
        let 
          agr = case rp.a of {
            RNoAg => agrP3 (numGenNum gn) ;
            RAg a => a ** {g = Neutr}
            } ;
          cl = mkClause (rp.s ! gn ! Nom) agr vp
        in
        cl.s ! t ! ant ! b ! Sub ;
      c = Nom
      } ;

    RelSlash rp slash = {
      s = \\t,a,p,gn => 
          appPrep slash.c2 (rp.s ! gn) ++ slash.s ! t ! a ! p ! Sub ;
      c = slash.c2.c
      } ;

    FunRP p np rp = {
      s = \\gn,c => np.s ! c ++ appPrep p (rp.s ! gn) ;
      a = RAg np.a
      } ;

    IdRP = {s = relPron ; a = RNoAg} ;

  oper
      relPron :  GenNum => Case => Str = \\gn,c =>
    case <gn,c> of {
      <GSg Fem,Gen> => "deren" ;
      <GSg g,Gen>   => "dessen" ;
      <GPl,Dat>     => "denen" ;
      <GPl,Gen>     => "deren" ;
      _ => artDef ! gn ! c
      } ;

}
