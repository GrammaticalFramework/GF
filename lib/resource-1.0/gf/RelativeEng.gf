concrete RelativeEng of Relative = CatEng ** open ResEng in {

  lin

    RelCl cl = {
      s = \\t,a,p,_ => "such" ++ "that" ++ cl.s ! t ! a ! p ! ODir
      } ;

    RelVP rp vp = {
      s = \\t,ant,b,ag => 
        let 
          agr = case rp.a of {
            RNoAg => ag ;
            RAg a => a
            } ;
          verb  = vp.s ! t ! ant ! b ! ODir ! agr ;
          subj  = rp.s ! Nom ;
          compl = vp.s2 ! agr
        in
        subj ++ verb.fin ++ verb.inf ++ compl
      } ;

    RelSlash rp slash = {
      s = \\t,a,p,_ => slash.c2 ++ rp.s ! Acc ++ slash.s ! t ! a ! p ! ODir
      } ;

    FunRP p np rp = {
      s = \\c => np.s ! c ++ p.s ++ rp.s ! Acc ;
      a = RAg np.a
      } ;

    IdRP = mkIP "which" "which" "whose" Sg ** {a = RNoAg} ;

}
