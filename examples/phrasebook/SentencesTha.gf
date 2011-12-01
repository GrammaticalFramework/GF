concrete SentencesTha of Sentences = NumeralTha ** SentencesI - [ACitizen, WherePlace, WherePerson] with 
  (Syntax = SyntaxTha),
  (Symbolic = SymbolicTha),
  (Lexicon = LexiconTha) ** open SyntaxTha, (P = ParadigmsTha), (R = ResTha) in {

flags coding=utf8 ;
lin
  ACitizen p n = mkCl p.name (mkVP (mkCN n (P.personN R.khon_s))) ;

  WherePlace place = mkQS (mkQCl where_IAdv (mkCl place.name yuu_V)) ;
  WherePerson person = mkQS (mkQCl where_IAdv (mkCl person.name yuu_V)) ;

oper
  yuu_V : V = R.regV "อยู่" ;

}
