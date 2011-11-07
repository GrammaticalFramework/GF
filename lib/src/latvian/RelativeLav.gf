concrete RelativeLav of Relative = CatLav ** open ResLav, VerbLav in {
flags optimize=all_subs ;

  lin

    RelCl cl = {
      s = \\m,p,_ => "ka" ++ cl.s ! m ! p 
    } ;
	  
    RelVP rp vp = {
      s = \\m,p,ag => rp.s ! Nom ++ buildVerb vp.v m p (toAgr (fromAgr ag).n P3 (fromAgr ag).g) ++ vp.s2 ! ag
    } ;

    RelSlash rp slash = { -- FIXME - vârdu secîba; nevis 'kas mîl viòu' bet 'kas viòu mîl' 
      s = \\m,p,ag => 
          slash.p.s ++ rp.s ! (slash.p.c ! Sg) ++  slash.s ! m ! p ;
    } ;
  {-

-- Pied piping: "at which we are looking". Stranding and empty
-- relative are defined in $ExtraEng.gf$ ("that we are looking at", 
-- "we are looking at").


    FunRP p np rp = {
      s = \\c => np.s ! Acc ++ p.s ++ rp.s ! RPrep (fromAgr np.a).g ;
      a = RAg np.a
      } ;
	-}
	--FIXME placeholder
	FunRP p np rp = { s = \\_ => NON_EXISTENT } ; 
	
	IdRP = {
	  s = table {
		Nom => "kas";
		Gen => "kâ";
		Dat => "kam";
		Acc => "ko";
		Loc => "kur";
		ResLav.Voc => NON_EXISTENT		
	  }
	};
	{-
    IdRP = 
     { s = table {
        RC _ Gen => "whose" ; 
        RC Neutr _  => "which" ;
        RC _ Acc    => "whom" ;
        RC _ Nom    => "who" ;
        RPrep Neutr => "which" ;
        RPrep _     => "whom"
        } ;
      a = RNoAg
    } ; -}
}
