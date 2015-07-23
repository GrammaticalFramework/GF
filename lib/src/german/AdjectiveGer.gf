concrete AdjectiveGer of Adjective = CatGer ** open ResGer, Prelude in {

  flags optimize=all_subs ;

  lin

    PositA  a = {
      s = a.s ! Posit ;
      isPre = True ;
      c = <[],[]> ;
      ext = []
      } ;
    ComparA a np = {
      s = \\af => a.s ! Compar ! af ++ conjThan ++ np.s ! NPC Nom ++ bigNP np ;
      isPre = True ;
      c = <[],[]> ;
      ext = []
      } ;
    CAdvAP ad ap np = ap ** {
      s = \\af => ad.s ++ ap.s ! af ++ ad.p ++ np.s ! NPC Nom ++ bigNP np ;
      isPre = False 
      } ;
    UseComparA a = {
      s = \\af => a.s ! Compar ! af ;
      isPre = True ;
      c = <[],[]> ;
      ext = []
      } ;

    AdjOrd a = {
      s = a.s ;
      isPre = True ;
      c = <[],[]> ;
      ext = []
      } ; 

-- $SuperlA$ belongs to determiner syntax in $Noun$.

    ComplA2 a np = 
	  let CExt = case a.c2.isPrep of {
			False => <appPrepNP a.c2 np, []> ;
			True => <[], appPrepNP a.c2 np> } 
		in {
      s = a.s ! Posit ;
      isPre = True ;
      c = CExt ;
	  ext = []
      } ;

    ReflA2 a = 
	  let 
		compl = appPrep a.c2 (\\k => usePrepC k (\c -> reflPron ! agrP3 Sg ! c)) ;
		CExt = case a.c2.isPrep of
			{False => <compl, []> ;
			True => <[], compl> }
	  in {
      s = a.s ! Posit ;
      isPre = True ;
      c = CExt ;
	  ext = []
      } ;

    SentAP ap sc = ap ** {
      isPre = False ;
	  ext = ap.ext ++ sc.s
      } ;

    AdAP ada ap = ap ** {s = \\a => ada.s ++ ap.s ! a} ;

    UseA2 a = {
      s = a.s ! Posit ;
      isPre = True ;
      c = <[],[]> ;
      ext = []
      } ;

}
