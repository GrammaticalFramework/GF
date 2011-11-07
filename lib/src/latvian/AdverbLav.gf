concrete AdverbLav of Adverb = CatLav ** open ResLav, Prelude in {

  lin
  
    PositAdvAdj a = {s = a.s ! (AAdv Posit)} ;
	
    ComparAdvAdj cadv a np = {
      s = cadv.s ++ a.s ! (AAdv cadv.d) ++ cadv.p ++ np.s ! Nom -- TODO vajag arî 'âtrâks par Jâni' un 'âtrâks nekâ Jânis' pie more_CAdv  
	  -- TODO - vai te tieðâm veido 'âtrâk par Jâni', kas ir pareizais adverbs? nevis 'âtrâks par jâni'...
      } ;
    ComparAdvAdjS cadv a s = {
      s = cadv.s ++ a.s ! (AAdv cadv.d) ++ cadv.p ++ s.s
      } ;   

    PrepNP prep np = {s = prep.s ++ np.s ! (prep.c ! (fromAgr np.a).n)} ; --FIXME - postpozîcijas prievârdi

    AdAdv = cc2 ;
    SubjS = cc2 ;

    AdnCAdv cadv = {
	  s = case cadv.d of {
		Posit => cadv.s ++ cadv.p;
		_ => NON_EXISTENT
	  }
	};
}
